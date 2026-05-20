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

unit BWSistemas.Provider;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebservicesResponse,
  ACBrNFSeXWebserviceBase;

type
  TACBrNFSeXWebserviceBWSistemas200 = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetDadosUsuario: string;
  public
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;

    property DadosUsuario: string read GetDadosUsuario;
  end;

  TACBrNFSeProviderBWSistemas200 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure GerarMsgDadosEmitir(Response: TNFSeEmiteResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;
  public
    function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao): string; override;
    function StrToRegimeEspecialTributacao(out ok: boolean; const s: string): TnfseRegimeEspecialTributacao; override;
  end;

implementation

uses
  ACBrUtil.XMLHTML,
  ACBrDFeException,
  ACBrNFSeX,
  BWSistemas.GravarXml,
  BWSistemas.LerXml;

{ TACBrNFSeProviderBWSistemas200 }

procedure TACBrNFSeProviderBWSistemas200.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    ServicosDisponibilizados.EnviarLoteAssincrono := False;
    ServicosDisponibilizados.EnviarLoteSincrono := False;
    ServicosDisponibilizados.EnviarUnitario := True;
    ServicosDisponibilizados.ConsultarFaixaNfse := True;
    ServicosDisponibilizados.ConsultarRps := True;
    {
    UseCertificateHTTP := True;
    UseAuthorizationHeader := False;
    NumMaxRpsGerar  := 1;
    NumMaxRpsEnviar := 50;

    TabServicosExt := False;
    Identificador := 'Id';
    QuebradeLinha := ';';
    }
    // meLoteAssincrono, meLoteSincrono ou meUnitario
    ModoEnvio := meUnitario;
    ConsultaLote := False;
    {
    ConsultaSitLote := False;
    ConsultaNFSe := True;

    ConsultaPorFaixa := True;
    ConsultaPorFaixaPreencherNumNfseFinal := False;

    CancPreencherMotivo := False;
    CancPreencherSerieNfse := False;
    CancPreencherCodVerificacao := False;
    }
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.00';
    VersaoAtrib := '2.00';
    AtribVerLote := 'versao';
  end;

  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderBWSistemas200.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_BWSistemas200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderBWSistemas200.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_BWSistemas200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderBWSistemas200.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceBWSistemas200.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderBWSistemas200.GerarMsgDadosEmitir(
  Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse);
var
  lEmitente: TEmitenteConfNFSe;
begin
  lEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  Response.ArquivoEnvio :=
    '<' + Params.Prefixo + Params.TagEnvio + '>' +
      '<Credenciais>' +
        '<UserName>' + lEmitente.WSUser + '</UserName>' +
        '<Password>' + lEmitente.WSSenha + '</Password>' +
      '</Credenciais>' +
       Params.Xml +
    '</' + Params.Prefixo + Params.TagEnvio + '>';
end;

procedure TACBrNFSeProviderBWSistemas200.GerarMsgDadosCancelaNFSe(
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
       '<' + Prefixo2 + 'Pedido>' +
         '<' + Prefixo2 + 'InfPedidoCancelamento' + IdAttr + NameSpace2 + '>' +
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
                IntToStr(InfoCanc.CodMunicipio) +
             '</' + Prefixo2 + 'CodigoMunicipio>' +
             CodigoVerificacao +
           '</' + Prefixo2 + 'IdentificacaoNfse>' +
           '<' + Prefixo2 + 'CodigoCancelamento>' +
              InfoCanc.CodCancelamento +
           '</' + Prefixo2 + 'CodigoCancelamento>' +
           Motivo +
         '</' + Prefixo2 + 'InfPedidoCancelamento>' +
       '</' + Prefixo2 + 'Pedido>';
  end;
end;

function TACBrNFSeProviderBWSistemas200.RegimeEspecialTributacaoToStr(
  const t: TnfseRegimeEspecialTributacao): string;
begin
  Result := EnumeradoToStr(t,
                         ['0', '1', '2', '3', '4', '5', '6'],
                         [retNenhum, retMicroempresaMunicipal, retEstimativa,
                         retSociedadeProfissionais, retCooperativa,
                         retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

function TACBrNFSeProviderBWSistemas200.StrToRegimeEspecialTributacao(
  out ok: boolean; const s: string): TnfseRegimeEspecialTributacao;
begin
  Result := StrToEnumerado(ok, s,
                        ['0', '1', '2', '3', '4', '5', '6'],
                        [retNenhum, retMicroempresaMunicipal, retEstimativa,
                         retSociedadeProfissionais, retCooperativa,
                         retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

{ TACBrNFSeXWebserviceBWSistemas200 }

function TACBrNFSeXWebserviceBWSistemas200.GetDadosUsuario: string;
begin
  with TACBrNFSeX(FPDFeOwner).Configuracoes.Geral do
  begin
    Result := '<Credenciais>' +
                '<UserName>' + Emitente.WSUser + '</UserName>' +
                '<Password>' + Emitente.WSSenha + '</Password>' +
              '</Credenciais>';
  end;
end;

function TACBrNFSeXWebserviceBWSistemas200.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

//  Request := '<GerarNfseEnvio>' +
//               DadosUsuario +
//               AMSG +
//             '</GerarNfseEnvio>';

  Result := Executar('/GerarNfse', AMSG,
                     ['GerarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceBWSistemas200.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := DadosUsuario +
             AMSG;

  Result := Executar('/ConsultarNfseFaixa', Request,
                     ['ConsultarNfseFaixaResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceBWSistemas200.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := DadosUsuario +
             '<ConsultarNfseRpsEnvio>' +
               AMSG +
             '</ConsultarNfseRpsEnvio>';

  Result := Executar('/ConsultarNfsePorRps', Request,
                     ['ConsultarNfseRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceBWSistemas200.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<CancelarNfseEnvio>' +
               DadosUsuario +
               AMSG +
             '</CancelarNfseEnvio>';

  Result := Executar('/CancelarNfse', Request,
                     ['CancelarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceBWSistemas200.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<SubstituirNfseEnvio>' +
               DadosUsuario +
               AMSG +
             '</SubstituirNfseEnvio>';

  Result := Executar('/SubstituirNfse', Request,
                     ['SubstituirNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceBWSistemas200.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
end;

end.
