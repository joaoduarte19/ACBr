{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2015 Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }

{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }

{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeCapicomIndy;

interface

uses
  Classes, SysUtils, ACBrDFeCapicom,
  SoapHTTPClient, SOAPHTTPTrans, SOAPConst, WinInet, ACBrCAPICOM_TLB;

type
  { TDFeCapicomIndy }

  TDFeCapicomIndy = class(TDFeCapicom)
  private
    FIndyReqResp: THTTPReqResp;;

    procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
  protected
    procedure ConfiguraReqResp(const URL, SoapAction: String);

  public
    constructor Create(AConfiguracoes: TConfiguracoes);
    destructor Destroy; override;

    function Enviar(const ConteudoXML: AnsiString; const URL: String;
      const SoapAction: String): AnsiString; override;
  end;

implementation

uses
  strutils, ACBrUtil, ACBrDFeUtil,
  ACBrCAPICOM_TLB;

{ TDFeCapicomIndy }

constructor TDFeCapicomIndy.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FIndyReqResp := THTTPReqResp.Create;
end;

destructor TDFeCapicomIndy.Destroy;
begin
  FIndyReqResp.Free;

  inherited Destroy;
end;

procedure TDFeCapicomIndy.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  CertContext: ICertContext;
  PCertContext: Pointer;
  ContentHeader: String;
begin
  CertContext := Certificado as ICertContext;
  CertContext.Get_CertContext(integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT,
    PCertContext, SizeOf(CERT_CONTEXT)) then
    GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if trim(Configuracoes.WebServices.ProxyUser) <> '' then
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME,
      PChar(Configuracoes.WebServices.ProxyUser),
      Length(Configuracoes.WebServices.ProxyUser)) then
      GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if trim(Configuracoes.WebServices.ProxyPass) <> '' then
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD,
      PChar(Configuracoes.WebServices.ProxyPass),
      Length(Configuracoes.WebServices.ProxyPass)) then
      GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if (pos('SCERECEPCAORFB', UpperCase(FURL)) <= 0) and
    (pos('SCECONSULTARFB', UpperCase(FURL)) <= 0) then
  begin
    ContentHeader := Format(ContentTypeTemplate,
      ['application/soap+xml; charset=utf-8']);
    HttpAddRequestHeaders(Data, PChar(ContentHeader),
      Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
  end;

  FIndyReqResp.CheckContentType;
end;

procedure TDFeCapicomIndy.ConfiguraReqResp(const URL, SoapAction: String);
begin
  with Configuracoes.WebServices do
  begin
    if ProxyHost <> '' then
    begin
      FIndyReqResp.Proxy := ProxyHost + ':' + ProxyPort;
      FIndyReqResp.UserName := ProxyUser;
      FIndyReqResp.Password := ProxyPass;
    end;
  end;

  FIndyReqResp.OnBeforePost := OnBeforePost;
  FIndyReqResp.UseUTF8InHeader := True;
end;


end.
