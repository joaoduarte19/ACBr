{ ****************************************************************************** }
{ Projeto: Componentes ACBr                                                      }
{ Biblioteca multiplataforma de componentes Delphi para interação com equipa-    }
{ mentos de Automação Comercial utilizados no Brasil                             }
{                                                                                }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida                 }
{                                                                                }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                           }
{                                                                                }
{ Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr       }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr        }
{                                                                                }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la    }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela    }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério)   }
{ qualquer versão posterior.                                                     }
{                                                                                }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM      }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU        }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor  }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)                }
{                                                                                }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto   }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,    }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.            }
{ Você também pode obter uma copia da licença em:                                }
{ http://www.opensource.org/licenses/lgpl-license.php                            }
{                                                                                }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br  }
{ Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170                 }
{ ****************************************************************************** }

{$I ACBr.inc}

unit ACBrNFSeXDANFSeRLPadraoNacional;

interface

uses
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  RLFilters,
  RLPDFFilter,
  RLReport,
  ACBrDelphiZXingQRCode,
  ACBrNFSeXConversao,
  ACBrNFSeXDANFSeRL;

type

  { TfrlXDANFSeRLPadraoNacional }

  TfrlXDANFSeRLPadraoNacional = class(TfrlXDANFSeRL)
    rlbBanda02_Ide_NFSe: TRLBand;
    rllNumNF0: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel12: TRLLabel;
    rllEmissaoNFSe: TRLLabel;
    RLLabel7: TRLLabel;
    rllCompetencia: TRLLabel;
    RLLabel18: TRLLabel;
    rllNumeroDPS: TRLLabel;
    rlbBanda03_Emitente: TRLBand;
    RLLabel30: TRLLabel;
    RLLabel32: TRLLabel;
    rllEmitenteInscMunicipal: TRLLabel;
    rllEmitenteCNPJ: TRLLabel;
    RLLabel1: TRLLabel;
    rllEmitenteNome: TRLLabel;
    rlbBanda04_Tomador: TRLBand;
    rllTomaCNPJ: TRLLabel;
    rllTomaInscMunicipal: TRLLabel;
    rllTomaNome: TRLLabel;
    rllTomaEndereco: TRLLabel;
    rllTomaMunicipio: TRLLabel;
    rllTomaEmail: TRLLabel;
    rllTomaTelefone: TRLLabel;
    rlbBanda06_ServicoPrestado: TRLBand;
    RLLabel14: TRLLabel;
    rlbBanda13_InformacoesComplementares: TRLBand;
    rlmDadosAdicionais: TRLMemo;
    RLLabel6: TRLLabel;
    rlbBanda07_ItensDetalhado: TRLBand;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    rlbBanda08_SubItens: TRLSubDetail;
    rlbBanda08_ItensServico: TRLBand;
    txtServicoQtde: TRLLabel;
    rlmServicoDescricao: TRLMemo;
    txtServicoUnitario: TRLLabel;
    txtServicoTotal: TRLLabel;
    rlbBanda14_Sistema: TRLBand;
    rllDataHoraImpressao: TRLLabel;
    rllSistema: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel9: TRLLabel;
    txtBaseCalculo: TRLLabel;
    txtISS: TRLLabel;
    rlbBanda09_TributacaoMunicipal: TRLBand;
    rlbBanda01_Logos: TRLBand;
    RLLabel74: TRLLabel;
    RLLabel8: TRLLabel;
    rliLogoNFSe: TRLImage;
    rliLogoPref: TRLImage;
    rlmPrefeitura: TRLMemo;
    rllCodigoChave: TRLLabel;
    rllChaveAcesso: TRLLabel;
    RLLabel16: TRLLabel;
    rllSerieDPS: TRLLabel;
    RLLabel22: TRLLabel;
    rllEmissaoDPS: TRLLabel;
    RLMemo1: TRLMemo;
    RLLabel23: TRLLabel;
    RLLabel2: TRLLabel;
    rllEmitenteTelefone: TRLLabel;
    RLLabel24: TRLLabel;
    rllEmitenteEndereco: TRLLabel;
    RLLabel29: TRLLabel;
    rllEmitenteEmail: TRLLabel;
    RLLabel31: TRLLabel;
    rllEmitenteMunicipio: TRLLabel;
    RLLabel55: TRLLabel;
    rllEmitenteCEP: TRLLabel;
    RLLabel60: TRLLabel;
    rllEmitenteSimplesNacional: TRLLabel;
    RLLabel69: TRLLabel;
    rllEmitenteRegimeApuracao: TRLLabel;
    rllEmitente: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    rllTomaCEP: TRLLabel;
    rlbBanda05_Intermediario: TRLBand;
    rllInterCNPJ: TRLLabel;
    rllInterInscMunicipal: TRLLabel;
    rllInterNome: TRLLabel;
    rllInterEndereco: TRLLabel;
    rllInterMunicipio: TRLLabel;
    rllInterEmail: TRLLabel;
    rllInterTelefone: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    rllInterCEP: TRLLabel;
    rllIntermediarioNaoIdentificado: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel92: TRLLabel;
    rllLocalPrestacao: TRLLabel;
    RLLabel94: TRLLabel;
    rllPaisPrestacao: TRLLabel;
    RLLabel96: TRLLabel;
    rlmDescServico: TRLMemo;
    rlmCodTribNac: TRLMemo;
    rlmCodTribMun: TRLMemo;
    rllMsgTeste: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    rllTribISSQN: TRLLabel;
    RLLabel17: TRLLabel;
    rllTipoImunidade: TRLLabel;
    RLLabel20: TRLLabel;
    rllValorServico: TRLLabel;
    RLLabel25: TRLLabel;
    rllValorBCISSQN: TRLLabel;
    RLLabel64: TRLLabel;
    rllPaisResult: TRLLabel;
    RLLabel90: TRLLabel;
    rllSuspensao: TRLLabel;
    RLLabel93: TRLLabel;
    rllValorDescIncond: TRLLabel;
    RLLabel97: TRLLabel;
    rllAliquotaAplicada: TRLLabel;
    RLLabel99: TRLLabel;
    rllMunicipioIncidencia: TRLLabel;
    RLLabel101: TRLLabel;
    rllNumeroProcesso: TRLLabel;
    RLLabel103: TRLLabel;
    rllValorTotalDedRed: TRLLabel;
    RLLabel105: TRLLabel;
    rllRetencaoISSQN: TRLLabel;
    RLLabel107: TRLLabel;
    rllRegimeEspecial: TRLLabel;
    RLLabel109: TRLLabel;
    rllBeneficioMunic: TRLLabel;
    RLLabel111: TRLLabel;
    rllCalculoBM: TRLLabel;
    RLLabel113: TRLLabel;
    rllValorISSQNApurado: TRLLabel;
    rlbBanda10_TributacaoFederal: TRLBand;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    rllValorIRRF: TRLLabel;
    RLLabel118: TRLLabel;
    rllValorPIS: TRLLabel;
    RLLabel124: TRLLabel;
    rllValorCP: TRLLabel;
    RLLabel126: TRLLabel;
    rllValorCOFINS: TRLLabel;
    RLLabel132: TRLLabel;
    rllValorCSLL: TRLLabel;
    RLLabel134: TRLLabel;
    rllDescCSLL: TRLLabel;
    rlbBanda11_ValorTotaNFSe: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel26: TRLLabel;
    rllValorTotalServico: TRLLabel;
    RLLabel35: TRLLabel;
    rllValorTotalDescCond: TRLLabel;
    RLLabel37: TRLLabel;
    rllValorTotalPISCOFINSRet: TRLLabel;
    RLLabel39: TRLLabel;
    rllValorTotalDescIncond: TRLLabel;
    RLLabel41: TRLLabel;
    rllValorTotalISSQNRetido: TRLLabel;
    RLLabel43: TRLLabel;
    rllValorTotalLiq: TRLLabel;
    rlbBanda12_TotaisAproximados: TRLBand;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    rllTotaisAproxTribFed: TRLLabel;
    RLLabel50: TRLLabel;
    rllTotaisAproxTribEst: TRLLabel;
    RLLabel54: TRLLabel;
    rllTotaisAproxTribMun: TRLLabel;
    RLLabel145: TRLLabel;
    rllValorTotalTribFed: TRLLabel;

    procedure RLNFSeBeforePrint(Sender: TObject; var PrintIt: Boolean);

    procedure rlbBanda01_LogosBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda02_Ide_NFSeBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda03_EmitenteBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda04_TomadorBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda05_IntermediarioBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda06_ServicoPrestadoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);

    procedure rlbBanda08_ItensServicoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda08_SubItensDataRecord(Sender: TObject; RecNo: Integer;
      CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);

    procedure rlbBanda09_TributacaoMunicipalBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda10_TributacaoFederalBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda11_ValorTotaNFSeBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda12_TotaisAproximadosBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda13_InformacoesComplementaresBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda14_SistemaBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
    FNumItem: Integer;
  public
    { Public declarations }
    class procedure QuebradeLinha(const sQuebradeLinha: String); override;
  end;

var
  frlXDANFSeRLPadraoNacional: TfrlXDANFSeRLPadraoNacional;

implementation

uses
  StrUtils, DateUtils,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrDFeUtil,
  ACBrNFSeX,
  ACBrNFSeXClass,
  ACBrNFSeXInterface,
  ACBrValidador,
  ACBrDFeReportFortes;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

var
  FQuebradeLinha: String;

  { TfrlXDANFSeRLPadraoNacional }

class procedure TfrlXDANFSeRLPadraoNacional.QuebradeLinha(const sQuebradeLinha: String);
begin
  FQuebradeLinha := sQuebradeLinha;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda01_LogosBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  TDFeReportFortes.CarregarLogo(rliLogoNFSe, fpDANFSe.LogoNFSe);
  TDFeReportFortes.CarregarLogo(rliLogoPref, fpDANFSe.Logo);

  if (fpDANFSe.TamanhoLogoHeight = 0) and (fpDANFSe.TamanhoLogoWidth = 0) then
  begin
    // Expande a logomarca
    if fpDANFSe.ExpandeLogoMarca then
    begin
      rlmPrefeitura.Visible := False;

      with rliLogoPref do
      begin
        Height := 130;
        Width := 580;
        Top := 9;
        Left := 9;

        TDFeReportFortes.AjustarLogo(rliLogoPref, fpDANFSe.ExpandeLogoMarcaConfig);
      end;
    end;
  end;

  rlmPrefeitura.Lines.Clear;
  rlmPrefeitura.Lines.Add(StringReplace(fpDANFSe.Prefeitura,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda02_Ide_NFSeBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  QrCode: TDelphiZXingQRCode;
  QrCodeBitmap: TBitmap;
  QRCodeData: string;
  rlImgQrCode: TRLImage;
  Row, Column: Integer;
begin
  inherited;

  rllChaveAcesso.Caption := ACBrStr(fpNFSe.CodigoVerificacao);
  rllNumNF0.Caption := fpNFSe.Numero;
  rllNumeroDPS.Caption := fpNFSe.IdentificacaoRps.Numero;
  rllCompetencia.Caption := IfThen(fpNFSe.Competencia > 0, FormatDateTime('dd/mm/yyyy', fpNFSe.Competencia), '');
  rllSerieDPS.Caption := fpNFSe.IdentificacaoRps.Serie;
  rllEmissaoNFSe.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', fpNFSe.DataEmissao);
  rllEmissaoDPS.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', fpNFSe.DataEmissaoRPS);

  if fpNFSe.Link <> '' then
  begin
    rlImgQrCode := TRLImage.Create(rlbBanda02_Ide_NFSe);
    rlImgQrCode.Parent := rlbBanda02_Ide_NFSe;
    rlImgQrCode.Stretch := True;
    rlImgQrCode.AutoSize := False;
    rlImgQrCode.Center := True;
    rlImgQrCode.SetBounds(648, 3, 90, 90);
    rlImgQrCode.BringToFront;

    QRCodeData := fpNFSe.Link;
    QrCode := TDelphiZXingQRCode.Create;
    QrCodeBitmap := TBitmap.Create;
    try
      QrCode.Encoding := qrUTF8NoBOM;
      QrCode.QuietZone := 1;
      QrCode.Data := WideString(QRCodeData);

      QrCodeBitmap.Width := QrCode.Columns;
      QrCodeBitmap.Height := QrCode.Rows;

      for Row := 0 to QrCode.Rows - 1 do
      begin
        for Column := 0 to QrCode.Columns - 1 do
        begin
          if (QrCode.IsBlack[Row, Column]) then
            QrCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
          else
            QrCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
        end;
      end;

      rlImgQrCode.Picture.Bitmap.Assign(QrCodeBitmap);
    finally
      QrCode.Free;
      QrCodeBitmap.Free;
    end;
  end;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda03_EmitenteBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  case fpNFSe.tpEmit of
    tePrestador: rllEmitente.Caption := ACBrStr('Prestador do Serviço');
    teTomador: rllEmitente.Caption := ACBrStr('Tomador do Serviço');
  else
    // teIntermediario
    rllEmitente.Caption := ACBrStr('Intermediário do Serviço');
  end;

  rllEmitenteNome.Caption := fpNFSe.infNFSe.emit.RazaoSocial;
  rllEmitenteEndereco.Caption := fpNFSe.infNFSe.emit.Endereco.Endereco + ', ' +
                                 fpNFSe.infNFSe.emit.Endereco.Numero + ', ' +
                                 fpNFSe.infNFSe.emit.Endereco.Bairro;

  case fpNFSe.OptanteSN of
    osnNaoOptante:
      rllEmitenteSimplesNacional.Caption := 'Não Optante';
    osnOptanteMEI:
      rllEmitenteSimplesNacional.Caption := 'Optante - Microempreendedor Individual (MEI)';
  else
    // osnOptanteMEEPP
    rllEmitenteSimplesNacional.Caption := 'Optante - MicroEmpresa EPP';
  end;

  if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
    rllEmitenteCNPJ.Caption := fpNFSe.infNFSe.emit.Identificacao.Nif
  else
    rllEmitenteCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.infNFSe.emit.Identificacao.CpfCnpj);

  rllEmitenteInscMunicipal.Caption := fpNFSe.infNFSe.emit.Identificacao.InscricaoMunicipal;
  rllEmitenteEmail.Caption := fpNFSe.infNFSe.emit.Contato.Email;
  rllEmitenteMunicipio.Caption := fpNFSe.infNFSe.emit.Endereco.xMunicipio + ' - ' +
                                  fpNFSe.infNFSe.emit.Endereco.UF;

  if fpNFSe.OptanteSN = osnOptanteMEEPP then
  begin
    case fpNFSe.RegimeApuracaoSN of
      raFederaisMunicipalpeloSN:
        rllEmitenteRegimeApuracao.Caption := 'Federais e Municipal pelo SN';
      raFederaisSN:
        rllEmitenteRegimeApuracao.Caption := 'Federais pelo SN';
    else
      // raFederaisMunicipalforaSN
      rllEmitenteRegimeApuracao.Caption := 'Federais e Municipal fora SN';
    end;
  end
  else
    rllEmitenteRegimeApuracao.Caption := '-';

  rllEmitenteTelefone.Caption := FormatarFone(fpNFSe.infNFSe.emit.Contato.Telefone);
  rllEmitenteCEP.Caption := fpNFSe.infNFSe.emit.Endereco.CEP;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda04_TomadorBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllTomaNome.Caption := fpNFSe.Tomador.RazaoSocial;
  rllTomaEndereco.Caption := fpNFSe.Tomador.Endereco.Endereco + ', ' +
                                 fpNFSe.Tomador.Endereco.Numero + ', ' +
                                 fpNFSe.Tomador.Endereco.Bairro;

  if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
    rllTomaCNPJ.Caption := fpNFSe.Tomador.IdentificacaoTomador.Nif
  else
    rllTomaCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.Tomador.IdentificacaoTomador.CpfCnpj);

  rllTomaInscMunicipal.Caption := fpNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal;
  rllTomaEmail.Caption := fpNFSe.Tomador.Contato.Email;
  rllTomaMunicipio.Caption := fpNFSe.Tomador.Endereco.xMunicipio + ' - ' +
                                  fpNFSe.Tomador.Endereco.UF;
  rllTomaTelefone.Caption := FormatarFone(fpNFSe.Tomador.Contato.Telefone);
  rllTomaCEP.Caption := fpNFSe.Tomador.Endereco.CEP;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda05_IntermediarioBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllIntermediarioNaoIdentificado.Visible := True;
  rlbBanda05_Intermediario.Height := 20;
  RLLabel81.Visible := False;
  RLLabel84.Visible := False;
  RLLabel85.Visible := False;
  RLLabel88.Visible := False;

  rllInterNome.Caption := '';
  rllInterEndereco.Caption := '';
  rllInterCNPJ.Caption := '';
  rllInterInscMunicipal.Caption := '';
  rllInterEmail.Caption := '';
  rllInterMunicipio.Caption := '';
  rllInterTelefone.Caption := '';
  rllInterCEP.Caption := '';

  if fpNFSe.Intermediario.RazaoSocial <> '' then
  begin
    rllIntermediarioNaoIdentificado.Visible := False;
    rlbBanda05_Intermediario.Height := 99;
    RLLabel81.Visible := True;
    RLLabel84.Visible := True;
    RLLabel85.Visible := True;
    RLLabel88.Visible := True;

    rllInterNome.Caption := fpNFSe.Intermediario.RazaoSocial;
    rllInterEndereco.Caption := fpNFSe.Intermediario.Endereco.Endereco + ', ' +
                                   fpNFSe.Intermediario.Endereco.Numero + ', ' +
                                   fpNFSe.Intermediario.Endereco.Bairro;

    if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
      rllInterCNPJ.Caption := fpNFSe.Intermediario.Identificacao.Nif
    else
      rllInterCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.Intermediario.Identificacao.CpfCnpj);

    rllInterInscMunicipal.Caption := fpNFSe.Intermediario.Identificacao.InscricaoMunicipal;
    rllInterEmail.Caption := fpNFSe.Intermediario.Contato.Email;
    rllInterMunicipio.Caption := fpNFSe.Intermediario.Endereco.xMunicipio + ' - ' +
                                    fpNFSe.Intermediario.Endereco.UF;
    rllInterTelefone.Caption := FormatarFone(fpNFSe.Intermediario.Contato.Telefone);
    rllInterCEP.Caption := fpNFSe.Intermediario.Endereco.CEP;
  end;
end;
procedure TfrlXDANFSeRLPadraoNacional.rlbBanda06_ServicoPrestadoBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rlmCodTribNac.Lines.Clear;
  rlmCodTribNac.Lines.Add(fpNFSe.Servico.ItemListaServico + ' - ' +
                          fpNFSe.Servico.xItemListaServico);

  rlmDescServico.Lines.Clear;
  rlmDescServico.Lines.Add(fpNFSe.Servico.Discriminacao);

  rlmCodTribMun.Lines.Clear;
  rlmCodTribMun.Lines.Add(fpNFSe.Servico.CodigoTributacaoMunicipio + ' - ' +
                          fpNFSe.infNFSe.xTribMun);

  rllLocalPrestacao.Caption := fpNFSe.Servico.MunicipioPrestacaoServico;
  rllPaisPrestacao.Caption := CodIBGEPaisToDescricao(fpNFSe.Servico.CodigoPais);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda08_SubItensDataRecord(Sender: TObject;
  RecNo: Integer; CopyNo: Integer; var Eof: Boolean;
  var RecordAction: TRLRecordAction);
begin
  inherited;

  FNumItem := RecNo - 1;
  Eof := (RecNo > fpNFSe.Servico.ItemServico.Count);
  RecordAction := raUseIt;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda08_ItensServicoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  with fpNFSe.Servico.ItemServico.Items[FNumItem] do
  begin
    rlmServicoDescricao.Lines.Clear;
    rlmServicoDescricao.Lines.Add(Descricao);
    txtServicoUnitario.Caption := FormatFloatBr(ValorUnitario);
    txtServicoQtde.Caption := FormatFloatBr(Quantidade);
    txtServicoTotal.Caption := FormatFloatBr(ValorTotal);
    txtBaseCalculo.Caption := FormatFloatBr(BaseCalculo);

    txtISS.Caption := FormatFloatBr(ValorISS);
  end;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda09_TributacaoMunicipalBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  LvDedRed: Double;
  i: Integer;
begin
  inherited;

  case fpNFSe.Servico.Valores.tribMun.tribISSQN of
    tiOperacaoTributavel:
      rllTribISSQN.Caption := 'Operaçãoo Tributável';
    tiImunidade:
      rllTribISSQN.Caption := 'Imunidade';
    tiExportacao:
      rllTribISSQN.Caption := 'Exportação';
  else
    // tiNaoIncidencia
    rllTribISSQN.Caption := 'Não Incidência';
  end;

  case fpNFSe.Servico.Valores.tribMun.tpImunidade of
    timImunidade:
      rllTipoImunidade.Caption := 'Imunidade';
    timPatrimonio:
      rllTipoImunidade.Caption := 'Patrimonio';
    timTemplos:
      rllTipoImunidade.Caption := 'Templos';
    timPatrimonioPartidos:
      rllTipoImunidade.Caption := 'Patrimonio Partidos';
    timLivros:
      rllTipoImunidade.Caption := 'Livros';
    timFonogramas:
      rllTipoImunidade.Caption := 'Fonogramas';
  else
    // timNenhum
    rllTipoImunidade.Caption := '-';
  end;

  rllValorServico.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.ValorServicos);

  if fpNFSe.infNFSe.Valores.BaseCalculo > 0 then
    rllValorBCISSQN.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.BaseCalculo)
  else
    rllValorBCISSQN.Caption := '-';

  if fpNFSe.Servico.Valores.tribMun.cPaisResult > 0 then
    rllPaisResult.Caption := CodIBGEPaisToSiglaISO2(fpNFSe.Servico.Valores.tribMun.cPaisResult)
  else
    rllPaisResult.Caption := '-';

  case fpNFSe.Servico.Valores.tribMun.tpSusp of
    tsDecisaoJudicial:
      rllSuspensao.Caption := 'Decisão Judicial';
    tsProcessoAdm:
      rllSuspensao.Caption := 'Processo Administrativo';
  else
    // tsNenhum
    rllSuspensao.Caption := 'Não';
  end;

  if fpNFSe.Servico.Valores.DescontoIncondicionado > 0 then
    rllValorDescIncond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoIncondicionado)
  else
    rllValorDescIncond.Caption := '-';

  if fpNFSe.infNFSe.Valores.Aliquota > 0 then
    rllAliquotaAplicada.Caption := FormatFloatBr(fpNFSe.infNFSe.Valores.Aliquota) + '%'
  else
    rllAliquotaAplicada.Caption := '-';

  if fpNFSe.infNFSe.xLocIncid <> '' then
    rllMunicipioIncidencia.Caption := fpNFSe.infNFSe.xLocIncid
  else
    rllMunicipioIncidencia.Caption := 'Nenhum';

  if fpNFSe.Servico.Valores.tribMun.nProcesso <> '' then
    rllNumeroProcesso.Caption := fpNFSe.Servico.Valores.tribMun.nProcesso
  else
    rllNumeroProcesso.Caption := '-';

  LvDedRed := 0;
  for i := 0 to fpNFSe.Servico.Valores.DocDeducao.Count -1 do
    LvDedRed := LvDedRed + fpNFSe.Servico.Valores.DocDeducao[i].vDeducaoReducao;

  if fpNFSe.Servico.Valores.DescontoIncondicionado > 0 then
    rllValorTotalDedRed.Caption := 'R$ ' + FormatFloatBr(LvDedRed)
  else
    rllValorTotalDedRed.Caption := '-';

  case fpNFSe.Servico.Valores.tribMun.tpRetISSQN of
    trRetidoPeloTomador:
      rllRetencaoISSQN.Caption := 'Retido Pelo Tomador';
    trRetidoPeloIntermediario:
      rllRetencaoISSQN.Caption := 'Retido Pelo Intermediário';
  else
    // trNaoRetido
    rllRetencaoISSQN.Caption := 'Não Retido';
  end;

  case fpNFSe.RegimeEspecialTributacao of
    retCooperativa:
      rllRegimeEspecial.Caption := 'Cooperativa';
    retEstimativa:
      rllRegimeEspecial.Caption := 'Estimativa';
    retMicroempresaMunicipal:
      rllRegimeEspecial.Caption := 'Microempresa Municipal';
    retNotarioRegistrador:
      rllRegimeEspecial.Caption := 'Notario Registrador';
    retISSQNAutonomos:
      rllRegimeEspecial.Caption := 'Autonomos';
    retSociedadeProfissionais:
      rllRegimeEspecial.Caption := 'Sociedade Profissionais';
    retOutros:
      rllRegimeEspecial.Caption := 'Outros';
  else
    // retNenhum
    rllRegimeEspecial.Caption := 'Nenhum';
  end;

  if fpNFSe.Servico.Valores.tribMun.nBM <> '' then
    rllBeneficioMunic.Caption := fpNFSe.Servico.Valores.tribMun.nBM
  else
    rllBeneficioMunic.Caption := '-';

  if fpNFSe.infNFSe.Valores.vCalcBM > 0 then
    rllCalculoBM.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.vCalcBM)
  else
    rllValorISSQNApurado.Caption := '-';

  if fpNFSe.infNFSe.Valores.ValorIss > 0 then
    rllValorISSQNApurado.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.ValorIss)
  else
    rllValorISSQNApurado.Caption := '-';
end;


procedure TfrlXDANFSeRLPadraoNacional.rlbBanda10_TributacaoFederalBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  if fpNFSe.Servico.Valores.tribFed.vRetIRRF > 0 then
    rllValorIRRF.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vRetIRRF)
  else
    rllValorIRRF.Caption := '-';

  if fpNFSe.Servico.Valores.tribFed.vPis > 0 then
    rllValorPIS.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vPis)
  else
    rllValorPIS.Caption := '-';

  if fpNFSe.Servico.Valores.tribFed.vRetCP > 0 then
    rllValorCP.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vRetCP)
  else
    rllValorCP.Caption := '-';

  if fpNFSe.Servico.Valores.tribFed.vCofins > 0 then
    rllValorCOFINS.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vCofins)
  else
    rllValorCOFINS.Caption := '-';

  if fpNFSe.Servico.Valores.tribFed.vRetCSLL > 0 then
    rllValorCSLL.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vRetCSLL)
  else
    rllValorCSLL.Caption := '-';

//  if fpNFSe.Servico.Valores.tribFed.???? > 0 then
//    rllDescCSLL.Caption := fpNFSe.Servico.Valores.tribFed.????
//  else
    rllDescCSLL.Caption := '-';
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda11_ValorTotaNFSeBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  LValor: Double;
begin
  inherited;

  if fpNFSe.Servico.Valores.ValorServicos > 0 then
    rllValorTotalServico.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.ValorServicos)
  else
    rllValorTotalServico.Caption := '-';

  if fpNFSe.Servico.Valores.RetencoesFederais > 0 then
    rllValorTotalTribFed.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.RetencoesFederais)
  else
    rllValorTotalTribFed.Caption := '-';

  if fpNFSe.Servico.Valores.DescontoCondicionado > 0 then
    rllValorTotalDescCond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoCondicionado)
  else
    rllValorTotalDescCond.Caption := '-';

  LValor := fpNFSe.Servico.Valores.tribFed.vPis +
            fpNFSe.Servico.Valores.tribFed.vCofins;

  if LValor > 0 then
    rllValorTotalPISCOFINSRet.Caption := 'R$ ' + FormatFloatBr(LValor)
  else
    rllValorTotalPISCOFINSRet.Caption := '-';

  if fpNFSe.Servico.Valores.DescontoIncondicionado > 0 then
    rllValorTotalDescIncond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoIncondicionado)
  else
    rllValorTotalDescIncond.Caption := '-';

  if fpNFSe.Servico.Valores.ValorIssRetido > 0 then
    rllValorTotalISSQNRetido.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.ValorIssRetido)
  else
    rllValorTotalISSQNRetido.Caption := '-';

  if fpNFSe.infNFSe.valores.ValorLiquidoNfse > 0 then
    rllValorTotalLiq.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.valores.ValorLiquidoNfse)
  else
    rllValorTotalLiq.Caption := '-';
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda12_TotaisAproximadosBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  if fpNFSe.Servico.Valores.totTrib.vTotTribFed > 0 then
    rllTotaisAproxTribFed.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribFed)
  else
    rllTotaisAproxTribFed.Caption := '-';

  if fpNFSe.Servico.Valores.totTrib.vTotTribEst > 0 then
    rllTotaisAproxTribEst.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribEst)
  else
    rllTotaisAproxTribEst.Caption := '-';

  if fpNFSe.Servico.Valores.totTrib.vTotTribMun > 0 then
    rllTotaisAproxTribMun.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribMun)
  else
    rllTotaisAproxTribMun.Caption := '-';
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda13_InformacoesComplementaresBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rlmDadosAdicionais.Lines.BeginUpdate;
  rlmDadosAdicionais.Lines.Clear;

  if fpNFSe.Servico.CodigoNBS <> '' then
    rlmDadosAdicionais.Lines.Append(ACBrStr('NBS: ') + fpNFSe.Servico.CodigoNBS);

  {
  if fpNFSe.Servico.MunicipioIncidencia <> 0 then
    rlmDadosAdicionais.Lines.Add('Cod/Municipio da incidencia do ISSQN: ' +
      IntToStr(fpNFSe.Servico.MunicipioIncidencia) + ' / ' +
      fpNFSe.Servico.xMunicipioIncidencia);

  if fpDANFSe.OutrasInformacaoesImp <> '' then
    rlmDadosAdicionais.Lines.Add(StringReplace(fpDANFSe.OutrasInformacaoesImp,
                                        FQuebradeLinha, #13#10, [rfReplaceAll]))
  else
    if fpNFSe.OutrasInformacoes <> '' then
      rlmDadosAdicionais.Lines.Add(StringReplace(fpNFSe.OutrasInformacoes,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));

  if fpNFSe.InformacoesComplementares <> '' then
    rlmDadosAdicionais.Lines.Add(StringReplace(fpNFSe.InformacoesComplementares,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));
  }

  rlmDadosAdicionais.Lines.EndUpdate;

  rllMsgTeste.Visible := (fpDANFSe.Producao = snNao);
  rllMsgTeste.Enabled := (fpDANFSe.Producao = snNao);

  if fpDANFSe.Cancelada or (fpNFSe.NfseCancelamento.DataHora <> 0) or
    (fpNFSe.SituacaoNfse = snCancelado) or (fpNFSe.StatusRps = srCancelado) then
  begin
    rllMsgTeste.Caption := 'NFS-e CANCELADA';
    rllMsgTeste.Visible := True;
    rllMsgTeste.Enabled := True;
  end;

  rllMsgTeste.Repaint;

  // Exibe canhoto
//  rlbCanhoto.Visible := fpDANFSe.ImprimeCanhoto;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda14_SistemaBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllDataHoraImpressao.Visible := NaoEstaVazio(fpDANFSe.Usuario);
  rllDataHoraImpressao.Caption := ACBrStr('DATA / HORA DA IMPRESSÃO: ') +
                               FormatDateTimeBr(Now) + ' - ' + fpDANFSe.Usuario;

  rllSistema.Visible := NaoEstaVazio(fpDANFSe.Sistema);
  rllSistema.Caption := Format('Desenvolvido por %s', [fpDANFSe.Sistema]);
end;

procedure TfrlXDANFSeRLPadraoNacional.RLNFSeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  Detalhar: Boolean;
begin
  inherited;

  Detalhar := ACBrNFSe.Provider.ConfigGeral.DetalharServico;

  RLNFSe.Title := 'NFS-e: ' + fpNFSe.Numero;
  TDFeReportFortes.AjustarMargem(RLNFSe, fpDANFSe);
  rlmDescServico.Visible := not Detalhar;
  rlbBanda07_ItensDetalhado.Visible := Detalhar;
  rlbBanda08_SubItens.Visible := Detalhar;
end;

end.
