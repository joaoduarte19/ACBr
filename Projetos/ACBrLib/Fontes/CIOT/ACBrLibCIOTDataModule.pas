{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrLibCIOTDataModule;

{$IfDef FPC}
{$mode delphi}
{$EndIf}

interface

uses
  Classes, SysUtils, ACBrLibComum, ACBrLibDataModule,
  ACBrDFe.Conversao,
  ACBrCIOT,
  ACBrMail;

type

  { TLibCIOTDM }

  TLibCIOTDM = class(TLibDataModule)
    ACBrCIOT1: TACBrCIOT;
    ACBrMail1: TACBrMail;
  public
    procedure AplicarConfiguracoes; override;
    procedure AplicarConfigMail;
  end;

var
  LibCIOTDM: TLibCIOTDM;

implementation

uses
  ACBrLibConfig, ACBrLibCIOTConfig, ACBrUtil.Base, ACBrUtil.FilesIO;

{$R *.lfm}

{ TLibCIOTDM }

procedure TLibCIOTDM.AplicarConfiguracoes;
var
  pLibCIOTConfig: TLibCIOTConfig;
begin
  ACBrCIOT1.SSL.DescarregarCertificado;
  pLibCIOTConfig := TLibCIOTConfig(Lib.Config);
  ACBrCIOT1.Configuracoes.Assign(pLibCIOTConfig.CIOTConfig);

  ACBrCIOT1.Configuracoes.Geral.Usuario := pLibCIOTConfig.IntegradoraConfig.IntegradoraUsuario;
  ACBrCIOT1.Configuracoes.Geral.Senha := pLibCIOTConfig.IntegradoraConfig.IntegradoraSenha;
  ACBrCIOT1.Configuracoes.Geral.HashIntegrador := pLibCIOTConfig.IntegradoraConfig.IntegradoraHash;

  ACBrCIOT1.SSL.UseCertificateHTTP := ((ACBrCIOT1.Configuracoes.Certificados.ArquivoPFX <> '') or
                                       (ACBrCIOT1.Configuracoes.Certificados.DadosPFX <> '') or
                                       (ACBrCIOT1.Configuracoes.Certificados.NumeroSerie <> ''));

  {$IFDEF Demo}
  GravarLog('Modo DEMO - Forçando ambiente para Homologação', logNormal);
  ACBrCIOT1.Configuracoes.WebServices.Ambiente := taHomologacao;
  {$ENDIF}

  AplicarConfigMail;
end;

procedure TLibCIOTDM.AplicarConfigMail;
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

end.

