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

unit Agape.Provider;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml, ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2, ACBrNFSeXWebserviceBase;

type
  TACBrNFSeXWebserviceAgape200 = class(TACBrNFSeXWebserviceSoap11)
  public
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

  TACBrNFSeProviderAgape200 = class (TACBrNFSeProviderABRASFv2)
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
  Agape.GravarXml, Agape.LerXml;

{ TACBrNFSeProviderAgape200 }

procedure TACBrNFSeProviderAgape200.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.ServicosDisponibilizados.EnviarLoteAssincrono := False;

  ConfigAssinar.Rps := True;
  ConfigAssinar.LoteRps := True;
  ConfigAssinar.CancelarNFSe := True;
  ConfigAssinar.RpsGerarNFSe := True;
  ConfigAssinar.RpsSubstituirNFSe := True;
  ConfigAssinar.SubstituirNFSe := True;
end;

function TACBrNFSeProviderAgape200.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Agape200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderAgape200.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Agape200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderAgape200.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceAgape200.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

{ TACBrNFSeXWebserviceAgape200 }

function TACBrNFSeXWebserviceAgape200.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:EnviarLoteRpsSincrono>';
  Request := Request + AMSG;
  Request := Request + '</web:EnviarLoteRpsSincrono>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:GerarNfse>';
  Request := Request + AMSG;
  Request := Request + '</web:GerarNfse>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:ConsultarLoteRps>';
  Request := Request + AMSG;
  Request := Request + '</web:ConsultarLoteRps>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:ConsultarNfsePorFaixa>';
  Request := Request + AMSG;
  Request := Request + '</web:ConsultarNfsePorFaixa>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:ConsultarNfsePorRps>';
  Request := Request + AMSG;
  Request := Request + '</web:ConsultarNfsePorRps>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:ConsultarNfseServicoPrestado>';
  Request := Request + AMSG;
  Request := Request + '</web:ConsultarNfseServicoPrestado>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:ConsultarNfseServicoTomado>';
  Request := Request + AMSG;
  Request := Request + '</web:ConsultarNfseServicoTomado>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:CancelarNfse>';
  Request := Request + AMSG;
  Request := Request + '</web:CancelarNfse>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<web:SubstituirNfse>';
  Request := Request + AMSG;
  Request := Request + '</web:SubstituirNfse>';

  Result := Executar('', Request, ['return'],
                     ['xmlns:web="http://webservice.agnfsewsserver.agapesistemas.com.br/"']);
end;

function TACBrNFSeXWebserviceAgape200.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
end;

end.
