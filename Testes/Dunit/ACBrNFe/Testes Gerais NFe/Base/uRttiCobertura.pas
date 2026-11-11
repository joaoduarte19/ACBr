unit uRttiCobertura;

{ Cobertura de propriedades via RTTI.

  TCoberturaRTTI percorre recursivamente TODAS as propriedades graváveis de um
  objeto (inclusive objetos aninhados e listas TObjectList<TObject>, nas quais
  adiciona um item chamando o método "New" quando a lista está vazia):

   - Preencher : atribui um valor distinto e diferente do padrão a cada
                 propriedade (strings com acento, números, datas, enums, boolean)
   - Listar    : gera "caminho=valor" de todas as propriedades simples

  CompararListas aponta, para cada propriedade, se foi PRESERVADA, PERDIDA
  (voltou ao valor padrão) ou ALTERADA, gerando um relatório CSV. }

interface

uses
  SysUtils, Classes, Rtti, TypInfo, Generics.Collections;

type
  { Retorna True para IGNORAR o caminho (ex.: chave, assinatura) }
  TFiltroCaminho = reference to function(const ACaminho: string): Boolean;

  TCoberturaRTTI = class
  private
    FCtx: TRttiContext;
    FSemente: Integer;
    FVisitados: TList<Pointer>;
    FIgnorar: TFiltroCaminho;
    FSoPadrao: Boolean;
    FProfMax: Integer;
    FPreenchidas: Integer;
    FFalhasAtribuicao: TStringList;
    function Ignorado(const ACaminho: string): Boolean;
    function EhPadrao(const V: TValue): Boolean;
    function NovoValor(P: TRttiProperty; const Atual: TValue; out Novo: TValue): Boolean;
    function EhLista(Obj: TObject): Boolean;
    function AdicionarItem(Lista: TObject): Boolean;
    procedure PreencherObj(Obj: TObject; const Caminho: string; Prof: Integer);
    procedure ListarObj(Obj: TObject; const Caminho: string; Prof: Integer; L: TStrings);
    function ValorTexto(const V: TValue): string;
    function TextoParaNome(const ANome: string): string;
  public
    { ASoPadrao = True: só preenche propriedades que ainda estão no valor padrão }
    constructor Create(AIgnorar: TFiltroCaminho; ASoPadrao: Boolean; AProfMax: Integer = 14);
    destructor Destroy; override;
    procedure Preencher(Obj: TObject; const ARaiz: string);
    function Listar(Obj: TObject; const ARaiz: string): TStringList;
    property Preenchidas: Integer read FPreenchidas;
    property FalhasAtribuicao: TStringList read FFalhasAtribuicao;
  end;

  TResultadoComparacao = record
    Total, Preservadas, Perdidas, Alteradas: Integer;
  end;

{ Compara as listas "caminho=valor". ARelatorio recebe linhas CSV
  (status;caminho;esperado;obtido). AResumoFalhas recebe as divergências. }
function CompararListas(AEsperado, AObtido: TStrings; ARelatorio, AResumoFalhas: TStrings): TResultadoComparacao;

implementation

uses
  DateUtils;

{ TCoberturaRTTI }

constructor TCoberturaRTTI.Create(AIgnorar: TFiltroCaminho; ASoPadrao: Boolean; AProfMax: Integer);
begin
  inherited Create;
  FCtx := TRttiContext.Create;
  FVisitados := TList<Pointer>.Create;
  FFalhasAtribuicao := TStringList.Create;
  FIgnorar := AIgnorar;
  FSoPadrao := ASoPadrao;
  FProfMax := AProfMax;
  FSemente := 10;
end;

destructor TCoberturaRTTI.Destroy;
begin
  FFalhasAtribuicao.Free;
  FVisitados.Free;
  FCtx.Free;
  inherited;
end;

function TCoberturaRTTI.Ignorado(const ACaminho: string): Boolean;
const
  // propriedades internas de TComponent/TPersistent (não são configuração)
  INTERNAS: array[0..11] of string = ('.Owner', '.Name', '.Tag', '.ComObject', '.VCLComObject',
    '.DesignInfo', '.ComponentIndex', '.ComponentCount', '.ComponentState', '.Observers',
    '.Capacity', '.OwnsObjects');
var
  S: string;
begin
  for S in INTERNAS do
    if (Length(ACaminho) >= Length(S)) and
       (Copy(ACaminho, Length(ACaminho) - Length(S) + 1, MaxInt) = S) then
      Exit(True);
  Result := Assigned(FIgnorar) and FIgnorar(ACaminho);
end;

function TCoberturaRTTI.EhLista(Obj: TObject): Boolean;
begin
  Result := Obj is TObjectList<TObject>;
end;

function TCoberturaRTTI.AdicionarItem(Lista: TObject): Boolean;
var
  T: TRttiType;
  M: TRttiMethod;
begin
  Result := False;
  T := FCtx.GetType(Lista.ClassType);
  for M in T.GetMethods('New') do
    if Length(M.GetParameters) = 0 then
    begin
      try
        M.Invoke(Lista, []);
        Result := True;
      except
        Result := False;
      end;
      Exit;
    end;
end;

function TCoberturaRTTI.EhPadrao(const V: TValue): Boolean;
begin
  case V.Kind of
    tkUString, tkString, tkLString, tkWString:
      Result := V.AsString = '';
    tkInteger, tkInt64:
      Result := V.AsOrdinal = 0;
    tkEnumeration:
      Result := V.AsOrdinal = 0;
    tkFloat:
      Result := V.AsExtended = 0;
  else
    Result := False;
  end;
end;

function TCoberturaRTTI.TextoParaNome(const ANome: string): string;
var
  N: string;
begin
  { Campos numéricos/identificadores recebem dígitos (CNPJ/CPF válidos);
    os demais recebem texto livre com acentos }
  N := LowerCase(ANome);
  if (N = 'cnpj') or (N = 'cnpjcpf') or (Pos('cnpj', N) = 1) or (Copy(N, Length(N) - 3, 4) = 'cnpj') then
    Result := '11222333000181'
  else if (N = 'cpf') or (Copy(N, Length(N) - 2, 3) = 'cpf') then
    Result := '12345678909'
  else if (N = 'ncm') then Result := '61051000'
  else if (N = 'cfop') then Result := '5102'
  else if (N = 'cest') then Result := '0100100'
  else if (Pos('cean', N) = 1) or (N = 'cbarra') or (N = 'cbarratrib') then Result := 'SEM GTIN'
  else if (Pos('fone', N) > 0) then Result := '1532599' + Format('%.3d', [FSemente mod 1000])
  else if (N = 'chave') or (N = 'chnfe') or (Pos('ref', N) = 1) or (Pos('chave', N) > 0) then
    Result := '35261118760540000139550010000000011000000016'
  else if (N = 'uf') or (Copy(N, Length(N) - 1, 2) = 'uf') then Result := 'MG'
  else
    Result := 'V' + IntToStr(FSemente) + ' ação ç';
end;

function TCoberturaRTTI.NovoValor(P: TRttiProperty; const Atual: TValue; out Novo: TValue): Boolean;
var
  T: TRttiType;
  Ord, Min, Max: Int64;
  Nome: string;
  S: string;
begin
  Result := True;
  Inc(FSemente);
  T := P.PropertyType;
  case T.TypeKind of
    tkUString, tkWString:
      Novo := TValue.From<string>(TextoParaNome(P.Name));
    tkLString:
      begin
        S := TextoParaNome(P.Name);
        Novo := TValue.From<AnsiString>(AnsiString(S));
      end;
    tkString:
      Novo := TValue.From<ShortString>(ShortString('V' + IntToStr(FSemente)));
    tkInteger:
      begin
        Min := TRttiOrdinalType(T).MinValue;
        Max := TRttiOrdinalType(T).MaxValue;
        if TRttiOrdinalType(T).OrdType = otULong then
        begin
          // Cardinal/LongWord: o RTTI informa MaxValue como Integer com sinal (-1)
          Min := 0;
          Max := High(Cardinal);
        end;
        Ord := (FSemente mod 89) + 2;
        if Ord > Max then Ord := Max;
        if Ord < Min then Ord := Min;
        if Ord = Atual.AsOrdinal then
          if Ord < Max then Inc(Ord) else Dec(Ord);
        Novo := TValue.FromOrdinal(T.Handle, Ord);
      end;
    tkInt64:
      Novo := TValue.From<Int64>(FSemente + 1000);
    tkEnumeration:
      begin
        if T.Handle = TypeInfo(Boolean) then
          Novo := TValue.From<Boolean>(not Atual.AsBoolean)
        else
        begin
          Min := TRttiEnumerationType(T).MinValue;
          Max := TRttiEnumerationType(T).MaxValue;
          if Max <= Min then Exit(False);
          Ord := Atual.AsOrdinal + 1 + (FSemente mod 3);
          Ord := Min + ((Ord - Min) mod (Max - Min + 1));
          if Ord = Atual.AsOrdinal then
            Ord := Min + ((Ord - Min + 1) mod (Max - Min + 1));
          Novo := TValue.FromOrdinal(T.Handle, Ord);
        end;
      end;
    tkFloat:
      begin
        Nome := LowerCase(T.Name);
        if (Nome = 'tdatetime') or (Nome = 'tdate') then
          Novo := TValue.From<TDateTime>(EncodeDate(2026, 11, 10) + (FSemente mod 20))
        else if Nome = 'ttime' then
          Novo := TValue.From<TDateTime>(EncodeTime(10, FSemente mod 60, 0, 0))
        else if Nome = 'currency' then
          Novo := TValue.From<Currency>(FSemente + 0.25)
        else if Nome = 'single' then
          Novo := TValue.From<Single>(FSemente + 0.25)
        else
          Novo := TValue.From<Double>(FSemente + 0.25);
      end;
  else
    Result := False;
  end;
end;

procedure TCoberturaRTTI.PreencherObj(Obj: TObject; const Caminho: string; Prof: Integer);
var
  T: TRttiType;
  P: TRttiProperty;
  V, Novo: TValue;
  Filho: TObject;
  Cam: string;
  i: Integer;
  Lista: TObjectList<TObject>;
begin
  if (Obj = nil) or (Prof > FProfMax) or FVisitados.Contains(Obj) or (Obj is TStrings) then
    Exit;    // TStrings: estado interno de lista, não é dado
  FVisitados.Add(Obj);

  if EhLista(Obj) then
  begin
    Lista := TObjectList<TObject>(Obj);
    if Lista.Count = 0 then
      AdicionarItem(Obj);
    for i := 0 to Lista.Count - 1 do
      PreencherObj(Lista[i], Caminho + '[' + IntToStr(i) + ']', Prof + 1);
    Exit;
  end;

  T := FCtx.GetType(Obj.ClassType);
  for P in T.GetProperties do
  begin
    if P.Visibility in [mvPrivate, mvProtected] then Continue;
    if not P.IsReadable then Continue;
    Cam := Caminho + '.' + P.Name;
    if Ignorado(Cam) then Continue;
    try
      V := P.GetValue(Obj);
    except
      Continue;
    end;

    if P.PropertyType.TypeKind = tkClass then
    begin
      Filho := V.AsObject;
      PreencherObj(Filho, Cam, Prof + 1);
      Continue;
    end;

    if not P.IsWritable then Continue;
    if FSoPadrao and not EhPadrao(V) then Continue;
    if not NovoValor(P, V, Novo) then Continue;
    try
      P.SetValue(Obj, Novo);
      Inc(FPreenchidas);
    except
      on E: Exception do
        FFalhasAtribuicao.Add(Cam + ': ' + E.Message);
    end;
  end;
end;

procedure TCoberturaRTTI.Preencher(Obj: TObject; const ARaiz: string);
begin
  FVisitados.Clear;
  PreencherObj(Obj, ARaiz, 0);
end;

function TCoberturaRTTI.ValorTexto(const V: TValue): string;
var
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Invariant;
  case V.Kind of
    tkFloat:
      if (V.TypeInfo = TypeInfo(TDateTime)) or (V.TypeInfo = TypeInfo(TDate)) or (V.TypeInfo = TypeInfo(TTime)) then
      begin
        if V.AsExtended = 0 then
          Result := ''
        else
          Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', V.AsExtended);
      end
      else
        Result := FormatFloat('0.########', V.AsExtended, FS);
    tkEnumeration:
      Result := GetEnumName(V.TypeInfo, V.AsOrdinal);
  else
    Result := V.ToString;
  end;
end;

procedure TCoberturaRTTI.ListarObj(Obj: TObject; const Caminho: string; Prof: Integer; L: TStrings);
var
  T: TRttiType;
  P: TRttiProperty;
  V: TValue;
  Cam: string;
  i: Integer;
  Lista: TObjectList<TObject>;
begin
  if (Obj = nil) or (Prof > FProfMax) or FVisitados.Contains(Obj) or (Obj is TStrings) then
    Exit;    // TStrings: estado interno de lista, não é dado
  FVisitados.Add(Obj);

  if EhLista(Obj) then
  begin
    Lista := TObjectList<TObject>(Obj);
    for i := 0 to Lista.Count - 1 do
      ListarObj(Lista[i], Caminho + '[' + IntToStr(i) + ']', Prof + 1, L);
    Exit;
  end;

  T := FCtx.GetType(Obj.ClassType);
  for P in T.GetProperties do
  begin
    if P.Visibility in [mvPrivate, mvProtected] then Continue;
    if not P.IsReadable then Continue;
    Cam := Caminho + '.' + P.Name;
    if Ignorado(Cam) then Continue;
    try
      V := P.GetValue(Obj);
    except
      Continue;
    end;
    if P.PropertyType.TypeKind = tkClass then
      ListarObj(V.AsObject, Cam, Prof + 1, L)
    else if P.IsWritable and (P.PropertyType.TypeKind in
      [tkUString, tkWString, tkLString, tkString, tkInteger, tkInt64, tkEnumeration, tkFloat]) then
      L.Add(Cam + '=' + ValorTexto(V));
  end;
end;

function TCoberturaRTTI.Listar(Obj: TObject; const ARaiz: string): TStringList;
begin
  Result := TStringList.Create;
  FVisitados.Clear;
  ListarObj(Obj, ARaiz, 0, Result);
end;

function CompararListas(AEsperado, AObtido: TStrings; ARelatorio, AResumoFalhas: TStrings): TResultadoComparacao;
var
  i: Integer;
  Nome, E, O, Status: string;
  Obt: TStringList;
begin
  FillChar(Result, SizeOf(Result), 0);
  Obt := TStringList.Create;
  try
    Obt.Assign(AObtido);
    Obt.Sorted := True;
    ARelatorio.Add('status;propriedade;esperado;obtido');
    for i := 0 to AEsperado.Count - 1 do
    begin
      Nome := AEsperado.Names[i];
      E := AEsperado.ValueFromIndex[i];
      if Obt.IndexOfName(Nome) >= 0 then
        O := Obt.Values[Nome]
      else
        O := '<ausente>';
      Inc(Result.Total);
      if E = O then
      begin
        Status := 'PRESERVADA';
        Inc(Result.Preservadas);
      end
      else if (O = '') or (O = '0') or (O = '<ausente>') or (O = 'False') then
      begin
        Status := 'PERDIDA';
        Inc(Result.Perdidas);
      end
      else
      begin
        Status := 'ALTERADA';
        Inc(Result.Alteradas);
      end;
      ARelatorio.Add(Status + ';' + Nome + ';' + E + ';' + O);
      if Status <> 'PRESERVADA' then
        AResumoFalhas.Add(Format('%-9s %s: esperado "%s" obtido "%s"', [Status, Nome, E, O]));
    end;
  finally
    Obt.Free;
  end;
end;

end.
