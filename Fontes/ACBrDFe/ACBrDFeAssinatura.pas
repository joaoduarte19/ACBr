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

type
  { TAssinador }

  TAssinador = class
    FConfiguracoes: TConfiguracoes;
  public
    constructor Create(AConfiguracoes: TConfiguracoes);
    function Assinar(const ConteudoXML: String): String;
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

    function Assinar(const ConteudoXML: String): String;
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

    function Assinar(const ConteudoXML: String): String;
  end;


implementation

uses strutils, ACBrUtil, ACBrDFeUtil;

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

function TDFeAssinador.Assinar(const ConteudoXML: String): String;
begin
  SetCryptoLib(FDFeOwner.Configuracoes.Geral.CryptoLib);

  Result := FAssinador.Assinar(ConteudoXML);
end;

procedure TDFeAssinador.SetCryptoLib(ACryptoLib: TCryptoLib);
begin
  if ACryptoLib = FCryptoLib then
    exit;

  if Assigned(FAssinador) then
    FreeAndNil(FAssinador);

  case ACryptoLib of
    libCapicom: FAssinador := TAssinador.Create(FDFeOwner.Configuracoes);
    libOpenSSL: FAssinador := TAssinador.Create(FDFeOwner.Configuracoes);
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

function TAssinador.Assinar(const ConteudoXML: String): String;
begin
  raise Exception.Create(ACBrStr('Assinador: ' + ClassName + ' não implementado'));
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

function TAssinadorXMLSec.Assinar(const ConteudoXML: String): String;
var
  I, J, PosIni, PosFim: integer;
  URI, AStr, XmlAss: AnsiString;
  Tipo: integer; // 1 - NFE 2 - Cancelamento 3 - Inutilizacao
  Cert: TMemoryStream;
  Cert2: TStringStream;
begin
  AStr := ConteudoXML;

  //// Encontrando o URI ////
  Tipo := 1 ;// TODO: Verificar: DFeUtil.IdentificaTipoSchema(AStr, I);

  I := PosEx('Id=', AStr, I + 6);
  if I = 0 then
    raise EACBrNFeException.Create('Não encontrei inicio do URI: Id=');
  I := PosEx('"', AStr, I + 2);
  if I = 0 then
    raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas inicial');
  J := PosEx('"', AStr, I + 1);
  if J = 0 then
    raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas final');

  URI := copy(AStr, I + 1, J - I - 1);

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>', AStr);

  case Tipo of
    1: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTD + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    2: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTDCanc + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    3: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTDInut + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    4: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTDDpec + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    5: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTDCCe + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    6..11: AStr := copy(AStr, 1, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 1, I)))) +
        cDTDEven + Copy(AStr, StrToInt(VarToStr(DFeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
    else
      AStr := '';
  end;

  //// Inserindo Template da Assinatura digital ////
  case Tipo of
    1:
    begin
      I := pos('</NFe>', AStr);
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </NFe>');
    end;
    2:
    begin
      I := pos('</cancNFe>', AStr);
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </cancNFe>');
    end;
    3:
    begin
      I := pos('</inutNFe>', AStr);
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </inutNFe>');
    end;
    4:
    begin
      I := pos('</envDPEC>', AStr);
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </envDPEC>');
    end;
    5..11:
    begin
      I := pos('</evento>', AStr);
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </evento>');
    end;
    else
      raise EACBrNFeException.Create('Template de Tipo não implementado.');
  end;

  if pos('<Signature', AStr) > 0 then
    I := pos('<Signature', AStr);
  AStr := copy(AStr, 1, I - 1) +
    '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
    '<SignedInfo>' +
    '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'
    +
    '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'
    +
    '<Reference URI="#' + URI + '">' + '<Transforms>' +
    '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'
    +
    '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'
    +
    '</Transforms>' +
    '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />' +
    '<DigestValue></DigestValue>' + '</Reference>' +
    '</SignedInfo>' + '<SignatureValue></SignatureValue>' +
    '<KeyInfo>' + '<X509Data>' +
    '<X509Certificate></X509Certificate>' + '</X509Data>' +
    '</KeyInfo>' + '</Signature>';

  case Tipo of
    1: AStr := AStr + '</NFe>';
    2: AStr := AStr + '</cancNFe>';
    3: AStr := AStr + '</inutNFe>';
    4: AStr := AStr + '</envDPEC>';
    5..11: AStr := AStr + '</evento>';
    else
      AStr := '';
  end;

  if FileExists(ArqPFX) then
    XmlAss := NotaUtil.sign_file(PAnsiChar(AStr), PAnsiChar(ArqPFX), PAnsiChar(PFXSenha))
  else
  begin
    Cert := TMemoryStream.Create;
    Cert2 := TStringStream.Create(ArqPFX);
    try
      Cert.LoadFromStream(Cert2);
      XmlAss := NotaUtil.sign_memory(PAnsiChar(AStr), PAnsiChar(ArqPFX),
        PAnsiChar(PFXSenha), Cert.Size, Cert.Memory);
    finally
      Cert2.Free;
      Cert.Free;
    end;
  end;

  // Removendo quebras de linha //
  XmlAss := StringReplace(XmlAss, #10, '', [rfReplaceAll]);
  XmlAss := StringReplace(XmlAss, #13, '', [rfReplaceAll]);

  // Removendo DTD //
  case Tipo of
    1: XmlAss := StringReplace(XmlAss, cDTD, '', []);
    2: XmlAss := StringReplace(XmlAss, cDTDCanc, '', []);
    3: XmlAss := StringReplace(XmlAss, cDTDInut, '', []);
    4: XmlAss := StringReplace(XmlAss, cDTDDpec, '', []);
    5: XmlAss := StringReplace(XmlAss, cDTDCCe, '', []);
    6..11: XmlAss := StringReplace(XmlAss, cDTDEven, '', []);
    else
      XmlAss := '';
  end;

  PosIni := Pos('<X509Certificate>', XmlAss) - 1;
  PosFim := DFeUtil.PosLast('<X509Certificate>', XmlAss);

  XmlAss := copy(XmlAss, 1, PosIni) + copy(XmlAss, PosFim, length(XmlAss));

  AXMLAssinado := StringReplace(XmlAss, '<?xml version="1.0"?>', '', []);

  Result := True;
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

end.
