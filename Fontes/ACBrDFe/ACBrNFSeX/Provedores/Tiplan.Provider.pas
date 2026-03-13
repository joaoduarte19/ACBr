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

unit Tiplan.Provider;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv1,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceTiplan = class(TACBrNFSeXWebserviceSoap11)
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderTiplan = class (TACBrNFSeProviderABRASFv1)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

  end;

  TACBrNFSeXWebserviceTiplan203 = class(TACBrNFSeXWebserviceSoap11)
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
  end;

  TACBrNFSeProviderTiplan203 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;
  end;

  TACBrNFSeXWebserviceTiplanAPIPropria = class(TACBrNFSeXWebservicePadraoNacional)
  protected

  public
    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderTiplanAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private

  protected
    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
  end;

implementation

uses
  synacode,
  ACBrJson,
  ACBrCompress,
  ACBrDFe.Conversao,
  ACBrUtil.XMLHTML,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConsts,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  Tiplan.GravarXml,
  Tiplan.LerXml;

{ TACBrNFSeProviderTiplan }

procedure TACBrNFSeProviderTiplan.Configuracao;
begin
  inherited Configuracao;

  with ConfigAssinar do
  begin
    LoteRps := True;
    IncluirURI := False;
  end;
end;

function TACBrNFSeProviderTiplan.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Tiplan.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplan.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Tiplan.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplan.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceTiplan.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

{ TACBrNFSeXWebserviceTiplan }

function TACBrNFSeXWebserviceTiplan.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<RecepcionarLoteRpsRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</RecepcionarLoteRpsRequest>';

  Result := Executar('http://www.nfe.com.br/RecepcionarLoteRps', Request,
                     ['outputXML', 'EnviarLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.ConsultarSituacao(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarSituacaoLoteRpsRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</ConsultarSituacaoLoteRpsRequest>';

  Result := Executar('http://www.nfe.com.br/ConsultarSituacaoLoteRps', Request,
                     ['outputXML', 'ConsultarSituacaoLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarLoteRpsRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</ConsultarLoteRpsRequest>';

  Result := Executar('http://www.nfe.com.br/ConsultarLoteRps', Request,
                     ['outputXML', 'ConsultarLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarNfsePorRpsRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</ConsultarNfsePorRpsRequest>';

  Result := Executar('http://www.nfe.com.br/ConsultarNfsePorRps', Request,
                     ['outputXML', 'ConsultarNfseRpsResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.ConsultarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarNfseRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</ConsultarNfseRequest>';

  Result := Executar('http://www.nfe.com.br/ConsultarNfse', Request,
                     ['outputXML', 'ConsultarNfseResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.Cancelar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<CancelarNfseRequest xmlns="http://www.nfe.com.br/">';
  Request := Request + '<inputXML>' + XmlToStr(AMSG) + '</inputXML>';
  Request := Request + '</CancelarNfseRequest>';

  Result := Executar('http://www.nfe.com.br/CancelarNfse', Request,
                     ['outputXML', 'CancelarNfseResposta'], []);
end;

function TACBrNFSeXWebserviceTiplan.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
end;

{ TACBrNFSeProviderTiplan203 }

procedure TACBrNFSeProviderTiplan203.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    NumMaxRpsGerar := 3;
    QuebradeLinha := '\s\n';
  end;

  with ConfigAssinar do
  begin
    LoteRps := True;
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

function TACBrNFSeProviderTiplan203.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Tiplan203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplan203.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Tiplan203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplan203.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceTiplan203.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

{ TACBrNFSeXWebserviceTiplan203 }

function TACBrNFSeXWebserviceTiplan203.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:RecepcionarLoteRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteRpsRequest>';

  Result := Executar('http://nfse.abrasf.org.br/RecepcionarLoteRps', Request,
                     ['outputXML', 'EnviarLoteRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:RecepcionarLoteRpsSincronoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteRpsSincronoRequest>';

  Result := Executar('http://nfse.abrasf.org.br/RecepcionarLoteRpsSincrono', Request,
                     ['outputXML', 'EnviarLoteRpsSincronoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:GerarNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:GerarNfseRequest>';

  Result := Executar('http://nfse.abrasf.org.br/GerarNfse', Request,
                     ['outputXML', 'GerarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarLoteRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarLoteRpsRequest>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarLoteRps', Request,
                     ['outputXML', 'ConsultarLoteRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfsePorFaixaRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfsePorFaixaRequest>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfsePorFaixa', Request,
                     ['outputXML', 'ConsultarNfseFaixaResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfsePorRpsRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfsePorRpsRequest>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfsePorRps', Request,
                     ['outputXML', 'ConsultarNfseRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfseServicoPrestadoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoPrestadoRequest>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfseServicoPrestado', Request,
                     ['outputXML', 'ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfseServicoTomadoRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoTomadoRequest>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfseServicoTomado', Request,
                     ['outputXML', 'ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:CancelarNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:CancelarNfseRequest>';

  Result := Executar('http://nfse.abrasf.org.br/CancelarNfse', Request,
                     ['outputXML', 'CancelarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:SubstituirNfseRequest>';
  Request := Request + '<nfseCabecMsg>' + XmlToStr(ACabecalho) + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + XmlToStr(AMSG) + '</nfseDadosMsg>';
  Request := Request + '</nfse:SubstituirNfseRequest>';

  Result := Executar('http://nfse.abrasf.org.br/SubstituirNfse', Request,
                     ['outputXML', 'SubstituirNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br/"']);
end;

function TACBrNFSeXWebserviceTiplan203.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := RemoverCaracteresDesnecessarios(Result);
  Result := ParseText(Result);
end;

{ TACBrNFSeProviderTiplanAPIPropria }

function TACBrNFSeProviderTiplanAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_TiplanAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplanAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_TiplanAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderTiplanAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceTiplanAPIPropria.Create(FAOwner, AMetodo, URL, Method);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderTiplanAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;

  if aMetodo in [tmGerar, tmEnviarEvento] then
  begin
    Result := ChangeLineBreak(aXml, '');
    Result := EncodeBase64(GZipCompress(Result));

    case aMetodo of
      tmGerar:
        begin
          Result := '{"dpsXmlGZipB64":"' + Result + '"}';
          Path := '';
        end;

      tmEnviarEvento:
        begin
          Result := '{"pedidoRegistroEventoXmlGZipB64":"' + Result + '"}';
          Path := '';
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

procedure TACBrNFSeProviderTiplanAPIPropria.PrepararConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.NumeroRps) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod102;
    AErro.Descricao := ACBrStr(Desc102);
    Exit;
  end;

  Path := '/' + Response.NumeroRps;
  Response.ArquivoEnvio := Path;
  Method := 'GET';
end;

{ TACBrNFSeXWebserviceTiplanAPIPropria }

function TACBrNFSeXWebserviceTiplanAPIPropria.TratarXmlRetornado(
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

end.
