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

unit HM2.LerXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXLerXml_ABRASFv2,
  ACBrXmlDocument;

type
  { TNFSeR_HM2203 }

  TNFSeR_HM2203 = class(TNFSeR_ABRASFv2)
  protected

    procedure LerServico(const ANode: TACBrXmlNode); override;
  public

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     HM2
//==============================================================================

{ TNFSeR_HM2203 }

procedure TNFSeR_HM2203.LerServico(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
  Ok: Boolean;
begin
  inherited LerServico(ANode);

  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.FindAnyNs('Servico');

  if AuxNode <> nil then
  begin
    NFSe.Servico.CodigoTributacaoNacional := ObterConteudo(AuxNode.Childrens.FindAnyNs('cTribNac'), tcStr);
    NFSe.Servico.CodigoNBS := ObterConteudo(AuxNode.Childrens.FindAnyNs('cNBS'), tcStr);
    NFSe.Servico.Valores.tribMun.tribISSQN := StrTotribISSQN(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('tribISSQN'), tcStr));
    NFSe.Servico.Valores.tribMun.tpImunidade := StrTotpImunidade(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('tpImunidade'), tcStr));
  end;
end;

end.
