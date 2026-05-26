{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Elton Barbosa                                   }
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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe: TNFSe = nil); override;
    procedure ImprimirDANFSePDF(NFSe: TNFSe = nil); override;
    procedure ImprimirDANFSePDF(AStream: TStream; NFSe: TNFSe = nil); overload; override;
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
  LA4Retrato: TACBrDANFSeFPDFA4Retrato;
  LPadraoNacional : TACBrDANFSeFPDFPadraoNacional;
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

    if Self.TipoDANFSE = tpGeral then
    begin
      LA4Retrato := TACBrDANFSeFPDFA4Retrato.Create(UmaNFSe);
      try
        LA4Retrato.Cancelada := Cancelada;
        LA4Retrato.Homologacao := TACBrNFSeX(ACBrNFSe).Configuracoes.WebServices.AmbienteCodigo <> 1;
        LA4Retrato.LogoPrefeitura := Trim(Self.Logo) <> '';
        LA4Retrato.LogoPrestador  := Trim(Self.Prestador.Logo) <> '';
        LA4Retrato.QRCode := (Trim(UmaNFSe.Link) <> '');

        if LA4Retrato.LogoPrefeitura then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.Logo, BLogoPref);
          LA4Retrato.LogoPrefeituraBytes := BLogoPref;
        end;

        if LA4Retrato.LogoPrestador then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.Prestador.Logo, BLogoPres);
          LA4Retrato.LogoPrestadorBytes := BLogoPres;
        end;

        LA4Retrato.CabecalhoLinha1 := Self.Prefeitura;
        LA4Retrato.QuebraDeLinha   := DadosAux.QuebradeLinha;
        LA4Retrato.MensagemRodape := Format('Impresso em %s||%s', [FormatDateTime('dd/mm/yyy HH:nn:ss', Now), Self.Sistema]);

        if Assigned(AStream) then
          LA4Retrato.SalvarPDF(DadosAux, AStream)
        else
          LA4Retrato.SalvarPDF(DadosAux, FPArquivoPDF);
      finally
        LA4Retrato.Free;
      end;
    end
    else
    begin
      LPadraoNacional := TACBrDANFSeFPDFPadraoNacional.Create(UmaNFSe);
      try
        LPadraoNacional.Cancelada := Cancelada;
        LPadraoNacional.Homologacao := TACBrNFSeX(ACBrNFSe).Configuracoes.WebServices.AmbienteCodigo <> 1;
        LPadraoNacional.LogoPrefeitura := Trim(Self.Logo) <> '';
        LPadraoNacional.LogoNFSe  := Trim(Self.LogoNFSe) <> '';
        LPadraoNacional.QRCode := (Trim(UmaNFSe.Link) <> '');

        if LPadraoNacional.LogoPrefeitura then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.Logo, BLogoPref);
          LPadraoNacional.LogoPrefeituraBytes := BLogoPref;
        end;

        if LPadraoNacional.LogoNFSe then
        begin
          ACBrUtil.FilesIO.FileToBytes(Self.LogoNFSe, BLogoPres);
          LPadraoNacional.LogoNFSeBytes := BLogoPres;
        end;

        LPadraoNacional.CabecalhoLinha1 := Self.Prefeitura;
        LPadraoNacional.QuebraDeLinha   := DadosAux.QuebradeLinha;
        LPadraoNacional.MensagemRodape := Format('Impresso em %s||%s', [FormatDateTime('dd/mm/yyy HH:nn:ss', Now), Self.Sistema]);

        if Assigned(AStream) then
          LPadraoNacional.SalvarPDF(DadosAux, AStream)
        else
          LPadraoNacional.SalvarPDF(DadosAux, FPArquivoPDF);
      finally
        LPadraoNacional.Free;
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
