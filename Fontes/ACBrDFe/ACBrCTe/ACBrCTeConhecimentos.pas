{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimen-}
{ to de Transporte eletrônico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Desenvolvimento                                                              }
{         de Cte: Wiliam Zacarias da Silva Rosa                                }
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
|* 28/07/2009: Andre F. Moraes
|*  - Inicio do componente ACBrCTe baseado no componente ACBrCTePCN
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeConhecimentos;

interface

uses
  Classes, Sysutils, Dialogs, Forms, StrUtils,
  ACBrCTeUtil, ACBrCTeConfiguracoes,
  ACBrCTeDACTEClass,
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcteCTe, pcteCTeR, pcteCTeW, pcnConversao, pcnAuxiliar, pcnLeitor;

type

  Conhecimento = class(TCollectionItem)
  private
    FCTe: TCTe;
    FXML: AnsiString;
    FXMLOriginal: AnsiString;
    FConfirmada: Boolean;
    FMsg: AnsiString;
    FAlertas: AnsiString;
    FErroValidacao: AnsiString;
    FErroValidacaoCompleto: AnsiString;
    FNomeArq: String;
    FRegrasdeNegocios: AnsiString;

    function GetCTeXML: AnsiString;
    function GerarXML(var XML: String; var Alertas: String): String;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: String = ''): Boolean;
    function SaveToStream(Stream: TStringStream): Boolean;
    procedure EnviarEmail(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem: TStrings;
                                SSL: Boolean;
                                EnviaPDF: Boolean = true;
                                sCC: TStrings = nil;
                                Anexos: TStrings = nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS: Boolean = True;
                                UsarThread: Boolean = True;
                                HTML: Boolean = False);
    function ValidarConcatChave: Boolean;

    property CTe: TCTe                         read FCTe                   write FCTe;
    property XML: AnsiString                   read GetCTeXML              write FXML;
    property XMLOriginal: AnsiString           read FXMLOriginal           write FXMLOriginal;
    property Confirmada: Boolean               read FConfirmada            write FConfirmada;
    property Msg: AnsiString                   read FMsg                   write FMsg;
    property Alertas: AnsiString               read FAlertas               write FAlertas;
    property ErroValidacao: AnsiString         read FErroValidacao         write FErroValidacao;
    property ErroValidacaoCompleto: AnsiString read FErroValidacaoCompleto write FErroValidacaoCompleto;
    property NomeArq: String                   read FNomeArq               write FNomeArq;
    property RegrasdeNegocios: AnsiString      read FRegrasdeNegocios      write FRegrasdeNegocios;
  end;

  TConhecimentos = class(TOwnedCollection)
  private
    FConfiguracoes: TConfiguracoes;
    FACBrCTe: TComponent;

    function GetItem(Index: Integer): Conhecimento;
    procedure SetItem(Index: Integer; const Value: Conhecimento);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarCTe;
    procedure Assinar;
    procedure Valida;
    function ValidaAssinatura(out Msg: String): Boolean;
    function ValidaRegrasdeNegocios: Boolean;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: Conhecimento;
    function Insert(Index: Integer): Conhecimento;

    function GetNamePath: String; override;
    // Incluido o Parametro AGerarCTe que determina se após carregar os dados do CTe
    // para o componente, será gerado ou não novamente o XML do CTe.
    function LoadFromFile(CaminhoArquivo: String; AGerarCTe: Boolean = True): Boolean;
    function LoadFromStream(Stream: TStringStream; AGerarCTe: Boolean = True): Boolean;
    function LoadFromString(AString: String; AGerarCTe: Boolean = True): Boolean;
    function SaveToFile(PathArquivo: String = ''): Boolean;

    property Items[Index: Integer]: Conhecimento read GetItem         write SetItem;
    property Configuracoes: TConfiguracoes       read FConfiguracoes  write FConfiguracoes;
    property ACBrCTe: TComponent                 read FACBrCTe;
  end;

  TSendMailThread = class(TThread)
  private
    FException: Exception;
    // FOwner: Conhecimento;
    procedure DoHandleException;
  public
    OcorreramErros: Boolean;
    Terminado: Boolean;
    smtp: TSMTPSend;
    sFrom: String;
    sTo: String;
    sCC: TStrings;
    slmsg_Lines: TStrings;

    constructor Create;
    destructor Destroy; override;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;

implementation

uses
  ACBrCTe, ACBrUtil, ACBrDFeUtil, pcnGerador;

{ Conhecimento }

constructor Conhecimento.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FCTe := TCTe.Create;

  FCTe.Ide.tpCTe  := tcNormal;
  FCTe.Ide.modelo := '57';

  FCTe.Ide.verProc := 'ACBrCTe';
  FCTe.Ide.tpAmb   := TACBrCTe(TConhecimentos(Collection).ACBrCTe).Configuracoes.WebServices.Ambiente;
  FCTe.Ide.tpEmis  := TACBrCTe(TConhecimentos(Collection).ACBrCTe).Configuracoes.Geral.FormaEmissao;
  if Assigned(TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTe) then
     FCTe.Ide.tpImp   := TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTe.TipoDACTE;
end;

destructor Conhecimento.Destroy;
begin
  FCTe.Free;
  inherited Destroy;
end;

procedure Conhecimento.Imprimir;
begin
  if not Assigned(TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE) then
     raise Exception.Create('Componente DACTE não associado.')
  else
     TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE.ImprimirDACTE(CTe);
end;

procedure Conhecimento.ImprimirPDF;
begin
  if not Assigned(TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE) then
     raise Exception.Create('Componente DACTE não associado.')
  else
     TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE.ImprimirDACTEPDF(CTe);
end;

function Conhecimento.SaveToFile(CaminhoArquivo: String = ''): Boolean;
var
  ArqXML, Alertas, ArqTXT : String;
begin
  try
     Result := True;
     ArqTXT := GerarXML(ArqXML, Alertas);
     if DFeUtil.EstaVazio(CaminhoArquivo) then
        CaminhoArquivo := PathWithDelim(TACBrCTe(TConhecimentos(Collection).ACBrCTe).Configuracoes.Geral.PathSalvar) + copy(CTe.infCTe.ID, (length(CTe.infCTe.ID)-44)+1, 44)+'-cte.xml';

     if DFeUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo)) then
        raise EACBrCTeException.Create('Caminho Inválido: ' + CaminhoArquivo);

     WriteToTXT(CaminhoArquivo, ArqXML, False, False);

     NomeArq := CaminhoArquivo;
  except
     raise;
     Result := False;
  end;
end;

function Conhecimento.SaveToStream(Stream: TStringStream): Boolean;
var
  ArqXML, Alertas : String;
begin
  try
     Result := True;
     GerarXML(ArqXML, Alertas);
     Stream.WriteString(ArqXML);
  except
     Result := False;
  end;
end;

procedure Conhecimento.EnviarEmail(const sSmtpHost,
                                         sSmtpPort,
                                         sSmtpUser,
                                         sSmtpPasswd,
                                         sFrom,
                                         sTo,
                                         sAssunto: String;
                                         sMensagem: TStrings;
                                         SSL: Boolean;
                                         EnviaPDF: Boolean = true;
                                         sCC: TStrings = nil;
                                         Anexos: TStrings = nil;
                                         PedeConfirma: Boolean = False;
                                         AguardarEnvio: Boolean = False;
                                         NomeRemetente: String = '';
                                         TLS: Boolean = True;
                                         UsarThread: Boolean = True;
                                         HTML: Boolean = False);
var
  NomeArq: String;
  AnexosEmail: TStrings;
  StreamCTe: TStringStream;
begin
 AnexosEmail := TStringList.Create;
 StreamCTe  := TStringStream.Create('');
 try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;
    if NomeArq <> '' then
     begin
       SaveToFile(NomeArq);
       AnexosEmail.Add(NomeArq);
     end
    else
     begin
       SaveToStream(StreamCTe);
     end;
    if (EnviaPDF) then
    begin
       if TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE <> nil then
       begin
          TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE.ImprimirDACTEPDF(CTe);
          NomeArq := StringReplace(CTe.infCTe.ID,'CTe', '', [rfIgnoreCase]);
          NomeArq := PathWithDelim(TACBrCTe(TConhecimentos(Collection).ACBrCTe).DACTE.PathPDF) + NomeArq + '-cte.pdf';
          AnexosEmail.Add(NomeArq);
       end;
    end;
    TACBrCTe(TConhecimentos(Collection).ACBrCTe).EnviaEmail(sSmtpHost, sSmtpPort,
                sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sMensagem, SSL,
                sCC, AnexosEmail, PedeConfirma, AguardarEnvio, NomeRemetente,
                TLS, StreamCTe,
                copy(CTe.infCTe.ID, (length(CTe.infCTe.ID)-44)+1, 44) + '-cte.xml',
                UsarThread, HTML);
 finally
    AnexosEmail.Free;
    StreamCTe.Free;
 end;
end;

function Conhecimento.GetCTeXML: AnsiString;
var
 ArqXML, Alertas: String;
begin
 GerarXML(ArqXML, Alertas);
 Result := ArqXML;
end;

function Conhecimento.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: Word;
begin
  DecodeDate(CTe.ide.dhEmi, wAno, wMes, wDia);
  if (Copy(CTe.infCTe.ID,  4,  2) <> IntToStrZero(CTe.ide.cUF, 2)) or
     (Copy(CTe.infCTe.ID,  6,  2) <> Copy(FormatFloat('0000', wAno), 3, 2)) or
     (Copy(CTe.infCTe.ID,  8,  2) <> FormatFloat('00', wMes)) or
     (Copy(CTe.infCTe.ID, 10, 14) <> copy(OnlyNumber(CTe.Emit.CNPJ) + '00000000000000', 1, 14)) or
     (Copy(CTe.infCTe.ID, 24,  2) <> CTe.ide.modelo) or
     (Copy(CTe.infCTe.ID, 26,  3) <> IntToStrZero(CTe.ide.serie, 3)) or
     (Copy(CTe.infCTe.ID, 29,  9) <> IntToStrZero(CTe.ide.nCT, 9)) or
     (Copy(CTe.infCTe.ID, 38,  1) <> TpEmisToStr(CTe.ide.tpEmis)) or
     (Copy(CTe.infCTe.ID, 39,  8) <> IntToStrZero(CTe.ide.cCT, 8)) then
    Result := False
  else
    Result := True;
end;

function Conhecimento.GerarXML(var XML, Alertas: String): String;
var
  LocCTeW : TCTeW;
begin
  LocCTeW := TCTeW.Create(Self.CTe);
  try
     LocCTeW.Gerador.Opcoes.FormatoAlerta   := TACBrCTe(TConhecimentos(Collection).ACBrCTe).Configuracoes.Geral.FormatoAlerta;
     LocCTeW.Gerador.Opcoes.RetirarAcentos  := TACBrCTe(TConhecimentos(Collection).ACBrCTe).Configuracoes.Geral.RetirarAcentos;

     LocCTeW.GerarXml;
     XML     := LocCTeW.Gerador.ArquivoFormatoXML;
     Alertas := LocCTeW.Gerador.ListaDeAlertas.Text;
     Result  := '';
  finally
     LocCTeW.Free;
  end;
end;

{ TConhecimentos }

constructor TConhecimentos.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrCTe) then
     raise Exception.Create('AOwner deve ser do tipo TACBrCTe');

  inherited;

  FACBrCTe := TACBrCTe(AOwner);
end;


function TConhecimentos.Add: Conhecimento;
begin
  Result := Conhecimento(inherited Add);

  Result.CTe.Ide.tpAmb := Configuracoes.WebServices.Ambiente;
end;

procedure TConhecimentos.Assinar;
var
  i: Integer;
  vAssinada: AnsiString;
  ArqXML, Alertas: String;
  Leitor: TLeitor;
  FMsg: AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     Self.Items[i].GerarXML(ArqXML, Alertas);
     Self.Items[i].Alertas := Alertas;

{$IFDEF ACBrCTeOpenSSL}
     if not(CTeUtil.Assinar(ArqXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Conhecimento de Transporte Eletrônico '+
                                   IntToStr(Self.Items[i].CTe.Ide.cCT)+FMsg);
{$ELSE}
     if not(CTeUtil.Assinar(ArqXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Conhecimento de Transporte Eletrônico '+
                                   IntToStr(Self.Items[i].CTe.Ide.cCT)+FMsg);
{$ENDIF}
     vAssinada := StringReplace(vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll]);
     vAssinada := StringReplace(vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll]);
     Self.Items[i].XML := vAssinada;

     Leitor := TLeitor.Create;
     try
       leitor.Grupo := vAssinada;
       Self.Items[i].CTe.signature.URI := Leitor.rAtributo('Reference URI=');
       Self.Items[i].CTe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
       Self.Items[i].CTe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
       Self.Items[i].CTe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
     finally
       Leitor.Free;
     end;

     if FConfiguracoes.Geral.Salvar then
       FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].CTe.infCTe.ID, 'CTe', '', [rfIgnoreCase]) + '-cte.xml', vAssinada);

     if DFeUtil.NaoEstaVazio(Self.Items[i].NomeArq) then
       FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));
   end;
end;

procedure TConhecimentos.GerarCTe;
var
 i: Integer;
 ArqXML, Alertas: String;
begin
 for i:= 0 to Self.Count-1 do
  begin
    Self.Items[i].GerarXML(ArqXML, Alertas);
    Self.Items[i].XML := UTF8Encode(ArqXML);
    Self.Items[i].Alertas := Alertas;
  end;
end;

function TConhecimentos.GetItem(Index: Integer): Conhecimento;
begin
  Result := Conhecimento(inherited Items[Index]);
end;

function TConhecimentos.GetNamePath: String;
begin
  Result := 'Conhecimento';
end;

procedure TConhecimentos.Imprimir;
begin
  if not Assigned(TACBrCTe(FACBrCTe).DACTE) then
     raise Exception.Create('Componente DACTE não associado.')
  else
     TACBrCTe(FACBrCTe).DACTe.ImprimirDACTe(nil);
end;

procedure TConhecimentos.ImprimirPDF;
begin
  if not Assigned(TACBrCTe(FACBrCTe).DACTE) then
     raise Exception.Create('Componente DACTE não associado.')
  else
     TACBrCTe(FACBrCTe).DACTe.ImprimirDACTePDF(nil);
end;

function TConhecimentos.Insert(Index: Integer): Conhecimento;
begin
  Result := Conhecimento(inherited Insert(Index));
end;

procedure TConhecimentos.SetItem(Index: Integer; const Value: Conhecimento);
begin
  Items[Index].Assign(Value);
end;

procedure TConhecimentos.Valida;
var
  i: Integer;
  FMsg: AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature',Self.Items[i].XML) = 0 then
        Assinar;
     if not(CTeUtil.Valida(('<CTe xmlns' + RetornarConteudoEntre(Self.Items[i].XML, '<CTe xmlns', '</CTe>')+ '</CTe>'),
                            FMsg, Self.FConfiguracoes.Geral.PathSchemas)) then
      begin
        Self.Items[i].ErroValidacaoCompleto := 'Falha na validação dos dados do Conhecimento ' +
                                               IntToStr(Self.Items[i].CTe.Ide.nCT) + sLineBreak +
                                               Self.Items[i].Alertas + FMsg;
        Self.Items[i].ErroValidacao := 'Falha na validação dos dados do conhecimento ' +
                                       IntToStr(Self.Items[i].CTe.Ide.nCT) + sLineBreak +
                                       Self.Items[i].Alertas +
                                       IfThen(Self.FConfiguracoes.Geral.ExibirErroSchema, FMsg, '');
        raise Exception.Create(Self.Items[i].ErroValidacao);
      end;
  end;
end;

function TConhecimentos.ValidaAssinatura(out Msg: String): Boolean;
var
  i: Integer;
  FMsg: AnsiString;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
   begin
     if not(CTeUtil.ValidaAssinatura(Self.Items[i].XMLOriginal, FMsg)) then
      begin
        Result := False;
        Msg := 'Falha na validação da assinatura do conhecimento ' +
               IntToStr(Self.Items[i].CTe.Ide.nCT) + sLineBreak + FMsg
      end
     else
       Result := True;
  end;
end;

function TConhecimentos.LoadFromFile(CaminhoArquivo: String; AGerarCTe: Boolean = True): Boolean;
var
 LocCTeR: TCTeR;
 ArquivoXML: TStringList;
 XML, XMLOriginal: AnsiString;
begin
 try
    ArquivoXML := TStringList.Create;
    try
      ArquivoXML.LoadFromFile(CaminhoArquivo {$IFDEF DELPHI2009_UP}, TEncoding.UTF8{$ENDIF});
      XMLOriginal := ArquivoXML.Text;
      Result := True;
      while pos('</CTe>', ArquivoXML.Text) > 0 do
       begin
         if pos('</cteProc>', ArquivoXML.Text) > 0  then
          begin
            XML := copy(ArquivoXML.Text, 1, pos('</cteProc>', ArquivoXML.Text) + 5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</cteProc>', ArquivoXML.Text) + 10, length(ArquivoXML.Text)));
          end
         else
          begin
            XML := copy(ArquivoXML.Text, 1, pos('</CTe>', ArquivoXML.Text) + 5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</CTe>', ArquivoXML.Text) + 6,length(ArquivoXML.Text)));
          end;
         LocCTeR := TCTeR.Create(Self.Add.CTe);
         try
            LocCTeR.Leitor.Arquivo := XML;
            LocCTeR.LerXml;
            Items[Self.Count-1].XML := LocCTeR.Leitor.Arquivo;
            Items[Self.Count-1].XMLOriginal := XMLOriginal;
            Items[Self.Count-1].NomeArq := CaminhoArquivo;
            if AGerarCTe then GerarCTe;
         finally
            LocCTeR.Free;
         end;
       end;
    finally
      ArquivoXML.Free;
    end;
 except
    raise;
    Result := False;
 end;
end;

function TConhecimentos.LoadFromStream(Stream: TStringStream; AGerarCTe: Boolean = True): Boolean;
var
 LocCTeR: TCTeR;
begin
  try
    Result  := True;
    LocCTeR := TCTeR.Create(Self.Add.CTe);
    try
       LocCTeR.Leitor.CarregarArquivo(Stream);
       LocCTeR.LerXml;
       Items[Self.Count-1].XML := LocCTeR.Leitor.Arquivo;
       Items[Self.Count-1].XMLOriginal := Stream.DataString;
       if AGerarCTe then GerarCTe;
    finally
       LocCTeR.Free
    end;
  except
    Result := False;
  end;
end;

function TConhecimentos.SaveToFile(PathArquivo: String = ''): Boolean;
var
 i: integer;
 CaminhoArquivo: String;
begin
 Result := True;
 try
    for i:= 0 to TACBrCTe(FACBrCTe).Conhecimentos.Count-1 do
     begin
        if DFeUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrCTe(FACBrCTe).Configuracoes.Geral.PathSalvar
        else
           PathArquivo := ExtractFilePath(PathArquivo);
        CaminhoArquivo := PathWithDelim(PathArquivo) +
                          copy(TACBrCTe(FACBrCTe).Conhecimentos.Items[i].CTe.inFCTe.ID, (length(TACBrCTe(FACBrCTe).Conhecimentos.Items[i].CTe.inFCTe.ID)-44)+1, 44)+'-cte.xml';
        TACBrCTe(FACBrCTe).Conhecimentos.Items[i].SaveToFile(CaminhoArquivo)
     end;
 except
    Result := False;
 end;
end;

function TConhecimentos.LoadFromString(AString: String; AGerarCTe: Boolean = True): Boolean;
var
  XMLCTe: TStringStream;
begin
  try
    XMLCTe := TStringStream.Create('');
    try
      XMLCTe.WriteString(AString);
      Result := LoadFromStream(XMLCTe, AGerarCTe);
    finally
      XMLCTe.Free;
    end;
  except
    Result := False;
  end;
end;

function TConhecimentos.ValidaRegrasdeNegocios: Boolean;
var
 i: Integer;
 Erros: AnsiString;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
  begin
    Erros := '';
    if not Self.Items[i].ValidarConcatChave then
       Erros := 'Rejeição: Erro na Chave de Acesso - Campo Id não corresponde à concatenação dos campos correspondentes' + sLineBreak;

    if (Self.Items[i].CTe.ide.tpAmb <> FConfiguracoes.WebServices.Ambiente) then
       Erros := Erros + '252-Rejeição: Tipo do ambiente do CT-e difere do ambiente do Web Service' + sLineBreak;

    if (Self.Items[i].CTe.Ide.serie > 889) then
       Erros := Erros + '670-Rejeição: Série utilizada fora da faixa permitida no Web Service (0-889)' + sLineBreak;

    if copy(IntToStr(Self.Items[i].CTe.Emit.EnderEmit.cMun), 1, 2) <> IntToStr(FConfiguracoes.WebServices.UFCodigo) then
       Erros := Erros + '226-Rejeição: Código da UF do Emitente diverge da UF autorizadora' + sLineBreak;


    Self.Items[i].RegrasdeNegocios := Erros;
    if Erros <> '' then
      Result := False;
  end;
end;

{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  // FOwner.Alertas := FException.Message;

  if FException is Exception then
    Application.ShowException(FException)
  else
    SysUtils.ShowException(FException, nil);
end;

constructor TSendMailThread.Create;
begin
  smtp        := TSMTPSend.Create;
  slmsg_Lines := TStringList.Create;
  sCC         := TStringList.Create;
  sFrom       := '';
  sTo         := '';

  FreeOnTerminate := True;

  inherited Create(True);
end;

destructor TSendMailThread.Destroy;
begin
  slmsg_Lines.Free;
  sCC.Free;
  smtp.Free;

  inherited;
end;

procedure TSendMailThread.Execute;
var
  i: integer;
begin
  inherited;

  try
    Terminado := False;
    try
      if not smtp.Login() then
        raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailFrom(sFrom, Length(sFrom)) then
        raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailTo(sTo) then
        raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if (sCC <> nil) then
      begin
        for I := 0 to sCC.Count - 1 do
        begin
          if not smtp.MailTo(sCC.Strings[i]) then
            raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
        end;
      end;

      if not smtp.MailData(slmsg_Lines) then
        raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.Logout() then
        raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
    finally
      try
        smtp.Sock.CloseSocket;
      except
      end;
      Terminado := True;
    end;
  except
    Terminado := True;
    HandleException;
  end;
end;

procedure TSendMailThread.HandleException;
begin
  FException := Exception(ExceptObject);
  try
    // Não mostra mensagens de EAbort
    if not (FException is EAbort) then
      Synchronize(DoHandleException);
  finally
    FException := nil;
  end;
end;

end.
