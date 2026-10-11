{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior                           }
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

unit ACBrLibIMendesDataModule;

{$IfDef FPC}
{$mode delphi}
{$EndIf}

interface

uses
  Classes, SysUtils, FileUtil, ACBrIMendes, ACBrLibComum, ACBrLibDataModule;

type

  { TLibIMendesDM }

  TLibIMendesDM = class(TLibDataModule)
    ACBrIMendes1: TACBrIMendes;
  public
    procedure AplicarConfiguracoes; override;
  end;

var
  LibIMendesDM: TLibIMendesDM;

implementation

uses
  ACBrLibIMendesConfig;

{$R *.lfm}

{ TLibIMendesDM }

procedure TLibIMendesDM.AplicarConfiguracoes;
var
  pLibIMendesConfig: TLibIMendesConfig;
begin
  pLibIMendesConfig := TLibIMendesConfig(Lib.Config);

  with ACBrIMendes1 do
  begin
    Ambiente := pLibIMendesConfig.IMendesConfig.Ambiente;
    CNPJ := pLibIMendesConfig.IMendesConfig.CNPJ;
    Senha := pLibIMendesConfig.IMendesConfig.Senha;
    ArqLOG := pLibIMendesConfig.IMendesConfig.ArqLog;
    NivelLog := pLibIMendesConfig.IMendesConfig.NivelLog;
    TimeOut := pLibIMendesConfig.IMendesConfig.TimeOut;
    MaxProdutosPorEnvio := pLibIMendesConfig.IMendesConfig.MaxProdutosPorEnvio;

    ProxyHost := pLibIMendesConfig.ProxyInfo.Servidor;
    ProxyPort := IntToStr(pLibIMendesConfig.ProxyInfo.Porta);
    ProxyUser := pLibIMendesConfig.ProxyInfo.Usuario;
    ProxyPass := pLibIMendesConfig.ProxyInfo.Senha;
  end;
end;

end.

