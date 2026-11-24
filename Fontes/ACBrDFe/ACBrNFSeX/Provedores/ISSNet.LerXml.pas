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

unit ISSNet.LerXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlDocument,
  ACBrNFSeXLerXml_ABRASFv1,
  ACBrNFSeXLerXml_ABRASFv2,
  PadraoNacional.LerXml;

type
  { TNFSeR_ISSNet }

  TNFSeR_ISSNet = class(TNFSeR_ABRASFv1)
  protected

    function NormatizarXml(const aXml: string): string; override;
  public

  end;

  { TNFSeR_ISSNet204 }

  TNFSeR_ISSNet204 = class(TNFSeR_ABRASFv2)
  protected

    function NormatizarXml(const aXml: string): string; override;
  public

  end;

  { TNFSeR_ISSNetAPIPropria }

  TNFSeR_ISSNetAPIPropria = class(TNFSeR_PadraoNacional)
  protected
    procedure LerXMLEnderecoObra(const ANode: TACBrXmlNode); override;
    procedure LerXMLEnderecoExteriorObra(const ANode: TACBrXmlNode); override;
    procedure LerXMLEnderecoEvento(const ANode: TACBrXmlNode); override;
    procedure LerXMLEnderecoExteriorEvento(const ANode: TACBrXmlNode); override;

    function NormatizarXml(const aXml: string): string; override;
  public

  end;

implementation

uses
  ACBrXmlBase,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     ISSNet
//==============================================================================

{ TNFSeR_ISSNet }

function TNFSeR_ISSNet.NormatizarXml(const aXml: string): string;
begin
  Result := inherited NormatizarXml(aXml);

  Result := RemoverPrefixosDesnecessarios(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TNFSeR_ISSNet204 }

function TNFSeR_ISSNet204.NormatizarXml(const aXml: string): string;
begin
  Result := inherited NormatizarXml(aXml);

  Result := RemoverPrefixosDesnecessarios(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TNFSeR_ISSNetAPIPropria }

function TNFSeR_ISSNetAPIPropria.NormatizarXml(const aXml: string): string;
begin
  Result := inherited NormatizarXml(aXml);

  Result := StringReplace(Result, '<br>', ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '<br/>', ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, ' & ', ' &amp; ', [rfReplaceAll]);

  Result := RemoverPrefixosDesnecessarios(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

procedure TNFSeR_ISSNetAPIPropria.LerXMLEnderecoObra(const ANode: TACBrXmlNode);
var
  AuxNode, NacNode: TACBrXmlNode;
begin
  inherited LerXMLEnderecoObra(ANode);

  AuxNode := ANode.Childrens.FindAnyNs('end');

  if AuxNode <> nil then
  begin
    NacNode := AuxNode.Childrens.FindAnyNs('endNac');

    if NacNode <> nil then
    begin
      with NFSe.ConstrucaoCivil.Endereco do
      begin
        CodigoMunicipio := ObterConteudo(NacNode.Childrens.FindAnyNs('cMun'), tcStr);
        CEP := ObterConteudo(NacNode.Childrens.FindAnyNs('CEP'), tcStr);
      end;
    end;
  end;
end;

procedure TNFSeR_ISSNetAPIPropria.LerXMLEnderecoExteriorObra(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
begin
  AuxNode := ANode.Childrens.FindAnyNs('endExt');

  if AuxNode <> nil then
  begin
    with NFSe.ConstrucaoCivil.Endereco do
    begin
      CodigoPais := SiglaISO2ToCodIBGEPais(ObterConteudo(AuxNode.Childrens.FindAnyNs('cPais'), tcStr));
      CEP := ObterConteudo(AuxNode.Childrens.FindAnyNs('cEndPost'), tcStr);
      xMunicipio := ObterConteudo(AuxNode.Childrens.FindAnyNs('xCidade'), tcStr);
      UF := ObterConteudo(AuxNode.Childrens.FindAnyNs('xEstProvReg'), tcStr);
    end;
  end;
end;

procedure TNFSeR_ISSNetAPIPropria.LerXMLEnderecoEvento(const ANode: TACBrXmlNode);
var
  AuxNode, NacNode: TACBrXmlNode;
begin
  inherited LerXMLEnderecoEvento(ANode);

  AuxNode := ANode.Childrens.FindAnyNs('end');

  if AuxNode <> nil then
  begin
    NacNode := AuxNode.Childrens.FindAnyNs('endNac');

    if NacNode <> nil then
    begin
      with NFSe.Servico.Evento.Endereco do
      begin
        CodigoMunicipio := ObterConteudo(NacNode.Childrens.FindAnyNs('cMun'), tcStr);
        CEP := ObterConteudo(NacNode.Childrens.FindAnyNs('CEP'), tcStr);
      end;
    end;
  end;
end;

procedure TNFSeR_ISSNetAPIPropria.LerXMLEnderecoExteriorEvento(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
begin
  inherited LerXMLEnderecoExteriorEvento(ANode);

  AuxNode := ANode.Childrens.FindAnyNs('endExt');

  if AuxNode <> nil then
    NFSe.Servico.Evento.Endereco.CodigoPais :=
      SiglaISO2ToCodIBGEPais(ObterConteudo(AuxNode.Childrens.FindAnyNs('cPais'), tcStr));
end;

end.
