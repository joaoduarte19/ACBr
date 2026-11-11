{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{																			                                         }
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

unit Frm_ACBrNFeABI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ComCtrls, OleCtrls, SHDocVw,
  ShellAPI, XMLIntf, XMLDoc, zlib,
  ACBrBase,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrDFe, ACBrDFeReport,
  ACBrMail, ACBrNFeABI;

type
  TfrmACBrNFeABI = class(TForm)
    pnlMenus: TPanel;
    pnlCentral: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PageControl4: TPageControl;
    TabSheet3: TTabSheet;
    lSSLLib: TLabel;
    lCryptLib: TLabel;
    lHttpLib: TLabel;
    lXmlSign: TLabel;
    gbCertificado: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    Label25: TLabel;
    sbtnGetCert: TSpeedButton;
    sbtnNumSerie: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    btnDataValidade: TButton;
    btnNumSerie: TButton;
    btnSubName: TButton;
    btnCNPJ: TButton;
    btnIssuerName: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    btnSha256: TButton;
    cbAssinar: TCheckBox;
    btnHTTPS: TButton;
    btnLeituraX509: TButton;
    cbSSLLib: TComboBox;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbXmlSignLib: TComboBox;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    sbtnPathSalvar: TSpeedButton;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label42: TLabel;
    spPathSchemas: TSpeedButton;
    edtPathLogs: TEdit;
    ckSalvar: TCheckBox;
    cbFormaEmissao: TComboBox;
    cbxAtualizarXML: TCheckBox;
    cbxExibirErroSchema: TCheckBox;
    edtFormatoAlerta: TEdit;
    cbxRetirarAcentos: TCheckBox;
    cbVersaoDF: TComboBox;
    edtPathSchemas: TEdit;
    TabSheet7: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    lTimeOut: TLabel;
    lSSLLib1: TLabel;
    cbxVisualizar: TCheckBox;
    cbUF: TComboBox;
    rgTipoAmb: TRadioGroup;
    cbxSalvarSOAP: TCheckBox;
    seTimeOut: TSpinEdit;
    cbSSLType: TComboBox;
    gbProxy: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    gbxRetornoEnvio: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    cbxAjustarAut: TCheckBox;
    edtTentativas: TEdit;
    edtIntervalo: TEdit;
    edtAguardar: TEdit;
    TabSheet12: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtEmitCNPJ: TEdit;
    edtEmitIE: TEdit;
    edtEmitRazao: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitCEP: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitComp: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitCidade: TEdit;
    edtEmitUF: TEdit;
    TabSheet13: TTabSheet;
    sbPathNFeABI: TSpeedButton;
    Label35: TLabel;
    Label47: TLabel;
    sbPathEvento: TSpeedButton;
    cbxSalvarArqs: TCheckBox;
    cbxPastaMensal: TCheckBox;
    cbxAdicionaLiteral: TCheckBox;
    cbxEmissaoPathNFeABI: TCheckBox;
    cbxSalvaPathEvento: TCheckBox;
    cbxSepararPorCNPJ: TCheckBox;
    edtPathNFeABI: TEdit;
    edtPathEvento: TEdit;
    cbxSepararPorModelo: TCheckBox;
    TabSheet2: TTabSheet;
    Label7: TLabel;
    sbtnLogoMarca: TSpeedButton;
    edtLogoMarca: TEdit;
    rgTipoDANFeABI: TRadioGroup;
    TabSheet14: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    btnSalvarConfig: TBitBtn;
    lblColaborador: TLabel;
    lblPatrocinador: TLabel;
    lblDoar1: TLabel;
    lblDoar2: TLabel;
    pgcBotoes: TPageControl;
    tsEnvios: TTabSheet;
    tsConsultas: TTabSheet;
    tsEventos: TTabSheet;
    btnConsultar: TButton;
    btnConsultarChave: TButton;
    btnValidarRegrasNegocio: TButton;
    btnGerarXML: TButton;
    btnGerarPDF: TButton;
    btnValidarXML: TButton;
    btnImprimir: TButton;
    btnEnviarEmail: TButton;
    btnAdicionarProtocolo: TButton;
    btnCarregarXMLEnviar: TButton;
    btnValidarAssinatura: TButton;
    btnCancelarXML: TButton;
    btnCancelarChave: TButton;
    btnImprimirEvento: TButton;
    pgRespostas: TPageControl;
    TabSheet5: TTabSheet;
    MemoResp: TMemo;
    TabSheet6: TTabSheet;
    WBResposta: TWebBrowser;
    TabSheet8: TTabSheet;
    memoLog: TMemo;
    TabSheet9: TTabSheet;
    trvwDocumento: TTreeView;
    TabSheet10: TTabSheet;
    memoRespWS: TMemo;
    Dados: TTabSheet;
    MemoDados: TMemo;
    ACBrMail1: TACBrMail;
    OpenDialog1: TOpenDialog;
    btnStatusServ: TButton;
    btnCriarEnviarSincrono: TButton;
    btnGerarPDFEvento: TButton;
    btnEnviarEventoEmail: TButton;
    tsOutros: TTabSheet;
    btnLerArqINI: TButton;
    btnGerarArqINI: TButton;
    btnLerArqINIEnviarEvento: TButton;
    ACBrNFeABI1: TACBrNFeABI;

    procedure FormCreate(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure sbPathNFeABIClick(Sender: TObject);
    procedure sbPathEventoClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnNumSerieClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure btnDataValidadeClick(Sender: TObject);
    procedure btnNumSerieClick(Sender: TObject);
    procedure btnSubNameClick(Sender: TObject);
    procedure btnCNPJClick(Sender: TObject);
    procedure btnIssuerNameClick(Sender: TObject);
    procedure btnSha256Click(Sender: TObject);
    procedure btnHTTPSClick(Sender: TObject);
    procedure btnLeituraX509Click(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure spPathSchemasClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure PathClick(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure lblColaboradorClick(Sender: TObject);
    procedure lblPatrocinadorClick(Sender: TObject);
    procedure lblDoar1Click(Sender: TObject);
    procedure lblDoar2Click(Sender: TObject);
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure btnCarregarXMLEnviarClick(Sender: TObject);
    procedure btnValidarRegrasNegocioClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnValidarAssinaturaClick(Sender: TObject);
    procedure btnAdicionarProtocoloClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConsultarChaveClick(Sender: TObject);
    procedure btnCancelarXMLClick(Sender: TObject);
    procedure btnCancelarChaveClick(Sender: TObject);
    procedure btnImprimirEventoClick(Sender: TObject);
    procedure btnCriarEnviarSincronoClick(Sender: TObject);
    procedure btnGerarPDFEventoClick(Sender: TObject);
    procedure btnEnviarEventoEmailClick(Sender: TObject);
    procedure btnLerArqINIClick(Sender: TObject);
    procedure btnGerarArqINIClick(Sender: TObject);
    procedure btnLerArqINIEnviarEventoClick(Sender: TObject);
    procedure ACBrNFeABI1GerarLog(const ALogLine: string; var Tratado: Boolean);
    procedure ACBrNFeABI1StatusChange(Sender: TObject);
  private
    { Private declarations }
    procedure GravarConfiguracao;
    procedure LerConfiguracao;
    procedure ConfigurarComponente;
    procedure ConfigurarEmail;
    procedure AlimentarNFeABI(NumDFe: String);
    Procedure AlimentarComponente(NumDFe: String);
    procedure LoadXML(RetWS: String; MyWebBrowser: TWebBrowser);
    procedure AtualizarSSLLibsCombo;
  public
    { Public declarations }
  end;

var
  frmACBrNFeABI: TfrmACBrNFeABI;

implementation

uses
  strutils, math, TypInfo, DateUtils, synacode, blcksock, FileCtrl, Grids,
  IniFiles, Printers,
  ACBrNFeABI.Classes,
  ACBrDFe.Conversao,
  ACBrNFeABI.Conversao,
  ACBrDFeConfiguracoes, ACBrDFeSSL, ACBrDFeOpenSSL, ACBrDFeUtil,
  ACBrNFeABINotasFiscais, ACBrNFeABIConfiguracoes,
  Frm_Status, Frm_SelecionarCertificado, ACBrXmlBase;

const
  SELDIRHELP = 1000;

{$R *.dfm}

{ TfrmACBrNFeABI }

procedure TfrmACBrNFeABI.ACBrNFeABI1GerarLog(const ALogLine: string;
  var Tratado: Boolean);
begin
  memoLog.Lines.Add(ALogLine);
end;

procedure TfrmACBrNFeABI.ACBrNFeABI1StatusChange(Sender: TObject);
begin
  case ACBrNFeABI1.Status of
    stNFeABIIdle:
      begin
        if ( frmStatus <> nil ) then
          frmStatus.Hide;
      end;

    stNFeABIStatusServico:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFeABIAutorizacao:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando dados da NFeABI...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFeABIConsulta:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Consultando NFeABI...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFeABIEmail:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando Email...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFeABIEvento:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando Evento...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
  end;

  Application.ProcessMessages;
end;

procedure TfrmACBrNFeABI.AlimentarComponente(NumDFe: String);
begin
  ACBrNFeABI1.NotasFiscais.Clear;

  AlimentarNFeABI(NumDFe);
end;

procedure TfrmACBrNFeABI.AlimentarNFeABI(NumDFe: String);
begin
  with ACBrNFeABI1.NotasFiscais.Add.NFeABI do
  begin
    //
    // Dados de Identificação do NFeABI
    //
    Ide.cUF := UFparaCodigoUF(edtEmitUF.Text);
    Ide.cNF := StrToInt(RightStr(IntToStr(GerarCodigoDFe(Ide.nNF)), 7));
    Ide.serie := 1;
    Ide.nNF := StrToIntDef(NumDFe, 0);
    Ide.dhEmi := Now;
    // tdSimplificado, tdCompleto
    Ide.tpNF := tdCompleto;
    // tiSemGeracao, tiRetrato, tiPaisagem)
    Ide.tpImp := tiRetrato;

    Ide.gModNat.modOper := 1;
    Ide.gModNat.natOper := 1;
    Ide.gModNat.detOper := 1;

    // TACBrTipoEmissao = (teNormal, teOffLine);
    Ide.tpEmis := teNormal;
    Ide.nSiteAutoriz := sa0;

    // taProducao, taHomologacao
    if rgTipoAmb.ItemIndex = 0 then
      Ide.tpAmb := taProducao
    else
      Ide.tpAmb := taHomologacao;

    // fnNormal, fnSubstituicao
    Ide.finNFe := fnNormal;
    // peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte,
    // peContribuinteAplicativoFisco, peProvedorAssinaturaAutorizacao
    Ide.procEmi := peAplicativoContribuinte;
    Ide.verProc := 'ACBrNFeABI';

    // Campos referente ao envio em Contingência
    Ide.gCont.dhCont := 0;
    Ide.gCont.xJust := '';

    // Alimentar somente se tiver Nota Fiscal Referenciada
    {
    with NFref.New do
    begin
      refNFeABI := '';
    end;
    }

    //
    // Dados do Emitente
    //
    Emit.CNPJCPF := edtEmitCNPJ.Text;
    Emit.xNome := edtEmitRazao.Text;
    Emit.xFant := edtEmitRazao.Text;

    Emit.EnderEmit.xLgr := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun := edtEmitCidade.Text;
    Emit.EnderEmit.UF := edtEmitUF.Text;
    Emit.EnderEmit.CEP := edtEmitCEP.Text;
    Emit.EnderEmit.fone := edtEmitFone.Text;
    Emit.EnderEmit.cPais := 1058;
    Emit.EnderEmit.xPais := 'Brasil';
    // teVendedor, teComprador, teLeiloeiro, teTabelionato, teJuntaComercial,
    // teBanco, teOrganizacao, teCredor, teGrupoConsorcio, teSucessora, teOutros
    Emit.tpEmit := teVendedor;

    //
    // Vendedor, Transmitente ou Cedente do imóvel
    //
    with transmit.New do
    begin
      indDeclarante := tieSim;
      CNPJCPF := edtEmitCNPJ.Text;
      xNome := 'Nome do Vendedor, Transmitente ou Cedente do imóvel';

      enderTransmit.xLgr := edtEmitLogradouro.Text;
      enderTransmit.nro := edtEmitNumero.Text;
      enderTransmit.xCpl := edtEmitComp.Text;
      enderTransmit.xBairro := edtEmitBairro.Text;
      enderTransmit.cMun := StrToInt(edtEmitCodCidade.Text);
      enderTransmit.xMun := edtEmitCidade.Text;
      enderTransmit.UF := edtEmitUF.Text;
      enderTransmit.CEP := edtEmitCEP.Text;
      enderTransmit.fone := edtEmitFone.Text;
      enderTransmit.cPais := 1058;
      enderTransmit.xPais := 'Brasil';

      pTransIndiv := 5;
      // icNenhum, icNaoContribuinteIBSCBS, icContribuinteRegimeRegular, icOptanteSN
      indContrib := icNaoContribuinteIBSCBS;
    end;

    //
    // Comprador, Adquirente ou Cessionário
    //
    with adquirente.New do
    begin
      indDeclarante := tieSim;
      CNPJCPF := edtEmitCNPJ.Text;
      xNome := 'Nome do Comprador, Adquirente ou Cessionário';

      enderAdquirente.xLgr := edtEmitLogradouro.Text;
      enderAdquirente.nro := edtEmitNumero.Text;
      enderAdquirente.xCpl := edtEmitComp.Text;
      enderAdquirente.xBairro := edtEmitBairro.Text;
      enderAdquirente.cMun := StrToInt(edtEmitCodCidade.Text);
      enderAdquirente.xMun := edtEmitCidade.Text;
      enderAdquirente.UF := edtEmitUF.Text;
      enderAdquirente.CEP := edtEmitCEP.Text;
      enderAdquirente.fone := edtEmitFone.Text;
      enderAdquirente.cPais := 1058;
      enderAdquirente.xPais := 'Brasil';

      pAquisicao := 5;
      // icNenhum, icNaoContribuinteIBSCBS, icContribuinteRegimeRegular, icOptanteSN
      indContrib := icNaoContribuinteIBSCBS;
    end;

    //
    // Identificação do imóvel transmitido
    //
    // tiUrbano, tiRural
    imovel.tipo := tiUrbano;

    imovel.cadastro.cCIB := '12345';
    imovel.cadastro.indIPTU := tiSim;
    imovel.cadastro.nIptu := '12345';
    imovel.cadastro.indIncra := tiNao;
    imovel.cadastro.nIncra := '';

    imovel.espImovel := '01';
    imovel.xOutrosEspecies := '';
    imovel.enquadramento := '01';

    imovel.enderImovel.xLgr := edtEmitLogradouro.Text;
    imovel.enderImovel.nro := edtEmitNumero.Text;
    imovel.enderImovel.xCpl := edtEmitComp.Text;
    imovel.enderImovel.xBairro := edtEmitBairro.Text;
    imovel.enderImovel.cMun := StrToInt(edtEmitCodCidade.Text);
    imovel.enderImovel.xMun := edtEmitCidade.Text;
    imovel.enderImovel.UF := edtEmitUF.Text;
    imovel.enderImovel.CEP := edtEmitCEP.Text;
    imovel.enderImovel.fone := edtEmitFone.Text;
    imovel.enderImovel.cPais := 1058;
    imovel.enderImovel.xPais := 'Brasil';

    imovel.obsLocalImovel := '';
    imovel.areaTotal := 500;
    // uatm2, uatha
    imovel.uAreaTotal := uatm2;
    imovel.cartorioRegistro := '';
    imovel.matricTransc := '';

    //
    // Dados do Autorizado a obter o XML (máximo 10)
    //
{
    with autXML.New do
    begin
      CNPJCPF := '';
    end;
}

    //
    // Informações da Operação
    //
    infOper.pTransImovel := 5;
    infOper.vTotalOperacao := 100;
    infOper.indTorna := tiSim;
    infOper.gTorna.vTorna := 100;

    with infOper.gTorna.imovelTorna.New do
    begin
      imovel.tipo := tiUrbano;

      imovel.cadastro.cCIB := '12345';
      imovel.cadastro.indIPTU := tiSim;
      imovel.cadastro.nIptu := '12345';
      imovel.cadastro.indIncra := tiNao;
      imovel.cadastro.nIncra := '';

      imovel.espImovel := '01';
      imovel.xOutrosEspecies := '';
      imovel.enquadramento := '01';

      imovel.enderImovel.xLgr := edtEmitLogradouro.Text;
      imovel.enderImovel.nro := edtEmitNumero.Text;
      imovel.enderImovel.xCpl := edtEmitComp.Text;
      imovel.enderImovel.xBairro := edtEmitBairro.Text;
      imovel.enderImovel.cMun := StrToInt(edtEmitCodCidade.Text);
      imovel.enderImovel.xMun := edtEmitCidade.Text;
      imovel.enderImovel.UF := edtEmitUF.Text;
      imovel.enderImovel.CEP := edtEmitCEP.Text;
      imovel.enderImovel.fone := edtEmitFone.Text;
      imovel.enderImovel.cPais := 1058;
      imovel.enderImovel.xPais := 'Brasil';

      imovel.obsLocalImovel := '';
      imovel.areaTotal := 500;
      // uatm2, uatha
      imovel.uAreaTotal := uatm2;
      imovel.cartorioRegistro := '';
      imovel.matricTransc := '';
    end;

    infOper.gIncorpLote.indIncorpLote := tiSim;
    infOper.gIncorpLote.CNPJempImob := '';
    infOper.gIncorpLote.cCIBObra := '12345';

    infOper.gRedAjusteImovel.vInicial := 100;
    infOper.gRedAjusteImovel.vITBI := 100;
    infOper.gRedAjusteImovel.vLaudemio := 100;
    infOper.gRedAjusteImovel.vContrap := 100;
    infOper.gRedAjusteImovel.vRedAjusteImovel := 100;

    infOper.indRedSocial := tiSim;
    infOper.vRedSocial := 100;

    infOper.instrumento.tpInstrumento := 1;
    infOper.instrumento.xOutrosInst := '';
    infOper.instrumento.dtInstrumento := Date;

    infOper.indIntermedCorret := tiSim;

    with infOper.gIntermedCorret.New do
    begin
      CNPJCPF := edtEmitCNPJ.Text;
      xNome := 'Nome do correntista';
      vCorretagem := 100;
    end;

    //
    // Informações da Tributação
    //
    gInfTrib.gCompraGov.tpEnteGov := tcgEstados;
    gInfTrib.gCompraGov.pRedutor := 5;
    gInfTrib.gCompraGov.tpOperGov := togFornecimento;

    //  Informações do tributo: IBS / CBS
    // CST permitidos para a NFeABI: 200, 220, 221, 410, 820
    gInfTrib.IBSCBS.CST := cst200;
    gInfTrib.IBSCBS.cClassTrib := '200001';
    gInfTrib.IBSCBS.indDoacao := tieSim;

    gInfTrib.IBSCBS.gIBSCBS.vBC := 100;

    gInfTrib.IBSCBS.gIBSCBS.gIBSUF.pIBSUF := 5;
    gInfTrib.IBSCBS.gIBSCBS.gIBSUF.vIBSUF := 100;

    gInfTrib.IBSCBS.gIBSCBS.gIBSUF.gRed.pRedAliq := 5;
    gInfTrib.IBSCBS.gIBSCBS.gIBSUF.gRed.pAliqEfet := 5;

    gInfTrib.IBSCBS.gIBSCBS.gIBSMun.pIBSMun := 5;
    gInfTrib.IBSCBS.gIBSCBS.gIBSMun.vIBSMun := 100;

    gInfTrib.IBSCBS.gIBSCBS.gIBSMun.gRed.pRedAliq := 5;
    gInfTrib.IBSCBS.gIBSCBS.gIBSMun.gRed.pAliqEfet := 5;

    // vIBS = vIBSUF + vIBSMun
    gInfTrib.IBSCBS.gIBSCBS.vIBS := 100;

    gInfTrib.IBSCBS.gIBSCBS.gCBS.pCBS := 5;
    gInfTrib.IBSCBS.gIBSCBS.gCBS.vCBS := 100;

    gInfTrib.IBSCBS.gIBSCBS.gCBS.gRed.pRedAliq := 5;
    gInfTrib.IBSCBS.gIBSCBS.gCBS.gRed.pAliqEfet := 5;

    // Tipo Tributação Compra Governamental
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.pAliqIBSUF := 5;
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.vTribIBSUF := 50;
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.pAliqIBSMun := 5;
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.vTribIBSMun := 50;
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.pAliqCBS := 5;
    gInfTrib.IBSCBS.gIBSCBS.gTribCompraGov.vTribCBS := 50;

    //  Informações Estorno de Crédito
    gInfTrib.IBSCBS.gEstornoCred.vIBSEstCred := 100;
    gInfTrib.IBSCBS.gEstornoCred.vCBSEstCred := 100;

    //
    // Grupo de pagamento
    //
    with pag.detPagImovel.New do
    begin
      tPag := 1;
      xPag := '';
      vPag := 100;
    end;

    with pag.detPagIncorpLote.New do
    begin
      tParcela := '1';
      nParcela := 1;
      xParcela := '';
    end;

    //
    // Grupo Totais da NF-e ABI
    //
    total.vTotalOperacao := 100;
    total.vOperacIndiv := 100;
    total.vRedAjusteIndiv := 100;
    total.vRedSocialIndiv := 100;
    total.vBC := 100;
    total.vIBSUF := 100;
    total.vIBSMun := 100;
    total.vCBS := 100;
    total.vNF := 100;

    //
    // Grupo de Informações Adicionais
    //
    infAdic.infAdFisco := '';
    infAdic.infCpl := '';

    //
    // Grupo Campo de uso livre do contribuinte (máximo 10)
    //
    with infAdic.obsCont.New do
    begin
      xCampo := 'Campo 1';
      xTexto := 'Texto 1';
    end;

    //
    // Grupo Campo de uso livre do Fisco (máximo 10)
    //
    with infAdic.obsFisco.New do
    begin
      xCampo := 'Campo 1';
      xTexto := 'Texto 1';
    end;

    //
    // Informações do Responsável Técnico pela emissão do DFe
    //
    infRespTec.CNPJ := edtEmitCNPJ.Text;
    infRespTec.xContato := edtEmitRazao.Text;
    infRespTec.email := 'nome@provedor.com.br';
    infRespTec.fone := '1622334455';
  end;

  ACBrNFeABI1.NotasFiscais.GerarNFeABI;
end;

procedure TfrmACBrNFeABI.AtualizarSSLLibsCombo;
begin
  cbSSLLib.ItemIndex     := Integer(ACBrNFeABI1.Configuracoes.Geral.SSLLib);
  cbCryptLib.ItemIndex   := Integer(ACBrNFeABI1.Configuracoes.Geral.SSLCryptLib);
  cbHttpLib.ItemIndex    := Integer(ACBrNFeABI1.Configuracoes.Geral.SSLHttpLib);
  cbXmlSignLib.ItemIndex := Integer(ACBrNFeABI1.Configuracoes.Geral.SSLXmlSignLib);

  cbSSLType.Enabled := (ACBrNFeABI1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
end;

procedure TfrmACBrNFeABI.btnAdicionarProtocoloClick(Sender: TObject);
var
  NomeArq: String;
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFeABI1.Consultar;

    ShowMessage(ACBrNFeABI1.WebServices.Consulta.Protocolo);

    MemoResp.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetWS;
    memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetornoWS;
    LoadXML(ACBrNFeABI1.WebServices.Consulta.RetornoWS, WBResposta);
    NomeArq := OpenDialog1.FileName;

    if pos(UpperCase('-NFeABI.xml'), UpperCase(NomeArq)) > 0 then
       NomeArq := StringReplace(NomeArq, '-NFeABI.xml', '-procNFeABI.xml', [rfIgnoreCase]);

    ACBrNFeABI1.NotasFiscais.Items[0].GravarXML(NomeArq);
    ShowMessage('Arquivo gravado em: ' + NomeArq);
    memoLog.Lines.Add('Arquivo gravado em: ' + NomeArq);
  end;
end;

procedure TfrmACBrNFeABI.btnCancelarChaveClick(Sender: TObject);
var
  Chave, idLote, CNPJ, Protocolo, Justificativa: string;
begin
  Chave := '41240629406475000164990010000000011302911292';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Chave da NFeABI', Chave)) then
     exit;
  Chave := Trim(OnlyNumber(Chave));

  idLote := '1';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;

  CNPJ := copy(Chave,7,14);
  if not(InputQuery('WebServices Eventos: Cancelamento', 'CNPJ ou o CPF do autor do Evento', CNPJ)) then
     exit;

  Protocolo:='1234567890123456';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Protocolo de Autorização', Protocolo)) then
     exit;

  Justificativa := 'Justificativa do Cancelamento';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa do Cancelamento', Justificativa)) then
     exit;

  ACBrNFeABI1.EventoNFeABI.Evento.Clear;

  with ACBrNFeABI1.EventoNFeABI.Evento.New do
  begin
    infEvento.chNFeABI := Chave;
//    infEvento.tpEmit := teTransportadora;
    infEvento.CNPJCPF := CNPJ;
    infEvento.CNPJCPFEmit := CNPJ;
    infEvento.dhEvento := now;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := Justificativa;
    infEvento.detEvento.nProt := Protocolo;
  end;

  ACBrNFeABI1.EnviarEvento(StrToInt(idLote));

  MemoResp.Lines.Text := ACBrNFeABI1.WebServices.EnvEvento.RetWS;
  memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.EnvEvento.RetornoWS;
  LoadXML(ACBrNFeABI1.WebServices.EnvEvento.RetornoWS, WBResposta);
  (*
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.TpAmb
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.verAplic
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.cStat
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.xMotivo
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.chNFeABI
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento
  ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt
  *)
end;

procedure TfrmACBrNFeABI.btnCancelarXMLClick(Sender: TObject);
var
  idLote, vAux: String;
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    idLote := '1';
    if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
       exit;

    if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa', vAux)) then
       exit;

    ACBrNFeABI1.EventoNFeABI.Evento.Clear;
    ACBrNFeABI1.EventoNFeABI.idLote := StrToInt(idLote);

    with ACBrNFeABI1.EventoNFeABI.Evento.New do
    begin
      infEvento.dhEvento := now;
      infEvento.tpEvento := teCancelamento;
      infEvento.detEvento.xJust := vAux;
    end;

    ACBrNFeABI1.EnviarEvento(StrToInt(idLote));

    MemoResp.Lines.Text := ACBrNFeABI1.WebServices.EnvEvento.RetWS;
    memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.EnvEvento.RetornoWS;
    LoadXML(ACBrNFeABI1.WebServices.EnvEvento.RetornoWS, WBResposta);
    ShowMessage(IntToStr(ACBrNFeABI1.WebServices.EnvEvento.cStat));
//    ShowMessage(ACBrNFeABI1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
  end;
end;

procedure TfrmACBrNFeABI.btnCarregarXMLEnviarClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName, False);

    with ACBrNFeABI1.NotasFiscais.Items[0].NFeABI do
    begin
      Emit.CNPJCPF           := edtEmitCNPJ.Text;
      Emit.xNome             := edtEmitRazao.Text;

      Emit.EnderEmit.fone    := edtEmitFone.Text;
      Emit.EnderEmit.CEP     := edtEmitCEP.Text;
      Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
      Emit.EnderEmit.nro     := edtEmitNumero.Text;
      Emit.EnderEmit.xCpl    := edtEmitComp.Text;
      Emit.EnderEmit.xBairro := edtEmitBairro.Text;
      Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
      Emit.EnderEmit.xMun    := edtEmitCidade.Text;
      Emit.EnderEmit.UF      := edtEmitUF.Text;
    end;

    ACBrNFeABI1.Enviar('1');

    MemoResp.Lines.Text := ACBrNFeABI1.WebServices.Enviar.RetWS;
    memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.Enviar.RetornoWS;
    LoadXML(ACBrNFeABI1.WebServices.Enviar.RetornoWS, WBResposta);

    MemoDados.Lines.Add('');
    MemoDados.Lines.Add('Envio NFeABI');
    MemoDados.Lines.Add('tpAmb: '+ TipoAmbienteToStr(ACBrNFeABI1.WebServices.Enviar.TpAmb));
    MemoDados.Lines.Add('verAplic: '+ ACBrNFeABI1.WebServices.Enviar.verAplic);
    MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFeABI1.WebServices.Enviar.cStat));
    MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFeABI1.WebServices.Enviar.cUF));
    MemoDados.Lines.Add('xMotivo: '+ ACBrNFeABI1.WebServices.Enviar.xMotivo);
    MemoDados.Lines.Add('Protocolo: '+ ACBrNFeABI1.WebServices.Enviar.Protocolo);
  end;
end;

procedure TfrmACBrNFeABI.btnCNPJClick(Sender: TObject);
begin
  ShowMessage(ACBrNFeABI1.SSL.CertCNPJ);
end;

procedure TfrmACBrNFeABI.btnConsultarChaveClick(Sender: TObject);
var
  vChave: String;
begin
  vChave := '';
  if not(InputQuery('WebServices Consultar', 'Chave da NFeABI:', vChave)) then
    exit;

  ACBrNFeABI1.NotasFiscais.Clear;
  ACBrNFeABI1.Consultar(vChave);

  MemoResp.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetWS;
  memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetornoWS;
  LoadXML(ACBrNFeABI1.WebServices.Consulta.RetornoWS, WBResposta);
end;

procedure TfrmACBrNFeABI.btnConsultarClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFeABI1.Consultar;

    ShowMessage(ACBrNFeABI1.WebServices.Consulta.Protocolo);
    MemoResp.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetWS;
    memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.Consulta.RetornoWS;
    LoadXML(ACBrNFeABI1.WebServices.Consulta.RetornoWS, WBResposta);
  end;
end;

procedure TfrmACBrNFeABI.btnCriarEnviarSincronoClick(Sender: TObject);
var
  vNumNFeABI, vNumLote, vZipado: String;
  bZipado: Boolean;
begin
  vNumNFeABI := '';
  if not(InputQuery('WebServices Enviar Síncrono', 'Numero da Declaração', vNumNFeABI)) then
    exit;

  vNumLote := '1';
  if not(InputQuery('WebServices Enviar Síncrono', 'Numero do Lote', vNumLote)) then
    exit;

  vZipado := 'S';
  if not(InputQuery('WebServices Enviar Síncrono', 'Zipado (S/N)', vZipado)) then
    exit;

  bZipado := (vZipado = 'S') or (vZipado = 's');

  vNumLote := OnlyNumber(vNumLote);

  if Trim(vNumLote) = '' then
  begin
    MessageDlg('Número do Lote inválido.', mtError,[mbok], 0);
    exit;
  end;

  AlimentarComponente(vNumNFeABI);

  // Parâmetros do método Enviar:
  // 1o = Número do Lote
  // 2o = Se True (padrão) imprime automaticamente o DAMDFE
  // 3o = Se True (padrão) envia o XML zipado e codificado em base 64

  ACBrNFeABI1.Enviar(vNumLote, True, bZipado);

  MemoResp.Lines.Text   := ACBrNFeABI1.WebServices.Enviar.RetWS;
  memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.Enviar.RetornoWS;

  LoadXML(ACBrNFeABI1.WebServices.Enviar.RetWS, WBResposta);

  pgRespostas.ActivePageIndex := 1;

  with MemoDados do
  begin
    Lines.Add('');
    Lines.Add('Envio NFeABI');
    Lines.Add('tpAmb: '     + TipoAmbienteToStr(ACBrNFeABI1.WebServices.Enviar.tpAmb));
    Lines.Add('verAplic: '  + ACBrNFeABI1.WebServices.Enviar.verAplic);
    Lines.Add('cStat: '     + IntToStr(ACBrNFeABI1.WebServices.Enviar.cStat));
    Lines.Add('xMotivo: '   + ACBrNFeABI1.WebServices.Enviar.xMotivo);
    Lines.Add('cUF: '       + IntToStr(ACBrNFeABI1.WebServices.Enviar.cUF));
    Lines.Add('xMsg: '      + ACBrNFeABI1.WebServices.Enviar.Msg);
    Lines.Add('Protocolo: ' + ACBrNFeABI1.WebServices.Enviar.Protocolo);
  end;
end;

procedure TfrmACBrNFeABI.btnDataValidadeClick(Sender: TObject);
begin
  ShowMessage(FormatDateBr(ACBrNFeABI1.SSL.CertDataVenc));
end;

procedure TfrmACBrNFeABI.btnEnviarEmailClick(Sender: TObject);
var
  Para: String;
  CC: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if not OpenDialog1.Execute then
    Exit;

  ACBrNFeABI1.NotasFiscais.Clear;
  ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

  CC := TStringList.Create;
  try
    //CC.Add('email_1@provedor.com'); //especifique um email valido
    //CC.Add('email_2@provedor.com.br');    //especifique um email valido
    ConfigurarEmail;
    ACBrNFeABI1.NotasFiscais.Items[0].EnviarEmail(Para
      , edtEmailAssunto.Text
      , mmEmailMsg.Lines
      , True  // Enviar PDF junto
      , CC    // Lista com emails que serao enviado copias - TStrings
      , nil // Lista de anexos - TStrings
      );
  finally
    CC.Free;
  end;

end;

procedure TfrmACBrNFeABI.btnEnviarEventoEmailClick(Sender: TObject);
var
  Para: String;
  CC, Evento: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione o NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.xml';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.xml)|*-NFeABI.xml|Arquivos XML (*.xml)|*.xml|Todos os arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.xml)|*.xml|Todos os arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if not OpenDialog1.Execute then
    Exit;

  Evento := TStringList.Create;
  CC := TStringList.Create;
  try
    Evento.Clear;
    Evento.Add(OpenDialog1.FileName);

//    ACBrNFeABI1.EventoNFeABI.Evento.Clear;
//    ACBrNFeABI1.EventoNFeABI.LerXML(OpenDialog1.FileName);

    //CC.Add('email_1@provedor.com'); // especifique um email valido
    //CC.Add('email_2@provedor.com.br');    // especifique um email valido
    ConfigurarEmail;
    ACBrNFeABI1.EnviarEmailEvento(Para
      , edtEmailAssunto.Text
      , mmEmailMsg.Lines
      , CC // Lista com emails que serao enviado copias - TStrings
      , nil // Lista de anexos - TStrings
      , nil  // ReplyTo
      );
  finally
    CC.Free;
    Evento.Free;
  end;

end;

procedure TfrmACBrNFeABI.btnGerarPDFClick(Sender: TObject);
var
  CarregarMaisXML: Boolean;
begin
	CarregarMaisXML := true;
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;
  ACBrNFeABI1.NotasFiscais.Clear;

  while CarregarMaisXML do
  begin
    if OpenDialog1.Execute then
      ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    CarregarMaisXML := MessageDlg('Carregar mais NotasFiscais?', mtConfirmation, mbYesNoCancel, 0) = mrYes;
  end;

  ACBrNFeABI1.NotasFiscais.ImprimirPDF;
end;

procedure TfrmACBrNFeABI.btnGerarPDFEventoClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.xml';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.xml)|*-NFeABI.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  ACBrNFeABI1.NotasFiscais.Clear;
  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*-procEventoNFeABI.xml';
  OpenDialog1.Filter := 'Arquivos Evento (*-procEventoNFeABI.xml)|*-procEventoNFeABI.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.EventoNFeABI.Evento.Clear;
    ACBrNFeABI1.EventoNFeABI.LerXML(OpenDialog1.FileName);
    ACBrNFeABI1.DANFeABI.ImprimirEventoPDF;
  end;
end;

procedure TfrmACBrNFeABI.btnGerarXMLClick(Sender: TObject);
var
  vAux: String;
begin
  if not(InputQuery('WebServices Enviar', 'Numero da Declaração', vAux)) then
    exit;

  ACBrNFeABI1.NotasFiscais.Clear;

  AlimentarComponente(vAux);

  ACBrNFeABI1.NotasFiscais.Assinar;
  ACBrNFeABI1.NotasFiscais.Validar;

  ACBrNFeABI1.NotasFiscais.Items[0].GravarXML();

  ShowMessage('Arquivo gerado em: ' + ACBrNFeABI1.NotasFiscais.Items[0].NomeArq);
  MemoDados.Lines.Add('Arquivo gerado em: ' + ACBrNFeABI1.NotasFiscais.Items[0].NomeArq);

  MemoResp.Lines.LoadFromFile(ACBrNFeABI1.NotasFiscais.Items[0].NomeArq);

  LoadXML(MemoResp.Text, WBResposta);

  pgRespostas.ActivePageIndex := 1;
end;

procedure TfrmACBrNFeABI.btnHTTPSClick(Sender: TObject);
var
  Acao: String;
  OldUseCert: Boolean;
begin
  Acao := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' +
     '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
     'xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/"> ' +
     ' <soapenv:Header/>' +
     ' <soapenv:Body>' +
     ' <cli:consultaCEP>' +
     ' <cep>18270-170</cep>' +
     ' </cli:consultaCEP>' +
     ' </soapenv:Body>' +
     ' </soapenv:Envelope>';

  OldUseCert := ACBrNFeABI1.SSL.UseCertificateHTTP;
  ACBrNFeABI1.SSL.UseCertificateHTTP := False;

  try
    MemoResp.Lines.Text := ACBrNFeABI1.SSL.Enviar(Acao, 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl', '');
  finally
    ACBrNFeABI1.SSL.UseCertificateHTTP := OldUseCert;
  end;

  pgRespostas.ActivePageIndex := 0;
end;

procedure TfrmACBrNFeABI.btnImprimirClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName,False);
    ACBrNFeABI1.NotasFiscais.Imprimir;
  end;
end;

procedure TfrmACBrNFeABI.btnImprimirEventoClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.EventoNFeABI.Evento.Clear;
    ACBrNFeABI1.EventoNFeABI.LerXML(OpenDialog1.FileName);
    ACBrNFeABI1.ImprimirEvento;
  end;
end;

procedure TfrmACBrNFeABI.btnIssuerNameClick(Sender: TObject);
begin
 ShowMessage(ACBrNFeABI1.SSL.CertIssuerName + sLineBreak + sLineBreak +
             'Certificadora: ' + ACBrNFeABI1.SSL.CertCertificadora);
end;

procedure TfrmACBrNFeABI.btnLeituraX509Click(Sender: TObject);
begin
  with ACBrNFeABI1.SSL do
  begin
    CarregarCertificadoPublico(MemoDados.Lines.Text);
    MemoResp.Lines.Add(CertIssuerName);
    MemoResp.Lines.Add(CertRazaoSocial);
    MemoResp.Lines.Add(CertCNPJ);
    MemoResp.Lines.Add(CertSubjectName);
    MemoResp.Lines.Add(CertNumeroSerie);

    pgRespostas.ActivePageIndex := 0;
  end;
end;

procedure TfrmACBrNFeABI.btnLerArqINIClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Arquivo INI';
  OpenDialog1.DefaultExt := '*.ini';
  OpenDialog1.Filter :=
    'Arquivos INI (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromIni(OpenDialog1.FileName);
    ACBrNFeABI1.NotasFiscais.Assinar;
    ACBrNFeABI1.NotasFiscais.GravarXML();

    memoLog.Lines.Add('Arquivo gerado em: ' + ACBrNFeABI1.NotasFiscais[0].NomeArq);

    try
      ACBrNFeABI1.NotasFiscais.Validar;

      if ACBrNFeABI1.NotasFiscais[0].Alertas <> '' then
        MemoDados.Lines.Add('Alertas: '+ACBrNFeABI1.NotasFiscais[0].Alertas);

      ShowMessage('Declaração de Conteúdo Eletrônica Valida');
    except
      on E: Exception do
      begin
        pgRespostas.ActivePage := Dados;
        MemoDados.Lines.Add('Exception: ' + E.Message);
        MemoDados.Lines.Add('Erro: ' + ACBrNFeABI1.NotasFiscais[0].ErroValidacao);
        MemoDados.Lines.Add('Erro Completo: ' + ACBrNFeABI1.NotasFiscais[0].ErroValidacaoCompleto);
      end;
    end;
  end;
end;

procedure TfrmACBrNFeABI.btnGerarArqINIClick(Sender: TObject);
var
  vAux: string;
  SaveDlg: TSaveDialog;
  ArqINI: TStringList;
begin
  vAux := '1';
  if not(InputQuery('Gerar Arquivo INI', 'Numero da Declaração', vAux)) then
    exit;

  ACBrNFeABI1.NotasFiscais.Clear;
  AlimentarComponente(vAux);
  ACBrNFeABI1.NotasFiscais.GerarNFeABI;

  ArqINI := TStringList.Create;
  SaveDlg := TSaveDialog.Create(nil);
  try
    ArqINI.Text := ACBrNFeABI1.NotasFiscais.GerarIni;

    SaveDlg.Title := 'Escolha o local onde salvar o INI';
    SaveDlg.DefaultExt := '*.INI';
    SaveDlg.Filter := 'Arquivo INI(*.INI)|*.INI|Arquivo ini(*.ini)|*.ini|Todos os arquivos(*.*)|*.*';

    if SaveDlg.Execute then
      ArqINI.SaveToFile(SaveDlg.FileName);

    memoLog.Lines.Add('Arquivo Salvo: ' + SaveDlg.FileName);
  finally
    SaveDlg.Free;
    ArqINI.Free;
  end;
end;

procedure TfrmACBrNFeABI.btnLerArqINIEnviarEventoClick(Sender: TObject);
var
  LIdLote: String;
  SaveDlg: TSaveDialog;
  LTempXML: TStringList;
begin
  OpenDialog1.Title := 'Selecione o Arquivo INI';
  OpenDialog1.DefaultExt := '*.ini';
  OpenDialog1.Filter :=
    'Arquivos INI (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    LIdLote := '1';
    if not(InputQuery('WebServices Eventos', 'Identificador de controle do Lote de envio do Evento', LIdLote)) then
       exit;
    ACBrNFeABI1.EventoNFeABI.Evento.Clear;
    ACBrNFeABI1.EventoNFeABI.LerFromIni(OpenDialog1.FileName);
    LTempXML := TStringList.Create;
    try
      ACBrNFeABI1.EventoNFeABI.GerarXml;
      LTempXML.Text := ACBrNFeABI1.EventoNFeABI.XmlEnvio;
      SaveDlg := TSaveDialog.Create(nil);
      try
        SaveDlg.Title := 'Escolha o local onde salvar o XML';
        SaveDlg.DefaultExt := '*.XML';
        SaveDlg.Filter := 'Arquivo XML(*.XML)|*.XML|Arquivo xml(*.xml)|*.xml|Todos os arquivos(*.*)|*.*';
        if SaveDlg.Execute then
          LTempXML.SaveToFile(SaveDlg.FileName);

        memoLog.Lines.Add('Arquivo Salvo: ' + SaveDlg.FileName);
      finally
        SaveDlg.Free;
      end;
    finally
      LTempXML.Free;
    end;
  end;
end;

procedure TfrmACBrNFeABI.btnNumSerieClick(Sender: TObject);
begin
  ShowMessage(ACBrNFeABI1.SSL.CertNumeroSerie);
end;

procedure TfrmACBrNFeABI.btnSalvarConfigClick(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TfrmACBrNFeABI.btnSha256Click(Sender: TObject);
var
  Ahash: AnsiString;
begin
  Ahash := ACBrNFeABI1.SSL.CalcHash(Edit1.Text, dgstSHA256, outBase64, cbAssinar.Checked);
  MemoResp.Lines.Add( Ahash );
  pgRespostas.ActivePageIndex := 0;
end;

procedure TfrmACBrNFeABI.btnStatusServClick(Sender: TObject);
begin
  ACBrNFeABI1.WebServices.StatusServico.Executar;

  MemoResp.Lines.Text := ACBrNFeABI1.WebServices.StatusServico.RetWS;
  memoRespWS.Lines.Text := ACBrNFeABI1.WebServices.StatusServico.RetornoWS;
  LoadXML(ACBrNFeABI1.WebServices.StatusServico.RetornoWS, WBResposta);

  pgRespostas.ActivePageIndex := 1;

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Status Serviço');
  MemoDados.Lines.Add('tpAmb    : ' + TipoAmbienteToStr(ACBrNFeABI1.WebServices.StatusServico.tpAmb));
  MemoDados.Lines.Add('verAplic : ' + ACBrNFeABI1.WebServices.StatusServico.verAplic);
  MemoDados.Lines.Add('cStat    : ' + IntToStr(ACBrNFeABI1.WebServices.StatusServico.cStat));
  MemoDados.Lines.Add('xMotivo  : ' + ACBrNFeABI1.WebServices.StatusServico.xMotivo);
  MemoDados.Lines.Add('cUF      : ' + IntToStr(ACBrNFeABI1.WebServices.StatusServico.cUF));
  MemoDados.Lines.Add('dhRecbto : ' + DateTimeToStr(ACBrNFeABI1.WebServices.StatusServico.dhRecbto));
  MemoDados.Lines.Add('tMed     : ' + IntToStr(ACBrNFeABI1.WebServices.StatusServico.TMed));
  MemoDados.Lines.Add('dhRetorno: ' + DateTimeToStr(ACBrNFeABI1.WebServices.StatusServico.dhRetorno));
  MemoDados.Lines.Add('xObs     : ' + ACBrNFeABI1.WebServices.StatusServico.xObs);
end;

procedure TfrmACBrNFeABI.btnSubNameClick(Sender: TObject);
begin
  ShowMessage(ACBrNFeABI1.SSL.CertSubjectName + sLineBreak + sLineBreak +
              'Razão Social: ' + ACBrNFeABI1.SSL.CertRazaoSocial);
end;

procedure TfrmACBrNFeABI.btnValidarAssinaturaClick(Sender: TObject);
var
  Msg: String;
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    pgRespostas.ActivePageIndex := 0;
    MemoResp.Lines.Add('');
    MemoResp.Lines.Add('');

    if not ACBrNFeABI1.NotasFiscais.VerificarAssinatura(Msg) then
      MemoResp.Lines.Add('Erro: '+Msg)
    else
    begin
      MemoResp.Lines.Add('OK: Assinatura Válida');
      ACBrNFeABI1.SSL.CarregarCertificadoPublico( ACBrNFeABI1.NotasFiscais[0].NFeABI.signature.X509Certificate );
      MemoResp.Lines.Add('Assinado por: '+ ACBrNFeABI1.SSL.CertRazaoSocial);
      MemoResp.Lines.Add('CNPJ: '+ ACBrNFeABI1.SSL.CertCNPJ);
      MemoResp.Lines.Add('Num.Série: '+ ACBrNFeABI1.SSL.CertNumeroSerie);

      ShowMessage('ASSINATURA VÁLIDA');
    end;
  end;
end;

procedure TfrmACBrNFeABI.btnValidarRegrasNegocioClick(Sender: TObject);
var
  Msg, Tempo: String;
  Inicio: TDateTime;
  Ok: Boolean;
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    Inicio := Now;
    Ok := ACBrNFeABI1.NotasFiscais.ValidarRegrasdeNegocios(Msg);
    Tempo := FormatDateTime('hh:nn:ss:zzz', Now - Inicio);

    if not Ok then
    begin
      MemoDados.Lines.Add('Erro: ' + Msg);
      ShowMessage('Erros encontrados' + sLineBreak + 'Tempo: ' + Tempo);
    end
    else
      ShowMessage('Tudo OK' + sLineBreak + 'Tempo: ' + Tempo);
  end;
end;

procedure TfrmACBrNFeABI.btnValidarXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFeABI';
  OpenDialog1.DefaultExt := '*-NFeABI.XML';
  OpenDialog1.Filter := 'Arquivos NFeABI (*-NFeABI.XML)|*-NFeABI.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFeABI1.Configuracoes.Arquivos.PathSalvar;

  // Sugestão de configuração para apresentação de mensagem mais amigável ao usuário final
  ACBrNFeABI1.Configuracoes.Geral.ExibirErroSchema := False;
  ACBrNFeABI1.Configuracoes.Geral.FormatoAlerta := 'Campo:%DESCRICAO% - %MSG%';

  if OpenDialog1.Execute then
  begin
    ACBrNFeABI1.NotasFiscais.Clear;
    ACBrNFeABI1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    try
      ACBrNFeABI1.NotasFiscais.Validar;

      if ACBrNFeABI1.NotasFiscais.Items[0].Alertas <> '' then
        MemoDados.Lines.Add('Alertas: '+ACBrNFeABI1.NotasFiscais.Items[0].Alertas);

      ShowMessage('Declaração de Conteúdo Eletrônica Valida');
    except
      on E: Exception do
      begin
        pgRespostas.ActivePage := Dados;
        MemoDados.Lines.Add('Exception: ' + E.Message);
        MemoDados.Lines.Add('Erro: ' + ACBrNFeABI1.NotasFiscais.Items[0].ErroValidacao);
        MemoDados.Lines.Add('Erro Completo: ' + ACBrNFeABI1.NotasFiscais.Items[0].ErroValidacaoCompleto);
      end;
    end;
  end;
end;

procedure TfrmACBrNFeABI.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrNFeABI1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFeABI.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrNFeABI1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFeABI.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      ACBrNFeABI1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFeABI.cbSSLTypeChange(Sender: TObject);
begin
  if cbSSLType.ItemIndex <> -1 then
    ACBrNFeABI1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TfrmACBrNFeABI.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrNFeABI1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFeABI.FormCreate(Sender: TObject);
var
  T: TSSLLib;
  I: TACBrTipoEmissao;
  K: TVersaoNFeABI;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
begin
  cbSSLLib.Items.Clear;
  for T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) );
  cbSSLLib.ItemIndex := 0;

  cbCryptLib.Items.Clear;
  for U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) );
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  for V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) );
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  for X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) );
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  for Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(Y) ) );
  cbSSLType.ItemIndex := 0;

  cbFormaEmissao.Items.Clear;
  for I := Low(TACBrTipoEmissao) to High(TACBrTipoEmissao) do
     cbFormaEmissao.Items.Add( GetEnumName(TypeInfo(TACBrTipoEmissao), integer(I) ) );
  cbFormaEmissao.ItemIndex := 0;

  cbVersaoDF.Items.Clear;
  for K := Low(TVersaoNFeABI) to High(TVersaoNFeABI) do
     cbVersaoDF.Items.Add( GetEnumName(TypeInfo(TVersaoNFeABI), integer(K) ) );
  cbVersaoDF.ItemIndex := 0;

  LerConfiguracao;
  pgRespostas.ActivePageIndex := 2;
end;

procedure TfrmACBrNFeABI.GravarConfiguracao;
var
  IniFile: String;
  Ini: TIniFile;
  StreamMemo: TMemoryStream;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteInteger('Certificado', 'SSLLib',     cbSSLLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'CryptLib',   cbCryptLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'HttpLib',    cbHttpLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'XmlSignLib', cbXmlSignLib.ItemIndex);
    Ini.WriteString( 'Certificado', 'Caminho',    edtCaminho.Text);
    Ini.WriteString( 'Certificado', 'Senha',      edtSenha.Text);
    Ini.WriteString( 'Certificado', 'NumSerie',   edtNumSerie.Text);

    Ini.WriteBool(   'Geral', 'AtualizarXML',     cbxAtualizarXML.Checked);
    Ini.WriteBool(   'Geral', 'ExibirErroSchema', cbxExibirErroSchema.Checked);
    Ini.WriteString( 'Geral', 'FormatoAlerta',    edtFormatoAlerta.Text);
    Ini.WriteInteger('Geral', 'FormaEmissao',     cbFormaEmissao.ItemIndex);
    Ini.WriteInteger('Geral', 'VersaoDF',         cbVersaoDF.ItemIndex);
    Ini.WriteBool(   'Geral', 'RetirarAcentos',   cbxRetirarAcentos.Checked);
    Ini.WriteBool(   'Geral', 'Salvar',           ckSalvar.Checked);
    Ini.WriteString( 'Geral', 'PathSalvar',       edtPathLogs.Text);
    Ini.WriteString( 'Geral', 'PathSchemas',      edtPathSchemas.Text);

    Ini.WriteString( 'WebService', 'UF',         cbUF.Text);
    Ini.WriteInteger('WebService', 'Ambiente',   rgTipoAmb.ItemIndex);
    Ini.WriteBool(   'WebService', 'Visualizar', cbxVisualizar.Checked);
    Ini.WriteBool(   'WebService', 'SalvarSOAP', cbxSalvarSOAP.Checked);
    Ini.WriteBool(   'WebService', 'AjustarAut', cbxAjustarAut.Checked);
    Ini.WriteString( 'WebService', 'Aguardar',   edtAguardar.Text);
    Ini.WriteString( 'WebService', 'Tentativas', edtTentativas.Text);
    Ini.WriteString( 'WebService', 'Intervalo',  edtIntervalo.Text);
    Ini.WriteInteger('WebService', 'TimeOut',    seTimeOut.Value);
    Ini.WriteInteger('WebService', 'SSLType',    cbSSLType.ItemIndex);

    Ini.WriteString('Proxy', 'Host',  edtProxyHost.Text);
    Ini.WriteString('Proxy', 'Porta', edtProxyPorta.Text);
    Ini.WriteString('Proxy', 'User',  edtProxyUser.Text);
    Ini.WriteString('Proxy', 'Pass',  edtProxySenha.Text);

    Ini.WriteBool(  'Arquivos', 'Salvar',           cbxSalvarArqs.Checked);
    Ini.WriteBool(  'Arquivos', 'PastaMensal',      cbxPastaMensal.Checked);
    Ini.WriteBool(  'Arquivos', 'AddLiteral',       cbxAdicionaLiteral.Checked);
    Ini.WriteBool(  'Arquivos', 'EmissaoPathNFeABI',   cbxEmissaoPathNFeABI.Checked);
    Ini.WriteBool(  'Arquivos', 'SalvarPathEvento', cbxSalvaPathEvento.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorCNPJ',   cbxSepararPorCNPJ.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorModelo', cbxSepararPorModelo.Checked);
    Ini.WriteString('Arquivos', 'PathNFeABI',          edtPathNFeABI.Text);
    Ini.WriteString('Arquivos', 'PathEvento',       edtPathEvento.Text);

    Ini.WriteString('Emitente', 'CNPJ',        edtEmitCNPJ.Text);
    Ini.WriteString('Emitente', 'IE',          edtEmitIE.Text);
    Ini.WriteString('Emitente', 'RazaoSocial', edtEmitRazao.Text);
    Ini.WriteString('Emitente', 'Fantasia',    edtEmitFantasia.Text);
    Ini.WriteString('Emitente', 'Fone',        edtEmitFone.Text);
    Ini.WriteString('Emitente', 'CEP',         edtEmitCEP.Text);
    Ini.WriteString('Emitente', 'Logradouro',  edtEmitLogradouro.Text);
    Ini.WriteString('Emitente', 'Numero',      edtEmitNumero.Text);
    Ini.WriteString('Emitente', 'Complemento', edtEmitComp.Text);
    Ini.WriteString('Emitente', 'Bairro',      edtEmitBairro.Text);
    Ini.WriteString('Emitente', 'CodCidade',   edtEmitCodCidade.Text);
    Ini.WriteString('Emitente', 'Cidade',      edtEmitCidade.Text);
    Ini.WriteString('Emitente', 'UF',          edtEmitUF.Text);

    Ini.WriteString('Email', 'Host',    edtSmtpHost.Text);
    Ini.WriteString('Email', 'Port',    edtSmtpPort.Text);
    Ini.WriteString('Email', 'User',    edtSmtpUser.Text);
    Ini.WriteString('Email', 'Pass',    edtSmtpPass.Text);
    Ini.WriteString('Email', 'Assunto', edtEmailAssunto.Text);
    Ini.WriteBool(  'Email', 'SSL',     cbEmailSSL.Checked );

    StreamMemo := TMemoryStream.Create;
    mmEmailMsg.Lines.SaveToStream(StreamMemo);
    StreamMemo.Seek(0,soFromBeginning);

    Ini.WriteBinaryStream('Email', 'Mensagem', StreamMemo);

    StreamMemo.Free;

    Ini.WriteInteger('DANFeABI', 'Tipo',      rgTipoDANFeABI.ItemIndex);
    Ini.WriteString( 'DANFeABI', 'LogoMarca', edtLogoMarca.Text);

    ConfigurarComponente;
    ConfigurarEmail;
  finally
    Ini.Free;
  end;
end;

procedure TfrmACBrNFeABI.lblColaboradorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrNFeABI.lblDoar1Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrNFeABI.lblDoar2Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrNFeABI.lblMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold,fsUnderline];
end;

procedure TfrmACBrNFeABI.lblMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TfrmACBrNFeABI.lblPatrocinadorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrNFeABI.LerConfiguracao;
var
  IniFile: String;
  Ini: TIniFile;
  StreamMemo: TMemoryStream;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    cbSSLLib.ItemIndex     := Ini.ReadInteger('Certificado', 'SSLLib',     0);
    cbCryptLib.ItemIndex   := Ini.ReadInteger('Certificado', 'CryptLib',   0);
    cbHttpLib.ItemIndex    := Ini.ReadInteger('Certificado', 'HttpLib',    0);
    cbXmlSignLib.ItemIndex := Ini.ReadInteger('Certificado', 'XmlSignLib', 0);
    edtCaminho.Text        := Ini.ReadString( 'Certificado', 'Caminho',    '');
    edtSenha.Text          := Ini.ReadString( 'Certificado', 'Senha',      '');
    edtNumSerie.Text       := Ini.ReadString( 'Certificado', 'NumSerie',   '');

    cbxAtualizarXML.Checked     := Ini.ReadBool(   'Geral', 'AtualizarXML',     True);
    cbxExibirErroSchema.Checked := Ini.ReadBool(   'Geral', 'ExibirErroSchema', True);
    edtFormatoAlerta.Text       := Ini.ReadString( 'Geral', 'FormatoAlerta',    'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.');
    cbFormaEmissao.ItemIndex    := Ini.ReadInteger('Geral', 'FormaEmissao',     0);

    cbVersaoDF.ItemIndex      := Ini.ReadInteger('Geral', 'VersaoDF',       0);
    ckSalvar.Checked          := Ini.ReadBool(   'Geral', 'Salvar',         True);
    cbxRetirarAcentos.Checked := Ini.ReadBool(   'Geral', 'RetirarAcentos', True);
    edtPathLogs.Text          := Ini.ReadString( 'Geral', 'PathSalvar',     PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
    edtPathSchemas.Text       := Ini.ReadString( 'Geral', 'PathSchemas',    PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\'+GetEnumName(TypeInfo(TVersaoNFeABI), integer(cbVersaoDF.ItemIndex) ));

    cbUF.ItemIndex := cbUF.Items.IndexOf(Ini.ReadString('WebService', 'UF', 'SP'));

    rgTipoAmb.ItemIndex   := Ini.ReadInteger('WebService', 'Ambiente',   0);
    cbxVisualizar.Checked := Ini.ReadBool(   'WebService', 'Visualizar', False);
    cbxSalvarSOAP.Checked := Ini.ReadBool(   'WebService', 'SalvarSOAP', False);
    cbxAjustarAut.Checked := Ini.ReadBool(   'WebService', 'AjustarAut', False);
    edtAguardar.Text      := Ini.ReadString( 'WebService', 'Aguardar',   '0');
    edtTentativas.Text    := Ini.ReadString( 'WebService', 'Tentativas', '5');
    edtIntervalo.Text     := Ini.ReadString( 'WebService', 'Intervalo',  '0');
    seTimeOut.Value       := Ini.ReadInteger('WebService', 'TimeOut',    5000);
    cbSSLType.ItemIndex   := Ini.ReadInteger('WebService', 'SSLType',    0);

    edtProxyHost.Text  := Ini.ReadString('Proxy', 'Host',  '');
    edtProxyPorta.Text := Ini.ReadString('Proxy', 'Porta', '');
    edtProxyUser.Text  := Ini.ReadString('Proxy', 'User',  '');
    edtProxySenha.Text := Ini.ReadString('Proxy', 'Pass',  '');

    cbxSalvarArqs.Checked       := Ini.ReadBool(  'Arquivos', 'Salvar',           false);
    cbxPastaMensal.Checked      := Ini.ReadBool(  'Arquivos', 'PastaMensal',      false);
    cbxAdicionaLiteral.Checked  := Ini.ReadBool(  'Arquivos', 'AddLiteral',       false);
    cbxEmissaoPathNFeABI.Checked   := Ini.ReadBool(  'Arquivos', 'EmissaoPathNFeABI',   false);
    cbxSalvaPathEvento.Checked  := Ini.ReadBool(  'Arquivos', 'SalvarPathEvento', false);
    cbxSepararPorCNPJ.Checked   := Ini.ReadBool(  'Arquivos', 'SepararPorCNPJ',   false);
    cbxSepararPorModelo.Checked := Ini.ReadBool(  'Arquivos', 'SepararPorModelo', false);
    edtPathNFeABI.Text             := Ini.ReadString('Arquivos', 'PathNFeABI',          '');
    edtPathEvento.Text          := Ini.ReadString('Arquivos', 'PathEvento',       '');

    edtEmitCNPJ.Text       := Ini.ReadString('Emitente', 'CNPJ',        '');
    edtEmitIE.Text         := Ini.ReadString('Emitente', 'IE',          '');
    edtEmitRazao.Text      := Ini.ReadString('Emitente', 'RazaoSocial', '');
    edtEmitFantasia.Text   := Ini.ReadString('Emitente', 'Fantasia',    '');
    edtEmitFone.Text       := Ini.ReadString('Emitente', 'Fone',        '');
    edtEmitCEP.Text        := Ini.ReadString('Emitente', 'CEP',         '');
    edtEmitLogradouro.Text := Ini.ReadString('Emitente', 'Logradouro',  '');
    edtEmitNumero.Text     := Ini.ReadString('Emitente', 'Numero',      '');
    edtEmitComp.Text       := Ini.ReadString('Emitente', 'Complemento', '');
    edtEmitBairro.Text     := Ini.ReadString('Emitente', 'Bairro',      '');
    edtEmitCodCidade.Text  := Ini.ReadString('Emitente', 'CodCidade',   '');
    edtEmitCidade.Text     := Ini.ReadString( 'Emitente', 'Cidade',      '');
    edtEmitUF.Text         := Ini.ReadString('Emitente', 'UF',          '');

    edtSmtpHost.Text     := Ini.ReadString('Email', 'Host',    '');
    edtSmtpPort.Text     := Ini.ReadString('Email', 'Port',    '');
    edtSmtpUser.Text     := Ini.ReadString('Email', 'User',    '');
    edtSmtpPass.Text     := Ini.ReadString('Email', 'Pass',    '');
    edtEmailAssunto.Text := Ini.ReadString('Email', 'Assunto', '');
    cbEmailSSL.Checked   := Ini.ReadBool(  'Email', 'SSL',     False);

    StreamMemo := TMemoryStream.Create;
    Ini.ReadBinaryStream('Email', 'Mensagem', StreamMemo);
    mmEmailMsg.Lines.LoadFromStream(StreamMemo);
    StreamMemo.Free;

    rgTipoDANFeABI.ItemIndex := Ini.ReadInteger('DANFeABI', 'Tipo',       0);
    edtLogoMarca.Text    := Ini.ReadString( 'DANFeABI', 'LogoMarca',  '');

    ConfigurarComponente;
    ConfigurarEmail;
  finally
    Ini.Free;
  end;
end;

procedure TfrmACBrNFeABI.ConfigurarComponente;
var
  PathMensal: string;
begin
  ACBrNFeABI1.Configuracoes.Certificados.ArquivoPFX  := edtCaminho.Text;
  ACBrNFeABI1.Configuracoes.Certificados.Senha       := edtSenha.Text;
  ACBrNFeABI1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;

  ACBrNFeABI1.SSL.DescarregarCertificado;

  with ACBrNFeABI1.Configuracoes.Geral do
  begin
    SSLLib        := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib   := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib    := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);

    AtualizarSSLLibsCombo;

    Salvar           := ckSalvar.Checked;
    ExibirErroSchema := cbxExibirErroSchema.Checked;
    RetirarAcentos   := cbxRetirarAcentos.Checked;
    FormatoAlerta    := edtFormatoAlerta.Text;
    FormaEmissao     := TACBrTipoEmissao(cbFormaEmissao.ItemIndex);
    VersaoDF         := TVersaoNFeABI(cbVersaoDF.ItemIndex);
  end;

  with ACBrNFeABI1.Configuracoes.WebServices do
  begin
    UF         := cbUF.Text;
    Ambiente   := StrToTipoAmbiente(IntToStr(rgTipoAmb.ItemIndex+1));
    Visualizar := cbxVisualizar.Checked;
    Salvar     := cbxSalvarSOAP.Checked;

    AjustaAguardaConsultaRet := cbxAjustarAut.Checked;

    if NaoEstaVazio(edtAguardar.Text)then
      AguardarConsultaRet := ifThen(StrToInt(edtAguardar.Text) < 1000, StrToInt(edtAguardar.Text) * 1000, StrToInt(edtAguardar.Text))
    else
      edtAguardar.Text := IntToStr(AguardarConsultaRet);

    if NaoEstaVazio(edtTentativas.Text) then
      Tentativas := StrToInt(edtTentativas.Text)
    else
      edtTentativas.Text := IntToStr(Tentativas);

    if NaoEstaVazio(edtIntervalo.Text) then
      IntervaloTentativas := ifThen(StrToInt(edtIntervalo.Text) < 1000, StrToInt(edtIntervalo.Text) * 1000, StrToInt(edtIntervalo.Text))
    else
      edtIntervalo.Text := IntToStr(ACBrNFeABI1.Configuracoes.WebServices.IntervaloTentativas);

    TimeOut   := seTimeOut.Value;
    ProxyHost := edtProxyHost.Text;
    ProxyPort := edtProxyPorta.Text;
    ProxyUser := edtProxyUser.Text;
    ProxyPass := edtProxySenha.Text;
  end;

  ACBrNFeABI1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);

  with ACBrNFeABI1.Configuracoes.Arquivos do
  begin
    Salvar           := cbxSalvarArqs.Checked;
    SepararPorMes    := cbxPastaMensal.Checked;
    AdicionarLiteral := cbxAdicionaLiteral.Checked;
    EmissaoPathNFeABI  := cbxEmissaoPathNFeABI.Checked;
    SepararPorCNPJ   := cbxSepararPorCNPJ.Checked;
    SepararPorModelo := cbxSepararPorModelo.Checked;
    PathSchemas      := edtPathSchemas.Text;
    PathNFeABI         := edtPathNFeABI.Text;
    PathEvento       := edtPathEvento.Text;
    PathMensal       := GetPathNFeABI(0);
    PathSalvar       := PathMensal;
  end;

  if ACBrNFeABI1.DANFeABI <> nil then
  begin
    ACBrNFeABI1.DANFeABI.TipoDANFeABI := StrToTpImp(IntToStr(rgTipoDANFeABI.ItemIndex + 1));
    ACBrNFeABI1.DANFeABI.Logo := edtLogoMarca.Text;

    ACBrNFeABI1.DANFeABI.PathPDF := PathMensal;
    ACBrNFeABI1.DANFeABI.Usuario := 'ACBr';

    ACBrNFeABI1.DANFeABI.MargemDireita  := 4;
    ACBrNFeABI1.DANFeABI.MargemEsquerda := 4;
    ACBrNFeABI1.DANFeABI.MargemSuperior := 7;
    ACBrNFeABI1.DANFeABI.MargemInferior := 7;

//    ACBrNFeABI1.DANFeABI.ImprimeDadosExtras := [deRelacaoDFe, deValorTotal];
  end;
end;

procedure TfrmACBrNFeABI.ConfigurarEmail;
begin
  ACBrMail1.Host := edtSmtpHost.Text;
  ACBrMail1.Port := edtSmtpPort.Text;
  ACBrMail1.Username := edtSmtpUser.Text;
  ACBrMail1.Password := edtSmtpPass.Text;
  ACBrMail1.From := edtSmtpUser.Text;
  ACBrMail1.SetSSL := cbEmailSSL.Checked; // SSL - Conexao Segura
  ACBrMail1.SetTLS := cbEmailSSL.Checked; // Auto TLS
  ACBrMail1.ReadingConfirmation := False; //Pede confirmacao de leitura do email
  ACBrMail1.UseThread := False;           //Aguarda Envio do Email(nao usa thread)
  ACBrMail1.FromName := 'Projeto ACBr - ACBrNFeABI';
end;

procedure TfrmACBrNFeABI.LoadXML(RetWS: String; MyWebBrowser: TWebBrowser);
begin
  WriteToTXT(PathWithDelim(ExtractFileDir(application.ExeName)) + 'temp.xml',
                      ConverteXMLtoUTF8(RetWS), False, False);

  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(application.ExeName)) + 'temp.xml');

  if ACBrNFeABI1.NotasFiscais.Count > 0then
    MemoResp.Lines.Add('Empresa: ' + ACBrNFeABI1.NotasFiscais.Items[0].NFeABI.Emit.xNome);
end;

procedure TfrmACBrNFeABI.PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    TEdit(Sender).Text := Dir;
end;

procedure TfrmACBrNFeABI.sbPathEventoClick(Sender: TObject);
begin
  PathClick(edtPathEvento);
end;

procedure TfrmACBrNFeABI.sbPathNFeABIClick(Sender: TObject);
begin
  PathClick(edtPathNFeABI);
end;

procedure TfrmACBrNFeABI.sbtnCaminhoCertClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

  if OpenDialog1.Execute then
    edtCaminho.Text := OpenDialog1.FileName;
end;

procedure TfrmACBrNFeABI.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := ACBrNFeABI1.SSL.SelecionarCertificado;
end;

procedure TfrmACBrNFeABI.sbtnLogoMarcaClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Logo';
  OpenDialog1.DefaultExt := '*.bmp';
  OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

  if OpenDialog1.Execute then
    edtLogoMarca.Text := OpenDialog1.FileName;
end;

procedure TfrmACBrNFeABI.sbtnNumSerieClick(Sender: TObject);
var
  I: Integer;
  ASerie: String;
  AddRow: Boolean;
begin
  ACBrNFeABI1.SSL.LerCertificadosStore;
  AddRow := False;

  with frmSelecionarCertificado.StringGrid1 do
  begin
    ColWidths[0] := 220;
    ColWidths[1] := 250;
    ColWidths[2] := 120;
    ColWidths[3] := 80;
    ColWidths[4] := 150;

    Cells[0, 0] := 'Num.Série';
    Cells[1, 0] := 'Razão Social';
    Cells[2, 0] := 'CNPJ';
    Cells[3, 0] := 'Validade';
    Cells[4, 0] := 'Certificadora';
  end;

  for I := 0 to ACBrNFeABI1.SSL.ListaCertificados.Count-1 do
  begin
    with ACBrNFeABI1.SSL.ListaCertificados[I] do
    begin
      ASerie := NumeroSerie;

      if (CNPJ <> '') then
      begin
        with frmSelecionarCertificado.StringGrid1 do
        begin
          if Addrow then
            RowCount := RowCount + 1;

          Cells[0, RowCount-1] := NumeroSerie;
          Cells[1, RowCount-1] := RazaoSocial;
          Cells[2, RowCount-1] := CNPJ;
          Cells[3, RowCount-1] := FormatDateBr(DataVenc);
          Cells[4, RowCount-1] := Certificadora;

          AddRow := True;
        end;
      end;
    end;
  end;

  frmSelecionarCertificado.ShowModal;

  if frmSelecionarCertificado.ModalResult = mrOK then
    edtNumSerie.Text := frmSelecionarCertificado.StringGrid1.Cells[0, frmSelecionarCertificado.StringGrid1.Row];
end;

procedure TfrmACBrNFeABI.sbtnPathSalvarClick(Sender: TObject);
begin
  PathClick(edtPathLogs);
end;

procedure TfrmACBrNFeABI.spPathSchemasClick(Sender: TObject);
begin
  PathClick(edtPathSchemas);
end;

end.
