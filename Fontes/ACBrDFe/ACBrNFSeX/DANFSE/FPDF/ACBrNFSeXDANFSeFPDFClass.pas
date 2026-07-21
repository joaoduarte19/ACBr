{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Elton Barbosa                                   }
{                              Leonardo Gregianin                              }
{                                                                              }
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

unit ACBrNFSeXDANFSeFPDFClass;

{$I ACBr.inc}

interface

uses
  SysUtils, 
  Classes, 
  ACBrBase, 
  ACBrNFSeXClass,
  ACBrNFSeXDANFSeClass;

type
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFSeXDANFSeFPDF = class(TACBrNFSeXDANFSeClass)
  private
    procedure ExecutaImpressaoPDFUmaNFSe(var UmaNFSe: TNFSe; AStream: TStream);
  protected
//    FPrintDialog: boolean;
//	  FDetalharServico : Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe: TNFSe = nil); override;
    procedure ImprimirDANFSePDF(NFSe: TNFSe = nil); override;
    procedure ImprimirDANFSePDF(AStream: TStream; NFSe: TNFSe = nil); overload; override;
  published
//    property PrintDialog: boolean read FPrintDialog write FPrintDialog;
//    property DetalharServico: Boolean read FDetalharServico write FDetalharServico default False;

  end;

implementation

uses
  ACBrUtil.Compatibilidade,
  ACBrUtil.FilesIO,
  ACBrNFSeX, 
  ACBrNFSeXConversao, 
  ACBr.DANFSeX.Classes, 
  ACBrNFSeXInterface,
  ACBr.DANFSeX.FPDFA4Retrato,
  ACBr.DANFSeX.FPDFPadraoNacional;

constructor TACBrNFSeXDANFSeFPDF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  MargemInferior := 0;
  MargemSuperior := 0;
  MargemEsquerda := 0;
  MargemDireita  := 0;
end;

destructor TACBrNFSeXDANFSeFPDF.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrNFSeXDANFSeFPDF.ImprimirDANFSe(NFSe: TNFSe = nil);
begin
  ImprimirDANFSePDF(NFSe);
end;

procedure TACBrNFSeXDANFSeFPDF.ExecutaImpressaoPDFUmaNFSe(var UmaNFSe: TNFSe; AStream: TStream);
var
  FProvider: IACBrNFSeXProvider;
  DadosAux: TDadosNecessariosParaDANFSeX;
  Report: TACBrDANFSeFPDFA4Retrato;
  ReportPN: TACBrDANFSeFPDFPadraoNacional;
  BLogoPref: TBytes;
  BLogoPres: TBytes;
begin
  FProvider := TACBrNFSeX(ACBrNFSe).Provider;

  FPArquivoPDF := DefinirNomeArquivo(Self.PathPDF, TACBrNFSeX(ACBrNFSe).NumID[UmaNFSe] + '-nfse.pdf',
    self.NomeDocumento);

  DadosAux := TDadosNecessariosParaDANFSeX.Create;
  try
    DadosAux.NaturezaOperacaoDescricao     := FProvider.NaturezaOperacaoDescricao(UmaNFSe.NaturezaOperacao);
    DadosAux.RegimeEspecialDescricao       := FProvider.RegimeEspecialTributacaoDescricao(UmaNFSe.RegimeEspecialTributacao);
    DadosAux.IssAReterDescricao            := FProvider.SituacaoTributariaDescricao(UmaNFSe.Servico.Valores.IssRetido);
    DadosAux.OptanteSimplesDescricao       := FProvider.SimNaoDescricao(UmaNFSe.OptanteSimplesNacional);
    DadosAux.IncentivadorCulturalDescricao := FProvider.SimNaoDescricao(UmaNFSe.IncentivadorCultural);
    DadosAux.QuebradeLinha                 := FProvider.ConfigGeral.QuebradeLinha;
    DadosAux.Detalhar                      := FProvider.ConfigGeral.DetalharServico;

    // NT 008 (DANFSe v2.0): layout proprio, obrigatorio para o Padrao Nacional.
    // Os demais provedores (leiaute municipal/ABRASF) continuam no layout antigo.
    if TACBrNFSeX(ACBrNFSe).Configuracoes.Geral.Provedor = proPadraoNacional then
    begin
      ReportPN := TACBrDANFSeFPDFPadraoNacional.Create(UmaNFSe);
      try
        ReportPN.Cancelada := Cancelada;
        ReportPN.Substituida := (UmaNFSe.SituacaoNfse = snSubstituido);
        ReportPN.Homologacao := UmaNFSe.Producao <> snSim;
        ReportPN.LogoNFSe := Self.LogoNFSe;
        ReportPN.QRCode := (Trim(UmaNFSe.infNFSe.ID) <> '') or (Trim(UmaNFSe.ChaveAcesso) <> '');

        ReportPN.CabecalhoLinha1 := Self.Prefeitura;
        ReportPN.QuebraDeLinha   := DadosAux.QuebradeLinha;
        ReportPN.MensagemRodape := Format('Impresso em %s||%s', [FormatDateTime('dd/mm/yyy HH:nn:ss', Now), Self.Sistema]);

        if Assigned(AStream) then
          ReportPN.SalvarPDF(DadosAux, AStream)
        else
          ReportPN.SalvarPDF(DadosAux, FPArquivoPDF);
      finally
        ReportPN.Free;
      end;
    end
    else
    begin
      Report := TACBrDANFSeFPDFA4Retrato.Create(UmaNFSe);
      try
        Report.Cancelada := Cancelada;
        Report.Homologacao := TACBrNFSeX(ACBrNFSe).Configuracoes.WebServices.AmbienteCodigo <> 1;
        Report.LogoPrefeitura := Trim(Self.Logo) <> '';
        Report.LogoPrestador  := Trim(Self.Prestador.Logo) <> '';
        Report.QRCode := (Trim(UmaNFSe.Link) <> '');

        if Report.LogoPrefeitura then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.Logo, BLogoPref);
          Report.LogoPrefeituraBytes := BLogoPref;
        end;

        if Report.LogoPrestador then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.Prestador.Logo, BLogoPres);
          Report.LogoPrestadorBytes := BLogoPres;
        end;

        Report.CabecalhoLinha1 := Self.Prefeitura;
        Report.QuebraDeLinha   := DadosAux.QuebradeLinha;
        Report.MensagemRodape := Format('Impresso em %s||%s', [FormatDateTime('dd/mm/yyy HH:nn:ss', Now), Self.Sistema]);

        if Assigned(AStream) then
          Report.SalvarPDF(DadosAux, AStream)
        else
          Report.SalvarPDF(DadosAux, FPArquivoPDF);
      finally
        Report.Free;
      end;
    end;
  finally
    DadosAux.Free;
  end;
end;

procedure TACBrNFSeXDANFSeFPDF.ImprimirDANFSePDF(NFSe: TNFSe);
begin
  ImprimirDANFSePDF(nil, NFSe);
end;

procedure TACBrNFSeXDANFSeFPDF.ImprimirDANFSePDF(AStream: TStream; NFSe: TNFSe);
var
  i: integer;
  UmaNFSe: TNFSe;
begin
  if NFSe = nil then
  begin
    for i := 0 to TACBrNFSeX(ACBrNFSe).NotasFiscais.Count - 1 do
    begin
      UmaNFSe := TACBrNFSeX(ACBrNFSe).NotasFiscais.Items[i].NFSe;
      ExecutaImpressaoPDFUmaNFSe(UmaNFSe, AStream);
    end;
  end
  else
  begin
    UmaNFSe := NFSe;
    ExecutaImpressaoPDFUmaNFSe(UmaNFSe, AStream);
  end;
end;

end.

