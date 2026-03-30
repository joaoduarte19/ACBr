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

unit EloTech.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils, IniFiles,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_Elotech203 }

  TNFSeW_Elotech203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarListaItensServico: TACBrXmlNode; override;
    function GerarItemServico: TACBrXmlNodeArray; override;
    function GerarDadosDeducao(Item: Integer): TACBrXmlNode;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarXMLDestinatario(Dest: TDadosdaPessoa): TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;

    procedure GerarINISecaoServicos(const AINIRec: TMemIniFile); override;
    procedure GerarINISecaoDadosDeducao(const AINIRec: TMemIniFile;
      Item: TItemServicoCollectionItem; const AIndice: Integer); override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrNFSeXConsts,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     EloTech
//     Chave de Acesso tem que ter 32 caracteres.
//==============================================================================

{ TNFSeW_Elotech203 }

procedure TNFSeW_Elotech203.Configuracao;
begin
  inherited Configuracao;

  FormatoAliq := tcDe4;

  NrOcorrCodigoMunic_2 := 1;
  NrOcorrOptanteSimplesNacional := -1;
  NrOcorrItemListaServico := -1;
  NrOcorrCodigoCNAE := -1;
  NrOcorrCodTribMun_1 := -1;
  NrOcorrCodigoMunic_1 := -1;
  NrOcorrCodigoPaisServico := -1;

  FormatoItemListaServico := filsNaoSeAplica;
  NrOcorrRespRetencao := -1;
  NrOcorrValorDeducoes := 1;
  NrOcorrDescIncond := 1;
  NrOcorrDescCond := 1;
  NrOcorrOutrasRet := 1;

  NrOcorrAliquotaPis := 1;
  NrOcorrRetidoPis := 1;
  NrOcorrAliquotaCofins := 1;
  NrOcorrRetidoCofins := 1;
  NrOcorrAliquotaInss := 1;
  NrOcorrRetidoInss := 1;
  NrOcorrAliquotaIr := 1;
  NrOcorrRetidoIr := 1;
  NrOcorrAliquotaCsll := 1;
  NrOcorrRetidoCsll := 1;
  NrOcorrInscEstTomador_2 := 0;
  NrOcorrValorCpp := 0;
  NrOcorrAliquotaCpp := 0;
  NrOcorrRetidoCpp := 0;

  GerarIDDeclaracao := False;
  GerargReeRepRes := False;

  TagIBSCBS := 'InfIbsCbs';
  TagCST := 'Cst';
  TagCSTReg := 'CstReg';
end;

function TNFSeW_Elotech203.GerarDadosDeducao(Item: Integer): TACBrXmlNode;
var
  aDoc: string;
begin
  Result := nil;

  if NFSe.Servico.ItemServico[Item].DadosDeducao.TipoDeducao = tdNenhum then
    Exit;

  Result := CreateElement('DadosDeducao');

  Result.AppendChild(AddNode(tcStr, '#', 'TipoDeducao', 1, 1, 1,
    FpAOwner.TipoDeducaoToStr(NFSe.Servico.ItemServico[Item].DadosDeducao.TipoDeducao)));

  aDoc := OnlyNumber(NFSe.Servico.ItemServico[Item].DadosDeducao.CpfCnpj);

  if length(aDoc) <= 11 then
    Result.AppendChild(AddNode(tcStr, '#', 'Cpf ', 11, 11, 1, aDoc, DSC_CPF))
  else
    Result.AppendChild(AddNode(tcStr, '#', 'Cnpj', 14, 14, 1, aDoc, DSC_CNPJ));

  Result.AppendChild(AddNode(tcStr, '#', 'NumeroNotaFiscalReferencia', 1, 15, 0,
       NFSe.Servico.ItemServico[Item].DadosDeducao.NumeroNotaFiscalReferencia));

  Result.AppendChild(AddNode(tcDe2, '#', 'ValorTotalNotaFiscal', 1, 15, 1,
             NFSe.Servico.ItemServico[Item].DadosDeducao.ValorTotalNotaFiscal));

  Result.AppendChild(AddNode(tcDe2, '#', 'PercentualADeduzir', 1, 15, 0,
               NFSe.Servico.ItemServico[Item].DadosDeducao.PercentualADeduzir));

  Result.AppendChild(AddNode(tcDe2, '#', 'ValorADeduzir', 1, 15, 0,
                    NFSe.Servico.ItemServico[Item].DadosDeducao.ValorADeduzir));
end;

function TNFSeW_Elotech203.GerarItemServico: TACBrXmlNodeArray;
var
  i: integer;
  item: string;
begin
  Result := nil;
  SetLength(Result, NFSe.Servico.ItemServico.Count);

  for i := 0 to NFSe.Servico.ItemServico.Count - 1 do
  begin
    Result[i] := CreateElement('ItemServico');

    item := FormatarItemServico(NFSe.Servico.ItemServico[i].ItemListaServico, FormatoItemListaServico);

    Result[i].AppendChild(AddNode(tcStr, '#', 'ItemListaServico', 1, 6, 1,
                                                          item, DSC_CLISTSERV));

    Result[i].AppendChild(AddNode(tcStr, '#', 'CodigoCnae', 1, 7, 0,
                                       NFSe.Servico.ItemServico[i].CodigoCnae));

    Result[i].AppendChild(AddNode(tcStr, '#', 'Descricao', 1, 4000, 0,
                                        NFSe.Servico.ItemServico[i].Descricao));

    Result[i].AppendChild(AddNode(tcStr, '#', 'Tributavel', 1, 1, 0,
                 FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[i].Tributavel)));

    Result[i].AppendChild(AddNode(tcDe5, '#', 'Quantidade', 1, 17, 1,
                                       NFSe.Servico.ItemServico[i].Quantidade));

    Result[i].AppendChild(AddNode(tcDe5, '#', 'ValorUnitario', 1, 17, 1,
                                    NFSe.Servico.ItemServico[i].ValorUnitario));

    Result[i].AppendChild(AddNode(tcDe2, '#', 'ValorDesconto', 1, 17, 1,
                             NFSe.Servico.ItemServico[i].DescontoIncondicionado));

    Result[i].AppendChild(AddNode(tcDe2, '#', 'ValorLiquido', 1, 17, 1,
                                       NFSe.Servico.ItemServico[i].ValorTotal));

    Result[i].AppendChild(GerarDadosDeducao(i));
  end;

  if NFSe.Servico.ItemServico.Count > 10 then
    wAlerta('#54', 'ItemServico', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFSeW_Elotech203.GerarListaItensServico: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := CreateElement('ListaItensServico');

  nodeArray := GerarItemServico;
  if nodeArray <> nil then
  begin
    for i := 0 to Length(nodeArray) - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFSeW_Elotech203.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                             NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, 0,
                            NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaPis', 1, 15, 0,
                                  NFSe.Servico.Valores.AliquotaPis, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoPis', 1, 1, 0,
               FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoPis), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, 0,
                                      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCofins', 1, 15, 0,
                               NFSe.Servico.Valores.AliquotaCofins, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCofins', 1, 1, 0,
            FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCofins), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, 0,
                                NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaInss', 1, 15, 0,
                                 NFSe.Servico.Valores.AliquotaInss, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoInss', 1, 1, 0,
              FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoInss), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaIr', 1, 15, 0,
                                   NFSe.Servico.Valores.AliquotaIr, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoIr', 1, 1, 0,
                FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoIr), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, 0,
                                        NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCsll', 1, 15, 0,
                                 NFSe.Servico.Valores.AliquotaCsll, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCsll', 1, 1, 0,
              FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCsll), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCpp', 1, 15, 0,
                                 NFSe.Servico.Valores.AliquotaCpp, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCpp', 1, 1, 0,
              FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCpp), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCpp', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorCpp, DSC_VCSLL));

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

  Result.AppendChild(AddNode(tcStr, '#1', 'CSTPisCofins', 2, 2, 0,
                               CSTToStr(NFSe.Servico.Valores.tribFed.CST), ''));
end;

function TNFSeW_Elotech203.GerarXMLDestinatario(
  Dest: TDadosdaPessoa): TACBrXmlNode;
begin
  Result := CreateElement('dest');

  if Dest.CNPJCPF <> '' then
    Result.AppendChild(GerarCPFCNPJ(Dest.CNPJCPF));

  if Dest.Nif <> '' then
    Result.AppendChild(AddNode(tcStr, '#1', 'NIF', 1, 40, 1, Dest.Nif, ''))
  else
    Result.AppendChild(AddNode(tcStr, '#1', 'cNaoNif', 1, 1, 1,
                                                NaoNIFToStr(Dest.cNaoNIF), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'XNome', 1, 300, 1, Dest.xNome, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'fone', 6, 20, 0, Dest.fone, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'email', 1, 80, 0, Dest.email, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'end', 1, 125, 0, Dest.ender.xLgr, ''));
end;

procedure TNFSeW_Elotech203.GerarINISecaoServicos(const AINIRec: TMemIniFile);
var
  I: Integer;
  sSecao: string;
begin
  for I := 0 to NFSe.Servico.ItemServico.Count - 1 do
  begin
    sSecao:= 'Itens' + IntToStrZero(I + 1, 3);

    AINIRec.WriteString(sSecao, 'ItemListaServico', NFSe.Servico.ItemServico[I].ItemListaServico);
    AINIRec.WriteString(sSecao, 'CodigoCnae', NFSe.Servico.ItemServico[I].CodigoCnae);
    AINIRec.WriteString(sSecao, 'Descricao', ChangeLineBreak(NFSe.Servico.ItemServico[I].Descricao, FpAOwner.ConfigGeral.QuebradeLinha));
    AINIRec.WriteString(sSecao, 'Tributavel', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].Tributavel));
    AINIRec.WriteFloat(sSecao, 'Quantidade', NFSe.Servico.ItemServico[I].Quantidade);
    AINIRec.WriteFloat(sSecao, 'ValorUnitario', NFSe.Servico.ItemServico[I].ValorUnitario);
    AINIRec.WriteFloat(sSecao, 'DescontoIncondicionado', NFSe.Servico.ItemServico[I].DescontoIncondicionado);
    AINIRec.WriteFloat(sSecao, 'ValorTotal', NFSe.Servico.ItemServico[I].ValorTotal);

    GerarINISecaoDadosDeducao(AINIRec, NFSe.Servico.ItemServico[I], I);
  end;
end;

function TNFSeW_Elotech203.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
begin
  Result := inherited GerarInfDeclaracaoPrestacaoServico;

  if (NFSe.IBSCBS.dest.xNome <> '') or (NFSe.IBSCBS.imovel.cCIB <> '') or
     (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum) then
    Result.AppendChild(GerarXMLIBSCBS(NFSe.IBSCBS));
end;

procedure TNFSeW_Elotech203.GerarINISecaoDadosDeducao(
  const AINIRec: TMemIniFile; Item: TItemServicoCollectionItem;
  const AIndice: Integer);
var
  sSecao: string;
begin
  sSecao := 'DadosDeducao' + IntToStrZero(AIndice + 1, 3);

  AINIRec.WriteString(sSecao, 'TipoDeducao', FpAOwner.TipoDeducaoToStr(Item.DadosDeducao.TipoDeducao));
  AINIRec.WriteString(sSecao, 'CpfCnpj', Item.DadosDeducao.CpfCnpj);
  AINIRec.WriteString(sSecao, 'NumeroNotaFiscalReferencia', Item.DadosDeducao.NumeroNotaFiscalReferencia);
  AINIRec.WriteFloat(sSecao, 'ValorTotalNotaFiscal', Item.DadosDeducao.ValorTotalNotaFiscal);
  AINIRec.WriteFloat(sSecao, 'PercentualADeduzir', Item.DadosDeducao.PercentualADeduzir);
  AINIRec.WriteFloat(sSecao, 'ValorADeduzir', Item.DadosDeducao.ValorADeduzir);
end;

end.
