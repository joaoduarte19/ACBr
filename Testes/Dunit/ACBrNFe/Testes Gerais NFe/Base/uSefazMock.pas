unit uSefazMock;

{ SEFAZ simulada para os testes do TACBrNFe.

  Liga-se ao evento TACBrNFe.OnTransmit: o componente monta o envelope SOAP
  real, e em vez de ir para a rede, recebe aqui uma resposta no layout oficial.

  O serviço é identificado pela RAIZ da mensagem enviada:
    consStatServ   -> retConsStatServ      (Status do serviço)
    enviNFe        -> retEnviNFe           (Autorização, síncrona ou assíncrona)
    consReciNFe    -> retConsReciNFe       (Retorno da autorização)
    consSitNFe     -> retConsSitNFe        (Consulta protocolo)
    envEvento      -> retEnvEvento         (Cancelamento, CC-e, manifestação...)
    inutNFe        -> retInutNFe           (Inutilização)
    ConsCad        -> retConsCad           (Consulta cadastro)
    distDFeInt     -> retDistDFeInt        (Distribuição DF-e)
    admCscNFCe     -> retAdmCscNFCe        (Administrar CSC)
    nfceListagem / nfceDownload -> retorno ObterDFe (SP NFC-e)

  As respostas são entregues como o HTTP real entrega: bytes UTF-8 lidos para
  String na "convenção UTF8 ACBr" (ver uXmlTesteHelpers). }

interface

uses
  SysUtils, Classes;

type
  TServicoSefaz = (ssDesconhecido, ssStatus, ssAutorizacao, ssRetAutorizacao,
    ssConsulta, ssEvento, ssInutilizacao, ssConsCad, ssDistDFe, ssAdmCSC,
    ssObterListagem, ssObterDownload);

  TSefazMock = class
  private
    FRequisicoes: TStringList;
    FUltimosDados: string;
    FUltimoServico: TServicoSefaz;
    FUltimaURL: string;
    FUltimoSoapAction: string;
    FChave: string;
    FDigest: string;
    FNFeAssinadaEnviada: string;
    function Envelope(const ATagResult, AConteudo: string): string;
    function ProtNFe: string;
    function Identificar(const ADados, ASoapAction: string): TServicoSefaz;
    function RespEvento(const ADados: string): string;
    function RespInutilizacao(const ADados: string): string;
    function RespDistDFe: string;
  public
    // Comportamento configurável
    Sincrono: Boolean;                 // usado apenas para documentação
    CStatProtocolo: Integer;           // 100 autorizada, 110/301/302 denegada, 204...
    xMotivoProtocolo: string;          // aceita acentos e entidades XML
    DhRecbtoProtocolo: string;         // dhRecbto do protNFe (com offset)
    cMsgProtocolo: Integer;            // > 0 inclui <cMsg>/<xMsg> (mensagem da SEFAZ ao contribuinte)
    xMsgProtocolo: string;             // texto já escapado para XML (ex.: &amp;)
    CStatLote: Integer;                // 104 processado; 103 recebido (assíncrono)
    CStatEvento: Integer;              // 135 vinculado, 573 duplicidade...
    xMotivoEvento: string;
    DigestDivergente: Boolean;         // devolve digVal diferente do enviado
    FalharHTTP: Boolean;               // simula erro de comunicação
    HTTPCode: Integer;
    SemDeclaracaoNaResposta: Boolean;  // algumas SEFAZ respondem sem <?xml?>
    NomeEmitenteCadastro: string;      // xNome devolvido na consulta cadastro
    constructor Create;
    destructor Destroy; override;
    procedure Reset;
    { Define chave/digest devolvidos no protNFe (consulta de nota já assinada) }
    procedure DefinirProtocolo(const AChave, ADigest: string);

    procedure OnTransmit(const Dados, URL, SoapAction, MimeType: String;
      var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);

    property Requisicoes: TStringList read FRequisicoes;
    property UltimosDados: string read FUltimosDados;
    property UltimoServico: TServicoSefaz read FUltimoServico;
    property UltimaURL: string read FUltimaURL;
    property UltimoSoapAction: string read FUltimoSoapAction;
    property ChaveRecebida: string read FChave;
    property DigestRecebido: string read FDigest;
    property NFeAssinadaEnviada: string read FNFeAssinadaEnviada;
  end;

const
  NS_NFE = 'http://www.portalfiscal.inf.br/nfe';
  NPROT_TESTE = '135260009910632';
  NREC_TESTE = '351000000000001';

function NomeServico(S: TServicoSefaz): string;

implementation

uses
  ACBrUtil.Strings, ACBrUtil.XMLHTML, ACBrCompress, synacode;

function NomeServico(S: TServicoSefaz): string;
const
  N: array[TServicoSefaz] of string = ('?', 'Status', 'Autorizacao', 'RetAutorizacao',
    'Consulta', 'Evento', 'Inutilizacao', 'ConsCad', 'DistDFe', 'AdmCSC',
    'ObterListagem', 'ObterDownload');
begin
  Result := N[S];
end;

{ TSefazMock }

constructor TSefazMock.Create;
begin
  inherited Create;
  FRequisicoes := TStringList.Create;
  Reset;
end;

destructor TSefazMock.Destroy;
begin
  FRequisicoes.Free;
  inherited;
end;

procedure TSefazMock.Reset;
begin
  FRequisicoes.Clear;
  FUltimosDados := '';
  FUltimoServico := ssDesconhecido;
  FChave := '';
  FDigest := '';
  FNFeAssinadaEnviada := '';
  Sincrono := True;
  CStatProtocolo := 100;
  xMotivoProtocolo := 'Autorizado o uso da NF-e';
  cMsgProtocolo := 0;
  DhRecbtoProtocolo := '2026-11-10T09:00:38-03:00';
  xMsgProtocolo := '';
  CStatLote := 104;
  CStatEvento := 135;
  xMotivoEvento := 'Evento registrado e vinculado a NF-e';
  DigestDivergente := False;
  FalharHTTP := False;
  HTTPCode := 200;
  SemDeclaracaoNaResposta := False;
  NomeEmitenteCadastro := 'EMPRESA TESTE CONSTRUÇÕES E AÇÕES LTDA';
end;

procedure TSefazMock.DefinirProtocolo(const AChave, ADigest: string);
begin
  FChave := AChave;
  FDigest := ADigest;
end;

function TSefazMock.Identificar(const ADados, ASoapAction: string): TServicoSefaz;
begin
  if Pos('nfceListagemChaves', ASoapAction) > 0 then Result := ssObterListagem
  else if Pos('nfceDownloadXML', ASoapAction) > 0 then Result := ssObterDownload
  else if Pos('<consStatServ', ADados) > 0 then Result := ssStatus
  else if Pos('<enviNFe', ADados) > 0 then Result := ssAutorizacao
  else if Pos('<consReciNFe', ADados) > 0 then Result := ssRetAutorizacao
  else if Pos('<consSitNFe', ADados) > 0 then Result := ssConsulta
  else if Pos('<envEvento', ADados) > 0 then Result := ssEvento
  else if Pos('<inutNFe', ADados) > 0 then Result := ssInutilizacao
  else if Pos('<ConsCad', ADados) > 0 then Result := ssConsCad
  else if Pos('<distDFeInt', ADados) > 0 then Result := ssDistDFe
  else if Pos('<admCscNFCe', ADados) > 0 then Result := ssAdmCSC
  else Result := ssDesconhecido;
end;

function TSefazMock.Envelope(const ATagResult, AConteudo: string): string;
begin
  Result :=
    '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" ' +
    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
    'xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body>' +
    '<' + ATagResult + ' xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/mock">' +
    AConteudo + '</' + ATagResult + '></soap:Body></soap:Envelope>';
  if not SemDeclaracaoNaResposta then
    Result := '<?xml version="1.0" encoding="utf-8"?>' + Result;
end;

function TSefazMock.ProtNFe: string;
var
  Dig: string;
begin
  Dig := FDigest;
  if DigestDivergente then
    Dig := 'AAAAAAAAAAAAAAAAAAAAAAAAAAA=';
  Result :=
    '<protNFe versao="4.00"><infProt>' +
      '<tpAmb>2</tpAmb><verAplic>SP_NFE_PL009_V4</verAplic>' +
      '<chNFe>' + FChave + '</chNFe>' +
      '<dhRecbto>' + DhRecbtoProtocolo + '</dhRecbto>' +
      '<nProt>' + NPROT_TESTE + '</nProt>' +
      '<digVal>' + Dig + '</digVal>' +
      '<cStat>' + IntToStr(CStatProtocolo) + '</cStat>' +
      '<xMotivo>' + xMotivoProtocolo + '</xMotivo>';
  if cMsgProtocolo > 0 then
    Result := Result + '<cMsg>' + IntToStr(cMsgProtocolo) + '</cMsg><xMsg>' + xMsgProtocolo + '</xMsg>';
  Result := Result + '</infProt></protNFe>';
end;

function TSefazMock.RespEvento(const ADados: string): string;
var
  Ch, TpEv, Seq, Lote: string;
begin
  Ch := RetornarConteudoEntre(ADados, '<chNFe>', '</chNFe>');
  TpEv := RetornarConteudoEntre(ADados, '<tpEvento>', '</tpEvento>');
  Seq := RetornarConteudoEntre(ADados, '<nSeqEvento>', '</nSeqEvento>');
  Lote := RetornarConteudoEntre(ADados, '<idLote>', '</idLote>');
  if Seq = '' then Seq := '1';
  Result :=
    '<retEnvEvento xmlns="' + NS_NFE + '" versao="1.00"><idLote>' + Lote + '</idLote>' +
    '<tpAmb>2</tpAmb><verAplic>SP_EVENTOS_PL_100</verAplic><cOrgao>35</cOrgao>' +
    '<cStat>128</cStat><xMotivo>Lote de Evento Processado</xMotivo>' +
    '<retEvento versao="1.00"><infEvento Id="ID' + NPROT_TESTE + '">' +
      '<tpAmb>2</tpAmb><verAplic>SP_EVENTOS_PL_100</verAplic><cOrgao>35</cOrgao>' +
      '<cStat>' + IntToStr(CStatEvento) + '</cStat><xMotivo>' + xMotivoEvento + '</xMotivo>' +
      '<chNFe>' + Ch + '</chNFe><tpEvento>' + TpEv + '</tpEvento>' +
      '<xEvento>Evento de teste</xEvento><nSeqEvento>' + Seq + '</nSeqEvento>' +
      '<CNPJDest>05481336000137</CNPJDest>' +
      '<dhRegEvento>2026-11-10T10:00:00-03:00</dhRegEvento>' +
      '<nProt>' + NPROT_TESTE + '</nProt>' +
    '</infEvento></retEvento></retEnvEvento>';
end;

function TSefazMock.RespInutilizacao(const ADados: string): string;
  function T(const ATag: string): string;
  begin
    Result := RetornarConteudoEntre(ADados, '<' + ATag + '>', '</' + ATag + '>');
  end;
begin
  Result :=
    '<retInutNFe xmlns="' + NS_NFE + '" versao="4.00"><infInut>' +
    '<tpAmb>2</tpAmb><verAplic>SP_NFE_PL009_V4</verAplic>' +
    '<cStat>102</cStat><xMotivo>Inutilização de número homologado</xMotivo>' +
    '<cUF>' + T('cUF') + '</cUF><ano>' + T('ano') + '</ano><CNPJ>' + T('CNPJ') + '</CNPJ>' +
    '<mod>' + T('mod') + '</mod><serie>' + T('serie') + '</serie>' +
    '<nNFIni>' + T('nNFIni') + '</nNFIni><nNFFin>' + T('nNFFin') + '</nNFFin>' +
    '<dhRecbto>2026-11-10T10:00:00-03:00</dhRecbto><nProt>' + NPROT_TESTE + '</nProt>' +
    '</infInut></retInutNFe>';
end;

function TSefazMock.RespDistDFe: string;
var
  ResNFe: AnsiString;
  Zip: AnsiString;
begin
  ResNFe := NativeStringToUTF8(
    '<resNFe xmlns="' + NS_NFE + '" versao="1.01">' +
    '<chNFe>35261118760540000139550030000000831312257860</chNFe>' +
    '<CNPJ>18760540000139</CNPJ><xNome>EMITENTE AÇÃO LTDA</xNome><IE>687097034118</IE>' +
    '<dhEmi>2026-11-10T00:00:00-03:00</dhEmi><tpNF>1</tpNF><vNF>100.00</vNF>' +
    '<digVal>Lk+IuRnseKd6Nn1LPYlKwAkZR34=</digVal>' +
    '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto><nProt>' + NPROT_TESTE + '</nProt>' +
    '<cSitNFe>1</cSitNFe></resNFe>');
  Zip := EncodeBase64(GZipCompress(ResNFe));
  Result :=
    '<retDistDFeInt xmlns="' + NS_NFE + '" versao="1.01">' +
    '<tpAmb>2</tpAmb><verAplic>1.7.0</verAplic><cStat>138</cStat>' +
    '<xMotivo>Documento localizado</xMotivo><dhResp>2026-11-10T10:00:00-03:00</dhResp>' +
    '<ultNSU>000000000000001</ultNSU><maxNSU>000000000000001</maxNSU>' +
    '<loteDistDFeInt><docZip NSU="000000000000001" schema="resNFe_v1.01.xsd">' +
    string(Zip) + '</docZip></loteDistDFeInt></retDistDFeInt>';
end;

procedure TSefazMock.OnTransmit(const Dados, URL, SoapAction, MimeType: String;
  var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);
var
  R, Tag: string;
begin
  FUltimosDados := Dados;
  FUltimaURL := URL;
  FUltimoSoapAction := SoapAction;
  FUltimoServico := Identificar(Dados, SoapAction);
  FRequisicoes.Add(NomeServico(FUltimoServico));

  if FalharHTTP then
  begin
    Resposta := '';
    HTTPResultCode := 500;
    InternalErrorCode := 12029;   // ERROR_INTERNET_CANNOT_CONNECT
    Exit;
  end;

  if Pos('<DigestValue>', Dados) > 0 then
  begin
    FDigest := RetornarConteudoEntre(Dados, '<DigestValue>', '</DigestValue>');
    FChave := RetornarConteudoEntre(Dados, 'Id="NFe', '"');
    if FUltimoServico = ssAutorizacao then
      FNFeAssinadaEnviada := '<NFe' + RetornarConteudoEntre(Dados, '<NFe', '</NFe>') + '</NFe>';
  end;
  if (FChave = '') and (Pos('<chNFe>', Dados) > 0) then
    FChave := RetornarConteudoEntre(Dados, '<chNFe>', '</chNFe>');

  Tag := 'nfeResultMsg';
  case FUltimoServico of
    ssStatus:
      R := '<retConsStatServ xmlns="' + NS_NFE + '" versao="4.00"><tpAmb>2</tpAmb>' +
           '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>107</cStat>' +
           '<xMotivo>Serviço em Operação</xMotivo><cUF>35</cUF>' +
           '<dhRecbto>2026-11-10T10:00:00-03:00</dhRecbto><tMed>1</tMed></retConsStatServ>';

    ssAutorizacao:
      if Pos('<indSinc>1</indSinc>', Dados) > 0 then
        R := '<retEnviNFe xmlns="' + NS_NFE + '" versao="4.00"><tpAmb>2</tpAmb>' +
             '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>' + IntToStr(CStatLote) + '</cStat>' +
             '<xMotivo>Lote processado</xMotivo><cUF>35</cUF>' +
             '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto>' + ProtNFe + '</retEnviNFe>'
      else
        R := '<retEnviNFe xmlns="' + NS_NFE + '" versao="4.00"><tpAmb>2</tpAmb>' +
             '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>103</cStat>' +
             '<xMotivo>Lote recebido com sucesso</xMotivo><cUF>35</cUF>' +
             '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto>' +
             '<infRec><nRec>' + NREC_TESTE + '</nRec><tMed>1</tMed></infRec></retEnviNFe>';

    ssRetAutorizacao:
      R := '<retConsReciNFe xmlns="' + NS_NFE + '" versao="4.00"><tpAmb>2</tpAmb>' +
           '<verAplic>SP_NFE_PL009_V4</verAplic><nRec>' + NREC_TESTE + '</nRec>' +
           '<cStat>' + IntToStr(CStatLote) + '</cStat><xMotivo>Lote processado</xMotivo><cUF>35</cUF>' +
           '<dhRecbto>2026-11-10T09:00:39-03:00</dhRecbto>' + ProtNFe + '</retConsReciNFe>';

    ssConsulta:
      R := '<retConsSitNFe xmlns="' + NS_NFE + '" versao="4.00"><tpAmb>2</tpAmb>' +
           '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>' + IntToStr(CStatProtocolo) + '</cStat>' +
           '<xMotivo>' + xMotivoProtocolo + '</xMotivo><cUF>35</cUF>' +
           '<dhRecbto>2026-11-10T09:01:00-03:00</dhRecbto><chNFe>' + FChave + '</chNFe>' +
           ProtNFe + '</retConsSitNFe>';

    ssEvento:
      R := RespEvento(Dados);

    ssInutilizacao:
      R := RespInutilizacao(Dados);

    ssConsCad:
      begin
        Tag := 'consultaCadastroResult';
        R := '<retConsCad xmlns="' + NS_NFE + '" versao="2.00"><infCons>' +
             '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>111</cStat>' +
             '<xMotivo>Consulta cadastro com uma ocorrência</xMotivo><UF>SP</UF>' +
             '<CNPJ>18760540000139</CNPJ><dhCons>2026-11-10T10:00:00-03:00</dhCons><cUF>35</cUF>' +
             '<infCad><IE>687097034118</IE><CNPJ>18760540000139</CNPJ><UF>SP</UF>' +
             '<cSit>1</cSit><indCredNFe>1</indCredNFe><indCredCTe>4</indCredCTe>' +
             '<xNome>' + NomeEmitenteCadastro + '</xNome><xRegApur>NORMAL</xRegApur>' +
             '<CNAE>6201500</CNAE><dIniAtiv>2013-08-01</dIniAtiv>' +
             '<ender><xLgr>RUA DA AÇÃO</xLgr><nro>1</nro><xBairro>CENTRO</xBairro>' +
             '<cMun>3554003</cMun><xMun>TATUÍ</xMun><CEP>18270170</CEP></ender>' +
             '</infCad></infCons></retConsCad>';
      end;

    ssDistDFe:
      begin
        Tag := 'nfeDistDFeInteresseResult';
        R := RespDistDFe;
      end;

    ssAdmCSC:
      begin
        Tag := 'admCscNFCeResult';
        R := '<retAdmCscNFCe xmlns="' + NS_NFE + '" versao="1.00"><tpAmb>2</tpAmb>' +
             '<indOp>1</indOp><cStat>150</cStat><xMotivo>Consulta CSC realizada</xMotivo>' +
             '<dadosCsc><idCsc>000001</idCsc><codigoCsc>ABCDEF0123456789</codigoCsc></dadosCsc>' +
             '</retAdmCscNFCe>';
      end;

    ssObterListagem:
      R := '<retNFCeListagemChaves xmlns="' + NS_NFE + '" versao="1.00"><tpAmb>2</tpAmb>' +
           '<verAplic>SP</verAplic><cStat>100</cStat><xMotivo>Consulta realizada</xMotivo>' +
           '<dhReq>2026-11-10T10:00:00-03:00</dhReq>' +
           '<chNFCe>35261118760540000139650010000000011000000016</chNFCe>' +
           '<chNFCe>35261118760540000139650010000000021000000021</chNFCe>' +
           '</retNFCeListagemChaves>';

    ssObterDownload:
      R := '<retNFCeDownloadXML xmlns="' + NS_NFE + '" versao="1.00"><tpAmb>2</tpAmb>' +
           '<verAplic>SP</verAplic><cStat>100</cStat><xMotivo>Consulta realizada</xMotivo>' +
           '<dhReq>2026-11-10T10:00:00-03:00</dhReq></retNFCeDownloadXML>';
  else
    R := '<erro>serviço não simulado</erro>';
  end;

  // Igual ao HTTP real: bytes UTF-8 lidos para String (ReadStrFromStream)
  Resposta := string(NativeStringToUTF8(Envelope(Tag, R)));
  HTTPResultCode := HTTPCode;
  InternalErrorCode := 0;
end;

end.
