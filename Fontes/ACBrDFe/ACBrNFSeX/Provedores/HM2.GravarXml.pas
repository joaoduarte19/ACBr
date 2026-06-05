{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit HM2.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXGravarXml_ABRASFv2,
  ACBrXmlDocument;

type
  { TNFSeW_HM2203 }

  TNFSeW_HM2203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     HM2
//==============================================================================

{ TNFSeW_HM2203 }

procedure TNFSeW_HM2203.Configuracao;
begin
  inherited Configuracao;

  NrOcorrCodigoPaisTomador := 0;
  NrOcorrCodigoNbs := -1;
  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
end;

function TNFSeW_HM2203.GerarServico: TACBrXmlNode;
begin
  Result := inherited GerarServico;

  Result.AppendChild(AddNode(tcStr, '#1', 'cTribNac', 6, 6, 1,
                                    NFSe.Servico.CodigoTributacaoNacional, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cNBS', 9, 9, 0,
                                                   NFSe.Servico.CodigoNBS, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'tribISSQN', 1, 1, 1,
                   tribISSQNToStr(NFSe.Servico.Valores.tribMun.tribISSQN), ''));

  if NFSe.Servico.Valores.tribMun.tribISSQN = tiImunidade then
    Result.AppendChild(AddNode(tcStr, '#1', 'tpImunidade', 1, 1, 0,
               tpImunidadeToStr(NFSe.Servico.Valores.tribMun.tpImunidade), ''));
end;

end.
