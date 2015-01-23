{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{*******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 10/02/2009: André Ferreira de Moraes
|*  - Adicionado URL de todos os estados
|* 18/02/2009: André Ferreira de Moraes
|*  - Criado Assinatura baseado em código passado por Daniel Simões
|*  - Criado Validação do XML da NFE baseado em código passado por Daniel Simões
|* 24/09/2012: Italo Jurisato Junior
|*  - Alterações para funcionamento com NFC-e
*******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeUtil;

interface

uses {$IFNDEF ACBrNFeOpenSSL}ACBrCAPICOM_TLB, ACBrMSXML2_TLB, JwaWinCrypt, {$ENDIF}
  Classes, Forms, TypInfo,
  {$IFDEF FPC}
     LResources, Controls, Graphics, Dialogs, strutils,
  {$ELSE}
     StrUtils,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
     ActiveX,
  {$ENDIF}
  ACBrNFeConfiguracoes, pcnConversao, pcnNFe, ACBrDFeUtil, ACBrEAD;


{$IFDEF ACBrNFeOpenSSL}
const
 cDTD     = '<!DOCTYPE test [<!ATTLIST infNFe Id ID #IMPLIED>]>' ;
 cDTDCanc = '<!DOCTYPE test [<!ATTLIST infCanc Id ID #IMPLIED>]>' ;
 cDTDInut = '<!DOCTYPE test [<!ATTLIST infInut Id ID #IMPLIED>]>' ;
 cDTDDpec = '<!DOCTYPE test [<!ATTLIST infDPEC Id ID #IMPLIED>]>' ;
 cDTDCCe  = '<!DOCTYPE test [<!ATTLIST infEvento Id ID #IMPLIED>]>' ;
 cDTDEven = '<!DOCTYPE test [<!ATTLIST infEvento Id ID #IMPLIED>]>' ;
{$ELSE}
const
  DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
{$ENDIF}
var
  fsHashQRCode : TACBrEAD;
{$IFNDEF ACBrNFeOpenSSL}
  CertStore     : IStore3;
  CertStoreMem  : IStore3;
  PrivateKey    : IPrivateKey;
  Certs         : ICertificates2;
  Cert          : ICertificate2;
  NumCertCarregado : String;
{$ENDIF}

type
  NotaUtil = class
  private
//(AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//AC,AL,AP,MA,PA,PB,PI,RJ,RN,RR,SC,SE,TO - Estados sem WebServices próprios
//Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul): AC, AL, AM, AP, MS, PB, RJ, RR, SC, SE e TO.
//Estados Emissores pela Sefaz Virtual AN (Ambiente Nacional): ES, MA, PA, PI e RN.

    class function GetURLSVRS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLSVAN(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLAM(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLBA(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLCE(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLES(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNfe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLGO(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLMT(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLMS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLMG(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLPR(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLPE(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLRS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function GetURLSP(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
  protected

  public
    {$IFDEF ACBrNFeOpenSSL}
       class function sign_file(const Axml: PAnsiChar; const key_file: PAnsiChar; const senha: PAnsiChar): AnsiString;
       class function sign_memory(const Axml: PAnsiChar; const key_file: PAnsichar; const senha: PAnsiChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
       class Procedure InitXmlSec ;
       class Procedure ShutDownXmlSec ;
    {$ENDIF}
    class function Modulo11(Valor: string): String;
    class function ChaveAcesso(AUF:Integer; ADataEmissao:TDateTime; ACNPJ:String; ASerie:Integer;
                               ANumero,ACodigo: Integer; AModelo:Integer=55): String;
    class function ExtraiCNPJChaveAcesso(AChaveNFE: String): String;
    class function ExtraiModeloChaveAcesso(AChaveNFE: String): String;
    class function StringToDateTime(const AString: string): TDateTime;
    class function ValidaUFCidade(const UF, Cidade: Integer): Boolean;overload;
    class procedure ValidaUFCidade(const UF, Cidade: Integer; Const AMensagem: String);overload;
    class function FormatarCEP(AValue : String ): String;
    class function FormatarFone(AValue : String ): String;
    class function FormatarChaveAcesso(AValue : String ): String;
    class function GetURL(Const AUF, AAmbiente, FormaEmissao: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
    class function IdentificaTipoSchema(Const AXML: AnsiString; var I: Integer): integer; {eventos_juaumkiko}
    class function Valida(Const AXML: AnsiString; var AMsg: AnsiString; const APathSchemas: string = '';
                          AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
    class function ValidaAssinatura(const AXML: AnsiString;  var AMsg: AnsiString): Boolean;
{$IFDEF ACBrNFeOpenSSL}
    class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
    class function Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
    class procedure ConfAmbiente;
    class function PathAplication: String;
    class function GerarChaveContingencia(FNFe:TNFe): String;
    class function FormatarChaveContigencia(AValue: String): String;
    class function PreparaCasasDecimais(AValue: Integer): String;
    class function CollateBr(Str: String): String;
    class function UpperCase2(Str: String): String;
    class function UFtoCUF(UF : String): Integer;
    class function GetURLConsultaNFCe(const AUF : Integer; AAmbiente : TpcnTipoAmbiente) : String;
    class function GetURLQRCode(const AUF : Integer;  AAmbiente : TpcnTipoAmbiente;
                                AchNFe, AcDest: String;
                                AdhEmi: TDateTime;
                                AvNF, AvICMS: Currency;
                                AdigVal, AidToken, AToken: String) : String;
    class function CstatProcessado(AValue: Integer): Boolean;                                
  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}libxml2, libxmlsec, libxslt, {$ELSE} ComObj, {$ENDIF} Sysutils,
  Variants, ACBrUtil, ACBrConsts, ACBrNFe, pcnAuxiliar;

{ NotaUtil }

{$IFDEF ACBrNFeOpenSSL}
class function NotaUtil.sign_file(const Axml: PAnsiChar; const key_file: PAnsiChar; const senha: PAnsiChar): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PAnsiChar;
  bufSize: integer;
label done;
begin
    doc := nil;
    //node := nil;
    dsigCtx := nil;
    result := '';

    if (Axml = nil) or (key_file = nil) then Exit;

    try
       { load template }
       doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       { find start node }
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       { create signature context, we don't need keys manager in this example }
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       // { load private key}
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file, xmlSecKeyDataFormatPkcs12, senha, nil, nil);
       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       { set key name to the file name, this is just an example! }
       if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

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
          result := buffer ;
   finally
       { cleanup }
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end ;
end;

class function NotaUtil.sign_memory(const Axml: PAnsiChar; const key_file: PAnsichar; const senha: PAnsiChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PAnsiChar;
  bufSize: integer;
label done;
begin
    doc := nil;
    //node := nil;
    dsigCtx := nil;
    result := '';

    if (Axml = nil) or (key_file = nil) then Exit;
    try
       { load template }
       doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       { find start node }
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       { create signature context, we don't need keys manager in this example }
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       // { load private key, assuming that there is not password }
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Ponteiro, size, xmlSecKeyDataFormatPkcs12, senha, nil, nil);

       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       { set key name to the file name, this is just an example! }
       if (xmlSecKeySetName(dsigCtx^.signKey, key_file) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

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
          result := buffer ;
   finally
       { cleanup }
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end ;
end;

class Procedure NotaUtil.InitXmlSec ;
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
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');

    { Init crypto library }
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    { Init xmlsec-crypto library }
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end ;

class Procedure NotaUtil.ShutDownXmlSec ;
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
end ;
{$ENDIF}

class function NotaUtil.ChaveAcesso(AUF: Integer; ADataEmissao: TDateTime;
  ACNPJ: String; ASerie, ANumero, ACodigo: Integer; AModelo: Integer): String;
var
  vUF, vDataEmissao, vSerie, vNumero,
  vCodigo, vModelo: String;
begin
  vUF          := DFeUtil.Poem_Zeros(AUF, 2);
  vDataEmissao := FormatDateTime('YYMM', ADataEmissao);
  vModelo      := DFeUtil.Poem_Zeros(AModelo, 2);
  vSerie       := DFeUtil.Poem_Zeros(ASerie, 3);
  vNumero      := DFeUtil.Poem_Zeros(ANumero, 9);
  vCodigo      := DFeUtil.Poem_Zeros(ACodigo, 9);

  Result := vUF+vDataEmissao+ACNPJ+vModelo+vSerie+vNumero+vCodigo;
  Result := Result+NotaUtil.Modulo11(Result);
end;

class function NotaUtil.ExtraiCNPJChaveAcesso(AChaveNFE: String): String;
begin
  AChaveNFE := OnlyNumber(AChaveNFE);
  if ValidarChave('NFe'+AChaveNFe) then
     Result := copy(AChaveNFE,7,14)
  else
     Result := '';
end;

class function NotaUtil.ExtraiModeloChaveAcesso(AChaveNFE: String): String;
begin
  AChaveNFE := OnlyNumber(AChaveNFE);
  if ValidarChave('NFe'+AChaveNFe) then
     Result := copy(AChaveNFE,21,2)
  else
     Result := '';
end;

class function NotaUtil.StringToDateTime(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToDateTime(AString);
end;

class function NotaUtil.Modulo11(Valor: string): string;
var
  Soma: integer;
  Contador, Peso, Digito: integer;
begin
  Soma := 0;
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
    if Peso < 9 then
      Peso := Peso + 1
    else
      Peso := 2;
  end;

  Digito := 11 - (Soma mod 11);
  if (Digito > 9) then
    Digito := 0;

  Result := IntToStr(Digito);
end;

class function NotaUtil.FormatarCEP(AValue: String): String;
begin
   Result := DFeUtil.FormatarCEP(AValue);
end;

class function NotaUtil.FormatarFone(AValue: String): String;
begin
   Result := DFeUtil.FormatarFone(AValue);
end;

class function NotaUtil.FormatarChaveAcesso(AValue: String): String;
begin
  AValue := DFeUtil.LimpaNumero(AValue);

  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) + ' ' + copy(AValue,37,4) + ' ' +
            copy(AValue,41,4) ;
end;

class function NotaUtil.GetURL(const AUF, AAmbiente, FormaEmissao : Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
//  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

case FormaEmissao of
  1,2,4,5,9 : begin
       case ALayOut of
         LayNfeEnvDPEC      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx',          'https://hom.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx');
         LayNfeConsultaDPEC : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx',          'https://hom.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx');
         LayNFeEventoAN     : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',          'https://hom.nfe.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx ');
         LayNfeConsNFeDest  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/NFeConsultaDest/NFeConsultaDest.asmx',        'https://hom.nfe.fazenda.gov.br/NFeConsultaDest/NFeConsultaDest.asmx');
         LayNfeDownloadNFe  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/NfeDownloadNF/NfeDownloadNF.asmx',            'https://hom.nfe.fazenda.gov.br/NfeDownloadNF/NfeDownloadNF.asmx');
         LayDistDFeInt      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx', 'https://hom.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx');
       end;

       // Alguns Estados Brasiseiros deixaram de autorizar as NF-e no SEFAZ Virtual do Ambiente Nacional
       // e passaram a utilizar o SEFAZ Virtual do Rio Grande do Sul, são eles:
       // Inicio     - Estado
       // ----------   -------------------
       // 03/09/2009 - Rondônia
       // 04/10/2009 - Distrito Federal
       // 06/05/2013 - Rio Grande do Norte
       // 04/02/2014 - Espirito Santo

       case AUF of
         12: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AC
         27: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AL
         16: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AP
         13: Result := NotaUtil.GetURLAM(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //AM
         29: Result := NotaUtil.GetURLBA(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //BA
         23: Result := NotaUtil.GetURLCE(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //CE
         53: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //DF

//         32: Result := NotaUtil.GetURLSVAN(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //ES
//         32: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //ES
         32: Result := NotaUtil.GetURLES(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //ES

         52: Result := NotaUtil.GetURLGO(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //GO

//         21: Result := NotaUtil.GetURLSVAN(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //MA
         21: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //MA
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //MA
             end;
         51: Result := NotaUtil.GetURLMT(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MT
         50: Result := NotaUtil.GetURLMS(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MS
         31: Result := NotaUtil.GetURLMG(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MG
//         15: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PA
         15: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //PA
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PA
             end;
         25: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PB
         41: Result := NotaUtil.GetURLPR(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //PR
         26: Result := NotaUtil.GetURLPE(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //PE
         22: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //PI
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PI
             end;
         33: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RJ
         24: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RN
         43: Result := NotaUtil.GetURLRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //RS
         11: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RO
         14: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RR
         42: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //SC
         35: Result := NotaUtil.GetURLSP(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //SP
         28: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //SE
         17: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //TO
       end;
      end;
  3 : begin
       case ALayOut of
         LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.nfe.fazenda.gov.br/SCAN/NfeRecepcao2/NfeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx',     'https://hom.nfe.fazenda.gov.br/SCAN/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeCancelamento2/NfeCancelamento2.asmx',   'https://hom.nfe.fazenda.gov.br/SCAN/NfeCancelamento2/NfeCancelamento2.asmx');
         LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx',   'https://hom.nfe.fazenda.gov.br/SCAN/NfeInutilizacao2/NfeInutilizacao2.asmx');
         LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx',           'https://hom.nfe.fazenda.gov.br/SCAN/NfeConsulta2/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NFeStatusServico2/NFeStatusServico2.asmx', 'https://hom.nfe.fazenda.gov.br/SCAN/NfeStatusServico2/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.nfe.fazenda.gov.br/SCAN/RecepcaoEvento/RecepcaoEvento.asmx');

         LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.nfe.fazenda.gov.br/SCAN/NfeAutorizacao/NfeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hom.nfe.fazenda.gov.br/SCAN/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
       end;
      end;
  6 : begin
       // SVC-AN SEFAZ VIRTUAL DE CONTINGENCIA - AMBIENTE NACIONAL
       // Utilizado pelas UF: AC, AL, AP, MG, PB, RJ, RS, RO, RR, SC, SE, SP, TO, DF
       case ALayOut of
         LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.svc.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx',     'https://hom.svc.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
         LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx',   'https://hom.svc.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx');
         LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx',           'https://hom.svc.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx', 'https://hom.svc.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.svc.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx');

         LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.svc.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hom.svc.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
       end;
      end;
  7 : begin
       // SVC-RS SEFAZ VIRTUAL DE CONTINGENCIA - RIO GRANDE DO SUL
       // Utilizado pelas UF: AM, BA, CE, ES, GO, MA, MT, MS, PA, PE, PI, PR, RN
       case ALayOut of
         LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',      'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
         LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
         LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

         LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
       end;
      end;
  end;
  if Result = '' then
     raise EACBrNFeException.Create('URL não disponível para o estado solicitado.');
end;

//AC,AL,AP,MA,PA,PB,PI,RJ,RN,RR,SC,SE,TO - Estados sem WebServices próprios
//Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul): AC, AL, AM, AP, MS, PB, RJ, RR, SC, SE e TO.
//Estados Emissores pela Sefaz Virtual AN (Ambiente Nacional): ES, MA, PA, PI, PR e RN.

class function NotaUtil.GetURLSVRS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',                    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',              'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',                    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',          'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://svp-ws.sefazvirtual.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro2.asmx', 'https://webservice.set.rn.gov.br/projetonfehomolog/set_nfe/servicos/CadConsultaCadastroWS.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',               'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',               'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx',         'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');

      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLSVAN(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.sefazvirtual.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeRetRecepcao2/NFeRetRecepcao2.asmx',     'https://hom.sefazvirtual.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeCancelamento2/NFeCancelamento2.asmx',   'https://hom.sefazvirtual.fazenda.gov.br/NfeCancelamento2/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeInutilizacao2/NFeInutilizacao2.asmx',   'https://hom.sefazvirtual.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/nfeconsulta2/nfeconsulta2.asmx',           'https://hom.sefazvirtual.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeStatusServico2/NFeStatusServico2.asmx', 'https://hom.sefazvirtual.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx');
//      LayNfeCadastro       : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.sefazvirtual.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.sefazvirtual.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://hom.sefazvirtual.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLAM(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRecepcao2',         'https://homnfe.sefaz.am.gov.br/services2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRetRecepcao2',      'https://homnfe.sefaz.am.gov.br/services2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeCancelamento2',     'https://homnfe.sefaz.am.gov.br/services2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeInutilizacao2',     'https://homnfe.sefaz.am.gov.br/services2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeConsulta2',         'https://homnfe.sefaz.am.gov.br/services2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeStatusServico2',    'https://homnfe.sefaz.am.gov.br/services2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/cadconsultacadastro2', 'https://homnfe.sefaz.am.gov.br/services2/services/cadconsultacadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/RecepcaoEvento',       'https://homnfe.sefaz.am.gov.br/services2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeAutorizacao',       'https://homnfe.sefaz.am.gov.br/services2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao',    'https://homnfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    (*
    case ALayOut of
      LayNfeRecepcao      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2',      'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2');
      LayNfeRetRecepcao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2',   'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2');
      LayNfeInutilizacao  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2',  'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2');
      LayNfeConsulta      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2',      'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2');
      LayNfeStatusServico : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2', 'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2');
      LayNFeCCe,
      LayNFeEvento        : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento',    'https://homnfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento');
    end;
    *)

    // Novos endereços disponibilizados para a NFC-e

    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2',      'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeRecepcao2');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2',   'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeRetRecepcao2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2',  'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2',      'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2', 'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeStatusServico2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento',    'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/RecepcaoEvento');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLBA(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeRecepcao2.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeRecepcao2.asmx');
        LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeRetRecepcao2.asmx',      'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeRetRecepcao2.asmx');
        LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeCancelamento2.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeCancelamento2.asmx');
        LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeInutilizacao2.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeInutilizacao2.asmx');
        LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeConsulta2.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeConsulta2.asmx');
        LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeStatusServico2.asmx',    'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeStatusServico2.asmx');
        LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/sre/RecepcaoEvento.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/sre/RecepcaoEvento.asmx');
      end;
     end
     else begin
      case ALayOut of
        LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeInutilizacao/NfeInutilizacao.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/NfeInutilizacao/NfeInutilizacao.asmx');
        // Alterado por Italo em 07/07/2014
        LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeConsulta/NfeConsulta.asmx',             'https://hnfe.sefaz.ba.gov.br/webservices/NfeConsulta/NfeConsulta.asmx');
        LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx',          'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/sre/recepcaoevento.asmx',                  'https://hnfe.sefaz.ba.gov.br/webservices/sre/recepcaoevento.asmx');

        LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeStatusServico/NfeStatusServico.asmx',   'https://hnfe.sefaz.ba.gov.br/webservices/NfeStatusServico/NfeStatusServico.asmx');
        LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hnfe.sefaz.ba.gov.br/webservices/NfeAutorizacao/NfeAutorizacao.asmx');
        LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLCE(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then 
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRecepcao2',         'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRetRecepcao2',      'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeCancelamento2',     'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeInutilizacao2',     'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeConsulta2',         'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeStatusServico2',    'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/CadConsultaCadastro2', 'https://nfeh.sefaz.ce.gov.br/nfe2/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/RecepcaoEvento',       'https://nfeh.sefaz.ce.gov.br/nfe2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeAutorizacao',       'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRetAutorizacao',    'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLES(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
 if AModeloDF = moNFe then
  begin
    case ALayOut of
      LayNfeCadastro : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://app.sefaz.es.gov.br/ConsultaCadastroService/CadConsultaCadastro2.asmx','https://app.sefaz.es.gov.br/ConsultaCadastroService/CadConsultaCadastro2.asmx');
      else             Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF);
    end;
  end
 else
  begin
   Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF);
  end;
end;

class function NotaUtil.GetURLGO(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRecepcao2?wsdl',         'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRecepcao2?wsdl');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRetRecepcao2?wsdl',      'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRetRecepcao2?wsdl');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeCancelamento2?wsdl',     'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeCancelamento2?wsdl');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeInutilizacao2?wsdl',     'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeInutilizacao2?wsdl');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeConsulta2?wsdl',         'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeConsulta2?wsdl');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeStatusServico2?wsdl',    'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeStatusServico2?wsdl');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/CadConsultaCadastro2?wsdl', 'https://homolog.sefaz.go.gov.br/nfe/services/v2/CadConsultaCadastro2?wsdl');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/RecepcaoEvento?wsdl',       'https://homolog.sefaz.go.gov.br/nfe/services/v2/RecepcaoEvento?wsdl');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeAutorizacao?wsdl',       'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeAutorizacao?wsdl');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRetAutorizacao?wsdl',    'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRetAutorizacao?wsdl');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMT(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRecepcao2',         'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRetRecepcao2',      'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeCancelamento2',     'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeInutilizacao2',     'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeConsulta2',         'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeStatusServico2',    'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/CadConsultaCadastro2', 'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/RecepcaoEvento',       'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeAutorizacao',       'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRetAutorizacao',    'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeAutorizacao?wsdl',    'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeAutorizacao?wsdl');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeRetAutorizacao?wsdl', 'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeRetAutorizacao?wsdl');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeInutilizacao2?wsdl',  'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeInutilizacao2?wsdl');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeConsulta2?wsdl',      'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeConsulta2?wsdl');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeStatusServico2?wsdl', 'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeStatusServico2?wsdl');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/RecepcaoEvento?wsdl',    'https://homologacao.sefaz.mt.gov.br/nfcews/services/RecepcaoEvento?wsdl');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRecepcao2',         'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRetRecepcao2',      'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeCancelamento2',     'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeInutilizacao2',     'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeConsulta2',         'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeStatusServico2',    'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeStatusServico2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/CadConsultaCadastro2', 'https://homologacao.nfe.ms.gov.br/homologacao/services2/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/RecepcaoEvento',       'https://homologacao.nfe.ms.gov.br/homologacao/services2/RecepcaoEvento');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeAutorizacao',       'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRetAutorizacao',    'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMG(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRecepcao2',         'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRetRecepcao2',      'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeCancelamento2',     'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeInutilizacao2',     'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeConsulta2',         'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeStatus2',           'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeStatus2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/cadconsultacadastro2', 'https://hnfe.fazenda.mg.gov.br/nfe2/services/cadconsultacadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/RecepcaoEvento',       'https://hnfe.fazenda.mg.gov.br/nfe2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeAutorizacao',       'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRetAutorizacao',    'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLPR(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeRecepcao2',             'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeRecepcao2');
        LayNfeRetRecepcao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeRetRecepcao2',          'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeRetRecepcao2');
        LayNfeCancelamento  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeCancelamento2',         'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeCancelamento2');
        LayNfeInutilizacao  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeInutilizacao2',         'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeInutilizacao2');
        LayNfeConsulta      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeConsulta2',             'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeConsulta2');
        LayNfeStatusServico : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeStatusServico2',        'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeStatusServico2');
        LayNfeCadastro      : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/CadConsultaCadastro2',     'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/CadConsultaCadastro2');
        LayNFeCCe,
        LayNFeEvento        : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe-evento/NFeRecepcaoEvento', 'https://homologacao.nfe2.fazenda.pr.gov.br/nfe-evento/NFeRecepcaoEvento');
      end;
     end
     else begin
      case ALayOut of
        LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeAutorizacao3',      'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeAutorizacao3');
        LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeRetAutorizacao3',   'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeRetAutorizacao3');
        LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeInutilizacao3',     'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeInutilizacao3');
        LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeConsulta3',         'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeConsulta3');
        LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeStatusServico3',    'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeStatusServico3');
        LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/CadConsultaCadastro2', 'https://homologacao.nfe.fazenda.pr.gov.br/nfe/CadConsultaCadastro2');
        LayNFeCCe,
        LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeRecepcaoEvento',    'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeRecepcaoEvento');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeAutorizacao3',    'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeAutorizacao3');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeRetAutorizacao3', 'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeRetAutorizacao3');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeInutilizacao3',   'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeInutilizacao3');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeConsulta3',       'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeConsulta3');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeStatusServico3',  'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeStatusServico3');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeRecepcaoEvento',  'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeRecepcaoEvento');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLPE(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao2',           'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao2',        'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento2',       'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao2',       'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeConsulta2',           'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeConsulta2');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico2',      'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico2');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro2',   'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/RecepcaoEvento?wsdl',    'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/RecepcaoEvento?wsdl');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeAutorizacao?wsdl',    'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeAutorizacao?wsdl');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRetAutorizacao?wsdl', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRetAutorizacao?wsdl');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLRS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',                 'https://homologacao.nfe.sefaz.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',           'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx',         'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',         'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',                 'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://sef.sefaz.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro2.asmx', 'https://sef.sefaz.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx',      'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx');

      // Incluido por Italo em 14/11/2014
      LayNfeConsNFeDest  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeConsultaDest/nfeConsultaDest.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeConsultaDest/nfeConsultaDest.asmx');
      LayNfeDownloadNFe  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeDownloadNF/nfeDownloadNF.asmx',                'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeDownloadNF/nfeDownloadNF.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',    'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLSP(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferecepcao2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeRecepcao2.asmx');
        LayNfeRetRecepcao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferetrecepcao2.asmx',      'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeRetRecepcao2.asmx');
        LayNfeCancelamento   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfecancelamento2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeCancelamento2.asmx');
        LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeinutilizacao2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeInutilizacao2.asmx');
        LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeconsulta2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeConsulta2.asmx');
        LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfestatusservico2.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeStatusServico2.asmx');
        LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/cadconsultacadastro2.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeWEB/services/cadconsultacadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/eventosWEB/services/RecepcaoEvento.asmx',   'https://homologacao.nfe.fazenda.sp.gov.br/eventosWEB/services/RecepcaoEvento.asmx');
      end;
     end
     else begin
      case ALayOut of
        LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeinutilizacao2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeinutilizacao2.asmx');
        LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeconsulta2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeconsulta2.asmx');
        LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfestatusservico2.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfestatusservico2.asmx');
        LayNfeCadastro       : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/cadconsultacadastro2.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/ws/cadconsultacadastro2.asmx');
        LayNFeCCe,                                                                                                                   
        LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/recepcaoevento.asmx',       'https://homologacao.nfe.fazenda.sp.gov.br/ws/recepcaoevento.asmx');
        LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeautorizacao.asmx',       'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeautorizacao.asmx');
        LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nferetautorizacao.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/ws/nferetautorizacao.asmx');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := DFeUtil.SeSenao(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := DFeUtil.SeSenao(AAmbiente=1, '', '');
    end;
   end;

end;

{$IFDEF ACBrNFeOpenSSL}
function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''; AModeloDF: TpcnModeloDF = moNFe;
  AVersaoDF: TpcnVersaoDF = ve200): Boolean;
var
 doc, schema_doc : xmlDocPtr;
 parser_ctxt : xmlSchemaParserCtxtPtr;
 schema : xmlSchemaPtr;
 valid_ctxt : xmlSchemaValidCtxtPtr;
 schemError : xmlErrorPtr;
 schema_filename : AnsiString;

 Tipo,I: Integer;
begin
  Tipo := NotaUtil.IdentificaTipoSchema(AXML,I) ;

 if not DirectoryExists(DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+'Schemas',PathWithDelim(APathSchemas))) then
    raise EACBrNFeException.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+'Schemas',PathWithDelim(APathSchemas)));

  if AModeloDF = moNFe then 
   begin
    case Tipo of
      1: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
      2: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
      3: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
      4: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
      5: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
      6: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      7..10: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                                 'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                 GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      11: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
      else schema_filename := '';
    end;
   end
  else 
   begin
    case Tipo of
      1: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
      2: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
      3: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
      4: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
      5: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
      6: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      7..10: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                                 'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                 GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      11: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
      else schema_filename := '';
    end;
   end;

  if not FilesExists(schema_filename) then
    raise EACBrNFeException.Create('Arquivo '+schema_filename+' não encontrado');

 //doc         := nil;
 //schema_doc  := nil;
 //parser_ctxt := nil;
 //schema      := nil;
 //valid_ctxt  := nil;

 doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
 if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

  schema_doc := xmlReadFile(Pansichar(AnsiString(ACBrStr(schema_filename))), nil, XML_DETECT_IDS);

//  the schema cannot be loaded or is not well-formed
 if (schema_doc = nil) then
  begin
    AMsg := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt  := xmlSchemaNewDocParserCtxt(schema_doc);
// unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
     begin
        xmlFreeDoc(schema_doc);
        AMsg := 'Erro: unable to create a parser context for the schema';
        Result := False;
        exit;
     end;

   schema := xmlSchemaParse(parser_ctxt);
// the schema itself is not valid
    if (schema = nil) then
     begin
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: the schema itself is not valid';
        Result := False;
        exit;
     end;

    valid_ctxt := xmlSchemaNewValidCtxt(schema);
//   unable to create a validation context for the schema */
    if (valid_ctxt = nil) then
     begin
        xmlSchemaFree(schema);
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: unable to create a validation context for the schema';
        Result := False;
        exit;
     end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
     begin
       schemError := xmlGetLastError();
       AMsg := IntToStr(schemError^.code)+' - '+schemError^.message;
       Result := False;
       exit;
     end;

    xmlSchemaFreeValidCtxt(valid_ctxt);
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    Result := True;
end;

function ValidaAssinaturaLibXML(const Axml: PAnsiChar; out Msg: AnsiString): Boolean;
{var
  doc : xmlDocPtr;
  node : xmlNodePtr;
  dsigCtx : xmlSecDSigCtxPtr;
  mngr : xmlSecKeysMngrPtr;

  Publico : String;
  Cert: TMemoryStream;
  Cert2: TStringStream;}
begin
  Result := False;
{  Publico := copy(Axml,pos('<X509Certificate>',Axml)+17,pos('</X509Certificate>',Axml)-(pos('<X509Certificate>',Axml)+17));

  Cert := TMemoryStream.Create;
  Cert2 := TStringStream.Create(Publico);
  Cert.LoadFromStream(Cert2);
       xmlSecCryptoAppKeyCertLoadMemory
  if (xmlSecCryptoAppKeysMngrCertLoadMemory(mngr,
                                        Cert.Memory,
                                        Cert.Size,
                                        xmlSecKeyDataFormatUnknown,
                                        1) < 0) then
    raise Exception.Create('Error: failed to load certificate');
  xmlSecOpenSSLAppKeyCertLoadMemory

  doc := xmlParseDoc(Axml);
  if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
    raise Exception.Create('Error: unable to parse');

  node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
  if (node = nil) then
    raise Exception.Create('Error: start node not found');

  dsigCtx := xmlSecDSigCtxCreate(nil);
  if (dsigCtx = nil) then
    raise Exception.Create('Error :failed to create signature context');



  dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Cert.Memory, Cert.Size, xmlSecKeyDataFormatPem, '', nil, nil);
  if (dsigCtx^.signKey = nil) then
    raise Exception.Create('Error: failed to load public pem key from "' + Axml + '"');}

  { Verify signature }
 { if (xmlSecDSigCtxVerify(dsigCtx, node) < 0) then
      raise Exception.Create('Error: signature verify');

  if dsigCtx.status = xmlSecDSigStatusSucceeded then
    Result := True
  else
    Result := False;

  xmlSecDSigCtxDestroy(dsigCtx);
  xmlFreeDoc(doc);}
end;
{$ELSE}
function ValidaMSXML(XML: AnsiString; out Msg: AnsiString; const APathSchemas: string = '';
                     AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
var
  DOMDocument: IXMLDOMDocument2;
  ParseError: IXMLDOMParseError;
  Schema: XMLSchemaCache;
  Tipo,I: Integer;
  schema_filename: String;
begin
  CoInitialize(nil);
  try
    Tipo := NotaUtil.IdentificaTipoSchema(XML,I) ;

    DOMDocument := CoDOMDocument50.Create;
    DOMDocument.async := False;
    DOMDocument.resolveExternals := False;
    DOMDocument.validateOnParse := True;
    DOMDocument.loadXML(XML);

    Schema := CoXMLSchemaCache50.Create;

    if not DirectoryExists(DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas))) then
       raise EACBrNFeException.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas)));

    if AModeloDF = moNFe then
     begin
      case Tipo of
        1: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
        2: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
        3: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
        4: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
        5: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
        6: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        7..10: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                                   'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                   GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        11: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
        else schema_filename := '';
      end;
     end
    else
     begin
      case Tipo of
        1: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
        2: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
        3: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
        4: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
        5: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
        6: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        7..10: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                                   'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                   GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        11: schema_filename := DFeUtil.SeSenao(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
        else schema_filename := '';
      end;
     end;

    if not FilesExists(schema_filename) then
       raise EACBrNFeException.Create('Arquivo '+schema_filename+' não encontrado');

    Schema.add( 'http://www.portalfiscal.inf.br/nfe', schema_filename );

    DOMDocument.schemas := Schema;
    ParseError := DOMDocument.validate;
    Result := (ParseError.errorCode = 0);
    Msg   := ParseError.reason;

    DOMDocument := nil;
    ParseError := nil;
    Schema := nil;
  finally
    CoUninitialize;
  end;
end;

function ValidaAssinaturaMSXML(XML: AnsiString; out Msg: AnsiString): Boolean;
var
  xmldoc  : IXMLDOMDocument3;
  xmldsig : IXMLDigitalSignature;

  pKeyInfo : IXMLDOMNode;
  pKey, pKeyOut : IXMLDSigKey;

begin
  xmldoc := CoDOMDocument50.Create;
  xmldsig := CoMXDigitalSignature50.Create;

  xmldoc.async              := False;
  xmldoc.validateOnParse    := False;
  xmldoc.preserveWhiteSpace := True;

   if (not xmldoc.loadXML(XML) ) then
      raise EACBrNFeException.Create('Não foi possível carregar o arquivo: '+XML);
  try
    xmldoc.setProperty('SelectionNamespaces', DSIGNS);
    xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

   if (xmldsig.signature = nil ) then
      raise EACBrNFeException.Create('Não foi possível carregar ou ler a assinatura: '+XML);

    pKeyInfo := xmldoc.selectSingleNode('.//ds:KeyInfo/ds:X509Data');

    pKey := xmldsig.createKeyFromNode(pKeyInfo);

    try
      pKeyOut := xmldsig.verify(pKey);
    except
       on E: Exception do
          Msg := 'Erro ao verificar assinatura do arquivo: '+ E.Message;
    end;
  finally
    Result := (pKeyOut <> nil );

    pKeyOut := nil;
    pKey := nil;
    pKeyInfo := nil;
    xmldsig := nil;
    xmldoc := nil;
  end;
end;
{$ENDIF}

class function NotaUtil.IdentificaTipoSchema(const AXML: AnsiString; var I: integer): integer;
var
 lTipoEvento: String;
begin
  I := pos('<infNFe',AXML) ;
  Result := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',AXML) ;
     if I > 0 then
        Result := 2
     else
      begin
        I := pos('<infInut',AXML) ;
        if I > 0 then
           Result := 3
        else
         begin
          I := Pos('<infEvento', AXML);
          if I > 0 then
          begin
            lTipoEvento := Trim(RetornarConteudoEntre(AXML,'<tpEvento>','</tpEvento>'));
            if lTipoEvento = '110111' then
              Result := 6 // Cancelamento
            else if lTipoEvento = '210200' then
              Result := 7 //Manif. Destinatario: Confirmação da Operação
            else if lTipoEvento = '210210' then
              Result := 8 //Manif. Destinatario: Ciência da Operação Realizada
            else if lTipoEvento = '210220' then
              Result := 9 //Manif. Destinatario: Desconhecimento da Operação
            else if lTipoEvento = '210240' then
              Result := 10 // Manif. Destinatario: Operação não Realizada
            else if lTipoEvento = '110140' then
              Result := 11 // EPEC
            else
              Result := 5; //Carta de Correção Eletrônica
          end
          else
            Result := 4; //DPEC
         end;
     end;
   end;
end;

class function NotaUtil.Valida(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = '';
  AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaLibXML(AXML,AMsg,APathSchemas, AModeloDF, AVersaoDF);
{$ELSE}
  Result := ValidaMSXML(AXML,AMsg,APathSchemas, AModeloDF, AVersaoDF);
{$ENDIF}
end;

class function NotaUtil.ValidaAssinatura(const AXML: AnsiString;
  var AMsg: AnsiString): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaAssinaturaLibXML(PAnsiChar(AXML),AMsg);
{$ELSE}
  Result := ValidaAssinaturaMSXML(AXML,AMsg);
{$ENDIF}
end;

{$IFDEF ACBrNFeOpenSSL}
function AssinarLibXML(const AXML, ArqPFX, PFXSenha : AnsiString;
  out AXMLAssinado, FMensagem: AnsiString): Boolean;
 Var I, J, PosIni, PosFim : Integer ;
     URI, AStr, XmlAss : AnsiString ;
     Tipo : Integer; // 1 - NFE 2 - Cancelamento 3 - Inutilizacao
     Cert: TMemoryStream;
     Cert2: TStringStream;
begin
  AStr := AXML ;

  //// Encontrando o URI ////
  Tipo := NotaUtil.IdentificaTipoSchema(AStr,I);

  I := DFeUtil.PosEx('Id=',AStr,I+6) ;
  if I = 0 then
     raise EACBrNFeException.Create('Não encontrei inicio do URI: Id=') ;
  I := DFeUtil.PosEx('"',AStr,I+2) ;
  if I = 0 then
     raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas inicial') ;
  J := DFeUtil.PosEx('"',AStr,I+1) ;
  if J = 0 then
     raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas final') ;

  URI := copy(AStr,I+1,J-I-1) ;

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>',AStr) ;

  case Tipo of
    1: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTD     + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    2: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTDCanc + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    3: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTDInut + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    4: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTDDpec + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    5: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTDCCe  + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    6..11: AStr := copy(AStr,1,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+1,I)))) + cDTDEven  + Copy(AStr,StrToInt(VarToStr(DFeUtil.SeSenao(I>0,I+2,I))),Length(AStr));
    else AStr := '';
  end;

  //// Inserindo Template da Assinatura digital ////
  case Tipo of
    1:
    begin
      I := pos('</NFe>',AStr) ;
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </NFe>') ;
    end;
    2:
    begin
      I := pos('</cancNFe>',AStr) ;
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </cancNFe>') ;
    end;
    3:
    begin
      I := pos('</inutNFe>',AStr) ;
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </inutNFe>') ;
    end;
    4:
    begin
      I := pos('</envDPEC>',AStr) ;
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </envDPEC>') ;
    end;
    5..11:
    begin
      I := pos('</evento>',AStr) ;
      if I = 0 then
        raise EACBrNFeException.Create('Não encontrei final do XML: </evento>') ;
    end;
    else
      raise EACBrNFeException.Create('Template de Tipo não implementado.') ;
  end;

  if pos('<Signature',AStr) > 0 then
     I := pos('<Signature',AStr);
     AStr := copy(AStr,1,I-1) +
            '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
              '<SignedInfo>'+
                '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                '<Reference URI="#'+URI+'">'+
                  '<Transforms>'+
                    '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'+
                    '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'+
                  '</Transforms>'+
                  '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />'+
                  '<DigestValue></DigestValue>'+
                '</Reference>'+
              '</SignedInfo>'+
              '<SignatureValue></SignatureValue>'+
              '<KeyInfo>'+
                '<X509Data>'+
                  '<X509Certificate></X509Certificate>'+
                '</X509Data>'+
              '</KeyInfo>'+
            '</Signature>';

  case Tipo of
    1: AStr := AStr + '</NFe>';
    2: AStr := AStr + '</cancNFe>';
    3: AStr := AStr + '</inutNFe>';
    4: AStr := AStr + '</envDPEC>';
    5..11: AStr := AStr + '</evento>';
    else AStr := '';
  end;

  if FileExists(ArqPFX) then
    XmlAss := NotaUtil.sign_file(PAnsiChar(AStr), PAnsiChar(ArqPFX), PAnsiChar(PFXSenha))
  else
   begin
    Cert := TMemoryStream.Create;
    Cert2 := TStringStream.Create(ArqPFX);
    try
      Cert.LoadFromStream(Cert2);
      XmlAss := NotaUtil.sign_memory(PAnsiChar(AStr), PAnsiChar(ArqPFX), PAnsiChar(PFXSenha), Cert.Size, Cert.Memory) ;
    finally
      Cert2.Free;
      Cert.Free;
    end;
  end;

  // Removendo quebras de linha //
  XmlAss := StringReplace( XmlAss, #10, '', [rfReplaceAll] ) ;
  XmlAss := StringReplace( XmlAss, #13, '', [rfReplaceAll] ) ;

  // Removendo DTD //
  case Tipo of
    1: XmlAss := StringReplace( XmlAss, cDTD, '', [] );
    2: XmlAss := StringReplace( XmlAss, cDTDCanc, '', [] );
    3: XmlAss := StringReplace( XmlAss, cDTDInut, '', [] );
    4: XmlAss := StringReplace( XmlAss, cDTDDpec, '', [] );
    5: XmlAss := StringReplace( XmlAss, cDTDCCe, '', [] );
    6..11: XmlAss := StringReplace( XmlAss, cDTDEven, '', [] );
    else XmlAss := '';
  end;

  PosIni := Pos('<X509Certificate>',XmlAss)-1;
  PosFim := DFeUtil.PosLast('<X509Certificate>',XmlAss);

  XmlAss := copy(XmlAss,1,PosIni)+copy(XmlAss,PosFim,length(XmlAss));

  AXMLAssinado := StringReplace( XmlAss, '<?xml version="1.0"?>', '', [] );

  Result := True;
end;
{$ELSE}
function AssinarMSXML(XML : AnsiString; Certificado : ICertificate2; out XMLAssinado : AnsiString): Boolean;
var
 I, J, PosIni, PosFim : Integer;
 URI           : String ;
 Tipo : Integer;

 xmlHeaderAntes, xmlHeaderDepois : AnsiString ;
 xmldoc  : IXMLDOMDocument3;
 xmldsig : IXMLDigitalSignature;
 dsigKey   : IXMLDSigKey;
 signedKey : IXMLDSigKey;
begin
  CoInitialize(nil);
  try
   if Pos('<Signature',XML) <= 0 then
   begin
      Tipo := NotaUtil.IdentificaTipoSchema(XML,I);

      I := DFeUtil.PosEx('Id=',XML,6) ;
      if I = 0 then
         raise EACBrNFeException.Create('Não encontrei inicio do URI: Id=') ;
      I := DFeUtil.PosEx('"',XML,I+2) ;
      if I = 0 then
         raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas inicial') ;
      J := DFeUtil.PosEx('"',XML,I+1) ;
      if J = 0 then
         raise EACBrNFeException.Create('Não encontrei inicio do URI: aspas final') ;

      URI := copy(XML,I+1,J-I-1) ;

      case Tipo of
        1: XML := copy(XML,1,pos('</NFe>',XML)-1);
        2: XML := copy(XML,1,pos('</cancNFe>',XML)-1);
        3: XML := copy(XML,1,pos('</inutNFe>',XML)-1);
        4: XML := copy(XML,1,pos('</envDPEC>',XML)-1);
        5..11: XML := copy(XML,1,pos('</evento>',XML)-1);
        else XML := '';
      end;

      XML := XML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
      XML := XML + '<Reference URI="#'+URI+'">';
      XML := XML + '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
      XML := XML + '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

      case Tipo of
        1: XML := XML + '</NFe>';
        2: XML := XML + '</cancNFe>';
        3: XML := XML + '</inutNFe>';
        4: XML := XML + '</envDPEC>';
        5..11: XML := XML + '</evento>';
        else XML := '';
      end;
   end;

   // Lendo Header antes de assinar //
   xmlHeaderAntes := '' ;
   I := pos('?>',XML) ;
   if I > 0 then
      xmlHeaderAntes := copy(XML,1,I+1) ;

   xmldoc := CoDOMDocument50.Create;

   xmldoc.async              := False;
   xmldoc.validateOnParse    := False;
   xmldoc.preserveWhiteSpace := True;

   xmldsig := CoMXDigitalSignature50.Create;

   if (not xmldoc.loadXML(XML) ) then
      raise EACBrNFeException.Create('Não foi possível carregar o arquivo: '+XML);

   xmldoc.setProperty('SelectionNamespaces', DSIGNS);

   xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

   if (xmldsig.signature = nil) then
      raise EACBrNFeException.Create('É preciso carregar o template antes de assinar.');

   if NumCertCarregado <> Certificado.SerialNumber then
      CertStoreMem := nil;

   if  CertStoreMem = nil then
    begin
      CertStore := CoStore.Create;
      CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_READ_ONLY);

      CertStoreMem := CoStore.Create;
      CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_READ_ONLY);

      Certs := CertStore.Certificates as ICertificates2;
      for i:= 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = Certificado.SerialNumber then
         begin
           CertStoreMem.Add(Cert);
           NumCertCarregado := Certificado.SerialNumber;
         end;
      end;
   end;

   OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey,PrivateKey));
   xmldsig.store := CertStoreMem;

   dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
   if (dsigKey = nil) then
      raise EACBrNFeException.Create('Erro ao criar a chave do CSP.');

   signedKey := xmldsig.sign(dsigKey, $00000002);
   if (signedKey <> nil) then
    begin
      XMLAssinado := xmldoc.xml;
      XMLAssinado := StringReplace( XMLAssinado, #10, '', [rfReplaceAll] ) ;
      XMLAssinado := StringReplace( XMLAssinado, #13, '', [rfReplaceAll] ) ;
      PosIni := Pos('<SignatureValue>',XMLAssinado)+length('<SignatureValue>');
      XMLAssinado := copy(XMLAssinado,1,PosIni-1)+StringReplace( copy(XMLAssinado,PosIni,length(XMLAssinado)), ' ', '', [rfReplaceAll] ) ;
      PosIni := Pos('<X509Certificate>',XMLAssinado)-1;
      PosFim := DFeUtil.PosLast('<X509Certificate>',XMLAssinado);

      XMLAssinado := copy(XMLAssinado,1,PosIni)+copy(XMLAssinado,PosFim,length(XMLAssinado));
    end
   else
      raise EACBrNFeException.Create('Assinatura Falhou.');

   if xmlHeaderAntes <> '' then
   begin
      I := pos('?>',XMLAssinado) ;
      if I > 0 then
       begin
         xmlHeaderDepois := copy(XMLAssinado,1,I+1) ;
         if xmlHeaderAntes <> xmlHeaderDepois then
            XMLAssinado := StuffString(XMLAssinado,1,length(xmlHeaderDepois),xmlHeaderAntes) ;
       end
      else
         XMLAssinado := xmlHeaderAntes + XMLAssinado ;
   end ;

   dsigKey   := nil;
   signedKey := nil;
   xmldoc    := nil;
   xmldsig   := nil;

   Result := True;
  finally
   CoUninitialize;
  end;
end;
{$ENDIF}

{$IFDEF ACBrNFeOpenSSL}
class function NotaUtil.Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
class function NotaUtil.Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := AssinarLibXML(AXML, ArqPFX, PFXSenha, AXMLAssinado, FMensagem);
{$ELSE}
  Result := AssinarMSXML(AXML,Certificado,AXMLAssinado);
{$ENDIF}
end;

class function NotaUtil.ValidaUFCidade(const UF, Cidade: Integer): Boolean;
begin
   Result := DFeUtil.ValidaUFCidade(UF, Cidade);
end;

class procedure NotaUtil.ValidaUFCidade(const UF, Cidade: Integer;
  const AMensagem: String);
begin
   DFeUtil.ValidaUFCidade(UF, Cidade, AMensagem);
end;

class procedure NotaUtil.ConfAmbiente;
begin
 DecimalSeparator := ',';
end;

class function NotaUtil.PathAplication: String;
begin
   Result := DFeUtil.PathAplication;
end;

class function NotaUtil.GerarChaveContingencia(FNFe:TNFe): string;
   function GerarDigito_Contigencia(var Digito: integer; chave: string): boolean;
   var
     i, j: integer;
   const
     PESO = '43298765432987654329876543298765432';
   begin
     // Manual Integracao Contribuinte v2.02a - Página: 70 //
     chave := DFeUtil.LimpaNumero(chave);
     j := 0;
     Digito := 0;
     result := True;
     try
       for i := 1 to 35 do
         j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
       Digito := 11 - (j mod 11);
       if (j mod 11) < 2 then
         Digito := 0;
     except
       result := False;
     end;
     if length(chave) <> 35 then
       result := False;
   end;
var
   wchave: string;
   wicms_s, wicms_p: string;
   wd,wm,wa: word;
   Digito: integer;
begin
   //ajustado de acordo com nota tecnica 2009.003

   //UF
   if FNFe.Dest.EnderDest.UF='EX' then
      wchave:='99' //exterior
   else
   begin
      if FNFe.Ide.tpNF=tnSaida then
         wchave:=copy(inttostr(FNFe.Dest.EnderDest.cMun),1,2) //saida
      else
         wchave:=copy(inttostr(FNFe.Emit.EnderEmit.cMun),1,2); //entrada
   end;

   //TIPO DE EMISSAO
   if FNFe.Ide.tpEmis=teContingencia then
      wchave:=wchave+'2'
   else if FNFe.Ide.tpEmis=teFSDA then
      wchave:=wchave+'5'
   else if FNFe.Ide.tpEmis=teSVCAN then
      wchave:=wchave+'6'
   else if FNFe.Ide.tpEmis=teSVCRS then
      wchave:=wchave+'7'
   else
      wchave:=wchave+'0'; //este valor caracteriza ERRO, valor tem q ser  2, 5, 6 ou 7

   //CNPJ OU CPF
   if (FNFe.Dest.EnderDest.UF='EX') then
      wchave:=wchave+DFeUtil.Poem_Zeros('0',14)
   else
      wchave:=wchave+DFeUtil.Poem_Zeros(FNFe.Dest.CNPJCPF,14);

   //VALOR DA NF
   wchave:=wchave+DFeUtil.Poem_Zeros(DFeUtil.LimpaNumero(Floattostrf(FNFe.Total.ICMSTot.vNF,ffFixed,18,2)),14);

   //DESTAQUE ICMS PROPRIO E ST
   wicms_p:='2';
   wicms_s:='2';
   if (DFeUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vICMS)) then
      wicms_p:='1';
   if (DFeUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vST)) then
      wicms_s:='1';
   wchave:=wchave+wicms_p+wicms_s;

   //DIA DA EMISSAO
   decodedate(FNFe.Ide.dEmi,wa,wm,wd);
   wchave:=wchave+DFeUtil.Poem_Zeros(inttostr(wd),2);

   //DIGITO VERIFICADOR
   GerarDigito_Contigencia(Digito,wchave);
   wchave:=wchave+inttostr(digito);

   //RETORNA A CHAVE DE CONTINGENCIA
   result:=wchave;
end;

class function NotaUtil.FormatarChaveContigencia(AValue: String): String;
begin
  AValue := DFeUtil.LimpaNumero(AValue);
  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) ;
end;

class function NotaUtil.PreparaCasasDecimais(AValue: Integer): String;
var
   i: integer;
begin
   Result:='0';
   if AValue > 0 then
      Result:=Result+'.';
   for I := 0 to AValue-1 do
      Result:=Result+'0';
end;

class function NotaUtil.CollateBr(Str: String): String;
begin
   Result := DFeUtil.CollateBr(Str);
end;

class function NotaUtil.UpperCase2(Str: String): String;
begin
   Result := DFeUtil.UpperCase2(Str);
end;

class function NotaUtil.UFtoCUF(UF : String): Integer;
var
  Codigo, i: Integer;
begin
  Codigo := -1 ;
  for i:= 0 to High(NFeUF) do
  begin
    if NFeUF[I] = UF then
      Codigo := NFeUFCodigo[I];
  end;

  if Codigo < 0 then
     Result := -1
  else
     Result := Codigo;
end;

class function NotaUtil.GetURLConsultaNFCe(const AUF : Integer; AAmbiente : TpcnTipoAmbiente) : String;
begin
  // As URLs abaixo são impressas no DANFE NFC-e e servem para que o
  // consumidor possa realizar a consulta mediante a digitação da chave de acesso.
  case AUF of
   12: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.sefaznet.ac.gov.br/nfce/', 'http://hml.sefaznet.ac.gov.br/nfce/'); //AC
   27: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //AL
   16: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //AP
   13: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://sistemas.sefaz.am.gov.br/nfceweb/formConsulta.do', 'http://homnfce.sefaz.am.gov.br/nfceweb/formConsulta.do'); //AM
   29: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //BA
   23: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //CE
   53: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //DF
   32: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //ES
   52: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //GO
   21: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.nfce.sefaz.ma.gov.br/portal/consultaNFe.do', 'http://www.hom.nfce.sefaz.ma.gov.br/portal/consultaNFe.do'); // MA
   51: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.sefaz.mt.gov.br/nfce/consultanfce',          'http://homologacao.sefaz.mt.gov.br/nfce/consultanfce');      // MT
   50: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //MS
   31: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //MG
   15: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //PA
   25: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www5.receita.pb.gov.br/atf/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1410', 'https://www6.receita.pb.gov.br/atf/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1410'); //PB
   41: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.fazenda.pr.gov.br/', 'http://www.fazenda.pr.gov.br/'); //PR
   26: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //PE
   22: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //PI
   33: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx',               'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx');              // RJ
   24: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://nfce.set.rn.gov.br/portalDFE/NFCe/ConsultaNFCe.aspx', ''); // RN
   43: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-NFC.aspx',               'https://www.sefaz.rs.gov.br/NFE/NFE-NFC.aspx');              // RS
   11: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp',  'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp'); // RO
   14: Result := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rr.gov.br/nfce/servlet/wp_consulta_nfce',  'http://200.174.88.103:8080/nfce/servlet/wp_consulta_nfce'); //RR
   42: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //SC
   35: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //SP
   28: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //SE
   17: Result := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); //TO
  end;
end;

class function NotaUtil.GetURLQRCode(const AUF : Integer; AAmbiente : TpcnTipoAmbiente;
                                     AchNFe, AcDest: String;
                                     AdhEmi: TDateTime;
                                     AvNF, AvICMS: Currency;
                                     AdigVal, AidToken, AToken: String): String;
var
 sdhEmi_HEX, sdigVal_HEX, sNF, sICMS,
 cIdToken, cTokenHom, cTokenPro, sToken,
 sEntrada, cHashQRCode, urlUF: String;
begin
  // As URLs abaixo são utilizadas para compor a URL do QR-Code que é gerado
  // e impresso no DANFE NFC-e e serve para que o consumidor possa través de
  // um leitor de QR-Code ter acesso ao DANFE completo da NFC-e
  case AUF of
   12: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.sefaznet.ac.gov.br/nfe', 'http://hml.sefaznet.ac.gov.br/nfce'); // AC
   27: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // AL
   16: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // AP
   13: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://sistemas.sefaz.am.gov.br/nfceweb/consultarNFCe.jsp', 'http://homnfce.sefaz.am.gov.br/nfceweb/consultarNFCe.jsp'); // AM
   29: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // BA
   23: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // CE
   53: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // DF
   32: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // ES
   52: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // GO
   21: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.nfce.sefaz.ma.gov.br/portal/consultarNFCe.jsp', 'http://www.hom.nfce.sefaz.ma.gov.br/portal/consultarNFCe.jsp'); // MA
   51: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.sefaz.mt.gov.br/nfce/consultanfce',             'http://homologacao.sefaz.mt.gov.br/nfce/consultanfce');         // MT
   50: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // MS
   31: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // MG
   15: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // PA
   25: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www5.receita.pb.gov.br/atf/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1410', 'https://www6.receita.pb.gov.br/atf/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1410'); //PB
   41: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaNFCe', 'www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaNFCe'); // PR
   26: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // PE
   22: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // PI
//   33: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx',              'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx');              // RJ
   33: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www4.fazenda.rj.gov.br/consultaNFCe/QRCode',         'http://www4.fazenda.rj.gov.br/consultaNFCe/QRCode');         // RJ
   24: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://nfce.set.rn.gov.br/consultarNFCe.aspx',              'http://nfce.set.rn.gov.br/consultarNFCe.aspx');              // RN
   43: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx',            'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx');            // RS
   11: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp', 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp'); // RO
   14: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'https://www.sefaz.rr.gov.br/nfce/servlet/qrcode',           'http://200.174.88.103:8080/nfce/servlet/qrcode'); // RR
   42: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // SC
   35: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', 'https://homologacao.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx'); // SP
   28: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, 'http://www.nfe.se.gov.br/portal/consultarNFCe.jsp', 'http://www.hom.nfe.se.gov.br/portal/consultarNFCe.jsp'); // SE
   17: urlUF := DFeUtil.SeSenao(AAmbiente = taProducao, '', ''); // TO
  end;

  AchNFe := OnlyNumber(AchNFe);

  // Passo 1
  // Alterado por Italo em 22/12/2014
  if AUF = 41 then
   sdhEmi_HEX  := LowerCase(AsciiToHex(DateTimeTodh(AdhEmi) + GetUTC(CodigoParaUF(AUF), AdhEmi)))
  else
   sdhEmi_HEX  := AsciiToHex(DateTimeTodh(AdhEmi) + GetUTC(CodigoParaUF(AUF), AdhEmi));


  // Passo 2
  // Alterado por Italo em 22/12/2014
  if AUF = 41 then
   sdigVal_HEX := LowerCase(AsciiToHex(AdigVal))
  else
   sdigVal_HEX := AsciiToHex(AdigVal);

  // Passo 3 e 4
  cIdToken  := AidToken;
  if DFeUtil.EstaVazio(AToken) then
     cTokenHom := Copy(AchNFe, 7, 8) + '20' + Copy(AchNFe, 3, 2) + Copy(cIdToken, 3, 4)
  else
     cTokenHom := AToken;
        
  cTokenPro := AToken;

  // Alterado por Italo em 05/06/2014
  // Essa alteração foi feita, pois algumas UF estão gerando o Token também para o Ambiente de Homologação
  // Neste caso o mesmo deve ser informado na propriedade Token caso contario deve-se atribuir a
  // essa propriedade uma String vazia
  if (AAmbiente = taHomologacao) then
   begin
     if (AToken = '') then
        cTokenHom := Copy(AchNFe, 7, 8) + '20' + Copy(AchNFe, 3, 2) + Copy(cIdToken, 3, 4)
     else
        cTokenHom := AToken;
   end
  else
     cTokenPro := AToken;

  sToken    := DFeUtil.SeSenao(AAmbiente = taProducao, cIdToken + cTokenPro, cIdToken + cTokenHom);

  sNF       := StringReplace(FormatFloat('0.00', AvNF), ',', '.', [rfReplaceAll]);
  sICMS     := StringReplace(FormatFloat('0.00', AvICMS), ',', '.', [rfReplaceAll]);

  sEntrada  := 'chNFe=' + AchNFe + '&nVersao=100&tpAmb=' + TpAmbToStr(AAmbiente) +
               DFeUtil.SeSenao(AcDest = '', '', '&cDest='+AcDest) +
               '&dhEmi=' + sdhEmi_HEX + '&vNF=' + sNF + '&vICMS=' + sICMS +
               '&digVal=' + sdigVal_HEX + '&cIdToken=';

  // Passo 5 calcular o SHA-1 da string sEntrada
  if fsHashQRCode = nil then
    fsHashQRCode := TACBrEAD.Create(nil);
  try
    cHashQRCode := fsHashQRCode.CalcularHash(sEntrada + sToken, dgstSHA1);
  except
    raise Exception.Create('Erro ao calcular Hash do QR-Code');
  end;

  // Passo 6
  Result := urlUF + '?' + sEntrada + cIdToken+ '&cHashQRCode=' + cHashQRCode;
end;

class function NotaUtil.CstatProcessado(AValue: Integer): Boolean;
begin
  case AValue of
     100: Result := True;
     110: Result := True;
     150: Result := True;
     301: Result := True;
     302: Result := True;          
  else
     Result := False;
  end;
end;

initialization

finalization
  if fsHashQRCode <> nil then
     fsHashQRCode.Free;

end.
