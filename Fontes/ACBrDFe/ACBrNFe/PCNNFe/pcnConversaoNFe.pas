////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcnConversaoNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Utilize a unit ACBrNFe.Conversao no lugar dessa' {$ENDIF};

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrBase,
  ACBrDFe.Conversao,
  ACBrNFe.Conversao;

{$IFDEF FPC}
  {$DEFINE SUPPORTS_SCOPEDENUMS}
{$ENDIF}
{$IFDEF DELPHI2009_UP}
  {$DEFINE SUPPORTS_SCOPEDENUMS}
{$ENDIF}

type
  TpcnIndicadorPagamento = ACBrNFe.Conversao.TIndicadorPagamento;
  TpcnPercentualTributos = ACBrNFe.Conversao.TPercentualTributos;
  TpcnDeterminacaoBaseIcms = ACBrNFe.Conversao.TDeterminacaoBaseIcms;
  TpcnDeterminacaoBaseIcmsST = ACBrNFe.Conversao.TDeterminacaoBaseIcmsST;
  TpcnMotivoDesoneracaoICMS = ACBrNFe.Conversao.TMotivoDesoneracaoICMS;
  TpcnCstIpi = ACBrNFe.Conversao.TCstIpi;
  TpcnIndicadorProcesso = ACBrNFe.Conversao.TIndicadorProcesso;
  TpcnCRT = ACBrNFe.Conversao.TCRT;
  TpcnIndicadorTotal = ACBrNFe.Conversao.TIndicadorTotal;
  TpcnECFModRef = ACBrNFe.Conversao.TECFModRef;
  TpcnISSQNcSitTrib = ACBrNFe.Conversao.TISSQNcSitTrib;
  TpcnImprimeDescAcrescItem = ACBrNFe.Conversao.TImprimeDescAcrescItem;
  TImprimirUnidQtdeValor = ACBrNFe.Conversao.TImprimirUnidQtdeValor;
  TpcnDestinoOperacao = ACBrNFe.Conversao.TDestinoOperacao;
  TpcnConsumidorFinal = ACBrNFe.Conversao.TConsumidorFinal;
  TpcnPresencaComprador = ACBrNFe.Conversao.TPresencaComprador;
  TpcnFormaPagamento = ACBrNFe.Conversao.TTipoPagamento;
  TpcnBandeiraCartao = ACBrNFe.Conversao.TBandeiraCartao;
  TpcnTipoViaTransp = ACBrNFe.Conversao.TTipoViaTransp;
  TpcnTipoIntermedio = ACBrNFe.Conversao.TTipoIntermedio;
  TpcnindISSRet = ACBrNFe.Conversao.TindISSRet;
  TpcnindISS = ACBrNFe.Conversao.TindISS;
  TpcnTipoAutor = ACBrNFe.Conversao.TTipoAutor;
  TpcnIndOperacao = ACBrNFe.Conversao.TIndOperacao;
  TForcarGeracaoTag = ACBrNFe.Conversao.TForcarGeracaoTag;
  TIndSomaPISST = ACBrNFe.Conversao.TIndSomaPISST;
  TIndSomaCOFINSST = ACBrNFe.Conversao.TIndSomaCOFINSST;
  TStatusACBrNFe = ACBrNFe.Conversao.TStatusACBrNFe;
  TpcnInformacoesDePagamento = ACBrNFe.Conversao.TInformacoesDePagamento;
  TpcnVersaoDF = ACBrNFe.Conversao.TVersaoDF;
  TSchemaNFe = ACBrNFe.Conversao.TSchemaNFe;
  TLayOut = ACBrNFe.Conversao.TLayOut;
  TpcnFinalidadeNFe = ACBrNFe.Conversao.TFinalidadeNFe;
  TpcnModeloDF = ACBrNFe.Conversao.TModeloDF;
  TpcnIndicadorNFe = ACBrNFe.Conversao.TIndicadorNFe;
  TpcnVersaoQrCode = ACBrNFe.Conversao.TVersaoQrCode;
  TpcnTipoOperacao = ACBrNFe.Conversao.TTipoOperacao;
  TpcnCondicaoVeiculo = ACBrNFe.Conversao.TCondicaoVeiculo;
  TpcnTipoArma = ACBrNFe.Conversao.TTipoArma;
  TpcnIndEscala = ACBrNFe.Conversao.TIndEscala;
  TpcnModalidadeFrete = ACBrNFe.Conversao.TModalidadeFrete;
  TAutorizacao = ACBrNFe.Conversao.TAutorizacao;
  TindIntermed = ACBrNFe.Conversao.TindIntermed;
  TtpAto = ACBrNFe.Conversao.TtpAto;
  TindImport = ACBrNFe.Conversao.TindImport;
  TmotRedAdRem = ACBrNFe.Conversao.TmotRedAdRem;
  TtpMotivo = ACBrNFe.Conversao.TtpMotivo;
  TtpGuia = ACBrNFe.Conversao.TtpGuia;
  // Reforma Tributária
  TtpNFCredito = ACBrNFe.Conversao.TtpNFCredito;

const
  // Enumerados do TIndicadorPagamento
  ipVista = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorPagamento.{$ENDIF}ipVista deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipPrazo = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorPagamento.{$ENDIF}ipPrazo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipOutras = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorPagamento.{$ENDIF}ipOutras deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorPagamento.{$ENDIF}ipNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TPercentualTributos
  ptValorProdutos = {$IFDEF SUPPORTS_SCOPEDENUMS}TPercentualTributos.{$ENDIF}ptValorProdutos deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPercentualTributos da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ptValorNF = {$IFDEF SUPPORTS_SCOPEDENUMS}TPercentualTributos.{$ENDIF}ptValorNF deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPercentualTributos da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ptPersonalizado = {$IFDEF SUPPORTS_SCOPEDENUMS}TPercentualTributos.{$ENDIF}ptPersonalizado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPercentualTributos da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TDeterminacaoBaseIcms
  dbiMargemValorAgregado = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcms.{$ENDIF}dbiMargemValorAgregado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcms da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbiPauta = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcms.{$ENDIF}dbiPauta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcms da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbiPrecoTabelado = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcms.{$ENDIF}dbiPrecoTabelado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcms da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbiValorOperacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcms.{$ENDIF}dbiValorOperacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcms da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbiNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcms.{$ENDIF}dbiNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcms da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TDeterminacaoBaseIcmsST
  dbisPrecoTabelado = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisPrecoTabelado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisListaNegativa = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisListaNegativa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisListaPositiva = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisListaPositiva deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisListaNeutra = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisListaNeutra deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisMargemValorAgregado = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisMargemValorAgregado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisPauta = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisPauta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  dbisValordaOperacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TDeterminacaoBaseIcmsST.{$ENDIF}dbisValordaOperacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDeterminacaoBaseIcmsST da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TMotivoDesoneracaoICMS
  mdiTaxi = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiTaxi deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiDeficienteFisico = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiDeficienteFisico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiProdutorAgropecuario = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiProdutorAgropecuario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiFrotistaLocadora = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiFrotistaLocadora deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiDiplomaticoConsular = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiDiplomaticoConsular deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiAmazoniaLivreComercio = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiAmazoniaLivreComercio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiSuframa = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiSuframa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiVendaOrgaosPublicos = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiVendaOrgaosPublicos deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiDeficienteCondutor = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiDeficienteCondutor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiDeficienteNaoCondutor = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiDeficienteNaoCondutor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiOrgaoFomento = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiOrgaoFomento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiOlimpiadaRio2016 = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiOlimpiadaRio2016 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mdiSolicitadoFisco = {$IFDEF SUPPORTS_SCOPEDENUMS}TMotivoDesoneracaoICMS.{$ENDIF}mdiSolicitadoFisco deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TMotivoDesoneracaoICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TCstIpi
  ipi00 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi00 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi01 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi01 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi02 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi02 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi03 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi03 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi04 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi04 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi05 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi05 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi49 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi49 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi50 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi50 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi51 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi51 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi52 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi52 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi53 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi53 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi54 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi54 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi55 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi55 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipi99 = {$IFDEF SUPPORTS_SCOPEDENUMS}TCstIpi.{$ENDIF}ipi99 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCstIpi da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndicadorProcesso
  ipSEFAZ = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipSEFAZ deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipJusticaFederal = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipJusticaFederal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipJusticaEstadual = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipJusticaEstadual deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipSecexRFB = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipSecexRFB deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipCONFAZ = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipCONFAZ deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ipOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorProcesso.{$ENDIF}ipOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorProcesso da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TCRT  ==> migrar para o ACBrDFe.Conversao
  crtSimplesNacional = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtSimplesNacional deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  crtSimplesExcessoReceita = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtSimplesExcessoReceita deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  crtRegimeNormal = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtRegimeNormal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  crtMEI = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtMEI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndicadorTotal
  itSomaTotalNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorTotal.{$ENDIF}itSomaTotalNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorTotal da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  itNaoSomaTotalNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorTotal.{$ENDIF}itNaoSomaTotalNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorTotal da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TECFModRef
  ECFModRefVazio = {$IFDEF SUPPORTS_SCOPEDENUMS}TECFModRef.{$ENDIF}ECFModRefVazio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TECFModRef da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ECFModRef2B = {$IFDEF SUPPORTS_SCOPEDENUMS}TECFModRef.{$ENDIF}ECFModRef2B deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TECFModRef da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ECFModRef2C = {$IFDEF SUPPORTS_SCOPEDENUMS}TECFModRef.{$ENDIF}ECFModRef2C deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TECFModRef da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ECFModRef2D = {$IFDEF SUPPORTS_SCOPEDENUMS}TECFModRef.{$ENDIF}ECFModRef2D deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TECFModRef da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TISSQNcSitTrib
  ISSQNcSitTribVazio = {$IFDEF SUPPORTS_SCOPEDENUMS}TISSQNcSitTrib.{$ENDIF}ISSQNcSitTribVazio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ISSQNcSitTribNORMAL = {$IFDEF SUPPORTS_SCOPEDENUMS}TISSQNcSitTrib.{$ENDIF}ISSQNcSitTribNORMAL deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ISSQNcSitTribRETIDA = {$IFDEF SUPPORTS_SCOPEDENUMS}TISSQNcSitTrib.{$ENDIF}ISSQNcSitTribRETIDA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ISSQNcSitTribSUBSTITUTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TISSQNcSitTrib.{$ENDIF}ISSQNcSitTribSUBSTITUTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ISSQNcSitTribISENTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TISSQNcSitTrib.{$ENDIF}ISSQNcSitTribISENTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TImprimeDescAcrescItem
  idaiSempre = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimeDescAcrescItem.{$ENDIF}idaiSempre deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimeDescAcrescItem da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  idaiNunca = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimeDescAcrescItem.{$ENDIF}idaiNunca deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimeDescAcrescItem da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  idaiComValor = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimeDescAcrescItem.{$ENDIF}idaiComValor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimeDescAcrescItem da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TImprimirUnidQtdeValor
  iuComercial = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimirUnidQtdeValor.{$ENDIF}iuComercial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimirUnidQtdeValor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iuTributavel = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimirUnidQtdeValor.{$ENDIF}iuTributavel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimirUnidQtdeValor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iuComercialETributavel = {$IFDEF SUPPORTS_SCOPEDENUMS}TImprimirUnidQtdeValor.{$ENDIF}iuComercialETributavel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TImprimirUnidQtdeValor da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TDestinoOperacao
  doInterna = {$IFDEF SUPPORTS_SCOPEDENUMS}TDestinoOperacao.{$ENDIF}doInterna deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDestinoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  doInterestadual = {$IFDEF SUPPORTS_SCOPEDENUMS}TDestinoOperacao.{$ENDIF}doInterestadual deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDestinoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  doExterior = {$IFDEF SUPPORTS_SCOPEDENUMS}TDestinoOperacao.{$ENDIF}doExterior deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDestinoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TConsumidorFinal
  cfNao = {$IFDEF SUPPORTS_SCOPEDENUMS}TConsumidorFinal.{$ENDIF}cfNao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TConsumidorFinal da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  cfConsumidorFinal = {$IFDEF SUPPORTS_SCOPEDENUMS}TConsumidorFinal.{$ENDIF}cfConsumidorFinal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TConsumidorFinal da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TPresencaComprador
  pcNao = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcNao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcPresencial = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcPresencial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcInternet = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcInternet deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcTeleatendimento = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcTeleatendimento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcEntregaDomicilio = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcEntregaDomicilio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcPresencialForaEstabelecimento = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcPresencialForaEstabelecimento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  pcOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TPresencaComprador.{$ENDIF}pcOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoPagamento
  fpDinheiro = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpDinheiro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpCheque = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpCheque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpCartaoCredito = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpCartaoCredito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpCartaoDebito = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpCartaoDebito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpCreditoLoja = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpCreditoLoja deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpValeAlimentacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpValeAlimentacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpValeRefeicao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpValeRefeicao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpValePresente = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpValePresente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpValeCombustivel = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpValeCombustivel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpDuplicataMercantil = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpDuplicataMercantil deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpBoletoBancario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpBoletoBancario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpDepositoBancario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpDepositoBancario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpPagamentoInstantaneo = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpPagamentoInstantaneo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpTransfBancario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpTransfBancario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpProgramaFidelidade = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpProgramaFidelidade deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpSemPagamento = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpSemPagamento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpRegimeEspecial = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpRegimeEspecial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpOutro = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpOutro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpPagamentoInstantaneoEstatico = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpPagamentoInstantaneoEstatico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpCreditoEmLojaPorDevolucao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpCreditoEmLojaPorDevolucao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpFalhaHardware = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpFalhaHardware deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpPagamentoPosterior = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpPagamentoPosterior deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpPagInstantaneoPIXAutomatico = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpPagInstantaneoPIXAutomatico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fpTEFBookTransfer = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPagamento.{$ENDIF}fpTEFBookTransfer deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TBandeiraCartao
  bcVisa = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcVisa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcMasterCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcMasterCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcAmericanExpress = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcAmericanExpress deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcSorocred = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcSorocred deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcDinersClub = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcDinersClub deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcElo = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcElo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcHipercard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcHipercard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcAura = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcAura deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcCabal = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcCabal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcAlelo = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcAlelo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcBanesCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcBanesCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcCalCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcCalCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcCredz = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcCredz deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcDiscover = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcDiscover deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcGoodCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcGoodCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcGreenCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcGreenCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcHiper = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcHiper deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcJcB = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcJcB deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcMais = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcMais deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcMaxVan = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcMaxVan deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcPolicard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcPolicard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcRedeCompras = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcRedeCompras deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcSodexo = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcSodexo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcValeCard = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcValeCard deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcVerocheque = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcVerocheque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcVR = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcVR deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcTicket = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcTicket deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  bcOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TBandeiraCartao.{$ENDIF}bcOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoViaTransp
  tvMaritima = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvMaritima deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvFluvial = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvFluvial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvLacustre = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvLacustre deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvAerea = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvAerea deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvPostal = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvPostal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvFerroviaria = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvFerroviaria deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvRodoviaria = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvRodoviaria deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvConduto = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvConduto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvMeiosProprios = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvMeiosProprios deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvEntradaSaidaFicta = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvEntradaSaidaFicta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvCourier = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvCourier deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvEmMaos = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvEmMaos deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tvPorReboque = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoViaTransp.{$ENDIF}tvPorReboque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoIntermedio
  tiContaPropria = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoIntermedio.{$ENDIF}tiContaPropria deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoIntermedio da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tiContaOrdem = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoIntermedio.{$ENDIF}tiContaOrdem deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoIntermedio da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tiEncomenda = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoIntermedio.{$ENDIF}tiEncomenda deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoIntermedio da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TindISSRet
  iirSim = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISSRet.{$ENDIF}iirSim deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISSRet da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iirNao = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISSRet.{$ENDIF}iirNao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISSRet da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TindISS
  iiExigivel = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiExigivel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiNaoIncidencia = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiNaoIncidencia deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiIsencao = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiIsencao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiExportacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiExportacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiImunidade = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiImunidade deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiExigSuspDecisaoJudicial = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiExigSuspDecisaoJudicial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiExigSuspProcessoAdm = {$IFDEF SUPPORTS_SCOPEDENUMS}TindISS.{$ENDIF}iiExigSuspProcessoAdm deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoAutor
  taEmpresaEmitente = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taEmpresaEmitente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taEmpresaDestinataria = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taEmpresaDestinataria deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taEmpresa = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taEmpresa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taFisco = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taFisco deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taRFB = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taRFB deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taEmpresaSucessora = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoAutor.{$ENDIF}taEmpresaSucessora deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndOperacao
  ioConsultaCSC = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndOperacao.{$ENDIF}ioConsultaCSC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ioNovoCSC = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndOperacao.{$ENDIF}ioNovoCSC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ioRevogaCSC = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndOperacao.{$ENDIF}ioRevogaCSC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TForcarGeracaoTag
  fgtNunca = {$IFDEF SUPPORTS_SCOPEDENUMS}TForcarGeracaoTag.{$ENDIF}fgtNunca deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TForcarGeracaoTag da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fgtSomenteProducao = {$IFDEF SUPPORTS_SCOPEDENUMS}TForcarGeracaoTag.{$ENDIF}fgtSomenteProducao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TForcarGeracaoTag da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fgtSomenteHomologacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TForcarGeracaoTag.{$ENDIF}fgtSomenteHomologacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TForcarGeracaoTag da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fgtSempre = {$IFDEF SUPPORTS_SCOPEDENUMS}TForcarGeracaoTag.{$ENDIF}fgtSempre deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TForcarGeracaoTag da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndSomaPISST
  ispNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaPISST.{$ENDIF}ispNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaPISST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ispPISSTNaoCompoe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaPISST.{$ENDIF}ispPISSTNaoCompoe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaPISST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ispPISSTCompoe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaPISST.{$ENDIF}ispPISSTCompoe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaPISST da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndSomaCOFINSST
  iscNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaCOFINSST.{$ENDIF}iscNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaCOFINSST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iscCOFINSSTNaoCompoe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaCOFINSST.{$ENDIF}iscCOFINSSTNaoCompoe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaCOFINSST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iscCOFINSSTCompoe = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndSomaCOFINSST.{$ENDIF}iscCOFINSSTCompoe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndSomaCOFINSST da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TStatusACBrNFe
  stIdle = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stIdle deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeStatusServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeStatusServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeRetRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeRetRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeConsulta = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeConsulta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeCancelamento = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeCancelamento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeInutilizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeInutilizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeRecibo = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeRecibo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeCadastro = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeCadastro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeEmail = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeEmail deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeCCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeCCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stNFeEvento = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stNFeEvento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stConsNFeDest = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stConsNFeDest deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stDownloadNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stDownloadNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stAdmCSCNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stAdmCSCNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stDistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stDistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  stEnvioWebService = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrNFe.{$ENDIF}stEnvioWebService deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TInformacoesDePagamento
  eipNunca = {$IFDEF SUPPORTS_SCOPEDENUMS}TInformacoesDePagamento.{$ENDIF}eipNunca deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TInformacoesDePagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  eipAdicionais = {$IFDEF SUPPORTS_SCOPEDENUMS}TInformacoesDePagamento.{$ENDIF}eipAdicionais deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TInformacoesDePagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  eipQuadro = {$IFDEF SUPPORTS_SCOPEDENUMS}TInformacoesDePagamento.{$ENDIF}eipQuadro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TInformacoesDePagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TVersaoDF
  ve200 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoDF.{$ENDIF}ve200 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ve300 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoDF.{$ENDIF}ve300 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ve310 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoDF.{$ENDIF}ve310 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ve400 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoDF.{$ENDIF}ve400 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TSchemaNFe
  schErro = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schErro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schNfe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schNfe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schcancNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schcancNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schInutNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schInutNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schEnvCCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schEnvCCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schEnvEventoCancNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schEnvEventoCancNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schEnvConfRecebto = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schEnvConfRecebto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schEnvEPEC = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schEnvEPEC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schconsReciNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schconsReciNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schconsSitNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schconsSitNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schconsStatServ = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schconsStatServ deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schconsCad = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schconsCad deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schenvEvento = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schenvEvento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schconsNFeDest = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schconsNFeDest deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schdownloadNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schdownloadNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schretEnviNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schretEnviNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schadmCscNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schadmCscNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schdistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schdistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  scheventoEPEC = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}scheventoEPEC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCancSubst = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCancSubst deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schPedProrrog1 = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schPedProrrog1 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schPedProrrog2 = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schPedProrrog2 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCanPedProrrog1 = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCanPedProrrog1 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCanPedProrrog2 = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCanPedProrrog2 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifDestConfirmacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifDestConfirmacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifDestCiencia = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifDestCiencia deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifDestDesconhecimento = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifDestDesconhecimento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifDestOperNaoRealizada = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifDestOperNaoRealizada deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCompEntrega = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCompEntrega deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCancCompEntrega = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCancCompEntrega deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schAtorInteressadoNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schAtorInteressadoNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schInsucessoEntregaNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schInsucessoEntregaNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCancInsucessoEntregaNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCancInsucessoEntregaNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schConcFinanceira = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schConcFinanceira deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCancConcFinanceira = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCancConcFinanceira deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schCancGenerico = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schCancGenerico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schPagIntegLibCredPresAdq = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schPagIntegLibCredPresAdq deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schImporALCZFM = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schImporALCZFM deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schPerecPerdaRouboFurtoTranspContratFornec = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schPerecPerdaRouboFurtoTranspContratFornec deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schFornecNaoRealizPagAntec = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schFornecNaoRealizPagAntec deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schSolicApropCredPres = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schSolicApropCredPres deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schDestItemConsPessoal = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schDestItemConsPessoal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schPerecPerdaRouboFurtoTranspContratAqu = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schPerecPerdaRouboFurtoTranspContratAqu deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schAceiteDebitoApuracaoNotaCredito = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schAceiteDebitoApuracaoNotaCredito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schImobilizacaoItem = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schImobilizacaoItem deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schSolicApropCredCombustivel = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schSolicApropCredCombustivel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schSolicApropCredBensServicos = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schSolicApropCredBensServicos deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifPedTransfCredIBSSucessao = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifPedTransfCredIBSSucessao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schManifPedTransfCredCBSSucessao = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schManifPedTransfCredCBSSucessao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schAtualizacaoDataPrevisaoEntrega = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schAtualizacaoDataPrevisaoEntrega deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schevVincPgto = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schevVincPgto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schnfceListagemChaves = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schnfceListagemChaves deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  schnfceDownloadXML = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaNFe.{$ENDIF}schnfceDownloadXML deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TLayOut
  LayNfeRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeRetRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeRetRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeCancelamento = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeCancelamento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeInutilizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeInutilizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeConsulta = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeConsulta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeStatusServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeStatusServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeCadastro = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeCadastro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeCCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeCCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeEvento = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeEvento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeEventoAN = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeEventoAN deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeConsNFeDest = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeConsNFeDest deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeDownloadNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeDownloadNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeAutorizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeAutorizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNfeRetAutorizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNfeRetAutorizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayAdministrarCSCNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayAdministrarCSCNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayDistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayDistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFCeEPEC = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFCeEPEC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFeURLQRCode = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFeURLQRCode deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayURLConsultaNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayURLConsultaNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayURLConsultaNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayURLConsultaNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFCeListagemChaves = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFCeListagemChaves deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  LayNFCeDownloadXML = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOut.{$ENDIF}LayNFCeDownloadXML deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TFinalidadeNFe
  fnNormal = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnNormal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fnComplementar = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnComplementar deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fnAjuste = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnAjuste deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fnDevolucao = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnDevolucao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fnCredito = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnCredito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  fnDebito = {$IFDEF SUPPORTS_SCOPEDENUMS}TFinalidadeNFe.{$ENDIF}fnDebito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFinalidadeNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TModeloDF
  moNFe = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloDF.{$ENDIF}moNFe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  moNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloDF.{$ENDIF}moNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndicadorNFe
  inTodas = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorNFe.{$ENDIF}inTodas deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  inSemManifestacaoComCiencia = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorNFe.{$ENDIF}inSemManifestacaoComCiencia deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  inSemManifestacaoSemCiencia = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndicadorNFe.{$ENDIF}inSemManifestacaoSemCiencia deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndicadorNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TVersaoQrCode
  veqr000 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoQrCode.{$ENDIF}veqr000 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoQrCode da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  veqr100 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoQrCode.{$ENDIF}veqr100 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoQrCode da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  veqr200 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoQrCode.{$ENDIF}veqr200 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoQrCode da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  veqr300 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoQrCode.{$ENDIF}veqr300 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoQrCode da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoOperacao
  toVendaConcessionaria = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoOperacao.{$ENDIF}toVendaConcessionaria deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  toFaturamentoDireto = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoOperacao.{$ENDIF}toFaturamentoDireto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  toVendaDireta = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoOperacao.{$ENDIF}toVendaDireta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  toOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoOperacao.{$ENDIF}toOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TCondicaoVeiculo
  cvAcabado = {$IFDEF SUPPORTS_SCOPEDENUMS}TCondicaoVeiculo.{$ENDIF}cvAcabado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCondicaoVeiculo da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  cvInacabado = {$IFDEF SUPPORTS_SCOPEDENUMS}TCondicaoVeiculo.{$ENDIF}cvInacabado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCondicaoVeiculo da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  cvSemiAcabado = {$IFDEF SUPPORTS_SCOPEDENUMS}TCondicaoVeiculo.{$ENDIF}cvSemiAcabado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCondicaoVeiculo da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TTipoArma
  taUsoPermitido = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoArma.{$ENDIF}taUsoPermitido deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoArma da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taUsoRestrito = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoArma.{$ENDIF}taUsoRestrito deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoArma da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TIndEscala
  ieRelevante = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndEscala.{$ENDIF}ieRelevante deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndEscala da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ieNaoRelevante = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndEscala.{$ENDIF}ieNaoRelevante deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndEscala da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  ieNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TIndEscala.{$ENDIF}ieNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TIndEscala da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TModalidadeFrete
  mfContaEmitente = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfContaEmitente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mfContaDestinatario = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfContaDestinatario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mfContaTerceiros = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfContaTerceiros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mfProprioRemetente = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfProprioRemetente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mfProprioDestinatario = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfProprioDestinatario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  mfSemFrete = {$IFDEF SUPPORTS_SCOPEDENUMS}TModalidadeFrete.{$ENDIF}mfSemFrete deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModalidadeFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TAutorizacao
  taNaoPermite = {$IFDEF SUPPORTS_SCOPEDENUMS}TAutorizacao.{$ENDIF}taNaoPermite deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TAutorizacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taPermite = {$IFDEF SUPPORTS_SCOPEDENUMS}TAutorizacao.{$ENDIF}taPermite deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TAutorizacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taNaoInformar = {$IFDEF SUPPORTS_SCOPEDENUMS}TAutorizacao.{$ENDIF}taNaoInformar deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TAutorizacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TindIntermed
  iiSemOperacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TindIntermed.{$ENDIF}iiSemOperacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindIntermed da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiOperacaoSemIntermediador = {$IFDEF SUPPORTS_SCOPEDENUMS}TindIntermed.{$ENDIF}iiOperacaoSemIntermediador deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindIntermed da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiOperacaoComIntermediador = {$IFDEF SUPPORTS_SCOPEDENUMS}TindIntermed.{$ENDIF}iiOperacaoComIntermediador deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindIntermed da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TtpAto
  taNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taTermoAcordo = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taTermoAcordo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taRegimeEspecial = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taRegimeEspecial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taAutorizacaoEspecifica = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taAutorizacaoEspecifica deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taAjusteSNIEF = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taAjusteSNIEF deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  taConvenioICMS = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpAto.{$ENDIF}taConvenioICMS deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TindImport
  iiNacional = {$IFDEF SUPPORTS_SCOPEDENUMS}TindImport.{$ENDIF}iiNacional deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindImport da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  iiImportado = {$IFDEF SUPPORTS_SCOPEDENUMS}TindImport.{$ENDIF}iiImportado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindImport da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TmotRedAdRem
  motTranspColetivo = {$IFDEF SUPPORTS_SCOPEDENUMS}TmotRedAdRem.{$ENDIF}motTranspColetivo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TmotRedAdRem da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  motOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TmotRedAdRem.{$ENDIF}motOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TmotRedAdRem da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TtpMotivo
  tmNaoEncontrado = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmNaoEncontrado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tmRecusa = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmRecusa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tmInexistente = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmInexistente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tmOutro = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmOutro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrNFe.Conversao.pas' {$ENDIF};

  // Enumerados do TtpGuia
  tpgNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgGTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgGTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgTTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgTTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgDTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgDTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgATV = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgATV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgPTV = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgPTV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgGTV = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgGTV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tpgGuiaFlorestal = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpGuia.{$ENDIF}tpgGuiaFlorestal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};

// Reforma Tributária
  // Enumerados do TtpNFCredito
  tcNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcMultaJuros = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcMultaJuros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcApropriacaoCreditoPresumido = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcApropriacaoCreditoPresumido deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcRetorno = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcRetorno deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcReducaoValores = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcReducaoValores deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcTransferenciaCreditoSucessao = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcTransferenciaCreditoSucessao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};
  tcRetornoRecusaParcial = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNFCredito.{$ENDIF}tcRetornoRecusaParcial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};

const
  TVersaoDFArrayStrings: array[TpcnVersaoDF] of string = ('2.00', '3.00', '3.10',
    '4.00');
  TVersaoDFArrayDouble: array[TpcnVersaoDF] of Double = (2.00, 3.00, 3.10, 4.00);

  TSchemaNFeArrayStrings: array[TSchemaNFe] of string = ('Erro', 'Nfe',
    'cancNFe', 'InutNFe', 'EnvCCe', 'EnvEventoCancNFe', 'EnvConfRecebto',
    'EnvEPEC', 'consReciNFe', 'consSitNFe', 'consStatServ', 'consCad',
    'envEvento', 'consNFeDest', 'downloadNFe', 'retEnviNFe', 'admCscNFCe',
    'distDFeInt', 'eventoEPEC', 'CancSubst', 'PedProrrog1', 'PedProrrog2',
    'CanPedProrrog1', 'CanPedProrrog2', 'ManifDestConfirmacao',
    'ManifDestCiencia', 'ManifDestDesconhecimento', 'ManifDestOperNaoRealizada',
    'CompEntrega', 'CancCompEntrega', 'AtorInteressadoNFe',
    'InsucessoEntrega', 'CancInsucessoEntrega', 'ConcFinanceira',
    'CancConcFinanceira', 'CancGenerico', 'PagIntegLibCredPresAdq',
    'ImporALCZFM', 'PerecPerdaRouboFurtoTranspContratFornec',
    'FornecNaoRealizPagAntec', 'SolicApropCredPres', 'DestItemConsPessoal',
    'PerecPerdaRouboFurtoTranspContratAqu',
    'AceiteDebitoApuracaoNotaCredito', 'ImobilizacaoItem',
    'SolicApropCredCombustivel', 'SolicApropCredBensServicos',
    'ManifPedTransfCredIBSSucessao', 'ManifPedTransfCredCBSSucessao',
    'AtualizacaoDataPrevisaoEntrega', 'evVincPgto',
    'nfceListagemChaves', 'nfceDownloadXML');

  TEventoArrayStrings: array[TSchemaNFe] of string = ('', '', 'e110111', '',
    'e110110', '', '', 'e110140', '', '', '', '', '', '', '', '', '', '', '',
    'e110112', 'e111500', 'e111501', 'e111502', 'e111503', 'e210200', 'e210210',
    'e210220', 'e210240', 'e110130', 'e110131', 'e110150', 'e110192', 'e110193',
    'e110750', 'e110751', 'e110001', 'e112110', 'e112120', 'e112130', 'e112140',
    'e211110', 'e211120', 'e211124', 'e211128', 'e211130', 'e211140', 'e211150',
    'e212110', 'e212120', 'e112150', 'e110300', '', '');

  TLayOutArrayStrings: array[TLayOut] of string = ('NfeRecepcao',
    'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
    'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
    'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
    'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
    'NFeDistribuicaoDFe', 'EventoEPEC', 'URL-QRCode', 'URL-ConsultaNFe',
    'URL-ConsultaNFCe', 'NFCeListagemChaves', 'NFCeDownloadXML');

  TFinalidadeNFeArrayStrings: array[TpcnFinalidadeNFe] of string = ('1', '2', '3',
    '4', '5', '6');

  TModeloDFArrayStrings: array[TpcnModeloDF] of string = ('55', '65');

  TIndicadorNFeArrayStrings: array[TpcnIndicadorNFe] of string = ('0', '1', '2');

  TVersaoQrCodeArrayStrings: array[TpcnVersaoQrCode] of string = ('0', '1', '2',
    '3');
  TVersaoQrCodeArrayDouble: array[TpcnVersaoQrCode] of Double = (0, 1.00, 2.00,
    3.00);

  TTipoOperacaoArrayStrings: array[TpcnTipoOperacao] of string = ('1', '2', '3',
    '0');
  TTipoOperacaoDescArrayStrings: array[TpcnTipoOperacao]
    of string = ('1-VENDA CONCESSIONÁRIA', '2-FAT. DIRETO CONS. FINAL',
      '3-VENDA DIRETA', '0-OUTROS');

  TCondicaoVeiculoArrayStrings: array[TpcnCondicaoVeiculo] of string = ('1', '2',
    '3');
  TCondicaoVeiculoDescArrayStrings: array[TpcnCondicaoVeiculo]
     of string = ('1-ACABADO', '2-INACABADO', '3-SEMI-ACABADO');

  TTipoArmaArrayStrings: array[TpcnTipoArma] of string = ('0', '1');
  TTipoArmaDescArrayStrings: array[TpcnTipoArma] of string = ('0-USO PERMITIDO',
    '1-USO RESTRITO');

  TIndEscalaArrayStrings: array[TpcnIndEscala] of string = ('S', 'N', '');

  TModalidadeFreteArrayStrings: array[TpcnModalidadeFrete] of string = ('0', '1',
    '2', '3', '4', '9');

  TAutorizacaoArrayStrings: array[TAutorizacao] of string = ('0', '1', '');

  TindIntermedArrayStrings: array[TindIntermed] of string = ('', '0', '1');

  TtpAtoArrayStrings: array[TtpAto] of string = ('', '08', '10', '12', '14',
    '15');

  TindImportArrayStrings: array[TindImport] of string = ('0', '1');

  TmotRedAdRemArrayStrings: array[TmotRedAdRem] of string = ('1', '9');

  TtpMotivoArrayStrings: array[TtpMotivo] of string = ('1', '2', '3', '4');

  TtpGuiaArrayStrings: array[TtpGuia] of string = ('', '1', '2', '3', '4', '5', '6', '7');

  TtpNFCreditoArrayStrings: array[TtpNFCredito] of string = ('', '01', '02', '03',
    '04', '05', '06');

{
  Declaração das funções de conversão
}
function StrToTpEventoNFe(out ok: boolean; const s: string): TACBrTipoEvento;

function IndpagToStr(const t: TpcnIndicadorPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função IndpagToStrEX'{$ENDIF};
function StrToIndpag(out ok: boolean; const s: string): TpcnIndicadorPagamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função StrToIndpagEX'{$ENDIF};
function IndpagToStrEX(const t: TpcnIndicadorPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método IndpagToStrEX da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToIndpagEX(const s: string): TpcnIndicadorPagamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToIndpagEX da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function PercTribToStr(const t: TpcnPercentualTributos): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método PercTribToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToPercTrib(out ok: boolean; const s: string): TpcnPercentualTributos; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToPercTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modBCToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function modBCToStrTagPosText(const t: TpcnDeterminacaoBaseIcms): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modBCToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTomodBC(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcms; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTomodBC da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modBCSTToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function modBCSTToStrTagPosText(const t: TpcnDeterminacaoBaseIcmsST): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modBCSTToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTomodBCST(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTomodBCST da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function motDesICMSToStr(const t: TpcnMotivoDesoneracaoICMS): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método motDesICMSToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function motDesICMSToStrTagPosText(const t: TpcnMotivoDesoneracaoICMS): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método motDesICMSToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTomotDesICMS(out ok: boolean; const s: string): TpcnMotivoDesoneracaoICMS; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTomotDesICMS da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function CSTIPIToStrTagPosText(const t: TpcnCstIpi): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método CSTIPIToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function CSTIPIToStr(const t: TpcnCstIpi): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método CSTIPIToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToCSTIPI(out ok: boolean; const s: string): TpcnCstIpi; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToCSTIPI da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function indProcToStr(const t: TpcnIndicadorProcesso): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indProcToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function indProcToDescrStr(const t: TpcnIndicadorProcesso): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indProcToDescrStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindProc(out ok: boolean; const s: string): TpcnIndicadorProcesso; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindProc da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function CRTToStr(const t: TpcnCRT): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método CRTToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToCRT(out ok: boolean; const s: string): TpcnCRT; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToCRT da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function CRTTocRegTrib(const t: TpcnCRT): TRegTrib; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método CRTTocRegTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function indTotToStr(const t: TpcnIndicadorTotal): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indTotToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindTot(out ok: boolean; const s: string): TpcnIndicadorTotal; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindTot da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function ECFModRefToStr(const t:  TpcnECFModRef ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ECFModRefToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToECFModRef(out ok: boolean; const s: string): TpcnECFModRef; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToECFModRef da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function ISSQNcSitTribToStr(const t: TpcnISSQNcSitTrib ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ISSQNcSitTribToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function ISSQNcSitTribToStrTagPosText(const t: TpcnISSQNcSitTrib ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ISSQNcSitTribToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TpcnISSQNcSitTrib; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToISSQNcSitTrib da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function DestinoOperacaoToStr(const t: TpcnDestinoOperacao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método DestinoOperacaoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToDestinoOperacao(out ok: boolean; const s: string): TpcnDestinoOperacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToDestinoOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function ConsumidorFinalToStr(const t: TpcnConsumidorFinal): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ConsumidorFinalToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToConsumidorFinal(out ok: boolean; const s: string): TpcnConsumidorFinal; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToConsumidorFinal da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function PresencaCompradorToStr(const t: TpcnPresencaComprador): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método PresencaCompradorToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToPresencaComprador(out ok: boolean; const s: string): TpcnPresencaComprador; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToPresencaComprador da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function FormaPagamentoToStr(const t: TpcnFormaPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método FormaPagamentoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function FormaPagamentoToDescricao(const t: TpcnFormaPagamento): string; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use FormaPagamentoToDescricao(const t: TpcnFormaPagamento; const xPag: String)'{$EndIf};
function FormaPagamentoToDescricao(const t: TpcnFormaPagamento; const xPag: String): string; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método FormaPagamentoToDescricao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToFormaPagamento(out ok: boolean; const s: string): TpcnFormaPagamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToFormaPagamento da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function BandeiraCartaoToStr(const t: TpcnBandeiraCartao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método BandeiraCartaoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function BandeiraCartaoToDescStr(const t: TpcnBandeiraCartao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método BandeiraCartaoToDescStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToBandeiraCartao(out ok: boolean; const s: string): TpcnBandeiraCartao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToBandeiraCartao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function TipoViaTranspToStr(const t: TpcnTipoViaTransp ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TipoViaTranspToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToTipoViaTransp(out ok: boolean; const s: string): TpcnTipoViaTransp; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTipoViaTransp da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function TipoViaTranspToDescricao(const t: TpcnTipoViaTransp): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TipoViaTranspToDescricao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function TipoIntermedioToStr(const t: TpcnTipoIntermedio ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TipoIntermedioToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToTipoIntermedio(out ok: boolean; const s: string): TpcnTipoIntermedio; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTipoIntermedio da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function TipoIntermedioToDescricao(const t: TpcnTipoIntermedio ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TipoIntermedioToDescricao da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function indISSRetToStr(const t: TpcnindISSRet ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indISSRetToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindISSRet(out ok: boolean; const s: string): TpcnindISSRet; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindISSRet da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function indISSToStr(const t: TpcnindISS ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indISSToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindISS(out ok: boolean; const s: string): TpcnindISS; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindISS da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function indISSToStrTagPosText(const t: TpcnindISS ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indISSToStrTagPosText da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function TipoAutorToStr(const t: TpcnTipoAutor ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TipoAutorToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToTipoAutor(out ok: boolean; const s: string): TpcnTipoAutor; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTipoAutor da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function IndOperacaoToStr(const t: TpcnIndOperacao ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método IndOperacaoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToIndOperacao(out ok: boolean; const s: string): TpcnIndOperacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToIndOperacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function indSomaPISSTToStr(const t: TIndSomaPISST): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indSomaPISSTToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindSomaPISST(out ok: Boolean; const s: String): TIndSomaPISST; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindSomaPISST da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function indSomaCOFINSSTToStr(const t: TIndSomaCOFINSST): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indSomaCOFINSSTToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindSomaCOFINSST(out ok: Boolean; const s: String): TIndSomaCOFINSST; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindSomaCOFINSST da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function LayOutToServico(const t: TLayOut): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método LayOutToServico da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function ServicoToLayOut(out ok: Boolean; const s: String): TLayOut; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ServicoToLayOut da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function LayOutToSchema(const t: TLayOut): TSchemaNFe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método LayOutToSchema da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function SchemaNFeToStr(const t: TSchemaNFe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método SchemaNFeToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToSchemaNFe(const s: String): TSchemaNFe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToSchemaNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function SchemaEventoToStr(const t: TSchemaNFe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método SchemaEventoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function FinNFeToStr(const t: TpcnFinalidadeNFe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método FinNFeToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToFinNFe(out ok: Boolean; const s: String): TpcnFinalidadeNFe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToFinNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function IndicadorNFeToStr(const t: TpcnIndicadorNFe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método IndicadorNFeToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToIndicadorNFe(out ok: Boolean; const s: String): TpcnIndicadorNFe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToIndicadorNFe da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function VersaoQrCodeToStr(const t: TpcnVersaoQrCode): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoQrCodeToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToVersaoQrCode(out ok: Boolean; const s: String): TpcnVersaoQrCode; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToVersaoQrCode da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VersaoQrCodeToDbl(const t: TpcnVersaoQrCode): Real; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoQrCodeToDbl da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function ModeloDFToStr(const t: TpcnModeloDF): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloDFToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToModeloDF(out ok: Boolean; const s: String): TpcnModeloDF; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToModeloDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function ModeloDFToPrefixo(const t: TpcnModeloDF): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloDFToPrefixo da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function StrToVersaoDF(out ok: Boolean; const s: String): TpcnVersaoDF; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VersaoDFToStr(const t: TpcnVersaoDF): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoDFToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function DblToVersaoDF(out ok: Boolean; const d: Real): TpcnVersaoDF; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método DblToVersaoDF da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VersaoDFToDbl(const t: TpcnVersaoDF): Real; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoDFToDbl da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function tpOPToStr(const t: TpcnTipoOperacao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpOPToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTotpOP(out ok: boolean; const s: string): TpcnTipoOperacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpOP da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function condVeicToStr(const t: TpcnCondicaoVeiculo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método condVeicToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTocondVeic(out ok: boolean; const s: string): TpcnCondicaoVeiculo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTocondVeic da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function tpArmaToStr(const t: TpcnTipoArma): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpArmaToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTotpArma(out ok: boolean; const s: string): TpcnTipoArma; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpArma da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function VeiculosRestricaoStr( const iRestricao :Integer ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosRestricaoStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosCorDENATRANStr( const sCorDENATRAN : String ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosCorDENATRANStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosCondicaoStr( const condVeic: TpcnCondicaoVeiculo ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosCondicaoStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosVinStr( const sVin: String ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosVinStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosEspecieStr( const iEspecie : Integer ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosEspecieStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosTipoStr( const iTipoVeic : Integer ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosTipoStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosCombustivelStr( const sTpComb : String ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosCombustivelStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function VeiculosTipoOperStr( const TtpOP : TpcnTipoOperacao ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VeiculosTipoOperStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function ArmaTipoStr( const TtpArma : TpcnTipoArma ): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ArmaTipoStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function IndEscalaToStr(const t: TpcnIndEscala): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método IndEscalaToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToIndEscala(out ok: Boolean; const s: String): TpcnIndEscala; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToIndEscala da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function modFreteToStr(const t: TpcnModalidadeFrete): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modFreteToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTomodFrete(out ok: boolean; const s: string): TpcnModalidadeFrete; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTomodFrete da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function modFreteToDesStr(const t: TpcnModalidadeFrete; versao: TpcnVersaoDF): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método modFreteToDesStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function AutorizacaoToStr(const t: TAutorizacao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método AutorizacaoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToAutorizacao(out ok: boolean; const s: string): TAutorizacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToAutorizacao da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function IndIntermedToStr(const t: TindIntermed): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método IndIntermedToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToIndIntermed(out ok: boolean; const s: string): TindIntermed; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToIndIntermed da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function tpAtoToStr(const t: TtpAto): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpAtoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTotpAto(out ok: boolean; const s: string): TtpAto; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpAto da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function indImportToStr(const t: TindImport): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indImportToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToindImport(out ok: boolean; const s: string): TindImport; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindImport da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function motRedAdRemToStr(const t: TmotRedAdRem): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método motRedAdRemToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTomotRedAdRem(out ok: boolean; const s: string): TmotRedAdRem; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTomotRedAdRem da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function tpMotivoToStr(const t: TtpMotivo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpMotivoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpMotivo da Unit ACBrNFe.Conversao.pas' {$ENDIF};

function TtpGuiaToStr(const t: TtpGuia): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TtpGuiaToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrToTtpGuia(const s: String): TtpGuia; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTtpGuia da Unit ACBrNFe.Conversao.pas' {$ENDIF};

// Reforma Tributária
function tpNFCreditoToStr(const t: TtpNFCredito): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpNFCreditoToStr da Unit ACBrNFe.Conversao.pas' {$ENDIF};
function StrTotpNFCredito(const s: string): TtpNFCredito; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpNFCredito da Unit ACBrNFe.Conversao.pas' {$ENDIF};

implementation

uses
  typinfo;

// Indicador do Tipo de pagamento **********************************************
function IndpagToStr(const t: TpcnIndicadorPagamento): string;
begin
  Result := EnumeradoToStr(t, TIndicadorPagamentoArrayStrings, [ipVista, ipPrazo, ipOutras, ipNenhum]);
end;

function StrToIndpag(out ok: boolean; const s: string): TpcnIndicadorPagamento;
begin
  Result := StrToEnumerado(ok, s, TIndicadorPagamentoArrayStrings, [ipVista, ipPrazo, ipOutras, ipNenhum]);
end;

function IndpagToStrEX(const t: TpcnIndicadorPagamento): string;
begin
  Result := TIndicadorPagamentoArrayStrings[t];
end;

function StrToIndpagEX(const s: string): TpcnIndicadorPagamento;
var
  idx: TpcnIndicadorPagamento;
begin
  for idx:= Low(TIndicadorPagamentoArrayStrings) to High(TIndicadorPagamentoArrayStrings)do
  begin
    if(TIndicadorPagamentoArrayStrings[idx] = s)then
    begin
      Result := idx;
      Exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TpcnIndicadorPagamento: %s', [s]);
end;

function PercTribToStr(const t: TpcnPercentualTributos): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'],
                              [ptValorProdutos, ptValorNF, ptPersonalizado]);
end;

function StrToPercTrib(out ok: boolean; const s: string): TpcnPercentualTributos;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'],
                                  [ptValorProdutos, ptValorNF, ptPersonalizado]);
end;

// N13 - Modalidade de determinação da BC do ICMS ******************************
function modBCToStrTagPosText(const t: TpcnDeterminacaoBaseIcms): string;
begin
  result := EnumeradoToStr(t, ['0 - Margem Valor Agregado (%)', '1 - Pauta (Valor)', '2 - Preço Tabelado Máx. (valor)', '3 - Valor da operação', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string;
begin
  // 0 - Margem Valor Agregado (%);
  // 1 - Pauta (Valor);
  // 2 - Preço Tabelado Máx. (valor);
  // 3 - valor da operação.
  result := EnumeradoToStr(t, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function StrTomodBC(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcms;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

// N18 - Modalidade de determinação da BC do ICMS ST ***************************
function modBCSTToStrTagPosText(const t: TpcnDeterminacaoBaseIcmsST): string;
begin
  result := EnumeradoToStr(t, ['0 - Preço tabelado ou máximo sugerido', '1 - Lista Negativa (valor)',
   '2 - Lista Positiva (valor)', '3 - Lista Neutra (valor)',
   '4 - Margem Valor Agregado (%)', '5 - Pauta (valor)', '6 - Valor da Operação', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TpcnDeterminacaoBaseIcmsST(-1)]);
end;

function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string;
begin
  // 0 – Preço tabelado ou máximo sugerido;
  // 1 - Lista Negativa (valor);
  // 2 - Lista Positiva (valor);
  // 3 - Lista Neutra (valor);
  // 4 - Margem Valor Agregado (%);
  // 5 - Pauta (valor);
  // 6 - Valor da Operação
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TpcnDeterminacaoBaseIcmsST(-1)]);
end;

function StrTomodBCST(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '6', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TpcnDeterminacaoBaseIcmsST(-1)]);
end;

// N28 - Motivo da desoneração do ICMS ***************************
function motDesICMSToStr(const t: TpcnMotivoDesoneracaoICMS): string;
begin
    // 1 – Táxi;
    // 2 – Deficiente Físico;
    // 3 – Produtor Agropecuário;
    // 4 – Frotista/Locadora;
    // 5 – Diplomático/Consular;
    // 6 – Utilitários e Motocicletas da
    // Amazônia Ocidental e Áreas de
    // Livre Comércio (Resolução
    // 714/88 e 790/94 – CONTRAN e
    // suas alterações);
    // 7 – SUFRAMA;
    // 8 – Venda a Orgãos Publicos;
    // 9 – outros. (v2.0)
    // 10 – Deficiente Condutor (Convênio ICMS 38/12). (v3.1)
    // 11 – Deficiente não Condutor (Convênio ICMS 38/12). (v3.1)
    // 12 - Orgão Fomento
    // 16 - Olimpiadas Rio 2016
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                               '11', '12', '16', '90', ''],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
     mdiOlimpiadaRio2016, mdiSolicitadoFisco,
     TpcnMotivoDesoneracaoICMS(-1)]);
end;

function StrTomotDesICMS(out ok: boolean; const s: string): TpcnMotivoDesoneracaoICMS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                   '10', '11', '12', '16', '90', ''],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
     mdiOlimpiadaRio2016, mdiSolicitadoFisco,
     TpcnMotivoDesoneracaoICMS(-1)]);
end;

function motDesICMSToStrTagPosText(const t: TpcnMotivoDesoneracaoICMS): string;
begin
  // 1 – Táxi;
  // 2 – Deficiente Físico;
  // 3 – Produtor Agropecuário;
  // 4 – Frotista/Locadora;
  // 5 – Diplomático/Consular;
  // 6 – Utilitários e Motocicletas da
  // Amazônia Ocidental e Áreas de
  // Livre Comércio (Resolução
  // 714/88 e 790/94 – CONTRAN e
  // suas alterações);
  // 7 – SUFRAMA;
  // 8 – Venda a Orgãos Publicos;
  // 9 – outros. (v2.0)
  // 10 – Deficiente Condutor (Convênio ICMS 38/12). (v3.1)
  // 11 – Deficiente não Condutor (Convênio ICMS 38/12). (v3.1)
  // 12 - Orgão Fomento
  // 16 - Olimpiadas Rio 2016
  // 90 - Solicitado pelo Fisco
result := EnumeradoToStr(t, ['1 – Táxi', '2 – Deficiente Físico', '3 – Produtor Agropecuário',
  '4 – Frotista/Locadora', '5 – Diplomático/Consular', '6 - Utilit./Motos da Am./Áreas Livre Com.',
  '7 – SUFRAMA', '8 – Venda a Orgãos Publicos', '9 – Outros', '10 – Deficiente Condutor',
  '11 – Deficiente não Condutor', '12 - Orgão Fomento', '16 - Olimpiadas Rio 2016',
  '90 - Solicitado pelo Fisco', ''],
  [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
   mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
   mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
   mdiOlimpiadaRio2016, mdiSolicitadoFisco,
   TpcnMotivoDesoneracaoICMS(-1)]);
end;

// CST IPI *********************************************************************
function CSTIPIToStr(const t: TpcnCstIpi): string;
begin
  result := EnumeradoToStr(t, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function StrToCSTIPI(out ok: boolean; const s: string): TpcnCstIpi;
begin
  result := StrToEnumerado(ok, s, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function CSTIPIToStrTagPosText(const t: TpcnCstIpi): string;
begin
  case t of
    ipi00 : Result := '00 - Entrada com Recuperação de Crédito';
    ipi01 : Result := '01 - Entrada Tributável com Alíquota Zero';
    ipi02 : Result := '02 - Entrada Isenta';
    ipi03 : Result := '03 - Entrada Não-Tributada';
    ipi04 : Result := '04 - Entrada Imune';
    ipi05 : Result := '05 - Entrada com Suspensão';
    ipi49 : Result := '49 - Outras Entradas';
    ipi50 : Result := '50 - Saída Tributada';
    ipi51 : Result := '51 - Saída Tributável com Alíquota Zero';
    ipi52 : Result := '52 - Saída Isenta';
    ipi53 : Result := '53 - Saída Não-Tributada';
    ipi54 : Result := '54 - Saída Imune';
    ipi55 : Result := '55 - Saída com Suspensão';
    ipi99 : Result := '99 - Outras Saídas';
  end;
end;

// 401i - Indicador da origem do processo **************************************
function indProcToStr(const t: TpcnIndicadorProcesso): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '9'],
  [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipCONFAZ, ipOutros]);
end;

function indProcToDescrStr(const t: TpcnIndicadorProcesso): string;
begin
  case t of
    ipSEFAZ           : result  := 'SEFAZ';
    ipJusticaFederal  : result  := 'JUSTIÇA FEDERAL';
    ipJusticaEstadual : result  := 'JUSTIÇA ESTADUAL';
    ipSecexRFB        : result  := 'SECEX / RFB';
    ipCONFAZ          : Result  := 'CONFAZ';
    ipOutros          : result  := 'OUTROS';
  end;
end;

function StrToindProc(out ok: boolean; const s: string): TpcnIndicadorProcesso;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '9'],
  [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipCONFAZ, ipOutros]);
end;

// 49a - Código do Regime Tributário **************************************
function CRTToStr(const t: TpcnCRT): string;
begin
  result := EnumeradoToStr(t, ['','1', '2', '3', '4'],
    [crtRegimeNormal, crtSimplesNacional, crtSimplesExcessoReceita,
     crtRegimeNormal, crtMEI]);
end;

function StrToCRT(out ok: boolean; const s: string): TpcnCRT;
begin
  result := StrToEnumerado(ok, s, ['','1', '2', '3', '4'],
    [crtRegimeNormal, crtSimplesNacional, crtSimplesExcessoReceita,
     crtRegimeNormal, crtMEI]);
end;

function CRTTocRegTrib(const t: TpcnCRT): TRegTrib;
begin
  if T = crtSimplesNacional then
    Result := RTSimplesNacional
  else
    Result := RTRegimeNormal;
end;

// 117b - Indicador de soma no total da NFe **************************************
function indTotToStr(const t: TpcnIndicadorTotal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

function StrToindTot(out ok: boolean; const s: string): TpcnIndicadorTotal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

// B20k - Modelo Refenciado  **************************************
function ECFModRefToStr(const t: TpcnECFModRef): string;
begin
    result := EnumeradoToStr(t, ['', '2B', '2C','2D'],[ECFModRefVazio ,ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function StrToECFModRef(out ok: boolean; const s: string): TpcnECFModRef;
begin
  result := StrToEnumerado(ok, s, ['', '2B', '2C','2D'],[ECFModRefVazio, ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function ISSQNcSitTribToStr(const t: TpcnISSQNcSitTrib ): string;
begin
    result := EnumeradoToStr(t, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TpcnISSQNcSitTrib;
begin
  result := StrToEnumerado(ok, s, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function ISSQNcSitTribToStrTagPosText(const t: TpcnISSQNcSitTrib): string;
begin
  result := EnumeradoToStr(t, ['','N - Normal','R - Retida','S - Substituta','I - Isenta'],
  [ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function DestinoOperacaoToStr(const t: TpcnDestinoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [doInterna, doInterestadual, doExterior]);
end;

function StrToDestinoOperacao(out ok: boolean; const s: string): TpcnDestinoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [doInterna, doInterestadual, doExterior]);
end;

function ConsumidorFinalToStr(const t: TpcnConsumidorFinal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [cfNao, cfConsumidorFinal]);
end;

function StrToConsumidorFinal(out ok: boolean; const s: string): TpcnConsumidorFinal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [cfNao, cfConsumidorFinal]);
end;

function PresencaCompradorToStr(const t: TpcnPresencaComprador): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '9'],
                              [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio,
                              pcPresencialForaEstabelecimento, pcOutros]);
end;

function StrToPresencaComprador(out ok: boolean; const s: string): TpcnPresencaComprador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '9'],
                                  [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio,
                                  pcPresencialForaEstabelecimento, pcOutros]);
end;

function FormaPagamentoToStr(const t: TpcnFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '10', '11', '12',
                               '13', '14', '15', '16', '17', '18', '19', '90',
                               '98', '99', '20', '21', '22', '91', '23', '24'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro, fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function FormaPagamentoToDescricao(const t: TpcnFormaPagamento): string; overload;
begin
  Result := ACBrNFe.Conversao.FormaPagamentoToDescricao(t, '');
end;

function FormaPagamentoToDescricao(const t: TpcnFormaPagamento; const xPag: String): string; overload;
begin
  if (t = fpOutro) and (xPag <> '') then
    result := xPag
  else
    result := EnumeradoToStr(t,  ['Dinheiro', 'Cheque', 'Cartão de Crédito',
                                'Cartão de Débito', 'Cartão da Loja (Private Label)',
                                'Vale Alimentação', 'Vale Refeição', 'Vale Presente',
                                'Vale Combustível', 'Duplicata Mercantil',
                                'Boleto Bancário', 'Deposito Bancário',
                                'PIX - Dinâmico', 'Transferência Bancária',
                                'Programa Fidelidade', 'Sem Pagamento',
                                'Regime Especial NFF', 'Outro', 'PIX - Estático',
                                'Crédito em Loja', 'Falha de hardware do sistema emissor',
                                'Pagamento Posterior', 'PIX - Automatico',
                                'TEF - Book Transfer'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro, fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function StrToFormaPagamento(out ok: boolean; const s: string): TpcnFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '10', '11', '12',
                                   '13', '14', '15', '16', '17', '18', '19', '90',
                                   '98', '99', '20', '21', '22', '91', '23', '24'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro,fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function BandeiraCartaoToDescStr(const t: TpcnBandeiraCartao): string;
begin
  case t of
    bcVisa:            Result := 'Visa';
    bcMasterCard:      Result := 'MasterCard';
    bcAmericanExpress: Result := 'AmericanExpress';
    bcSorocred:        Result := 'Sorocred';
    bcDinersClub:      Result := 'Diners Club';
    bcElo:             Result := 'Elo';
    bcHipercard:       Result := 'Hipercard';
    bcAura:            Result := 'Aura';
    bcCabal:           Result := 'Cabal';
    bcAlelo:           Result := 'Alelo';
    bcBanesCard:       Result := 'BanesCard';
    bcCalCard:         Result := 'CalCard';
    bcCredz:           Result := 'Credz';
    bcDiscover:        Result := 'Discover';
    bcGoodCard:        Result := 'GoodCard';
    bcGreenCard:       Result := 'GreenCard';
    bcHiper:           Result := 'Hiper';
    bcJcB:             Result := 'JcB';
    bcMais:            Result := 'Mais';
    bcMaxVan:          Result := 'MaxVan';
    bcPolicard:        Result := 'Policard';
    bcRedeCompras:     Result := 'RedeCompras';
    bcSodexo:          Result := 'Sodexo';
    bcValeCard:        Result := 'ValeCard';
    bcVerocheque:      Result := 'Verocheque';
    bcVR:              Result := 'VR';
    bcTicket:          Result := 'Ticket';
    bcOutros:          Result := 'Outros'
  end;
end;

function BandeiraCartaoToStr(const t: TpcnBandeiraCartao): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '07', '08',
                               '09', '10', '11', '12', '13', '14', '15', '16',
                               '17', '18', '19', '20', '21', '22', '23', '24',
                               '25', '26', '27', '99', ''],
                              [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                               bcDinersClub, bcElo, bcHipercard, bcAura, bcCabal,
                               bcAlelo, bcBanesCard, bcCalCard, bcCredz, bcDiscover,
                               bcGoodCard, bcGreenCard, bcHiper, bcJcB, bcMais,
                               bcMaxVan, bcPolicard, bcRedeCompras, bcSodexo,
                               bcValeCard, bcVerocheque, bcVR, bcTicket, bcOutros,
                               TpcnBandeiraCartao(-1)]);
end;

function StrToBandeiraCartao(out ok: boolean; const s: string): TpcnBandeiraCartao;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '07', '08',
                                   '09', '10', '11', '12', '13', '14', '15', '16',
                                   '17', '18', '19', '20', '21', '22', '23', '24',
                                   '25', '26', '27', '99', ''],
                                  [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                                   bcDinersClub, bcElo, bcHipercard, bcAura, bcCabal,
                                   bcAlelo, bcBanesCard, bcCalCard, bcCredz, bcDiscover,
                                   bcGoodCard, bcGreenCard, bcHiper, bcJcB, bcMais,
                                   bcMaxVan, bcPolicard, bcRedeCompras, bcSodexo,
                                   bcValeCard, bcVerocheque, bcVR, bcTicket, bcOutros,
                                   TpcnBandeiraCartao(-1)]);
end;

function TipoViaTranspToStr(const t: TpcnTipoViaTransp ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                               '10', '11', '12', '13'],
                              [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                               tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                               tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function StrToTipoViaTransp(out ok: boolean; const s: string): TpcnTipoViaTransp;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                   '10', '11', '12', '13'],
                                  [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                                   tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                                   tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function TipoViaTranspToDescricao(const t: TpcnTipoViaTransp): string;
begin
  result := EnumeradoToStr(t, ['01 - Marítima',
                               '02 - Fluvial',
                               '03 - Lacustre',
                               '04 - Aérea',
                               '05 - Postal',
                               '06 - Ferroviária',
                               '07 - Rodoviária',
                               '08 - Conduto / Rede Transmissão',
                               '09 - Meios Próprios',
                               '10 - Entrada / Saída ficta',
                               '11 - Courier',
                               '12 - Em mãos',
                               '13 - Por reboque'],
                              [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                               tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                               tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function TipoIntermedioToStr(const t: TpcnTipoIntermedio ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function StrToTipoIntermedio(out ok: boolean; const s: string): TpcnTipoIntermedio;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function TipoIntermedioToDescricao(const t: TpcnTipoIntermedio): string;
begin
  result := EnumeradoToStr(t, ['1 - Importação por conta própria',
                               '2 - Importação por conta e ordem',
                               '3 - Importação por encomenda'],
                              [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function indISSRetToStr(const t: TpcnindISSRet ): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [iirSim, iirNao]);
end;

function StrToindISSRet(out ok: boolean; const s: string): TpcnindISSRet;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                                  [iirSim, iirNao]);
end;

function indISSToStr(const t: TpcnindISS ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7'],
                              [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                               iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function StrToindISS(out ok: boolean; const s: string): TpcnindISS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7'],
                                  [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                                   iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function indISSToStrTagPosText(const t: TpcnindISS): string;
begin
  result := EnumeradoToStr(t, ['1 - Exigível', '2 - Não incidência', '3 - Isenção', '4 - Exportação',
                               '5 - Imunidade', '6 - Exig. Susp. Dec. Jud.', '7 - Exig. Susp. Proc. Adm.'],
                              [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                               iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function TipoAutorToStr(const t: TpcnTipoAutor ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '5', '6', '9', '8'],
                              [taEmpresaEmitente, taEmpresaDestinataria,
                               taEmpresa, taFisco, taRFB, taOutros,
                               taEmpresaSucessora]);
end;

function StrToTipoAutor(out ok: boolean; const s: string): TpcnTipoAutor;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '5', '6', '9', '8'],
                                  [taEmpresaEmitente, taEmpresaDestinataria,
                                   taEmpresa, taFisco, taRFB, taOutros,
                                   taEmpresaSucessora]);
end;

function IndOperacaoToStr(const t: TpcnIndOperacao ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function StrToIndOperacao(out ok: boolean; const s: string): TpcnIndOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function indSomaPISSTToStr(const t: TIndSomaPISST): String;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
                                [ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe]);
end;

function StrToindSomaPISST(out ok: Boolean; const s: String): TIndSomaPISST;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
                                [ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe]);
end;

function indSomaCOFINSSTToStr(const t: TIndSomaCOFINSST): String;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
                          [iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe]);
end;

function StrToindSomaCOFINSST(out ok: Boolean; const s: String): TIndSomaCOFINSST;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
                          [iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe]);
end;

function StrToTpEventoNFe(out ok: boolean; const s: string): TACBrTipoEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110110', '110111', '110112', '110140', '111500',
             '111501', '111502', '111503', '210200', '210210', '210220',
             '210240', '610600', '610614', '790700', '990900', '990910',
             '110180', '610554', '610510', '610615', '610610', '110130',
             '110131', '110150', '610130', '610131', '610601', '110192',
             '110193', '610514', '610500', '110750', '110751', '510630',
             '110001', '112110', '112120', '112130', '112140', '211110',
             '211120', '211124', '211128', '211130', '211140', '211150',
             '212110', '212120', '112150', '110300', '110301'],
            [teNaoMapeado, teCCe, teCancelamento, teCancSubst, teEPECNFe,
             tePedProrrog1, tePedProrrog2, teCanPedProrrog1, teCanPedProrrog2,
             teManifDestConfirmacao, teManifDestCiencia,
             teManifDestDesconhecimento, teManifDestOperNaoRealizada,
             teRegistroCTe, teMDFeAutorizadoComCTe, teAverbacaoExportacao,
             teVistoriaSuframa, teConfInternalizacao, teComprEntrega,
             teRegPasAutMDFeComCte, teRegPasNfeProMDFe,
             teCancelamentoMDFeAutComCTe, teMDFeAutorizado,
             teComprEntregaNFe, teCancComprEntregaNFe, teAtorInteressadoNFe,
             teComprEntregaCTe, teCancComprEntregaCTe, teCTeCancelado,
             teInsucessoEntregaNFe, teCancInsucessoEntregaNFe,
             teRegPasNfeProMDFeCte, teRegistroPassagemNFe, teConcFinanceira,
             teCancConcFinanceira, teRegistroPassagemMDFe, teCancGenerico,
             tePagIntegLibCredPresAdq, teImporALCZFM,
             tePerecPerdaRouboFurtoTranspContratFornec, teFornecNaoRealizPagAntec,
             teSolicApropCredPres, teDestItemConsPessoal,
             tePerecPerdaRouboFurtoTranspContratAqu,
             teAceiteDebitoApuracaoNotaCredito, teImobilizacaoItem,
             teSolicApropCredCombustivel, teSolicApropCredBensServicos,
             teManifPedTransfCredIBSSucessao, teManifPedTransfCredCBSSucessao,
             teAtualizacaoDataPrevisaoEntrega, teVinculoPgto, teCancVinculoPgto]);
end;

function LayOutToServico(const t: TLayOut): String;
begin
  Result := EnumeradoToStr(t,
    ['NfeRecepcao', 'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
     'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
     'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
     'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
     'NFeDistribuicaoDFe', 'EventoEPEC', 'NFCeListagemChaves', 'NFCeDownloadXML'],
    [ LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento, LayNfeInutilizacao,
      LayNfeConsulta, LayNfeStatusServico, LayNfeCadastro,
      LayNFeCCe, LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest,
      LayNFeDownloadNFe, LayNfeAutorizacao, LayNfeRetAutorizacao,
      LayAdministrarCSCNFCe, LayDistDFeInt, LayNFCeEPEC,
      LayNFCeListagemChaves, LayNFCeDownloadXML ] );
end;

function ServicoToLayOut(out ok: Boolean; const s: String): TLayOut;
begin
  Result := StrToEnumerado(ok, s,
  ['NfeRecepcao', 'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
   'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
   'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
   'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
   'NFeDistribuicaoDFe', 'EventoEPEC', 'NFCeListagemChaves', 'NFCeDownloadXML'],
  [ LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento, LayNfeInutilizacao,
    LayNfeConsulta, LayNfeStatusServico, LayNfeCadastro,
    LayNFeCCe, LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest,
    LayNFeDownloadNFe, LayNfeAutorizacao, LayNfeRetAutorizacao,
    LayAdministrarCSCNFCe, LayDistDFeInt, LayNFCeEPEC,
    LayNFCeListagemChaves, LayNFCeDownloadXML ] );
end;

function LayOutToSchema(const t: TLayOut): TSchemaNFe;
begin
  case t of
    LayNfeRecepcao:       Result := schNfe;
    LayNfeRetRecepcao:    Result := schconsReciNFe;
    LayNfeCancelamento:   Result := schcancNFe;
    LayNfeInutilizacao:   Result := schInutNFe;
    LayNfeConsulta:       Result := schconsSitNFe;
    LayNfeStatusServico:  Result := schconsStatServ;
    LayNfeCadastro:       Result := schconsCad;
    LayNFeCCe,
    LayNFeEvento,
    LayNFeEventoAN:       Result := schenvEvento;
    LayNFeConsNFeDest:    Result := schconsNFeDest;
    LayNFeDownloadNFe:    Result := schdownloadNFe;
    LayNfeAutorizacao:    Result := schNfe;
    LayNfeRetAutorizacao: Result := schretEnviNFe;
    LayAdministrarCSCNFCe: Result := schadmCscNFCe;
    LayDistDFeInt:        Result := schdistDFeInt;
    LayNFCeEPEC:          Result := scheventoEPEC;
    LayNFCeListagemChaves: Result := schnfceListagemChaves;
    LayNFCeDownloadXML:   Result := schnfceDownloadXML;
  else
    Result := schErro;
  end;
end;

function SchemaNFeToStr(const t: TSchemaNFe): String;
begin
  Result := GetEnumName(TypeInfo(TSchemaNFe), Integer( t ) );
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaNFe(const s: String): TSchemaNFe;
var
  P: Integer;
  SchemaStr: String;
  CodSchema: Integer;
begin
  P := pos('_',s);
  if p > 0 then
    SchemaStr := copy(s,1,P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr,3) <> 'sch' then
    SchemaStr := 'sch'+SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaNFe), SchemaStr );

  if CodSchema = -1 then
  begin
    raise Exception.Create(Format('"%s" não é um valor TSchemaNFe válido.',[SchemaStr]));
  end;

  Result := TSchemaNFe( CodSchema );
end;

// B25 - Finalidade de emissão da NF-e *****************************************
function FinNFeToStr(const t: TpcnFinalidadeNFe): String;
begin
  Result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6'],
    [fnNormal, fnComplementar, fnAjuste, fnDevolucao, fnCredito, fnDebito]);
end;

function StrToFinNFe(out ok: Boolean; const s: String): TpcnFinalidadeNFe;
begin
  Result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6'],
    [fnNormal, fnComplementar, fnAjuste, fnDevolucao, fnCredito, fnDebito]);
end;

function IndicadorNFeToStr(const t: TpcnIndicadorNFe): String;
begin
  Result := EnumeradoToStr(t, ['0', '1', '2'],
    [inTodas, inSemManifestacaoComCiencia, inSemManifestacaoSemCiencia]);
end;

function StrToIndicadorNFe(out ok: Boolean; const s: String): TpcnIndicadorNFe;
begin
  Result := StrToEnumerado(ok, s, ['0', '1', '2'],
    [inTodas, inSemManifestacaoComCiencia, inSemManifestacaoSemCiencia]);
end;

function VersaoQrCodeToStr(const t: TpcnVersaoQrCode): String;
begin
  Result := EnumeradoToStr(t, ['0', '1', '2', '3'],
    [veqr000, veqr100, veqr200, veqr300]);
end;

function StrToVersaoQrCode(out ok: Boolean; const s: String): TpcnVersaoQrCode;
begin
  Result := StrToEnumerado(ok, s, ['0', '1', '2', '3'],
    [veqr000, veqr100, veqr200, veqr300]);
end;

function VersaoQrCodeToDbl(const t: TpcnVersaoQrCode): Real;
begin
  case t of
    veqr000: Result := 0;
    veqr100: Result := 1;
    veqr200: Result := 2;
    veqr300: Result := 3;
  else
    Result := 0;
  end;
end;

function ModeloDFToStr(const t: TpcnModeloDF): String;
begin
  Result := EnumeradoToStr(t, ['55', '65'], [moNFe, moNFCe]);
end;

function StrToModeloDF(out ok: Boolean; const s: String): TpcnModeloDF;
begin
  Result := StrToEnumerado(ok, s, ['55', '65'], [moNFe, moNFCe]);
end;

function ModeloDFToPrefixo(const t: TpcnModeloDF): String;
begin
  Case t of
    moNFCe: Result := 'NFCe';
  else
    Result := 'NFe';
  end;
end;

function StrToVersaoDF(out ok: Boolean; const s: String): TpcnVersaoDF;
begin
  Result := StrToEnumerado(ok, s, ['2.00', '3.00', '3.10', '4.00'], [ve200, ve300, ve310, ve400]);
end;

function VersaoDFToStr(const t: TpcnVersaoDF): String;
begin
  Result := EnumeradoToStr(t, ['2.00', '3.00', '3.10', '4.00'], [ve200, ve300, ve310, ve400]);
end;

 function DblToVersaoDF(out ok: Boolean; const d: Real): TpcnVersaoDF;
 begin
   ok := True;

   if (d = 2.0) or (d < 3.0)  then
     Result := ve200
   else if (d >= 3.0) and (d < 3.1) then
     Result := ve300
   else if (d >= 3.10) and (d < 4) then
     Result := ve310
   else if (d >= 4) then
     Result := ve400
   else
   begin
     Result := ve310;
     ok := False;
   end;
 end;

 function VersaoDFToDbl(const t: TpcnVersaoDF): Real;
 begin
   case t of
     ve200: Result := 2.00;
     ve300: Result := 3.00;
     ve310: Result := 3.10;
     ve400: Result := 4.00;
   else
     Result := 0;
   end;
 end;

// J02 - Tipo da operação ******************************************************
 function tpOPToStr(const t: TpcnTipoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

function StrTotpOP(out ok: boolean; const s: string): TpcnTipoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

// J22 - Condição do Veículo ***************************************************
function condVeicToStr(const t: TpcnCondicaoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

function StrTocondVeic(out ok: boolean; const s: string): TpcnCondicaoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

// L02 - Indicador do tipo de arma de fogo *************************************
function tpArmaToStr(const t: TpcnTipoArma): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function StrTotpArma(out ok: boolean; const s: string): TpcnTipoArma;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function VeiculosRestricaoStr( const iRestricao : Integer ): String;
begin
  case iRestricao of
    0: result := '0-NÃO HÁ';
    1: result := '1-ALIENAÇÃO FIDUCIÁRIA';
    2: result := '2-RESERVA DE DOMICÍLIO';
    3: result := '3-RESERVA DE DOMÍNIO';
    4: result := '4-PENHOR DE VEÍCULOS';
    9: result := '9-OUTRAS'
    else
      result := IntToStr(iRestricao)+ 'NÃO DEFINIDO' ;
  end;
end;

function VeiculosCorDENATRANStr( const sCorDENATRAN : String ): String;
begin
  case StrToIntDef( sCorDENATRAN, 0 ) of
     1: result := '01-AMARELO';
     2: result := '02-AZUL';
     3: result := '03-BEGE';
     4: result := '04-BRANCA';
     5: result := '05-CINZA';
     6: result := '06-DOURADA';
     7: result := '07-GRENÁ';
     8: result := '08-LARANJA';
     9: result := '09-MARROM';
    10: result := '10-PRATA';
    11: result := '11-PRETA';
    12: result := '12-ROSA';
    13: result := '13-ROXA';
    14: result := '14-VERDE';
    15: result := '15-VERMELHA';
    16: result := '16-FANTASIA'
    else
      result := sCorDENATRAN + 'NÃO DEFINIDA' ;
  end;
end;

function VeiculosCondicaoStr( const condVeic: TpcnCondicaoVeiculo ): String;
begin
  case condVeic of
    cvAcabado     : result := '1-ACABADO';
    cvInacabado   : result := '2-INACABADO';
    cvSemiAcabado : result := '3-SEMI-ACABADO';
  end;
end;

function VeiculosVinStr( const sVin: String ): String;
begin
  // Enumerar Vim no futuro ?
  if sVIN = 'R' then
      result := 'R-REMARCADO'
  else
    if sVIN = 'N' then
      result:= 'N-NORMAL'
    else
      result := 'NÃO DEFINIDA' ;
end;

function VeiculosEspecieStr( const iEspecie : Integer ): String;
begin
  case iEspecie of
    1: result := '01-PASSAGEIRO';
    2: result := '02-CARGA';
    3: result := '03-MISTO';
    4: result := '04-CORRIDA';
    5: result := '05-TRAÇÃO';
    6: result := '06-ESPECIAL';
    7: result := '07-COLEÇÃO'
    else
      result := IntToStr(iEspecie ) + 'NÃO DEFINIDA' ;
    end;
end;

function VeiculosTipoStr( const iTipoVeic : Integer ): String;
begin
  case iTipoVeic of
     1: result := '01-BICICLETA';
     2: result := '02-CICLOMOTOR';
     3: result := '03-MOTONETA';
     4: result := '04-MOTOCICLETA';
     5: result := '05-TRICICLO';
     6: result := '06-AUTOMÓVEL';
     7: result := '07-MICROONIBUS';
     8: result := '08-ONIBUS';
     9: result := '09-BONDE';
    10: result := '10-REBOQUE';
    11: result := '11-SEMI-REBOQUE';
    12: result := '12-CHARRETE';
    13: result := '13-CAMIONETA';
    14: result := '14-CAMINHÃO';
    15: result := '15-CARROÇA';
    16: result := '16-CARRO DE MÃO';
    17: result := '17-CAMINHÃO TRATOR';
    18: result := '18-TRATOR DE RODAS';
    19: result := '19-TRATOR DE ESTEIRAS';
    20: result := '20-TRATOR MISTO';
    21: result := '21-QUADRICICLO';
    22: result := '22-CHASSI/PLATAFORMA';
    23: result := '23-CAMINHONETE';
    24: result := '24-SIDE-CAR';
    25: result := '25-UTILITÁRIO';
    26: result := '26-MOTOR-CASA'
    else
      result := IntToStr(iTipoVeic)+'NÃO DEFINIDO' ;
    end;
end;

function VeiculosCombustivelStr( const sTpComb : String ): String;
begin
  case StrToIntDef( stpComb, 0) of
     1: result := '01-ÁLCOOL';
     2: result := '02-GASOLINA';
     3: result := '03-DIESEL';
     4: result := '04-GASOGÊNIO';
     5: result := '05-GÁS METANO';
     6: result := '06-ELETRICO/F INTERNA';
     7: result := '07-ELETRICO/F EXTERNA';
     8: result := '08-GASOLINA/GNC';
     9: result := '09-ÁLCOOL/GNC';
    10: result := '10-DIESEL / GNC';
    11: result := '11-VIDE CAMPO OBSERVAÇÃO';
    12: result := '12-ÁLCOOL/GNV';
    13: result := '13-GASOLINA/GNV';
    14: result := '14-DIESEL/GNV';
    15: result := '15-GÁS NATURAL VEICULAR';
    16: result := '16-ÁLCOOL/GASOLINA';
    17: result := '17-GASOLINA/ÁLCOOL/GNV';
    18: result := '18-GASOLINA/ELÉTRICO';
    19: result := '19-GASOLINA/ÁLCOOL/ELÉTRICO';
    20: result := '20-GÁS/NATURAL/LIQUEFEITO';
    21: result := '21-DIESEL/ELÉTRICO';
    22: result := '22-HÍBRIDO';
    23: result := '23-HÍBRIDO PLUG-IN';
    24: result := '24-ELÉTRICO';
    25: result := '25-CÉLULA COMBUSTÍVEL';
    26: result := '26-HÍBRIDO/GÁS NATURAL VEICULAR';
    27: result := '27-ETANOL/ELÉTRICO';
    else
      result := stpComb +'NÃO DEFINIDO' ;
    end;
end;

function VeiculosTipoOperStr( const TtpOP : TpcnTipoOperacao ): String;
begin
  case TtpOP of
    toVendaConcessionaria : result := '1-VENDA CONCESSIONÁRIA';
    toFaturamentoDireto   : result := '2-FAT. DIRETO CONS. FINAL';
    toVendaDireta         : result := '3-VENDA DIRETA';
    toOutros              : result := '0-OUTROS';
  end;

end;

function ArmaTipoStr( const TtpArma : TpcnTipoArma ): String;
begin
  case TtpArma of
    taUsoPermitido: result := '0-USO PERMITIDO';
    taUsoRestrito : result := '1-USO RESTRITO';
  end;
end;

function IndEscalaToStr(const t: TpcnIndEscala): String;
begin
  result := EnumeradoToStr(t, ['S', 'N', ''],
                              [ieRelevante, ieNaoRelevante, ieNenhum]);
end;

function StrToIndEscala(out ok: Boolean; const s: String): TpcnIndEscala;
begin
  result := StrToEnumerado(ok, s, ['S', 'N', ''],
                                  [ieRelevante, ieNaoRelevante, ieNenhum]);
end;

// ??? - Modalidade do frete ***************************************************
function modFreteToStr(const t: TpcnModalidadeFrete): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '9'],
    [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfProprioRemetente, mfProprioDestinatario, mfSemFrete]);
end;

function StrTomodFrete(out ok: boolean; const s: string): TpcnModalidadeFrete;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2',  '3', '4', '9'],
    [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfProprioRemetente, mfProprioDestinatario, mfSemFrete]);
end;

function modFreteToDesStr(const t: TpcnModalidadeFrete; versao: TpcnVersaoDF): string;
begin
  case versao of
    ve200,
    ve300,
    ve310:
      case t  of
        mfContaEmitente       : result := '0 - EMITENTE';
        mfContaDestinatario   : result := '1 - DEST/REM';
        mfContaTerceiros      : result := '2 - TERCEIROS';
        mfProprioRemetente    : result := '3 - PROP/REMT';
        mfProprioDestinatario : result := '4 - PROP/DEST';
        mfSemFrete            : result := '9 - SEM FRETE';
      end;
    ve400:
      case t  of
        mfContaEmitente       : result := '0 - REMETENTE';
        mfContaDestinatario   : result := '1 - DESTINATARIO';
        mfContaTerceiros      : result := '2 - TERCEIROS';
        mfProprioRemetente    : result := '3 - PROP/REMT';
        mfProprioDestinatario : result := '4 - PROP/DEST';
        mfSemFrete            : result := '9 - SEM FRETE';
      end;
  end;
end;

function SchemaEventoToStr(const t: TSchemaNFe): String;
begin
  result := EnumeradoToStr(t, ['e110001',
                               'e110110', 'e110111', 'e110112', 'e110140',
                               'e111500', 'e111501', 'e111502', 'e111503',
                               'e210200', 'e210210', 'e210220', 'e210240',
                               'e110130', 'e110131', 'e110150', 'e110192',
                               'e110193', 'e110750', 'e110751', 'e112110',
                               'e112120', 'e112130', 'e112140', 'e211110',
                               'e211120', 'e211124', 'e211128', 'e211130',
                               'e211140', 'e211150', 'e212110', 'e212120',
                               'e112150'],
    [schCancGenerico,
     schEnvCCe, schcancNFe, schCancSubst, schEnvEPEC,
     schPedProrrog1, schPedProrrog2, schCanPedProrrog1, schCanPedProrrog2,
     schManifDestConfirmacao, schManifDestCiencia, schManifDestDesconhecimento,
     schManifDestOperNaoRealizada, schCompEntrega, schCancCompEntrega,
     schAtorInteressadoNFe, schInsucessoEntregaNFe, schCancInsucessoEntregaNFe,
     schConcFinanceira, schCancConcFinanceira, schPagIntegLibCredPresAdq,
     schImporALCZFM, schPerecPerdaRouboFurtoTranspContratFornec,
     schFornecNaoRealizPagAntec, schSolicApropCredPres, schDestItemConsPessoal,
     schPerecPerdaRouboFurtoTranspContratAqu, schAceiteDebitoApuracaoNotaCredito,
     schImobilizacaoItem, schSolicApropCredCombustivel, schSolicApropCredBensServicos,
     schManifPedTransfCredIBSSucessao, schManifPedTransfCredCBSSucessao,
     schAtualizacaoDataPrevisaoEntrega]);
end;

function AutorizacaoToStr(const t: TAutorizacao): string;
begin
  result := EnumeradoToStr(t, ['0', '1', ''],
                              [taNaoPermite, taPermite, taNaoInformar]);
end;

function StrToAutorizacao(out ok: boolean; const s: string): TAutorizacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1', ''],
                                  [taNaoPermite, taPermite, taNaoInformar]);
end;

function IndIntermedToStr(const t: TindIntermed): string;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
       [iiSemOperacao, iiOperacaoSemIntermediador, iiOperacaoComIntermediador]);
end;

function StrToIndIntermed(out ok: boolean; const s: string): TindIntermed;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
       [iiSemOperacao, iiOperacaoSemIntermediador, iiOperacaoComIntermediador]);
end;

function tpAtoToStr(const t: TtpAto): string;
begin
  Result := EnumeradoToStr(t, ['', '08', '10', '12', '14', '15'],
       [taNenhum, taTermoAcordo, taRegimeEspecial, taAutorizacaoEspecifica,
            taAjusteSNIEF, taConvenioICMS]);
end;

function StrTotpAto(out ok: boolean; const s: string): TtpAto;
begin
  Result := StrToEnumerado(ok, s, ['', '08', '10', '12', '14', '15'],
       [taNenhum, taTermoAcordo, taRegimeEspecial, taAutorizacaoEspecifica,
            taAjusteSNIEF, taConvenioICMS]);
end;

function indImportToStr(const t: TindImport): string;
begin
  Result := EnumeradoToStr(t, ['0', '1'],
       [iiNacional, iiImportado]);
end;

function StrToindImport(out ok: boolean; const s: string): TindImport;
begin
  Result := StrToEnumerado(ok, s, ['0', '1'],
       [iiNacional, iiImportado]);
end;

function motRedAdRemToStr(const t: TmotRedAdRem): string;
begin
  Result := EnumeradoToStr(t, ['1', '9'],
       [motTranspColetivo, motOutros]);
end;

function StrTomotRedAdRem(out ok: boolean; const s: string): TmotRedAdRem;
begin
  Result := StrToEnumerado(ok, s, ['1', '9'],
       [motTranspColetivo, motOutros]);
end;

function tpMotivoToStr(const t: TtpMotivo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4'],
    [tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro]);
end;

function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4'],
    [tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro]);
end;

function TtpGuiaToStr(const t: TtpGuia): string;
begin
  Result := TtpGuiaArrayStrings[t];
end;

function StrToTtpGuia(const s: String): TtpGuia;
var
  idx: TtpGuia;
begin
  for idx:= Low(TtpGuiaArrayStrings) to High(TtpGuiaArrayStrings)do
  begin
    if(TtpGuiaArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TtpGuia: %s', [s]);
end;

// Reforma Tributária
function tpNFCreditoToStr(const t: TtpNFCredito): string;
begin
  Result := TtpNFCreditoArrayStrings[t];
end;

function StrTotpNFCredito(const s: string): TtpNFCredito;
var
  idx: TtpNFCredito;
begin
  for idx:= Low(TtpNFCreditoArrayStrings) to High(TtpNFCreditoArrayStrings)do
  begin
    if(TtpNFCreditoArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TtpNFCredito: %s', [s]);
end;

initialization
  RegisterStrToTpEventoDFe(StrToTpEventoNFe, 'NFe');

end.

