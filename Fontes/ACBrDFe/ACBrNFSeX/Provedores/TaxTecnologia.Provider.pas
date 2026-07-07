{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit TaxTecnologia.Provider;

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
  ACBrNFSeXWebservicesResponse;

type
  TACBrNFSeXWebserviceTaxTecnologia204 = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetNameSpace: string;
    function GetSoapAction: string;
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

    function TratarXmlRetornado(const aXML: string): string; override;

    property NameSpace: string read GetNameSpace;
    property SoapAction: string read GetSoapAction;
  end;

  TACBrNFSeProviderTaxTecnologia204 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;
  public
    function GetSchemaPath: string; override;

    function ResponsavelRetencaoToStr(const t: TnfseResponsavelRetencao): string; override;
    function StrToResponsavelRetencao(out ok: boolean; const s: string): TnfseResponsavelRetencao; override;
    function ResponsavelRetencaoDescricao(const t: TnfseResponsavelRetencao): string; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  TaxTecnologia.GravarXml,
  TaxTecnologia.LerXml;

{ TACBrNFSeProviderTaxTecnologia204 }

procedure TACBrNFSeProviderTaxTecnologia204.Configuracao;
var
  FpURL: string;
begin
  inherited Configuracao;

  ConfigGeral.UseCertificateHTTP := False;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.04';
    VersaoAtrib := '204';
  end;

  ConfigAssinar.CancelarNFSe := False;
  ConfigMsgDados.GerarPrestadorLoteRps := True;

  if ConfigGeral.Params.TemParametro('GerarGrupoIBSCBS') then
    FpURL := 'http://www.abrasf.org.br/nfse.xsd'
  else
  begin
    if FAOwner.Configuracoes.WebServices.AmbienteCodigo = 1 then
      FpURL := ConfigWebServices.Producao.XMLNameSpace
    else
      FpURL := ConfigWebServices.Homologacao.XMLNameSpace;
  end;

  ConfigMsgDados.DadosCabecalho := GetCabecalho(FpURL);

  if ConfigGeral.Params.TemParametro('GerarGrupoIBSCBS') then
  begin
    SetXmlNameSpace(FpURL);
    SetNomeXSD('nfse.xsd');
  end
  else
  begin
    SetXmlNameSpace(FpURL);
    SetNomeXSD('nfse_v204.xsd');
  end;
end;

function TACBrNFSeProviderTaxTecnologia204.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_TaxTecnologia204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTaxTecnologia204.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_TaxTecnologia204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTaxTecnologia204.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceTaxTecnologia204.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderTaxTecnologia204.GetSchemaPath: string;
begin
  Result := inherited GetSchemaPath;

  if not ConfigGeral.Params.TemParametro('GerarGrupoIBSCBS') then
    Result := PathWithDelim(Result + ConfigGeral.CodIBGE);

  if ConfigGeral.Ambiente = taProducao then
    Result := Result + '\Producao'
  else
    Result := Result + '\Homologacao';

end;

procedure TACBrNFSeProviderTaxTecnologia204.GerarMsgDadosCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;

  with Params do
  begin
    Response.ArquivoEnvio :=
      '<' + Prefixo + 'CancelarNfseEnvio' + NameSpace + '>' +
        '<' + Prefixo2 + 'Pedido>' +
          '<' + Prefixo2 + 'InfPedidoCancelamento' + {IdAttr +} '>' +
            '<' + Prefixo2 + 'IdentificacaoNfse>' +
              '<' + Prefixo2 + 'Numero>' +
                 InfoCanc.NumeroNFSe +
              '</' + Prefixo2 + 'Numero>' +
              Serie +
              '<' + Prefixo2 + 'CpfCnpj>' +
                GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
              '</' + Prefixo2 + 'CpfCnpj>' +
              GetInscMunic(Emitente.InscMun, Prefixo2) +
              '<' + Prefixo2 + 'CodigoMunicipio>' +
                 IntToStr(TACBrNFSeX(FAOwner).Configuracoes.Geral.CodigoMunicipio) +
              '</' + Prefixo2 + 'CodigoMunicipio>' +
              CodigoVerificacao +
            '</' + Prefixo2 + 'IdentificacaoNfse>' +
            '<' + Prefixo2 + 'CodigoCancelamento>' +
               InfoCanc.CodCancelamento +
            '</' + Prefixo2 + 'CodigoCancelamento>' +
            Motivo +
          '</' + Prefixo2 + 'InfPedidoCancelamento>' +
        '</' + Prefixo2 + 'Pedido>' +
      '</' + Prefixo + 'CancelarNfseEnvio>';
  end;
end;

function TACBrNFSeProviderTaxTecnologia204.ResponsavelRetencaoDescricao(
  const t: TnfseResponsavelRetencao): string;
begin
  case t of
    rtTomador : Result := '1 - Tomador';
    rtPrestador : Result := '2 - Prestador';
  else
    Result := '';
  end;
end;

function TACBrNFSeProviderTaxTecnologia204.ResponsavelRetencaoToStr(
  const t: TnfseResponsavelRetencao): string;
begin
  Result := EnumeradoToStr(t,
                           ['1', '2', '', ''],
                           [rtTomador, rtPrestador, rtIntermediario, rtNenhum]);
end;

function TACBrNFSeProviderTaxTecnologia204.StrToResponsavelRetencao(
  out ok: boolean; const s: string): TnfseResponsavelRetencao;
begin
  Result := StrToEnumerado(ok, s,
                           ['1', '2', ''],
                           [rtTomador, rtPrestador, rtNenhum]);
end;

{ TACBrNFSeXWebserviceTaxTecnologia204 }

function TACBrNFSeXWebserviceTaxTecnologia204.GetNameSpace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 2 then
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Homologacao.NameSpace
  else
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Producao.NameSpace;

  Result := 'xmlns:ns1="' + Result + '"';
end;

function TACBrNFSeXWebserviceTaxTecnologia204.GetSoapAction: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 2 then
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Homologacao.SoapAction
  else
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Producao.SoapAction;
end;

function TACBrNFSeXWebserviceTaxTecnologia204.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:RecepcionarLoteRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:RecepcionarLoteRpsRequest>';

  Result := Executar(SoapAction + 'RecepcionarLoteRps', Request,
                     ['outputXML', 'EnviarLoteRpsResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:RecepcionarLoteRpsSincronoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:RecepcionarLoteRpsSincronoRequest>';

  Result := Executar(SoapAction + 'RecepcionarLoteRpsSincrono', Request,
                     ['outputXML', 'EnviarLoteRpsSincronoResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:GerarNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:GerarNfseRequest>';

  Result := Executar(SoapAction + 'GerarNfse', Request,
                     ['outputXML', 'GerarNfseResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:ConsultarLoteRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:ConsultarLoteRpsRequest>';

  Result := Executar(SoapAction + 'ConsultarLoteRps', Request,
                     ['outputXML', 'ConsultarLoteRpsResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:ConsultarNfsePorFaixaRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:ConsultarNfsePorFaixaRequest>';

  Result := Executar(SoapAction + 'ConsultarNfsePorFaixa', Request,
                     ['outputXML', 'ConsultarNfseFaixaResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:ConsultarNfsePorRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:ConsultarNfsePorRpsRequest>';

  Result := Executar(SoapAction + 'ConsultarNfsePorRps', Request,
                     ['outputXML', 'ConsultarNfseRpsResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:ConsultarNfseServicoPrestadoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:ConsultarNfseServicoPrestadoRequest>';

  Result := Executar(SoapAction + 'ConsultarNfseServicoPrestado', Request,
                     ['outputXML', 'ConsultarNfseServicoPrestadoResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:ConsultarNfseServicoTomadoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:ConsultarNfseServicoTomadoRequest>';

  Result := Executar(SoapAction + 'ConsultarNfseServicoTomado', Request,
                     ['outputXML', 'ConsultarNfseServicoTomadoResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:CancelarNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:CancelarNfseRequest>';

  Result := Executar(SoapAction + 'CancelarNfse', Request,
                     ['outputXML', 'CancelarNfseResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ns1:SubstituirNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</ns1:SubstituirNfseRequest>';

  Result := Executar(SoapAction + 'SubstituirNfse', Request,
                     ['outputXML', 'SubstituirNfseResposta'],
                     [NameSpace]);
end;

function TACBrNFSeXWebserviceTaxTecnologia204.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(AnsiString(Result));
  Result := RemoverDeclaracaoXML(Result);
end;

end.
