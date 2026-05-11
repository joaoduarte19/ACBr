{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{																			   }
{ Colaboradores nesse arquivo: Juliomar Marchetti                              }
{																			   }
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

unit ufrmPrincipal;

{$I ACBr_jedi.inc}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ExtCtrls,
  ACBrUtil,
  ACBrBase,
  ACBrDFe,
  ACBrNFe,
  ACBrDFeReport,
  ACBrDFeDANFeReport,
  ACBrNFeDANFEClass,
  ACBrNFeDANFEFRDM,
  frxClass,
  frxSmartMemo,
  frCoreClasses,
  ACBrNFeDANFEFR;

type
  TfrmPrincipal = class(TForm)
    imgLogo: TImage;
    pnlbotoes: TPanel;
    btnImprimir: TButton;
    btncarregar: TButton;
    btnCarregarEvento: TButton;
    OpenDialog1: TOpenDialog;
    btncarregarinutilizacao: TButton;
    Image1: TImage;
    frxReport1: TfrxReport;
    PageControl1: TPageControl;
    TabArquivos: TTabSheet;
    lstbxFR3: TListBox;
    TabCustomizacao: TTabSheet;
    RbCanhoto: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditMargemEsquerda: TEdit;
    EditMargemSuperior: TEdit;
    EditMargemDireita: TEdit;
    EditMargemInferior: TEdit;
    Decimais: TTabSheet;
    RgTipodedecimais: TRadioGroup;
    PageControl2: TPageControl;
    TabtdetInteger: TTabSheet;
    TabtdetMascara: TTabSheet;
    cbtdetInteger_qtd: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    cbtdetInteger_Vrl: TComboBox;
    Label7: TLabel;
    cbtdetMascara_qtd: TComboBox;
    Label8: TLabel;
    cbtdetMascara_Vrl: TComboBox;
    rbTarjaNfeCancelada: TCheckBox;
    Label9: TLabel;
    CBImprimirUndQtVlComercial: TComboBox;
    rbImprimirDadosDocReferenciados: TCheckBox;
    rgModelo: TRadioGroup;
    ckImprimeCodigoEan: TCheckBox;
    ckImprimeItens: TCheckBox;
    ChkQuebraLinhaEmDetalhamentos: TCheckBox;
    Label10: TLabel;
    cbPosCanhotoLayout: TComboBox;
    ACBrNFeDANFEFR1: TACBrNFeDANFEFR;
    ACBrNFeDANFCEFR1: TACBrNFeDANFCEFR;
    ACBrNFe1: TACBrNFe;
    Label11: TLabel;
    cbExibeCampoDePagamento: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btncarregarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btncarregarinutilizacaoClick(Sender: TObject);
    procedure btnCarregarEventoClick(Sender: TObject);
    procedure rgModeloClick(Sender: TObject);
  private
    procedure Configuracao;
    procedure Initializao;
    procedure ConfiguraNfe;
    procedure ConfiguraNFCe;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal      : TfrmPrincipal;

implementation

uses
{$IFDEF DELPHIXE6_UP}
  System.IOUtils,
{$ENDIF}
  pcnConversao,
  pcnConversaoNFe;

{$R *.dfm}

procedure TfrmPrincipal.btncarregarClick(Sender: TObject);
begin
  ACBrNFe1.NotasFiscais.Clear;
  if OpenDialog1.Execute then
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmPrincipal.btnImprimirClick(Sender: TObject);
begin
  Configuracao;
  if lstbxFR3.ItemIndex = -1 then
    raise Exception.Create('Selecione um arquivo fr3 ');

  if Pos('danf', LowerCase(lstbxFR3.Items[lstbxFR3.ItemIndex])) > 0 then
  begin
    if ACBrNFe1.NotasFiscais.Count = 0 then
      raise Exception.Create('Não foi carregado nenhum xml para impressão');

    case rgModelo.ItemIndex of
      0: ACBrNFeDANFEFR1.FastFile := lstbxFR3.Items[lstbxFR3.ItemIndex];
      1: ACBrNFeDANFCEFR1.FastFile := lstbxFR3.Items[lstbxFR3.ItemIndex];
    end;

    ACBrNFe1.NotasFiscais.Imprimir;
  end
  else if Pos('evento', LowerCase(lstbxFR3.Items[lstbxFR3.ItemIndex])) > 0 then
  begin
    if ACBrNFe1.EventoNFe.Evento.Count = 0 then
      raise Exception.Create('Não tem nenhum evento para imprimir');

    case rgModelo.ItemIndex of
      0: ACBrNFeDANFEFR1.FastFileEvento := lstbxFR3.Items[lstbxFR3.ItemIndex];
      1: ACBrNFeDANFCEFR1.FastFileEvento := lstbxFR3.Items[lstbxFR3.ItemIndex];
    end;

    ACBrNFe1.ImprimirEvento;
  end
  else if Pos('inuti', LowerCase(lstbxFR3.Items[lstbxFR3.ItemIndex])) > 0 then
  begin
    if ACBrNFe1.InutNFe.RetInutNFe.nProt = EmptyStr then
      raise Exception.Create('Não foi carregado nenhuma inutilização');

    case rgModelo.ItemIndex of
      0: ACBrNFeDANFEFR1.FastFileInutilizacao := lstbxFR3.Items[lstbxFR3.ItemIndex];
      1: ACBrNFeDANFCEFR1.FastFileInutilizacao := lstbxFR3.Items[lstbxFR3.ItemIndex];
    end;

    ACBrNFe1.ImprimirInutilizacao;
  end;

end;

procedure TfrmPrincipal.btnCarregarEventoClick(Sender: TObject);
begin

  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.EventoNFe.Evento.Clear;
  OpenDialog1.Execute();
  ACBrNFe1.EventoNFe.LerXML(OpenDialog1.FileName);
end;

procedure TfrmPrincipal.btncarregarinutilizacaoClick(Sender: TObject);
begin
  ACBrNFe1.NotasFiscais.Clear;

  OpenDialog1.Execute();
  ACBrNFe1.InutNFe.LerXML(OpenDialog1.FileName);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);

  procedure AdicionarArquivos(const Diretorio: string; const Extensao: string);
  var
  {$IFDEF DELPHIXE6_UP}
    fsFiles         : string;
    fsDirectories   : string;
  {$ELSE}
    SR              : TSearchRec;
    PathArq         : string;
  {$ENDIF}
  begin
{$IFDEF DELPHIXE6_UP}
    for fsFiles in TDirectory.GetFiles(Diretorio) do
      if Pos(Extensao, LowerCase(fsFiles)) > 0 then
        lstbxFR3.AddItem(fsFiles, nil);

    for fsDirectories in TDirectory.GetDirectories(Diretorio) do
      if (fsDirectories <> '.') and (fsDirectories <> '..') then
        AdicionarArquivos(fsDirectories, Extensao);

{$ELSE}
    if FindFirst(Diretorio + '*.*', faDirectory or faArchive, SR) = 0 then
      try
        repeat
          PathArq := Diretorio + SR.Name;
          if ((SR.Attr and faDirectory) = 0) then
          begin
            if (ExtractFileExt(PathArq) = Extensao) then
              lstbxFR3.AddItem(PathArq, nil);
          end
          else if (SR.Name <> '.') and (SR.Name <> '..') then
            AdicionarArquivos(PathArq + '\', Extensao);
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;
{$ENDIF}
  end;

begin
  AdicionarArquivos('..\Delphi\Report\', '.fr3');
  Initializao;
end;

procedure TfrmPrincipal.Configuracao;
begin

  case rgModelo.ItemIndex of
    0: ACBrNFe1.DANFE := ACBrNFeDANFEFR1;
    1: ACBrNFe1.DANFE := ACBrNFeDANFCEFR1;
  end;

  // --- Configurações para NFe e NFCe ---
  with ACBrNFe1.DANFE do
  begin
    // Imprime codigo cEan
    ImprimeCodigoEan := ckImprimeCodigoEan.Checked;

    // Mostra  a Tarja NFe CANCELADA
    Cancelada := rbTarjaNfeCancelada.Checked;

    { Ajustar a propriedade ProtocoloNFe conforme a sua necessidade }
    { ProtocoloNFe := }

    // Margens
    MargemEsquerda := StringToFloat(EditMargemEsquerda.Text);
    MargemSuperior := StringToFloat(EditMargemSuperior.Text);
    MargemDireita := StringToFloat(EditMargemDireita.Text);
    MargemInferior := StringToFloat(EditMargemInferior.Text);

    // Decimais
    CasasDecimais.Formato := TDetFormato(RgTipodedecimais.ItemIndex);
    CasasDecimais.qCom := cbtdetInteger_qtd.ItemIndex;
    CasasDecimais.vUnCom := cbtdetInteger_Vrl.ItemIndex;
    CasasDecimais.MaskqCom := cbtdetMascara_qtd.Items[cbtdetMascara_qtd.ItemIndex];
    CasasDecimais.MaskvUnCom := cbtdetMascara_Vrl.Items[cbtdetMascara_Vrl.ItemIndex];

  end;
  ConfiguraNfe;
  ConfiguraNFCe;

end;

procedure TfrmPrincipal.Initializao;
begin
  PageControl1.ActivePage := TabArquivos;
  rgModelo.ItemIndex := 0;

  with ACBrNFeDANFEFR1 do
  begin

    EditMargemEsquerda.Text := FloatToString(MargemEsquerda);
    EditMargemSuperior.Text := FloatToString(MargemSuperior);
    EditMargemDireita.Text := FloatToString(MargemDireita);
    EditMargemInferior.Text := FloatToString(MargemInferior);

    Cancelada := False;

    // Decimais
    RgTipodedecimais.ItemIndex := integer(CasasDecimais.Formato);
    cbtdetInteger_qtd.ItemIndex := CasasDecimais.qCom;
    cbtdetInteger_Vrl.ItemIndex := CasasDecimais.vUnCom;
    cbtdetMascara_qtd.ItemIndex := CasasDecimais.qCom;
    cbtdetMascara_Vrl.ItemIndex := CasasDecimais.vUnCom;

    // ImprimirUndQtVlComercial
    CBImprimirUndQtVlComercial.ItemIndex := integer(ImprimeValor);

    rbImprimirDadosDocReferenciados.Checked := ExibeDadosDocReferenciados;

    ckImprimeCodigoEan.Checked := ImprimeCodigoEan;

    ChkQuebraLinhaEmDetalhamentos.Checked := QuebraLinhaEmDetalhamentos;

    cbPosCanhotoLayout.ItemIndex := Integer(PosCanhotoLayout);
  end;

  ckImprimeItens.Checked := ACBrNFeDANFCEFR1.ImprimeItens;

  with frxReport1 do
  begin
    ShowProgress := False;
    StoreInDFM := False;
  end;

end;

procedure TfrmPrincipal.ConfiguraNfe;
// --- Configurações específicas para NFe ---
begin
  // Mostra a posicao do canhoto
  ACBrNFeDANFEFR1.PosCanhoto := TPosRecibo(RbCanhoto.ItemIndex);
  // ImprimirUndQtVlComercial
  ACBrNFeDANFEFR1.ImprimeValor := TImprimirUnidQtdeValor(CBImprimirUndQtVlComercial.ItemIndex);
  // Mostra dados referenciados
  ACBrNFeDANFEFR1.ExibeDadosDocReferenciados := rbImprimirDadosDocReferenciados.Checked;
  // Mostra Quebra Linha Em Detalhamentos
  ACBrNFeDANFEFR1.QuebraLinhaEmDetalhamentos := ChkQuebraLinhaEmDetalhamentos.Checked;
  // Mostra Layout do Canhoto
  ACBrNFeDANFEFR1.PosCanhotoLayout := TPosReciboLayout(cbPosCanhotoLayout.ItemIndex);
  // informações de pagamentos
  ACBrNFeDANFEFR1.ExibeCampoDePagamento := TpcnInformacoesDePagamento(cbExibeCampoDePagamento.ItemIndex);

end;

procedure TfrmPrincipal.ConfiguraNFCe;
// --- Configurações específicas para NFCe ---
begin
  // Mostra itens na NFCe, caso False emite a NFCe resumida
  ACBrNFeDANFCEFR1.ImprimeItens := ckImprimeItens.Checked;
  // Mostra Quebra Linha Em Detalhamentos
  ACBrNFeDANFCEFR1.QuebraLinhaEmDetalhamentos := ChkQuebraLinhaEmDetalhamentos.Checked;
end;

procedure TfrmPrincipal.rgModeloClick(Sender: TObject);
begin
  RbCanhoto.Enabled := rgModelo.ItemIndex = 0;
  rbImprimirDadosDocReferenciados.Enabled := rgModelo.ItemIndex = 0;
  CBImprimirUndQtVlComercial.Enabled := rgModelo.ItemIndex = 0;

  ckImprimeItens.Enabled := rgModelo.ItemIndex = 1;

end;

end.

