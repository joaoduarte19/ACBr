{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                              Equipe Nexus (Adequação Padrão Nacional IBS/CBS)}
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

unit SigCorp.Provider;

interface

uses
  SysUtils, Classes,
  ACBrBase,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  ACBrJSON,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceSigCorp203 = class(TACBrNFSeXWebserviceMisto1)
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderSigCorp203 = class (TACBrNFSeProviderABRASFv2)
  private
    FPath: string;
    FMethod: string;
    FChave: string;

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure TratarRetornoCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;

    procedure PrepararObterDANFSE(Response: TNFSeObterDANFSEResponse); override;
    procedure TratarRetornoObterDANFSE(Response: TNFSeObterDANFSEResponse); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
      Response: TNFSeWebserviceResponse; const AListTag: string);

    procedure ValidarSchema(Response: TNFSeWebserviceResponse; aMetodo: TMetodo); override;
  public
    property Path: string read FPath write FPath;
    property Method: string read FMethod write FMethod;
    property Chave: string read FChave write FChave;
  end;

  TACBrNFSeXWebserviceSigCorp204 = class(TACBrNFSeXWebserviceMisto1)
  private
    function GetNameSpace: string;
    function GetSoapAction: string;
    function GetURL: string;
    function GetSubVersao: Integer;
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;

    property URL: string read GetURL;
    property NameSpace: string read GetNameSpace;
    property SoapAction: string read GetSoapAction;
    property SubVersao: Integer read GetSubVersao;
  end;

  TACBrNFSeProviderSigCorp204 = class (TACBrNFSeProviderABRASFv2)
  private
    FPath: string;
    FMethod: string;
    FChave: string;

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure PrepararObterDANFSE(Response: TNFSeObterDANFSEResponse); override;
    procedure TratarRetornoObterDANFSE(Response: TNFSeObterDANFSEResponse); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
      Response: TNFSeWebserviceResponse; const AListTag: string);
    procedure ValidarSchema(Response: TNFSeWebserviceResponse; aMetodo: TMetodo); override;
  public
    property Path: string read FPath write FPath;
    property Method: string read FMethod write FMethod;
    property Chave: string read FChave write FChave;
  end;

  TACBrNFSeXWebserviceSigCorpAPIPropria = class(TACBrNFSeXWebserviceRest)
  private
    FNumeroNFSe: string;
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;
  public
    function Recepcionar(const ACabecalho, AMSG: string): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: string): string; override;
    function GerarNFSe(const ACabecalho, AMSG: string): string; override;
    function ConsultarLote(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: string): string; override;
    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;  end;

  TACBrNFSeProviderSigCorpAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private
    FPath: string;
    FMethod: string;
    FChave: string;

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;

    procedure PrepararObterDANFSE(Response: TNFSeObterDANFSEResponse); override;
    procedure TratarRetornoObterDANFSE(Response: TNFSeObterDANFSEResponse); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
      Response: TNFSeWebserviceResponse; const AListTag: string);

    procedure ValidarSchema(Response: TNFSeWebserviceResponse; aMetodo: TMetodo); override;
  public
    function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao): string; override;
    function StrToRegimeEspecialTributacao(out ok: boolean; const s: string): TnfseRegimeEspecialTributacao; override;

    property Path: string read FPath write FPath;
    property Method: string read FMethod write FMethod;
    property Chave: string read FChave write FChave;
  end;

implementation

uses
  synacode,
  ACBrDFe.Conversao,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  ACBrNFSeXNotasFiscais,
  SigCorp.GravarXml,
  SigCorp.LerXml;

{ TACBrNFSeProviderSigCorp203 }

procedure TACBrNFSeProviderSigCorp203.Configuracao;
begin
  inherited Configuracao;

  // Usado na leitura do envio
  FpFormatoDataRecebimento := tcDatUSA;
  // Usado na leitura das informações de cancelamento
  FpFormatoDataHora := tcDatHor;
  // Usado na leitura da data de emissão da NFS-e
  FpFormatoDataEmissao := tcDatHor;

  if ConfigGeral.Params.ParamTemValor('FormatoData', 'CancDDMMAAAA') then
    FpFormatoDataHora := tcDatVcto;

  if ConfigGeral.Params.ParamTemValor('FormatoData', 'CancMMDDAAAA') then
    FpFormatoDataHora := tcDatUSA;

  if ConfigGeral.Params.ParamTemValor('FormatoData', 'NFSeDDMMAAAA') then
    FpFormatoDataEmissao := tcDatVcto;

  if ConfigGeral.Params.ParamTemValor('FormatoData', 'NFSeMMDDAAAA') then
    FpFormatoDataEmissao := tcDatUSA;

  with ConfigGeral do
  begin
    UseCertificateHTTP := False;
    QuebradeLinha := '|';
  end;

  with ConfigAssinar do
  begin
    Rps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.03';
    VersaoAtrib := '2.03';
  end;

  ConfigMsgDados.DadosCabecalho := GetCabecalho('');
end;

function TACBrNFSeProviderSigCorp203.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_SigCorp203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorp203.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_SigCorp203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorp203.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmObterDANFSE] then
  begin
    ConfigGeral.FormatoArqEnvioSoap := tfaJson;
    AMimeType := 'application/json';
    URL := URL + Path;
  end
  else
  begin
    ConfigGeral.FormatoArqEnvioSoap := tfaXml;
    AMimeType := 'text/xml';
    Method := 'POST';
  end;

  if URL <> '' then
    Result := TACBrNFSeXWebserviceSigCorp204.Create(FAOwner, AMetodo, URL, Method, AMimeType)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderSigCorp203.TratarRetornoCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode: TACBrXmlNode;
  Ret: TRetCancelamento;
  IdAttr, xDataHora, xFormato: string;
  AErro: TNFSeEventoCollectionItem;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ProcessarMensagemErros(Document.Root, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      ANode := Document.Root.Childrens.FindAnyNs('RetCancelamento');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod209;
        AErro.Descricao := ACBrStr(Desc209);
        Exit;
      end;

      ANode := ANode.Childrens.FindAnyNs('NfseCancelamento');
      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod210;
        AErro.Descricao := ACBrStr(Desc210);
        Exit;
      end;

      ANode := ANode.Childrens.FindAnyNs('Cancelamento');

      ANode := ANode.Childrens.FindAnyNs('Confirmacao');
      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod204;
        AErro.Descricao := ACBrStr(Desc204);
        Exit;
      end;

      Ret :=  Response.RetCancelamento;

      xDataHora := ObterConteudoTag(ANode.Childrens.FindAnyNs('DataHoraCancelamento'), tcStr);
      xFormato := 'YYYY/MM/DD';

      if ConfigGeral.Params.ParamTemValor('FormatoData', 'CancDDMMAAAA') then
        xFormato := 'DD/MM/YYYY';

      if ConfigGeral.Params.ParamTemValor('FormatoData', 'CancMMDDAAAA') then
        xFormato := 'MM/DD/YYYY';

      Ret.DataHora := EncodeDataHora(xDataHora, xFormato);

      if ConfigAssinar.IncluirURI then
        IdAttr := ConfigGeral.Identificador
      else
        IdAttr := 'ID';

      ANode := ANode.Childrens.FindAnyNs('Pedido');
      ANode := ANode.Childrens.FindAnyNs('InfPedidoCancelamento');

      Ret.Pedido.InfID.ID := ObterConteudoTag(ANode.Attributes.Items[IdAttr]);
      Ret.Pedido.CodigoCancelamento := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoCancelamento'), tcStr);

      ANode := ANode.Childrens.FindAnyNs('IdentificacaoNfse');

      with Ret.Pedido.IdentificacaoNfse do
      begin
        Numero := ObterConteudoTag(ANode.Childrens.FindAnyNs('Numero'), tcStr);
        Cnpj := ObterConteudoTag(ANode.Childrens.FindAnyNs('Cnpj'), tcStr);
        InscricaoMunicipal := ObterConteudoTag(ANode.Childrens.FindAnyNs('InscricaoMunicipal'), tcStr);
        CodigoMunicipio := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderSigCorp203.PrepararObterDANFSE(
  Response: TNFSeObterDANFSEResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.ChaveNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod118;
    AErro.Descricao := ACBrStr(Desc118);
    Exit;
  end;

  Path := '/danfse/' + Response.ChaveNFSe;
  Response.Metodo := tmObterDANFSE;

  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

procedure TACBrNFSeProviderSigCorp203.TratarRetornoObterDANFSE(
  Response: TNFSeObterDANFSEResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Document: TACBrJSONObject;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  if Pos('"title":"Not Found","status":404', Response.ArquivoRetorno) > 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod214;
    AErro.Descricao := ACBrStr(Desc214);
    Exit
  end;

  if not StringISPDF(Response.ArquivoRetorno) then
  begin
    Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

    try
      try
        ProcessarMensagemDeErros(Document, Response, 'Erros');
        Response.Sucesso := (Response.Erros.Count = 0);

        if Response.Sucesso then
          SalvarPDFNfse(Response.ChaveNFSe, Response.ArquivoRetorno);
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
      FreeAndNil(Document);
    end;
  end else
  begin
    try
      Response.Sucesso := True;
      SalvarPDFNfse(Response.ChaveNFSe, Response.ArquivoRetorno);
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  end;
end;

procedure TACBrNFSeProviderSigCorp203.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  JSonLista: TACBrJSONArray;
  JSon: TACBrJSONObject;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo: string;
  begin
    Codigo := JSonItem.AsString['Codigo'];

    if Codigo <> '' then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := JSonItem.AsString['Descricao'];
      AItem.Correcao := JSonItem.AsString['Complemento'];
    end
    else
    begin
      Codigo := JSonItem.AsString['codigo'];

      if Codigo <> '' then
      begin
        AItem := Collection.New;
        AItem.Codigo := Codigo;
        AItem.Descricao := JSonItem.AsString['descricao'];
        AItem.Correcao := JSonItem.AsString['complemento'];
      end;
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
  begin
    for i := 0 to jsLista.Count-1 do
    begin
      JSon := jsLista.ItemAsJSONObject[i];

      AdicionaCollectionItem(JSon, Collection);
    end;
  end;

  procedure VerificaSeObjetoOuArray(aNome: string; Collection: TNFSeEventoCollection);
  begin
    // Verifica se no retorno contem um objeto ou array
    if LJson.IsJSONArray(aNome) then
    begin
      JSonLista := LJson.AsJSONArray[aNome];

      if JSonLista.Count > 0 then
        LerListaErrosAlertas(JSonLista, Collection);
    end
    else
    begin
      JSon := LJson.AsJSONObject[aNome];

      if JSon <> nil then
        AdicionaCollectionItem(JSon, Collection);
    end;
  end;
begin
  // Verifica se no retorno contem a lista de Erros
  VerificaSeObjetoOuArray(AListTag, Response.Erros);
  // Verifica se no retorno contem a lista de erros
  VerificaSeObjetoOuArray('erros', Response.Erros);
  // Verifica se no retorno contem a lista de erro
  VerificaSeObjetoOuArray('erro', Response.Erros);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('Alertas', Response.Alertas);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('alertas', Response.Alertas);
end;

procedure TACBrNFSeProviderSigCorp203.ValidarSchema(
  Response: TNFSeWebserviceResponse; aMetodo: TMetodo);
begin
  if aMetodo <> tmObterDANFSE then
  begin
    inherited ValidarSchema(Response, aMetodo);
  end;
end;

{ TACBrNFSeXWebserviceSigCorp203 }

function TACBrNFSeXWebserviceSigCorp203.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:RecepcionarLoteRps>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:RecepcionarLoteRps>';

  Result := Executar('http://tempuri.org/RecepcionarLoteRps', Request,
                     ['RecepcionarLoteRpsResult', 'EnviarLoteRpsResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:RecepcionarLoteRpsSincrono>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:RecepcionarLoteRpsSincrono>';

  Result := Executar('http://tempuri.org/RecepcionarLoteRpsSincrono', Request,
                     ['RecepcionarLoteRpsSincronoResult', 'EnviarLoteRpsResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:GerarNfse>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:GerarNfse>';

  Result := Executar('http://tempuri.org/GerarNfse', Request,
                     ['GerarNfseResult', 'GerarNfseResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:ConsultarLoteRps>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:ConsultarLoteRps>';

  Result := Executar('http://tempuri.org/ConsultarLoteRps', Request,
                     ['ConsultarLoteRpsResult', 'ConsultarLoteRpsResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:ConsultarNfsePorFaixa>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:ConsultarNfsePorFaixa>';

  Result := Executar('http://tempuri.org/ConsultarNfsePorFaixa', Request,
                     ['ConsultarNfsePorFaixaResult', 'ConsultarNfseFaixaResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:ConsultarNfsePorRps>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:ConsultarNfsePorRps>';

  Result := Executar('http://tempuri.org/ConsultarNfsePorRps', Request,
                     ['ConsultarNfsePorRpsResult', 'ConsultarNfseRpsResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:ConsultarNfseServicoPrestado>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:ConsultarNfseServicoPrestado>';

  Result := Executar('http://tempuri.org/ConsultarNfseServicoPrestado', Request,
                     ['ConsultarNfseServicoPrestadoResult', 'ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:ConsultarNfseServicoTomado>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:ConsultarNfseServicoTomado>';

  Result := Executar('http://tempuri.org/ConsultarNfseServicoTomado', Request,
                     ['ConsultarNfseServicoTomadoResult', 'ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:CancelaNota>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:CancelaNota>';

  Result := Executar('http://tempuri.org/CancelaNota', Request,
                     ['CancelaNotaResult', 'CancelarNfseResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<tem:SubstituirNfse>';
  Request := Request + '<tem:nfseCabecMsg>' + XmlToStr(ACabecalho) + '</tem:nfseCabecMsg>';
  Request := Request + '<tem:nfseDadosMsg>' + XmlToStr(AMSG) + '</tem:nfseDadosMsg>';
  Request := Request + '</tem:SubstituirNfse>';

  Result := Executar('http://tempuri.org/SubstituirNfse', Request,
                     ['SubstituirNfseResult', 'SubstituirNfseResposta'],
                     ['xmlns:tem="http://tempuri.org/"']);
end;

function TACBrNFSeXWebserviceSigCorp203.ObterDANFSE(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceSigCorp203.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  if not StringIsPDF(Result) then
  begin

    Result := ParseText(Result);
    Result := RemoverDeclaracaoXML(Result);
    Result := RemoverCaracteresDesnecessarios(Result);
  end;
end;

{ TACBrNFSeProviderSigCorp204 }

procedure TACBrNFSeProviderSigCorp204.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    QuebradeLinha := '|';
    ConsultaPorFaixaPreencherNumNfseFinal := True;
    CancPreencherMotivo := True;
    ServicosDisponibilizados.ObterDANFSE := True;
  end;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
    SubstituirNFSe := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.04';
    VersaoAtrib := '2.04';
  end;

  with ConfigMsgDados do
  begin
    GerarPrestadorLoteRps := True;
    DadosCabecalho := GetCabecalho('');
  end;

  // Provedor não disponibilizou os novos Schemas.
  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderSigCorp204.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_SigCorp204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorp204.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_SigCorp204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorp204.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmObterDANFSE] then
  begin
    ConfigGeral.FormatoArqEnvioSoap := tfaJson;
    AMimeType := 'application/json';
    URL := URL + Path;
  end
  else
  begin
    ConfigGeral.FormatoArqEnvioSoap := tfaXml;
    AMimeType := 'text/xml';
    Method := 'POST';
  end;

  if URL <> '' then
    Result := TACBrNFSeXWebserviceSigCorp204.Create(FAOwner, AMetodo, URL, Method, AMimeType)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderSigCorp204.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  JSonLista: TACBrJSONArray;
  JSon: TACBrJSONObject;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo: string;
  begin
    Codigo := JSonItem.AsString['Codigo'];

    if Codigo <> '' then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := JSonItem.AsString['Descricao'];
      AItem.Correcao := JSonItem.AsString['Complemento'];
    end
    else
    begin
      Codigo := JSonItem.AsString['codigo'];

      if Codigo <> '' then
      begin
        AItem := Collection.New;
        AItem.Codigo := Codigo;
        AItem.Descricao := JSonItem.AsString['descricao'];
        AItem.Correcao := JSonItem.AsString['complemento'];
      end;
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
  begin
    for i := 0 to jsLista.Count-1 do
    begin
      JSon := jsLista.ItemAsJSONObject[i];

      AdicionaCollectionItem(JSon, Collection);
    end;
  end;

  procedure VerificaSeObjetoOuArray(aNome: string; Collection: TNFSeEventoCollection);
  begin
    // Verifica se no retorno contem um objeto ou array
    if LJson.IsJSONArray(aNome) then
    begin
      JSonLista := LJson.AsJSONArray[aNome];

      if JSonLista.Count > 0 then
        LerListaErrosAlertas(JSonLista, Collection);
    end
    else
    begin
      JSon := LJson.AsJSONObject[aNome];

      if JSon <> nil then
        AdicionaCollectionItem(JSon, Collection);
    end;
  end;
begin
  // Verifica se no retorno contem a lista de Erros
  VerificaSeObjetoOuArray(AListTag, Response.Erros);
  // Verifica se no retorno contem a lista de erros
  VerificaSeObjetoOuArray('erros', Response.Erros);
  // Verifica se no retorno contem a lista de erro
  VerificaSeObjetoOuArray('erro', Response.Erros);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('Alertas', Response.Alertas);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('alertas', Response.Alertas);
end;

procedure TACBrNFSeProviderSigCorp204.PrepararObterDANFSE(Response: TNFSeObterDANFSEResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.ChaveNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod118;
    AErro.Descricao := ACBrStr(Desc118);
    Exit;
  end;

  Path := '/danfse/' + Response.ChaveNFSe;
  Response.Metodo := tmObterDANFSE;

  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

procedure TACBrNFSeProviderSigCorp204.TratarRetornoObterDANFSE(Response: TNFSeObterDANFSEResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Document: TACBrJSONObject;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  if Pos('"title":"Not Found","status":404', Response.ArquivoRetorno) > 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod214;
    AErro.Descricao := ACBrStr(Desc214);
    Exit
  end;

  if not StringISPDF(Response.ArquivoRetorno) then
  begin
    Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

    try
      try
        ProcessarMensagemDeErros(Document, Response, 'Erros');
        Response.Sucesso := (Response.Erros.Count = 0);

        if Response.Sucesso then
          SalvarPDFNfse(Response.ChaveNFSe, Response.ArquivoRetorno);
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
      FreeAndNil(Document);
    end;
  end else
  begin
    try
      Response.Sucesso := True;
      SalvarPDFNfse(Response.ChaveNFSe, Response.ArquivoRetorno);
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  end;
end;

procedure TACBrNFSeProviderSigCorp204.ValidarSchema(
  Response: TNFSeWebserviceResponse; aMetodo: TMetodo);
begin
  if aMetodo <> tmObterDANFSE then
  begin
    inherited ValidarSchema(Response, aMetodo);
  end;
end;

{ TACBrNFSeXWebserviceSigCorp204 }

function TACBrNFSeXWebserviceSigCorp204.GetURL: string;
begin
  if TACBrNFSeX(FPDFeOwner).Configuracoes.WebServices.AmbienteCodigo = 1 then
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Producao.NameSpace
  else
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Homologacao.NameSpace;
end;

function TACBrNFSeXWebserviceSigCorp204.GetNameSpace: string;
begin
  Result := 'xmlns:ws="' + URL + '"';
end;

function TACBrNFSeXWebserviceSigCorp204.GetSoapAction: string;
begin
  if TACBrNFSeX(FPDFeOwner).Configuracoes.WebServices.AmbienteCodigo = 1 then
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Producao.SoapAction
  else
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Homologacao.SoapAction;

  if Result = '' then
    Result := URL;

  Result := Result + '#';
end;

function TACBrNFSeXWebserviceSigCorp204.GetSubVersao: Integer;
begin
  Result := StrToIntDef(TACBrNFSeX(FPDFeOwner).Provider.ConfigGeral.Params.ValorParametro('SubVersao'), 0);
end;

function TACBrNFSeXWebserviceSigCorp204.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:RecepcionarLoteRpsRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:RecepcionarLoteRpsRequest>';

    Result := Executar(SoapAction + 'RecepcionarLoteRps', Request,
                       ['RecepcionarLoteRpsResponse', 'outputXML', 'EnviarLoteRpsResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:RecepcionarLoteRps>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:RecepcionarLoteRps>';

    Result := Executar(SoapAction + 'RecepcionarLoteRps', Request,
                       ['RecepcionarLoteRpsResult', 'EnviarLoteRpsResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:RecepcionarLoteRpsSincronoRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:RecepcionarLoteRpsSincronoRequest>';

    Result := Executar(SoapAction + 'RecepcionarLoteRpsSincrono', Request,
                       ['RecepcionarLoteRpsSincronoResponse', 'outputXML', 'EnviarLoteRpsSincronoResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:RecepcionarLoteRpsSincrono>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:RecepcionarLoteRpsSincrono>';

    Result := Executar(SoapAction + 'RecepcionarLoteRpsSincrono', Request,
                       ['RecepcionarLoteRpsSincronoResult', 'EnviarLoteRpsSincronoResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:GerarNfseRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:GerarNfseRequest>';

    Result := Executar(SoapAction + 'GerarNfse', Request,
                       ['GerarNfseResponse', 'outputXML', 'GerarNfseResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:GerarNfse>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:GerarNfse>';

    Result := Executar(SoapAction + 'GerarNfse', Request,
                       ['GerarNfseResult', 'GerarNfseResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:ConsultarLoteRpsRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:ConsultarLoteRpsRequest>';

    Result := Executar(SoapAction + 'ConsultarLoteRps', Request,
                       ['ConsultarLoteRpsResponse', 'outputXML', 'ConsultarLoteRpsResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:ConsultarLoteRps>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:ConsultarLoteRps>';

    Result := Executar(SoapAction + 'ConsultarLoteRps', Request,
                       ['ConsultarLoteRpsResult', 'ConsultarLoteRpsResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:ConsultarNfsePorRpsRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:ConsultarNfsePorRpsRequest>';

    Result := Executar(SoapAction + 'ConsultarNfsePorRps', Request,
                       ['ConsultarNfsePorRpsResponse', 'outputXML', 'ConsultarNfseRpsResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:ConsultarNfsePorRps>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:ConsultarNfsePorRps>';

    Result := Executar(SoapAction + 'ConsultarNfsePorRps', Request,
                       ['ConsultarNfsePorRpsResult', 'ConsultarNfseRpsResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:ConsultarNfseFaixaRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:ConsultarNfseFaixaRequest>';

    Result := Executar(SoapAction + 'ConsultarNfseFaixa', Request,
                       ['ConsultarNfseFaixaResponse', 'outputXML', 'ConsultarNfseFaixaResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:ConsultarNfseFaixa>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:ConsultarNfseFaixa>';

    Result := Executar(SoapAction + 'ConsultarNfseFaixa', Request,
                       ['ConsultarNfseFaixaResult', 'ConsultarNfseFaixaResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:ConsultarNfseServicoPrestadoRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:ConsultarNfseServicoPrestadoRequest>';

    Result := Executar(SoapAction + 'ConsultarNfseServicoPrestado', Request,
                       ['ConsultarNfseServicoPrestadoResponse', 'outputXML',
                        'ConsultarNfseServicoPrestadoResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:ConsultarNfseServicoPrestado>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:ConsultarNfseServicoPrestado>';

    Result := Executar(SoapAction + 'ConsultarNfseServicoPrestado', Request,
                       ['ConsultarNfseServicoPrestadoResult', 'ConsultarNfseServicoPrestadoResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:ConsultarNfseServicoTomadoRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:ConsultarNfseServicoTomadoRequest>';

    Result := Executar(SoapAction + 'ConsultarNfseServicoTomado', Request,
                       ['ConsultarNfseServicoTomadoResponse', 'outputXML',
                        'ConsultarNfseServicoTomadoResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:ConsultarNfseServicoTomado>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:ConsultarNfseServicoTomado>';

    Result := Executar(SoapAction + 'ConsultarNfseServicoTomado', Request,
                       ['ConsultarNfseServicoTomadoResult', 'ConsultarNfseServicoTomadoResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.Cancelar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:CancelarNfseRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:CancelarNfseRequest>';

    Result := Executar(SoapAction + 'CancelarNfse', Request,
                       ['CancelarNfseResponse', 'outputXML',
                        'CancelarNfseResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:CancelarNfse>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:CancelarNfse>';

    Result := Executar(SoapAction + 'CancelarNfse', Request,
                       ['CancelarNfseResult', 'CancelarNfseResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  if SubVersao = 1 then
  begin
    Request := '<ws:SubstituirNfseRequest>';
    Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
    Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
    Request := Request + '</ws:SubstituirNfseRequest>';

    Result := Executar(SoapAction + 'SubstituirNfse', Request,
                       ['SubstituirNfseResponse', 'outputXML',
                        'SubstituirNfseResposta'],
                       [NameSpace]);
  end
  else
  begin
    Request := '<ws:SubstituirNfse>';
    Request := Request + '<xml>' + IncluirCDATA(AMSG) + '</xml>';
    Request := Request + '</ws:SubstituirNfse>';

    Result := Executar(SoapAction + 'SubstituirNfse', Request,
                       ['SubstituirNfseResult', 'SubstituirNfseResposta'],
                       [NameSpace]);
  end;
end;

function TACBrNFSeXWebserviceSigCorp204.ObterDANFSE(const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceSigCorp204.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  if not StringIsPDF(Result) then
  begin
    Result := ParseText(Result);
    Result := RemoverDeclaracaoXML(Result);
    Result := RemoverCaracteresDesnecessarios(Result);
  end;
end;

{ TACBrNFSeXWebserviceSigCorpAPIPropria }

procedure TACBrNFSeXWebserviceSigCorpAPIPropria.SetHeaders(
  aHeaderReq: THTTPHeader);
var
  Auth, Usuario, Senha, sCNPJ: string;
begin
  Usuario := Trim(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.WSUser);
  if Usuario = '' then
    Usuario := Trim(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.InscMun);
  Senha := Trim(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.WSSenha);
  sCNPJ := OnlyNumber(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.CNPJ);

  // Fallback se o CNPJ não foi informado nas Configurações Gerais, mas existe nota carregada
  if (sCNPJ = '') and Assigned(FPDFeOwner) and (TACBrNFSeX(FPDFeOwner).NotasFiscais.Count > 0) then
    sCNPJ := OnlyNumber(TACBrNFSeX(FPDFeOwner).NotasFiscais.Items[0].NFSe.Prestador.IdentificacaoPrestador.CpfCnpj);

  Auth := 'Basic ' + string(EncodeBase64(AnsiString(Usuario + ':' + Senha)));

  aHeaderReq.AddHeader('Authorization', Auth);
  if sCNPJ <> '' then
    aHeaderReq.AddHeader('X-NFSe-Prestador-CNPJ', sCNPJ);
  if FNumeroNFSe <> '' then
    aHeaderReq.AddHeader('X-NFSe-nNFSe', FNumeroNFSe);
  aHeaderReq.AddHeader('Accept', 'application/json');
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
  PosIni, PosFim: Integer;
begin
  FPMsgOrig := AMSG;
  Request := AMSG;

  // Extrair nDPS do XML para header X-NFSe-nNFSe
  FNumeroNFSe := '';
  PosIni := Pos('<nDPS>', AMSG);
  if PosIni > 0 then
  begin
    PosIni := PosIni + Length('<nDPS>');
    PosFim := Pos('</nDPS>', AMSG);
    if PosFim > PosIni then
      FNumeroNFSe := Trim(Copy(AMSG, PosIni, PosFim - PosIni));
  end;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.RecepcionarSincrono(
  const ACabecalho, AMSG: String): string;
begin
  Result := Recepcionar(ACabecalho, AMSG);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.GerarNFSe(const ACabecalho,
  AMSG: string): string;
begin
  Result := Recepcionar(ACabecalho, AMSG);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.ConsultarLote(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', '', [], []);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.ConsultarNFSePorRps(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', '', [], []);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.ObterDANFSE(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', '', [], []);
end;

function TACBrNFSeXWebserviceSigCorpAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := aXML;
end;

{ TACBrNFSeProviderSigCorpAPIPropria }

procedure TACBrNFSeProviderSigCorpAPIPropria.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    QuebradeLinha := '|';
    ConsultaPorFaixaPreencherNumNfseFinal := True;
    CancPreencherMotivo := True;
    ServicosDisponibilizados.ObterDANFSE := True;
    ModoEnvio := meUnitario;

    // Desativa exigência de certificado mTLS na camada HTTP e ativa autenticação por login/senha
    UseCertificateHTTP := False;
    Autenticacao.RequerCertificado := False;
    Autenticacao.RequerLogin := True;
    UseAuthorizationHeader := True;
  end;

  // Desativa assinaturas digitais no XML (o Sigcorp REST valida via Basic Auth do prestador)
  with ConfigAssinar do
  begin
    Rps := False;
    LoteRps := False;
    CancelarNFSe := False;
    RpsGerarNFSe := False;
    SubstituirNFSe := False;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.04';
    VersaoAtrib := '1.01';
  end;

  with ConfigMsgDados do
  begin
    GerarPrestadorLoteRps := False;
    DadosCabecalho := GetCabecalho('');
  end;

  // Desabilita validação local por XSD ABRASF antigo (o XML gerado é DPS 1.01 Nacional)
  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderSigCorpAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_SigCorpAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorpAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_SigCorpAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSigCorpAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmRecepcionar, tmGerar, tmRecepcionarSincrono] then
  begin
    ConfigGeral.FormatoArqEnvio := tfaXml;
    AMimeType := 'application/xml';
    Method := 'POST';
  end
  else if AMetodo in [tmConsultarLote, tmConsultarSituacao, tmConsultarNFSePorRps, tmConsultarNFSePorChave] then
  begin
    ConfigGeral.FormatoArqEnvio := tfaJson;
    AMimeType := 'application/json';
    Method := 'GET';
    if Path <> '' then
      URL := URL + Path;
  end
  else if AMetodo in [tmObterDANFSE] then
  begin
    ConfigGeral.FormatoArqEnvio := tfaJson;
    AMimeType := 'application/json';
    Method := 'GET';
    if Path <> '' then
      URL := URL + Path;
  end
  else
  begin
    ConfigGeral.FormatoArqEnvio := tfaJson;
    AMimeType := 'application/json';
    Method := 'GET';
  end;

  if URL <> '' then
    Result := TACBrNFSeXWebserviceSigCorpAPIPropria.Create(FAOwner, AMetodo, URL, Method, AMimeType)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Nota: TNotaFiscal;
  I: Integer;
begin
  if TACBrNFSeX(FAOwner).NotasFiscais.Count <= 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod002;
    AErro.Descricao := ACBrStr(Desc002);
    Exit;
  end;

  for I := 0 to TACBrNFSeX(FAOwner).NotasFiscais.Count - 1 do
  begin
    Nota := TACBrNFSeX(FAOwner).NotasFiscais.Items[I];
    Nota.GerarXML;
    Nota.XmlRps := ConverteXMLtoUTF8(Nota.XmlRps);
    Nota.XmlRps := ChangeLineBreak(Nota.XmlRps, '');

    SalvarXmlRps(Nota);

    Response.ArquivoEnvio := Nota.XmlRps;
  end;

  Method := 'POST';
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrJSONObject;
  Protocolo, Msg: string;
  AErro: TNFSeEventoCollectionItem;
  I: Integer;
  ItemObj: TACBrJSONObject;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit;
  end;

  try
    Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);
    try
      if Document <> nil then
      begin
        try
          Protocolo := Document.AsString['protocolo'];
        except
          Protocolo := '';
        end;

        if Protocolo <> '' then
        begin
          Response.Protocolo := Protocolo;
          Response.Sucesso := True;
        end
        else
        begin
          Response.Sucesso := False;
          try
            ProcessarMensagemDeErros(Document, Response, 'erros');
          except
          end;

          if Response.Erros.Count = 0 then
          begin
            if Document.IsJSONArray('message') then
            begin
              for I := 0 to Document.AsJSONArray['message'].Count - 1 do
              begin
                ItemObj := nil;
                try
                  ItemObj := Document.AsJSONArray['message'].ItemAsJSONObject[I];
                except
                  ItemObj := nil;
                end;

                AErro := Response.Erros.New;
                if ItemObj <> nil then
                begin
                  try
                    AErro.Codigo := ItemObj.AsString['codigo_erro'];
                    if AErro.Codigo = '' then
                      AErro.Codigo := ItemObj.AsString['codigo'];
                    if AErro.Codigo = '' then
                      AErro.Codigo := Cod201;

                    AErro.Descricao := ItemObj.AsString['mensagem_erro'];
                    if AErro.Descricao = '' then
                      AErro.Descricao := ItemObj.AsString['descricao'];
                    if AErro.Descricao = '' then
                      AErro.Descricao := ItemObj.AsString['message'];
                  except
                    AErro.Codigo := Cod201;
                    AErro.Descricao := Response.ArquivoRetorno;
                  end;
                end
                else
                begin
                  AErro.Codigo := Cod201;
                  try
                    AErro.Descricao := Document.AsJSONArray['message'].Items[I];
                  except
                    AErro.Descricao := Response.ArquivoRetorno;
                  end;
                end;
              end;
            end
            else
            begin
              try
                Msg := Document.AsString['message'];
              except
                Msg := '';
              end;

              if Msg = '' then
              begin
                try
                  Msg := Document.AsString['mensagem'];
                except
                  Msg := '';
                end;
              end;

              if Msg = '' then
                Msg := Response.ArquivoRetorno;

              AErro := Response.Erros.New;
              AErro.Codigo := Cod201;
              AErro.Descricao := Msg;
            end;
          end;
        end;
      end
      else
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := Response.ArquivoRetorno;
      end;
    finally
      Document.Free;
    end;
  except
    on E: Exception do
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod999;
      AErro.Descricao := ACBrStr(Desc999 + E.Message);
    end;
  end;
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.PrepararConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.Protocolo) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod101;
    AErro.Descricao := ACBrStr(Desc101);
    Exit;
  end;

  Path := '/' + Trim(Response.Protocolo);
  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.TratarRetornoConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  Status, XmlNfse, Link, Chave, Msg: string;
  ANota: TNotaFiscal;
  I: Integer;
  ItemObj: TACBrJSONObject;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit;
  end;

  try
    Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);
    try
      if Document <> nil then
      begin
        try
          Status := LowerCase(Document.AsString['status']);
        except
          Status := '';
        end;
        Response.Situacao := Status;

        try
          XmlNfse := Document.AsString['nfse'];
          if XmlNfse = '' then
            XmlNfse := Document.AsString['xml'];
        except
          XmlNfse := '';
        end;

        try
          Link := Document.AsString['linkImpressao'];
          Chave := Document.AsString['chave'];
        except
          Link := '';
          Chave := '';
        end;

        if (Status = 'aprovado') or (Status = 'autorizado') or (XmlNfse <> '') then
        begin
          Response.Sucesso := True;

          if XmlNfse <> '' then
          begin
            if TACBrNFSeX(FAOwner).NotasFiscais.Count > 0 then
              ANota := TACBrNFSeX(FAOwner).NotasFiscais.Items[0]
            else
              ANota := TACBrNFSeX(FAOwner).NotasFiscais.New;

            ANota.XmlNfse := XmlNfse;
            ANota.LerXML(XmlNfse);

            if Link <> '' then
              ANota.NFSe.Link := Link;
            if Chave <> '' then
              ANota.NFSe.ChaveAcesso := Chave;
          end;
        end
        else if (Status = 'em_processamento') or (Status = 'processando') or (Status = 'aguardando') then
        begin
          Response.Sucesso := True;
          Response.Situacao := 'Lote em processamento';
        end
        else
        begin
          Response.Sucesso := False;
          try
            ProcessarMensagemDeErros(Document, Response, 'erros');
          except
          end;

          if Response.Erros.Count = 0 then
          begin
            if Document.IsJSONArray('message') then
            begin
              for I := 0 to Document.AsJSONArray['message'].Count - 1 do
              begin
                ItemObj := nil;
                try
                  ItemObj := Document.AsJSONArray['message'].ItemAsJSONObject[I];
                except
                  ItemObj := nil;
                end;

                AErro := Response.Erros.New;
                if ItemObj <> nil then
                begin
                  try
                    AErro.Codigo := ItemObj.AsString['codigo_erro'];
                    if AErro.Codigo = '' then
                      AErro.Codigo := ItemObj.AsString['codigo'];
                    if AErro.Codigo = '' then
                      AErro.Codigo := Cod201;

                    AErro.Descricao := ItemObj.AsString['mensagem_erro'];
                    if AErro.Descricao = '' then
                      AErro.Descricao := ItemObj.AsString['descricao'];
                    if AErro.Descricao = '' then
                      AErro.Descricao := ItemObj.AsString['message'];
                  except
                    AErro.Codigo := Cod201;
                    AErro.Descricao := Response.ArquivoRetorno;
                  end;
                end
                else
                begin
                  AErro := Response.Erros.New;
                  AErro.Codigo := Cod201;
                  try
                    AErro.Descricao := Document.AsJSONArray['message'].Items[I];
                  except
                    AErro.Descricao := Response.ArquivoRetorno;
                  end;
                end;
              end;
            end
            else if Document.IsJSONArray('mensagem') then
            begin
              for I := 0 to Document.AsJSONArray['mensagem'].Count - 1 do
              begin
                AErro := Response.Erros.New;
                AErro.Codigo := Cod201;
                try
                  AErro.Descricao := Document.AsJSONArray['mensagem'].Items[I];
                except
                  AErro.Descricao := Response.ArquivoRetorno;
                end;
              end;
            end
            else
            begin
              try
                Msg := Document.AsString['mensagem'];
                if Msg = '' then
                  Msg := Document.AsString['message'];
              except
                Msg := '';
              end;

              if Msg = '' then
                Msg := Response.ArquivoRetorno;

              AErro := Response.Erros.New;
              AErro.Codigo := Cod201;
              AErro.Descricao := Msg;
            end;
          end;
        end;
      end
      else
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := Response.ArquivoRetorno;
      end;
    finally
      Document.Free;
    end;
  except
    on E: Exception do
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod999;
      AErro.Descricao := ACBrStr(Desc999 + E.Message);
    end;
  end;
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.PrepararObterDANFSE(
  Response: TNFSeObterDANFSEResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.ChaveNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod118;
    AErro.Descricao := ACBrStr(Desc118);
    Exit;
  end;

  Path := '/danfse/' + Response.ChaveNFSe;
  Response.Metodo := tmObterDANFSE;
  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.TratarRetornoObterDANFSE(
  Response: TNFSeObterDANFSEResponse);
begin
  if Response.ArquivoRetorno = '' then
  begin
    Response.Erros.New.Descricao := ACBrStr(Desc201);
    Exit;
  end;

  Response.Sucesso := True;
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  JSonLista: TACBrJSONArray;
  JSon: TACBrJSONObject;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo, Descricao, Correcao: string;
  begin
    if JSonItem = nil then
      Exit;

    try
      Codigo := JSonItem.AsString['codigo_erro'];
      if Codigo = '' then
        Codigo := JSonItem.AsString['Codigo'];
      if Codigo = '' then
        Codigo := JSonItem.AsString['codigo'];
    except
      Codigo := '';
    end;

    try
      Descricao := JSonItem.AsString['mensagem_erro'];
      if Descricao = '' then
        Descricao := JSonItem.AsString['Descricao'];
      if Descricao = '' then
        Descricao := JSonItem.AsString['descricao'];
      if Descricao = '' then
        Descricao := JSonItem.AsString['message'];
    except
      Descricao := '';
    end;

    try
      Correcao := JSonItem.AsString['correcao_erro'];
      if Correcao = '' then
        Correcao := JSonItem.AsString['Complemento'];
      if Correcao = '' then
        Correcao := JSonItem.AsString['complemento'];
    except
      Correcao := '';
    end;

    if (Codigo <> '') or (Descricao <> '') then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := Descricao;
      AItem.Correcao := Correcao;
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
    ItemObj: TACBrJSONObject;
    AItem: TNFSeEventoCollectionItem;
  begin
    if jsLista = nil then
      Exit;

    for i := 0 to jsLista.Count-1 do
    begin
      ItemObj := nil;
      try
        ItemObj := jsLista.ItemAsJSONObject[i];
      except
        ItemObj := nil;
      end;

      if ItemObj <> nil then
        AdicionaCollectionItem(ItemObj, Collection)
      else
      begin
        try
          if jsLista.Items[i] <> '' then
          begin
            AItem := Collection.New;
            AItem.Codigo := Cod201;
            AItem.Descricao := jsLista.Items[i];
          end;
        except
        end;
      end;
    end;
  end;

  procedure VerificaSeObjetoOuArray(aNome: string; Collection: TNFSeEventoCollection);
  begin
    if LJson = nil then
      Exit;

    try
      if LJson.IsJSONArray(aNome) then
      begin
        JSonLista := LJson.AsJSONArray[aNome];

        if (JSonLista <> nil) and (JSonLista.Count > 0) then
          LerListaErrosAlertas(JSonLista, Collection);
      end
      else if LJson.IsJSONObject(aNome) then
      begin
        JSon := LJson.AsJSONObject[aNome];

        if JSon <> nil then
          AdicionaCollectionItem(JSon, Collection);
      end;
    except
    end;
  end;
begin
  if LJson = nil then
    Exit;

  // Verifica se no retorno contem a lista de Erros
  VerificaSeObjetoOuArray(AListTag, Response.Erros);
  VerificaSeObjetoOuArray('erros', Response.Erros);
  VerificaSeObjetoOuArray('erro', Response.Erros);
  VerificaSeObjetoOuArray('message', Response.Erros);
  VerificaSeObjetoOuArray('mensagem', Response.Erros);
  VerificaSeObjetoOuArray('Alertas', Response.Alertas);
  VerificaSeObjetoOuArray('alertas', Response.Alertas);
end;

procedure TACBrNFSeProviderSigCorpAPIPropria.ValidarSchema(
  Response: TNFSeWebserviceResponse; aMetodo: TMetodo);
begin
  // No Sigcorp REST, validação de schema é realizada no webservice da prefeitura
  Exit;
end;

function TACBrNFSeProviderSigCorpAPIPropria.RegimeEspecialTributacaoToStr(
  const t: TnfseRegimeEspecialTributacao): string;
begin
  Result := EnumeradoToStr(t,
                         ['0', '1', '2', '3', '4', '5', '6', '9'],
                         [retNenhum, retCooperativa, retEstimativa,
                         retMicroempresaMunicipal, retNotarioRegistrador,
                         retISSQNAutonomos, retSociedadeProfissionais, retOutros]);
end;

function TACBrNFSeProviderSigCorpAPIPropria.StrToRegimeEspecialTributacao(
  out ok: boolean; const s: string): TnfseRegimeEspecialTributacao;
begin
  Result := StrToEnumerado(ok, s,
                        ['0', '1', '2', '3', '4', '5', '6', '9'],
                        [retNenhum, retCooperativa, retEstimativa,
                         retMicroempresaMunicipal, retNotarioRegistrador,
                         retISSQNAutonomos, retSociedadeProfissionais, retOutros]);
end;

end.
