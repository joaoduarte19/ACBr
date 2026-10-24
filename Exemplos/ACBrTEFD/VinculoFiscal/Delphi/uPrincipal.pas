unit uPrincipal;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, uFrameTitulo,
  uframemenuesquerdo, uFrames, ACBrEnterTab, ACBrPosPrinter, ACBrAbecsPinPad,
  ACBrTEFAPI, ACBrNFe, ACBrDANFCeFortesFr, ACBrNFeDANFeESCPOS,
  ACBrNFeDANFeRLClass, ImgList, ACBrTEFAPIComum,
  ACBrNFeDANFEClass, ACBrDFeReport, ACBrDFeDANFeReport, ACBrDFe, ACBrBase,
  Frm_Status, ACBrPIXCD
  {$IFDEF DELPHIXE8_UP}, System.ImageList{$ENDIF};

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    ACBrAbecsPinPad1: TACBrAbecsPinPad;
    ACBrEnterTab1: TACBrEnterTab;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrPosPrinter1: TACBrPosPrinter;
    ACBrTEFAPI1: TACBrTEFAPI;
    frameMenuEsquerdo1: TframeMenuEsquerdo;
    FrameTitulo1: TFrameTitulo;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    pnpPrincipal: TPanel;
    pnpFundo: TPanel;
    pnpMenuEsquerdo: TPanel;
    pnpTitulo: TPanel;
    ACBrPixCD1: TACBrPixCD;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCfgNFCeClick(Sender: TObject);
    procedure btnConfTEFClick(Sender: TObject);
    procedure btnCfgPIXClick(Sender: TObject);
    procedure btnPDVClick(Sender: TObject);
    procedure ACBrNFe1StatusChange(Sender: TObject);
  private
     FFrame: TFrame;
     FfrmStatus: TfrmStatus;
     procedure FecharFrameAtual(Sender: TObject);
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
  uses ActiveX,   // CoInitialize / CoUninitialize
    uframeConfigNFe, uframeconfigTEF, uframeConfigPIX, uframePDV,
    pcnConversaoNFe;   // TStatusACBrNFe (stIdle, stNFeRecepcao...)

{$R *.dfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  CoUninitialize;   // par do CoInitialize do FormCreate
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  // Garante o COM (ActiveX) inicializado durante toda a vida do programa.
  // O TBitBtn com Kind (ex.: botão "Voltar" do menu do TEF) carrega o ícone
  // via TWicImage, que usa COM (WICImagingFactory). Sem isso, um
  // CoUninitialize feito por DLL de terceiros (ex.: GP do TEF) gera
  // "Access violation" / "Cannot create instance of class
  // CLSID_WICImagingFactory" ao abrir o menu do TEF.
  // Ref.: https://www.projetoacbr.com.br/forum/topic/68349
  CoInitialize(nil);

  // O tamanho (1024 x 860, no .dfm) cabe a maior tela: CONFIG. PIX
  // (1000 x 790) + título. A VCL ajusta esse tamanho à escala do Windows.
  // Em monitores menores (ex.: notebook 1366 x 768), abre maximizado.
  if (Width > Screen.WorkAreaWidth) or (Height > Screen.WorkAreaHeight) then
    WindowState := wsMaximized;

  frameMenuEsquerdo1.CarregarOpcoes;
end;

procedure TfrmPrincipal.btnCfgNFCeClick(Sender: TObject);
begin
  FFrame := AbrirFrame(pnpPrincipal, TframeConfigNFe);
  TframeConfigNfe(FFrame).OnFechar := FecharFrameAtual;
  pnpMenuEsquerdo.Visible := False;
end;

procedure TfrmPrincipal.btnConfTEFClick(Sender: TObject);
begin
  FFrame := AbrirFrame(pnpPrincipal, TframeConfigTEF);
  TframeConfigTEF(FFrame).OnFechar := FecharFrameAtual;
  pnpMenuEsquerdo.Visible := False;
end;

procedure TfrmPrincipal.btnCfgPIXClick(Sender: TObject);
begin
  FFrame := AbrirFrame(pnpPrincipal, TframeConfigPIX);
  TframeConfigPIX(FFrame).OnFechar := FecharFrameAtual;
  pnpMenuEsquerdo.Visible := False;
end;

procedure TfrmPrincipal.btnPDVClick(Sender: TObject);
begin
  FFrame := AbrirFrame(pnpPrincipal, TframePDV);
  TframePDV(FFrame).OnFechar := FecharFrameAtual;
  pnpMenuEsquerdo.Visible := False;
end;

procedure TfrmPrincipal.FecharFrameAtual(Sender: TObject);
begin
  FecharFrame(FFrame);
  frameMenuEsquerdo1.CarregarOpcoes;   // CONFIG. PIX pode ter mudado [PIX] Habilitado
  pnpMenuEsquerdo.Visible := True;
end;

// Igual ao exemplo ACBr\Exemplos\ACBrDFe\ACBrNFe\Delphi (Frm_ACBrNFe.pas):
// exibe o Frm_Status enquanto o ACBrNFe1 se comunica com a SEFAZ
procedure TfrmPrincipal.ACBrNFe1StatusChange(Sender: TObject);
begin
  case ACBrNFe1.Status of
    stIdle:
      begin
        if ( FfrmStatus <> nil ) then
          FfrmStatus.Hide;
      end;

    stNFeStatusServico:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Verificando Status do servico...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeRecepcao:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNfeRetRecepcao:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNfeConsulta:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Consultando NFe...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNfeCancelamento:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNfeInutilizacao:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeRecibo:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeCadastro:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Consultando Cadastro...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeEmail:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando Email...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeCCe:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando Carta de Correção...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;

    stNFeEvento:
      begin
        if ( FfrmStatus = nil ) then
          FfrmStatus := TfrmStatus.Create(Application);

        FfrmStatus.lblStatus.Caption := 'Enviando Evento...';
        FfrmStatus.Show;
        FfrmStatus.BringToFront;
      end;
  end;

  Application.ProcessMessages;
end;

end.

