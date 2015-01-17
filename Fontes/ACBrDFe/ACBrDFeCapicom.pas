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

unit ACBrDFeCapicom;

interface

uses
  Classes, SysUtils,
  ACBrCAPICOM_TLB, ACBrMSXML2_TLB, JwaWinCrypt, ActiveX, ComObj,
  ACBrDFeConfiguracoes, ACBrDFeSSL;

const
  DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';

type
  { TDFeCapicom }

  TDFeCapicom = class(TDFeSSLClass)
  private
    FNumCertCarregado: String;
    FCertificado: ICertificate2;

  protected
    procedure CarregarCertificado; override;

    function GetCertDataVenc: TDateTime; override;
    function GetCertNumeroSerie: AnsiString; override;
    function GetCertSubjectName: String; override;

  public
    property Certificado: ICertificate2 read FCertificado;

    constructor Create(AConfiguracoes: TConfiguracoes);
    destructor Destroy; override;

    function Assinar(const ConteudoXML, docElement, infElement: String): String;
      override;
    function Enviar(const ConteudoXML: AnsiString; const URL: String;
      const SoapAction: String): AnsiString; override;

    function SelecionarCertificado: String; override;
  end;

implementation

uses
  ACBrUtil, ACBrDFeUtil;

{ TDFeCapicom }

constructor TDFeCapicom.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FNumCertCarregado := '';
  FCertificado := nil;
end;

destructor TDFeCapicom.Destroy;
begin

  inherited Destroy;
end;

function TDFeCapicom.SelecionarCertificado: String;
var
  Store: IStore3;
  Certs: ICertificates2;
  Certs2: ICertificates2;
begin
  Store := CoStore.Create;
  Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME,
    CAPICOM_STORE_OPEN_READ_ONLY);

  Certs := Store.Certificates as ICertificates2;
  Certs2 := Certs.Select('Certificado(s) Digital(is) disponível(is)',
    'Selecione o Certificado Digital para uso no aplicativo', False);

  if not (Certs2.Count = 0) then
    FCertificado := IInterface(Certs2.Item[1]) as ICertificate2;

  Result := GetCertNumeroSerie;
end;

procedure TDFeCapicom.CarregarCertificado;
var
  Store: IStore3;
  Certs: ICertificates2;
  Cert: ICertificate2;
  Extension: IExtension;
  i, j, k: integer;

  xmldoc: IXMLDOMDocument3;
  xmldsig: IXMLDigitalSignature;
  dsigKey: IXMLDSigKey;
  SigKey: IXMLDSigKeyEx;
  PrivateKey: IPrivateKey;
  hCryptProvider: ULONG_PTR;
  XML, Propriedades: String;
  Lista: TStringList;
begin
(*
  if (PCertCarregado <> nil) and (NumCertCarregado = FNumeroSerie) then
    Result := PCertCarregado
  else
  begin
    CoInitialize(nil); // PERMITE O USO DE THREAD
    try
      if DFeUtil.EstaVazio(FNumeroSerie) then
        raise Exception.Create(
          ACBrStr('Número de Série do Certificado Digital não especificado !'));

      Result := nil;
      Store := CoStore.Create;
      Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME,
        CAPICOM_STORE_OPEN_READ_ONLY);

      Certs := Store.Certificates as ICertificates2;
      for i := 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = FNumeroSerie then
        begin
          if DFeUtil.EstaVazio(NumCertCarregado) then
            NumCertCarregado := Cert.SerialNumber;

          PrivateKey := Cert.PrivateKey;

          if CertStoreMem = nil then
          begin
            CertStoreMem := CoStore.Create;
            CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'MemoriaACBr',
              CAPICOM_STORE_OPEN_READ_ONLY);
            CertStoreMem.Add(Cert);

            if (FSenhaCert <> '') and PrivateKey.IsHardwareDevice then
            begin
              XML := XML +
                '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
              XML := XML + '<Reference URI="#">';
              XML := XML +
                '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
              XML := XML +
                '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

              xmldoc := CoDOMDocument50.Create;
              xmldoc.async := False;
              xmldoc.validateOnParse := False;
              xmldoc.preserveWhiteSpace := True;
              xmldoc.loadXML(XML);
              xmldoc.setProperty('SelectionNamespaces', DSIGNS);

              xmldsig := CoMXDigitalSignature50.Create;
              xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');
              xmldsig.store := CertStoreMem;

              dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType,
                PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
              if (dsigKey = nil) then
                raise EACBrNFeException.Create('Erro ao criar a chave do CSP.');

              SigKey := dsigKey as IXMLDSigKeyEx;
              SigKey.getCSPHandle(hCryptProvider);

              try
                CryptSetProvParam(hCryptProvider, PP_SIGNATURE_PIN,
                  Windows.PBYTE(FSenhaCert), 0);
              finally
                CryptReleaseContext(hCryptProvider, 0);
              end;

              SigKey := nil;
              dsigKey := nil;
              xmldsig := nil;
              xmldoc := nil;
            end;
          end;

          Result := Cert;
          PCertCarregado := Result;
          FDataVenc := Cert.ValidToDate;
          FSubjectName := Cert.SubjectName;

          for J := 1 to Cert.Extensions.Count do
          begin
            Extension := IInterface(Cert.Extensions.Item[J]) as IExtension;
            Propriedades := Extension.EncodedData.Format(True);
            if (Pos('2.16.76.1.3.3', Propriedades) > 0) then
            begin
              Lista := TStringList.Create;
              try
                Lista.Text := Propriedades;
                for K := 0 to Lista.Count - 1 do
                begin
                  if (Pos('2.16.76.1.3.3', Lista.Strings[K]) > 0) then
                  begin
                    FCNPJ :=
                      StringReplace(Lista.Strings[K], '2.16.76.1.3.3=', '',
                      [rfIgnoreCase]);

                    FCNPJ := OnlyNumber(HexToAscii(RemoveString(' ', FCNPJ)));
                    break;
                  end;
                end;
              finally
                Lista.Free;
              end;
              break;
            end;
            Extension := nil;
          end;

          break;
        end;
      end;

      if not (Assigned(Result)) then
        raise EACBrNFeException.Create('Certificado Digital não encontrado!');
    finally
      CoUninitialize;
    end;
  end;
*)
end;

function TDFeCapicom.GetCertDataVenc: TDateTime;
begin
  if Assigned(FCertificado) then
    Result := FCertificado.ValidToDate
  else
    Result := 0;
end;

function TDFeCapicom.GetCertNumeroSerie: AnsiString;
begin
  if Assigned(FCertificado) then
    Result := FCertificado.SerialNumber
  else
    Result := '';
end;

function TDFeCapicom.GetCertSubjectName: String;
begin
  if Assigned(FCertificado) then
    Result := FCertificado.SubjectName
  else
    Result := '';
end;

function TDFeCapicom.Assinar(const ConteudoXML, docElement, infElement: String): String;
var
  I, PosIni, PosFim: integer;
  URI, AXml, TagEndDocElement: String;

  xmlHeaderAntes, xmlHeaderDepois: AnsiString;
  xmldoc: IXMLDOMDocument3;
  xmldsig: IXMLDigitalSignature;
  dsigKey: IXMLDSigKey;
  signedKey: IXMLDSigKey;
begin
  CoInitialize(nil);
  try
    AXml := ConteudoXML;

    if not DFeUtil.XmlEstaAssinado(AXml) then
    begin
      URI := DFeUtil.ExtraiURI(AXml);

      TagEndDocElement := '</' + docElement + '>';
      AXml := copy(AXml, 1, pos(TagEndDocElement, AXml) - 1);

      AXml := AXml + SignatureElement(URI, False) + TagEndDocElement;
    end;

    // Lendo Header antes de assinar //
    xmlHeaderAntes := '';
    I := pos('?>', AXml);
    if I > 0 then
      xmlHeaderAntes := copy(AXml, 1, I + 1);

    // Criando XMLDOC //
    xmldoc := CoDOMDocument50.Create;
    xmldoc.async := False;
    xmldoc.validateOnParse := False;
    xmldoc.preserveWhiteSpace := True;

    // Carregando o AXml em XMLDOC //
    if (not xmldoc.loadXML(AXml)) then
      raise EACBrDFeException.Create('Não foi possível carregar o arquivo: ' + AXml);

    xmldoc.setProperty('SelectionNamespaces', DSIGNS);

    // Criando Elemento de assinatura //
    xmldsig := CoMXDigitalSignature50.Create;
    // Lendo elemento de Assinatura de XMLDOC //
    xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

    if (xmldsig.signature = nil) then
      raise EACBrDFeException.Create('É preciso carregar o template antes de assinar.');

(*
    if FNumCertCarregado <> CertNumeroSerie then
      CertStoreMem := nil;

    if CertStoreMem = nil then
    begin
      CertStore := CoStore.Create;
      CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_READ_ONLY);

      CertStoreMem := CoStore.Create;
      CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_READ_ONLY);

      Certs := CertStore.Certificates as ICertificates2;
      for i := 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = Certificado.SerialNumber then
        begin
          CertStoreMem.Add(Cert);
          NumCertCarregado := Certificado.SerialNumber;
        end;
      end;
    end;

    OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey, PrivateKey));
    xmldsig.store := CertStoreMem;

    dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType,
      PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
    if (dsigKey = nil) then
      raise EACBrNFeException.Create('Erro ao criar a chave do CSP.');

    signedKey := xmldsig.sign(dsigKey, $00000002);
    if (signedKey <> nil) then
    begin
      XMLAssinado := xmldoc.xml;
      XMLAssinado := StringReplace(XMLAssinado, #10, '', [rfReplaceAll]);
      XMLAssinado := StringReplace(XMLAssinado, #13, '', [rfReplaceAll]);
      PosIni := Pos('<SignatureValue>', XMLAssinado) + length('<SignatureValue>');
      XMLAssinado := copy(XMLAssinado, 1, PosIni - 1) + StringReplace(
        copy(XMLAssinado, PosIni, length(XMLAssinado)), ' ', '', [rfReplaceAll]);
      PosIni := Pos('<X509Certificate>', XMLAssinado) - 1;
      PosFim := DFeUtil.PosLast('<X509Certificate>', XMLAssinado);

      XMLAssinado := copy(XMLAssinado, 1, PosIni) + copy(
        XMLAssinado, PosFim, length(XMLAssinado));
    end
    else
      raise EACBrNFeException.Create('Assinatura Falhou.');

    if xmlHeaderAntes <> '' then
    begin
      I := pos('?>', XMLAssinado);
      if I > 0 then
      begin
        xmlHeaderDepois := copy(XMLAssinado, 1, I + 1);
        if xmlHeaderAntes <> xmlHeaderDepois then
          XMLAssinado := StuffString(XMLAssinado, 1, length(xmlHeaderDepois),
            xmlHeaderAntes);
      end
      else
        XMLAssinado := xmlHeaderAntes + XMLAssinado;
    end;

    dsigKey := nil;
    signedKey := nil;
    xmldoc := nil;
    xmldsig := nil;

    Result := True;
    *)
  finally
    CoUninitialize;
  end;
end;

function TDFeCapicom.Enviar(const ConteudoXML: AnsiString; const URL: String;
  const SoapAction: String): AnsiString;
begin

end;

end.
