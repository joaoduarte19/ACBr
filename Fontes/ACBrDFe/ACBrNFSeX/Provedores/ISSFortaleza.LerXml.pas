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

unit ISSFortaleza.LerXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXClass,
  ACBrXmlDocument,
  ACBrNFSeXLerXml_ABRASFv1;

type
  { TNFSeR_ISSFortaleza }

  TNFSeR_ISSFortaleza = class(TNFSeR_ABRASFv1)
  protected
    procedure LerXMLIBSCBS(const aNode: TACBrXmlNode);

    procedure LerXMLDestinatario(const aNode: TACBrXmlNode; Dest: TDadosdaPessoa); override;
    procedure LerXMLEnderecoDestinatario(const aNode: TACBrXmlNode; ender: Tender); override;
    procedure LerXMLContatoDestinatario(const aNode: TACBrXmlNode; Dest: TDadosdaPessoa);

    procedure LerXMLImovel(const aNode: TACBrXmlNode; Imovel: TDadosimovel); override;
    procedure LerXMLEnderecoNacionalImovel(const aNode: TACBrXmlNode; ender: TenderImovel); override;

    procedure LerXMLIBSCBSValores(const aNode: TACBrXmlNode; valores: Tvalorestrib); override;

    procedure LerXMLgReeRepRes(const aNode: TACBrXmlNode; gReeRepRes: TgReeRepRes); override;
    procedure LerXMLdFeNacional(const aNode: TACBrXmlNode; dFeNacional: TdFeNacional); override;
    procedure LerXMLdocFiscalOutro(const aNode: TACBrXmlNode; docFiscalOutro: TdocFiscalOutro); override;
    procedure LerXMLdocOutro(const aNode: TACBrXmlNode; docOutro: TdocOutro); override;
    procedure LerXMLfornec(const aNode: TACBrXmlNode; fornec: Tfornec); override;

    procedure LerXMLTributos(const aNode: TACBrXmlNode; trib: Ttrib); override;
    procedure LerXMLgIBSCBS(const aNode: TACBrXmlNode; gIBSCBS: TgIBSCBS); override;
    procedure LerXMLgTribRegular(const aNode: TACBrXmlNode; gTribRegular: TgTribRegular); override;
    procedure LerXMLgDif(const aNode: TACBrXmlNode; gDif: TgDif); override;
                                                              
    procedure LerServico(const aNode: TACBrXmlNode); override;
    procedure LerConstrucaoCivil(const aNode: TACBrXmlNode); override;
    procedure LerAtividadeEvento(const aNode: TACBrXmlNode); override;
    procedure LerEndereco(const aNode: TACBrXmlNode; aEndereco: TEndereco);
  public
    function LerXmlRps(const aNode: TACBrXmlNode): Boolean; override;
  end;

implementation

uses
  ACBrNFSeXConversao,
  ACBrDFe.Conversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     ISSFortaleza
//==============================================================================

{ TNFSeR_ISSFortaleza }

procedure TNFSeR_ISSFortaleza.LerXMLIBSCBS(const aNode: TACBrXmlNode);
var
  IbsCbsNode, gNFSeRefNode: TACBrXmlNode;
  chavesNFSeNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(aNode) then Exit;

  IbsCbsNode := aNode.Childrens.FindAnyNs('IbsCbs');
  if not Assigned(IbsCbsNode) then Exit;
                                
  NFSe.IBSCBS.finNFSe := StrTofinNFSe(ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('CodigoIndicadorFinalidadeNFSe'), tcStr));
  NFSe.IBSCBS.indFinal := StrToindFinal(ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('CodigoIndicadorOperacaoUsoConsumoPessoal'), tcStr));
  NFSe.IBSCBS.cIndOp := ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('CodigoIndicadorOperacao'), tcStr);
  NFSe.IBSCBS.tpOper := StrTotpOperGovNFSe(ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('TipoOp'), tcStr));
  NFSe.IBSCBS.tpEnteGov := StrTotpEnteGov(ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('TipoEnteGovernamental'), tcStr));
  NFSe.IBSCBS.indDest := StrToindDest(ObterConteudo(IbsCbsNode.Childrens.FindAnyNs('IndDest'), tcStr));

  gNFSeRefNode := IbsCbsNode.Childrens.Find('GrupoNFSeReferenciada');
  if Assigned(gNFSeRefNode) then
  begin
    chavesNFSeNodes := gNFSeRefNode.Childrens.FindAll('ChaveNFSeReferenciada');
    if Assigned(chavesNFSeNodes) then
      for i := 0 to Length(chavesNFSeNodes) - 1 do
        LerXMLgRefNFSe(chavesNFSeNodes[i]);
  end;
        
  LerXMLDestinatario(IbsCbsNode.Childrens.FindAnyNs('Destinatario'), NFSe.IBSCBS.dest);
  LerXMLImovel(IbsCbsNode.Childrens.FindAnyNs('Imovel'), NFSe.IBSCBS.imovel);
  LerXMLIBSCBSValores(IbsCbsNode.Childrens.FindAnyNs('Valores'), NFSe.IBSCBS.valores);
end;

procedure TNFSeR_ISSFortaleza.LerXMLDestinatario(const aNode: TACBrXmlNode; Dest: TDadosdaPessoa);
var
  oK: Boolean;
  enderecoNode: TACBrXmlNode;
begin
  if not Assigned(aNode) then Exit;

  NFSe.IBSCBS.dest.CNPJCPF := ObterCNPJCPF(aNode);
  NFSe.IBSCBS.dest.NIF := ObterConteudo(aNode.Childrens.FindAnyNs('Nif'), tcStr);
  NFSe.IBSCBS.dest.cNaoNIF := StrToNaoNIF(Ok, ObterConteudo(aNode.Childrens.FindAnyNs('NaoNif'), tcStr));
  NFSe.IBSCBS.dest.xNome := ObterConteudo(aNode.Childrens.FindAnyNs('Nome'), tcStr);

  LerXMLEnderecoDestinatario(aNode.Childrens.FindAnyNs('Endereco'), Dest.ender);
  LerXMLContatoDestinatario(aNode.Childrens.FindAnyNs('Contato'), Dest);
end;

procedure TNFSeR_ISSFortaleza.LerXMLEnderecoDestinatario(const aNode: TACBrXmlNode; ender: Tender);
begin
  if not Assigned(aNode) then Exit;

  NFSe.IBSCBS.dest.ender.xLgr := ObterConteudo(aNode.Childrens.FindAnyNs('Endereco'), tcStr);
  NFSe.IBSCBS.dest.ender.nro := ObterConteudo(aNode.Childrens.FindAnyNs('Numero'), tcStr);
  NFSe.IBSCBS.dest.ender.xCpl := ObterConteudo(aNode.Childrens.FindAnyNs('Complemento'), tcStr);
  NFSe.IBSCBS.dest.ender.xBairro := ObterConteudo(aNode.Childrens.FindAnyNs('Bairro'), tcStr);
  NFSe.IBSCBS.dest.ender.endNac.cMun := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoMunicipio'), tcInt);
  NFSe.IBSCBS.dest.ender.endNac.UF := ObterConteudo(aNode.Childrens.FindAnyNs('Uf'), tcStr);
  NFSe.IBSCBS.dest.ender.endNac.CEP := ObterConteudo(aNode.Childrens.FindAnyNs('Cep'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLContatoDestinatario(const aNode: TACBrXmlNode; Dest: TDadosdaPessoa);
begin
  if not Assigned(aNode) then Exit;

  NFSe.IBSCBS.dest.fone := ObterConteudo(aNode.Childrens.FindAnyNs('Telefone'), tcStr);
  NFSe.IBSCBS.dest.email := ObterConteudo(aNode.Childrens.FindAnyNs('Email'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLImovel(const aNode: TACBrXmlNode; Imovel: TDadosimovel);
begin
  if not Assigned(aNode) then Exit;

  Imovel.inscImobFisc := ObterConteudo(aNode.Childrens.FindAnyNs('InscImobFisc'), tcStr);
  Imovel.cCIB := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoCIB'), tcStr);

  LerXMLEnderecoNacionalImovel(aNode.Childrens.FindAnyNs('Endereco'), Imovel.ender);
end;

procedure TNFSeR_ISSFortaleza.LerXMLEnderecoNacionalImovel(const aNode: TACBrXmlNode; ender: TenderImovel);
begin
  if not Assigned(aNode) then Exit;

  ender.xLgr := ObterConteudo(aNode.Childrens.FindAnyNs('Endereco'), tcStr);
  ender.nro := ObterConteudo(aNode.Childrens.FindAnyNs('Numero'), tcStr);
  ender.xCpl := ObterConteudo(aNode.Childrens.FindAnyNs('Complemento'), tcStr);
  ender.xBairro := ObterConteudo(aNode.Childrens.FindAnyNs('Bairro'), tcStr);
  ender.CodigoMunicipio := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);
  ender.UF := ObterConteudo(aNode.Childrens.FindAnyNs('Uf'), tcStr);
  ender.CEP := ObterConteudo(aNode.Childrens.FindAnyNs('Cep'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLIBSCBSValores(const aNode: TACBrXmlNode; valores: Tvalorestrib);
begin
  if not Assigned(aNode) then Exit;

  LerXMLgReeRepRes(aNode.Childrens.FindAnyNs('GrupoReeRepRes'), valores.gReeRepRes);
  LerXMLTributos(aNode.Childrens.FindAnyNs('TributosIbsCbs'), valores.trib);
end;

procedure TNFSeR_ISSFortaleza.LerXMLgReeRepRes(const aNode: TACBrXmlNode; gReeRepRes: TgReeRepRes);
var
  i: Integer;
  wValor: Double;
  wTipoDesc: String;
  wTipo: TtpReeRepRes;
  wNodes: TACBrXmlNodeArray;
  wEmissao, wCompetencia: TDateTime;
begin
  if not Assigned(aNode) then Exit;

  wEmissao := ObterConteudo(aNode.Childrens.FindAnyNs('DataEmissaoDocumento'), tcDat);
  wCompetencia := ObterConteudo(aNode.Childrens.FindAnyNs('DataCompetenciaDocumento'), tcDat);
  wTipo := StrTotpReeRepRes(ObterConteudo(aNode.Childrens.FindAnyNs('TipoReeRepRes'), tcStr));
  wTipoDesc := ObterConteudo(aNode.Childrens.FindAnyNs('DescTipoReeRepRes'), tcStr);
  wValor := ObterConteudo(aNode.Childrens.FindAnyNs('ValorReeRepRes'), tcDe2);

  wNodes := aNode.Childrens.FindAllAnyNs('Documentos');
  if (not Assigned(wNodes)) then Exit;

  for i := 0 to Length(wNodes) - 1 do
  begin
    gReeRepRes.documentos.New;
    with gReeRepRes.documentos[i] do
    begin
      LerXMLdFeNacional(wNodes[i].Childrens.FindAnyNs('DocumentosFiscaisEletronicos'), gReeRepRes.documentos[i].dFeNacional);
      LerXMLdocFiscalOutro(wNodes[i].Childrens.FindAnyNs('DocumentosFiscaisOutro'), gReeRepRes.documentos[i].docFiscalOutro);
      LerXMLdocOutro(wNodes[i].Childrens.FindAnyNs('DocumentosOutro'), gReeRepRes.documentos[i].docOutro);
      LerXMLfornec(wNodes[i].Childrens.FindAnyNs('Fornecedor'), gReeRepRes.documentos[i].fornec);

      dtEmiDoc := wEmissao;
      dtCompDoc := wCompetencia;
      tpReeRepRes := wTipo;
      xTpReeRepRes := wTipoDesc;
      vlrReeRepRes := wValor;
    end;
  end;
end;

procedure TNFSeR_ISSFortaleza.LerXMLdFeNacional(const aNode: TACBrXmlNode; dFeNacional: TdFeNacional);
begin
  if not Assigned(aNode) then Exit;

  dFeNacional.tipoChaveDFe := StrTotipoChaveDFe(ObterConteudo(aNode.Childrens.FindAnyNs('TipoChaveDFe'), tcStr));
  dFeNacional.xTipoChaveDFe := ObterConteudo(aNode.Childrens.FindAnyNs('DescTipoChaveDFe'), tcStr);
  dFeNacional.chaveDFe := ObterConteudo(aNode.Childrens.FindAnyNs('ChaveDFe'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLdocFiscalOutro(const aNode: TACBrXmlNode; docFiscalOutro: TdocFiscalOutro);
begin
  if not Assigned(aNode) then Exit;

  docFiscalOutro.cMunDocFiscal := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoMunicipioDocFiscal'), tcInt);
  docFiscalOutro.nDocFiscal := ObterConteudo(aNode.Childrens.FindAnyNs('NumeroDocumentoFiscal'), tcStr);
  docFiscalOutro.xDocFiscal := ObterConteudo(aNode.Childrens.FindAnyNs('DescTipoChaveDFe'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLdocOutro(const aNode: TACBrXmlNode; docOutro: TdocOutro);
begin
  if not Assigned(aNode) then Exit;

  docOutro.nDoc := ObterConteudo(aNode.Childrens.FindAnyNs('NumeroDocumentoOutro'), tcStr);
  docOutro.xDoc := ObterConteudo(aNode.Childrens.FindAnyNs('DescDocumentoOutro'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLfornec(const aNode: TACBrXmlNode; fornec: Tfornec);
var
  Ok: Boolean;
begin
  if not Assigned(aNode) then Exit;

  fornec.CNPJCPF := ObterCNPJCPF(aNode);
  fornec.NIF := ObterConteudo(aNode.Childrens.FindAnyNs('Nif'), tcStr);
  fornec.cNaoNIF := StrToNaoNIF(Ok, ObterConteudo(aNode.Childrens.FindAnyNs('NaoNif'), tcStr));
  fornec.xNome := ObterConteudo(aNode.Childrens.FindAnyNs('Nome'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLTributos(const aNode: TACBrXmlNode; trib: Ttrib);
begin
  if not Assigned(aNode) then Exit;

  LerXMLgIBSCBS(aNode.Childrens.FindAnyNs('GrupoIbsCbs'), trib.gIBSCBS);
end;

procedure TNFSeR_ISSFortaleza.LerXMLgIBSCBS(const aNode: TACBrXmlNode; gIBSCBS: TgIBSCBS);
begin
  if not Assigned(aNode) then Exit;

  gIBSCBS.CST := StrToCSTIBSCBS(ObterConteudo(aNode.Childrens.FindAnyNs('CST'), tcStr));
  gIBSCBS.cClassTrib := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoClassTrib'), tcStr);
  gIBSCBS.cCredPres := StrTocCredPres(ObterConteudo(aNode.Childrens.FindAnyNs('CodigoCreditoPresumido'), tcStr));

  LerXMLgTribRegular(aNode.Childrens.FindAnyNs('GrupoInfoTributacaoRegular'), gIBSCBS.gTribRegular);
  LerXMLgDif(aNode.Childrens.FindAnyNs('GrupoDiferimento'), gIBSCBS.gDif);
end;

procedure TNFSeR_ISSFortaleza.LerXMLgTribRegular(const aNode: TACBrXmlNode; gTribRegular: TgTribRegular);
begin
  if not Assigned(aNode) then Exit;

  gTribRegular.CSTReg := StrToCSTIBSCBS(ObterConteudo(aNode.Childrens.FindAnyNs('CodigoSitTribReg'), tcStr));
  gTribRegular.cClassTribReg := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoClassTribReg'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerXMLgDif(const aNode: TACBrXmlNode; gDif: TgDif);
begin
  if not Assigned(aNode) then Exit;

  gDif.pDifUF := ObterConteudo(aNode.Childrens.FindAnyNs('PercentualDiferimentoIbsUf'), tcDe2);
  gDif.pDifMun := ObterConteudo(aNode.Childrens.FindAnyNs('PercentualDiferimentoIbsMun'), tcDe2);
  gDif.pDifCBS := ObterConteudo(aNode.Childrens.FindAnyNs('PercentualDiferimentoCbs'), tcDe2);
end;

procedure TNFSeR_ISSFortaleza.LerServico(const aNode: TACBrXmlNode);
var
  servicoNode: TACBrXmlNode;
begin
  inherited LerServico(aNode);
                     
  if not Assigned(aNode) then Exit;

  servicoNode := aNode.Childrens.FindAnyNs('Servico');
  if Assigned(servicoNode) then
    NFSe.Servico.CodigoNBS := ObterConteudo(servicoNode.Childrens.FindAnyNs('CodigoNbs'), tcStr);
end;

procedure TNFSeR_ISSFortaleza.LerConstrucaoCivil(const aNode: TACBrXmlNode);
var
  construcaoCivilNode: TACBrXmlNode;
begin
  inherited LerConstrucaoCivil(aNode);

  construcaoCivilNode := aNode.Childrens.FindAnyNs('ConstrucaoCivil');
  if Assigned(construcaoCivilNode) then
    LerEndereco(construcaoCivilNode.Childrens.FindAnyNs('Endereco'), NFSe.ConstrucaoCivil.Endereco);
end;

procedure TNFSeR_ISSFortaleza.LerAtividadeEvento(const aNode: TACBrXmlNode);
var
  eventosNode: TACBrXmlNode;
begin
  if not Assigned(aNode) then Exit;

  eventosNode := aNode.Childrens.FindAnyNs('Eventos');
  if not Assigned(eventosNode) then Exit;

  NFSe.Servico.Evento.xNome := ObterConteudo(eventosNode.Childrens.FindAnyNs('NomeEvento'), tcStr);
  NFSe.Servico.Evento.dtIni := ObterConteudo(eventosNode.Childrens.FindAnyNs('DataInicioEvento'), tcStr);
  NFSe.Servico.Evento.dtFim := ObterConteudo(eventosNode.Childrens.FindAnyNs('DataFimEvento'), tcStr);
  NFSe.Servico.Evento.idAtvEvt := ObterConteudo(eventosNode.Childrens.FindAnyNs('IdentificacaoEvento'), tcStr);

  LerEndereco(eventosNode.Childrens.FindAnyNs('Endereco'), NFSe.Servico.Evento.Endereco);
end;

procedure TNFSeR_ISSFortaleza.LerEndereco(const aNode: TACBrXmlNode; aEndereco: TEndereco);
begin
  if not Assigned(aNode) then Exit;

  aEndereco.Endereco := ObterConteudo(aNode.Childrens.FindAnyNs('Endereco'), tcStr);
  aEndereco.Numero := ObterConteudo(aNode.Childrens.FindAnyNs('Numero'), tcStr);
  aEndereco.Complemento := ObterConteudo(aNode.Childrens.FindAnyNs('Complemento'), tcStr);
  aEndereco.Bairro := ObterConteudo(aNode.Childrens.FindAnyNs('Bairro'), tcStr);
  aEndereco.CodigoMunicipio := ObterConteudo(aNode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);
  aEndereco.UF := ObterConteudo(aNode.Childrens.FindAnyNs('Uf'), tcStr);
  aEndereco.CEP := ObterConteudo(aNode.Childrens.FindAnyNs('Cep'), tcStr);
end;

function TNFSeR_ISSFortaleza.LerXmlRps(const aNode: TACBrXmlNode): Boolean;
var
  infRpsNode: TACBrXmlNode;
begin
  Result := inherited LerXmlRps(aNode);

  if not Assigned(aNode) then Exit;

  infRpsNode := ANode.Childrens.FindAnyNs('InfRps');
  if Assigned(infRpsNode) then
    LerXMLIBSCBS(infRpsNode);
end;

end.
