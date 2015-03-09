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

unit ACBrDFeSSL;

interface

uses
  Classes, SysUtils, ACBrDFeConfiguracoes;

type
  { TDFeSSLClass }

  TDFeSSLClass = class
  private
    FConfiguracoes: TConfiguracoes;

  protected
    FpInicializado: Boolean;

    property Configuracoes: TConfiguracoes read FConfiguracoes;

    procedure CarregarCertificado; virtual;

    function GetCertDataVenc: TDateTime; virtual;
    function GetCertNumeroSerie: String; virtual;
    function GetCertSubjectName: String; virtual;
    function GetCertCNPJ: String; virtual;

    function SignatureElement(const URI: String; AddX509Data: Boolean): String;
      virtual;
  public
    property CertNumeroSerie: String read GetCertNumeroSerie;
    property CertDataVenc: TDateTime read GetCertDataVenc;
    property CertSubjectName: String read GetCertSubjectName;
    property CertCNPJ: String read GetCertCNPJ;

    constructor Create(AConfiguracoes: TConfiguracoes);

    procedure Inicializar; virtual;
    procedure DesInicializar; virtual;

    function Assinar(const ConteudoXML, docElement, infElement: String): String;
      virtual;
    function Enviar(const ConteudoXML: String; const URL: String;
      const SoapAction: String): String; virtual;
    function Validar(const ConteudoXML, ArqSchema: String;
      out MsgErro: String): Boolean; virtual;
    function VerificarAssinatura(const ConteudoXML: String;
      out MsgErro: String): Boolean; virtual;

    function SelecionarCertificado: String; virtual;
  end;

  { TDFeSSL }

  TDFeSSL = class
  private
    FDFeOwner: TComponent;
    FConfiguracoes: TConfiguracoes;
    FSSLClass: TDFeSSLClass;
    FSSLLib: TSSLLib;

    function GetCertDataVenc: TDateTime;
    function GetCertNumeroSerie: String;
    function GetCertSubjectName: String;

    procedure InitSSLClass;
    procedure DeInitSSLClass;

    procedure SetSSLLib(ASSLLib: TSSLLib);
  public
    property CertNumeroSerie: String read GetCertNumeroSerie;
    property CertDataVenc: TDateTime read GetCertDataVenc;
    property CertSubjectName: String read GetCertSubjectName;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    // Nota: ConteudoXML, DEVE estar em UTF8 //
    function Assinar(const ConteudoXML, docElement, infElement: String): String;
    // Envia por SoapAction o ConteudoXML para URL. Retorna a resposta do Servico //
    function Enviar(var ConteudoXML: String; const URL: String;
      const SoapAction: String): String;
    // Valida um Arquivo contra o seu Schema. Retorna True se OK, preenche MsgErro se False //
    function Validar(const ConteudoXML: String; ArqSchema: String;
      out MsgErro: String): Boolean;
    // Verifica se assinatura de um XML é válida. Retorna True se OK, preenche MsgErro se False //
    function VerificarAssinatura(const ConteudoXML: String;
      out MsgErro: String): Boolean;

    function SelecionarCertificado: String; virtual;

  end;


implementation

uses strutils, ACBrUtil, ACBrDFe, ACBrDFeOpenSSL, ACBrDFeCapicom
  {$IFNDEF FPC}, ACBrDFeCapicomDelphiSoap{$ENDIF};

{ TDFeSSL }

constructor TDFeSSL.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrDFe) then
    raise EACBrDFeException.Create('Owner de TDFeSSL deve ser do tipo TACBrDFe');

  inherited Create;

  FDFeOwner := AOwner;
  FConfiguracoes := TACBrDFe(FDFeOwner).Configuracoes;
  FSSLClass := TDFeSSLClass.Create(FConfiguracoes);
  FSSLLib := libNone;
end;

destructor TDFeSSL.Destroy;
begin
  if Assigned(FSSLClass) then
  begin
    DeInitSSLClass;
    FreeAndNil(FSSLClass);
  end;

  inherited Destroy;
end;

function TDFeSSL.Assinar(const ConteudoXML, docElement, infElement: String): String;
begin
  // Nota: ConteudoXML, DEVE estar em UTF8 //
  InitSSLClass;
  Result := FSSLClass.Assinar(ConteudoXML, docElement, infElement);
end;

function TDFeSSL.Enviar(var ConteudoXML: String; const URL: String;
  const SoapAction: String): String;
begin
  // Nota: ConteudoXML, DEVE estar em UTF8 //
  InitSSLClass;
  Result := FSSLClass.Enviar(ConteudoXML, URL, SoapAction);
end;

function TDFeSSL.Validar(const ConteudoXML: String; ArqSchema: String; out
  MsgErro: String): Boolean;
begin
  InitSSLClass;

  if pos(PathDelim, ArqSchema) = 0 then
    ArqSchema := TACBrDFe(FDFeOwner).Configuracoes.Arquivos.PathSchemas + ArqSchema;

  if not FileExists(ArqSchema) then
    raise EACBrDFeException.Create('Arquivo ' + sLineBreak +
      ArqSchema + sLineBreak + 'Não encontrado');

  Result := FSSLClass.Validar(ConteudoXML, ArqSchema, MsgErro);
end;

function TDFeSSL.VerificarAssinatura(const ConteudoXML: String;
  out MsgErro: String): Boolean;
begin
  InitSSLClass;
  Result := FSSLClass.VerificarAssinatura(ConteudoXML, MsgErro);
end;

function TDFeSSL.SelecionarCertificado: String;
begin
  InitSSLClass;
  Result := FSSLClass.SelecionarCertificado;
end;

function TDFeSSL.GetCertDataVenc: TDateTime;
begin
  Result := FSSLClass.CertDataVenc;
end;

function TDFeSSL.GetCertNumeroSerie: String;
begin
  Result := FSSLClass.CertNumeroSerie;
end;

function TDFeSSL.GetCertSubjectName: String;
begin
  Result := FSSLClass.CertSubjectName;
end;

procedure TDFeSSL.InitSSLClass;
begin
  SetSSLLib(FConfiguracoes.Geral.SSLLib);
  FSSLClass.Inicializar;
  FSSLClass.CarregarCertificado;
end;

procedure TDFeSSL.DeInitSSLClass;
begin
  FSSLClass.DesInicializar;
end;

procedure TDFeSSL.SetSSLLib(ASSLLib: TSSLLib);
begin
  if ASSLLib = FSSLLib then
    exit;

  if Assigned(FSSLClass) then
    FreeAndNil(FSSLClass);

  case ASSLLib of
    libCapicom: FSSLClass := TDFeCapicom.Create(FConfiguracoes);
    libOpenSSL: FSSLClass := TDFeOpenSSL.Create(FConfiguracoes);
    libCapicomDelphiSoap:
    begin
      {$IFNDEF FPC}
      FSSLClass := TDFeCapicomDelphiSoap.Create(FConfiguracoes);
      {$ELSE}
      FSSLClass := TDFeCapicom.Create(FConfiguracoes);
      {$ENDIF}
    end
    else
      FSSLClass := TDFeSSLClass.Create(FConfiguracoes);
  end;

  FSSLLib := ASSLLib;
end;

{ TDFeSSLClass }

constructor TDFeSSLClass.Create(AConfiguracoes: TConfiguracoes);
begin
  FConfiguracoes := AConfiguracoes;
  FpInicializado := False;
end;

procedure TDFeSSLClass.Inicializar;
begin
  {nada aqui}
end;

procedure TDFeSSLClass.DesInicializar;
begin
  {nada aqui}
end;

function TDFeSSLClass.Assinar(const ConteudoXML, docElement, infElement: String): String;
begin
  Result := '';
  raise EACBrDFeException.Create(ClassName + '.Assinar, não implementado');
end;

function TDFeSSLClass.Enviar(const ConteudoXML: String; const URL: String;
  const SoapAction: String): String;
begin
  Result := '';
  raise EACBrDFeException.Create(ClassName + '.Enviar não implementado');
end;

function TDFeSSLClass.Validar(const ConteudoXML, ArqSchema: String;
  out MsgErro: String): Boolean;
begin
  Result := False;
  raise EACBrDFeException.Create('"Validar" não suportado em: ' + ClassName);
end;

function TDFeSSLClass.VerificarAssinatura(const ConteudoXML: String;
  out MsgErro: String): Boolean;
begin
  Result := False;
  raise EACBrDFeException.Create('"ValidarAssinatura" não suportado em: ' + ClassName);
end;

function TDFeSSLClass.SelecionarCertificado: String;
begin
  Result := '';
  raise EACBrDFeException.Create('"SelecionarCertificado" não suportado em: ' +
    ClassName);
end;

procedure TDFeSSLClass.CarregarCertificado;
begin
  raise EACBrDFeException.Create(ClassName + '.CarregarCertificado não implementado');
end;

function TDFeSSLClass.GetCertDataVenc: TDateTime;
begin
  Result := 0;
end;

function TDFeSSLClass.GetCertNumeroSerie: String;
begin
  Result := '';
end;

function TDFeSSLClass.GetCertSubjectName: String;
begin
  Result := '';
end;

function TDFeSSLClass.GetCertCNPJ: String;
begin
  Result := '';
end;

function TDFeSSLClass.SignatureElement(const URI: String; AddX509Data: Boolean): String;
begin
  {(*}
  Result :=
  '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
    '<SignedInfo>' +
      '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />' +
      '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />' +
      '<Reference URI="#' + URI + '">' +
        '<Transforms>' +
          '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />' +
          '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />' +
        '</Transforms>' +
        '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />' +
        '<DigestValue></DigestValue>' +
      '</Reference>' +
    '</SignedInfo>' +
    '<SignatureValue></SignatureValue>' +
    '<KeyInfo>' +
    IfThen(AddX509Data,
      '<X509Data>' +
        '<X509Certificate></X509Certificate>' +
      '</X509Data>',
      '')+
    '</KeyInfo>'+
  '</Signature>';
  {*)}
end;

end.

