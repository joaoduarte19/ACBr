{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Daniel Morais                                   }
{                                                                              }
{                                                                              }
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

{$I ACBr.inc}

unit ACBrNFeDANFeRLRTC;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  ACBrNFe.Classes,
  ACBrNFeDANFeRTC,
  ACBrNFeDANFeRLClass,
  RLReport,
  RLPDFFilter,
  RLFilters;

type

  { TfrlDANFeRLRTC }

  TfrlDANFeRLRTC = class(TForm)
    RLNFe: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure AdicionaInformacaoPDF;
    procedure AjustarEscala;
    class function CriarReport(ADANFe: TACBrNFeDANFeRL; ANFe: TNFe): TfrlDANFeRLRTC;
  protected
    fpNFe: TNFe;
    fpDANFe: TACBrNFeDANFeRL;
    fpRTC: TACBrNFeDANFeRTC;
  public
    class procedure Imprimir(ADANFe: TACBrNFeDANFeRL; ANotas: array of TNFe);
    class procedure SalvarPDF(ADANFe: TACBrNFeDANFeRL; ANFe: TNFe; const AFile: String); overload;
    class procedure SalvarPDF(ADANFe: TACBrNFeDANFeRL; ANFe: TNFe; AStream: TStream); overload;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrDFeReportFortes;

{$IfNDef FPC}
 {$R *.dfm}
{$Else}
 {$R *.lfm}
{$EndIf}

{ TfrlDANFeRLRTC }

class function TfrlDANFeRLRTC.CriarReport(ADANFe: TACBrNFeDANFeRL;
  ANFe: TNFe): TfrlDANFeRLRTC;
begin
  Result := Create(nil);
  try
    Result.fpNFe := ANFe;
    Result.fpDANFe := ADANFe;
    Result.fpRTC := TACBrNFeDANFeRTC.Create(ANFe);
    Result.AjustarEscala;
  except
    Result.Free;
    raise;
  end;
end;

procedure TfrlDANFeRLRTC.AdicionaInformacaoPDF;
var
  LNNF: String;
begin
  if fpDANFe.FormatarNumeroDocumento then
    LNNF := FormatFloat('000,000,000', fpNFe.Ide.nNF)
  else
    LNNF := IntToStr(fpNFe.Ide.nNF);

  RLPDFFilter1.DocumentInfo.Title := ACBrStr('DANFE - Nota fiscal nº ') + LNNF;
  RLPDFFilter1.DocumentInfo.KeyWords := ACBrStr('Número:') + LNNF +
    ACBrStr('; Data de emissão: ') + FormatDateBr(fpNFe.Ide.dEmi) + ACBrStr('; Destinatário: ') + fpNFe.Dest.xNome +
    '; CNPJ: ' + fpNFe.Dest.CNPJCPF + '; Valor total: ' + FormatFloatBr(fpNFe.Total.ICMSTot.vNF);
end;

procedure TfrlDANFeRLRTC.AjustarEscala;
begin
  if fpDANFe.AlterarEscalaPadrao then
  begin
    Scaled := False;
    ScaleBy(fpDANFe.NovaEscala, Screen.PixelsPerInch);
  end;
end;

class procedure TfrlDANFeRLRTC.Imprimir(ADANFe: TACBrNFeDANFeRL; ANotas: array of TNFe);
var
  I: Integer;
  LReport: TRLReport;
  LReportNext: TRLCustomReport;
  LReports: array of TfrlDANFeRLRTC;
begin
  if (Length(ANotas) < 1) then
    Exit;

  SetLength(LReports, Length(ANotas));
  try
    for I := 0 to High(ANotas) do
    begin
      LReports[I] := CriarReport(ADANFe, ANotas[I]);
      LReports[I].RLNFe.CompositeOptions.ResetPageNumber := True;
    end;

    LReport := LReports[0].RLNFe;
    for I := 1 to High(LReports) do
    begin
      LReportNext := LReport;
      while (LReportNext.NextReport <> nil) do
        LReportNext := LReportNext.NextReport;

      LReportNext.NextReport := LReports[I].RLNFe;
    end;

    TDFeReportFortes.AjustarReport(LReport, ADANFe);

    if ADANFe.MostraPreview then
    begin
      SelectedFilter := LReports[High(LReports)].RLPDFFilter1;
      LReport.PreviewModal;
    end
    else
      LReport.Print;
  finally
    for I := 0 to High(LReports) do
      FreeAndNil(LReports[I]);

    SetLength(LReports, 0);
  end;
end;

class procedure TfrlDANFeRLRTC.SalvarPDF(ADANFe: TACBrNFeDANFeRL; ANFe: TNFe;
  const AFile: String);
var
  LDANFeReport: TfrlDANFeRLRTC;
begin
  LDANFeReport := CriarReport(ADANFe, ANFe);
  try
    TDFeReportFortes.AjustarReport(LDANFeReport.RLNFe, ADANFe);
    TDFeReportFortes.AjustarFiltroPDF(LDANFeReport.RLPDFFilter1, ADANFe, AFile);

    LDANFeReport.AdicionaInformacaoPDF;

    LDANFeReport.RLNFe.Prepare;
    LDANFeReport.RLPDFFilter1.FilterPages(LDANFeReport.RLNFe.Pages);
  finally
    FreeAndNil(LDANFeReport);
  end;
end;

class procedure TfrlDANFeRLRTC.SalvarPDF(ADANFe: TACBrNFeDANFeRL; ANFe: TNFe;
  AStream: TStream);
var
  LDANFeReport: TfrlDANFeRLRTC;
begin
  LDANFeReport := CriarReport(ADANFe, ANFe);
  try
    TDFeReportFortes.AjustarReport(LDANFeReport.RLNFe, ADANFe);
    LDANFeReport.RLPDFFilter1.ShowProgress := ADANFe.MostraStatus;

    LDANFeReport.AdicionaInformacaoPDF;

    LDANFeReport.RLNFe.Prepare;
    LDANFeReport.RLPDFFilter1.FilterPages(LDANFeReport.RLNFe.Pages, AStream);
  finally
    FreeAndNil(LDANFeReport);
  end;
end;

procedure TfrlDANFeRLRTC.FormCreate(Sender: TObject);
begin
  {$IfNDef FPC}
  Self.Scaled := False;
  {$EndIf}
end;

procedure TfrlDANFeRLRTC.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fpRTC);
end;

end.
