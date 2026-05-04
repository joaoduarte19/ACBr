{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
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

unit ISSIntel.LerXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlDocument,
  ACBrNFSeXLerXml_ABRASFv1;

type
  { TNFSeR_ISSIntel }

  TNFSeR_ISSIntel = class(TNFSeR_ABRASFv1)
  protected
    procedure LerServico(const ANode: TACBrXmlNode);
    procedure LerValores(const ANode: TACBrXmlNode);
//    procedure LerINISecaoServico(const AINIRec: TMemIniFile);
//    procedure LerINISecaoValores(const AINIRec: TMemIniFile);
  public

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     ISSIntel
//==============================================================================

{ TNFSeR_ISSIntel }

procedure TNFSeR_ISSIntel.LerServico(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
  CodigoItemServico, xUF: string;
  Ok: Boolean;
begin
  if not Assigned(ANode) then
    Exit;

  AuxNode := ANode.Childrens.FindAnyNs('Servico');

  if AuxNode <> nil then
  begin
    LerValores(AuxNode);

    CodigoItemServico := ObterConteudo(AuxNode.Childrens.FindAnyNs('ItemListaServico'), tcStr);

    with NFSe.Servico do
    begin
      ItemListaServico := NormatizarItemListaServico(CodigoItemServico);
      xItemListaServico := ItemListaServicoDescricao(ItemListaServico);
      CodigoServicoNacional := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoServicoNacional'), tcStr);
      CodigoCnae := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoCnae'), tcStr);
      CodigoTributacaoMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoTributacaoMunicipio'), tcStr);
      CodigoNBS := ObterConteudo(ANode.Childrens.FindAnyNs('CodigoNbs'), tcStr);
      Discriminacao := ObterConteudo(AuxNode.Childrens.FindAnyNs('Discriminacao'), tcStr);
      Discriminacao := StringReplace(Discriminacao, FpQuebradeLinha,
        sLineBreak, [rfReplaceAll]);

      CodigoMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);

      if CodigoMunicipio = '' then
        CodigoMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('MunicipioPrestacaoServico'), tcStr);

      MunicipioIncidencia := StrToIntDef(CodigoMunicipio, 0);
      MunicipioPrestacaoServico := '';
      xMunicipioIncidencia := '';

      if MunicipioIncidencia > 0 then
      begin
        MunicipioPrestacaoServico := ObterNomeMunicipioUF(MunicipioIncidencia, xUF);
        MunicipioPrestacaoServico := MunicipioPrestacaoServico + '/' + xUF;
        xMunicipioIncidencia := MunicipioPrestacaoServico;
      end;
    end;
  end;
end;

procedure TNFSeR_ISSIntel.LerValores(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
  Ok: Boolean;
  ValorLiq: Double;
begin
  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.FindAnyNs('Valores');

  if AuxNode <> nil then
  begin
    with NFSe.Servico.Valores do
    begin
      ValorServicos := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorServicos'), tcDe2);
      ValorDeducoes := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorDeducoes'), tcDe2);
      ValorPis := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorPis'), tcDe2);
      ValorCofins := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorCofins'), tcDe2);
      ValorInss := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorInss'), tcDe2);
      ValorIr := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorIr'), tcDe2);
      ValorCsll := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorCsll'), tcDe2);
      IssRetido := FpAOwner.StrToSituacaoTributaria(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('IssRetido'), tcStr));
      ValorIss := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorIss'), tcDe2);
      OutrasRetencoes := ObterConteudo(AuxNode.Childrens.FindAnyNs('OutrasRetencoes'), tcDe2);
      BaseCalculo := ObterConteudo(AuxNode.Childrens.FindAnyNs('BaseCalculo'), tcDe2);
      Aliquota := ObterConteudo(AuxNode.Childrens.FindAnyNs('Aliquota'), tcDe4);
      Aliquota := NormatizarAliquota(Aliquota);
      ValorLiquidoNfse := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorLiquidoNfse'), tcDe2);
      ValorIssRetido := ObterConteudo(AuxNode.Childrens.FindAnyNs('ValorIssRetido'), tcDe2);
      DescontoCondicionado := ObterConteudo(AuxNode.Childrens.FindAnyNs('DescontoCondicionado'), tcDe2);
      DescontoIncondicionado := ObterConteudo(AuxNode.Childrens.FindAnyNs('DescontoIncondicionado'), tcDe2);

      tribFed.TpRetPisCofins := StrTotpRetPisCofins(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('TpRetPisCofins'), tcStr));
      tribFed.CST := StrToCST(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('PisCofinsCst'), tcStr));
      tribFed.vBCPisCofins := ObterConteudo(AuxNode.Childrens.FindAnyNs('BcPisCofins'), tcDe2);
      tribFed.pAliqPis := ObterConteudo(AuxNode.Childrens.FindAnyNs('AliquotaPis'), tcDe2);
      tribFed.pAliqCofins := ObterConteudo(AuxNode.Childrens.FindAnyNs('AliquotaCofins'), tcDe2);

      RetencoesFederais := ValorPis + ValorCofins + ValorInss + ValorIr + ValorCsll;

      if ValorIssRetido = 0 then
      begin
        if IssRetido = stRetencao then
          ValorIssRetido := ValorIss
        else
          ValorIssRetido := 0;
      end;

      ValorLiq := ValorServicos - RetencoesFederais - OutrasRetencoes -
                  ValorIssRetido - DescontoIncondicionado - DescontoCondicionado;

      if (ValorLiquidoNfse = 0) or (ValorLiquidoNfse <> ValorLiq) then
        ValorLiquidoNfse := ValorLiq;

      ValorTotalNotaFiscal := ValorServicos - DescontoCondicionado -
                              DescontoIncondicionado;
    end;

    NFSe.TipoRecolhimento := FpAOwner.SituacaoTributariaDescricao(NFSe.Servico.Valores.IssRetido);
  end;
end;

end.
