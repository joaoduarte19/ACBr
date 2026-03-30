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
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
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

  Request := '<GerarNfseEnvio>' +
               DadosUsuario +
               AMSG +
             '</GerarNfseEnvio>';

  Result := Executar('/GerarNfse', Request,
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
