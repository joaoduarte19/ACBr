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

unit Tinus.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXGravarXml_ABRASFv1,
  ACBrNFSeXGravarXml_ABRASFv2,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrXmlDocument;

type
  { TNFSeW_Tinus }

  TNFSeW_Tinus = class(TNFSeW_ABRASFv1)
  protected
    procedure Configuracao; override;

  public
    function GerarXml: Boolean; Override;

  end;

  { TNFSeW_Tinus203 }

  TNFSeW_Tinus203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
  public
    function GerarXml: Boolean; Override;

  end;

implementation

uses
  ACBrNFSeXConsts;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Tinus
//==============================================================================

{ TNFSeW_Tinus }

procedure TNFSeW_Tinus.Configuracao;
begin
  inherited Configuracao;

  DivAliq100 := True;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoDividir100') then
    DivAliq100 := False;

  NrOcorrValorIss := 1;
end;

function TNFSeW_Tinus.GerarXml: Boolean;
begin
  if NFSe.OptanteSimplesNacional = snSim then
  begin
    NrOcorrAliquota := 1;
    NrOcorrValorIss := -1;
  end;

  Result := inherited GerarXml;
end;

{ TNFSeW_Tinus203 }

procedure TNFSeW_Tinus203.Configuracao;
begin
  inherited Configuracao;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
  NrOcorrCodigoNBS := 1;
end;

function TNFSeW_Tinus203.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  aNameSpace: string;
begin
  aNameSpace := DefinirNameSpaceDeclaracao;

  Result := CreateElement('InfDeclaracaoPrestacaoServico');

  if aNameSpace <> '' then
    Result.SetNamespace(aNameSpace);

  DefinirIDDeclaracao;

  if (FpAOwner.ConfigGeral.Identificador <> '') and GerarIDDeclaracao then
    Result.SetAttribute(FpAOwner.ConfigGeral.Identificador, NFSe.infID.ID);

  if (NFSe.IdentificacaoRps.Numero <> '') and GerarTagRps then
    Result.AppendChild(GerarRps);

  Result.AppendChild(AddNode(FormatoCompetencia, '#4', 'Competencia', 10, 10, 1,
                                                         NFSe.Competencia, ''));

  Result.AppendChild(GerarServico);
  Result.AppendChild(GerarPrestador);
  Result.AppendChild(GerarTomador);
  Result.AppendChild(GerarIntermediarioServico);
  Result.AppendChild(GerarConstrucaoCivil);

  Result.AppendChild(AddNode(tcStr, '#6', 'RegimeEspecialTributacao', 1, 2, 0,
    FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), ''));

  Result.AppendChild(AddNode(tcStr, '#7', 'OptanteSimplesNacional', 1, 1, 1,
                        FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional), ''));

  Result.AppendChild(AddNode(tcStr, '#8', 'IncentivoFiscal', 1, 1, 1,
                          FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural), ''));

  Result.AppendChild(AddNode(tcStr, '#8', 'regApTribSN', 1, 1, 1,
                             RegimeApuracaoSNToStr(NFSe.RegimeApuracaoSN), ''));

  // Reforma Tributária
  if (NFSe.IBSCBS.dest.xNome <> '') or (NFSe.IBSCBS.imovel.cCIB <> '') or
     (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum) then
    Result.AppendChild(GerarXMLIBSCBS(NFSe.IBSCBS));
end;

function TNFSeW_Tinus203.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                             NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, 0,
                            NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, 0,
                                      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, 0,
                                NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, 0,
                                        NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, 0,
                    NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#23', 'ValTotTributos', 1, 15, 0,
                                  NFSe.Servico.Valores.ValorTotalTributos, ''));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, 0,
                                      NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, 0,
                                                          Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#27', 'DescontoIncondicionado', 1, 15, 0,
                 NFSe.Servico.Valores.DescontoIncondicionado, DSC_VDESCINCOND));

  Result.AppendChild(AddNode(tcDe2, '#28', 'DescontoCondicionado', 1, 15, 0,
                     NFSe.Servico.Valores.DescontoCondicionado, DSC_VDESCCOND));

  // Tributação Federal - no arquivo INI esta na seção: [tribFederal]
  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaPis', 1, 15, 0,
                             NFSe.Servico.Valores.tribFed.pAliqPis, DSC_VALIQ));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCofins', 1, 15, 0,
                          NFSe.Servico.Valores.tribFed.pAliqCofins, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorBaseCalculoPisCofins', 1, 15, 0,
                                NFSe.Servico.Valores.tribFed.vBCPisCofins, ''));

  Result.AppendChild(AddNode(tcStr, '#15', 'tpRetPisCofins', 1, 1, 0,
         tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins), ''));

  Result.AppendChild(AddNode(tcStr, '#15', 'CSTPisCofins', 2, 2, 0,
                               CSTToStr(NFSe.Servico.Valores.tribFed.CST), ''));
end;

function TNFSeW_Tinus203.GerarXml: Boolean;
var
  NFSeNode, xmlNode: TACBrXmlNode;
begin
  // Em conformidade com a versão 2 do layout da ABRASF não deve ser alterado

  ListaDeAlertas.Clear;

  case VersaoNFSe of
    ve203:
      begin
        GerarTagNifTomador := True;
        NrOcorrCodigoMunicInterm := 1;
      end;
    ve204:
      begin
        GerarTagNifTomador := True;
        GerarEnderecoExterior := True;
        NrOcorrCodigoMunicInterm := 1;
      end;
  else
    begin
      GerarTagNifTomador := False;
      GerarEnderecoExterior := False;
      NrOcorrCodigoMunicInterm := -1;
    end;
  end;

  FDocument.Clear();

  NFSeNode := CreateElement('Rps');

  if GerarNSRps then
    NFSeNode.SetNamespace(FpAOwner.ConfigMsgDados.XmlRps.xmlns, Self.PrefixoPadrao);

  FDocument.Root := NFSeNode;

  if FormatoDiscriminacao <> fdNenhum then
    ConsolidarVariosItensServicosEmUmSo;

  xmlNode := GerarInfDeclaracaoPrestacaoServico;
  NFSeNode.AppendChild(xmlNode);

  // Reforma Tributária
  if NFSe.infNFSe.IBSCBS.cLocalidadeIncid > 0 then
    NFSeNode.AppendChild(GerarXMLIBSCBSNFSe);

  Result := True;
end;

end.
