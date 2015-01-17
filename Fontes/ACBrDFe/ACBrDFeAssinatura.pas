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

unit ACBrDFeAssinatura;

interface

uses
  Classes, SysUtils, ACBrDFe, ACBrDFeConfiguracoes,
  libxml2, libxmlsec, libxslt;

const
  cDTD = '<!DOCTYPE test [<!ATTLIST &infElement& Id ID #IMPLIED>]>';

type
  { TAssinador }

  TAssinador = class
  private
    FConfiguracoes: TConfiguracoes;

  protected
    function SignatureElement(const URI: String; AddX509Data: Boolean): String;
  public
    constructor Create(AConfiguracoes: TConfiguracoes);
    function Assinar(const ConteudoXML, docElement, infElement: String): String;
  end;

  { TAssinadorXMLSec }

  TAssinadorXMLSec = class(TAssinador)
  private
    procedure InitXmlSec;
    procedure ShutDownXmlSec;

    function sign_file(const Axml: PAnsiChar; const key_file: PAnsiChar;
      const senha: PAnsiChar): AnsiString;
    function sign_memory(const Axml: PAnsiChar; const key_file: PAnsichar;
      const senha: PAnsiChar; Size: cardinal; Ponteiro: Pointer): AnsiString;
  public
    constructor Create(AConfiguracoes: TConfiguracoes);
    destructor Destroy;

    function Assinar(const ConteudoXML, docElement, infElement: String): String;
  end;

  { TAssinadorMSXML }

  TAssinadorMSXML = class(TAssinador)
  private
  public
    constructor Create(AConfiguracoes: TConfiguracoes);
    destructor Destroy;

    function Assinar(const ConteudoXML, docElement, infElement: String): String;
  end;

  { TDFeAssinador }

  TDFeAssinador = class
  private
    FDFeOwner: TACBrDFe;
    FAssinador: TAssinador;
    FCryptoLib: TCryptoLib;

    procedure SetCryptoLib(ACryptoLib: TCryptoLib);
  public
    constructor Create(AOwner: TACBrDFe);
    destructor Destroy;

    function Assinar(const ConteudoXML, docElement, infElement: String): String;
  end;


implementation

uses Math, strutils, ACBrUtil, ACBrDFeUtil;

{ TDFeAssinador }

constructor TDFeAssinador.Create(AOwner: TACBrDFe);
begin
  inherited Create;

  FDFeOwner := AOwner;
  FAssinador := TAssinador.Create(FDFeOwner.Configuracoes);
  FCryptoLib := libNone;
end;

destructor TDFeAssinador.Destroy;
begin
  if Assigned(FAssinador) then
    FreeAndNil(FAssinador);

  inherited Destroy;
end;

function TDFeAssinador.Assinar(const ConteudoXML, docElement, infElement:
  String): String;
begin
  SetCryptoLib(FDFeOwner.Configuracoes.Geral.CryptoLib);

  Result := FAssinador.Assinar(ConteudoXML, docElement, infElement);
end;

procedure TDFeAssinador.SetCryptoLib(ACryptoLib: TCryptoLib);
begin
  if ACryptoLib = FCryptoLib then
    exit;

  if Assigned(FAssinador) then
    FreeAndNil(FAssinador);

  case ACryptoLib of
    libCapicom: FAssinador := TAssinadorMSXML.Create(FDFeOwner.Configuracoes);
    libOpenSSL: FAssinador := TAssinadorXMLSec.Create(FDFeOwner.Configuracoes);
    else
      FAssinador := TAssinador.Create(FDFeOwner.Configuracoes);
  end;

  FCryptoLib := ACryptoLib;
end;

{ TAssinador }

constructor TAssinador.Create(AConfiguracoes: TConfiguracoes);
begin
  FConfiguracoes := AConfiguracoes;
end;

function TAssinador.Assinar(const ConteudoXML, docElement, infElement: String): String;
begin
  raise EACBrDFeException.Create('Assinador: ' + ClassName + ' não implementado');
end;


function TAssinador.SignatureElement(const URI: String; AddX509Data: Boolean): String;
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
    IfThen(AddX509Data,
    '<KeyInfo>' +
      '<X509Data>' +
        '<X509Certificate></X509Certificate>' +
      '</X509Data>' +
    '</KeyInfo>',
    '<KeyInfo></KeyInfo>') +
  '</Signature>';
  {*)}
end;

{ TAssinadorXMLSec }

constructor TAssinadorXMLSec.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  InitXmlSec;
end;

destructor TAssinadorXMLSec.Destroy;
begin
  ShutDownXmlSec;

  inherited Destroy;
end;

function TAssinadorXMLSec.Assinar(
  const ConteudoXML, docElement, infElement: String): String;
var
  I, PosIni, PosFim: integer;
  URI, AXml, XmlAss, DTD: String;
  Cert: TMemoryStream;
  Cert2: TStringStream;
begin
  AXml := ConteudoXML;

  URI := DFeUtil.ExtraiURI(AXml);

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>', AXml);
  DTD := StringReplace(cDTD, '&infElement&', infElement, []);

  AXml := Copy(AXml, 1, IfThen(I > 0, I + 1, I)) + DTD +
    Copy(AXml, IfThen(I > 0, I + 2, I), Length(AXml));

  //// Inserindo Template da Assinatura digital ////
  I := pos('<signature', lowercase(AXml));
  if I < 0 then
    I := pos('</' + docElement + '>', AXml);

  if I = 0 then
    raise EACBrDFeException.Create('Não encontrei final do elemento: </' +
      docElement + '>');

  AXml := copy(AXml, 1, I - 1) + SignatureElement(URI, True) + docElement;

  if FileExists(FConfiguracoes.Certificados.ArquivoPFX) then
    XmlAss := sign_file(PAnsiChar(AXml),
      PAnsiChar(FConfiguracoes.Certificados.ArquivoPFX),
      PAnsiChar(FConfiguracoes.Certificados.Senha))
  else
  begin
    Cert := TMemoryStream.Create;
    Cert2 := TStringStream.Create(FConfiguracoes.Certificados.DadosPFX);
    try
      Cert.LoadFromStream(Cert2);
      XmlAss := sign_memory(PAnsiChar(AXml),
        PAnsiChar(FConfiguracoes.Certificados.DadosPFX),
        PAnsiChar(FConfiguracoes.Certificados.Senha),
        Cert.Size, Cert.Memory);
    finally
      Cert2.Free;
      Cert.Free;
    end;
  end;

  // Removendo quebras de linha //
  XmlAss := StringReplace(XmlAss, #10, '', [rfReplaceAll]);
  XmlAss := StringReplace(XmlAss, #13, '', [rfReplaceAll]);

  // Removendo DTD //
  XmlAss := StringReplace(XmlAss, DTD, '', []);

  // Considerando apenas o último Certificado //
  PosIni := Pos('<X509Certificate>', XmlAss) - 1;
  PosFim := PosLast('<X509Certificate>', XmlAss);
  XmlAss := copy(XmlAss, 1, PosIni) + copy(XmlAss, PosFim, length(XmlAss));

  // Removendo cabecalho de versao XML
  XmlAss := StringReplace(XmlAss, '<?xml version="1.0"?>', '', []);

  Result := XmlAss;
end;

function TAssinadorXMLSec.sign_file(const Axml: PAnsiChar;
  const key_file: PAnsiChar; const senha: PAnsiChar): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PAnsiChar;
  bufSize: integer;
begin
  // TODO: refatorar sign_file() e sign_memory() ;

  doc := nil;
  dsigCtx := nil;
  Result := '';

  if (Axml = nil) or (key_file = nil) then
    Exit;

  try
    { load template }
    doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
    if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
      raise Exception.Create('Error: unable to parse');

    { find start node }
    node := xmlSecFindNode(xmlDocGetRootElement(doc),
      PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
    if (node = nil) then
      raise Exception.Create('Error: start node not found');

    { create signature context, we don't need keys manager in this example }
    dsigCtx := xmlSecDSigCtxCreate(nil);
    if (dsigCtx = nil) then
      raise Exception.Create('Error :failed to create signature context');

    // { load private key}
    dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file,
      xmlSecKeyDataFormatPkcs12, senha, nil, nil);
    if (dsigCtx^.signKey = nil) then
      raise Exception.Create('Error: failed to load private pem key from "' +
        key_file + '"');

    { set key name to the file name, this is just an example! }
    if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
      raise Exception.Create('Error: failed to set key name for key from "' +
        key_file + '"');

    { sign the template }
    if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
      raise Exception.Create('Error: signature failed');

    { print signed document to stdout }
    // xmlDocDump(stdout, doc);
    // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
    buffer := nil;
    xmlDocDumpMemory(doc, @buffer, @bufSize);
    if (buffer <> nil) then
      { success }
      Result := buffer;
  finally
    { cleanup }
    if (dsigCtx <> nil) then
      xmlSecDSigCtxDestroy(dsigCtx);

    if (doc <> nil) then
      xmlFreeDoc(doc);
  end;
end;

function TAssinadorXMLSec.sign_memory(const Axml: PAnsiChar;
  const key_file: PAnsichar; const senha: PAnsiChar; Size: cardinal;
  Ponteiro: Pointer): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PAnsiChar;
  bufSize: integer;
begin
  // TODO: refatorar sign_file() e sign_memory() ;

  doc := nil;
  dsigCtx := nil;
  Result := '';

  if (Axml = nil) or (key_file = nil) then
    Exit;

  try
    { load template }
    doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
    if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
      raise Exception.Create('Error: unable to parse');

    { find start node }
    node := xmlSecFindNode(xmlDocGetRootElement(doc),
      PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
    if (node = nil) then
      raise Exception.Create('Error: start node not found');

    { create signature context, we don't need keys manager in this example }
    dsigCtx := xmlSecDSigCtxCreate(nil);
    if (dsigCtx = nil) then
      raise Exception.Create('Error :failed to create signature context');

    // { load private key, assuming that there is not password }
    dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Ponteiro, size,
      xmlSecKeyDataFormatPkcs12, senha, nil, nil);

    if (dsigCtx^.signKey = nil) then
      raise Exception.Create('Error: failed to load private pem key from "' +
        key_file + '"');

    { set key name to the file name, this is just an example! }
    if (xmlSecKeySetName(dsigCtx^.signKey, key_file) < 0) then
      raise Exception.Create('Error: failed to set key name for key from "' +
        key_file + '"');

    { sign the template }
    if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
      raise Exception.Create('Error: signature failed');

    { print signed document to stdout }
    // xmlDocDump(stdout, doc);
    // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
    buffer := nil;
    xmlDocDumpMemory(doc, @buffer, @bufSize);
    if (buffer <> nil) then
      { success }
      Result := buffer;
  finally
    { cleanup }
    if (dsigCtx <> nil) then
      xmlSecDSigCtxDestroy(dsigCtx);

    if (doc <> nil) then
      xmlFreeDoc(doc);
  end;
end;

procedure TAssinadorXMLSec.InitXmlSec;
begin
  { Init libxml and libxslt libraries }
  xmlInitParser();
  __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
  xmlSubstituteEntitiesDefault(1);
  __xmlIndentTreeOutput^ := 1;

  { Init xmlsec library }
  if (xmlSecInit() < 0) then
    raise Exception.Create('Error: xmlsec initialization failed.');

  { Check loaded library version }
  if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
    raise Exception.Create('Error: loaded xmlsec library version is not compatible.');

  (* Load default crypto engine if we are supporting dynamic
   * loading for xmlsec-crypto libraries. Use the crypto library
   * name ("openssl", "nss", etc.) to load corresponding
   * xmlsec-crypto library.
   *)
  if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
    raise Exception.Create(
      'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
      'that you have it installed and check shared libraries path'#10 +
      '(LD_LIBRARY_PATH) environment variable.');

  { Init crypto library }
  if (xmlSecCryptoAppInit(nil) < 0) then
    raise Exception.Create('Error: crypto initialization failed.');

  { Init xmlsec-crypto library }
  if (xmlSecCryptoInit() < 0) then
    raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end;

procedure TAssinadorXMLSec.ShutDownXmlSec;
begin
  { Shutdown xmlsec-crypto library }
  xmlSecCryptoShutdown();

  { Shutdown crypto library }
  xmlSecCryptoAppShutdown();

  { Shutdown xmlsec library }
  xmlSecShutdown();

  { Shutdown libxslt/libxml }
  xsltCleanupGlobals();
  xmlCleanupParser();
end;

{ TAssinadorMSXML }

constructor TAssinadorMSXML.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

end;

destructor TAssinadorMSXML.Destroy;
begin

  inherited Destroy;
end;

function TAssinadorMSXML.Assinar(const ConteudoXML, docElement,
  infElement: String): String;
begin
  // TODO:....

end;

end.




(*

// TODO: Verificar chamadas de assintura...

cDTD     = '<!DOCTYPE test [<!ATTLIST infNFe Id ID #IMPLIED>]>' ;
 cDTDCanc = '<!DOCTYPE test [<!ATTLIST infCanc Id ID #IMPLIED>]>' ;
 cDTDInut = '<!DOCTYPE test [<!ATTLIST infInut Id ID #IMPLIED>]>' ;
 cDTDDpec = '<!DOCTYPE test [<!ATTLIST infDPEC Id ID #IMPLIED>]>' ;
 cDTDCCe  = '<!DOCTYPE test [<!ATTLIST infEvento Id ID #IMPLIED>]>' ;
 cDTDEven = '<!DOCTYPE test [<!ATTLIST infEvento Id ID #IMPLIED>]>' ;

 </NFe>
 </cancNFe>
 </inutNFe>
 </envDPEC>
 </evento>

 *)
