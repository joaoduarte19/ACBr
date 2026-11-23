{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDeREEventos;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrDeRE.Classes,
  ACBrDeRE.D1001.Classes,
  ACBrDeRE.D1011.Classes,
  ACBrDeRE.D1101.Classes,
  ACBrDeRE.D1106.Classes,
  ACBrDeRE.D1121.Classes,
  ACBrDeRE.D1198.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.D2201.Classes,
  ACBrDeRE.D2202.Classes,
  ACBrDeRE.D2211.Classes,
  ACBrDeRE.D2221.Classes,
  ACBrDeRE.D2231.Classes,
  ACBrDeRE.D2241.Classes,
  ACBrDeRE.D2242.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.D2252.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.D4201.Classes,
  ACBrDeRE.Conversao;

type
  TEventos = class;
  TGeradosCollection = class;
  TGeradosCollectionItem = class;
  TDeRECollection = class;

  { TGeradosCollectionItem }

  TGeradosCollectionItem = class(TObject)
  private
    FTipoEvento: TTipoEventoDeRE;
    FPathNome: string;
    FXML: string;
    FIdEvento: string;
  public
    property TipoEvento: TTipoEventoDeRE read FTipoEvento write FTipoEvento;
    property IdEvento: string read FIdEvento write FIdEvento;
    property PathNome: string read FPathNome write FPathNome;
    property XML: string read FXML write FXML;
  end;

  { TGeradosCollection }

  TGeradosCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TGeradosCollectionItem;
    procedure SetItem(Index: Integer; Value: TGeradosCollectionItem);
  public
    function New: TGeradosCollectionItem;
    property Items[Index: Integer]: TGeradosCollectionItem read GetItem write SetItem; default;
  end;

  { TDeRECollection - lista unica de todos os eventos (TDeRE), na ordem de insercao }

  TDeRECollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TDeRE;
    procedure SetItem(Index: Integer; Value: TDeRE);
  public
    // Cria o TDeRE do tipo de evento informado e o adiciona na lista
    function New(ATipo: TTipoEventoDeRE): TDeRE;
    property Items[Index: Integer]: TDeRE read GetItem write SetItem; default;
  end;

  { TEventos }

  TEventos = class(TComponent)
  private
    FLista: TDeRECollection;
    FGerados: TGeradosCollection;

    function GetCount: Integer;
    function GetItem(Index: Integer): TDeRE;
    procedure SetGerados(const Value: TGeradosCollection);

    function GerarIniEvento(AIndex: Integer): string;
    function LerConteudoArquivo(const ACaminho: string): string;
    function EhXml(const AConteudo: string): Boolean;
    function CarregarConteudo(const AConteudo: string): Boolean;
    function CarregarXmlEvento(const AXml: string): Boolean;
    function CarregarIniEvento(const AIni: string): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Gerar;
    procedure Assinar;
    procedure Validar;
    procedure GerarXMLs;
    procedure SaveToFiles;
    // Gera o INI de um unico evento da lista, a partir das propriedades carregadas no componente.
    // Mesmo formato do primeiro evento de um INI com varios eventos (sequencia do evento 001)
    function GerarIni(AIndex: Integer): string; overload;
    // Gera um unico INI com todos os eventos carregados (de tipos diferentes), cada um
    // com as secoes NomeDaSecao + sequencia do evento (+ sequencias dos itens). Eventos sem gerador de INI sao ignorados.
    function GerarIni: string; overload;
    // Grava o INI com todos os eventos em um arquivo. Retorna a quantidade de eventos gravados.
    function SaveToIniFile(const AArquivo: string): Integer;
    // Grava um arquivo INI por evento carregado em ADiretorio.
    // Retorna a lista dos arquivos gravados (o chamador libera a lista).
    function SaveToIni(const ADiretorio: string): TStringList;
    procedure Clear;

    // Adiciona um novo evento do tipo informado
    function New(ATipo: TTipoEventoDeRE): TDeRE;
    // Atalhos tipados, um por evento
    function NewD1001: TDeRED1001;
    function NewD1011: TDeRED1011;
    function NewD1101: TDeRED1101;
    function NewD1106: TDeRED1106;
    function NewD1121: TDeRED1121;
    function NewD1198: TDeRED1198;
    function NewD1199: TDeRED1199;
    function NewD2101: TDeRED2101;
    function NewD2102: TDeRED2102;
    function NewD2201: TDeRED2201;
    function NewD2202: TDeRED2202;
    function NewD2211: TDeRED2211;
    function NewD2221: TDeRED2221;
    function NewD2231: TDeRED2231;
    function NewD2241: TDeRED2241;
    function NewD2242: TDeRED2242;
    function NewD2251: TDeRED2251;
    function NewD2252: TDeRED2252;
    function NewD3201: TDeRED3201;
    function NewD4201: TDeRED4201;

    // Todos os metodos de carga aceitam XML ou INI com um ou varios eventos, inclusive de
    // tipos diferentes: o formato e o tipo de cada evento sao identificados pelo conteudo.
    function LoadFromFile(const CaminhoArquivo: string): Boolean;
    function LoadFromStream(AStream: TStringStream): Boolean;
    function LoadFromString(const AString: string): Boolean;
    function LoadFromStringXML(const AXMLString: string): Boolean;
    function LoadFromStringINI(const AINIString: string): Boolean;
    // Aceita o nome de um arquivo INI ou o proprio conteudo do INI
    function LoadFromIni(const AIniString: string): Boolean;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDeRE read GetItem; default;
    property Gerados: TGeradosCollection read FGerados write SetGerados;
  end;

implementation

uses
  StrUtils, IniFiles, synautil,
  ACBrDFeSSL,
  ACBrDFeException,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrXmlBase,
  ACBrDeRE,
  ACBrDeRE.Consts,
  ACBrDeRE.XmlWriter,
  ACBrDeRE.IniWriter,
  ACBrDeRE.D1001.IniWriter,
  ACBrDeRE.IniReader,
  ACBrDeRE.D1001.IniReader,
  ACBrDeRE.XmlReader,
  ACBrDeRE.D1001.XmlReader,
  ACBrDeRE.D1199.IniWriter,
  ACBrDeRE.D1199.IniReader,
  ACBrDeRE.D1199.XmlReader,
  ACBrDeRE.D2101.IniWriter,
  ACBrDeRE.D2101.IniReader,
  ACBrDeRE.D2101.XmlReader,
  ACBrDeRE.D2102.IniWriter,
  ACBrDeRE.D2102.IniReader,
  ACBrDeRE.D2102.XmlReader,
  ACBrDeRE.D2201.IniWriter,
  ACBrDeRE.D2201.IniReader,
  ACBrDeRE.D2201.XmlReader,
  ACBrDeRE.D2202.IniWriter,
  ACBrDeRE.D2202.IniReader,
  ACBrDeRE.D2202.XmlReader,
  ACBrDeRE.D2211.IniWriter,
  ACBrDeRE.D2211.IniReader,
  ACBrDeRE.D2211.XmlReader,
  ACBrDeRE.D2221.IniWriter,
  ACBrDeRE.D2221.IniReader,
  ACBrDeRE.D2221.XmlReader,
  ACBrDeRE.D2231.IniWriter,
  ACBrDeRE.D2231.IniReader,
  ACBrDeRE.D2231.XmlReader,
  ACBrDeRE.D2241.IniWriter,
  ACBrDeRE.D2241.IniReader,
  ACBrDeRE.D2241.XmlReader,
  ACBrDeRE.D2242.IniWriter,
  ACBrDeRE.D2242.IniReader,
  ACBrDeRE.D2242.XmlReader,
  ACBrDeRE.D2251.IniWriter,
  ACBrDeRE.D2251.IniReader,
  ACBrDeRE.D2251.XmlReader,
  ACBrDeRE.D2252.IniWriter,
  ACBrDeRE.D2252.IniReader,
  ACBrDeRE.D2252.XmlReader,
  ACBrDeRE.D3201.IniWriter,
  ACBrDeRE.D3201.IniReader,
  ACBrDeRE.D3201.XmlReader,
  ACBrDeRE.D4201.IniWriter,
  ACBrDeRE.D4201.IniReader,
  ACBrDeRE.D4201.XmlReader,
  ACBrDeRE.D1198.IniWriter,
  ACBrDeRE.D1198.IniReader,
  ACBrDeRE.D1198.XmlReader,
  ACBrDeRE.D1011.IniWriter,
  ACBrDeRE.D1011.IniReader,
  ACBrDeRE.D1011.XmlReader,
  ACBrDeRE.D1101.IniWriter,
  ACBrDeRE.D1101.IniReader,
  ACBrDeRE.D1101.XmlReader,
  ACBrDeRE.D1106.IniWriter,
  ACBrDeRE.D1106.IniReader,
  ACBrDeRE.D1106.XmlReader,
  ACBrDeRE.D1121.IniWriter,
  ACBrDeRE.D1121.IniReader,
  ACBrDeRE.D1121.XmlReader,
  ACBrDeRE.D1001.XmlWriter,
  ACBrDeRE.D1011.XmlWriter,
  ACBrDeRE.D1101.XmlWriter,
  ACBrDeRE.D1106.XmlWriter,
  ACBrDeRE.D1198.XmlWriter,
  ACBrDeRE.D1199.XmlWriter,
  ACBrDeRE.D2101.XmlWriter,
  ACBrDeRE.D2102.XmlWriter,
  ACBrDeRE.D2201.XmlWriter,
  ACBrDeRE.D2202.XmlWriter,
  ACBrDeRE.D2211.XmlWriter,
  ACBrDeRE.D2221.XmlWriter,
  ACBrDeRE.D2231.XmlWriter,
  ACBrDeRE.D2241.XmlWriter,
  ACBrDeRE.D2242.XmlWriter,
  ACBrDeRE.D2251.XmlWriter,
  ACBrDeRE.D2252.XmlWriter,
  ACBrDeRE.D3201.XmlWriter,
  ACBrDeRE.D4201.XmlWriter,
  ACBrDeRE.D1121.XmlWriter;

{ TGeradosCollection }

function TGeradosCollection.GetItem(Index: Integer): TGeradosCollectionItem;
begin
  Result := TGeradosCollectionItem(inherited Items[Index]);
end;

procedure TGeradosCollection.SetItem(Index: Integer; Value: TGeradosCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TGeradosCollection.New: TGeradosCollectionItem;
begin
  Result := TGeradosCollectionItem.Create;
  Add(Result);
end;

{ TDeRECollection }

function TDeRECollection.GetItem(Index: Integer): TDeRE;
begin
  Result := TDeRE(inherited Items[Index]);
end;

procedure TDeRECollection.SetItem(Index: Integer; Value: TDeRE);
begin
  inherited Items[Index] := Value;
end;

function TDeRECollection.New(ATipo: TTipoEventoDeRE): TDeRE;
begin
  Result := CriarDeRE(ATipo);
  Add(Result);
end;

{ TEventos }

constructor TEventos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLista := TDeRECollection.Create;
  FGerados := TGeradosCollection.Create;
end;

destructor TEventos.Destroy;
begin
  FLista.Free;
  FGerados.Free;

  inherited Destroy;
end;

procedure TEventos.Clear;
begin
  FLista.Clear;
  FGerados.Clear;
end;

function TEventos.GetCount: Integer;
begin
  Result := FLista.Count;
end;

function TEventos.GetItem(Index: Integer): TDeRE;
begin
  Result := FLista[Index];
end;

procedure TEventos.SetGerados(const Value: TGeradosCollection);
begin
  FGerados := Value;
end;

function TEventos.New(ATipo: TTipoEventoDeRE): TDeRE;
begin
  Result := FLista.New(ATipo);
end;

function TEventos.NewD1001: TDeRED1001;
begin
  Result := TDeRED1001(FLista.New(teInfoContrib));
end;

function TEventos.NewD1011: TDeRED1011;
begin
  Result := TDeRED1011(FLista.New(tePGCC));
end;

function TEventos.NewD1101: TDeRED1101;
begin
  Result := TDeRED1101(FLista.New(teBalancete));
end;

function TEventos.NewD1106: TDeRED1106;
begin
  Result := TDeRED1106(FLista.New(teAplicResTec));
end;

function TEventos.NewD1121: TDeRED1121;
begin
  Result := TDeRED1121(FLista.New(teRelDeducoes));
end;

function TEventos.NewD1198: TDeRED1198;
begin
  Result := TDeRED1198(FLista.New(teReabertMensal));
end;

function TEventos.NewD1199: TDeRED1199;
begin
  Result := TDeRED1199(FLista.New(teFechMensal));
end;

function TEventos.NewD2101: TDeRED2101;
begin
  Result := TDeRED2101(FLista.New(teDebOpOfPublic));
end;

function TEventos.NewD2102: TDeRED2102;
begin
  Result := TDeRED2102(FLista.New(teInfoCotistas));
end;

function TEventos.NewD2201: TDeRED2201;
begin
  Result := TDeRED2201(FLista.New(teServRemPreco));
end;

function TEventos.NewD2202: TDeRED2202;
begin
  Result := TDeRED2202(FLista.New(teServRemTarifa));
end;

function TEventos.NewD2211: TDeRED2211;
begin
  Result := TDeRED2211(FLista.New(teOperFinanc));
end;

function TEventos.NewD2221: TDeRED2221;
begin
  Result := TDeRED2221(FLista.New(teAntecReceb));
end;

function TEventos.NewD2231: TDeRED2231;
begin
  Result := TDeRED2231(FLista.New(teArrendMerc));
end;

function TEventos.NewD2241: TDeRED2241;
begin
  Result := TDeRED2241(FLista.New(teArranjoCredDest));
end;

function TEventos.NewD2242: TDeRED2242;
begin
  Result := TDeRED2242(FLista.New(teArranjoPartic));
end;

function TEventos.NewD2251: TDeRED2251;
begin
  Result := TDeRED2251(FLista.New(teSegPrevCap));
end;

function TEventos.NewD2252: TDeRED2252;
begin
  Result := TDeRED2252(FLista.New(teSegElemSCob));
end;

function TEventos.NewD3201: TDeRED3201;
begin
  Result := TDeRED3201(FLista.New(tePlAssistSaude));
end;

function TEventos.NewD4201: TDeRED4201;
begin
  Result := TDeRED4201(FLista.New(teIdApostPrem));
end;

procedure TEventos.Gerar;
var
  i: Integer;
  LDeRE: TDeRE;
  LWriter: TDeREXmlWriter;
begin
  for i := 0 to FLista.Count - 1 do
  begin
    LDeRE := FLista[i];

    LWriter := CriarWriterDeRE(LDeRE);
    try
      LWriter.VersaoDF := TACBrDeRE(Owner).Configuracoes.Geral.VersaoDF;
      LWriter.GerarXml;
      // Converte de ANSI (string nativa) para UTF-8 antes de assinar,
      LDeRE.Evento.XML := ConverteANSItoUTF8(LWriter.Document.Xml);
    finally
      LWriter.Free;
    end;
  end;
end;

procedure TEventos.Assinar;
var
  i: Integer;
  LDeRE: TDeRE;
begin
  for i := 0 to FLista.Count - 1 do
  begin
    LDeRE := FLista[i];

    // A assinatura (e a checagem das libs SHA256) fica na classe do evento
    LDeRE.Evento.Assinar(TACBrDeRE(Owner), LDeRE.Evento.XML);
  end;
end;

procedure TEventos.Validar;
var
  i: Integer;
  LDeRE: TDeRE;
  LArqSchema, LMsgErro: string;
begin
  for i := 0 to FLista.Count - 1 do
  begin
    LDeRE := FLista[i];

    LArqSchema := TACBrDeRE(Owner).GerarNomeArqSchema(LDeRE.Evento.Schema);

    if not TACBrDeRE(Owner).SSL.Validar(LDeRE.Evento.XML, LArqSchema, LMsgErro) then
      raise EACBrDFeException.CreateFmt(
        'Falha na validacao do evento %s:'#13#10'%s',
        [SchemaDeREToStr(LDeRE.Evento.Schema), LMsgErro]);
  end;
end;

procedure TEventos.GerarXMLs;
begin
  Gerar;
  Assinar;
  Validar;
end;

procedure TEventos.SaveToFiles;
var
  i: Integer;
  LDeRE: TDeRE;
  LItem: TGeradosCollectionItem;
  LNomeArq, LPath: string;
begin
  FGerados.Clear;

  LPath := TACBrDeRE(Owner).Configuracoes.Arquivos.GetPathDeRE;

  for i := 0 to FLista.Count - 1 do
  begin
    LDeRE := FLista[i];
    LNomeArq := LDeRE.Evento.id + '-dere.xml';

    if TACBrDeRE(Owner).Configuracoes.Geral.Salvar then
      TACBrDeRE(Owner).Gravar(LNomeArq, LDeRE.Evento.XML, LPath);

    LItem := FGerados.New;
    LItem.TipoEvento := LDeRE.Evento.TipoEvento;
    LItem.IdEvento := LDeRE.Evento.id;
    LItem.PathNome := LPath + LNomeArq;
    LItem.XML := LDeRE.Evento.XML;
  end;
end;

function TEventos.GerarIniEvento(AIndex: Integer): string;
var
  LWriter: TDeREIniWriter;
begin
  LWriter := CriarIniWriterDeRE(FLista[AIndex]);
  try
    LWriter.VersaoDF := TACBrDeRE(Owner).Configuracoes.Geral.VersaoDF;
    Result := LWriter.GravarIni;
  finally
    LWriter.Free;
  end;
end;

function TEventos.GerarIni(AIndex: Integer): string;
var
  LIni: TMemIniFile;
  LLista: TStringList;
begin
  // Igual ao primeiro evento de um INI com varios eventos: secoes com a sequencia 001
  LIni := TMemIniFile.Create('');
  LLista := TStringList.Create;
  try
    AdicionarIniEventoDeRE(LIni, GerarIniEvento(AIndex), 1);
    LIni.GetStrings(LLista);
    Result := LLista.Text;
  finally
    LLista.Free;
    LIni.Free;
  end;
end;

function TEventos.SaveToIni(const ADiretorio: string): TStringList;
var
  i: Integer;
  LDeRE: TDeRE;
  LIni: TStringList;
  LNomeArq, LPath: string;
begin
  Result := TStringList.Create;
  try
    LPath := ADiretorio;
    if LPath <> '' then
      LPath := IncludeTrailingPathDelimiter(LPath);

    if (LPath <> '') and (not DirectoryExists(LPath)) then
      ForceDirectories(LPath);

    for i := 0 to FLista.Count - 1 do
    begin
      LDeRE := FLista[i];

      // Eventos que ainda nao possuem gerador de INI sao ignorados
      if not ExisteIniWriterDeRE(LDeRE.Evento.TipoEvento) then
        Continue;

      LIni := TStringList.Create;
      try
        LIni.Text := GerarIni(i);

        // O id do evento so existe depois de Gerar; antes disso usa tipo + sequencia
        LNomeArq := LDeRE.Evento.id;
        if LNomeArq = '' then
          LNomeArq := SchemaDeREToStr(LDeRE.Evento.Schema) + '-' + IntToStr(i + 1);

        LNomeArq := LPath + LNomeArq + '-dere.ini';
        LIni.SaveToFile(LNomeArq);
        Result.Add(LNomeArq);
      finally
        LIni.Free;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TEventos.GerarIni: string;
var
  LLote: TMemIniFile;
  LLista: TStringList;
  i: Integer;
begin
  LLote := TMemIniFile.Create('');
  LLista := TStringList.Create;
  try
    for i := 0 to FLista.Count - 1 do
    begin
      // Eventos que ainda nao possuem gerador de INI sao ignorados
      if not ExisteIniWriterDeRE(FLista[i].Evento.TipoEvento) then
        Continue;

      AdicionarIniEventoDeRE(LLote, GerarIniEvento(i), i + 1);
    end;

    LLote.GetStrings(LLista);
    Result := LLista.Text;
  finally
    LLista.Free;
    LLote.Free;
  end;
end;

function TEventos.SaveToIniFile(const AArquivo: string): Integer;
var
  i: Integer;
  LIni: TStringList;
begin
  Result := 0;

  for i := 0 to FLista.Count - 1 do
    if ExisteIniWriterDeRE(FLista[i].Evento.TipoEvento) then
      Inc(Result);

  if Result = 0 then
    Exit;

  if ExtractFilePath(AArquivo) <> '' then
    ForceDirectories(ExtractFilePath(AArquivo));

  LIni := TStringList.Create;
  try
    LIni.Text := GerarIni;
    LIni.SaveToFile(AArquivo);
  finally
    LIni.Free;
  end;
end;

function TEventos.LerConteudoArquivo(const ACaminho: string): string;
var
  LArquivo: TStringList;
  LOriginal: AnsiString;
begin
  LArquivo := TStringList.Create;
  try
    LArquivo.LoadFromFile(ACaminho);
    LOriginal := LArquivo.Text;
  finally
    LArquivo.Free;
  end;

  // Converte de UTF8 para a string nativa da IDE
  Result := DecodeToString(LOriginal, True);
end;

function TEventos.EhXml(const AConteudo: string): Boolean;
var
  LPosXml, LPosIni: Integer;
begin
  // XML: o primeiro '<' vem antes do primeiro '[' (INI comeca por uma secao)
  LPosXml := Pos('<', AConteudo);
  LPosIni := Pos('[', AConteudo);

  Result := (LPosXml > 0) and ((LPosIni = 0) or (LPosXml < LPosIni));
end;

function TEventos.CarregarConteudo(const AConteudo: string): Boolean;
begin
  if EhXml(AConteudo) then
    Result := LoadFromStringXML(ConverteANSItoUTF8(AConteudo))
  else
    Result := LoadFromStringINI(AConteudo);
end;

function TEventos.LoadFromFile(const CaminhoArquivo: string): Boolean;
begin
  Result := CarregarConteudo(LerConteudoArquivo(CaminhoArquivo));
end;

function TEventos.LoadFromStream(AStream: TStringStream): Boolean;
var
  LOriginal: AnsiString;
begin
  AStream.Position := 0;
  LOriginal := ReadStrFromStream(AStream, AStream.Size);

  Result := CarregarConteudo(DecodeToString(LOriginal, True));
end;

function TEventos.LoadFromString(const AString: string): Boolean;
begin
  if EhXml(AString) then
    Result := LoadFromStringXML(AString)
  else
    Result := LoadFromStringINI(AString);
end;

// Posicao do proximo elemento <DeRE ...> (e nao de outra tag iniciada por DeRE)
function PosTagDeRE(const AXml: string; AInicio: Integer): Integer;
var
  LPos: Integer;
begin
  Result := 0;
  LPos := PosEx('<DeRE', AXml, AInicio);

  while LPos > 0 do
  begin
    if (LPos + 5 <= Length(AXml)) and ((AXml[LPos + 5] = ' ') or (AXml[LPos + 5] = '>')) then
    begin
      Result := LPos;
      Exit;
    end;

    LPos := PosEx('<DeRE', AXml, LPos + 5);
  end;
end;

function TEventos.CarregarXmlEvento(const AXml: string): Boolean;
var
  LTipo: TTipoEventoDeRE;
  LNomeEvt, LNome: string;
  LPos, LPosId, LFim: Integer;
  LDeRE: TDeRE;
  LReader: TDeREEventoXmlReader;
begin
  Result := False;

  // Nome do elemento do evento: primeira tag <evtXxx apos o <DeRE>
  LPos := PosEx('<evt', AXml, 1);
  if LPos = 0 then
    Exit;

  LFim := LPos + 1;
  while (LFim <= Length(AXml)) and not ((AXml[LFim] = ' ') or (AXml[LFim] = '>') or (AXml[LFim] = '/')) do
    Inc(LFim);

  LNome := Copy(AXml, LPos + 1, LFim - LPos - 1);

  for LTipo := Low(TTipoEventoDeRE) to High(TTipoEventoDeRE) do
  begin
    LNomeEvt := SchemaDeREToStr(TipoEventoDeREToSchema(LTipo));

    if LNomeEvt <> LNome then
      Continue;

    LDeRE := FLista.New(LTipo);

    // Eventos que possuem leitor de XML registrado alimentam as propriedades
    if ExisteReaderDeRE(LTipo) then
    begin
      LReader := CriarReaderDeRE(LDeRE);
      try
        LReader.Arquivo := AXml;
        LReader.LerXml;
      finally
        LReader.Free;
      end;
    end
    else
    begin
      // Sem leitor: preserva o conteudo para reenvio/consulta e le somente o id
      LPosId := PosEx('id="', AXml, LPos);
      if LPosId > 0 then
      begin
        Inc(LPosId, 4);
        LFim := PosEx('"', AXml, LPosId);
        if LFim > 0 then
          LDeRE.Evento.id := Copy(AXml, LPosId, LFim - LPosId);
      end;
    end;

    LDeRE.Evento.XML := AXml;

    Result := True;
    Exit;
  end;
end;

function TEventos.LoadFromStringXML(const AXMLString: string): Boolean;
var
  LResto, LXmlEvento: string;
  LPos, LFim: Integer;
begin
  // Varre todos os <DeRE>...</DeRE> (um evento cada), inclusive os de um lote
  Result := False;
  LResto := AXMLString;

  while True do
  begin
    LPos := PosTagDeRE(LResto, 1);
    if LPos = 0 then
      Break;

    LFim := PosEx('</DeRE>', LResto, LPos);
    if LFim = 0 then
      Break;

    LXmlEvento := Copy(LResto, LPos, LFim + Length('</DeRE>') - LPos);
    LResto := Copy(LResto, LFim + Length('</DeRE>'), MaxInt);

    if CarregarXmlEvento(LXmlEvento) then
      Result := True;
  end;
end;

function TEventos.CarregarIniEvento(const AIni: string): Boolean;
var
  LIni: TMemIniFile;
  LTipo: TTipoEventoDeRE;
  LDeRE: TDeRE;
  LReader: TDeREIniReader;
begin
  // O INI de um evento possui a secao [evtXxx], que identifica o tipo do evento
  Result := False;

  LIni := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIni, LIni);

    for LTipo := Low(TTipoEventoDeRE) to High(TTipoEventoDeRE) do
    begin
      if not LIni.SectionExists(SchemaDeREToStr(TipoEventoDeREToSchema(LTipo))) then
        Continue;

      if not ExisteIniReaderDeRE(LTipo) then
        Continue;

      LDeRE := FLista.New(LTipo);

      LReader := CriarIniReaderDeRE(LDeRE);
      try
        Result := LReader.LerIni(AIni);
      finally
        LReader.Free;
      end;

      Exit;
    end;
  finally
    LIni.Free;
  end;
end;

function TEventos.LoadFromStringINI(const AINIString: string): Boolean;
var
  LEventos: TStringList;
  i: Integer;
begin
  // O INI pode conter varios eventos de tipos diferentes (secoes com a sequencia do evento: [evtXxx001], [ideEvento001]...)
  Result := False;

  LEventos := TStringList.Create;
  try
    SepararIniEventosDeRE(AINIString, LEventos);

    for i := 0 to LEventos.Count - 1 do
      if CarregarIniEvento(LEventos[i]) then
        Result := True;
  finally
    LEventos.Free;
  end;
end;

function TEventos.LoadFromIni(const AIniString: string): Boolean;
begin
  if FileExists(AIniString) then
    Result := LoadFromStringINI(LerConteudoArquivo(AIniString))
  else
    Result := LoadFromStringINI(AIniString);
end;

end.
