{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatu� - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrPagForProviderManager;

interface

uses
  SysUtils, Classes,
  ACBrPagForInterface;

type

  TACBrPagForProviderManager = class
  public
    class function GetProvider(ACBrPagFor: TComponent): IACBrPagForProvider;
  end;

implementation

uses
  ACBrPagFor, ACBrPagForConversao,

  PagFor.BancoCECRED.Provider,
  PagFor.BancodoBrasil.Provider,
  PagFor.Banrisul.Provider,
  PagFor.Bradesco.Provider,
  PagFor.Caixa.Provider,
  PagFor.HSBC.Provider,
  PagFor.Inter.Provider,
  PagFor.Itau.Provider,
  PagFor.Safra.Provider,
  PagFor.Santander.Provider,
  PagFor.Sicoob.Provider,
  PagFor.Sicredi.Provider,
  PagFor.UnicredCooperativa.Provider,
  PagFor.Cresol.Provider;

  { TACBrPagForProviderManager }

class function TACBrPagForProviderManager.GetProvider(ACBrPagFor: TComponent): IACBrPagForProvider;
begin
  with TACBrPagfor(ACBrPagFor).Configuracoes.Geral do
  begin
    case Banco of
      pagBancoCECRED:
        Result := TACBrPagForProviderBancoCECRED.Create(ACBrPagFor);

      pagBancodoBrasil:
        Result := TACBrPagForProviderBancodoBrasil.Create(ACBrPagFor);

      pagBanrisul:
        Result := TACBrPagForProviderBanrisul.Create(ACBrPagFor);

      pagBradesco:
        Result := TACBrPagForProviderBradesco.Create(ACBrPagFor);

      pagCaixaEconomica:
        Result := TACBrPagForProviderCaixa.Create(ACBrPagFor);

      pagHSBC:
        Result := TACBrPagForProviderHSBC.Create(ACBrPagFor);

      pagInter:
        Result := TACBrPagForProviderInter.Create(ACBrPagFor);

      pagItau:
        Result := TACBrPagForProviderItau.Create(ACBrPagFor);

      pagSafra:
        Result := TACBrPagForProviderSafra.Create(ACBrPagFor);

      pagSantander:
        Result := TACBrPagForProviderSantander.Create(ACBrPagFor);

      pagBanCooB:
        Result := TACBrPagForProviderSicoob.Create(ACBrPagFor);

      pagSicredi:
        Result := TACBrPagForProviderSicredi.Create(ACBrPagFor);

      pagUnicredCooperativa:
        Result := TACBrPagForProviderUnicredCooperativa.Create(ACBrPagFor);

      pagCresol:
        Result := TACBrPagForProviderCresol.Create(ACBrPagFor);
    else
      Result := nil;
    end;
  end;
end;

end.
