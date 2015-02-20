{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
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
  Classes, SysUtils, Dialogs, Forms, StrUtils,
  ACBrNFeConfiguracoes, ACBrDFeConfiguracoes, ACBrDFeUtil,
  ACBrNFeDANFEClass,
  pcnNFe, pcnNFeR, pcnNFeW, pcnConversao, pcnAuxiliar, pcnLeitor;

type

  { NotaFiscal }

  NotaFiscal = class(TCollectionItem)
  private
    FNFe: TNFe;
    FNFeW: TNFeW;

    FXML: String;
    FXMLAssinado: String;
    FXMLOriginal: String;
    FMsg: String;
    FAlertas: String;
    FErroValidacao: String;
    FErroValidacaoCompleto: String;
    FErroRegrasdeNegocios: String;
    FNomeArq: String;

    //Funções para validar Regras de Negócios
    function GetConfirmada: Boolean;
    function GetMsg: String;
    function GetProcessada: Boolean;
    function ValidarConcatChave: Boolean;
    function CalcularNomeArquivo: String;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;

    procedure Assinar;
    function Validar: Boolean;
    function VerificarAssinatura: Boolean;
    function ValidarRegrasdeNegocios: Boolean;

    function GerarXML: String;
    function GravarXML(CaminhoArquivo: String = ''): Boolean;

    function GerarTXT: String;
    function GravarTXT(CaminhoArquivo: String = ''): Boolean;

    function SaveToStream(AStream: TStream): Boolean;
    procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; EnviaPDF: Boolean = True; sCC: TStrings = nil;
      Anexos: TStrings = nil; PedeConfirma: Boolean = False;
      AguardarEnvio: Boolean = False; NomeRemetente: String = '';
      TLS: Boolean = True; UsarThread: Boolean = True; HTML: Boolean = False);

    property NomeArq: String read FNomeArq write FNomeArq;

    property NFe: TNFe read FNFe ;
    property XML: String read FXML ;
    property XMLOriginal: String read FXMLOriginal write FXMLOriginal;
    property XMLAssinado: String read FXMLAssinado;
    property Confirmada: Boolean read GetConfirmada;
    property Processada: Boolean read GetProcessada;
    property Msg: String read GetMsg;
    property Alertas: String read FAlertas;
    property ErroValidacao: String read FErroValidacao;
    property ErroValidacaoCompleto: String read FErroValidacaoCompleto;
    property ErroRegrasdeNegocios: String read FErroRegrasdeNegocios;

  end;

  { TNotasFiscais }

  TNotasFiscais = class(TOwnedCollection)
  private
    FACBrNFe: TComponent;
    FConfiguracoes: TConfiguracoesNFe;

    function GetItem(Index: integer): NotaFiscal;
    procedure SetItem(Index: integer; const Value: NotaFiscal);

    procedure VerificarDANFE;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFe;
    procedure Assinar;
    procedure Validar;
    procedure VerificarAssinatura;
    procedure ValidarRegrasdeNegocios;
    procedure Imprimir;
    procedure ImprimirResumido;
    procedure ImprimirPDF;
    procedure ImprimirResumidoPDF;
    function Add: NotaFiscal;
    function Insert(Index: integer): NotaFiscal;

    property Items[Index: integer]: NotaFiscal read GetItem write SetItem; default;

    function GetNamePath: String; override;
    // Incluido o Parametro AGerarNFe que determina se após carregar os dados da NFe
    // para o componente, será gerado ou não novamente o XML da NFe.
    function LoadFromFile(CaminhoArquivo: String; AGerarNFe: Boolean = True): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFe: Boolean = True): Boolean;
    function LoadFromString(AXMLString: String; AGerarNFe: Boolean = True): Boolean;
    function SaveToFile(PathArquivo: String = ''; SalvaTXT: Boolean = False): Boolean;
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
  FNFeW := TNFeW.Create(FNFe);

  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    FNFe.Ide.modelo := StrToInt(ModeloDFToStr(Configuracoes.Geral.ModeloDF));
    FNFe.infNFe.Versao := VersaoDFToDbl(Configuracoes.Geral.VersaoDF);

    FNFe.Ide.tpNF := tnSaida;
    FNFe.Ide.indPag := ipVista;
    FNFe.Ide.verProc := 'ACBrNFe2';
    FNFe.Ide.tpAmb := Configuracoes.WebServices.Ambiente;
    FNFe.Ide.tpEmis := Configuracoes.Geral.FormaEmissao;

    if Assigned(DANFE) then
      FNFe.Ide.tpImp := DANFE.TipoDANFE;

    FNFe.Emit.EnderEmit.xPais := 'BRASIL';
    FNFe.Emit.EnderEmit.cPais := 1058;
    FNFe.Emit.EnderEmit.nro := 'SEM NUMERO';
  end;
end;

destructor NotaFiscal.Destroy;
begin
  FNFeW.Free;
  FNFe.Free;
  inherited Destroy;
end;

procedure NotaFiscal.Imprimir;
begin
  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    if not Assigned(DANFE) then
      raise EACBrNFeException.Create('Componente DANFE não associado.')
    else
      DANFE.ImprimirDANFE(NFe);
  end;
end;

procedure NotaFiscal.ImprimirPDF;
begin
  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    if not Assigned(DANFE) then
      raise EACBrNFeException.Create('Componente DANFE não associado.')
    else
      DANFE.ImprimirDANFEPDF(NFe);
  end;
end;

procedure NotaFiscal.Assinar;
var
  i: integer;
  XMLAss: String;
  ArqXML, Alertas: String;
  Leitor: TLeitor;
  FMsg: String;
begin
  Alertas := '';
  ArqXML := GerarXML;

  // XML já deve estar em UTF8, para poder ser assinado //
  ArqXML := DFeUtil.ConverteXMLtoUTF8(ArqXML);
  FXMLOriginal := ArqXML;

  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    XMLAss := SSL.Assinar(ArqXML, 'NFe', 'infNFe');
    FXMLAssinado := XMLAss;

    // Remove header, pois podem existir várias Notas no XML //
    //XMLAss := StringReplace(XMLAss, '<' + ENCODING_UTF8_STD + '>', '', [rfReplaceAll]);
    //XMLAss := StringReplace(XMLAss, '<' + XML_V01 + '>', '', [rfReplaceAll]);

    Leitor := TLeitor.Create;
    try
      leitor.Grupo := XMLAss;
      NFe.signature.URI := Leitor.rAtributo('Reference URI=');
      NFe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
      NFe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
      NFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
    finally
      Leitor.Free;
    end;

    if Configuracoes.Geral.Salvar then
      Gravar(OnlyNumber(NFe.infNFe.ID) + '-nfe.xml', XMLAss);

    if DFeUtil.NaoEstaVazio(NomeArq) then
      Gravar(NomeArq, XMLAss);
  end;
end;

function NotaFiscal.Validar: Boolean;
var
  i: integer;
  FMsg, Erro: String;
  NotaEhValida: Boolean;
begin
(*  for i := 0 to Self.Count - 1 do
  begin
    if pos('<Signature', Self.Items[i].XMLOriginal) = 0 then
      Assinar;

    ////NotaEhValida := NotaUtil.Valida(('<NFe xmlns' +
    ////                RetornarConteudoEntre(Self.Items[i].XMLOriginal,
    ////                               '<NFe xmlns', '</NFe>')+ '</NFe>'),
    ////                FMsg, Self.FConfiguracoes.Geral.PathSchemas,
    ////                Self.FConfiguracoes.Geral.ModeloDF,
    ////                Self.FConfiguracoes.Geral.VersaoDF) ;

    if not NotaEhValida then
    begin
      Erro := 'Falha na validação dos dados da nota ' +
        IntToStr(Self.Items[i].NFe.Ide.nNF) + sLineBreak + Self.Items[i].Alertas;

      Self.Items[i].ErroValidacaoCompleto := Erro + FMsg;
      Self.Items[i].ErroValidacao :=
        Erro + IfThen(Self.FConfiguracoes.Geral.ExibirErroSchema, FMsg, '');

      raise EACBrNFeException.Create(Self.Items[i].ErroValidacao);
    end;
  end; *)
end;

function NotaFiscal.VerificarAssinatura: Boolean;
begin

end;

function NotaFiscal.ValidarRegrasdeNegocios: Boolean;
var
  Erros: String;

  procedure AdicionaErro(const Erro: String);
  begin
    Erros := Erros + Erro + sLineBreak;
  end;

begin
  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    Erros := '';

    if not ValidarConcatChave then  //A03-10
      AdicionaErro(
        '502-Rejeição: Erro na Chave de Acesso - Campo Id não corresponde à concatenação dos campos correspondentes');

    if copy(IntToStr(NFe.Emit.EnderEmit.cMun), 1, 2) <>
      IntToStr(Configuracoes.WebServices.UFCodigo) then //B02-10
      AdicionaErro('226-Rejeição: Código da UF do Emitente diverge da UF autorizadora');

    if (NFe.Ide.serie > 899) and  //B07-20
      (NFe.Ide.tpEmis <> teSCAN) then
      AdicionaErro('503-Rejeição: Série utilizada fora da faixa permitida no SCAN (900-999)');

    if (NFe.Ide.dEmi > now) then  //B09-10
      AdicionaErro('703-Rejeição: Data-Hora de Emissão posterior ao horário de recebimento');

    if ((now - NFe.Ide.dEmi) > 30) then  //B09-20
      AdicionaErro('228-Rejeição: Data de Emissão muito atrasada');

    //GB09.02 - Data de Emissão posterior à 31/03/2011
    //GB09.03 - Data de Recepção posterior à 31/03/2011 e tpAmb (B24) = 2

    if not ValidarMunicipio(NFe.Ide.cMunFG) then //B12-10
      AdicionaErro('270-Rejeição: Código Município do Fato Gerador: dígito inválido');

    if (UFparaCodigo(NFe.Emit.EnderEmit.UF) <> StrToIntDef(
      copy(IntToStr(NFe.Ide.cMunFG), 1, 2), 0)) then//GB12.1
      AdicionaErro('271-Rejeição: Código Município do Fato Gerador: difere da UF do emitente');

    if ((NFe.Ide.tpEmis in [teSCAN, teSVCAN, teSVCRS]) and
      (Configuracoes.Geral.FormaEmissao = teNormal)) then  //B22-30
      AdicionaErro(
        '570-Rejeição: Tipo de Emissão 3, 6 ou 7 só é válido nas contingências SCAN/SVC');

    if ((NFe.Ide.tpEmis <> teSCAN) and (Configuracoes.Geral.FormaEmissao = teSCAN))
    then  //B22-40
      AdicionaErro('571-Rejeição: Tipo de Emissão informado diferente de 3 para contingência SCAN');

    if ((Configuracoes.Geral.FormaEmissao in [teSVCAN, teSVCRS]) and
      (not (NFe.Ide.tpEmis in [teSVCAN, teSVCRS]))) then  //B22-60
      AdicionaErro('713-Rejeição: Tipo de Emissão diferente de 6 ou 7 para contingência da SVC acessada');

    //B23-10
    if (NFe.Ide.tpAmb <> Configuracoes.WebServices.Ambiente) then
      //B24-10
      AdicionaErro('252-Rejeição: Ambiente informado diverge do Ambiente de recebimento '
        + '(Tipo do ambiente da NF-e difere do ambiente do Web Service)');

    if (not (NFe.Ide.procEmi in [peAvulsaFisco, peAvulsaContribuinte])) and
      (NFe.Ide.serie > 889) then //B26-10
      AdicionaErro('266-Rejeição: Série utilizada fora da faixa permitida no Web Service (0-889)');

    if (NFe.Ide.procEmi in [peAvulsaFisco, peAvulsaContribuinte]) and
      (NFe.Ide.serie < 890) and (NFe.Ide.serie > 899) then
      //B26-20
      AdicionaErro('451-Rejeição: Processo de emissão informado inválido');

    if (NFe.Ide.procEmi in [peAvulsaFisco, peAvulsaContribuinte]) and
      (NFe.Ide.tpEmis <> teNormal) then //B26-30
      AdicionaErro('370-Rejeição: Nota Fiscal Avulsa com tipo de emissão inválido');

    if (NFe.Ide.tpEmis = teNormal) and ((NFe.Ide.xJust > '') or
      (NFe.Ide.dhCont <> 0)) then
      //B28-10
      AdicionaErro(
        '556-Justificativa de entrada em contingência não deve ser informada para tipo de emissão normal');

    if (NFe.Ide.tpEmis in [teContingencia, teDPEC, teFSDA, teOffLine]) and
      (NFe.Ide.xJust = '') then //B28-20
      AdicionaErro('557-A Justificativa de entrada em contingência deve ser informada');

    if (NFe.Ide.dhCont > now) then //B28-30
      AdicionaErro('558-Rejeição: Data de entrada em contingência posterior a data de recebimento');

    if (NFe.Ide.dhCont > 0) and ((now - NFe.Ide.dhCont) > 30) then //B28-40
      AdicionaErro('559-Rejeição: Data de entrada em contingência muito atrasada');

    if (NFe.Ide.modelo = 65) then  //Regras válidas apenas para NFC-e - 65
    begin
      if (NFe.Ide.dEmi < now - StrToTime('00:05:00')) and
        (NFe.Ide.tpEmis in [teNormal, teSCAN, teSVCAN, teSVCRS]) then
        //B09-40
        AdicionaErro('704-Rejeição: NFC-e com Data-Hora de emissão atrasada');

      if (NFe.Ide.dSaiEnt <> 0) then  //B10-10
        AdicionaErro('705-Rejeição: NFC-e com data de entrada/saída');

      if (NFe.Ide.tpNF = tnEntrada) then  //B11-10
        AdicionaErro('706-Rejeição: NFC-e para operação de entrada');

      if (NFe.Ide.idDest <> doInterna) then  //B11-10
        AdicionaErro('707-NFC-e para operação interestadual ou com o exterior');

      if (not (NFe.Ide.tpImp in [tiNFCe, tiNFCeA4, tiMsgEletronica])) then
        //B21-10
        AdicionaErro('709-Rejeição: NFC-e com formato de DANFE inválido');

      if (NFe.Ide.tpEmis = teOffLine) and
        (AnsiIndexStr(NFe.Emit.EnderEmit.UF, ['SP']) <> -1) then  //B22-20
        AdicionaErro('712-Rejeição: NF-e com contingência off-line');

      if (NFe.Ide.tpEmis in [teDPEC]) then  //B22-34
        AdicionaErro('714-Rejeição: NFC-e com contingência DPEC inexistente');

      if (NFe.Ide.tpEmis = teSCAN) then //B22-50
        AdicionaErro('782-Rejeição: NFC-e não é autorizada pelo SCAN');

      if (NFe.Ide.tpEmis in [teSVCAN, teSVCRS]) then  //B22-70
        AdicionaErro('783-Rejeição: NFC-e não é autorizada pela SVC');

      if (NFe.Ide.finNFe <> fnNormal) then  //B25-20
        AdicionaErro('715-Rejeição: Rejeição: NFC-e com finalidade inválida');

      if (NFe.Ide.indFinal = cfNao) then //B25a-10
        AdicionaErro('716-Rejeição: NFC-e em operação não destinada a consumidor final');

      if (not (NFe.Ide.indPres in [pcPresencial, pcEntregaDomicilio])) then
        //B25b-20
        AdicionaErro('717-Rejeição: NFC-e em operação não presencial');

      if (NFe.Ide.indPres = pcEntregaDomicilio) and
        (AnsiIndexStr(NFe.Emit.EnderEmit.UF, ['XX']) <> -1) then
        //B25b-30  Qual estado não permite entrega a domicílio?
        AdicionaErro('785-Rejeição: NFC-e com entrega a domicílio não permitida pela UF');

      if (NFe.Ide.NFref.Count > 0) then  //BA01-10
        AdicionaErro('708-Rejeição: NFC-e não pode referenciar documento fiscal');

      if (NFe.Emit.IEST > '') then  //C18-10
        AdicionaErro('718-Rejeição: NFC-e não deve informar IE de Substituto Tributário');
    end;

    if (NFe.Ide.modelo = 55) then  //Regras válidas apenas para NF-e - 55
    begin
      if ((NFe.Ide.dSaiEnt - now) > 30) then  //B10-20  - Facultativo
        AdicionaErro('504-Rejeição: Data de Entrada/Saída posterior ao permitido');

      if ((now - NFe.Ide.dSaiEnt) > 30) then  //B10-30  - Facultativo
        AdicionaErro('505-Rejeição: Data de Entrada/Saída anterior ao permitido');

      if (NFe.Ide.dSaiEnt < NFe.Ide.dEmi) then
        //B10-40  - Facultativo
        AdicionaErro('506-Rejeição: Data de Saída menor que a Data de Emissão');

      if (NFe.Ide.tpImp in [tiNFCe, tiMsgEletronica]) then  //B21-20
        AdicionaErro('710-Rejeição: NF-e com formato de DANFE inválido');

      if (NFe.Ide.tpEmis = teOffLine) then  //B22-10
        AdicionaErro('711-Rejeição: NF-e com contingência off-line');

      if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 0) then  //B25-30
        AdicionaErro('254-Rejeição: NF-e complementar não possui NF referenciada');

      if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count > 1) then  //B25-40
        AdicionaErro('255-Rejeição: NF-e complementar possui mais de uma NF referenciada');

      if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 1) and
        (((NFe.Ide.NFref.Items[0].RefNF.CNPJ > '') and
        (NFe.Ide.NFref.Items[0].RefNF.CNPJ <> NFe.Emit.CNPJCPF)) or
        ((NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF > '') and
        (NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF <> NFe.Emit.CNPJCPF))) then
        //B25-50
        AdicionaErro(
          '269-Rejeição: CNPJ Emitente da NF Complementar difere do CNPJ da NF Referenciada');

      if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 1) and
        //Testa pelo número para saber se TAG foi preenchida
        (((NFe.Ide.NFref.Items[0].RefNF.nNF > 0) and
        (NFe.Ide.NFref.Items[0].RefNF.cUF <> UFparaCodigo(
        NFe.Emit.EnderEmit.UF))) or ((NFe.Ide.NFref.Items[0].RefNFP.nNF > 0) and
        (NFe.Ide.NFref.Items[0].RefNFP.cUF <> UFparaCodigo(
        NFe.Emit.EnderEmit.UF))))
      then  //B25-60 - Facultativo
        AdicionaErro('678-Rejeição: NF referenciada com UF diferente da NF-e complementar');

      if (NFe.Ide.finNFe = fnDevolucao) and (NFe.Ide.NFref.Count = 0) then
        //B25-70
        AdicionaErro('321-Rejeição: NF-e devolução não possui NF referenciada');

      if (NFe.Ide.finNFe = fnDevolucao) and (NFe.Ide.NFref.Count > 1) then
        //B25-80
        AdicionaErro('322-Rejeição: NF-e devolução possui mais de uma NF referenciada');

      if (NFe.Ide.indPres = pcEntregaDomicilio) then //B25b-10
        AdicionaErro('794-Rejeição: NF-e com indicativo de NFC-e com entrega a domicílio');
    end;
  end;

  FErroRegrasdeNegocios := Erros;
  Result := DFeUtil.EstaVazio(Erros);
end;

function NotaFiscal.GravarXML(CaminhoArquivo: String): Boolean;
begin
  if DFeUtil.EstaVazio(CaminhoArquivo) then
    CaminhoArquivo := CalcularNomeArquivo;

  GerarXML;
  TACBrNFe(TNotasFiscais(Collection).ACBrNFe).Gravar(CaminhoArquivo, FXML);
  FNomeArq := CaminhoArquivo;
end;

function NotaFiscal.GravarTXT(CaminhoArquivo: String): Boolean;
var
  ATXT: String;
begin
  if DFeUtil.EstaVazio(CaminhoArquivo) then
    CaminhoArquivo := CalcularNomeArquivo;

  ATXT := GerarTXT;
  TACBrNFe(TNotasFiscais(Collection).ACBrNFe).Gravar(ChangeFileExt(CaminhoArquivo, '.txt'), ATXT);
  FNomeArq := CaminhoArquivo;
end;

function NotaFiscal.SaveToStream(AStream: TStream): Boolean;
begin
  Result := False;
  GerarXML;

  AStream.Size := 0;
  AStream.WriteBuffer(FXML[1], Length(FXML));  // Gravando no Buffer da Stream //
  Result := True;
end;

procedure NotaFiscal.EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; EnviaPDF: Boolean = True; sCC: TStrings = nil;
  Anexos: TStrings = nil; PedeConfirma: Boolean = False;
  AguardarEnvio: Boolean = False; NomeRemetente: String = '';
  TLS: Boolean = True; UsarThread: Boolean = True; HTML: Boolean = False);
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

function NotaFiscal.GerarXML: String;
begin
  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    NFe.infNFe.Versao := StringToFloat(LerVersaoDeParams(LayNfeRecepcao));
    FNFeW.Gerador.Opcoes.FormatoAlerta := Configuracoes.Geral.FormatoAlerta;
    FNFeW.Gerador.Opcoes.RetirarAcentos := Configuracoes.Geral.RetirarAcentos;
    FNFeW.Opcoes.GerarTXTSimultaneamente := False;
  end;

  FNFeW.GerarXml;
  FXML := FNFeW.Gerador.ArquivoFormatoXML;
  FAlertas := FNFeW.Gerador.ListaDeAlertas.Text;
  Result := FXML;
end;

function NotaFiscal.GerarTXT: String;
begin
  with TACBrNFe(TNotasFiscais(Collection).ACBrNFe) do
  begin
    NFe.infNFe.Versao := StringToFloat(LerVersaoDeParams(LayNfeRecepcao));
    FNFeW.Gerador.Opcoes.FormatoAlerta := Configuracoes.Geral.FormatoAlerta;
    FNFeW.Gerador.Opcoes.RetirarAcentos := Configuracoes.Geral.RetirarAcentos;
  end;

  FNFeW.Opcoes.GerarTXTSimultaneamente := True;

  FNFeW.GerarXml;
  FXML := FNFeW.Gerador.ArquivoFormatoXML;
  FAlertas := FNFeW.Gerador.ListaDeAlertas.Text;
  Result := FNFeW.Gerador.ArquivoFormatoTXT;
end;

function NotaFiscal.CalcularNomeArquivo: String;
var
  xID: String;
begin
  xID := OnlyNumber(NFe.infNFe.ID);

  if DFeUtil.EstaVazio(xID) then
    raise EACBrNFeException.Create('ID Inválido. Impossível Salvar XML');

  Result := xID + '-nfe.xml';
end;

function NotaFiscal.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: word;
begin
  DecodeDate(nfe.ide.dEmi, wAno, wMes, wDia);

  Result := not ((Copy(NFe.infNFe.ID, 4, 2) <> IntToStrZero(nfe.ide.cUF, 2)) or
    (Copy(NFe.infNFe.ID, 6, 2) <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(NFe.infNFe.ID, 8, 2) <> FormatFloat('00', wMes)) or
    (Copy(NFe.infNFe.ID, 10, 14) <> copy(OnlyNumber(nfe.Emit.CNPJCPF) +
    '00000000000000', 1, 14)) or (Copy(NFe.infNFe.ID, 24, 2) <>
    IntToStrZero(nfe.ide.modelo, 2)) or (Copy(NFe.infNFe.ID, 26, 3) <>
    IntToStrZero(nfe.ide.serie, 3)) or (Copy(NFe.infNFe.ID, 29, 9) <>
    IntToStrZero(nfe.ide.nNF, 9)) or (Copy(NFe.infNFe.ID, 38, 1) <>
    TpEmisToStr(nfe.ide.tpEmis)) or (Copy(NFe.infNFe.ID, 39, 8) <>
    IntToStrZero(nfe.ide.cNF, 8)));
end;

function NotaFiscal.GetConfirmada: Boolean;
begin
  Result := (FNFe.procNFe.cStat = 100 or 150);
end;

function NotaFiscal.GetMsg: String;
begin
  Result := FNFe.procNFe.xMotivo;
end;

function NotaFiscal.GetProcessada: Boolean;
begin
  Result := (FNFe.procNFe.cStat = 100 or 110 or 150 or 301 or 302)
end;

{ TNotasFiscais }

constructor TNotasFiscais.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFe) then
    raise EACBrNFeException.Create('AOwner deve ser do tipo TACBrNFe');

  inherited;

  FACBrNFe := TACBrNFe(AOwner);
  FConfiguracoes := TACBrNFe(FACBrNFe).Configuracoes;
end;


function TNotasFiscais.Add: NotaFiscal;
begin
  Result := NotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].Assinar;
end;

procedure TNotasFiscais.GerarNFe;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].GerarXML;
end;

function TNotasFiscais.GetItem(Index: integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: String;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.VerificarDANFE;
begin
  if not Assigned(TACBrNFe(FACBrNFe).DANFE) then
    raise EACBrNFeException.Create('Componente DANFE não associado.');
end;

procedure TNotasFiscais.Imprimir;
begin
  VerificarDANFE;
  TACBrNFe(FACBrNFe).DANFE.ImprimirDANFE(nil);
end;

procedure TNotasFiscais.ImprimirResumido;
begin
  VerificarDANFE;
  TACBrNFe(FACBrNFe).DANFE.ImprimirDANFEResumido(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  VerificarDANFE;
  TACBrNFe(FACBrNFe).DANFE.ImprimirDANFEPDF(nil);
end;

procedure TNotasFiscais.ImprimirResumidoPDF;
begin
  VerificarDANFE;
  TACBrNFe(FACBrNFe).DANFE.ImprimirDANFEResumidoPDF(nil);
end;

function TNotasFiscais.Insert(Index: integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: integer; const Value: NotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Validar;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    if not Self.Items[i].Validar then
      raise EACBrNFeException.Create(Self.Items[i].ErroValidacao);
  end;
end;

procedure TNotasFiscais.VerificarAssinatura;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    if not Self.Items[i].VerificarAssinatura then
      raise EACBrNFeException.Create(Self.Items[i].ErroValidacao);
  end;
end;

procedure TNotasFiscais.ValidarRegrasdeNegocios;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    if not Self.Items[i].ValidarRegrasdeNegocios then
      raise EACBrNFeException.Create(Self.Items[i].ErroRegrasdeNegocios);
  end;
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: String;
  AGerarNFe: Boolean = True): Boolean;
var
  ArquivoXML: TStringList;
  XMLOriginal, XML, Alertas: String;
  i: integer;
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

      for i := 0 to Self.Count - 1 do
      begin
        if AGerarNFe then
          Self.Items[i].GerarXML;

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

function TNotasFiscais.LoadFromStream(AStream: TStringStream;
  AGerarNFe: Boolean = True): Boolean;
var
  XMLOriginal: String;
begin
  try
    Result := True;
    XMLOriginal := '';
    AStream.Position := 0;
    SetLength(XMLOriginal, AStream.Size);
    AStream.ReadBuffer(XMLOriginal[1], AStream.Size);

    LoadFromString(XMLOriginal, AGerarNFe);
  except
    Result := False;
    raise;
  end;
end;

function TNotasFiscais.LoadFromString(AXMLString: String;
  AGerarNFe: Boolean = True): Boolean;
var
  LocNFeR: TNFeR;
  XML: String;
  Ok: Boolean;
  Versao: String;
  P: integer;
begin
  Result := True;
  try
    while pos('</NFe>', AXMLString) > 0 do
    begin
      if pos('</nfeProc>', AXMLString) > 0 then
      begin
        P := pos('</nfeProc>', AXMLString);
        XML := copy(AXMLString, 1, P + 5);
        AXMLString := Trim(copy(AXMLString, P + 10, length(AXMLString)));
      end
      else
      begin
        P := pos('</NFe>', AXMLString);
        XML := copy(AXMLString, 1, P + 5);
        AXMLString := Trim(copy(AXMLString, P + 6, length(AXMLString)));
      end;

      LocNFeR := TNFeR.Create(Self.Add.NFe);
      try
        LocNFeR.Leitor.Arquivo := XML;
        LocNFeR.LerXml;

        // Detecta o modelo e a versão do Documento Fiscal
        FConfiguracoes.Geral.ModeloDF :=
          StrToModeloDF(OK, IntToStr(LocNFeR.NFe.Ide.modelo));
        Versao := LocNFeR.NFe.infNFe.VersaoStr;
        Versao := StringReplace(Versao, 'versao="', '', [rfReplaceAll, rfIgnoreCase]);
        Versao := StringReplace(Versao, '"', '', [rfReplaceAll, rfIgnoreCase]);
        FConfiguracoes.Geral.VersaoDF := StrToVersaoDF(OK, Versao);

        Items[Self.Count - 1].XML := XML;
        Items[Self.Count - 1].XMLOriginal := XML;
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

function TNotasFiscais.SaveToFile(PathArquivo: String = '';
  SalvaTXT: Boolean = False): Boolean;
var
  i: integer;
  CaminhoArquivo: String;
begin
  Result := True;
  try
    for i := 0 to TACBrNFe(FACBrNFe).NotasFiscais.Count - 1 do
    begin
      if DFeUtil.EstaVazio(PathArquivo) then
        PathArquivo := TACBrNFe(FACBrNFe).Configuracoes.Arquivos.PathSalvar
      else
        PathArquivo := ExtractFilePath(PathArquivo);
      CaminhoArquivo := PathWithDelim(PathArquivo) + StringReplace(
        TACBrNFe(FACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID, 'NFe',
        '', [rfIgnoreCase]) + '-nfe.xml';

      TACBrNFe(FACBrNFe).NotasFiscais.Items[i].SaveToFile(CaminhoArquivo, SalvaTXT);
    end;
  except
    Result := False;
  end;
end;

function TNotasFiscais.SaveToTXT(PathArquivo: String): Boolean;
var
  loSTR: TStringList;
  ArqXML, Alertas, ArqTXT: String;
  I, J: integer;
begin
  Result := False;
  loSTR := TStringList.Create;
  try
    loSTR.Clear;
    for I := 0 to Self.Count - 1 do
    begin
      ArqTXT := Self.Items[I].GerarTXT;
      // loSTR.Text := ArqTXT;
      loSTR.Add(ArqTXT);
    end;

    if loSTR.Count > 0 then
    begin
      loSTR.Insert(0, 'NOTA FISCAL|' + IntToStr(Self.Count));
      J := loSTR.Count;
      i := 0;
      while (I <= J - 1) do
      begin
        if loSTR.Strings[I] = '' then
        begin
          loSTR.Delete(I);
          J := J - 1;
        end
        else
          I := I + 1;
      end;

      if DFeUtil.EstaVazio(PathArquivo) then
        PathArquivo := PathWithDelim(TACBrNFe(
          FACBrNFe).Configuracoes.Arquivos.PathSalvar) + 'NFe.TXT';
      loSTR.SaveToFile(PathArquivo);
      Result := True;
    end;
  finally
    loSTR.Free;
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



if VersaoStr = '' then
   raise EACBrNFeException.Create( 'Não existe versão do serviço "LayNfeRecepcao",'+
         ' para o modelo DF = '+ModeloDFToStr(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF)+
         ' e Versão = '+VersaoDFToStr(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF) );


*)
