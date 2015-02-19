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
|* 25/07/2009: Gilson Carmo
|*  - Envio do e-mail utilizando Thread
|* 24/09/2012: Italo Jurisato Junior
|*  - Alterações para funcionamento com NFC-e
*******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeNotasFiscais;

interface

uses
  Classes, Sysutils, Dialogs, Forms, StrUtils,
  ACBrNFeConfiguracoes, ACBrDFeConfiguracoes, ACBrDFeUtil,
  ACBrNFeDANFEClass,
  pcnNFe, pcnNFeR, pcnNFeW, pcnConversao, pcnAuxiliar, pcnLeitor;

type

  { NotaFiscal }

  NotaFiscal = class(TCollectionItem)
  private
    FNFe: TNFe;
    FXML: String;
    FXMLOriginal: String;
    FConfirmada: Boolean;
    FMsg: String;
    FAlertas: String;
    FErroValidacao: String;
    FErroValidacaoCompleto: String;
    FRegrasdeNegocios: String;
    FNomeArq: String;

    function GetNFeXML: String;
    function GerarXML(out XML: String; out Alertas: String; GerarTXT: Boolean = false) : String;  //SE GerarTXT = True retorna o arquivo no formato TXT, senão retorna vazio.
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: String = ''; SalvaTXT : Boolean = False): Boolean;
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
                                EnviaPDF: Boolean = True;
                                sCC: TStrings = nil;
                                Anexos: TStrings = nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS : Boolean = True;
                                UsarThread: Boolean = True;
                                HTML: Boolean = False);
    //Funções para validar Regras de Negócios
    function ValidarConcatChave: Boolean;

    property NFe: TNFe                     read FNFe                   write FNFe;
    property XML: String                   read GetNFeXML              write FXML;
    property XMLOriginal: String           read FXMLOriginal           write FXMLOriginal;
    property Confirmada: Boolean           read FConfirmada            write FConfirmada;
    property Msg: String                   read FMsg                   write FMsg;
    property Alertas: String               read FAlertas               write FAlertas;
    property ErroValidacao: String         read FErroValidacao         write FErroValidacao;
    property ErroValidacaoCompleto: String read FErroValidacaoCompleto write FErroValidacaoCompleto;
    property RegrasdeNegocios: String      read FRegrasdeNegocios      write FRegrasdeNegocios;
    property NomeArq: String                   read FNomeArq               write FNomeArq;
  end;

  { TNotasFiscais }

  TNotasFiscais = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoesNFe;
    FACBrNFe : TComponent;

    function GetItem(Index: Integer): NotaFiscal;
    procedure SetItem(Index: Integer; const Value: NotaFiscal);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFe;
    procedure Assinar;
    procedure Valida;
    function ValidaAssinatura(out Msg : String) : Boolean;
    function ValidaRegrasdeNegocios : Boolean;
    procedure Imprimir;
    procedure ImprimirResumido;
    procedure ImprimirPDF;
    procedure ImprimirResumidoPDF;
    function  Add: NotaFiscal;
    function Insert(Index: Integer): NotaFiscal;

    property Items[Index: Integer]: NotaFiscal read GetItem        write SetItem; default;

    function GetNamePath: String; override;
    // Incluido o Parametro AGerarNFe que determina se após carregar os dados da NFe
    // para o componente, será gerado ou não novamente o XML da NFe.
    function LoadFromFile(CaminhoArquivo: String; AGerarNFe: Boolean = True): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFe: Boolean = True): Boolean;
    function LoadFromString(AXMLString: String; AGerarNFe: Boolean = True): Boolean;
    function SaveToFile(PathArquivo: String = ''; SalvaTXT : Boolean = False): Boolean;
    function SaveToTXT(PathArquivo: String = ''): Boolean;

    property ACBrNFe: TComponent read FACBrNFe;
  end;

implementation

uses
  ACBrNFe, ACBrUtil, pcnGerador, pcnConversaoNFe;

{ NotaFiscal }

constructor NotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FNFe := TNFe.Create;

  case TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF of
   moNFe:  FNFe.Ide.modelo := 55;
   moNFCe: FNFe.Ide.modelo := 65;
  end;

  case TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF of
   ve200: FNFe.infNFe.Versao := 2;
   ve300: FNFe.infNFe.Versao := 3;
   ve310: FNFe.infNFe.Versao := 3.1;
  end;

  FNFe.Ide.tpNF    := tnSaida;
  FNFe.Ide.indPag  := ipVista;
  FNFe.Ide.verProc := 'ACBrNFe2';
  FNFe.Ide.tpAmb   := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.WebServices.Ambiente ;
  FNFe.Ide.tpEmis  := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormaEmissao;

  if Assigned(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE) then
     FNFe.Ide.tpImp := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.TipoDANFE;

  FNFe.Emit.EnderEmit.xPais := 'BRASIL';
  FNFe.Emit.EnderEmit.cPais := 1058;
  FNFe.Emit.EnderEmit.nro   := 'SEM NUMERO';

  if FNFe.Ide.modelo = 55 then
   begin
     FNFe.Dest.EnderDest.xPais := 'BRASIL';
     FNFe.Dest.EnderDest.cPais := 1058;
     FNFe.Dest.EnderDest.nro   := 'SEM NUMERO';
   end;
end;

destructor NotaFiscal.Destroy;
begin
  FNFe.Free;
  inherited Destroy;
end;

procedure NotaFiscal.Imprimir;
begin
  if not Assigned( TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFE(NFe);
end;

procedure NotaFiscal.ImprimirPDF;
begin
  if not Assigned( TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
end;

function NotaFiscal.SaveToFile(CaminhoArquivo: String = ''; SalvaTXT : Boolean = False): Boolean;
var
  ArqXML, Alertas, ArqTXT : String;
begin
  try
     Result := True;
     ArqTXT := GerarXML(ArqXML, Alertas, SalvaTXT);
     if DFeUtil.EstaVazio(CaminhoArquivo) then
        CaminhoArquivo := PathWithDelim(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Arquivos.PathSalvar)+copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-nfe.xml';

     if DFeUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo)) then
        raise EACBrNFeException.Create('Caminho Inválido: ' + CaminhoArquivo);

     WriteToTXT(CaminhoArquivo,ArqXML,False,False);

     if SalvaTXT then
        WriteToTXT(ChangeFileExt(CaminhoArquivo,'.txt'),ArqTXT,False,False);
     NomeArq := CaminhoArquivo;
  except
     raise;
     Result := False;
  end;
end;

function NotaFiscal.SaveToStream(Stream: TStringStream): Boolean;
var
  ArqXML, Alertas : String;
begin
  try
     Result := True;
     GerarXML(ArqXML, Alertas, False);
     Stream.WriteString(ArqXML);
  except
     Result := False;
  end;
end;

procedure NotaFiscal.EnviarEmail(const sSmtpHost,
                                      sSmtpPort,
                                      sSmtpUser,
                                      sSmtpPasswd,
                                      sFrom,
                                      sTo,
                                      sAssunto: String;
                                      sMensagem : TStrings;
                                      SSL : Boolean;
                                      EnviaPDF: Boolean = true;
                                      sCC: TStrings=nil;
                                      Anexos:TStrings=nil;
                                      PedeConfirma: Boolean = False;
                                      AguardarEnvio: Boolean = False;
                                      NomeRemetente: String = '';
                                      TLS : Boolean = True;
                                      UsarThread: Boolean = True;
                                      HTML:Boolean = False);
////var
//// NomeArq : String;
//// AnexosEmail:TStrings;
//// StreamNFe : TStringStream;
begin
  // TODO:
 ////AnexosEmail := TStringList.Create;
 ////StreamNFe  := TStringStream.Create('');
 ////try
 ////   AnexosEmail.Clear;
 ////   if Anexos <> nil then
 ////     AnexosEmail.Text := Anexos.Text;
 ////   if NomeArq <> '' then
 ////    begin
 ////      SaveToFile(NomeArq);
 ////      AnexosEmail.Add(NomeArq);
 ////    end
 ////   else
 ////    begin
 ////      SaveToStream(StreamNFe);
 ////    end;
 ////   if (EnviaPDF) then
 ////   begin
 ////      if TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE <> nil then
 ////      begin
 ////         TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
 ////         NomeArq :=  StringReplace(NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]);
 ////         NomeArq := PathWithDelim(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.PathPDF)+NomeArq+'-nfe.pdf';
 ////         AnexosEmail.Add(NomeArq);
 ////      end;
 ////   end;
 ////   TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).EnviarEmail(sSmtpHost,
 ////               sSmtpPort,
 ////               sSmtpUser,
 ////               sSmtpPasswd,
 ////               sFrom,
 ////               sTo,
 ////               sAssunto,
 ////               sMensagem,
 ////               SSL,
 ////               sCC,
 ////               AnexosEmail,
 ////               PedeConfirma,
 ////               AguardarEnvio,
 ////               NomeRemetente,
 ////               TLS,
 ////               StreamNFe,
 ////               copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-nfe.xml',
 ////               UsarThread,
 ////               HTML);
 ////finally
 ////   AnexosEmail.Free;
 ////   StreamNFe.Free;
 ////end;
end;

function NotaFiscal.GetNFeXML: String;
var
 ArqXML, Alertas: String;
begin
  GerarXML(ArqXML, Alertas, False);
  Result := ArqXML;
end;

function NotaFiscal.GerarXML(out XML: String; out Alertas: String; GerarTXT: Boolean = false) : String;
var
  LocNFeW : TNFeW;
  VersaoStr : String;
begin
  LocNFeW := TNFeW.Create(Self.NFe);
  try
     ////VersaoStr := GetVersaoNFe( TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF,
     ////                           TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF,
     ////                           LayNfeRecepcao );

     if VersaoStr = '' then
        raise EACBrNFeException.Create( 'Não existe versão do serviço "LayNfeRecepcao",'+
              ' para o modelo DF = '+ModeloDFToStr(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF)+
              ' e Versão = '+VersaoDFToStr(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF) );

     NFe.infNFe.Versao := StringToFloat(VersaoStr);

     LocNFeW.Opcoes.GerarTXTSimultaneamente := GerarTXT;
     LocNFeW.Gerador.Opcoes.FormatoAlerta   := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormatoAlerta;
     LocNFeW.Gerador.Opcoes.RetirarAcentos  := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.RetirarAcentos;
     
     LocNFeW.GerarXml;
     XML     := LocNFeW.Gerador.ArquivoFormatoXML;
     Alertas := LocNFeW.Gerador.ListaDeAlertas.Text;
     if GerarTXT then
        Result := LocNFeW.Gerador.ArquivoFormatoTXT
     else
        Result := '';
  finally
     LocNFeW.Free;
  end;
end;

function NotaFiscal.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: Word;
begin
  DecodeDate(nfe.ide.dEmi, wAno, wMes, wDia);
  if (Copy(NFe.infNFe.ID,4,2) <> IntToStrZero(nfe.ide.cUF, 2)) or
     (Copy(NFe.infNFe.ID,6,2) <> Copy(FormatFloat('0000', wAno), 3, 2)) or
     (Copy(NFe.infNFe.ID,8,2) <> FormatFloat('00', wMes)) or
     (Copy(NFe.infNFe.ID,10,14) <> copy(OnlyNumber(nfe.Emit.CNPJCPF) + '00000000000000', 1, 14)) or
     (Copy(NFe.infNFe.ID,24,2) <> IntToStrZero(nfe.ide.modelo, 2)) or
     (Copy(NFe.infNFe.ID,26,3) <> IntToStrZero(nfe.ide.serie, 3)) or
     (Copy(NFe.infNFe.ID,29,9) <> IntToStrZero(nfe.ide.nNF, 9)) or
     (Copy(NFe.infNFe.ID,38,1) <> TpEmisToStr(nfe.ide.tpEmis)) or
     (Copy(NFe.infNFe.ID,39,8) <> IntToStrZero(nfe.ide.cNF, 8)) then
    Result := False
  else
    Result := True;
end;

{ TNotasFiscais }

constructor TNotasFiscais.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFe) then
     raise EACBrNFeException.Create( 'AOwner deve ser do tipo TACBrNFe');

  inherited;

  FACBrNFe := TACBrNFe( AOwner );
  FConfiguracoes := TACBrNFe(FACBrNFe).Configuracoes;
end;


function TNotasFiscais.Add: NotaFiscal;
begin
  Result := NotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  i: Integer;
  vAssinada : String;
  ArqXML, Alertas: String;
  Leitor: TLeitor;
  FMsg : String;
begin
  for i:= 0 to Self.Count-1 do
   begin
     Self.Items[i].GerarXML(ArqXML, Alertas, False);
     // XML já deve estar em UTF8, para poder ser assinado //
     {$IFNDEF FPC}
      ArqXML := UTF8Encode(ArqXML);
     {$ENDIF}

     Self.Items[i].Alertas := Alertas;
     ////{$IFDEF ACBrNFeOpenSSL}
     //// if not(NotaUtil.Assinar(ArqXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
     ////    raise EACBrNFeException.Create('Falha ao assinar Nota Fiscal Eletrônica '+
     ////                              IntToStr(Self.Items[i].NFe.Ide.nNF)+FMsg);
     ////{$ELSE}
     //// if not(NotaUtil.Assinar(ArqXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
     ////    raise EACBrNFeException.Create('Falha ao assinar Nota Fiscal Eletrônica '+
     ////                              IntToStr(Self.Items[i].NFe.Ide.nNF)+FMsg);
     ////{$ENDIF}

     vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] );
     vAssinada := StringReplace( vAssinada, '<'+XML_V01+'>', '', [rfReplaceAll] );
     Self.Items[i].XMLOriginal := vAssinada;

     Leitor := TLeitor.Create;
     leitor.Grupo := vAssinada;
     Self.Items[i].NFe.signature.URI := Leitor.rAtributo('Reference URI=');
     Self.Items[i].NFe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
     Self.Items[i].NFe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
     Self.Items[i].NFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
     Leitor.Free;

     vAssinada := '<'+ENCODING_UTF8+'>' + vAssinada ;  // Sinaliza no Arquivo que o formato é UTF8, também evita novo UTF8Encode

     ////if FConfiguracoes.Geral.Salvar then
     ////   FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml', vAssinada);
     ////
     //// if DFeUtil.NaoEstaVazio(Self.Items[i].NomeArq) then
     ////   FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));
   end;
end;

procedure TNotasFiscais.GerarNFe;
var
  i: Integer;
  ArqXML, Alertas: String;
begin
  for i:= 0 to Self.Count-1 do
  begin
    Self.Items[i].GerarXML(ArqXML, Alertas, False);
    Self.Items[i].XML     := ArqXML;
    Self.Items[i].Alertas := Alertas;
  end;
end;

function TNotasFiscais.GetItem(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: String;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.Imprimir;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFE(nil);
end;

procedure TNotasFiscais.ImprimirResumido;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEResumido(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEPDF(nil);
end;

procedure TNotasFiscais.ImprimirResumidoPDF;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEResumidoPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: NotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Valida;
var
 i: Integer;
 FMsg, Erro : String;
 NotaEhValida: Boolean;
begin
  for i:= 0 to Self.Count-1 do
  begin
    if pos('<Signature',Self.Items[i].XMLOriginal) = 0 then
      Assinar;

    ////NotaEhValida := NotaUtil.Valida(('<NFe xmlns' +
    ////                RetornarConteudoEntre(Self.Items[i].XMLOriginal,
    ////                               '<NFe xmlns', '</NFe>')+ '</NFe>'),
    ////                FMsg, Self.FConfiguracoes.Geral.PathSchemas,
    ////                Self.FConfiguracoes.Geral.ModeloDF,
    ////                Self.FConfiguracoes.Geral.VersaoDF) ;

    if not NotaEhValida then
    begin
      Erro := 'Falha na validação dos dados da nota '+
              IntToStr(Self.Items[i].NFe.Ide.nNF)+sLineBreak+
              Self.Items[i].Alertas ;

      Self.Items[i].ErroValidacaoCompleto := Erro + FMsg;
      Self.Items[i].ErroValidacao := Erro +
                                     IfThen(Self.FConfiguracoes.Geral.ExibirErroSchema,FMsg,'');

      raise EACBrNFeException.Create(Self.Items[i].ErroValidacao);
    end;
  end;
end;

function TNotasFiscais.ValidaAssinatura(out Msg : String) : Boolean;
var
 i: Integer;
 FMsg : String;
begin
  Result := True;
  Msg    := '';
  for i:= 0 to Self.Count-1 do
  begin
    ////if not(NotaUtil.ValidaAssinatura(Self.Items[i].XMLOriginal, FMsg)) then
    ////begin
    ////  Result := False;
    ////  Msg := Msg + 'Falha na validação da assinatura da nota '+
    ////         IntToStr(Self.Items[i].NFe.Ide.nNF)+sLineBreak+FMsg+sLineBreak;
    ////  Result := False;
    ////end
  end;
end;

function TNotasFiscais.ValidaRegrasdeNegocios: Boolean;
var
 i: Integer;
 Erros : String;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
  begin
    Erros := '';
    if not Self.Items[i].ValidarConcatChave then  //A03-10
       Erros := '502-Rejeição: Erro na Chave de Acesso - Campo Id não corresponde à concatenação dos campos correspondentes'+sLineBreak;

    if copy(IntToStr(Self.Items[i].NFe.Emit.EnderEmit.cMun),1,2) <> IntToStr(FConfiguracoes.WebServices.UFCodigo) then //B02-10
       Erros := Erros + '226-Rejeição: Código da UF do Emitente diverge da UF autorizadora'+sLineBreak;

    if (Self.Items[i].NFe.Ide.serie > 899) and  //B07-20
       (Self.Items[i].NFe.Ide.tpEmis <> teSCAN)then
       Erros := Erros + '503-Rejeição: Série utilizada fora da faixa permitida no SCAN (900-999)'+sLineBreak;

    if (Self.Items[i].NFe.Ide.dEmi > now) then  //B09-10
       Erros := Erros + '703-Rejeição: Data-Hora de Emissão posterior ao horário de recebimento'+sLineBreak;

    if ((now - Self.Items[i].NFe.Ide.dEmi) > 30) then  //B09-20
       Erros := Erros + '228-Rejeição: Data de Emissão muito atrasada'+sLineBreak;

    //GB09.02 - Data de Emissão posterior à 31/03/2011
    //GB09.03 - Data de Recepção posterior à 31/03/2011 e tpAmb (B24) = 2

    if not ValidarMunicipio(Self.Items[i].NFe.Ide.cMunFG) then //B12-10
       Erros := Erros + '270-Rejeição: Código Município do Fato Gerador: dígito inválido'+sLineBreak;

    if (UFparaCodigo(Self.Items[i].NFe.Emit.EnderEmit.UF)<>StrToIntDef(copy(IntToStr(Self.Items[i].NFe.Ide.cMunFG),1,2),0)) then//GB12.1
       Erros := Erros + '271-Rejeição: Código Município do Fato Gerador: difere da UF do emitente'+sLineBreak;

    if((Self.Items[i].NFe.Ide.tpEmis in [teSCAN,teSVCAN,teSVCRS]) and
       (FConfiguracoes.Geral.FormaEmissao = teNormal)) then  //B22-30
       Erros := Erros + '570-Rejeição: Tipo de Emissão 3, 6 ou 7 só é válido nas contingências SCAN/SVC'+sLineBreak;

    if((Self.Items[i].NFe.Ide.tpEmis <> teSCAN) and
       (FConfiguracoes.Geral.FormaEmissao = teSCAN)) then  //B22-40
       Erros := Erros + '571-Rejeição: Tipo de Emissão informado diferente de 3 para contingência SCAN'+sLineBreak;

    if((FConfiguracoes.Geral.FormaEmissao in [teSVCAN,teSVCRS]) and
       (not (Self.Items[i].NFe.Ide.tpEmis in [teSVCAN,teSVCRS]))) then  //B22-60
       Erros := Erros + '713-Rejeição: Tipo de Emissão diferente de 6 ou 7 para contingência da SVC acessada'+sLineBreak;

    //B23-10   

    if(Self.Items[i].NFe.Ide.tpAmb <> FConfiguracoes.WebServices.Ambiente) then  //B24-10
       Erros := Erros + '252-Rejeição: Ambiente informado diverge do Ambiente de recebimento '+
                        '(Tipo do ambiente da NF-e difere do ambiente do Web Service)'+sLineBreak;

    if (not (Self.Items[i].NFe.Ide.procEmi in [peAvulsaFisco, peAvulsaContribuinte])) and
       (Self.Items[i].NFe.Ide.serie > 889) then //B26-10
       Erros := Erros + '266-Rejeição: Série utilizada fora da faixa permitida no Web Service (0-889)'+sLineBreak;

    if (Self.Items[i].NFe.Ide.procEmi in[peAvulsaFisco, peAvulsaContribuinte]) and
       (Self.Items[i].NFe.Ide.serie < 890) and
       (Self.Items[i].NFe.Ide.serie > 899) then //B26-20
       Erros := Erros + '451-Rejeição: Processo de emissão informado inválido'+sLineBreak;

    if (Self.Items[i].NFe.Ide.procEmi in[peAvulsaFisco, peAvulsaContribuinte]) and
       (Self.Items[i].NFe.Ide.tpEmis <> teNormal) then //B26-30
       Erros := Erros + '370-Rejeição: Nota Fiscal Avulsa com tipo de emissão inválido'+sLineBreak;

    if (Self.Items[i].NFe.Ide.tpEmis = teNormal) and
       ((Self.Items[i].NFe.Ide.xJust > '') or (Self.Items[i].NFe.Ide.dhCont <> 0)) then //B28-10
       Erros := Erros + '556-Justificativa de entrada em contingência não deve ser informada para tipo de emissão normal'+sLineBreak;

    if (Self.Items[i].NFe.Ide.tpEmis in[teContingencia, teDPEC, teFSDA, teOffLine]) and
       (Self.Items[i].NFe.Ide.xJust = '') then //B28-20
       Erros := Erros + '557-A Justificativa de entrada em contingência deve ser informada'+sLineBreak;

    if (Self.Items[i].NFe.Ide.dhCont > now) then //B28-30
       Erros := Erros + '558-Rejeição: Data de entrada em contingência posterior a data de recebimento'+sLineBreak;
    if (Self.Items[i].NFe.Ide.dhCont > 0) and
       ((now - Self.Items[i].NFe.Ide.dhCont) > 30)then //B28-40
       Erros := Erros + '559-Rejeição: Data de entrada em contingência muito atrasada'+sLineBreak;

    if (Self.Items[i].NFe.Ide.modelo = 65) then  //Regras válidas apenas para NFC-e - 65
     begin
       if (Self.Items[i].NFe.Ide.dEmi < now-StrToTime('00:05:00')) and
          (Self.Items[i].NFe.Ide.tpEmis in [teNormal,teSCAN,teSVCAN,teSVCRS]) then  //B09-40
          Erros := Erros + '704-Rejeição: NFC-e com Data-Hora de emissão atrasada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.dSaiEnt <> 0) then  //B10-10
          Erros := Erros + '705-Rejeição: NFC-e com data de entrada/saída'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpNF = tnEntrada) then  //B11-10
          Erros := Erros + '706-Rejeição: NFC-e para operação de entrada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.idDest <> doInterna) then  //B11-10
          Erros := Erros + '707-NFC-e para operação interestadual ou com o exterior'+sLineBreak;

       if (not (Self.Items[i].NFe.Ide.tpImp in[tiNFCe, tiNFCeA4, tiMsgEletronica])) then  //B21-10
          Erros := Erros + '709-Rejeição: NFC-e com formato de DANFE inválido'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpEmis = teOffLine) and
          (AnsiIndexStr(Self.Items[i].NFe.Emit.EnderEmit.UF,['SP']) <> -1) then  //B22-20
          Erros := Erros + '712-Rejeição: NF-e com contingência off-line'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpEmis in [teDPEC]) then  //B22-34
          Erros := Erros + '714-Rejeição: NFC-e com contingência DPEC inexistente'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpEmis = teSCAN) then //B22-50
          Erros := Erros + '782-Rejeição: NFC-e não é autorizada pelo SCAN'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpEmis in [teSVCAN,teSVCRS]) then  //B22-70
          Erros := Erros + '783-Rejeição: NFC-e não é autorizada pela SVC'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe <> fnNormal) then  //B25-20
          Erros := Erros + '715-Rejeição: Rejeição: NFC-e com finalidade inválida'+sLineBreak;

       if (Self.Items[i].NFe.Ide.indFinal = cfNao) then //B25a-10
          Erros := Erros + '716-Rejeição: NFC-e em operação não destinada a consumidor final'+sLineBreak;

       if (not (Self.Items[i].NFe.Ide.indPres in[pcPresencial, pcEntregaDomicilio])) then //B25b-20
          Erros := Erros + '717-Rejeição: NFC-e em operação não presencial'+sLineBreak;

       if (Self.Items[i].NFe.Ide.indPres =  pcEntregaDomicilio) and
          (AnsiIndexStr(Self.Items[i].NFe.Emit.EnderEmit.UF,['XX']) <> -1) then //B25b-30  Qual estado não permite entrega a domicílio?
          Erros := Erros + '785-Rejeição: NFC-e com entrega a domicílio não permitida pela UF'+sLineBreak;

       if (Self.Items[i].NFe.Ide.NFref.Count > 0) then  //BA01-10
          Erros := Erros + '708-Rejeição: NFC-e não pode referenciar documento fiscal'+sLineBreak;


          

       if (Self.Items[i].NFe.Emit.IEST > '') then  //C18-10
          Erros := Erros + '718-Rejeição: NFC-e não deve informar IE de Substituto Tributário'+sLineBreak;
     end;

    if (Self.Items[i].NFe.Ide.modelo = 55) then  //Regras válidas apenas para NF-e - 55
     begin
       if ((Self.Items[i].NFe.Ide.dSaiEnt - now) > 30) then  //B10-20  - Facultativo
          Erros := Erros + '504-Rejeição: Data de Entrada/Saída posterior ao permitido'+sLineBreak;

       if ((now - Self.Items[i].NFe.Ide.dSaiEnt) > 30) then  //B10-30  - Facultativo
          Erros := Erros + '505-Rejeição: Data de Entrada/Saída anterior ao permitido'+sLineBreak;

       if (Self.Items[i].NFe.Ide.dSaiEnt < Self.Items[i].NFe.Ide.dEmi) then  //B10-40  - Facultativo
          Erros := Erros + '506-Rejeição: Data de Saída menor que a Data de Emissão'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpImp in[tiNFCe, tiMsgEletronica]) then  //B21-20
          Erros := Erros + '710-Rejeição: NF-e com formato de DANFE inválido'+sLineBreak;

       if (Self.Items[i].NFe.Ide.tpEmis = teOffLine) then  //B22-10
          Erros := Erros + '711-Rejeição: NF-e com contingência off-line'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnComplementar) and
          (Self.Items[i].NFe.Ide.NFref.Count = 0) then  //B25-30
          Erros := Erros + '254-Rejeição: NF-e complementar não possui NF referenciada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnComplementar) and
          (Self.Items[i].NFe.Ide.NFref.Count > 1) then  //B25-40
          Erros := Erros + '255-Rejeição: NF-e complementar possui mais de uma NF referenciada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnComplementar) and
          (Self.Items[i].NFe.Ide.NFref.Count = 1) and
          ( ((Self.Items[i].NFe.Ide.NFref.Items[0].RefNF.CNPJ > '') and (Self.Items[i].NFe.Ide.NFref.Items[0].RefNF.CNPJ <>  Self.Items[i].NFe.Emit.CNPJCPF)) or
            ((Self.Items[i].NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF > '') and (Self.Items[i].NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF <>  Self.Items[i].NFe.Emit.CNPJCPF)) ) then  //B25-50
          Erros := Erros + '269-Rejeição: CNPJ Emitente da NF Complementar difere do CNPJ da NF Referenciada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnComplementar) and
          (Self.Items[i].NFe.Ide.NFref.Count = 1) and //Testa pelo número para saber se TAG foi preenchida
          ( ((Self.Items[i].NFe.Ide.NFref.Items[0].RefNF.nNF > 0) and (Self.Items[i].NFe.Ide.NFref.Items[0].RefNF.cUF <>  UFparaCodigo(Self.Items[i].NFe.Emit.EnderEmit.UF))) or
            ((Self.Items[i].NFe.Ide.NFref.Items[0].RefNFP.nNF > 0) and (Self.Items[i].NFe.Ide.NFref.Items[0].RefNFP.cUF <>  UFparaCodigo(Self.Items[i].NFe.Emit.EnderEmit.UF))) ) then  //B25-60 - Facultativo
          Erros := Erros + '678-Rejeição: NF referenciada com UF diferente da NF-e complementar'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnDevolucao) and
          (Self.Items[i].NFe.Ide.NFref.Count = 0) then  //B25-70
          Erros := Erros + '321-Rejeição: NF-e devolução não possui NF referenciada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.finNFe = fnDevolucao) and
          (Self.Items[i].NFe.Ide.NFref.Count > 1) then  //B25-80
          Erros := Erros + '322-Rejeição: NF-e devolução possui mais de uma NF referenciada'+sLineBreak;

       if (Self.Items[i].NFe.Ide.indPres = pcEntregaDomicilio) then //B25b-10
          Erros := Erros + '794-Rejeição: NF-e com indicativo de NFC-e com entrega a domicílio'+sLineBreak;

     end;

    Self.Items[i].RegrasdeNegocios := Erros;
    if Erros <> '' then
      Result := False;
  end;
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: String; AGerarNFe: Boolean = True): Boolean;
var
  ArquivoXML: TStringList;
  XMLOriginal, XML, Alertas : String;
  i: Integer;
begin
  Result := True;
  try
    ArquivoXML := TStringList.Create;
    try
      ArquivoXML.LoadFromFile(CaminhoArquivo);
      XMLOriginal := ArquivoXML.Text;

      // Converte de UTF8 para a String nativa da IDE //
      XML := DecodeToString(XMLOriginal, True);

      LoadFromString(XML);

      for i := 0 to Self.Count-1 do
      begin
        if AGerarNFe then
        begin
          XML := '';
          Self.Items[i].GerarXML(XML, Alertas, False);
          Self.Items[i].XML := XML;
        end;

        Self.Items[i].NomeArq := CaminhoArquivo;
      end;
    finally
      ArquivoXML.Free;
    end;
  except
    Result := False;
    raise;
  end;
end;

function TNotasFiscais.LoadFromStream(AStream: TStringStream; AGerarNFe: Boolean = True): Boolean;
var
  XMLOriginal : String;
begin
  try
    Result           := True;
    XMLOriginal      := '';
    AStream.Position := 0;
    SetLength(XMLOriginal, AStream.Size);
    AStream.ReadBuffer(XMLOriginal[1], AStream.Size);

    LoadFromString(XMLOriginal, AGerarNFe);
  except
    Result := False;
    raise;
  end;
end;

function TNotasFiscais.LoadFromString(AXMLString: String; AGerarNFe: Boolean = True): Boolean;
var
  LocNFeR : TNFeR;
  XML : String;
  Ok: Boolean;
  Versao: String;
  P: Integer;
begin
  Result := True;
  try
    while pos('</NFe>',AXMLString) > 0 do
    begin
      if pos('</nfeProc>',AXMLString) > 0  then
      begin
        P   := pos('</nfeProc>',AXMLString);
        XML := copy(AXMLString,1,P+5);
        AXMLString := Trim(copy(AXMLString,P+10,length(AXMLString)));
      end
      else
      begin
        P   := pos('</NFe>',AXMLString);
        XML := copy(AXMLString,1,P+5);
        AXMLString := Trim(copy(AXMLString,P+6,length(AXMLString)));
      end;

      LocNFeR := TNFeR.Create(Self.Add.NFe);
      try
        LocNFeR.Leitor.Arquivo := XML;
        LocNFeR.LerXml;

        // Detecta o modelo e a versão do Documento Fiscal
        FConfiguracoes.Geral.ModeloDF := StrToModeloDF(OK, IntToStr(LocNFeR.NFe.Ide.modelo));
        Versao := LocNFeR.NFe.infNFe.VersaoStr;
        Versao := StringReplace(Versao, 'versao="', '', [rfReplaceAll,rfIgnoreCase]);
        Versao := StringReplace(Versao, '"', '', [rfReplaceAll,rfIgnoreCase]);
        FConfiguracoes.Geral.VersaoDF := StrToVersaoDF(OK, Versao);

        Items[Self.Count-1].XML         := XML;
        Items[Self.Count-1].XMLOriginal := XML;
      finally
        LocNFeR.Free;
      end;
    end;

    if AGerarNFe then
      GerarNFe;
  except
    Result := False;
    raise;
  end;
end;

function TNotasFiscais.SaveToFile(PathArquivo: String = ''; SalvaTXT : Boolean = False): Boolean;
var
 i : Integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if DFeUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrNFe( FACBrNFe ).Configuracoes.Arquivos.PathSalvar
        else
           PathArquivo := ExtractFilePath(PathArquivo);
        CaminhoArquivo := PathWithDelim(PathArquivo)+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(CaminhoArquivo, SalvaTXT);
     end;
 except
    Result := False;
 end;
end;

function TNotasFiscais.SaveToTXT(PathArquivo: String): Boolean;
var
  loSTR: TStringList;
  ArqXML, Alertas, ArqTXT : String;
  I,J: Integer;
begin
  Result:=False;
  loSTR := TStringList.Create;
  try
    loSTR.Clear;
    for I := 0 to Self.Count - 1 do
    begin
      ArqTXT := Self.Items[I].GerarXML(ArqXML, Alertas, True);
      // loSTR.Text := ArqTXT;
      loSTR.Add(ArqTXT);
    end;
    
    if loSTR.Count > 0 then
    begin
      loSTR.Insert(0,'NOTA FISCAL|'+IntToStr(Self.Count));
      J:=loSTR.Count;
      i:=0;
      while (I <= J-1) do
      begin
        if loSTR.Strings[I] = '' then
        begin
          loSTR.Delete(I);
          J:=J-1;
        end
        else
          I:=I+1;
      end;

      if DFeUtil.EstaVazio(PathArquivo) then
        PathArquivo := PathWithDelim(TACBrNFe( FACBrNFe ).Configuracoes.Arquivos.PathSalvar)+'NFe.TXT';
      loSTR.SaveToFile(PathArquivo);
      Result:=True;
    end;
  finally
    loSTR.free;
  end;
end;

end.


(*  TODO: para onde vai

TSendMailThread = class(TThread)
private
  FException : Exception;
  //FOwner: NotaFiscal;

  procedure DoHandleException;
public
  OcorreramErros: Boolean;
  Terminado: Boolean;
  smtp : TSMTPSend;
  sFrom : String;
  sTo : String;
  sCC : TStrings;
  slmsg_Lines : TStrings;

  constructor Create;
  destructor Destroy; override;
protected
  procedure Execute; override;
  procedure HandleException;
end;



{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  //TACBrNFe(TNotasFiscais(FOwner.GetOwner).ACBrNFe).SetStatus( stIdle );
  //FOwner.Alertas := FException.Message;

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
   I: Integer;
begin
  inherited;

  try
    Terminado := False;
    try
      if not smtp.Login() then
        raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailFrom( sFrom, Length(sFrom)) then
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


*)
