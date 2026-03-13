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

unit DBSeller.GravarXml;

interface

uses
  SysUtils,
  Classes,
  StrUtils,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrDFeUtil,
  ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXConsts,
  ACBrNFSeXGravarXml_ABRASFv1,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_DBSeller }

  TNFSeW_DBSeller = class(TNFSeW_ABRASFv1)
  protected
    procedure Configuracao; override;

  end;

  { TNFSeW_DBSeller204 }

  TNFSeW_DBSeller204 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
    function GeraAtividadeEvento: TACBrXmlNode; override;
    function GerarIdentificacaoNFSe(const AIndex: Integer): TACBrXmlNode;
    function GerarIdentificacaoNFe(const AIndex: Integer): TACBrXmlNode;
    function GerarIdentificacaoOutroDoc(const AIndex: Integer): TACBrXmlNode;
    function GerarIdentificacaoDocumentosDeducao(const AIndex: Integer): TACBrXmlNode;
    function GerarIdentificacaoFornecedor(const AIndex: Integer): TACBrXmlNode;
    function GerarFornecedorExterior(const AIndex: Integer): TACBrXmlNode;
    function GerarDadosFornecedor(const AIndex: Integer): TACBrXmlNode;
    function GerarDadosDeducao: TACBrXmlNodeArray;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
  end;

implementation

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     DBSeller
//==============================================================================

{ TNFSeW_DBSeller }

procedure TNFSeW_DBSeller.Configuracao;
begin
  inherited Configuracao;

  NrOcorrRegimeEspecialTributacao := -1;
end;

{ TNFSeW_DBSeller204 }

procedure TNFSeW_DBSeller204.Configuracao;
begin
  inherited Configuracao;

  TagTomador := 'TomadorServico';

  NrOcorrCodigoPaisTomador := -1;
  NrOcorrCodigoPaisServico := -1;

  NrOcorrInformacoesComplemetares := 0;
  NrOcorrValorDeducoes := 1;
  NrOcorrValorISS := 1;
  NrOcorrAliquota := 1;
  NrOcorrDescIncond := 1;
  NrOcorrDescCond := 1;
  NrOcorrOutrasRet := 1;
  NrOcorrValTotTrib := 1;
  NrOcorrValorPis := 1;
  NrOcorrValorCofins := 1;
  NrOcorrValorInss := 1;
  NrOcorrValorIr := 1;
  NrOcorrValorCsll := 1;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;
  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
  GerarAtividadeEventoAposIncentivoFiscal := True;
end;

function TNFSeW_DBSeller204.GeraAtividadeEvento: TACBrXmlNode;
var
  lNomeTagEvt, lValorTagEvt: String;
begin
  Result := nil;
  if (Trim(NFSe.Servico.Evento.xNome) <> EmptyStr) or
     (Trim(NFSe.Servico.Evento.idAtvEvt) <> EmptyStr) then
  begin
    Result := CreateElement('Evento');

    if NFSe.Servico.Evento.xNome <> EmptyStr then
    begin
      lNomeTagEvt := 'DescricaoEvento';
      lValorTagEvt := NFSe.Servico.Evento.xNome;
    end else
    begin
      lNomeTagEvt := 'IdentificacaoEvento';
      lValorTagEvt := NFSe.Servico.Evento.idAtvEvt;
    end;
    Result.AppendChild(AddNode(tcStr, '#1', lNomeTagEvt, 1, 255, 1, lValorTagEvt, ''));
  end;
end;

function TNFSeW_DBSeller204.GerarDadosDeducao: TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, NFSe.Servico.Valores.DocDeducao.Count);
  for I := 0 to NFSe.Servico.Valores.DocDeducao.Count - 1 do
  begin
    Result[I] := CreateElement('Deducao');

    Result[I].AppendChild(AddNode(tcStr, '#1', 'TipoDeducao', 1, 2, 0,
                              FpAOwner.tpDedRedToStr(NFSe.Servico.Valores.DocDeducao[I].tpDedRed), ''));

    Result[I].AppendChild(AddNode(tcStr, '#2', 'DescricaoDeducao', 1, 150, 0,
                               NFSe.Servico.Valores.DocDeducao[I].xDescOutDed, ''));

    Result[I].AppendChild(GerarIdentificacaoDocumentosDeducao(I));

    Result[I].AppendChild(GerarDadosFornecedor(I));
  end;
end;

function TNFSeW_DBSeller204.GerarDadosFornecedor(const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('DadosFornecedor');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];

  if lDocDeducao.fornec.Identificacao.Nif <> EmptyStr then
    Result.AppendChild(GerarFornecedorExterior(AIndex))
  else
    Result.AppendChild(GerarIdentificacaoFornecedor(AIndex));
end;

function TNFSeW_DBSeller204.GerarFornecedorExterior(
  const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('FornecedorExterior');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];
  
  Result.AppendChild(AddNode(tcStr, '#1', 'NifFornecedor', 1, 40, 0,
                             lDocDeducao.fornec.Identificacao.Nif, ''));
  Result.AppendChild(AddNode(tcStr, '#2', 'CodigoPais', 1, 4, 1,
                             lDocDeducao.fornec.Endereco.CodigoPais, ''));
end;

function TNFSeW_DBSeller204.GerarIdentificacaoDocumentosDeducao(const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('IdentificacaoDocumentoDeducao');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];
  if lDocDeducao.NFSeMun.cMunNFSeMun <> EmptyStr then
    Result.AppendChild(GerarIdentificacaoNFSe(AIndex))
  else if lDocDeducao.chNFe <> EmptyStr then
    Result.AppendChild(GerarIdentificacaoNFe(AIndex))
  else
    Result.AppendChild(GerarIdentificacaoOutroDoc(AIndex));
end;

function TNFSeW_DBSeller204.GerarIdentificacaoFornecedor(
  const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('IdentificacaoFornecedor');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];
  Result.AppendChild(GerarCPFCNPJ(lDocDeducao.fornec.Identificacao.CpfCnpj));
end;

function TNFSeW_DBSeller204.GerarIdentificacaoNFe(
  const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('IdentificacaoNfe');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];
    
  Result.AppendChild(AddNode(tcInt, '#1','NumeroNfe', 1, 9, 1,
                     lDocDeducao.nDocFisc, ''));

  Result.AppendChild(AddNode(tcStr, '#2','UfNfe', 2, 2, 1,
                     CodigoUFParaUF(ExtrairUFChaveAcesso(lDocDeducao.chNFe)), ''));

  Result.AppendChild(AddNode(tcInt, '#3','ChaveAcessoNfe', 44, 44, 0,
                     lDocDeducao.chNFe, ''));
end;

function TNFSeW_DBSeller204.GerarIdentificacaoNFSe(
  const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('IdentificacaoNfse');

  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];
    
  Result.AppendChild(AddNode(tcInt, '#1','CodigoMunicipioGerador', 1, 7, 1,
                     lDocDeducao.NFSeMun.cMunNFSeMun, ''));

  Result.AppendChild(AddNode(tcInt, '#2','NumeroNfse', 1, 15, 1,
                     lDocDeducao.NFSeMun.nNFSeMun, ''));

  Result.AppendChild(AddNode(tcStr, '#3','CodigoVerificacao', 1, 9, 0,
                     lDocDeducao.NFSeMun.cVerifNFSeMun, ''));
end;

function TNFSeW_DBSeller204.GerarIdentificacaoOutroDoc(
  const AIndex: Integer): TACBrXmlNode;
var
  lDocDeducao: TDocDeducaoCollectionItem;
begin
  Result := CreateElement('OutroDocumento');
  
  lDocDeducao := NFSe.Servico.Valores.DocDeducao[AIndex];  
  Result.AppendChild(AddNode(tcStr, '#1', 'IdentificacaoDocumento', 1, 255, 1,
                     lDocDeducao.nDoc, ''));
end;

function TNFSeW_DBSeller204.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  lNodeArray: TACBrXMLNodeArray;
  I: Integer;
begin
  Result := inherited GerarInfDeclaracaoPrestacaoServico;

  lNodeArray := GerarDadosDeducao;
  if Assigned(lNodeArray) then
  begin
    for I := 0 to Length(lNodeArray) - 1 do
      Result.AppendChild(lNodeArray[I]);
  end;
end;

function TNFSeW_DBSeller204.GerarServico: TACBrXmlNode;
var
  item, lcIndOP, lcClassTrib, lNaoExigencia: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  if GerarTagServicos then
  begin
    Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, NrOcorrIssRetido,
      FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

    Result.AppendChild(AddNode(tcStr, '#21', 'ResponsavelRetencao', 1, 1, NrOcorrRespRetencao,
     FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), DSC_INDRESPRET));

    item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

    Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, NrOcorrItemListaServico,
                                                          item, DSC_CLISTSERV));

    Result.AppendChild(AddNode(tcStr, '#30', 'CodigoCnae', 1, 9, NrOcorrCodigoCNAE,
                                OnlyNumber(NFSe.Servico.CodigoCnae), DSC_CNAE));

    Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoMunicipio', 1, 20, NrOcorrCodTribMun_1,
                     NFSe.Servico.CodigoTributacaoMunicipio, DSC_CSERVTRIBMUN));

    Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNbs', 1, 9, NrOcorrCodigoNBS,
                                             NFSe.Servico.CodigoNBS, DSC_CMUN));

    lcIndOp := NFSe.IBSCBS.cIndOp;
    if Trim(lcIndOp) = EmptyStr then
      lcIndOp := NFSe.Servico.INDOP;
    Result.AppendChild(AddNode(tcStr, '#39', 'cIndOp', 6, 6, 1, lcIndOp, ''));

    lcClassTrib := NFSe.IBSCBS.valores.trib.gIBSCBS.cClassTrib;
    if Trim(lcClassTrib) = EmptyStr then
      lcClassTrib := NFSe.Servico.cClassTrib;
    Result.AppendChild(AddNode(tcStr, '#40', 'cClassTrib', 6, 6, 1, lcClassTrib, ''));

    Result.AppendChild(AddNode(tcStr, '#33', 'Discriminacao', 1, 2000, NrOcorrDiscriminacao_2,
      StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

    Result.AppendChild(AddNode(tcStr, '#34', 'CodigoMunicipio', 1, 7, NrOcorrCodigoMunic_2,
                           OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

    Result.AppendChild(GerarCodigoPaisServico);

    Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
                               NrMinExigISS, NrMaxExigISS, NrOcorrExigibilidadeISS,
    StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

    lNaoExigencia:= DSC_INDISS;
    lNaoExigencia:= StringReplace(lNaoExigencia,  ' da ', ' da não ', [rfReplaceAll]);

    Result.AppendChild(AddNode(tcInt, '#37', 'IdentifNaoExigibilidade', 1, 4, 1,
        StrToIntDef(NFSe.Servico.IdentifNaoExigibilidade, 0), lNaoExigencia));

    Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, NrOcorrMunIncid,
                                NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

    Result.AppendChild(AddNode(tcStr, '#38', 'NumeroProcesso', 1, 30, NrOcorrNumProcesso,
                                   NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));
  end;
end;

function TNFSeW_DBSeller204.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                             NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, NrOcorrValorDeducoes,
                            NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, NrOcorrValorPis,
                                      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, NrOcorrValorCofins,
                                NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, NrOcorrValorInss,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, NrOcorrValorIr,
                                        NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, NrOcorrValorCsll,
                                    NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, NrOcorrOutrasRet,
                    NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#23', 'ValTotTributos', 1, 15, NrOcorrValTotTrib,
                                  NFSe.Servico.Valores.ValorTotalTributos, ''));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, NrOcorrValorISS,
                                      NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, NrOcorrAliquota,
                                                          Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#27', 'DescontoIncondicionado', 1, 15, NrOcorrDescIncond,
                 NFSe.Servico.Valores.DescontoIncondicionado, DSC_VDESCINCOND));

  Result.AppendChild(AddNode(tcDe2, '#28', 'DescontoCondicionado', 1, 15, NrOcorrDescCond,
                     NFSe.Servico.Valores.DescontoCondicionado, DSC_VDESCCOND));

  Result.AppendChild(AddNode(tcDe2, '#29', 'vReceb', 1, 15, 0, NFSe.Servico.Valores.ValorRecebido, ''));
end;

end.
