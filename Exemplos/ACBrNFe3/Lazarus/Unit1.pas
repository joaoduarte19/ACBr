{$I ACBr.inc}

unit Unit1;

interface

uses IniFiles, { ShellAPI,}
  Classes, SysUtils, FileUtil, IpHtml, Ipfilebroker, SynHighlighterXML, SynEdit,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  ACBrNFe, ACBrNFeDANFeRLClass, pcnConversao, ACBrUtil, pcnNFeW, pcnNFeRTXT,
  pcnAuxiliar, types, ACBrDFeUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    btnAdicionarProtNFe: TButton;
    btnCancelarChave: TButton;
    btnCancNF: TButton;
    btnCarregarXMLEnviar: TButton;
    btnCartadeCorrecao: TButton;
    btnConsCad: TButton;
    btnConsultar: TButton;
    btnConsultarChave: TButton;
    btnConsultarDPEC: TButton;
    btnConsultarRecibo: TButton;
    btnCriarEnviar: TButton;
    btnEnvDPEC: TButton;
    btnEnviarEmail: TButton;
    btnGerarNFE: TButton;
    btnGerarPDF: TButton;
    btnGerarTXT: TButton;
    btnImportarXML: TButton;
    btnImprimir: TButton;
    btnInutilizar: TButton;
    btnSalvarConfig: TBitBtn;
    btnStatusServ: TButton;
    btnValidarAssinatura: TButton;
    btnValidarXML: TButton;
    btnManifDestConfirmacao: TButton;
    btnNfeDestinadas: TButton;
    btnImprimirCCe: TButton;
    btnEnviarEvento: TButton;
    cbEmailSSL: TCheckBox;
    cbUF: TComboBox;
    ckSalvar: TCheckBox;
    ckVisualizar: TCheckBox;
    Dados: TTabSheet;
    edtCaminho: TEdit;
    edtEmailAssunto: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCEP: TEdit;
    edtEmitCidade: TEdit;
    edtEmitCNPJ: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitComp: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitIE: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitRazao: TEdit;
    edtEmitUF: TEdit;
    edtLogoMarca: TEdit;
    edtNumSerie: TEdit;
    edtPathLogs: TEdit;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxySenha: TEdit;
    edtProxyUser: TEdit;
    edtSenha: TEdit;
    edtSmtpHost: TEdit;
    edtSmtpPass: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    gbProxy: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblColaborador: TLabel;
    lblDoar1: TLabel;
    lblDoar2: TLabel;
    lblPatrocinador: TLabel;
    MemoDados: TMemo;
    memoLog: TMemo;
    MemoResp: TMemo;
    memoRespWS: TMemo;
    mmEmailMsg: TMemo;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgFormaEmissao: TRadioGroup;
    rgTipoAmb: TRadioGroup;
    rgTipoDanfe: TRadioGroup;
    sbtnCaminhoCert: TSpeedButton;
    sbtnGetCert: TSpeedButton;
    sbtnLogoMarca: TSpeedButton;
    sbtnPathSalvar: TSpeedButton;
    SynReposta: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    trvwNFe: TTreeView;
    procedure ACBrNFe1GerarLog(const Mensagem: String);
    procedure ACBrNFe1StatusChange(Sender: TObject);
    procedure btnAdicionarProtNFeClick(Sender: TObject);
    procedure btnCancelarChaveClick(Sender: TObject);
    procedure btnCancNFClick(Sender: TObject);
    procedure btnCarregarXMLEnviarClick(Sender: TObject);
    procedure btnCartadeCorrecaoClick(Sender: TObject);
    procedure btnConsCadClick(Sender: TObject);
    procedure btnConsultarChaveClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConsultarDPECClick(Sender: TObject);
    procedure btnConsultarReciboClick(Sender: TObject);
    procedure btnCriarEnviarClick(Sender: TObject);
    procedure btnEnvDPECClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnGerarNFEClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnGerarTXTClick(Sender: TObject);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure btnManifDestConfirmacaoClick(Sender: TObject);
    procedure btnNfeDestinadasClick(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnValidarAssinaturaClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnImprimirCCeClick(Sender: TObject);
    procedure btnEnviarEventoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblColaboradorClick(Sender: TObject);
    procedure lblColaboradorMouseEnter(Sender: TObject);
    procedure lblColaboradorMouseLeave(Sender: TObject);
    procedure lblDoar1Click(Sender: TObject);
    procedure lblPatrocinadorClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
  private
    { private declarations }
    procedure GravarConfiguracao ;
    procedure LerConfiguracao ;
    procedure GerarNFe(NumNFe : String);
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TSynEdit);
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FileCtrl, pcnNFe, ufrmStatus, ACBrNFeNotasFiscais, DateUtils, ACBrNFeUtil,
     LCLProc;

const
  SELDIRHELP = 1000;

{$R *.lfm}

{ TForm1 }


procedure TForm1.GerarNFe(NumNFe : String);
begin
  with ACBrNFe1.NotasFiscais.Add.NFe do
   begin
     Ide.cNF       := StrToInt(NumNFe); //Caso não seja preenchido será gerado um número aleatório pelo componente
     Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
     Ide.indPag    := ipVista;
     Ide.modelo    := 55;
     Ide.serie     := 1;
     Ide.nNF       := StrToInt(NumNFe);
     Ide.dEmi      := Date;
     Ide.dSaiEnt   := Date;
     Ide.hSaiEnt   := Now;
     Ide.tpNF      := tnSaida;
     Ide.tpEmis    := teNormal;
     Ide.tpAmb     := taProducao;  //Lembre-se de trocar esta variável quando for para ambiente de produção
     Ide.verProc   := '1.0.0.0'; //Versão do seu sistema
     Ide.cUF       := NotaUtil.UFtoCUF(edtEmitUF.Text);
     Ide.cMunFG    := StrToInt(edtEmitCodCidade.Text);
     Ide.finNFe    := fnNormal;

//     Ide.dhCont := date;
//     Ide.xJust  := 'Justificativa Contingencia';

//Para NFe referenciada use os campos abaixo
{     with Ide.NFref.Add do
      begin
        refNFe       := ''; //NFe Eletronica

        RefNF.cUF    := 0;  // |
        RefNF.AAMM   := ''; // |
        RefNF.CNPJ   := ''; // |
        RefNF.modelo := 1;  // |- NFe Modelo 1/1A
        RefNF.serie  := 1;  // |
        RefNF.nNF    := 0;  // |

        RefNFP.cUF     := 0;  // |
        RefNFP.AAMM    := ''; // |
        RefNFP.CNPJCPF := ''; // |
        RefNFP.IE      := ''; // |- NF produtor Rural
        RefNFP.modelo  := ''; // |
        RefNFP.serie   := 1;  // |
        RefNFP.nNF     := 0;  // |

        RefECF.modelo  := ECFModRef2B; // |
        RefECF.nECF    := '';          // |- Cupom Fiscal
        RefECF.nCOO    := '';          // |
      end;
}
      Emit.CNPJCPF           := edtEmitCNPJ.Text;
      Emit.IE                := edtEmitIE.Text;
      Emit.xNome             := edtEmitRazao.Text;
      Emit.xFant             := edtEmitFantasia.Text;

      Emit.EnderEmit.fone    := edtEmitFone.Text;
      Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
      Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
      Emit.EnderEmit.nro     := edtEmitNumero.Text;
      Emit.EnderEmit.xCpl    := edtEmitComp.Text;
      Emit.EnderEmit.xBairro := edtEmitBairro.Text;
      Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
      Emit.EnderEmit.xMun    := edtEmitCidade.Text;
      Emit.EnderEmit.UF      := edtEmitUF.Text;
      Emit.enderEmit.cPais   := 1058;
      Emit.enderEmit.xPais   := 'BRASIL';

      Emit.IEST              := '';
      Emit.IM                := '2648800'; // Preencher no caso de existir serviços na nota
      Emit.CNAE              := '6201500'; // Verifique na cidade do emissor da NFe se é permitido
                                    // a inclusão de serviços na NFe
      Emit.CRT               := crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)

//Para NFe Avulsa preencha os campos abaixo
{      Avulsa.CNPJ    := '';
      Avulsa.xOrgao  := '';
      Avulsa.matr    := '';
      Avulsa.xAgente := '';
      Avulsa.fone    := '';
      Avulsa.UF      := '';
      Avulsa.nDAR    := '';
      Avulsa.dEmi    := now;
      Avulsa.vDAR    := 0;
      Avulsa.repEmi  := '';
      Avulsa.dPag    := now;             }

      Dest.CNPJCPF           := '05481336000137';
      Dest.IE                := 'ISENTO';
      Dest.ISUF              := '';
      Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';

      Dest.EnderDest.Fone    := '1532599600';
      Dest.EnderDest.CEP     := 18270170;
      Dest.EnderDest.xLgr    := 'Rua Coronel Aureliano de Camargo';
      Dest.EnderDest.nro     := '973';
      Dest.EnderDest.xCpl    := '';
      Dest.EnderDest.xBairro := 'Centro';
      Dest.EnderDest.cMun    := 3554003;
      Dest.EnderDest.xMun    := 'Tatuí';
      Dest.EnderDest.UF      := 'SP';
      Dest.EnderDest.cPais   := 1058;
      Dest.EnderDest.xPais   := 'BRASIL';

//Use os campos abaixo para informar o endereço de retirada quando for diferente do Remetente/Destinatário
{      Retirada.CNPJCPF := '';
      Retirada.xLgr    := '';
      Retirada.nro     := '';
      Retirada.xCpl    := '';
      Retirada.xBairro := '';
      Retirada.cMun    := 0;
      Retirada.xMun    := '';
      Retirada.UF      := '';}

//Use os campos abaixo para informar o endereço de entrega quando for diferente do Remetente/Destinatário
{      Entrega.CNPJCPF := '';
      Entrega.xLgr    := '';
      Entrega.nro     := '';
      Entrega.xCpl    := '';
      Entrega.xBairro := '';
      Entrega.cMun    := 0;
      Entrega.xMun    := '';
      Entrega.UF      := '';}
 {
//Adicionando Produtos
      with Det.Add do
       begin
         Prod.nItem    := 1; // Número sequencial, para cada item deve ser incrementado
         Prod.cProd    := '123456';
         Prod.cEAN     := '7896523206646';
         Prod.xProd    := 'Descrição do Produto';
         Prod.NCM      := '94051010'; // Tabela NCM disponível em  http://www.receita.fazenda.gov.br/Aliquotas/DownloadArqTIPI.htm
         Prod.EXTIPI   := '';
         Prod.CFOP     := '5101';
         Prod.uCom     := 'UN';
         Prod.qCom     := 1 ;
         Prod.vUnCom   := 100;
         Prod.vProd    := 100 ;

         Prod.cEANTrib  := '7896523206646';
         Prod.uTrib     := 'UN';
         Prod.qTrib     := 1;
         Prod.vUnTrib   := 100;

         Prod.vOutro    := 0;
         Prod.vFrete    := 0;
         Prod.vSeg      := 0;
         Prod.vDesc     := 0;

         infAdProd      := 'Informação Adicional do Produto';
}
//Declaração de Importação. Pode ser adicionada várias através do comando Prod.DI.Add
{         with Prod.DI.Add do
          begin
            nDi         := '';
            dDi         := now;
            xLocDesemb  := '';
            UFDesemb    := '';
            dDesemb     := now;
            cExportador := '';

            with adi.Add do
             begin
               nAdicao     := 1;
               nSeqAdi     := 1;
               cFabricante := '';
               vDescDI     := 0;
             end;
          end;
}
//Campos para venda de veículos novos
{         with Prod.veicProd do
          begin
            tpOP    := toVendaConcessionaria;
            chassi  := '';
            cCor    := '';
            xCor    := '';
            pot     := '';
            Cilin   := '';
            pesoL   := '';
            pesoB   := '';
            nSerie  := '';
            tpComb  := '';
            nMotor  := '';
            CMT     := '';
            dist    := '';
            RENAVAM := '';
            anoMod  := 0;
            anoFab  := 0;
            tpPint  := '';
            tpVeic  := 0;
            espVeic := 0;
            VIN     := '';
            condVeic := cvAcabado;
            cMod    := '';
          end;
}
//Campos específicos para venda de medicamentos
{         with Prod.med.Add do
          begin
            nLote := '';
            qLote := 0 ;
            dFab  := now ;
            dVal  := now ;
            vPMC  := 0 ;
          end;  }
//Campos específicos para venda de armamento
{         with Prod.arma.Add do
          begin
            nSerie := 0;
            tpArma := taUsoPermitido ;
            nCano  := 0 ;
            descr  := '' ;
          end;      }
//Campos específicos para venda de combustível(distribuidoras)
{         with Prod.comb do
          begin
            cProdANP := 0;
            CODIF    := '';
            qTemp    := 0;
            UFcons   := '';

            CIDE.qBCprod   := 0 ;
            CIDE.vAliqProd := 0 ;
            CIDE.vCIDE     := 0 ;

            ICMS.vBCICMS   := 0 ;
            ICMS.vICMS     := 0 ;
            ICMS.vBCICMSST := 0 ;
            ICMS.vICMSST   := 0 ;

            ICMSInter.vBCICMSSTDest := 0 ;
            ICMSInter.vICMSSTDest   := 0 ;

            ICMSCons.vBCICMSSTCons := 0 ;
            ICMSCons.vICMSSTCons   := 0 ;
            ICMSCons.UFcons        := '' ;
          end;}

 {        with Imposto do
          begin
            with ICMS do
             begin
               CST          := cst00;
               ICMS.orig    := oeNacional;
               ICMS.modBC   := dbiValorOperacao;
               ICMS.vBC     := 100;
               ICMS.pICMS   := 18;
               ICMS.vICMS   := 18;
               ICMS.modBCST := dbisMargemValorAgregado;
               ICMS.pMVAST  := 0;
               ICMS.pRedBCST:= 0;
               ICMS.vBCST   := 0;
               ICMS.pICMSST := 0;
               ICMS.vICMSST := 0;
               ICMS.pRedBC  := 0;
             end;

            with IPI do
             begin
               CST      := ipi99 ;
               clEnq    := '999';
               CNPJProd := '';
               cSelo    := '';
               qSelo    := 0;
               cEnq     := '';

               vBC    := 100;
               qUnid  := 0;
               vUnid  := 0;
               pIPI   := 5;
               vIPI   := 5;
             end;         }
{
            with II do
             begin
               vBc      := 0;
               vDespAdu := 0;
               vII      := 0;
               vIOF     := 0;
             end;

            with PIS do
             begin
               CST      := pis99;
               PIS.vBC  := 0;
               PIS.pPIS := 0;
               PIS.vPIS := 0;

               PIS.qBCProd   := 0;
               PIS.vAliqProd := 0;
               PIS.vPIS      := 0;
             end;

            with PISST do
             begin
               vBc       := 0;
               pPis      := 0;
               qBCProd   := 0;
               vAliqProd := 0;
               vPIS      := 0;
             end;

            with COFINS do
             begin
               CST            := cof99;
               COFINS.vBC     := 0;
               COFINS.pCOFINS := 0;
               COFINS.vCOFINS := 0;

               COFINS.qBCProd   := 0;
               COFINS.vAliqProd := 0;
             end;

            with COFINSST do
             begin
               vBC       := 0;
               pCOFINS   := 0;
               qBCProd   := 0;
               vAliqProd := 0;
               vCOFINS   := 0;
             end;
}
//Grupo para serviços
{            with ISSQN do
             begin
               vBC       := 0;
               vAliq     := 0;
               vISSQN    := 0;
               cMunFG    := 0;
               cListServ := 1402; // Preencha este campo usando a tabela disponível
                               // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
             end;}
      {    end;
       end ;         }

//Adicionando Serviços
      with Det.Add do
       begin
         Prod.nItem    := 1; // Número sequencial, para cada item deve ser incrementado
         Prod.cProd    := '123457';
         Prod.cEAN     := '';
         Prod.xProd    := 'Descrição do Serviço';
         Prod.NCM      := '99';
         Prod.EXTIPI   := '';
         Prod.CFOP     := '6102';
         Prod.uCom     := 'UND';
         Prod.qCom     := 1 ;
         Prod.vUnCom   := 100;
         Prod.vProd    := 100 ;

         Prod.cEANTrib  := '';
         Prod.uTrib     := 'UND';
         Prod.qTrib     := 1;
         Prod.vUnTrib   := 100;

         Prod.vFrete    := 0;
         Prod.vSeg      := 0;
         Prod.vDesc     := 0;

         infAdProd      := 'Informação Adicional do Serviço';

//Grupo para serviços
            with Imposto.ISSQN do
             begin
               cSitTrib  := ISSQNcSitTribNORMAL;
               vBC       := 100;
               vAliq     := 2;
               vISSQN    := 2;
               cMunFG    := 3554003;
               cListServ := '1402'; // Preencha este campo usando a tabela disponível
                               // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
             end;
       end ;

      Total.ICMSTot.vBC     := 0;
      Total.ICMSTot.vICMS   := 0;
      Total.ICMSTot.vBCST   := 0;
      Total.ICMSTot.vST     := 0;
      Total.ICMSTot.vProd   := 0;
      Total.ICMSTot.vFrete  := 0;
      Total.ICMSTot.vSeg    := 0;
      Total.ICMSTot.vDesc   := 0;
      Total.ICMSTot.vII     := 0;
      Total.ICMSTot.vIPI    := 0;
      Total.ICMSTot.vPIS    := 0;
      Total.ICMSTot.vCOFINS := 0;
      Total.ICMSTot.vOutro  := 0;
      Total.ICMSTot.vNF     := 100;

      Total.ISSQNtot.vServ   := 100;
      Total.ISSQNTot.vBC     := 100;
      Total.ISSQNTot.vISS    := 2;
      Total.ISSQNTot.vPIS    := 0;
      Total.ISSQNTot.vCOFINS := 0;

{      Total.retTrib.vRetPIS    := 0;
      Total.retTrib.vRetCOFINS := 0;
      Total.retTrib.vRetCSLL   := 0;
      Total.retTrib.vBCIRRF    := 0;
      Total.retTrib.vIRRF      := 0;
      Total.retTrib.vBCRetPrev := 0;
      Total.retTrib.vRetPrev   := 0;}

      Transp.modFrete := mfContaEmitente;
      Transp.Transporta.CNPJCPF  := '';
      Transp.Transporta.xNome    := '';
      Transp.Transporta.IE       := '';
      Transp.Transporta.xEnder   := '';
      Transp.Transporta.xMun     := '';
      Transp.Transporta.UF       := '';

{      Transp.retTransp.vServ    := 0;
      Transp.retTransp.vBCRet   := 0;
      Transp.retTransp.pICMSRet := 0;
      Transp.retTransp.vICMSRet := 0;
      Transp.retTransp.CFOP     := '';
      Transp.retTransp.cMunFG   := 0;         }

      Transp.veicTransp.placa := '';
      Transp.veicTransp.UF    := '';
      Transp.veicTransp.RNTC  := '';
//Dados do Reboque
{      with Transp.Reboque.Add do
       begin
         placa := '';
         UF    := '';
         RNTC  := '';
       end;}

      with Transp.Vol.Add do
       begin
         qVol  := 1;
         esp   := 'Especie';
         marca := 'Marca';
         nVol  := 'Numero';
         pesoL := 100;
         pesoB := 110;

         //Lacres do volume. Pode ser adicionado vários
         //Lacres.Add.nLacre := '';
       end;

      Cobr.Fat.nFat  := 'Numero da Fatura';
      Cobr.Fat.vOrig := 100 ;
      Cobr.Fat.vDesc := 0 ;
      Cobr.Fat.vLiq  := 100 ;

      with Cobr.Dup.Add do
       begin
         nDup  := '1234';
         dVenc := now+10;
         vDup  := 50;
       end;

      with Cobr.Dup.Add do
       begin
         nDup  := '1235';
         dVenc := now+10;
         vDup  := 50;
       end;


      InfAdic.infCpl     :=  '';
      InfAdic.infAdFisco :=  '';

      with InfAdic.obsCont.Add do
       begin
         xCampo := 'ObsCont';
         xTexto := 'Texto';
       end;

      with InfAdic.obsFisco.Add do
       begin
         xCampo := 'ObsFisco';
         xTexto := 'Texto';
       end;
//Processo referenciado
{     with InfAdic.procRef.Add do
       begin
         nProc := '';
         indProc := ipSEFAZ;
       end;                 }

      exporta.UFembarq   := '';;
      exporta.xLocEmbarq := '';

      compra.xNEmp := '';
      compra.xPed  := '';
      compra.xCont := '';
   end;

end;



procedure TForm1.GravarConfiguracao;
Var IniFile : String ;
    Ini     : TIniFile ;
    StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
      Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text) ;
      Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text) ;
      Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text) ;

      Ini.WriteInteger( 'Geral','DANFE'       ,rgTipoDanfe.ItemIndex) ;
      Ini.WriteInteger( 'Geral','FormaEmissao',rgFormaEmissao.ItemIndex) ;
      Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text) ;
      Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked) ;
      Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text) ;

      Ini.WriteString( 'WebService','UF'        ,cbUF.Text) ;
      Ini.WriteInteger( 'WebService','Ambiente'  ,rgTipoAmb.ItemIndex) ;
      Ini.WriteBool(   'WebService','Visualizar',ckVisualizar.Checked) ;

      Ini.WriteString( 'Proxy','Host'   ,edtProxyHost.Text) ;
      Ini.WriteString( 'Proxy','Porta'  ,edtProxyPorta.Text) ;
      Ini.WriteString( 'Proxy','User'   ,edtProxyUser.Text) ;
      Ini.WriteString( 'Proxy','Pass'   ,edtProxySenha.Text) ;

      Ini.WriteString( 'Emitente','CNPJ'       ,edtEmitCNPJ.Text) ;
      Ini.WriteString( 'Emitente','IE'         ,edtEmitIE.Text) ;
      Ini.WriteString( 'Emitente','RazaoSocial',edtEmitRazao.Text) ;
      Ini.WriteString( 'Emitente','Fantasia'   ,edtEmitFantasia.Text) ;
      Ini.WriteString( 'Emitente','Fone'       ,edtEmitFone.Text) ;
      Ini.WriteString( 'Emitente','CEP'        ,edtEmitCEP.Text) ;
      Ini.WriteString( 'Emitente','Logradouro' ,edtEmitLogradouro.Text) ;
      Ini.WriteString( 'Emitente','Numero'     ,edtEmitNumero.Text) ;
      Ini.WriteString( 'Emitente','Complemento',edtEmitComp.Text) ;
      Ini.WriteString( 'Emitente','Bairro'     ,edtEmitBairro.Text) ;
      Ini.WriteString( 'Emitente','CodCidade'  ,edtEmitCodCidade.Text) ;
      Ini.WriteString( 'Emitente','Cidade'     ,edtEmitCidade.Text) ;
      Ini.WriteString( 'Emitente','UF'         ,edtEmitUF.Text) ;

      Ini.WriteString( 'Email','Host'    ,edtSmtpHost.Text) ;
      Ini.WriteString( 'Email','Port'    ,edtSmtpPort.Text) ;
      Ini.WriteString( 'Email','User'    ,edtSmtpUser.Text) ;
      Ini.WriteString( 'Email','Pass'    ,edtSmtpPass.Text) ;
      Ini.WriteString( 'Email','Assunto' ,edtEmailAssunto.Text) ;
      Ini.WriteBool(   'Email','SSL'     ,cbEmailSSL.Checked ) ;
      StreamMemo := TMemoryStream.Create;
      mmEmailMsg.Lines.SaveToStream(StreamMemo);
      StreamMemo.Seek(0,soFromBeginning);
      Ini.WriteBinaryStream( 'Email','Mensagem',StreamMemo) ;
      StreamMemo.Free;
  finally
     Ini.Free ;
  end;

end;

procedure TForm1.LerConfiguracao;
Var IniFile  : String ;
    Ini     : TIniFile ;
    Ok : Boolean;
    StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
     {$IFDEF ACBrNFeOpenSSL}
        edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
        edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
        ACBrNFe1.Configuracoes.Certificados.Certificado  := edtCaminho.Text;
        ACBrNFe1.Configuracoes.Certificados.Senha        := edtSenha.Text;
        edtNumSerie.Visible := False;
        Label25.Visible := False;
        sbtnGetCert.Visible := False;
     {$ELSE}
        edtNumSerie.Text := Ini.ReadString( 'Certificado','NumSerie','') ;
        ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
        edtNumSerie.Text := ACBrNFe1.Configuracoes.Certificados.NumeroSerie;
        Label1.Caption := 'Informe o número de série do certificado'#13+
                          'Disponível no Internet Explorer no menu'#13+
                          'Ferramentas - Opções da Internet - Conteúdo '#13+
                          'Certificados - Exibir - Detalhes - '#13+
                          'Número do certificado';
        Label2.Visible := False;
        edtCaminho.Visible := False;
        edtSenha.Visible   := False;
        sbtnCaminhoCert.Visible := False;
     {$ENDIF}

      rgFormaEmissao.ItemIndex := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
      ckSalvar.Checked    := Ini.ReadBool(   'Geral','Salvar'      ,True) ;
      edtPathLogs.Text    := Ini.ReadString( 'Geral','PathSalvar'  ,'') ;
      ACBrNFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK,IntToStr(rgFormaEmissao.ItemIndex+1));
      ACBrNFe1.Configuracoes.Geral.Salvar       := ckSalvar.Checked;
      ACBrNFe1.Configuracoes.Geral.PathSalvar   := edtPathLogs.Text;

      cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString( 'WebService','UF','SP')) ;
      rgTipoAmb.ItemIndex  := Ini.ReadInteger( 'WebService','Ambiente'  ,0) ;
      ckVisualizar.Checked :=Ini.ReadBool(    'WebService','Visualizar',False) ;
      ACBrNFe1.Configuracoes.WebServices.UF         := cbUF.Text;
      ACBrNFe1.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(rgTipoAmb.ItemIndex+1));
      ACBrNFe1.Configuracoes.WebServices.Visualizar := ckVisualizar.Checked;

      edtProxyHost.Text  := Ini.ReadString( 'Proxy','Host'   ,'') ;
      edtProxyPorta.Text := Ini.ReadString( 'Proxy','Porta'  ,'') ;
      edtProxyUser.Text  := Ini.ReadString( 'Proxy','User'   ,'') ;
      edtProxySenha.Text := Ini.ReadString( 'Proxy','Pass'   ,'') ;
      ACBrNFe1.Configuracoes.WebServices.ProxyHost := edtProxyHost.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPort := edtProxyPorta.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyUser := edtProxyUser.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPass := edtProxySenha.Text;

      rgTipoDanfe.ItemIndex     := Ini.ReadInteger( 'Geral','DANFE'       ,0) ;
      edtLogoMarca.Text         := Ini.ReadString( 'Geral','LogoMarca'   ,'') ;
      if ACBrNFe1.DANFE <> nil then
       begin
         ACBrNFe1.DANFE.TipoDANFE  := StrToTpImp(OK,IntToStr(rgTipoDanfe.ItemIndex+1));
         ACBrNFe1.DANFE.Logo       := edtLogoMarca.Text;
       end;

      edtEmitCNPJ.Text       := Ini.ReadString( 'Emitente','CNPJ'       ,'') ;
      edtEmitIE.Text         := Ini.ReadString( 'Emitente','IE'         ,'') ;
      edtEmitRazao.Text      := Ini.ReadString( 'Emitente','RazaoSocial','') ;
      edtEmitFantasia.Text   := Ini.ReadString( 'Emitente','Fantasia'   ,'') ;
      edtEmitFone.Text       := Ini.ReadString( 'Emitente','Fone'       ,'') ;
      edtEmitCEP.Text        := Ini.ReadString( 'Emitente','CEP'        ,'') ;
      edtEmitLogradouro.Text := Ini.ReadString( 'Emitente','Logradouro' ,'') ;
      edtEmitNumero.Text     := Ini.ReadString( 'Emitente','Numero'     ,'') ;
      edtEmitComp.Text       := Ini.ReadString( 'Emitente','Complemento','') ;
      edtEmitBairro.Text     := Ini.ReadString( 'Emitente','Bairro'     ,'') ;
      edtEmitCodCidade.Text  := Ini.ReadString( 'Emitente','CodCidade'  ,'') ;
      edtEmitCidade.Text     :=Ini.ReadString( 'Emitente','Cidade'     ,'') ;
      edtEmitUF.Text         := Ini.ReadString( 'Emitente','UF'         ,'') ;

      edtSmtpHost.Text      := Ini.ReadString( 'Email','Host'   ,'') ;
      edtSmtpPort.Text      := Ini.ReadString( 'Email','Port'   ,'') ;
      edtSmtpUser.Text      := Ini.ReadString( 'Email','User'   ,'') ;
      edtSmtpPass.Text      := Ini.ReadString( 'Email','Pass'   ,'') ;
      edtEmailAssunto.Text  := Ini.ReadString( 'Email','Assunto','') ;
      cbEmailSSL.Checked    := Ini.ReadBool(   'Email','SSL'    ,False) ;
      StreamMemo := TMemoryStream.Create;
      Ini.ReadBinaryStream( 'Email','Mensagem',StreamMemo) ;
      mmEmailMsg.Lines.LoadFromStream(StreamMemo);
      StreamMemo.Free;
  finally
     Ini.Free ;
  end;

end;

procedure TForm1.LoadXML(MyMemo: TMemo; MyWebBrowser: TSynEdit);
var
  vText: String;
begin
  vText := MyMemo.Text;

  // formata resposta
  vText := StringReplace(vText, '>', '>' + LineEnding + '    ', [rfReplaceAll]);
  vText := StringReplace(vText, '<', LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '>' + LineEnding + '    ' + LineEnding +
             '  <', '>' + LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '  </ret', '</ret', []);

  // exibe resposta
  MyWebBrowser.Text := Trim(vText);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   ACBrNFe1.Configuracoes.WebServices.Visualizar := True;
   LerConfiguracao;
end;

procedure TForm1.lblColaboradorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TForm1.lblColaboradorMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold,fsUnderline];
end;

procedure TForm1.lblColaboradorMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TForm1.lblDoar1Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TForm1.lblPatrocinadorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/35');
end;

procedure TForm1.sbtnCaminhoCertClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);
  if OpenDialog1.Execute then
  begin
    edtCaminho.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.sbtnGetCertClick(Sender: TObject);
begin
 {$IFNDEF ACBrNFeOpenSSL}
 try
 edtNumSerie.Text := ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
 except
   on e: Exception do
      MessageDlg('Erro', e.Message, mtError, [mbOK], '');
 end;
 {$ENDIF}
end;

procedure TForm1.sbtnLogoMarcaClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione o Logo';
 OpenDialog1.DefaultExt := '*.bmp';
 OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);
 if OpenDialog1.Execute then
 begin
   edtLogoMarca.Text := OpenDialog1.FileName;
 end;

end;

procedure TForm1.sbtnPathSalvarClick(Sender: TObject);
var
  Dir: string;
begin
 if Length(edtPathLogs.Text) <= 0 then
    Dir := ExtractFileDir(application.ExeName)
 else
    Dir := edtPathLogs.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
   edtPathLogs.Text := Dir;

end;

procedure TForm1.btnSalvarConfigClick(Sender: TObject);
begin
 GravarConfiguracao;
 LerConfiguracao;
end;

procedure TForm1.btnCriarEnviarClick(Sender: TObject);
var
 vAux, vNumLote : String;
begin
 if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
   exit;

 if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote)) then
   exit;

 vNumLote := OnlyNumber(vNumLote);

 if Trim(vNumLote) = '' then
  begin
    MessageDlg('Número do Lote inválido.',mtError,[mbok],0);
    exit;
  end;

 ACBrNFe1.NotasFiscais.Clear;

 GerarNFe(vAux);

 ACBrNFe1.Enviar(vNumLote,True);

 MemoResp.Lines.Text := ACBrNFe1.WebServices.Retorno.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.Retorno.RetornoWS;
 LoadXML(MemoResp, SynReposta);

 MemoDados.Lines.Add('');
 MemoDados.Lines.Add('Envio NFe');
 MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
 MemoDados.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
 MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
 MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
 MemoDados.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
 MemoDados.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
 MemoDados.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
 MemoDados.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
 MemoDados.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);
 // MemoDados.Lines.Add('cStat: '+ ACBrNFe1.WebServices.Retorno.NFeRetorno;

 ACBrNFe1.NotasFiscais.Clear;
end;

procedure TForm1.btnEnvDPECClick(Sender: TObject);
var
 vAux : String;
begin
 if not(InputQuery('WebServices DPEC', 'Numero da Nota', vAux)) then
     exit;

   ACBrNFe1.NotasFiscais.Clear;

   GerarNFe(vAux);

   ACBrNFe1.NotasFiscais.SaveToFile();
   if ACBrNFe1.WebServices.EnviarDPEC.Executar then
    begin
      //protocolo de envio ao DPEC e impressão do DANFE
      ACBrNFe1.DANFE.ProtocoloNFe:=ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC+' '+
                                   DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC);
      ACBrNFe1.NotasFiscais.Imprimir;

      ShowMessage(DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC));
      ShowMessage(ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC);
    end;

   MemoResp.Lines.Text := ACBrNFe1.WebServices.EnviarDPEC.RetWS;
   memoRespWS.Lines.Text := ACBrNFe1.WebServices.EnviarDPEC.RetornoWS;
   LoadXML(MemoResp, SynReposta);

   ACBrNFe1.NotasFiscais.Clear;
end;

procedure TForm1.btnEnviarEmailClick(Sender: TObject);
var
 Para : String;
 CC: Tstrings;
begin
   if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
     exit;

   OpenDialog1.Title := 'Selecione a NFE';
   OpenDialog1.DefaultExt := '*-nfe.XML';
   OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
   OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
   if OpenDialog1.Execute then
   begin
     ACBrNFe1.NotasFiscais.Clear;
     ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
     CC:=TstringList.Create;
     CC.Add('andrefmoraes@gmail.com'); //especifique um email válido
     CC.Add('anfm@zipmail.com.br');    //especifique um email válido
     ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(edtSmtpHost.Text
                                              , edtSmtpPort.Text
                                              , edtSmtpUser.Text
                                              , edtSmtpPass.Text
                                              , edtSmtpUser.Text
                                              , Para
                                              , edtEmailAssunto.Text
                                              , mmEmailMsg.Lines
                                              , cbEmailSSL.Checked // SSL - Conexão Segura
                                              , True //Enviar PDF junto
                                              , CC //Lista com emails que serão enviado cópias - TStrings
                                              , nil // Lista de anexos - TStrings
                                              , False  //Pede confirmação de leitura do email
                                              , False  //Aguarda Envio do Email(não usa thread)
                                              , 'ACBrNFe2' // Nome do Rementente
                                              , cbEmailSSL.Checked ); // Auto TLS
     CC.Free;
   end;
end;

procedure TForm1.btnGerarNFEClick(Sender: TObject);
var
 vAux : String;
begin
 if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
     exit;

   ACBrNFe1.NotasFiscais.Clear;

   GerarNFe(vAux);

   ACBrNFe1.NotasFiscais.Assinar;

   ACBrNFe1.NotasFiscais.Items[0].SaveToFile;
   ShowMessage('Arquivo gerado em: '+ACBrNFe1.NotasFiscais.Items[0].NomeArq);
   MemoDados.Lines.Add('Arquivo gerado em: '+ACBrNFe1.NotasFiscais.Items[0].NomeArq);
   MemoResp.Lines.LoadFromFile(ACBrNFe1.NotasFiscais.Items[0].NomeArq);
   LoadXML(MemoResp, SynReposta);
   PageControl2.ActivePageIndex := 1;

end;

procedure TForm1.btnGerarPDFClick(Sender: TObject);
begin
    OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  ACBrNFe1.NotasFiscais.Clear;
  if OpenDialog1.Execute then
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

  ACBrNFe1.NotasFiscais.ImprimirPDF;
end;

procedure TForm1.btnGerarTXTClick(Sender: TObject);
var
   vAux, vNumLote : String;
begin
  if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote)) then
    exit;

  vNumLote := OnlyNumber(vNumLote);

  if Trim(vNumLote) = '' then
   begin
     MessageDlg('Número do Lote inválido.',mtError,[mbok],0);
     exit;
   end;

  ACBrNFe1.NotasFiscais.Clear;

  GerarNFe(vAux);

  ACBrNFe1.NotasFiscais.SaveToTXT({caminho e nome do arquivo TXT});
end;

procedure TForm1.btnImportarXMLClick(Sender: TObject);
var
  i, j, k, n  : integer;
  Nota, Node, NodePai, NodeItem: TTreeNode;
  NFeRTXT: TNFeRTXT;
begin
 OpenDialog1.FileName  :=  '';
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Arquivos TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   //tenta TXT
   ACBrNFe1.NotasFiscais.Add;
   NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
   NFeRTXT.CarregarArquivo(OpenDialog1.FileName);
   if NFeRTXT.LerTxt then
      NFeRTXT.Free
   else
   begin
      NFeRTXT.Free;
      //tenta XML
      ACBrNFe1.NotasFiscais.Clear;
      try
         ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
      except
         ShowMessage('Arquivo NFe Inválido');
         exit;
      end;
   end;

   trvwNFe.Items.Clear;

   for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
   begin
   with ACBrNFe1.NotasFiscais.Items[n].NFe do
    begin

      Nota := trvwNFe.Items.Add(nil,infNFe.ID);
      trvwNFe.Items.AddChild(Nota,'ID= ' +infNFe.ID);
      Node := trvwNFe.Items.AddChild(Nota,'procNFe');
      trvwNFe.Items.AddChild(Node,'tpAmb= '     +TpAmbToStr(procNFe.tpAmb));
      trvwNFe.Items.AddChild(Node,'verAplic= '  +procNFe.verAplic);
      trvwNFe.Items.AddChild(Node,'chNFe= '     +procNFe.chNFe);
      trvwNFe.Items.AddChild(Node,'dhRecbto= '  +DateTimeToStr(procNFe.dhRecbto));
      trvwNFe.Items.AddChild(Node,'nProt= '     +procNFe.nProt);
      trvwNFe.Items.AddChild(Node,'digVal= '    +procNFe.digVal);
      trvwNFe.Items.AddChild(Node,'cStat= '     +IntToStr(procNFe.cStat));
      trvwNFe.Items.AddChild(Node,'xMotivo= '   +procNFe.xMotivo);

      Node := trvwNFe.Items.AddChild(Nota,'Ide');
      trvwNFe.Items.AddChild(Node,'cNF= '     +IntToStr(Ide.cNF));
      trvwNFe.Items.AddChild(Node,'natOp= '   +Ide.natOp );
      trvwNFe.Items.AddChild(Node,'indPag= '  +IndpagToStr(Ide.indPag));
      trvwNFe.Items.AddChild(Node,'modelo= '  +IntToStr(Ide.modelo));
      trvwNFe.Items.AddChild(Node,'serie= '   +IntToStr(Ide.serie));
      trvwNFe.Items.AddChild(Node,'nNF= '     +IntToStr(Ide.nNF));
      trvwNFe.Items.AddChild(Node,'dEmi= '    +DateToStr(Ide.dEmi));
      trvwNFe.Items.AddChild(Node,'dSaiEnt= ' +DateToStr(Ide.dSaiEnt));
      trvwNFe.Items.AddChild(Node,'hSaiEnt= ' +DateToStr(Ide.hSaiEnt));
      trvwNFe.Items.AddChild(Node,'tpNF= '    +tpNFToStr(Ide.tpNF));
      trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
      trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
      trvwNFe.Items.AddChild(Node,'cUF= '     +IntToStr(Ide.cUF));
      trvwNFe.Items.AddChild(Node,'cMunFG= '  +IntToStr(Ide.cMunFG));
      trvwNFe.Items.AddChild(Node,'tpImp= '   +TpImpToStr(Ide.tpImp));
      trvwNFe.Items.AddChild(Node,'tpEmis= '  +TpEmisToStr(Ide.tpEmis));
      trvwNFe.Items.AddChild(Node,'cDV= '     +IntToStr(Ide.cDV));
      trvwNFe.Items.AddChild(Node,'tpAmb= '   +TpAmbToStr(Ide.tpAmb));
      trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
      trvwNFe.Items.AddChild(Node,'procEmi= ' +procEmiToStr(Ide.procEmi));
      trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
      trvwNFe.Items.AddChild(Node,'dhCont= '  +DateTimeToStr(Ide.dhCont));
      trvwNFe.Items.AddChild(Node,'xJust= '   +Ide.xJust);

      for i:=0 to Ide.NFref.Count-1 do
       begin
         if Ide.NFref.Items[i].refNFe <> '' then
         begin
           Node := trvwNFe.Items.AddChild(Node,'NFRef'+IntToStrZero(i+1,3));
           trvwNFe.Items.AddChild(Node,'refNFe= ' +Ide.NFref.Items[i].refNFe);
           trvwNFe.Items.AddChild(Node,'cUF= '    +IntToStr(Ide.NFref.Items[i].RefNF.cUF));
           trvwNFe.Items.AddChild(Node,'AAMM= '   +Ide.NFref.Items[i].RefNF.AAMM);
           trvwNFe.Items.AddChild(Node,'CNPJ= '   +Ide.NFref.Items[i].RefNF.CNPJ);
           trvwNFe.Items.AddChild(Node,'modelo= ' +IntToStr(Ide.NFref.Items[i].RefNF.modelo));
           trvwNFe.Items.AddChild(Node,'serie= '  +IntToStr(Ide.NFref.Items[i].RefNF.serie));
           trvwNFe.Items.AddChild(Node,'nNF= '    +IntToStr(Ide.NFref.Items[i].RefNF.nNF));
         end;

         if Ide.NFref.Items[i].RefECF.nCOO <> '' then
         begin
           Node := trvwNFe.Items.AddChild(Node,'refECF'+IntToStrZero(i+1,3));
           trvwNFe.Items.AddChild(Node,'mod= '  +ECFModRefToStr(Ide.NFref.Items[i].RefECF.modelo));
           trvwNFe.Items.AddChild(Node,'nECF= ' +Ide.NFref.Items[i].RefECF.nECF);
           trvwNFe.Items.AddChild(Node,'nCOO= ' +Ide.NFref.Items[i].RefECF.nCOO);
         end;
       end;

      Node := trvwNFe.Items.AddChild(Nota,'Emit');
      trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Emit.CNPJCPF);
      trvwNFe.Items.AddChild(Node,'IE='       +Emit.IE);
      trvwNFe.Items.AddChild(Node,'xNome='    +Emit.xNome);
      trvwNFe.Items.AddChild(Node,'xFant='    +Emit.xFant );
      trvwNFe.Items.AddChild(Node,'IEST='     +Emit.IEST);
      trvwNFe.Items.AddChild(Node,'IM='       +Emit.IM);
      trvwNFe.Items.AddChild(Node,'CNAE='     +Emit.CNAE);
      trvwNFe.Items.AddChild(Node,'CRT='      +CRTToStr(Emit.CRT));

      Node := trvwNFe.Items.AddChild(Node,'EnderEmit');
      trvwNFe.Items.AddChild(Node,'Fone='    +Emit.EnderEmit.fone);
      trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Emit.EnderEmit.CEP));
      trvwNFe.Items.AddChild(Node,'xLgr='    +Emit.EnderEmit.xLgr);
      trvwNFe.Items.AddChild(Node,'nro='     +Emit.EnderEmit.nro);
      trvwNFe.Items.AddChild(Node,'xCpl='    +Emit.EnderEmit.xCpl);
      trvwNFe.Items.AddChild(Node,'xBairro=' +Emit.EnderEmit.xBairro);
      trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Emit.EnderEmit.cMun));
      trvwNFe.Items.AddChild(Node,'xMun='    +Emit.EnderEmit.xMun);
      trvwNFe.Items.AddChild(Node,'UF'       +Emit.EnderEmit.UF);
      trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Emit.EnderEmit.cPais));
      trvwNFe.Items.AddChild(Node,'xPais='   +Emit.EnderEmit.xPais);

      if Avulsa.CNPJ  <> '' then
       begin
         Node := trvwNFe.Items.AddChild(Nota,'Avulsa');
         trvwNFe.Items.AddChild(Node,'CNPJ='    +Avulsa.CNPJ);
         trvwNFe.Items.AddChild(Node,'xOrgao='  +Avulsa.xOrgao);
         trvwNFe.Items.AddChild(Node,'matr='    +Avulsa.matr );
         trvwNFe.Items.AddChild(Node,'xAgente=' +Avulsa.xAgente);
         trvwNFe.Items.AddChild(Node,'fone='    +Avulsa.fone);
         trvwNFe.Items.AddChild(Node,'UF='      +Avulsa.UF);
         trvwNFe.Items.AddChild(Node,'nDAR='    +Avulsa.nDAR);
         trvwNFe.Items.AddChild(Node,'dEmi='    +DateToStr(Avulsa.dEmi));
         trvwNFe.Items.AddChild(Node,'vDAR='    +FloatToStr(Avulsa.vDAR));
         trvwNFe.Items.AddChild(Node,'repEmi='  +Avulsa.repEmi);
         trvwNFe.Items.AddChild(Node,'dPag='    +DateToStr(Avulsa.dPag));
       end;
      Node := trvwNFe.Items.AddChild(Nota,'Dest');
      trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Dest.CNPJCPF);
      trvwNFe.Items.AddChild(Node,'IE='       +Dest.IE);
      trvwNFe.Items.AddChild(Node,'ISUF='     +Dest.ISUF);
      trvwNFe.Items.AddChild(Node,'xNome='    +Dest.xNome);
      trvwNFe.Items.AddChild(Node,'email='    +Dest.Email);

      Node := trvwNFe.Items.AddChild(Node,'EnderDest');
      trvwNFe.Items.AddChild(Node,'Fone='    +Dest.EnderDest.Fone);
      trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Dest.EnderDest.CEP));
      trvwNFe.Items.AddChild(Node,'xLgr='    +Dest.EnderDest.xLgr);
      trvwNFe.Items.AddChild(Node,'nro='     +Dest.EnderDest.nro);
      trvwNFe.Items.AddChild(Node,'xCpl='    +Dest.EnderDest.xCpl);
      trvwNFe.Items.AddChild(Node,'xBairro=' +Dest.EnderDest.xBairro);
      trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Dest.EnderDest.cMun));
      trvwNFe.Items.AddChild(Node,'xMun='    +Dest.EnderDest.xMun);
      trvwNFe.Items.AddChild(Node,'UF='      +Dest.EnderDest.UF );
      trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Dest.EnderDest.cPais));
      trvwNFe.Items.AddChild(Node,'xPais='   +Dest.EnderDest.xPais);

      {if Retirada.CNPJ <> '' then
       begin
         Node := trvwNFe.Items.AddChild(Nota,'Retirada');
         trvwNFe.Items.AddChild(Node,'CNPJ='    +Retirada.CNPJ);
         trvwNFe.Items.AddChild(Node,'xLgr='    +Retirada.xLgr);
         trvwNFe.Items.AddChild(Node,'nro='     +Retirada.nro);
         trvwNFe.Items.AddChild(Node,'xCpl='    +Retirada.xCpl);
         trvwNFe.Items.AddChild(Node,'xBairro=' +Retirada.xBairro);
         trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Retirada.cMun));
         trvwNFe.Items.AddChild(Node,'xMun='    +Retirada.xMun);
         trvwNFe.Items.AddChild(Node,'UF='      +Retirada.UF);
       end;

      if Entrega.CNPJ <> '' then
       begin
         Node := trvwNFe.Items.AddChild(Nota,'Entrega');
         trvwNFe.Items.AddChild(Node,'CNPJ='    +Entrega.CNPJ);
         trvwNFe.Items.AddChild(Node,'xLgr='    +Entrega.xLgr);
         trvwNFe.Items.AddChild(Node,'nro='     +Entrega.nro);
         trvwNFe.Items.AddChild(Node,'xCpl='    +Entrega.xCpl);
         trvwNFe.Items.AddChild(Node,'xBairro=' +Entrega.xBairro);
         trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Entrega.cMun));
         trvwNFe.Items.AddChild(Node,'xMun='    +Entrega.xMun);
         trvwNFe.Items.AddChild(Node,'UF='      +Entrega.UF);
       end;}

      for I := 0 to Det.Count-1 do
       begin
         with Det.Items[I] do
          begin
              NodeItem := trvwNFe.Items.AddChild(Nota,'Produto'+IntToStrZero(I+1,3));
              trvwNFe.Items.AddChild(NodeItem,'nItem='  +IntToStr(Prod.nItem) );
              trvwNFe.Items.AddChild(NodeItem,'cProd='  +Prod.cProd );
              trvwNFe.Items.AddChild(NodeItem,'cEAN='   +Prod.cEAN);
              trvwNFe.Items.AddChild(NodeItem,'xProd='  +Prod.xProd);
              trvwNFe.Items.AddChild(NodeItem,'NCM='    +Prod.NCM);
              trvwNFe.Items.AddChild(NodeItem,'EXTIPI=' +Prod.EXTIPI);
              //trvwNFe.Items.AddChild(NodeItem,'genero=' +IntToStr(Prod.genero));
              trvwNFe.Items.AddChild(NodeItem,'CFOP='   +Prod.CFOP);
              trvwNFe.Items.AddChild(NodeItem,'uCom='   +Prod.uCom);
              trvwNFe.Items.AddChild(NodeItem,'qCom='   +FloatToStr(Prod.qCom)) ;
              trvwNFe.Items.AddChild(NodeItem,'vUnCom=' +FloatToStr(Prod.vUnCom)) ;
              trvwNFe.Items.AddChild(NodeItem,'vProd='  +FloatToStr(Prod.vProd)) ;

              trvwNFe.Items.AddChild(NodeItem,'cEANTrib=' +Prod.cEANTrib);
              trvwNFe.Items.AddChild(NodeItem,'uTrib='    +Prod.uTrib);
              trvwNFe.Items.AddChild(NodeItem,'qTrib='    +FloatToStr(Prod.qTrib));
              trvwNFe.Items.AddChild(NodeItem,'vUnTrib='  +FloatToStr(Prod.vUnTrib)) ;

              trvwNFe.Items.AddChild(NodeItem,'vFrete='      +FloatToStr(Prod.vFrete)) ;
              trvwNFe.Items.AddChild(NodeItem,'vSeg='        +FloatToStr(Prod.vSeg)) ;
              trvwNFe.Items.AddChild(NodeItem,'vDesc='       +FloatToStr(Prod.vDesc)) ;
              trvwNFe.Items.AddChild(NodeItem,'vOutro='      +FloatToStr(Prod.vOutro)) ;
              trvwNFe.Items.AddChild(NodeItem,'indTot='      +indTotToStr(Prod.IndTot)) ;
              trvwNFe.Items.AddChild(NodeItem,'xPed='        +Prod.xPed) ;
              trvwNFe.Items.AddChild(NodeItem,'nItemPedido=' +IntToStr(Prod.nItemPed)) ;

              trvwNFe.Items.AddChild(NodeItem,'infAdProd=' +infAdProd);

              for J:=0 to Prod.DI.Count-1 do
               begin
                 if Prod.DI.Items[j].nDi <> '' then
                  begin
                    with Prod.DI.Items[j] do
                     begin
                       NodePai := trvwNFe.Items.AddChild(NodeItem,'DI'+IntToStrZero(J+1,3));
                       trvwNFe.Items.AddChild(NodePai,'nDi='         +nDi);
                       trvwNFe.Items.AddChild(NodePai,'dDi='         +DateToStr(dDi));
                       trvwNFe.Items.AddChild(NodePai,'xLocDesemb='  +xLocDesemb);
                       trvwNFe.Items.AddChild(NodePai,'UFDesemb='    +UFDesemb);
                       trvwNFe.Items.AddChild(NodePai,'dDesemb='     +DateToStr(dDesemb));
                       trvwNFe.Items.AddChild(NodePai,'cExportador=' +cExportador);;

                       for K:=0 to adi.Count-1 do
                        begin
                          with adi.Items[K] do
                           begin
                             Node := trvwNFe.Items.AddChild(NodePai,'LADI'+IntToStrZero(K+1,3));
                             trvwNFe.Items.AddChild(Node,'nAdicao='     +IntToStr(nAdicao)) ;
                             trvwNFe.Items.AddChild(Node,'nSeqAdi='     +IntToStr(nSeqAdi)) ;
                             trvwNFe.Items.AddChild(Node,'cFabricante=' +cFabricante);
                             trvwNFe.Items.AddChild(Node,'vDescDI='     +FloatToStr(vDescDI));
                           end;
                        end;
                     end;
                  end
                 else
                   Break;
               end;

             if Prod.veicProd.chassi <> '' then
              begin
                Node := trvwNFe.Items.AddChild(NodeItem,'Veiculo');
                with Prod.veicProd do
                 begin
                   trvwNFe.Items.AddChild(Node,'tpOP='     +tpOPToStr(tpOP));
                   trvwNFe.Items.AddChild(Node,'chassi='   +chassi) ;
                   trvwNFe.Items.AddChild(Node,'cCor='     +cCor);
                   trvwNFe.Items.AddChild(Node,'xCor='     +xCor);
                   trvwNFe.Items.AddChild(Node,'pot='      +pot);
                   trvwNFe.Items.AddChild(Node,'Cilin='      +Cilin);
                   trvwNFe.Items.AddChild(Node,'pesoL='    +pesoL);
                   trvwNFe.Items.AddChild(Node,'pesoB='    +pesoB);
                   trvwNFe.Items.AddChild(Node,'nSerie='   +nSerie);
                   trvwNFe.Items.AddChild(Node,'tpComb='   +tpComb);
                   trvwNFe.Items.AddChild(Node,'nMotor='   +nMotor);
                   trvwNFe.Items.AddChild(Node,'CMT='     +CMT);
                   trvwNFe.Items.AddChild(Node,'dist='     +dist);
                   //trvwNFe.Items.AddChild(Node,'RENAVAM='  +RENAVAM);
                   trvwNFe.Items.AddChild(Node,'anoMod='   +IntToStr(anoMod));
                   trvwNFe.Items.AddChild(Node,'anoFab='   +IntToStr(anoFab));
                   trvwNFe.Items.AddChild(Node,'tpPint='   +tpPint);
                   trvwNFe.Items.AddChild(Node,'tpVeic='   +IntToStr(tpVeic));
                   trvwNFe.Items.AddChild(Node,'espVeic='  +IntToStr(espVeic));
                   trvwNFe.Items.AddChild(Node,'VIN='      +VIN);
                   trvwNFe.Items.AddChild(Node,'condVeic=' +condVeicToStr(condVeic));
                   trvwNFe.Items.AddChild(Node,'cMod='     +cMod);
                 end;
              end;

              for J:=0 to Prod.med.Count-1 do
               begin
                 Node := trvwNFe.Items.AddChild(NodeItem,'Medicamento'+IntToStrZero(J+1,3) );
                 with Prod.med.Items[J] do
                  begin
                    trvwNFe.Items.AddChild(Node,'nLote=' +nLote) ;
                    trvwNFe.Items.AddChild(Node,'qLote=' +FloatToStr(qLote)) ;
                    trvwNFe.Items.AddChild(Node,'dFab='  +DateToStr(dFab)) ;
                    trvwNFe.Items.AddChild(Node,'dVal='  +DateToStr(dVal)) ;
                    trvwNFe.Items.AddChild(Node,'vPMC='  +FloatToStr(vPMC)) ;
                   end;
               end;

              for J:=0 to Prod.arma.Count-1 do
               begin
                 Node := trvwNFe.Items.AddChild(NodeItem,'Arma'+IntToStrZero(J+1,3));
                 with Prod.arma.Items[J] do
                  begin
                    trvwNFe.Items.AddChild(Node,'nSerie=' +nSerie) ;
                    trvwNFe.Items.AddChild(Node,'tpArma=' +tpArmaToStr(tpArma)) ;
                    trvwNFe.Items.AddChild(Node,'nCano='  +nCano) ;
                    trvwNFe.Items.AddChild(Node,'descr='  +descr) ;
                   end;
               end;

              if (Prod.comb.cProdANP > 0) then
               begin
                NodePai := trvwNFe.Items.AddChild(NodeItem,'Combustivel');
                with Prod.comb do
                 begin
                   trvwNFe.Items.AddChild(NodePai,'cProdANP=' +IntToStr(cProdANP)) ;
                   trvwNFe.Items.AddChild(NodePai,'CODIF='    +CODIF) ;
                   trvwNFe.Items.AddChild(NodePai,'qTemp='    +FloatToStr(qTemp)) ;
                   trvwNFe.Items.AddChild(NodePai,'UFcons='    +UFcons) ;

                   Node := trvwNFe.Items.AddChild(NodePai,'CIDE'+IntToStrZero(I+1,3));
                   trvwNFe.Items.AddChild(Node,'qBCprod='   +FloatToStr(CIDE.qBCprod)) ;
                   trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(CIDE.vAliqProd)) ;
                   trvwNFe.Items.AddChild(Node,'vCIDE='     +FloatToStr(CIDE.vCIDE)) ;

                   Node := trvwNFe.Items.AddChild(NodePai,'ICMSComb'+IntToStrZero(I+1,3));
                   trvwNFe.Items.AddChild(Node,'vBCICMS='   +FloatToStr(ICMS.vBCICMS)) ;
                   trvwNFe.Items.AddChild(Node,'vICMS='     +FloatToStr(ICMS.vICMS)) ;
                   trvwNFe.Items.AddChild(Node,'vBCICMSST=' +FloatToStr(ICMS.vBCICMSST)) ;
                   trvwNFe.Items.AddChild(Node,'vICMSST='   +FloatToStr(ICMS.vICMSST)) ;

                   if (ICMSInter.vBCICMSSTDest>0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'ICMSInter'+IntToStrZero(I+1,3));
                      trvwNFe.Items.AddChild(Node,'vBCICMSSTDest=' +FloatToStr(ICMSInter.vBCICMSSTDest)) ;
                      trvwNFe.Items.AddChild(Node,'vICMSSTDest='   +FloatToStr(ICMSInter.vICMSSTDest)) ;
                    end;

                   if (ICMSCons.vBCICMSSTCons>0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'ICMSCons'+IntToStrZero(I+1,3));
                      trvwNFe.Items.AddChild(Node,'vBCICMSSTCons=' +FloatToStr(ICMSCons.vBCICMSSTCons)) ;
                      trvwNFe.Items.AddChild(Node,'vICMSSTCons='   +FloatToStr(ICMSCons.vICMSSTCons)) ;
                      trvwNFe.Items.AddChild(Node,'UFCons='        +ICMSCons.UFcons) ;
                    end;
                 end;
              end;

              with Imposto do
               begin
                  NodePai := trvwNFe.Items.AddChild(NodeItem,'Imposto');

                  if ISSQN.cSitTrib = ISSQNcSitTribVazio then
                  begin
                    Node := trvwNFe.Items.AddChild(NodePai,'ICMS');
                    with ICMS do
                     begin
                       trvwNFe.Items.AddChild(Node,'CST=' +CSTICMSToStr(CST));
                       trvwNFe.Items.AddChild(Node,'CSOSN=' +CSOSNIcmsToStr(CSOSN));
                       trvwNFe.Items.AddChild(Node,'orig='  +OrigToStr(ICMS.orig));
                       trvwNFe.Items.AddChild(Node,'modBC=' +modBCToStr(ICMS.modBC));
                       trvwNFe.Items.AddChild(Node,'pRedBC=' +FloatToStr(ICMS.pRedBC));
                       trvwNFe.Items.AddChild(Node,'vBC='   +FloatToStr(ICMS.vBC));
                       trvwNFe.Items.AddChild(Node,'pICMS=' +FloatToStr(ICMS.pICMS));
                       trvwNFe.Items.AddChild(Node,'vICMS=' +FloatToStr(ICMS.vICMS));
                       trvwNFe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                       trvwNFe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                       trvwNFe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                       trvwNFe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                       trvwNFe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                       trvwNFe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                       trvwNFe.Items.AddChild(Node,'vBCSTRet='   +FloatToStr(ICMS.vBCSTRet));
                       trvwNFe.Items.AddChild(Node,'vICMSSTRet=' +FloatToStr(ICMS.vICMSSTRet));
                       trvwNFe.Items.AddChild(Node,'pCredSN='   +FloatToStr(ICMS.pCredSN));
                       trvwNFe.Items.AddChild(Node,'vCredICMSSN='   +FloatToStr(ICMS.vCredICMSSN));
                     end;
                  end
                  else
                  begin
                    Node := trvwNFe.Items.AddChild(NodePai,'ISSQN');
                    with ISSQN do
                     begin
                       trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                       trvwNFe.Items.AddChild(Node,'vAliq='     +FloatToStr(vAliq));
                       trvwNFe.Items.AddChild(Node,'vISSQN='    +FloatToStr(vISSQN));
                       trvwNFe.Items.AddChild(Node,'cMunFG='    +IntToStr(cMunFG));
                       trvwNFe.Items.AddChild(Node,'cListServ=' +cListServ);
                     end;
                  end;

                  if (IPI.vBC > 0) then
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'IPI');
                     with IPI do
                      begin
                        trvwNFe.Items.AddChild(Node,'CST='       +CSTIPIToStr(CST)) ;
                        trvwNFe.Items.AddChild(Node,'clEnq='    +clEnq);
                        trvwNFe.Items.AddChild(Node,'CNPJProd=' +CNPJProd);
                        trvwNFe.Items.AddChild(Node,'cSelo='    +cSelo);
                        trvwNFe.Items.AddChild(Node,'qSelo='    +IntToStr(qSelo));
                        trvwNFe.Items.AddChild(Node,'cEnq='     +cEnq);

                        trvwNFe.Items.AddChild(Node,'vBC='    +FloatToStr(vBC));
                        trvwNFe.Items.AddChild(Node,'qUnid='  +FloatToStr(qUnid));
                        trvwNFe.Items.AddChild(Node,'vUnid='  +FloatToStr(vUnid));
                        trvwNFe.Items.AddChild(Node,'pIPI='   +FloatToStr(pIPI));
                        trvwNFe.Items.AddChild(Node,'vIPI='   +FloatToStr(vIPI));
                      end;
                   end;

                  if (II.vBc > 0) then
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'II');
                     with II do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBc='      +FloatToStr(vBc));
                        trvwNFe.Items.AddChild(Node,'vDespAdu=' +FloatToStr(vDespAdu));
                        trvwNFe.Items.AddChild(Node,'vII='      +FloatToStr(vII));
                        trvwNFe.Items.AddChild(Node,'vIOF='     +FloatToStr(vIOF));
                      end;
                   end;

                  Node := trvwNFe.Items.AddChild(NodePai,'PIS');
                  with PIS do
                   begin
                     trvwNFe.Items.AddChild(Node,'CST=' +CSTPISToStr(CST));

                     if (CST = pis01) or (CST = pis02) then
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='  +FloatToStr(PIS.vBC));
                        trvwNFe.Items.AddChild(Node,'pPIS=' +FloatToStr(PIS.pPIS));
                        trvwNFe.Items.AddChild(Node,'vPIS=' +FloatToStr(PIS.vPIS));
                      end
                     else if CST = pis03 then
                      begin
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                      end
                     else if CST = pis99 then
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(PIS.vBC));
                        trvwNFe.Items.AddChild(Node,'pPIS='      +FloatToStr(PIS.pPIS));
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                      end;
                   end;

                  if (PISST.vBc>0) then
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'PISST');
                     with PISST do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBc='       +FloatToStr(vBc));
                        trvwNFe.Items.AddChild(Node,'pPis='      +FloatToStr(pPis));
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(vPIS));
                      end;
                     end;

                  Node := trvwNFe.Items.AddChild(NodePai,'COFINS');
                  with COFINS do
                   begin
                     trvwNFe.Items.AddChild(Node,'CST=' +CSTCOFINSToStr(CST));

                     if (CST = cof01) or (CST = cof02)   then
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(COFINS.vBC));
                        trvwNFe.Items.AddChild(Node,'pCOFINS=' +FloatToStr(COFINS.pCOFINS));
                        trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(COFINS.vCOFINS));
                      end
                     else if CST = cof03 then
                      begin
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                      end
                     else if CST = cof99 then
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(COFINS.vBC));
                        trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(COFINS.pCOFINS));
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                      end;
                   end;

                  if (COFINSST.vBC > 0) then
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'COFINSST');
                     with COFINSST do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                        trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(pCOFINS));
                        trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                        trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                        trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(vCOFINS));
                      end;
                   end;
               end;
            end;
         end ;

      NodePai := trvwNFe.Items.AddChild(Nota,'Total');
      Node := trvwNFe.Items.AddChild(NodePai,'ICMSTot');
      trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ICMSTot.vBC));
      trvwNFe.Items.AddChild(Node,'vICMS='   +FloatToStr(Total.ICMSTot.vICMS)) ;
      trvwNFe.Items.AddChild(Node,'vBCST='   +FloatToStr(Total.ICMSTot.vBCST)) ;
      trvwNFe.Items.AddChild(Node,'vST='     +FloatToStr(Total.ICMSTot.vST)) ;
      trvwNFe.Items.AddChild(Node,'vProd='   +FloatToStr(Total.ICMSTot.vProd)) ;
      trvwNFe.Items.AddChild(Node,'vFrete='  +FloatToStr(Total.ICMSTot.vFrete)) ;
      trvwNFe.Items.AddChild(Node,'vSeg='    +FloatToStr(Total.ICMSTot.vSeg)) ;
      trvwNFe.Items.AddChild(Node,'vDesc='   +FloatToStr(Total.ICMSTot.vDesc)) ;
      trvwNFe.Items.AddChild(Node,'vII='     +FloatToStr(Total.ICMSTot.vII)) ;
      trvwNFe.Items.AddChild(Node,'vIPI='    +FloatToStr(Total.ICMSTot.vIPI)) ;
      trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ICMSTot.vPIS)) ;
      trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ICMSTot.vCOFINS)) ;
      trvwNFe.Items.AddChild(Node,'vOutro='  +FloatToStr(Total.ICMSTot.vOutro)) ;
      trvwNFe.Items.AddChild(Node,'vNF='     +FloatToStr(Total.ICMSTot.vNF)) ;

      if Total.ISSQNtot.vServ > 0 then
       begin
         Node := trvwNFe.Items.AddChild(NodePai,'ISSQNtot');
         trvwNFe.Items.AddChild(Node,'vServ='   +FloatToStr(Total.ISSQNtot.vServ)) ;
         trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ISSQNTot.vBC)) ;
         trvwNFe.Items.AddChild(Node,'vISS='    +FloatToStr(Total.ISSQNTot.vISS)) ;
         trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ISSQNTot.vPIS)) ;
         trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ISSQNTot.vCOFINS)) ;
       end;

      Node := trvwNFe.Items.AddChild(NodePai,'retTrib');
      trvwNFe.Items.AddChild(Node,'vRetPIS='   +FloatToStr(Total.retTrib.vRetPIS)) ;
      trvwNFe.Items.AddChild(Node,'vRetCOFINS='+FloatToStr(Total.retTrib.vRetCOFINS)) ;
      trvwNFe.Items.AddChild(Node,'vRetCSLL='  +FloatToStr(Total.retTrib.vRetCSLL)) ;
      trvwNFe.Items.AddChild(Node,'vBCIRRF='   +FloatToStr(Total.retTrib.vBCIRRF)) ;
      trvwNFe.Items.AddChild(Node,'vIRRF='     +FloatToStr(Total.retTrib.vIRRF)) ;
      trvwNFe.Items.AddChild(Node,'vBCRetPrev='+FloatToStr(Total.retTrib.vBCRetPrev)) ;
      trvwNFe.Items.AddChild(Node,'vRetPrev='  +FloatToStr(Total.retTrib.vRetPrev)) ;

      NodePai := trvwNFe.Items.AddChild(Nota,'Transp');
      Node := trvwNFe.Items.AddChild(NodePai,'Transporta');
      trvwNFe.Items.AddChild(Node,'modFrete=' +modFreteToStr(Transp.modFrete));
      trvwNFe.Items.AddChild(Node,'CNPJCPF='  +Transp.Transporta.CNPJCPF);
      trvwNFe.Items.AddChild(Node,'xNome='    +Transp.Transporta.xNome);
      trvwNFe.Items.AddChild(Node,'IE='       +Transp.Transporta.IE);
      trvwNFe.Items.AddChild(Node,'xEnder='   +Transp.Transporta.xEnder);
      trvwNFe.Items.AddChild(Node,'xMun='     +Transp.Transporta.xMun);
      trvwNFe.Items.AddChild(Node,'UF='       +Transp.Transporta.UF);

      Node := trvwNFe.Items.AddChild(NodePai,'retTransp');
      trvwNFe.Items.AddChild(Node,'vServ='    +FloatToStr(Transp.retTransp.vServ)) ;
      trvwNFe.Items.AddChild(Node,'vBCRet='   +FloatToStr(Transp.retTransp.vBCRet)) ;
      trvwNFe.Items.AddChild(Node,'pICMSRet=' +FloatToStr(Transp.retTransp.pICMSRet)) ;
      trvwNFe.Items.AddChild(Node,'vICMSRet=' +FloatToStr(Transp.retTransp.vICMSRet)) ;
      trvwNFe.Items.AddChild(Node,'CFOP='     +Transp.retTransp.CFOP);
      trvwNFe.Items.AddChild(Node,'cMunFG='   +FloatToStr(Transp.retTransp.cMunFG));

      Node := trvwNFe.Items.AddChild(NodePai,'veicTransp');
      trvwNFe.Items.AddChild(Node,'placa='  +Transp.veicTransp.placa);
      trvwNFe.Items.AddChild(Node,'UF='     +Transp.veicTransp.UF);
      trvwNFe.Items.AddChild(Node,'RNTC='   +Transp.veicTransp.RNTC);

      for I:=0 to Transp.Reboque.Count-1 do
       begin
         Node := trvwNFe.Items.AddChild(NodePai,'Reboque'+IntToStrZero(I+1,3));
         with Transp.Reboque.Items[I] do
          begin
            trvwNFe.Items.AddChild(Node,'placa=' +placa) ;
            trvwNFe.Items.AddChild(Node,'UF='    +UF) ;
            trvwNFe.Items.AddChild(Node,'RNTC='  +RNTC) ;
          end;
       end;

      for I:=0 to Transp.Vol.Count-1 do
       begin
         Node := trvwNFe.Items.AddChild(NodePai,'Volume'+IntToStrZero(I+1,3));
         with Transp.Vol.Items[I] do
          begin
            trvwNFe.Items.AddChild(Node,'qVol='  +IntToStr(qVol)) ;
            trvwNFe.Items.AddChild(Node,'esp='   +esp);
            trvwNFe.Items.AddChild(Node,'marca=' +marca);
            trvwNFe.Items.AddChild(Node,'nVol='  +nVol);
            trvwNFe.Items.AddChild(Node,'pesoL=' +FloatToStr(pesoL)) ;
            trvwNFe.Items.AddChild(Node,'pesoB'  +FloatToStr(pesoB)) ;

            for J:=0 to Lacres.Count-1 do
             begin
               Node := trvwNFe.Items.AddChild(Node,'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) );
               trvwNFe.Items.AddChild(Node,'nLacre='+Lacres.Items[J].nLacre) ;
             end;
          end;
       end;

      NodePai := trvwNFe.Items.AddChild(Nota,'Cobr');
      Node    := trvwNFe.Items.AddChild(NodePai,'Fat');
      trvwNFe.Items.AddChild(Node,'nFat='  +Cobr.Fat.nFat);
      trvwNFe.Items.AddChild(Node,'vOrig=' +FloatToStr(Cobr.Fat.vOrig)) ;
      trvwNFe.Items.AddChild(Node,'vDesc=' +FloatToStr(Cobr.Fat.vDesc)) ;
      trvwNFe.Items.AddChild(Node,'vLiq='  +FloatToStr(Cobr.Fat.vLiq)) ;

      for I:=0 to Cobr.Dup.Count-1 do
       begin
         Node    := trvwNFe.Items.AddChild(NodePai,'Duplicata'+IntToStrZero(I+1,3));
         with Cobr.Dup.Items[I] do
          begin
            trvwNFe.Items.AddChild(Node,'nDup='  +nDup) ;
            trvwNFe.Items.AddChild(Node,'dVenc=' +DateToStr(dVenc));
            trvwNFe.Items.AddChild(Node,'vDup='  +FloatToStr(vDup)) ;
          end;
       end;

      NodePai := trvwNFe.Items.AddChild(Nota,'InfAdic');
      trvwNFe.Items.AddChild(NodePai,'infCpl='     +InfAdic.infCpl);
      trvwNFe.Items.AddChild(NodePai,'infAdFisco=' +InfAdic.infAdFisco);

      for I:=0 to InfAdic.obsCont.Count-1 do
       begin
         Node := trvwNFe.Items.AddChild(NodePai,'obsCont'+IntToStrZero(I+1,3));
         with InfAdic.obsCont.Items[I] do
          begin
            trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
            trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
          end;
       end;

        for I:=0 to InfAdic.obsFisco.Count-1 do
         begin
           Node := trvwNFe.Items.AddChild(NodePai,'obsFisco'+IntToStrZero(I+1,3));
           with InfAdic.obsFisco.Items[I] do
            begin
               trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
               trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
            end;
         end;

        for I:=0 to InfAdic.procRef.Count-1 do
         begin
           Node := trvwNFe.Items.AddChild(NodePai,'procRef'+IntToStrZero(I+1,3));
           with InfAdic.procRef.Items[I] do
            begin
              trvwNFe.Items.AddChild(Node,'nProc='   +nProc) ;
              trvwNFe.Items.AddChild(Node,'indProc=' +indProcToStr(indProc));
            end;
         end;

        if (exporta.UFembarq <> '') then
         begin
           Node := trvwNFe.Items.AddChild(Nota,'exporta');
           trvwNFe.Items.AddChild(Node,'UFembarq='   +exporta.UFembarq) ;
           trvwNFe.Items.AddChild(Node,'xLocEmbarq=' +exporta.xLocEmbarq);
         end;

        if (compra.xNEmp <> '') then
         begin
           Node := trvwNFe.Items.AddChild(Nota,'compra');
           trvwNFe.Items.AddChild(Node,'xNEmp=' +compra.xNEmp) ;
           trvwNFe.Items.AddChild(Node,'xPed='  +compra.xPed);
           trvwNFe.Items.AddChild(Node,'xCont=' +compra.xCont);
         end;
    end;
      PageControl2.ActivePageIndex := 3;
    end;

 end;

end;

procedure TForm1.btnConsultarClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
   ACBrNFe1.Consultar;
   ShowMessage(ACBrNFe1.WebServices.Consulta.Protocolo);
   MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
   memoRespWS.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
   LoadXML(MemoResp, SynReposta);
 end;

end;

procedure TForm1.btnConsultarDPECClick(Sender: TObject);
var
 vAux : String;
begin
 if not(InputQuery('WebServices DPEC', 'Informe o Numero do Registro do DPEC ou a Chave da NFe', vAux)) then
   exit;

 if Length(Trim(vAux)) < 44 then
    ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC := vAux
 else
    ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := vAux;
 ACBrNFe1.WebServices.ConsultaDPEC.Executar;

 MemoResp.Lines.Text := ACBrNFe1.WebServices.ConsultaDPEC.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.ConsultaDPEC.RetornoWS;
end;

procedure TForm1.btnConsultarReciboClick(Sender: TObject);
var
  aux : String;
begin
 if not(InputQuery('Consultar Recibo Lote', 'Número do Recibo', aux)) then
   exit;
 ACBrNFe1.WebServices.Recibo.Recibo := aux;;
 ACBrNFe1.WebServices.Recibo.Executar;

 MemoResp.Lines.Text := ACBrNFe1.WebServices.Recibo.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.Recibo.RetornoWS;
end;

procedure TForm1.btnConsultarChaveClick(Sender: TObject);
var
 vChave : String;
begin
 if not(InputQuery('WebServices Consultar', 'Chave da NF-e:', vChave)) then
   exit;

 ACBrNFe1.WebServices.Consulta.NFeChave := vChave;
 ACBrNFe1.WebServices.Consulta.Executar;

 MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
 LoadXML(MemoResp, SynReposta);
end;

procedure TForm1.btnCancNFClick(Sender: TObject);
var
  idLote,vAux : String;
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    idLote := '1';
    if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
       exit;
    if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa', vAux)) then
       exit;
    ACBrNFe1.EventoNFe.Evento.Clear;
    ACBrNFe1.EventoNFe.idLote := StrToInt(idLote) ;
    with ACBrNFe1.EventoNFe.Evento.Add do
    begin
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCancelamento;
     infEvento.detEvento.xJust := vAux;
    end;
    ACBrNFe1.EnviarEventoNFe(StrToInt(idLote));

    MemoResp.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetWS;
    memoRespWS.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetornoWS;
    SynReposta.Text := MemoResp.Text;
    ShowMessage(IntToStr(ACBrNFe1.WebServices.EnvEvento.cStat));
    ShowMessage(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
  end;
end;

procedure TForm1.btnCarregarXMLEnviarClick(Sender: TObject);
begin
    OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

 {   with ACBrNFe1.NotasFiscais.Items[0].NFe do
     begin
       Emit.CNPJCPF           := edtEmitCNPJ.Text;
       Emit.IE                := edtEmitIE.Text;
       Emit.xNome             := edtEmitRazao.Text;
       Emit.xFant             := edtEmitFantasia.Text;

       Emit.EnderEmit.fone    := edtEmitFone.Text;
       Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
       Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
       Emit.EnderEmit.nro     := edtEmitNumero.Text;
       Emit.EnderEmit.xCpl    := edtEmitComp.Text;
       Emit.EnderEmit.xBairro := edtEmitBairro.Text;
       Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
       Emit.EnderEmit.xMun    := edtEmitCidade.Text;
       Emit.EnderEmit.UF      := edtEmitUF.Text;
       Emit.enderEmit.cPais   := 1058;
       Emit.enderEmit.xPais   := 'BRASIL';

       Emit.IEST              := '';
       Emit.IM                := ''; // Preencher no caso de existir serviços na nota
       Emit.CNAE              := ''; // Verifique na cidade do emissor da NFe se é permitido
                                    // a inclusão de serviços na NFe
       Emit.CRT               := crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
    end;}
    ACBrNFe1.NotasFiscais.GerarNFe;
    ACBrNFe1.Enviar(1,True);

    MemoResp.Lines.Text := ACBrNFe1.WebServices.Retorno.RetWS;
    memoRespWS.Lines.Text := ACBrNFe1.WebServices.Retorno.RetornoWS;
    LoadXML(MemoResp, SynReposta);

   MemoDados.Lines.Add('');
   MemoDados.Lines.Add('Envio NFe');
   MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
   MemoDados.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
   MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
   MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
   MemoDados.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
   MemoDados.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
   MemoDados.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
   MemoDados.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
   MemoDados.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);
  end;

end;

procedure TForm1.btnCartadeCorrecaoClick(Sender: TObject);
var
 Chave, idLote, CNPJ, nSeqEvento, Correcao : string;
begin
  if not(InputQuery('WebServices Eventos: Carta de Correção', 'Chave da NF-e', Chave)) then
     exit;
  Chave := Trim(OnlyNumber(Chave));
  idLote := '1';
  if not(InputQuery('WebServices Eventos: Carta de Correção', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;
  CNPJ := copy(Chave,7,14);
  if not(InputQuery('WebServices Eventos: Carta de Correção', 'CNPJ ou o CPF do autor do Evento', CNPJ)) then
     exit;
  nSeqEvento := '1';
  if not(InputQuery('WebServices Eventos: Carta de Correção', 'Sequencial do evento para o mesmo tipo de evento', nSeqEvento)) then
     exit;
  Correcao := 'Correção a ser considerada, texto livre. A correção mais recente substitui as anteriores.';
  if not(InputQuery('WebServices Eventos: Carta de Correção', 'Correção a ser considerada', Correcao)) then
     exit;
  ACBrNFe1.EventoNFe.Evento.Clear;
//  ACBrNFe1.EnvEvento.EnvEventoNFe..idLote := StrToInt(idLote) ;
  with ACBrNFe1.EventoNFe.Evento.Add do
   begin
     infEvento.chNFe := Chave;
     infEvento.CNPJ   := CNPJ;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCCe;
     infEvento.nSeqEvento := StrToInt(nSeqEvento);
     infEvento.detEvento.xCorrecao := Correcao;
   end;
  ACBrNFe1.EnviarEventoNFe(StrToInt(idLote));

  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetWS);
  //memoRespWS.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.EnvEvento.EventoRetorno);
//  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].XXXX
  SynReposta.Text := MemoResp.Text;
end;

procedure TForm1.btnConsCadClick(Sender: TObject);
var
 UF, Documento : String;
begin
 if not(InputQuery('WebServices Consulta Cadastro ', 'UF do Documento a ser Consultado:',    UF)) then
    exit;
 if not(InputQuery('WebServices Consulta Cadastro ', 'Documento(CPF/CNPJ)',    Documento)) then
    exit;
  Documento :=  Trim(DFeUtil.LimpaNumero(Documento));

  ACBrNFe1.WebServices.ConsultaCadastro.UF  := UF;
  if Length(Documento) > 11 then
     ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := Documento
  else
     ACBrNFe1.WebServices.ConsultaCadastro.CPF := Documento;
  ACBrNFe1.WebServices.ConsultaCadastro.Executar;

  MemoResp.Lines.Text := ACBrNFe1.WebServices.ConsultaCadastro.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.ConsultaCadastro.RetornoWS;
  LoadXML(MemoResp, SynReposta);

  ShowMessage(ACBrNFe1.WebServices.ConsultaCadastro.xMotivo);
  ShowMessage(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome);

end;

procedure TForm1.btnCancelarChaveClick(Sender: TObject);
var
 Chave, idLote, CNPJ, Protocolo, Justificativa : string;
begin
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Chave da NF-e', Chave)) then
     exit;
  Chave := Trim(OnlyNumber(Chave));
  idLote := '1';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;
  CNPJ := copy(Chave,7,14);
  if not(InputQuery('WebServices Eventos: Cancelamento', 'CNPJ ou o CPF do autor do Evento', CNPJ)) then
     exit;
  Protocolo:='';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Protocolo de Autorização', Protocolo)) then
     exit;
  Justificativa := 'Justificativa do Cancelamento';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa do Cancelamento', Justificativa)) then
     exit;

  ACBrNFe1.EventoNFe.Evento.Clear;
//  ACBrNFe1.EvnvEvento.EnvEventoNFe.idLote := StrToInt(idLote) ;
  with ACBrNFe1.EventoNFe.Evento.Add do
   begin
     infEvento.chNFe := Chave;
     infEvento.CNPJ   := CNPJ;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCancelamento;
     infEvento.detEvento.xJust := Justificativa;
     infEvento.detEvento.nProt := Protocolo;
   end;
  ACBrNFe1.EnviarEventoNFe(StrToInt(idLote));

  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetWS);
  memoRespWS.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetornoWS);
  SynReposta.Text := MemoResp.Text;

  {ACBrNFe1.WebServices.EnvEvento.EventoRetorno.TpAmb
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.verAplic
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.cStat
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.xMotivo
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.chNFe
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento
  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt}
end;

procedure TForm1.btnAdicionarProtNFeClick(Sender: TObject);
var
  NomeArq : String;
begin
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
   ACBrNFe1.Consultar;
   ShowMessage(ACBrNFe1.WebServices.Consulta.Protocolo);
   MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
   memoRespWS.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
   LoadXML(MemoResp, SynReposta);
   NomeArq := OpenDialog1.FileName;
   if pos(UpperCase('-nfe.xml'),UpperCase(NomeArq)) > 0 then
      NomeArq := StringReplace(NomeArq,'-nfe.xml','-procNfe.xml',[rfIgnoreCase]);
   ACBrNFe1.NotasFiscais.Items[0].SaveToFile(NomeArq);
   ShowMessage('Arquivo gravado em: '+NomeArq);
   memoLog.Lines.Add('Arquivo gravado em: '+NomeArq);
 end;
end;

procedure TForm1.ACBrNFe1StatusChange(Sender: TObject);
begin
 case ACBrNFe1.Status of
   stIdle :
   begin
     if ( frmStatus <> nil ) then
       frmStatus.Hide;
   end;
   stNFeStatusServico :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeRecepcao :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNfeRetRecepcao :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNfeConsulta :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Consultando NFe...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNfeCancelamento :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNfeInutilizacao :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeRecibo :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeCadastro :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeEnvDPEC :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando DPEC...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeConsultaDPEC :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Consultando DPEC...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeEmail :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando Email...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
   stNFeCCe :
   begin
     if ( frmStatus = nil ) then
       frmStatus := TfrmStatus.Create(Application);
     frmStatus.lblStatus.Caption := 'Enviando Carta de Correção...';
     frmStatus.Show;
     frmStatus.BringToFront;
   end;
 end;
 Application.ProcessMessages;

end;

procedure TForm1.ACBrNFe1GerarLog(const Mensagem: String);
begin
   memoLog.Lines.Add(Mensagem);
end;

procedure TForm1.btnImprimirClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
   if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
    begin
      ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
      ACBrNFe1.WebServices.ConsultaDPEC.Executar;
      ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
    end;
   ACBrNFe1.NotasFiscais.Imprimir;
 end;

end;

procedure TForm1.btnInutilizarClick(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
 if not(InputQuery('WebServices Inutilização ', 'Ano',    Ano)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Modelo', Modelo)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Serie',  Serie)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroInicial)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroFinal)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Justificativa', Justificativa)) then
    exit;
  ACBrNFe1.WebServices.Inutiliza(edtEmitCNPJ.Text, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  MemoResp.Lines.Text := ACBrNFe1.WebServices.Inutilizacao.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.Inutilizacao.RetornoWS;
  LoadXML(MemoResp, SynReposta);

end;

procedure TForm1.btnManifDestConfirmacaoClick(Sender: TObject);
var
 Chave, idLote, CNPJ: string;
 lMsg: string;
begin
  Chave:='';
  if not(InputQuery('WebServices Eventos: Manif. Destinatario - Conf. Operacao', 'Chave da NF-e', Chave)) then
     exit;
  Chave := Trim(OnlyNumber(Chave));
  idLote := '1';
  if not(InputQuery('WebServices Eventos: Manif. Destinatario - Conf. Operacao', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;
  CNPJ := '';
  if not(InputQuery('WebServices Eventos: Manif. Destinatario - Conf. Operacao', 'CNPJ ou o CPF do autor do Evento', CNPJ)) then
     exit;

  ACBrNFe1.EventoNFe.Evento.Clear;
  with ACBrNFe1.EventoNFe.Evento.Add do
   begin
     infEvento.chNFe := Chave;
     infEvento.CNPJ   := CNPJ;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teManifDestConfirmacao;
   end;
  ACBrNFe1.EnviarEventoNFe(StrToInt(IDLote));

  with AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do
  begin
    lMsg:=
    'Id: '+Id+#13+
    'tpAmb: '+TpAmbToStr(tpAmb)+#13+
    'verAplic: '+verAplic+#13+
    'cOrgao: '+IntToStr(cOrgao)+#13+
    'cStat: '+IntToStr(cStat)+#13+
    'xMotivo: '+xMotivo+#13+
    'chNFe: '+chNFe+#13+
    'tpEvento: '+TpEventoToStr(tpEvento)+#13+
    'xEvento: '+xEvento+#13+
    'nSeqEvento: '+IntToStr(nSeqEvento)+#13+
    'CNPJDest: '+CNPJDest+#13+
    'emailDest: '+emailDest+#13+
    'dhRegEvento: '+DateTimeToStr(dhRegEvento)+#13+
    'nProt: '+nProt;
  end;
  ShowMessage(lMsg);

  MemoResp.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetornoWS;
//  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].XXXX
  LoadXML(MemoResp, SynReposta);
end;

procedure TForm1.btnNfeDestinadasClick(Sender: TObject);
var
 CNPJ, IndNFe, IndEmi, ultNSU: string;
 ok: boolean;
begin
  CNPJ := '';
  if not(InputQuery('WebServices Consulta NFe Destinadas', 'CNPJ do destinatário da NFe', CNPJ)) then
     exit;

  (*veja NT 2012/002 pág. 11 para identificar os valores possíveis
  Indicador de NF-e consultada:
  0=Todas as NF-e;
  1=Somente as NF-e que ainda não tiveram manifestação do destinatário
    (Desconhecimento da operação, Operação não Realizada ou Confirmação da Operação);
  2=Idem anterior, incluindo as NF-e que também não tiveram a Ciência da Operação.*)
  indNFe := '0';
  if not(InputQuery('WebServices Consulta NFe Destinadas', 'Indicador de NF-e consultada', indNFe)) then
     exit;

  (*veja NT 2012/002 pág. 11 para identificar os valores possíveis
  Indicador do Emissor da NF-e:
  0=Todos os Emitentes / Remetentes;
  1=Somente as NF-e emitidas por emissores / remetentes que não tenham a mesma
    raiz do CNPJ do destinatário (para excluir as notas fiscais de transferência
    entre filiais).*)
  IndEmi := '0';
  if not(InputQuery('WebServices Consulta NFe Destinadas', 'Indicador do Emissor da NF-e', IndEmi)) then
     exit;

  (*veja NT 2012/002 pág. 11 para identificar os valores possíveis
   Último NSU recebido pela Empresa.
   Caso seja informado com zero, ou com um NSU muito antigo, a consulta retornará
   unicamente as notas fiscais que tenham sido recepcionadas nos últimos 15 dias.*)
  ultNSU := '0';
  if not(InputQuery('WebServices Consulta NFe Destinadas', 'Último NSU recebido pela Empresa', ultNSU)) then
     exit;

  ACBrNFe1.ConsultaNFeDest(CNPJ,
                           StrToIndicadorNFe(ok,indNFe),
                           StrToIndicadorEmissor(ok,IndEmi),
                           UltNSu);

  //AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest

  MemoResp.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetornoWS;
//  ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].XXXX
  LoadXML(MemoResp, SynReposta);
end;

procedure TForm1.btnStatusServClick(Sender: TObject);
begin
 ACBrNFe1.WebServices.StatusServico.Executar;
 MemoResp.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetornoWS;
 LoadXML(MemoResp, SynReposta);

 PageControl2.ActivePageIndex := 1;

 MemoDados.Lines.Add('');
 MemoDados.Lines.Add('Status Serviço');
 MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb));
 MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.StatusServico.verAplic);
 MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.StatusServico.cStat));
 MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.StatusServico.xMotivo);
 MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.StatusServico.cUF));
 MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto));
 MemoDados.Lines.Add('tMed: '     +IntToStr(ACBrNFe1.WebServices.StatusServico.TMed));
 MemoDados.Lines.Add('dhRetorno: '+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRetorno));
 MemoDados.Lines.Add('xObs: '     +ACBrNFe1.WebServices.StatusServico.xObs);

end;

procedure TForm1.btnValidarAssinaturaClick(Sender: TObject);
var
  Msg : String;
begin
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
   if not ACBrNFe1.NotasFiscais.ValidaAssinatura(Msg) then
     MemoDados.Lines.Add('Erro: '+Msg)
   else
     ShowMessage('Assinatura Válida');
 end;
end;

procedure TForm1.btnValidarXMLClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione a NFE';
 OpenDialog1.DefaultExt := '*-nfe.XML';
 OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
 if OpenDialog1.Execute then
 begin
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
   ACBrNFe1.NotasFiscais.Valida;
   if ACBrNFe1.NotasFiscais.Items[0].Alertas <> '' then
     MemoDados.Lines.Add('Alertas: '+ACBrNFe1.NotasFiscais.Items[0].Alertas);
   showmessage('Nota Fiscal Eletrônica Valida');
 end;

end;

procedure TForm1.btnImprimirCCeClick(Sender: TObject);
begin
    OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.EventoNFe.Evento.Clear;
    ACBrNFe1.EventoNFe.LerXML(OpenDialog1.FileName) ;
    ACBrNFe1.ImprimirEvento;
  end;
//  LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.btnEnviarEventoClick(Sender: TObject);
var
 Para : String;
 CC, Evento: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione ao Evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    Evento := TStringList.Create;
    Evento.Clear;
    Evento.Add(OpenDialog1.FileName);
    ACBrNFe1.EventoNFe.Evento.Clear;
    ACBrNFe1.EventoNFe.LerXML(OpenDialog1.FileName) ;
    CC:=TstringList.Create;
    CC.Add('andrefmoraes@gmail.com'); //especifique um email válido
    CC.Add('anfm@zipmail.com.br');    //especifique um email válido
    ACBrNFe1.EnviarEmailEvento(edtSmtpHost.Text
                             , edtSmtpPort.Text
                             , edtSmtpUser.Text
                             , edtSmtpPass.Text
                             , edtSmtpUser.Text
                             , Para
                             , edtEmailAssunto.Text
                             , mmEmailMsg.Lines
                             , cbEmailSSL.Checked // SSL - Conexão Segura
                             , True //Enviar PDF junto
                             , CC //Lista com emails que serão enviado cópias - TStrings
                             , Evento // Lista de anexos - TStrings
                             , False  //Pede confirmação de leitura do email
                             , False  //Aguarda Envio do Email(não usa thread)
                             , 'ACBrNFe2' // Nome do Rementente
                             , cbEmailSSL.Checked ); // Auto TLS
    CC.Free;
    Evento.Free;
  end;
end;

end.

