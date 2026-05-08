{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior, Renato Rubinho           }
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

unit ACBrLibDCeDataModule;

{$IfDef FPC}
{$mode delphi}
{$EndIf}

interface

uses
  Classes, SysUtils, ACBrLibComum, ACBrLibDataModule,
  ACBrDFe.Conversao,
  ACBrDCe.DACERLClass,
  ACBrDCe,
  ACBrMail;

type

  { TLibDCeDM }

  TLibDCeDM = class(TLibDataModule)
    ACBrDCe1: TACBrDCe;
    ACBrDCeDACERL1: TACBrDCeDACERL;
    FDACeFortes: TACBrDCeDACERL;
    ACBrMail1: TACBrMail;

  protected
    procedure FreeReports;

  public
    procedure AplicarConfiguracoes; override;
    procedure AplicarConfigMail;
    procedure ConfigurarImpressao(NomeImpressora: String = ''; GerarPDF: Boolean = False;
      MostrarPreview: String = ''; AACBrDCe: TACBrDCe = nil);
    procedure FinalizarImpressao;
  end;

var
  LibDCeDM: TLibDCeDM;

implementation

uses
  ACBrLibConfig, ACBrLibDCeConfig, ACBrUtil.Base, ACBrUtil.FilesIO;

{$R *.lfm}

{ TLibDCeDM }

procedure TLibDCeDM.FreeReports;
begin
  ACBrDCe1.DACE := nil;
  if Assigned(FDACeFortes) then
    FreeAndNil(FDACeFortes);
end;

procedure TLibDCeDM.AplicarConfiguracoes;
var
  pLibDCeConfig: TLibDCeConfig;
begin
  ACBrDCe1.SSL.DescarregarCertificado;
  pLibDCeConfig := TLibDCeConfig(Lib.Config);
  ACBrDCe1.Configuracoes.Assign(pLibDCeConfig.DCeConfig);
  ACBrDCe1.DACE := FDACeFortes;

  {$IFDEF Demo}
  GravarLog('Modo DEMO - Forçando ambiente para Homologação', logNormal);
  ACBrDCe1.Configuracoes.WebServices.Ambiente := taHomologacao;
  {$ENDIF}

  AplicarConfigMail;
end;

procedure TLibDCeDM.AplicarConfigMail;
begin
  ACBrMail1.Attempts := Lib.Config.Email.Tentativas;
  ACBrMail1.SetTLS := Lib.Config.Email.TLS;
  ACBrMail1.DefaultCharset := Lib.Config.Email.Codificacao;
  ACBrMail1.From := Lib.Config.Email.Conta;
  ACBrMail1.FromName := Lib.Config.Email.Nome;
  ACBrMail1.SetSSL := Lib.Config.Email.SSL;
  ACBrMail1.Host := Lib.Config.Email.Servidor;
  ACBrMail1.IDECharset := Lib.Config.Email.Codificacao;
  ACBrMail1.IsHTML := Lib.Config.Email.IsHTML;
  ACBrMail1.Password := Lib.Config.Email.Senha;
  ACBrMail1.Port := IntToStr(Lib.Config.Email.Porta);
  ACBrMail1.Priority := Lib.Config.Email.Priority;
  ACBrMail1.ReadingConfirmation := Lib.Config.Email.Confirmacao;
  ACBrMail1.DeliveryConfirmation := Lib.Config.Email.ConfirmacaoEntrega;
  ACBrMail1.TimeOut := Lib.Config.Email.TimeOut;
  ACBrMail1.Username := Lib.Config.Email.Usuario;
  ACBrMail1.UseThread := Lib.Config.Email.SegundoPlano;
end;

procedure TLibDCeDM.ConfigurarImpressao(NomeImpressora: String; GerarPDF: Boolean;
  MostrarPreview: String; AACBrDCe: TACBrDCe);
var
  LibConfig: TLibDCeConfig;
begin
  if not Assigned(AACBrDCe) then
    AACBrDCe := ACBrDCe1;

  LibConfig := TLibDCeConfig(Lib.Config);

  GravarLog('ConfigurarImpressao - Iniciado', logNormal);

  FDACeFortes := TACBrDCeDACERL.Create(Nil);
  AACBrDCe.DACE := FDACeFortes;

  if GerarPDF then
  begin
    if (LibConfig.DACeConfig.PathPDF <> '') then
      if not DirectoryExists(PathWithDelim(LibConfig.DACeConfig.PathPDF))then
        ForceDirectories(PathWithDelim(LibConfig.DACeConfig.PathPDF));
  end;

  if LibConfig.DACeConfig.MargemInferior = 0 then
    LibConfig.DACeConfig.MargemInferior := 7;
  if LibConfig.DACeConfig.MargemSuperior = 0 then
    LibConfig.DACeConfig.MargemSuperior := 7;
  if LibConfig.DACeConfig.MargemEsquerda = 0 then
    LibConfig.DACeConfig.MargemEsquerda := 4;
  if LibConfig.DACeConfig.MargemDireita = 0 then
    LibConfig.DACeConfig.MargemDireita := 4;

  LibConfig.DACeConfig.Apply(FDACeFortes, Lib);

  if NaoEstaVazio(NomeImpressora) then
    FDACeFortes.Impressora := NomeImpressora;

  if NaoEstaVazio(MostrarPreview) then
    FDACeFortes.MostraPreview := StrToBoolDef(MostrarPreview, False);

  GravarLog('ConfigurarImpressao - Feito', logNormal);
end;

procedure TLibDCeDM.FinalizarImpressao;
begin
  GravarLog('FinalizarImpressao - Iniciado', logNormal);
  FreeReports;
  GravarLog('FinalizarImpressao - Feito', logNormal);
end;

end.

