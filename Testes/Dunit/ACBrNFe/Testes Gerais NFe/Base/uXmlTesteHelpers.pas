unit uXmlTesteHelpers;

{ Rotinas de apoio aos testes de acentuação.

  Convenção do ACBr em Delphi Unicode (D2009+):
  - "String nativa"  : UnicodeString com os caracteres corretos ('Ç' = U+00C7).
  - "String UTF8 ACBr": UnicodeString onde CADA BYTE UTF-8 virou um char via
    code page ANSI (CP1252). Ex.: 'Ç' -> bytes C3 87 -> string 'Ã‡'.
    É assim que XMLOriginal / XMLAssinado são mantidos ("Sempre deve estar em UTF8").
    Para obter os bytes reais: AnsiString(S).

  Classificação de BYTES (o que efetivamente vai para disco/SEFAZ/banco):
  - UTF-8 CORRETO: 'Ç' = C3 87
  - UTF-8 DUPLO  : 'Ç' = C3 83 E2 80 A1   (lido como UTF-8 aparece "Ã‡")
  - ANSI/CP1252  : 'Ç' = C7 }

interface

uses
  SysUtils, Classes;

type
  TCodificacao = (cdSemAcento, cdUTF8Correto, cdUTF8Duplo, cdANSI, cdMisto);

const
  NOMES_COD: array[TCodificacao] of string = (
    'SEM ACENTO', 'UTF-8 CORRETO', 'UTF-8 DUPLO (CORROMPIDO)', 'ANSI/CP1252 (CORROMPIDO)', 'MISTO');

  // Texto com todos os acentos pedidos: á é í ó ú ã õ ç (+ maiúsculas e circunflexos)
  TXT_ACENTOS = 'Ação Pão Lição: á é í ó ú â ê ô ã õ ç Á É Í Ó Ú Ã Õ Ç';
  // Trechos presentes nos XMLs fornecidos
  TXT_NATOP   = 'VENDA PRODUÇÃO DO ESTAB.';
  TXT_XPROD   = 'Camisa Polo ACBr com Acentuação';

function BytesUTF8(const ANativo: string): RawByteString;
function BytesUTF8Duplo(const ANativo: string): RawByteString;
function BytesANSI(const ANativo: string): RawByteString;

{ Bytes de uma String na convenção "UTF8 ACBr" (mesma conversão que o ACBr usa ao gravar) }
function BytesDeStringACBr(const S: string): RawByteString;
function BytesDeArquivo(const AArquivo: string): RawByteString;

function ClassificarBytes(const B: RawByteString; const ATexto: string): TCodificacao;
{ S está na convenção "UTF8 ACBr" (XMLOriginal, XMLAssinado, RetornoWS...) }
function ClassificarStringACBr(const S, ATexto: string): TCodificacao;
{ S é string nativa (NFe.Ide.natOp, Content de nó...) }
function ClassificarStringNativa(const S, ATexto: string): TCodificacao;

function HexTrecho(const B: RawByteString; const ATexto: string): string;

procedure LogEtapa(const AEtapa, ADescricao: string; ACod: TCodificacao; const AExtra: string = '');
procedure LogLinha(const S: string);
function PastaBase: string;
function PastaDados: string;
function PastaSaida: string;
{ Raiz do ACBr (Fontes, Exemplos, DLLs). Variável de ambiente ACBR_DIR;
  padrão: C:\ACBr }
function DiretorioACBr: string;

implementation

uses
  Windows;

var
  GLog: TStringList;

function PastaBase: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function DiretorioACBr: string;
begin
  Result := GetEnvironmentVariable('ACBR_DIR');
  if Result = '' then
    Result := 'C:\ACBr';
  Result := IncludeTrailingPathDelimiter(Result);
end;

function PastaDados: string;
begin
  Result := ExpandFileName(PastaBase + '..\Dados\');
end;

function PastaSaida: string;
begin
  Result := PastaBase + 'saida\';
  ForceDirectories(Result);
end;

function TBytesToRaw(const B: TBytes): RawByteString;
begin
  Result := '';
  if Length(B) > 0 then
    SetString(Result, PAnsiChar(@B[0]), Length(B));
  SetCodePage(Result, 1252, False);
end;

function BytesUTF8(const ANativo: string): RawByteString;
begin
  Result := TBytesToRaw(TEncoding.UTF8.GetBytes(ANativo));
end;

function BytesUTF8Duplo(const ANativo: string): RawByteString;
var
  Enc1252: TEncoding;
  Lido1252: string;
begin
  Enc1252 := TEncoding.GetEncoding(1252);
  try
    Lido1252 := Enc1252.GetString(TEncoding.UTF8.GetBytes(ANativo));
  finally
    Enc1252.Free;
  end;
  Result := TBytesToRaw(TEncoding.UTF8.GetBytes(Lido1252));
end;

function BytesANSI(const ANativo: string): RawByteString;
var
  Enc1252: TEncoding;
begin
  Enc1252 := TEncoding.GetEncoding(1252);
  try
    Result := TBytesToRaw(Enc1252.GetBytes(ANativo));
  finally
    Enc1252.Free;
  end;
end;

function BytesDeStringACBr(const S: string): RawByteString;
var
  A: AnsiString;
begin
  A := AnsiString(S);   // mesma conversão de WriteToTXT / WriteStrToStream do ACBr
  Result := RawByteString(A);
  SetCodePage(Result, 1252, False);
end;

function BytesDeArquivo(const AArquivo: string): RawByteString;
var
  FS: TFileStream;
begin
  Result := '';
  FS := TFileStream.Create(AArquivo, fmOpenRead or fmShareDenyNone);
  try
    SetLength(Result, FS.Size);
    if FS.Size > 0 then
      FS.ReadBuffer(Result[1], FS.Size);
  finally
    FS.Free;
  end;
  SetCodePage(Result, 1252, False);
end;

function PosRaw(const Sub, S: RawByteString): Integer;
begin
  Result := Pos(AnsiString(Sub), AnsiString(S));
end;

function ClassificarBytes(const B: RawByteString; const ATexto: string): TCodificacao;
var
  TemUTF8, TemDuplo, TemANSI: Boolean;
begin
  TemDuplo := PosRaw(BytesUTF8Duplo(ATexto), B) > 0;
  TemUTF8  := PosRaw(BytesUTF8(ATexto), B) > 0;
  TemANSI  := PosRaw(BytesANSI(ATexto), B) > 0;

  if TemDuplo and not TemUTF8 then
    Result := cdUTF8Duplo
  else if TemUTF8 and not TemDuplo and not TemANSI then
    Result := cdUTF8Correto
  else if TemANSI and not TemUTF8 and not TemDuplo then
    Result := cdANSI
  else if (TemUTF8 or TemDuplo or TemANSI) then
    Result := cdMisto
  else
    Result := cdSemAcento;   // trecho não encontrado em nenhuma forma
end;

function ClassificarStringACBr(const S, ATexto: string): TCodificacao;
begin
  Result := ClassificarBytes(BytesDeStringACBr(S), ATexto);
end;

function ClassificarStringNativa(const S, ATexto: string): TCodificacao;
begin
  // Se a string nativa estiver correta, seus bytes UTF-8 conterão o texto em UTF-8 simples
  Result := ClassificarBytes(BytesUTF8(S), ATexto);
end;

function HexTrecho(const B: RawByteString; const ATexto: string): string;
var
  P, I, Ini, Fim: Integer;
  Prefixo: RawByteString;
begin
  Result := '';
  // procura o início ASCII do texto (até o primeiro acento)
  I := 1;
  while (I <= Length(ATexto)) and (Ord(ATexto[I]) < 128) do
    Inc(I);
  Prefixo := RawByteString(AnsiString(Copy(ATexto, 1, I - 1)));
  if Prefixo = '' then
    Exit;
  P := PosRaw(Prefixo, B);
  if P = 0 then
    Exit;
  Ini := P + Length(Prefixo);
  Fim := Ini + 11;
  if Fim > Length(B) then
    Fim := Length(B);
  for I := Ini to Fim do
    Result := Result + IntToHex(Ord(B[I]), 2) + ' ';
  Result := Trim(Result);
end;

procedure LogLinha(const S: string);
begin
  GLog.Add(S);
  if IsConsole then          // no runner gráfico (VCL) não há console: Writeln geraria I/O error 105
    System.Writeln(S);
end;

procedure LogEtapa(const AEtapa, ADescricao: string; ACod: TCodificacao; const AExtra: string);
var
  S: string;
begin
  S := Format('  [%-28s] %-48s => %s', [AEtapa, ADescricao, NOMES_COD[ACod]]);
  if AExtra <> '' then
    S := S + '  (' + AExtra + ')';
  LogLinha(S);
end;

initialization
  GLog := TStringList.Create;

finalization
  try
    GLog.SaveToFile(PastaBase + 'rastreio_etapas.log', TEncoding.UTF8);
  except
  end;
  GLog.Free;

end.
