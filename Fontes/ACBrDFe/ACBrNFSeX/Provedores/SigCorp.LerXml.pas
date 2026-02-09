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

unit SigCorp.LerXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXLerXml_ABRASFv2;

type
  { TNFSeR_SigCorp203 }

  TNFSeR_SigCorp203 = class(TNFSeR_ABRASFv2)
  protected
    function LerDataHoraCancelamento(const ANode: TACBrXmlNode): TDateTime; override;
    function LerDataEmissao(const ANode: TACBrXmlNode): TDateTime; override;
    function LerDataEmissaoRps(const ANode: TACBrXmlNode): TDateTime; override;

  public

  end;

  { TNFSeR_SigCorp204 }

  TNFSeR_SigCorp204 = class(TNFSeR_ABRASFv2)
  protected

    procedure LerServico(const ANode: TACBrXmlNode); override;
    procedure LerInfDeclaracaoPrestacaoServico(const ANode: TACBrXmlNode); override;
    procedure LerConstrucaoCivil(const ANode: TACBrXmlNode); override;
  public

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrUtil.Strings, ACBrUtil.DateTime;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     SigCorp
//==============================================================================

{ TNFSeR_SigCorp203 }

function TNFSeR_SigCorp203.LerDataEmissao(const ANode: TACBrXmlNode): TDateTime;
var
  xDataHora, xFormato: string;
begin
  xDataHora := ObterConteudo(ANode.Childrens.FindAnyNs('DataEmissao'), tcStr);
  xFormato := 'YYYY/MM/DD';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'NFSeDDMMAAAA') then
    xFormato := 'DD/MM/YYYY';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'NFSeMMDDAAAA') then
    xFormato := 'MM/DD/YYYY';

  result := EncodeDataHora(xDataHora, xFormato);
end;

function TNFSeR_SigCorp203.LerDataEmissaoRps(
  const ANode: TACBrXmlNode): TDateTime;
var
  xDataHora, xFormato: string;
begin
  xDataHora := ObterConteudo(ANode.Childrens.FindAnyNs('DataEmissao'), tcStr);
  xFormato := 'YYYY/MM/DD';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'RpsDDMMAAAA') then
    xFormato := 'DD/MM/YYYY';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'RpsMMDDAAAA') then
    xFormato := 'MM/DD/YYYY';

  result := EncodeDataHora(xDataHora, xFormato);
end;

function TNFSeR_SigCorp203.LerDataHoraCancelamento(
  const ANode: TACBrXmlNode): TDateTime;
var
  xDataHora, xFormato: string;
begin
  xDataHora := ObterConteudo(ANode.Childrens.FindAnyNs('DataHoraCancelamento'), tcStr);
  xFormato := 'YYYY/MM/DD';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'CancDDMMAAAA') then
    xFormato := 'DD/MM/YYYY';

  if FpAOwner.ConfigGeral.Params.ParamTemValor('FormatoData', 'CancMMDDAAAA') then
    xFormato := 'MM/DD/YYYY';

  result := EncodeDataHora(xDataHora, xFormato);
end;

{ TNFSeR_SigCorp204 }

procedure TNFSeR_SigCorp204.LerServico(const ANode: TACBrXmlNode);
var
  AuxNode, AuxNode2: TACBrXmlNode;
  Ok: Boolean;
  CodigoItemServico, Responsavel, xUF: string;
  ValorLiq: Double;
begin
  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.FindAnyNs('Servico');

  if AuxNode <> nil then
  begin
    AuxNode2 := AuxNode.Childrens.FindAnyNs('tcDadosServico');

    if AuxNode2 <> nil then
      AuxNode := AuxNode2;

    LerValores(AuxNode);

    if NFSe.Servico.Valores.IssRetido = stNenhum then
      NFSe.Servico.Valores.IssRetido := FpAOwner.StrToSituacaoTributaria(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('IssRetido'), tcStr));

    NFSe.Servico.Valores.RetidoPis := FpAOwner.StrToSimNao(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('PisRetido'), tcStr));
    NFSe.Servico.Valores.RetidoCofins := FpAOwner.StrToSimNao(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('CofinsRetido'), tcStr));
    Responsavel := ObterConteudo(AuxNode.Childrens.FindAnyNs('ResponsavelRetencao'), tcStr);

    if Responsavel = '' then
      NFSe.Servico.ResponsavelRetencao := rtNenhum
    else
      NFSe.Servico.ResponsavelRetencao := FpAOwner.StrToResponsavelRetencao(Ok, Responsavel);

    CodigoItemServico := ObterConteudo(AuxNode.Childrens.FindAnyNs('ItemListaServico'), tcStr);

    NFSe.Servico.ItemListaServico := NormatizarItemListaServico(CodigoItemServico);
    NFSe.Servico.xItemListaServico := ItemListaServicoDescricao(NFSe.Servico.ItemListaServico);

    NFSe.Servico.CodigoCnae := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoCnae'), tcStr);
    NFSe.Servico.CodigoTributacaoMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoTributacaoMunicipio'), tcStr);
    NFSe.Servico.CodigoNBS := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoNbs'), tcStr);
    NFSe.Servico.Discriminacao := ObterConteudo(AuxNode.Childrens.FindAnyNs('Discriminacao'), tcStr);
    NFSe.Servico.Discriminacao := StringReplace(NFSe.Servico.Discriminacao, FpQuebradeLinha,
                                                    sLineBreak, [rfReplaceAll]);

    VerificarSeConteudoEhLista(NFSe.Servico.Discriminacao);

    NFSe.Servico.CodigoMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);

    NFSe.Servico.MunicipioPrestacaoServico := '';

    if NFSe.Servico.CodigoMunicipio <> '' then
    begin
      NFSe.Servico.MunicipioPrestacaoServico := ObterNomeMunicipioUF(StrToIntDef(NFSe.Servico.CodigoMunicipio, 0), xUF);
      NFSe.Servico.MunicipioPrestacaoServico := NFSe.Servico.MunicipioPrestacaoServico + '/' + xUF;
    end;

    NFSe.Servico.CodigoPais := LerCodigoPaisServico(AuxNode);
    NFSe.Servico.ExigibilidadeISS := FpAOwner.StrToExigibilidadeISS(Ok, ObterConteudo(AuxNode.Childrens.FindAnyNs('ExigibilidadeISS'), tcStr));
    NFSe.Servico.IdentifNaoExigibilidade := ObterConteudo(AuxNode.Childrens.FindAnyNs('IdentifNaoExigibilidade'), tcStr);
    NFSe.Servico.MunicipioIncidencia := ObterConteudo(AuxNode.Childrens.FindAnyNs('MunicipioIncidencia'), tcInt);
    NFSe.Servico.xMunicipioIncidencia := '';

    if NFSe.Servico.MunicipioIncidencia > 0 then
    begin
      NFSe.Servico.xMunicipioIncidencia := ObterNomeMunicipioUF(NFSe.Servico.MunicipioIncidencia, xUF);
      NFSe.Servico.xMunicipioIncidencia := NFSe.Servico.xMunicipioIncidencia + '/' + xUF;
    end;

    NFSe.Servico.NumeroProcesso := ObterConteudo(AuxNode.Childrens.FindAnyNs('NumeroProcesso'), tcStr);
    NFSe.Servico.CodigoNBS := ObterConteudo(AuxNode.Childrens.FindAnyNs('cNBS'), tcStr);

    // Na versão 2 do layout da ABRASF o valor do ISS retido ou não é retornado
    // na tag ValorIss, sendo assim se faz necessário checar o valor da tag IssRetido
    // para saber quais dos dois campos vai receber a informação.
    if NFSe.Servico.Valores.IssRetido = stRetencao then
    begin
      NFSe.Servico.Valores.ValorIssRetido := NFSe.Servico.Valores.ValorIss;
      NFSe.Servico.Valores.ValorIss := 0;
    end
    else
      NFSe.Servico.Valores.ValorIssRetido := 0;

    NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorPis +
      NFSe.Servico.Valores.ValorCofins + NFSe.Servico.Valores.ValorInss +
      NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorCsll +
      NFSe.Servico.Valores.ValorCpp;

    ValorLiq := NFSe.Servico.Valores.ValorServicos - NFSe.Servico.Valores.RetencoesFederais -
                NFSe.Servico.Valores.OutrasRetencoes - NFSe.Servico.Valores.ValorIssRetido -
                NFSe.Servico.Valores.DescontoIncondicionado - NFSe.Servico.Valores.DescontoCondicionado;

    if (NFSe.Servico.Valores.ValorLiquidoNfse = 0) or
       (NFSe.Servico.Valores.ValorLiquidoNfse > ValorLiq) then
      NFSe.Servico.Valores.ValorLiquidoNfse := ValorLiq;

    NFSe.Servico.Valores.ValorTotalNotaFiscal := NFSe.Servico.Valores.ValorServicos -
                                    NFSe.Servico.Valores.DescontoCondicionado -
                                    NFSe.Servico.Valores.DescontoIncondicionado +
                                    NFSe.Servico.Valores.ValorTaxaTurismo;
  end;
end;

procedure TNFSeR_SigCorp204.LerInfDeclaracaoPrestacaoServico(
  const ANode: TACBrXmlNode);
begin
  inherited LerInfDeclaracaoPrestacaoServico(ANode);

  LerXMLIBSCBSNFSe(ANode, NFSe.infNFSe.IBSCBS);
end;

procedure TNFSeR_SigCorp204.LerConstrucaoCivil(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.FindAnyNs('Obra');

  if AuxNode <> nil then
  begin
    NFSe.ConstrucaoCivil.CodigoObra := ObterConteudo(AuxNode.Childrens.FindAnyNs('CodigoObra'), tcStr);
    NFSe.ConstrucaoCivil.Art := ObterConteudo(AuxNode.Childrens.FindAnyNs('Art'), tcStr);

    AuxNode := ANode.Childrens.FindAnyNs('EnderecoObra');

    if AuxNode <> nil then
    begin
      NFSe.ConstrucaoCivil.Endereco.Endereco := ObterConteudo(AuxNode.Childrens.FindAnyNs('Logradouro'), tcStr);
      NFSe.ConstrucaoCivil.Endereco.Numero := ObterConteudo(AuxNode.Childrens.FindAnyNs('Numero'), tcStr);
      NFSe.ConstrucaoCivil.Endereco.Bairro := ObterConteudo(AuxNode.Childrens.FindAnyNs('Bairro'), tcStr);
      NFSe.ConstrucaoCivil.Endereco.Cep := ObterConteudo(AuxNode.Childrens.FindAnyNs('Cep'), tcStr);
    end;
  end;
end;

end.
