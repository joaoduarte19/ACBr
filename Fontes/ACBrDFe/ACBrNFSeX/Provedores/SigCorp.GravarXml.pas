{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                              Equipe Nexus (Adequação Padrão Nacional IBS/CBS)}
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

unit SigCorp.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXGravarXml_ABRASFv2,
  PadraoNacional.GravarXml;

type
  { TNFSeW_SigCorp203 }

  TNFSeW_SigCorp203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

  end;

  { TNFSeW_SigCorp204 }

  TNFSeW_SigCorp204 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarConstrucaoCivil: TACBrXmlNode; override;
  end;

  { TNFSeW_SigCorpAPIPropria }

  TNFSeW_SigCorpAPIPropria = class(TNFSeW_PadraoNacional)
  private
    function DevoGerarXMLObraSigCorp: Boolean;
    function GerarXMLLocalPrestacaoSigCorp: TACBrXmlNode;
  protected
    function GerarXMLInfDps: TACBrXmlNode; override;
    function GerarXMLPrestador: TACBrXmlNode; override;
    function GerarXMLServico: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrUtil.Strings,
  ACBrNFSeXConsts;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     SigCorp
//==============================================================================

{ TNFSeW_SigCorp203 }

procedure TNFSeW_SigCorp203.Configuracao;
begin
  inherited Configuracao;

  FormatoAliq := tcDe2;

  NrOcorrValorPis := 1;
  NrOcorrValorCofins := 1;
  NrOcorrValorInss := 1;
  NrOcorrValorIr := 1;
  NrOcorrValorCsll := 1;
  NrOcorrValorIss := 1;
  NrOcorrDescIncond := 1;
  NrOcorrDescCond := 1;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
end;

{ TNFSeW_SigCorp204 }

procedure TNFSeW_SigCorp204.Configuracao;
begin
  inherited Configuracao;

  FormatoAliq := tcDe2;

  NrOcorrInformacoesComplemetares := 0;
  NrOcorrCepTomador := 1;
  NrOcorrAliquota := 1;
  NrOcorrCodigoPaisTomador := -1;
  NrOcorrCodigoNBS := -1;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;

  TagTomador := 'TomadorServico';
end;

function TNFSeW_SigCorp204.GerarConstrucaoCivil: TACBrXmlNode;
var
  vEnderecoObra: TACBrXmlNode;
begin
  Result := nil;

  if (NFSe.ConstrucaoCivil.CodigoObra <> '') then
  begin
    Result := CreateElement('Obra');

    Result.AppendChild(AddNode(tcStr, '#51', 'CodigoObra', 1, 15, 1,
                                   NFSe.ConstrucaoCivil.CodigoObra, DSC_COBRA));
  end
  else
  if NFSe.ConstrucaoCivil.Endereco.Endereco <> '' then
  begin
    Result := CreateElement('Obra');

    vEnderecoObra := CreateElement('EnderecoObra');

    vEnderecoObra.AppendChild(AddNode(tcStr, '#52', 'Logradouro', 1, 100, 1,
                            NFSe.ConstrucaoCivil.Endereco.Endereco, DSC_EOBRA));

    vEnderecoObra.AppendChild(AddNode(tcStr, '#53', 'Numero', 1, 10, 0,
                             NFSe.ConstrucaoCivil.Endereco.Numero, DSC_NEOBRA));

    vEnderecoObra.AppendChild(AddNode(tcStr, '#54', 'Bairro', 1, 100, 1,
                             NFSe.ConstrucaoCivil.Endereco.Bairro, DSC_BEOBRA));

    vEnderecoObra.AppendChild(AddNode(tcStr, '#55', 'Cep', 1, 10, 1,
                               NFSe.ConstrucaoCivil.Endereco.CEP, DSC_CEPOBRA));

    Result.AppendChild(vEnderecoObra);
  end;
end;

function TNFSeW_SigCorp204.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
begin
  Result := inherited GerarInfDeclaracaoPrestacaoServico;

  Result.AppendChild(GerarXMLIBSCBSNFSe);
end;

function TNFSeW_SigCorp204.GerarServico: TACBrXmlNode;
var
  item: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, 1,
      FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

  Result.AppendChild(AddNode(tcStr, '#15', 'PisRetido', 1, 1, 0,
               FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoPis), DSC_VPIS));

  Result.AppendChild(AddNode(tcStr, '#15', 'CofinsRetido', 1, 1, 0,
            FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCofins), DSC_VPIS));

  Result.AppendChild(AddNode(tcStr, '#15', 'CsllRetido', 1, 1, 0,
            FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCsll), DSC_VPIS));

  Result.AppendChild(AddNode(tcStr, '#21', 'ResponsavelRetencao', 1, 1, 0,
     FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), DSC_INDRESPRET));

  item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

  Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, 1,
                                                          item, DSC_CLISTSERV));

  Result.AppendChild(AddNode(tcStr, '#30', 'CodigoCnae', 1, 9, 0,
                                OnlyNumber(NFSe.Servico.CodigoCnae), DSC_CNAE));

  Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoMunicipio', 1, 20, 0,
                     NFSe.Servico.CodigoTributacaoMunicipio, DSC_CSERVTRIBMUN));

  Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNbs', 1, 9, 0,
                                             NFSe.Servico.CodigoNBS, DSC_CMUN));

  Result.AppendChild(AddNode(tcStr, '#32', 'Discriminacao', 1, 2000, 1,
      StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

  Result.AppendChild(AddNode(tcStr, '#33', 'CodigoMunicipio', 1, 7, 1,
                           OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

  Result.AppendChild(GerarCodigoPaisServico);

  Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
                               NrMinExigISS, NrMaxExigISS, 1,
    StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

  Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, 0,
                                NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

  Result.AppendChild(AddNode(tcStr, '#38', 'NumeroProcesso', 1, 30, 0,
                                   NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));

  Result.AppendChild(AddNode(tcStr, '#32', 'cNBS', 1, 9, 0,
                                                   NFSe.Servico.CodigoNBS, ''));
end;

{ TNFSeW_SigCorpAPIPropria }

function TNFSeW_SigCorpAPIPropria.DevoGerarXMLObraSigCorp: Boolean;
begin
  Result := (NFSe.ConstrucaoCivil.CodigoObra <> '') or
            (NFSE.ConstrucaoCivil.Cib > 0) or
            (NFSe.ConstrucaoCivil.Endereco.CEP <> '');
end;

function TNFSeW_SigCorpAPIPropria.GerarXMLInfDps: TACBrXmlNode;
begin
  if Trim(NFSe.verAplic) = '' then
    NFSe.verAplic := 'ACBrNFSeX-1.00';

  if (Trim(NFSe.cLocEmi) = '') or (NFSe.cLocEmi = '0000000') or (NFSe.cLocEmi = '0') then
  begin
    if CodMunEmit <> 0 then
      NFSe.cLocEmi := IntToStr(CodMunEmit);
  end;

  Result := inherited GerarXMLInfDps;
end;

function TNFSeW_SigCorpAPIPropria.GerarXMLLocalPrestacaoSigCorp: TACBrXmlNode;
var
  CodMun: string;
begin
  Result := CreateElement('locPrest');

  CodMun := Trim(NFSe.Servico.CodigoMunicipio);
  if CodMun = '' then
    CodMun := Trim(NFSe.cLocEmi);
  if (CodMun = '') and (CodMunEmit <> 0) then
    CodMun := IntToStr(CodMunEmit);

  if CodMun <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#1', 'cLocPrestacao', 7, 7, 1, CodMun, ''));
    Result.AppendChild(AddNode(tcStr, '#1', 'cPaisPrestacao', 2, 2, 1, 'BR', ''));
  end
  else
    Result.AppendChild(AddNode(tcStr, '#1', 'cPaisPrestacao', 2, 2, 1,
                          CodIBGEPaisToSiglaISO2(NFSe.Servico.CodigoPais), ''));
end;

function TNFSeW_SigCorpAPIPropria.GerarXMLPrestador: TACBrXmlNode;
begin
  Result := CreateElement('prest');

  if NFSe.Prestador.IdentificacaoPrestador.CpfCnpj <> '' then
    Result.AppendChild(AddNodeCNPJCPF('#1', '#1',
                                 NFSe.Prestador.IdentificacaoPrestador.CpfCnpj))
  else
  begin
    if NFSe.Prestador.IdentificacaoPrestador.Nif <> '' then
      Result.AppendChild(AddNode(tcStr, '#1', 'NIF', 1, 40, 1,
                                 NFSe.Prestador.IdentificacaoPrestador.Nif, ''))
    else
      Result.AppendChild(AddNode(tcStr, '#1', 'cNaoNIF', 1, 1, 1,
               NaoNIFToStr(NFSe.Prestador.IdentificacaoPrestador.cNaoNIF), ''));
  end;

  Result.AppendChild(AddNode(tcStr, '#1', 'CAEPF', 1, 14, 0,
                              NFSe.Prestador.IdentificacaoPrestador.CAEPF, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'IM', 1, 15, 0,
                 NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, ''));

  // Exigência estrita do SigCorp / Caraguatatuba: sempre gerar xNome e Endereço do Prestador
  if NFSe.Prestador.RazaoSocial <> '' then
    Result.AppendChild(AddNode(tcStr, '#1', 'xNome', 1, 300, 0,
                                               NFSe.Prestador.RazaoSocial, ''));

  Result.AppendChild(GerarXMLEnderecoPrestador);

  Result.AppendChild(AddNode(tcStr, '#1', 'fone', 6, 20, 0,
                                          NFSe.Prestador.Contato.Telefone, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'email', 1, 80, 0,
                                             NFSe.Prestador.Contato.Email, ''));

  Result.AppendChild(GerarXMLRegimeTributacaoPrestador);
end;

function TNFSeW_SigCorpAPIPropria.GerarXMLServico: TACBrXmlNode;
begin
  Result := CreateElement('serv');

  Result.AppendChild(GerarXMLLocalPrestacaoSigCorp);
  Result.AppendChild(GerarXMLCodigoServico);
  Result.AppendChild(GerarXMLComercioExterior);
  if DevoGerarXMLObraSigCorp then
    Result.AppendChild(GerarXMLObra);
  Result.AppendChild(GerarXMLAtividadeEvento);

  Result.AppendChild(GerarXMLInformacoesComplementares);
end;

end.
