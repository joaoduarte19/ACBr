{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit SpeedGov.Provider;

interface

uses
  SysUtils, Classes,
  ACBrBase,
  ACBrJson,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrDFeSSL,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXWebservicesResponse,
  ACBrNFSeXProviderABRASFv1,
  ACBrNFSeXWebserviceBase,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceSpeedGov = class(TACBrNFSeXWebserviceSoap11)
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderSpeedGov = class (TACBrNFSeProviderABRASFv1)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure GerarMsgDadosEmitir(Response: TNFSeEmiteResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaSituacao(Response: TNFSeConsultaSituacaoResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse;
      Params: TNFSeParamsResponse); override;

    procedure PrepararConsultaNFSe(Response: TNFSeConsultaNFSeResponse); override;
    procedure GerarMsgDadosConsultaNFSe(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;
  public
    function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao): string; override;
    function StrToRegimeEspecialTributacao(out ok: boolean; const s: string): TnfseRegimeEspecialTributacao; override;
  end;

  TACBrNFSeXWebserviceSpeedGovAPIPropria = class(TACBrNFSeXWebservicePadraoNacional)
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;
  public
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderSpeedGovAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;
    procedure TratarRetornoConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;

    procedure PrepararEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
    procedure TratarRetornoEnviarEvento(Response: TNFSeEnviarEventoResponse); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'Erros'); override;
  public
    function GetSchemaPath: string; override;
  end;

implementation

uses
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrDFe.Conversao,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  ACBrNFSeXNotasFiscais,
  SpeedGov.GravarXml,
  SpeedGov.LerXml;

{ TACBrNFSeXWebserviceSpeedGov }

function TACBrNFSeXWebserviceSpeedGov.Recepcionar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:RecepcionarLoteRps>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:RecepcionarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'RecepcionarLoteRpsResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.ConsultarLote(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarLoteRps>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:ConsultarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarLoteRpsResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.ConsultarSituacao(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarSituacaoLoteRps>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:ConsultarSituacaoLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarSituacaoLoteRpsResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.ConsultarNFSePorRps(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfsePorRps>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:ConsultarNfsePorRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseRpsResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.ConsultarNFSe(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfse>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:ConsultarNfse>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:CancelarNfse>';
  Request := Request + '<header>' + IncluirCDATA(ACabecalho) + '</header>';
  Request := Request + '<parameters>' + IncluirCDATA(AMSG) + '</parameters>';
  Request := Request + '</nfse:CancelarNfse>';

  Result := Executar('', Request,
                     ['return', 'CancelarNfseResposta'],
                     ['xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"']);
end;

function TACBrNFSeXWebserviceSpeedGov.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
end;

{ TACBrNFSeProviderSpeedGov }

procedure TACBrNFSeProviderSpeedGov.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.UseCertificateHTTP := False;

  with ConfigMsgDados do
  begin
    GerarNSLoteRps := True;
    //Prefixo := 'p';
    //PrefixoTS := 'p1';

    //XmlRps.xmlns := 'http://ws.speedgov.com.br/tipos_v1.xsd';

    LoteRps.xmlns := 'http://ws.speedgov.com.br/enviar_lote_rps_envio_v1.xsd';

    ConsultarSituacao.xmlns := 'http://ws.speedgov.com.br/consultar_situacao_lote_rps_envio_v1.xsd';

    ConsultarLote.xmlns := 'http://ws.speedgov.com.br/consultar_lote_rps_envio_v1.xsd';

    ConsultarNfseRps.xmlns := 'http://ws.speedgov.com.br/consultar_nfse_rps_envio_v1.xsd';

    ConsultarNfse.xmlns := 'http://ws.speedgov.com.br/consultar_nfse_envio_v1.xsd';

    CancelarNfse.xmlns := 'http://ws.speedgov.com.br/cancelar_nfse_envio_v1.xsd';

    DadosCabecalho := '<cabecalho xmlns="http://ws.speedgov.com.br/cabecalho_v1.xsd" versao="1">' +
                      '<versaoDados xmlns="">1</versaoDados>' +
                      '</cabecalho>';
  end;

  with ConfigGeral do
  begin
    Particularidades.AtendeReformaTributaria := True;
  end;

  SetNomeXSD('***');

  with ConfigSchemas do
  begin
    Recepcionar := 'enviar_lote_rps_envio_v1.xsd';
    ConsultarSituacao := 'consultar_situacao_lote_rps_envio_v1.xsd';
    ConsultarLote := 'consultar_lote_rps_envio_v1.xsd';
    ConsultarNFSeRps := 'consultar_nfse_rps_envio_v1.xsd';
    ConsultarNFSe := 'consultar_nfse_envio_v1.xsd';
    CancelarNFSe := 'cancelar_nfse_envio_v1.xsd';
  end;

  with ConfigAssinar do
  begin
    Rps := False;
    LoteRps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
    RpsSubstituirNFSe := True;
    SubstituirNFSe := True;
  end;
end;

function TACBrNFSeProviderSpeedGov.CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_SpeedGov.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSpeedGov.CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_SpeedGov.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSpeedGov.CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceSpeedGov.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;

  with Params do
  begin
    NameSpace2 := ' xmlns=""';
    Response.ArquivoEnvio := '<' + Prefixo + 'CancelarNfseEnvio' + NameSpace + '>' +
                           '<' + Prefixo + 'Pedido' + Params.NameSpace2 + '>' +
                             '<' + Prefixo2 + 'InfPedidoCancelamento' + IdAttr + '>' +
                               '<' + Prefixo2 + 'IdentificacaoNfse>' +
                                 '<' + Prefixo2 + 'Numero>' +
                                   InfoCanc.NumeroNFSe +
                                 '</' + Prefixo2 + 'Numero>' +
                                 '<' + Prefixo2 + 'Cnpj>' +
                                   OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                                 '</' + Prefixo2 + 'Cnpj>' +
                                 GetInscMunic(Emitente.InscMun, Prefixo2) +
                                 '<' + Prefixo2 + 'CodigoMunicipio>' +
                                    ConfigGeral.CodIBGE +
                                 '</' + Prefixo2 + 'CodigoMunicipio>' +
                               '</' + Prefixo2 + 'IdentificacaoNfse>' +
                               '<' + Prefixo2 + 'CodigoCancelamento>' +
                                  InfoCanc.CodCancelamento +
                               '</' + Prefixo2 + 'CodigoCancelamento>' +
                               Motivo +
                             '</' + Prefixo2 + 'InfPedidoCancelamento>' +
                           '</' + Prefixo + 'Pedido>' +
                         '</' + Prefixo + 'CancelarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    NameSpace := Params.NameSpace + ' xmlns:tipos="http://ws.speedgov.com.br/tipos_v1.xsd"';
    NameSpace2 := ' xmlns=""';
    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarLoteRpsEnvio' + NameSpace + '>' +
                           '<' + Prefixo + 'Prestador' + NameSpace2 + '>' +
                             '<' + Prefixo2 + 'Cnpj>' +
                               OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                             '</' + Prefixo2 + 'Cnpj>' +
                             GetInscMunic(Emitente.InscMun, Prefixo2) +
                           '</' + Prefixo + 'Prestador>' +
                           '<' + Prefixo + 'Protocolo'+ NameSpace2 +'>' +
                             Response.Protocolo +
                           '</' + Prefixo + 'Protocolo>' +
                         '</' + Prefixo + 'ConsultarLoteRpsEnvio>';
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosConsultaNFSe(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Response.ArquivoEnvio := '<'+ TagEnvio + NameSpace + '>' +
                           '<Prestador'+ NameSpace2 + '>' +
                             '<Cnpj>' +
                               OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                             '</Cnpj>' +
                             GetInscMunic(Emitente.InscMun, '') +
                           '</Prestador>' +
                           Xml +
                         '</'+ TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosConsultaporRps(
  Response: TNFSeConsultaNFSeporRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    NameSpace2 := ' xmlns=""';
    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                           '<' + Prefixo + 'IdentificacaoRps' + Params.NameSpace2 + '>' +
                             '<' + Prefixo2 + 'Numero>' +
                               Response.NumeroRps +
                             '</' + Prefixo2 + 'Numero>' +
                             '<' + Prefixo2 + 'Serie>' +
                               Response.SerieRps +
                             '</' + Prefixo2 + 'Serie>' +
                             '<' + Prefixo2 + 'Tipo>' +
                               Response.TipoRps +
                             '</' + Prefixo2 + 'Tipo>' +
                           '</' + Prefixo + 'IdentificacaoRps>' +
                           '<' + Prefixo + 'Prestador' + Params.NameSpace2  + '>' +
                             '<' + Prefixo2 + 'Cnpj>' +
                               OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                             '</' + Prefixo2 + 'Cnpj>' +
                             GetInscMunic(Emitente.InscMun, Prefixo2) +
                           '</' + Prefixo + 'Prestador>' +
                         '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    NameSpace := Params.NameSpace + ' xmlns:tipos="http://ws.speedgov.com.br/tipos_v1.xsd"';
    NameSpace2 := ' xmlns=""';
    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarSituacaoLoteRpsEnvio' + NameSpace + '>' +
                           '<' + Prefixo + 'Prestador' + NameSpace2 + '>' +
                             '<' + Prefixo2 + 'Cnpj>' +
                               OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                             '</' + Prefixo2 + 'Cnpj>' +
                             GetInscMunic(Emitente.InscMun, Prefixo2) +
                           '</' + Prefixo + 'Prestador>' +
                           '<' + Prefixo + 'Protocolo'+ NameSpace2 +'>' +
                             Response.Protocolo +
                           '</' + Prefixo + 'Protocolo>' +
                         '</' + Prefixo + 'ConsultarSituacaoLoteRpsEnvio>';
  end;
end;

procedure TACBrNFSeProviderSpeedGov.GerarMsgDadosEmitir(
  Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse);
begin
  Params.NameSpace2 := ' xmlns=""';
  inherited GerarMsgDadosEmitir(Response, Params);
end;

procedure TACBrNFSeProviderSpeedGov.PrepararConsultaNFSe(
  Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  XmlConsulta, RazaoInter: string;
begin
  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;

    case Response.InfConsultaNFSe.tpConsulta of
      tcPorFaixa: Response.Metodo := tmConsultarNFSePorFaixa;
      tcServicoTomado: Response.Metodo := tmConsultarNFSeServicoTomado;
      tcServicoPrestado: Response.Metodo := tmConsultarNFSeServicoPrestado;
      tcPorChave: Response.Metodo := tmConsultarNFSePorChave;
    else
      Response.Metodo := tmConsultarNFSe;
    end;

    if Response.InfConsultaNFSe.tpConsulta in [tcPorFaixa, tcServicoTomado,
       tcServicoPrestado, tcPorChave, tcPorCodigoVerificacao] then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod001;
      AErro.Descricao := ACBrStr(Desc001);
      Exit;
    end;

    aParams.Prefixo := '';
    aParams.Prefixo2 := '';
    aParams.NameSpace2 := ' xmlns=""';

    if EstaVazio(ConfigMsgDados.ConsultarNFSe.xmlns) then
      aParams.NameSpace := ''
    else
    begin
      if ConfigMsgDados.Prefixo = '' then
        aParams.NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSe.xmlns + '"'
      else
      begin
        aParams.NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarNFSe.xmlns + '"';
        aParams.Prefixo := ConfigMsgDados.Prefixo + ':';
      end;
    end;

    if ConfigMsgDados.XmlRps.xmlns <> '' then
    begin
      if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarNFSe.xmlns) and
         ((ConfigMsgDados.Prefixo <> '') or (ConfigMsgDados.PrefixoTS <> '')) then
      begin
        if ConfigMsgDados.PrefixoTS = '' then
          aParams.NameSpace := aParams.NameSpace + ' xmlns="' + ConfigMsgDados.XmlRps.xmlns + '"'
        else
        begin
          aParams.NameSpace := aParams.NameSpace+ ' xmlns:' + ConfigMsgDados.PrefixoTS + '="' +
                                              ConfigMsgDados.XmlRps.xmlns + '"';
        end;
      end
      else
      begin
        if ConfigMsgDados.PrefixoTS <> '' then
          aParams.Prefixo2 := ConfigMsgDados.PrefixoTS + ':';
      end;
    end;
    aParams.NameSpace := aParams.NameSpace + ' xmlns:tipos="http://ws.speedgov.com.br/tipos_v1.xsd"';

    if OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) <> '' then
      XmlConsulta := '<NumeroNfse'+ aParams.NameSpace2 + '>' +
                        OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) +
                     '</NumeroNfse>'
    else
      XmlConsulta := '';

    if (Response.InfConsultaNFSe.DataInicial > 0) and (Response.InfConsultaNFSe.DataFinal > 0) then
      XmlConsulta := XmlConsulta +
                       '<PeriodoEmissao' + aParams.NameSpace2 + '>' +
                         '<DataInicial>' +
                            FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataInicial) +
                         '</DataInicial>' +
                         '<DataFinal>' +
                            FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataFinal) +
                         '</DataFinal>' +
                       '</PeriodoEmissao>';

    if NaoEstaVazio(Response.InfConsultaNFSe.CNPJTomador) then
    begin
      XmlConsulta := XmlConsulta +
                       '<Tomador' + aParams.NameSpace2 + '>' +
                         '<CpfCnpj>' +
                            GetCpfCnpj(Response.InfConsultaNFSe.CNPJTomador, '') +
                         '</CpfCnpj>' +
                         GetInscMunic(Response.InfConsultaNFSe.IMTomador, '') +
                       '</Tomador>';
    end;

    if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJInter) then
    begin
      if NaoEstaVazio(Response.InfConsultaNFSe.RazaoInter) then
        RazaoInter := '<RazaoSocial>' +
                         OnlyNumber(Response.InfConsultaNFSe.RazaoInter) +
                      '</RazaoSocial>'
      else
        RazaoInter := '';

      XmlConsulta := XmlConsulta +
                       '<IntermediarioServico' +  aParams.NameSpace2 + '>' +
                         RazaoInter +
                         '<CpfCnpj>' +
                            GetCpfCnpj(Response.InfConsultaNFSe.CNPJInter, '') +
                         '</CpfCnpj>' +
                         GetInscMunic(Response.InfConsultaNFSe.IMInter, '') +
                       '</IntermediarioServico>';
    end;

    aParams.TagEnvio := ConfigMsgDados.ConsultarNFSe.DocElemento;

    GerarMsgDadosConsultaNFSe(Response, aParams);
  finally
    aParams.Free;
  end;
end;

function TACBrNFSeProviderSpeedGov.RegimeEspecialTributacaoToStr(
  const t: TnfseRegimeEspecialTributacao): string;
begin
  Result := EnumeradoToStr(t,
                         ['0', '1', '2', '3', '4', '5', '6'],
                         [retNenhum, retMicroempresaMunicipal, retEstimativa,
                         retSociedadeProfissionais, retCooperativa,
                         retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

function TACBrNFSeProviderSpeedGov.StrToRegimeEspecialTributacao(
  out ok: boolean; const s: string): TnfseRegimeEspecialTributacao;
begin
  Result := StrToEnumerado(ok, s,
                        ['0', '1', '2', '3', '4', '5', '6'],
                        [retNenhum, retMicroempresaMunicipal, retEstimativa,
                         retSociedadeProfissionais, retCooperativa,
                         retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

{ TACBrNFSeXWebserviceSpeedGovAPIPropria }

function TACBrNFSeXWebserviceSpeedGovAPIPropria.ConsultarSituacao(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

procedure TACBrNFSeXWebserviceSpeedGovAPIPropria.SetHeaders(
  aHeaderReq: THTTPHeader);
var
  lDFeSSL: TDFeSSL;
  lBody, lAssinaturaEvt: AnsiString;
begin
  inherited SetHeaders(aHeaderReq);
  if Metodo = tmEnviarEvento then
  begin
    lBody := TACBrNFSeX(FPDFeOwner).WebService.EnviarEvento.ArquivoEnvio;
    lDFeSSL := TACBrNFSeX(FPDFeOWner).SSL;
    lAssinaturaEvt := lDFeSSL.GerarCMSDestacado(lBody);
    aHeaderReq.AddHeader('X-Evento-Assinatura', lAssinaturaEvt);
  end;

  ReqHeaders := aHeaderReq.Text;
end;

function TACBrNFSeXWebserviceSpeedGovAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
var
  lJSON, lErroJSON: TACBrJSONObject;
  lJSONArray: TACBrJSONArray;
  LMsg: string;
  i, j: Integer;
begin
  Result := inherited TratarXmlRetornado(aXML);

  if Pos('{"Message"', Result) > 0 then
  begin
    i := Pos('":"', Result) + 3;
    j := Pos('"}', Result);
    LMsg := Copy(Result, i, j-i);

    lJSON := TACBrJSONObject.Create;
    try
      lJSONArray := TACBrJSONArray.Create;
      try
        lErroJSON := TACBrJSONObject.Create;
        try
          lJSON.AddPair('tipoAmbiente', EmptyStr);
          lJSON.AddPair('versaoAplicativo', EmptyStr);
          lJSON.AddPair('dataHoraProcessamento', EmptyStr);
          lJSON.AddPair('idDps', EmptyStr);
          lJSON.AddPair('chaveAcesso', EmptyStr);
          lJSON.AddPair('nfseXmlGZipB64', EmptyStr);

          lErroJSON.AddPair('mensagem', EmptyStr);
          lErroJSON.AddPair('codigo', 'E9999');
          lErroJSON.AddPair('descricao', LMsg);
          lErroJSON.AddPair('complemento', '');

          lJSONArray.AddElementJSON(lErroJSON);
          lJSON.AddPair('erros', lJSONArray, False);

          Result := lJSON.ToJSON;
        finally
          //lErroJSON.Free;
        end;
      finally
        //lJSONArray.Free;
      end;
    finally
      lJSON.Free;
    end;
  end;
end;

{ TACBrNFSeProviderSpeedGovAPIPropria }

procedure TACBrNFSeProviderSpeedGovAPIPropria.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.ServicosDisponibilizados.ConsultarSituacao := True;
  ConfigAssinar.EnviarEvento := False;
  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderSpeedGovAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_SpeedGovAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSpeedGovAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_SpeedGovAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderSpeedGovAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmGerar] then
    AMimeType := 'application/xml; charset=utf-8'
  else
    AMimeType := 'application/json';

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceSpeedGovAPIPropria.Create(FAOwner, AMetodo, URL,
      Method, AMimeType);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderSpeedGovAPIPropria.GetSchemaPath: string;
begin
  {
    Usar essa função até que o provedor faça alteração e passa a usar os novos
    Schemas publicados pela Receita Federal.
  }
  with TACBrNFSeX(FAOwner).Configuracoes do
  begin
    if Geral.APIPropria then
      Result := PathWithDelim(Arquivos.PathSchemas + 'PadraoNacional')
    else
      Result := PathWithDelim(Arquivos.PathSchemas + Geral.xProvedor);

    Result := PathWithDelim(Result + VersaoNFSeToStr(Geral.Versao));
  end;
end;

function TACBrNFSeProviderSpeedGovAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;

  if aMetodo in [tmGerar, tmEnviarEvento] then
  begin
    Result := ChangeLineBreak(aXml, '');

    case aMetodo of
      tmGerar:
        begin
          Path := '/v101';
        end;

      tmEnviarEvento:
        begin
          Path := '/' + EnviarEventoResponse.InfEvento.pedRegEvento.chNFSe + '/eventos';
        end;
    else
      begin
        Result := '';
        Path := '';
      end;
    end;

    Method := 'POST';
  end;
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  lJSONArray: TACBrJSONArray;
  lJSONObj, lAuxJSONObj: TACBrJSONObject;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo: string;
  begin
    if not(Assigned(JsonItem)) then
      exit;
    Codigo := JSonItem.AsString['codigo_erro'];
    if Trim(Codigo) = '' then
      Codigo := JSonItem.AsString['codigo'];

    if Codigo <> '' then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := JSonItem.AsString['mensagem'];
      if AItem.Descricao = '' then
        AItem.Descricao := JSonItem.AsString['descricao'];
      AItem.Correcao := JSonItem.AsString['detalhes'];
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
    Json: TACBrJSONObject;
  begin
    for i := 0 to jsLista.Count-1 do
    begin
      JSon := jsLista.ItemAsJSONObject[i];

      AdicionaCollectionItem(JSon, Collection);
    end;
  end;

begin
  //Quando JSON de retorno vem sem elemento raiz e o erro no corpo
  AdicionaCollectionItem(LJSON, Response.Erros);
  if Response.Erros.Count > 0 then
    exit;

  //Quando JSON de retorno vem sem elemento raiz e um elemento "erro" no corpo
  if LJSON.IsJSONObject('erro') then
  begin
    lJSONObj := LJSON.AsJSONObject['erro'];
    AdicionaCollectionItem(lJSONObj, Response.Erros);
    if Response.Erros.Count > 0 then
      exit;
  end;

  //Quando JSON de retorno vem sem elemento raiz e um elemento "erros" no corpo
  if LJSON.IsJSONArray('erros') then
  begin
    lJSONArray := LJSON.AsJSONArray['erros'];
    LerListaErrosAlertas(lJSONArray, Response.Erros);
    if Response.Erros.Count > 0 then
      exit;
  end;

  //Quando JSON de retorno vem com elemento raiz e um elemento no corpo
  if LJSON.IsJSONObject('Erros') then
  begin
    lJSONObj := LJSON.AsJSONObject['Erros'];
    AdicionaCollectionItem(lJSONObj, Response.Erros);

    //Elemento do corpo "erros" ou "erro"
    if lJSONObj.IsJSONObject('erro') then
    begin
      lAuxJSONObj := lJSONObj.AsJSONObject['erro'];
      AdicionaCollectionItem(lAuxJSONObj, Response.Erros);
    end else if lJSONObj.IsJSONArray('erros') then
    begin
      lJSONArray := lJSONObj.AsJSONArray['erros'];
      LerListaErrosAlertas(lJSONArray, Response.Erros);
    end;
  end;
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  lDocument: TACBrJSONObject;
  lResumo: TNFSeResumoCollectionItem;
begin
  if Pos('codigo_erro', Response.ArquivoRetorno) > 0 then
  begin
    Response.ArquivoRetorno := '{"Erros":' + Response.ArquivoRetorno + '}';
  end;

  inherited TratarRetornoEmitir(Response);

  if Response.Erros.Count > 0 then
    exit;

  lDocument := TACBrJsonObject.Parse(Response.ArquivoRetorno);
  try
    Response.Protocolo := lDocument.AsString['numero_protocolo'];
    Response.idNota := lDocument.AsString['chave_acesso'];
    Response.NumeroNota := lDocument.AsString['numero_nota'];
    Response.Situacao := lDocument.AsString['status_nota'];
    Response.DescSituacao := lDocument.AsString['mensagem'];

    if Response.DescSituacao <> EmptyStr then
    begin
      lResumo := Response.Resumos.New;
      lResumo.NumeroNota := Response.NumeroNota;
      lResumo.Situacao := Response.Situacao;
      lResumo.DescSituacao := Response.DescSituacao;
      lResumo.Protocolo := Response.Protocolo;
      lResumo.idNota := Response.idNota;
    end;

  finally
    FreeAndNil(lDocument);
  end;
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.TratarRetornoEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  lDocument: TACBrJSONObject;
  lResumo: TNFSeResumoCollectionItem;
begin
  inherited TratarRetornoEnviarEvento(Response);
  if Response.Erros.Count > 0 then
    exit;

  lDocument := TACBrJSONObject.Parse(Response.ArquivoRetorno);
  try
    Response.Protocolo := lDocument.AsString['numero_protocolo'];
    Response.idEvento := lDocument.AsString['id_evento'];
    Response.nSeqEvento := lDocument.AsInteger['numero_sequencial'];
    Response.Data := lDocument.AsISODateTime['data_hora_evento'];
    Response.Situacao := lDocument.AsString['status_evento'];
    Response.DescSituacao := lDocument.AsString['mensagem'];

    if Response.DescSituacao <> EmptyStr then
    begin
      lResumo := Response.Resumos.New;
      lResumo.Protocolo := Response.Protocolo;
      lResumo.idEvento := Response.idEvento;
      lResumo.nSeqEvento := Response.nSeqEvento;
      lResumo.Data := Response.Data;
      lResumo.Situacao := Response.Situacao;
      lResumo.DescSituacao := Response.DescSituacao;
    end;
  finally
    FreeAndNil(lDocument);
  end;
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.PrepararConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
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

  Path := '/protocolo/' + Response.Protocolo;
  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.PrepararEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  AErro: TNFSeEventoCollectionItem;
  lJSONObj: TACBrJSONObject;
  lcCanc: String;
begin
  if Response.InfEvento.pedRegEvento.cMotivo <= 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod109;
    AErro.Descricao := ACBrStr(Desc109);
  end;
  if Response.InfEvento.pedRegEvento.xMotivo = EmptyStr then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod110;
    AErro.Descricao := ACBrStr(Desc110);
  end;
  if Response.InfEvento.pedRegEvento.chNFSe = EmptyStr then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod118;
    AErro.Descricao := ACBrStr(Desc118);
  end;

  if Response.Erros.Count > 0 then Exit;

  lJSONObj := TACBrJSONObject.Create;
  try
    case Response.InfEvento.pedRegEvento.cMotivo of
      1: lcCanc := 'erro_na_emissao';
      2: lcCanc := 'servico_nao_prestado';
      else lcCanc := 'outros';
    end;

    lJSONObj.AddPair('tipo_evento', 'cancelamento');
    lJSONObj.AddPair('codigo_motivo_cancelamento', lcCanc);
    lJSONObj.AddPair('descricao_motivo_cancelamento', Response.InfEvento.pedRegEvento.xMotivo);

    Response.ArquivoEnvio := lJSONObj.ToJSON;
  finally
    lJSONObj.Free;
  end;
end;

procedure TACBrNFSeProviderSpeedGovAPIPropria.TratarRetornoConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  if Pos('codigo_erro', Response.ArquivoRetorno) > 0 then
  begin
    Response.ArquivoRetorno := '{"Erros":' + Response.ArquivoRetorno + '}';
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['chaveAcesso'];

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

end.
