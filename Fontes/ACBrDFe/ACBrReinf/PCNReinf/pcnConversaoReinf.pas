{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Leivio Ramos de Fontenele                       }
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

unit pcnConversaoReinf;

interface

uses
  SysUtils, Classes;

type

  TContribuinte           = (tcPessoaJuridica, tcOrgaoPublico, tcPessoaFisica);

  TTipoEvento             = (teR1000, teR2099, teR1070, teR2010, teR2020,
                             teR2030, teR2040, teR2050, teR2055, teR2060,
                             teR2070, teR2098, teR3010, teR5001, teR5011,
                             teR9000, teR1050, teR4010, teR4020, teR4040,
                             teR4080, teR4099, teR9001, teR9005, teR9011,
                             teR9015);

  TprocEmi                = (peNenhum, peAplicEmpregador, peAplicGoverno);

  TStatusReinf            = (stIdle, stEnvLoteEventos, stConsultaLote);

  TLayOutReinf            = (LayEnvioLoteEventos, LayConsultaLoteEventos);

  TEventosReinf           = (erEnvioLote, erRetornoLote, erEnvioConsulta,
                             erRetornoConsulta);

  TtpInsc                 = (tiCNPJ, tiCPF, tiCAEPF, tiCNO);

  TtpInscProp             = (tpCNPJ, tpCPF);

  TTipoOperacao           = (toInclusao, toAlteracao, toExclusao);

  TtpSimNao               = (tpSim, tpNao);

  TpIndCoop               = (icNaoecooperativa, icCooperativadeTrabalho,
                             icCooperativadeProducao, icOutrasCooperativas);

  TtpProc                 = (tpAdministrativo, tpJudicial, tpSemProcesso);

  TindSusp                = (siLiminarMandadoSeguranca,
                             siDepositoJudicialMontanteIntegral,
                             siDepositoAdministrativoMontanteIntegral,
                             siAntecipacaoTutela,
                             siLiminarMedidaCautelar,
                             siSentencaMandadoSegurancaFavoravelContribuinte ,
                             siSentencaAcaoOrdinariaFavContribuinteConfirmadaPeloTRF,
                             siAcordaoTRFFavoravelContribuinte,
                             siAcordaoSTJRecursoEspecialFavoravelContribuinte,
                             siAcordaoSTFRecursoExtraordinarioFavoravelContribuinte,
                             siSentenca1instanciaNaoTransitadaJulgadoEfeitoSusp,
                             siDecisaoDefinitivaAFavorDoContribuinte,
                             siSemSuspensaoDaExigibilidade);

  TindSitPJ               = (spNormal, spExtincao, spFusao, spCisao, spIncorporacao);

  TindAutoria             = (taContribuinte, taOutraEntidade);

  TIndRetificacao         = (trOriginal, trRetificacao);

  TpindObra               = (ioNaoeObraDeConstrucaoCivil,
                             ioObradeConstrucaoCivilTotal,
                             ioObradeConstrucaoCivilParcial);

  TpindCPRB               = (icNaoContribuintePrevidenciariaReceitaBruta,
                             icContribuintePrevidenciaReceitaBruta);

  TtpProcRetPrinc         = (tprAdministrativoTomador, tprJudicialTomador,
                             tprJudicialPrestador);

  TReinfSchema            = (
                            schevtInfoContribuinte,           // R-1000 - Informações do Contribuinte
                            schevtFechamento,                 // R-2099 - Fechamento dos Eventos Periódicos
                            schevtTabProcesso,                // R-1070 - Tabela de Processos Administrativos/Judiciais
                            schevtTomadorServicos,            // R-2010 - Retenção Contribuição Previdenciária - Serviços Tomados
                            schevtPrestadorServicos,          // R-2020 - Retenção Contribuição Previdenciária - Serviços Prestados
                            schevtRecursoRecebidoAssociacao,  // R-2030 - Recursos Recebidos por Associação Desportiva
                            schevtRecursoRepassadoAssociacao, // R-2040 - Recursos Repassados para Associação Desportiva
                            schevtInfoProdRural,              // R-2050 - Comercialização da Produção por Produtor Rural PJ/Agroindústria
                            schevtAquisicaoProdRural,         // R-2055 - Aquisição de produção rural
                            schevtInfoCPRB,                   // R-2060 - Contribuição Previdenciária sobre a Receita Bruta - CPRB
                            schevtPgtosDivs,                  // R-2070 - Retenções na Fonte - IR, CSLL, Cofins, PIS/PASEP
                            schevtReabreEvPer,                // R-2098 - Reabertura dos Eventos Periódicos
                            schevtEspDesportivo,              // R-3010 - Receita de Espetáculo Desportivo
                            schevtTotalv1,                    // R-5001 - Informações das bases e dos tributos consolidados por contribuinte
                            schevtTotalConsolidv1,            // R-5011 - Informações de bases e tributos consolidadas por período de apuração
                            schevtExclusao,                   // R-9000 - Exclusão de Eventos
                            schErro, schConsultaLoteEventos, schEnvioLoteEventos,
                            schevt1050TabLig,                 // R-1050 - Evento tabela de entidades ligadas
                            schevt4010PagtoBeneficiarioPF,    // R-4010 - Pagamentos/créditos a beneficiário pessoa física
                            schevt4020PagtoBeneficiarioPJ,    // R-4020 - Pagamentos/créditos a beneficiário pessoa jurídica
                            schevt4040PagtoBenefNaoIdentificado,// R-4040 - Pagamentos/créditos a beneficiários não identificados
                            schevt4080RetencaoRecebimento,    // R-4080 - Retenção no recebimento
                            schevt4099FechamentoDirf,         // R-4099 - Fechamento/reabertura dos eventos da série R-4000
                            schevtTotal,                      // R-9001 - Informações das bases e dos tributos consolidados por contribuinte
                            schevtRet,                        // R-9005 - Bases e tributos - retenções na fonte
                            schevtTotalConsolid,              // R-9011 - Informações de bases e tributos consolidadas por período de apuração
                            schevtRetConsolid                 // R-9015 - Consolidação das retenções na fonte
                            );

  TtpAjuste               = (taReducao, taAcrescimo);

  TcodAjuste              = (
                            caRegimeCaixa,          // Ajuste da CPRB: Adoção do Regime de Caixa
                            caDifValRecPer,         // Ajuste da CPRB: Diferimento de Valores a recolher no período
                            caAdiValDif,            // Adição de valores Diferidos em Período(s) Anteriores(es)
                            caExpDiretas,           // Exportações diretas
                            caTransInternacional,   // Transporte internacional de cargas
                            caVendasCanceladas,     // Vendas canceladas e os descontos incondicionais concedidos
                            caIPI,                  // IPI, se incluído na receita bruta
                            caICMS,                 // ICMS, quando cobrado pelo vendedor dos bens ou prestador dos serviços na condição de substituto tributário
                            caReceBruta,            // Receita bruta reconhecida pela construção, recuperação, reforma, ampliação ou melhoramento da infraestrutura, cuja contrapartida seja ativo intangível representativo de direito de exploração, no caso de contratos de concessão de serviços públicos
                            caValAporte,            // O valor do aporte de recursos realizado nos termos do art 6 §3 inciso III da Lei 11.079/2004
                            caOutras                // Demais ajustes oriundos da Legislação Tributária, estorno ou outras situações
                            );

  TindExistInfo           = (
                            eiComMovComInfo,    // Há informações de bases e/ou de tributos
                            eiComMovSemInfo,    // Há movimento, porém não há informações de bases ou de tributos
                            eiSemMov            // Não há movimento na competência
                            );

  TindEscrituracao        = (
                            ieNaoObrig,  // 0 - Não é obrigada
                            ieObrig      // 1 - Empresa obrigada a entregar a ECD
                            );

  TindDesoneracao         = (
                            idNaoAplic,  // 0 - Não Aplicável
                            idAplic      // 1 - Empresa enquadrada nos art. 7º a 9º da Lei 12.546/2011
                            );

  TindAcordoIsenMulta     = (
                            aiSemAcordo, // 0 - Sem acordo
                            aiComAcordo  // 1 - Com acordo
                            );

  TindNIF                 = (
                            nifCom,        // 1 - Beneficiário com NIF;
                            nifDispensado, // 2 - Beneficiário dispensado do NIF
                            nifNaoExige    // 3 - País não exige NIF
                            );

  TindTpDeducao           = (
                            itdOficial,    // 1 - Previdência Oficial
                            itdPrivada,    // 2 - Previdência Privada
                            itdFapi,       // 3 - Fapi
                            itdFunpresp,   // 4 - Funpresp
                            itdPensao,     // 5 - Pensão Alimentícia
                            itdDependentes,// 7 - Dependentes
                            itdDescontoSimplMensal// 8 - Desconto simplificado mensal
                            );

  TtpIsencao              = (
                            tiIsenta,                 //  1 - Parcela Isenta 65 anos
                            tiAjudaViagem,            //  2 - Diária de viagem
                            tiIndenizaRescisao,       //  3 - Indenização e rescisão de contrato, inclusive a título de PDV e acidentes de trabalho
                            tiAbono,                  //  4 - Abono pecuniário
                            tiSocioMicroempresa,      //  5 - Valores pagos a titular ou sócio de microempresa ou empresa de pequeno porte, exceto pró-labore, alugueis e serviços prestados
                            tiPensaoAposentadoria,    //  6 - Pensão, aposentadoria ou reforma por moléstia grave ou acidente em serviço
                            tiComplAposentadoria,     //  7 - Complementação de aposentadoria, correspondente às contribuições efetuadas no período de 01/01/1989 a 31/12/1995
                            tiAjudaCusto,             //  8 - Ajuda de custo
                            tiRendimentosSemRetencao, //  9 - Rendimentos pagos sem retenção do IR na fonte - Lei 10.833/2003
                            tiJurosMoraRecebidos,     // 10 – Juros de mora recebidos, devidos pelo atraso no pagamento de remuneração por exercício de emprego, cargo ou função
                            tiResgatePrevidencia,     // 11 – Resgate de previdência complementar por portador de moléstia grave
                            tiLucrosDividendos,       // 12 – Lucros e dividendos distribuídos nos termos do § 3º do art. 6º-A da Lei nº 9.250/1995
                            tiOutros                  // 99 - Outros (especificar)
                            );

  TindPerReferencia       = (
                            iprMensal,     // 1 - Folha de Pagamento Mensal
                            iprDecTerceiro // 2 - Folha do Décimo Terceiro Salário
                            );

  TindOrigemRecursos      = (
                            iorProprios, // 1 - Recursos do próprio declarante
                            iorTerceiros // 2 - Recursos de terceiros - Declarante é a Instituição Financeira responsável apenas pelo repasse dos valores
                            );

  TtpRepasse              = (
                            trPatrocinio,    // 1 - Patrocínio
                            trLicenciamento, // 2 - Licenciamento de marcas e símbolos
                            trPublicidade,   // 3 - Publicidade
                            trPropaganda,    // 4 - Propaganda
                            trTransmissao    // 5 - Transmissão de espetáculos
                            );

  TindCom                 = (
                            icProdRural,  // 1 - Comercialização da Produção por Prod. Rural PJ/Agroindústria, exceto para entidades executoras do PAA
                            icProdIsenta, // 7 - Comercialização da Produção com Isenção de Contribuição Previdenciária, de acordo com a Lei n° 13.606/2018;
                            icPAA,        // 8 - Comercialização da Produção para Entidade do Programa de Aquisição de Alimentos - PAA
                            icMercExterno // 9 - Comercialização direta da Produção no Mercado Externo
                            );

  TdetAquis               = (
                            iaProdRuralPF,  // 1 - Aquisição de produção de produtor rural pessoa física ou segurado especial em geral;
                            iaProdRuraPFPAA, // 2 - Aquisição de produção de produtor rural pessoa física ou segurado especial em geral por entidade do PAA;
                            iaPF,            // 3 - Aquisição de produção de produtor rural pessoa jurídica por entidade do PAA;
                            iaIsentaPFPAA,   // 4 - Aquisição de produção de produtor rural pessoa física ou segurado especial em geral - Produção isenta (Lei 13.606/2018);
                            iaProdRuraPJPAA, // 5 - Aquisição de produção de produtor rural pessoa física ou segurado especial em geral por entidade do PAA - Produção isenta (Lei 13.606/2018);
                            iaIsentaPJPAA,   // 6 - Aquisição de produção de produtor rural pessoa jurídica por entidade do PAA - Produção isenta (Lei 13.606/2018);
                            iaExternoPF      // 7 - Aquisição de produção de produtor rural pessoa física ou segurado especial para fins de exportação.
                            );


  TtpCompeticao           = (
                            ttcOficial,   // 1 - Oficial
                            ttcnaoOficial // 2 - Não Oficial
                            );

  TcategEvento            = (
                            tceInternacional,  // 1 - Internacional
                            tceInterestadual,  // 2 - Interestadual
                            tceEstadual,       // 3 - Estadual
                            tceLocal           // 4 - Local
                            );

  TtpIngresso             = (
                            ttiArquibancada, // 1 - Arquibancada
                            ttiGeral,        // 2 - Geral
                            ttiCadeiras,     // 3 - Cadeiras
                            ttiCamarote      // 4 - Camarote
                            );

  TtpReceita              = (
                            ttrTransmissao, // 1 - Transmissão
                            ttrPropaganda,  // 2 - Propaganda
                            ttrPublicidade, // 3 - Publicidade
                            ttrSorteio,     // 4 - Sorteio
                            ttrOutros       // 5 - Outros
                            );

  TtpDependente           = (
                            ttdConjuge,          // 1 - Cônjuge
                            ttdUniaoEstavel,     // 2 - Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos ou possua declaração de união estável;
                            ttdFilhoOuEnteado,   // 3 - Filho(a) ou enteado(a);
                            ttdIrmaoNetoBisneto, // 6 - Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial do(a) qual detenha a guarda judicial;
                            ttdPaisAvoBisavo,    // 9 - Pais, avós e bisavós;
                            ttdMenorComGuarda,   // 10 - Menor pobre do qual detenha a guarda judicial;
                            ttdIncapaz,          // 11 - A pessoa absolutamente incapaz, da qual seja tutor ou curador;
                            ttdExConjuge,        // 12 - Ex-cônjuge;
                            ttdAgregadoOutros    // 99 - Agregado/Outros
                            );

  TtpDeducao              = (
                            ttePrevidenciaOficial,  // 1 - Previdência oficial
                            ttePrevidenciaPrivada,  // 2 - Previdência privada
                            tteFapi,                // 3 - Fundo de aposentadoria programada individual - Fapi
                            tteFunpresp,            // 4 - Fundação de previdência complementar do servidor público - Funpresp
                            ttePensaoAlimenticia,   // 5 - Pensão alimentícia
                            tteDependentes          // 7 - Dependentes
                            );

  TtpEntLig               = (
                            telFundoInvestimento,       // 1 - Fundo de investimento
                            telFundoInvestImobiliario,  // 2 - Fundo de investimento imobiliário
                            telClubeInvestimento,       // 3 - Clube de investimento
                            telSociedadeParticipacao    // 4 - Sociedade em conta de participação
                            );

  TtpIsencaoImunidade     = (
                            tiiNenhum,                   // 0 - Nenhum
                            tiiTributacaoNormal,         // 1 - Entidade não isenta/não imune - Tributação normal
                            tiiEducacao,                 // 2 - Instituição de educação e de assistência social sem fins lucrativos, a que se refere o art. 12 da Lei nº 9.532, de 10 de dezembro de 1997
                            tiiFilanRecreCultCien        // 3 - Instituição de caráter filantrópico, recreativo, cultural, científico e às associações civis, a que se refere o art. 15 da Lei nº 9.532, de 1997
                            );

  TtpPerApurQui           = (
                            paq01a15,   // 1 - ("DD") da data informada em {dtFG} no evento de origem for de 1 a 15
                            paq16a31    // 2 - ("DD") da data informada em {dtFG} no evento de origem for de 16 a 31
                            );

  TtpPerApurDec           = (
                            pad01a10,   // 1 - ("DD") da data informada em {dtFG} no evento de origem for de 1 a 10
                            pad11a20,   // 1 - ("DD") da data informada em {dtFG} no evento de origem for de 11 a 20
                            pad21a31    // 2 - ("DD") da data informada em {dtFG} no evento de origem for de 21 a 31
                            );

  TtpPerApurSem           = (              // número da semana dentro de um mês. O sábado deve ser considerado como o dia que define uma semana
                            pasSemana01,   // 1 - Semana 01
                            pasSemana02,   // 2 - Semana 02
                            pasSemana03,   // 3 - Semana 03
                            pasSemana04,   // 4 - Semana 04
                            pasSemana05    // 5 - Semana 05
                            );

  TtpFechRet              = (
                            tfrFechamento,   // 0 - Fechamento (fecha o movimento, caso esteja aberto)
                            tfrReabertura    // 1 - Reabertura (reabre o movimento, caso esteja fechado)
                            );

  TVersaoReinf = (v1_03_00, v1_03_02, v1_04_00, v1_05_00, v1_05_01, v2_01_01, v2_01_02);

  // ct00 não consta no manual mas consta no manual do desenvolvedor pg 85,
  // é usado para zerar a base de teste.
  TpClassTrib = (ct00, ct01, ct02, ct03, ct04, ct06, ct07, ct08, ct09, ct10,
                 ct11, ct13, ct14, ct21, ct22, ct60, ct70, ct80, ct85, ct99);

const
  PrefixVersao = '-v';

  TTipoEventoString: array[0..25] of String =('R-1000', 'R-2099', 'R-1070',
                                              'R-2010', 'R-2020', 'R-2030',
                                              'R-2040', 'R-2050', 'R-2055',
                                              'R-2060', 'R-2070', 'R-2098',
                                              'R-3010', 'R-5001', 'R-5011',
                                              'R-9000', 'R-1050', 'R-4010',
                                              'R-4020', 'R-4040', 'R-4080',
                                              'R-4099', 'R-9001', 'R-9005',
                                              'R-9011', 'R-9015');

  TReinfSchemaStr: array[0..25] of string = ('evtInfoContribuinte',           // R-1000 - Informações do Contribuinte
                                             'evtFechamento',                 // R-2099 - Fechamento dos Eventos Periódicos
                                             'evtTabProcesso',                // R-1070 - Tabela de Processos Administrativos/Judiciais
                                             'evtTomadorServicos',            // R-2010 - Retenção Contribuição Previdenciária - Serviços Tomados
                                             'evtPrestadorServicos',          // R-2020 - Retenção Contribuição Previdenciária - Serviços Prestados
                                             'evtRecursoRecebidoAssociacao',  // R-2030 - Recursos Recebidos por Associação Desportiva
                                             'evtRecursoRepassadoAssociacao', // R-2040 - Recursos Repassados para Associação Desportiva
                                             'evtInfoProdRural',              // R-2050 - Comercialização da Produção por Produtor Rural PJ/Agroindústria
                                             'evtAquisicaoProdRural',         // R-2055 - Aquisição de produção rural
                                             'evtInfoCPRB',                   // R-2060 - Contribuição Previdenciária sobre a Receita Bruta - CPRB
                                             'evtPagamentosDiversos',         // R-2070 - Retenções na Fonte - IR, CSLL, Cofins, PIS/PASEP
                                             'evtReabreEvPer',                // R-2098 - Reabertura dos Eventos Periódicos
                                             'evtEspDesportivo',              // R-3010 - Receita de Espetáculo Desportivo
                                             'evtTotal',                      // R-5001 - Informações das bases e dos tributos consolidados por contribuinte
                                             'evtTotalConsolid',              // R-5011 - Informações de bases e tributos consolidadas por período de apuração
                                             'evtExclusao',                   // R-9000 - Exclusão de Eventos
                                             'evtTabLig',                     // R-1050 - Evento tabela de entidades ligadas
                                             'evtRetPF',                      // R-4010 - Pagamentos/créditos a beneficiário pessoa física
                                             'evtRetPJ',                      // R-4020 - Pagamentos/créditos a beneficiário pessoa jurídica
                                             'evtBenefNId',                   // R-4040 - Pagamentos/créditos a beneficiários não identificados
                                             'evtRetRec',                     // R-4080 - Retenção no recebimento
                                             'evtFech',                       // R-4099 - Fechamento/reabertura dos eventos da série R-4000
                                             'evtTotal',                      // R-9001 - Informações das bases e dos tributos consolidados por contribuinte
                                             'evtRet',                        // R-9005 - Bases e tributos - retenções na fonte
                                             'evtTotalConsolid',              // R-9011 - Informações de bases e tributos consolidadas por período de apuração
                                             'evtRetConsolid'                 // R-9015 - Consolidação das retenções na fonte
                                            );

  TReinfSchemaRegistro: array[0..25] of string = ('R-1000', // rsevtInfoContri    - Informações do Contribuinte
                                                  'R-2099', // rsevtFechaEvPer    - Fechamento dos Eventos Periódicos
                                                  'R-1070', // rsevtTabProcesso   - Tabela de Processos Administrativos/Judiciais
                                                  'R-2010', // rsevtServTom       - Retenção Contribuição Previdenciária - Serviços Tomados
                                                  'R-2020', // rsevtServPrest     - Retenção Contribuição Previdenciária - Serviços Prestados
                                                  'R-2030', // rsevtAssocDespRec  - Recursos Recebidos por Associação Desportiva
                                                  'R-2040', // rsevtAssocDespRep  - Recursos Repassados para Associação Desportiva
                                                  'R-2050', // rsevtComProd       - Comercialização da Produção por Produtor Rural PJ/Agroindústria
                                                  'R-2055', // rsevtAquiProdRural - Aquisição de produção rural
                                                  'R-2060', // rsevtCPRB          - Contribuição Previdenciária sobre a Receita Bruta - CPRB
                                                  'R-2070', // rsevtPgtosDivs     - Retenções na Fonte - IR, CSLL, Cofins, PIS/PASEP
                                                  'R-2098', // rsevtReabreEvPer   - Reabertura dos Eventos Periódicos
                                                  'R-3010', // rsevtEspDesportivo - Receita de Espetáculo Desportivo
                                                  'R-5001', // rsevtTotal         - Informações das bases e dos tributos consolidados por contribuinte
                                                  'R-5011', // rsevtTotalConsolid - Informações de bases e tributos consolidadas por período de apuração
                                                  'R-9000', // rsevtExclusao      - Exclusão de Eventos
                                                  'R-1050', // rsevtTabLig        - Evento tabela de entidades ligadas
                                                  'R-4010', // rsevtRetPF         - Pagamentos/créditos a beneficiário pessoa física
                                                  'R-4020', // rsevtRetPJ         - Pagamentos/créditos a beneficiário pessoa jurídica
                                                  'R-4040', // revtBenefNId       - Pagamentos/créditos a beneficiários não identificados
                                                  'R-4080', // revtRetRec         - Retenção no recebimento
                                                  'R-4099', // revt4099FechamentoDirf - Fechamento/reabertura dos eventos da série R-4000
                                                  'R-9001', // rsevtTotal         - Informações das bases e dos tributos consolidados por contribuinte
                                                  'R-9005', // revtRet            - Bases e tributos - retenções na fonte
                                                  'R-9011', // rsevtTotalConsolid - Informações de bases e tributos consolidadas por período de apuração
                                                  'R-9015'  // revtRetConsolid    - Consolidação das retenções na fonte
                                                 );

  TEventoString: array[0..25] of String =('evtInfoContri', 'evtFechaEvPer',
                                          'evtTabProcesso', 'evtServTom',
                                          'evtServPrest', 'evtAssocDespRec',
                                          'evtAssocDespRep', 'evtComProd',
                                          'evtAqProd', 'evtCPRB',
                                          'evtPgtosDivs', 'evtReabreEvPer',
                                          'evtEspDesportivo', 'evtTotal',
                                          'evtTotalContrib', 'evtExclusao',
                                          'evtTabLig', 'evtRetPF',
                                          'evtRetPJ', 'evtBenefNId',
                                          'evtRetRec', 'evtFech',
                                          'evtTotal', 'evtRet',
                                          'evtTotalContrib', 'evtRetConsolid');


function ServicoToLayOut(out ok: Boolean; const s: String): TLayOutReinf;

function SchemaReinfToStr(const t: TReinfSchema): String;
function TipoEventiToSchemaReinf(const t: TTipoEvento): TReinfSchema;

function LayOutReinfToSchema(const t: TLayOutReinf): TReinfSchema;
function LayOutReinfToServico(const t: TLayOutReinf): String;

function VersaoReinfToDbl(const t: TVersaoReinf): Real;

function VersaoReinfToStr(const t: TVersaoReinf): String;
function StrToVersaoReinf(out ok: Boolean; const s: String): TVersaoReinf;

function TipoEventoToStr(const t: TTipoEvento): string;
function StrToTipoEvento(var ok: boolean; const s: string): TTipoEvento;
function StrEventoToTipoEvento(var ok: boolean; const s: string): TTipoEvento;
function StringINIToTipoEvento(out ok: boolean; const s: string): TTipoEvento;
function StringXMLToTipoEvento(out ok: boolean; const s: string): TTipoEvento;
function TipoEventoToStrEvento(const t: TTipoEvento): string;

function TpInscricaoToStr(const t: TtpInsc): string;
function StrToTpInscricao(out ok: boolean; const s: string): TtpInsc;

function ContribuinteToStr(const t: TContribuinte): string;
function ContribuinteEnumToStr(const t: TContribuinte): string;
function StrToContribuinte(var ok: boolean; const s: string): TContribuinte;

function procEmiReinfToStr(const t: TprocEmi): string;
function StrToprocEmiReinf(var ok: boolean; const s: string): TprocEmi;

function indEscrituracaoToStr(const t: TindEscrituracao): string;
function StrToindEscrituracao(var ok: boolean; const s: string): TindEscrituracao;

function indDesoneracaoToStr(const t: TindDesoneracao): string;
function StrToindDesoneracao(var ok: boolean; const s: string): TindDesoneracao;

function indAcordoIsenMultaToStr(const t: TindAcordoIsenMulta): string;
function StrToindAcordoIsenMulta(var ok: boolean; const s: string): TindAcordoIsenMulta;

function indSitPJToStr(const t: TindSitPJ): string;
function StrToindSitPJ(var ok: boolean; const s: string): TindSitPJ;

function SimNaoToStr(const t: TtpSimNao): string;
function StrToSimNao(var ok: boolean; const s: string): TtpSimNao;

function TpProcToStr(const t: TtpProc): string;
function StrToTpProc(var ok: boolean; const s: string): TtpProc;

function indAutoriaToStr(const t: TindAutoria): string;
function StrToindAutoria(var ok: boolean; const s: string): TindAutoria;

function IndSuspToStr(const t: TindSusp): string;
function StrToIndSusp(var ok: boolean; const s: string): TindSusp;

function IndRetificacaoToStr(const t: TIndRetificacao): string;
function StrToIndRetificacao(out ok: boolean; const s: string): TIndRetificacao;

function indObraToStr(const t: TpindObra): string;
function StrToindObra(var ok: boolean; const s: string): TpindObra;

function indCPRBToStr(const t: TpindCPRB): string;
function StrToindCPRB(var ok: boolean; const s: string): TpindCPRB;

function tpProcRetPrincToStr(const t: TtpProcRetPrinc): string;
function StrTotpProcRetPrinc(var ok: boolean; const s: string): TtpProcRetPrinc;

function tpRepasseToStr(const t: TtpRepasse): string;
function StrTotpRepasse(var ok: boolean; const s: string): TtpRepasse;

function indComToStr(const t: TindCom): string;
function StrToindCom(var ok: boolean; const s: string): TindCom;

function detAquisToStr(const t: TdetAquis): string;
function StrToDetAquis(var ok: boolean; const s: string): TdetAquis;

function tpAjusteToStr(const t: TtpAjuste): string;
function StrTotpAjuste(var ok: boolean; const s: string): TtpAjuste;

function codAjusteToStr(const t: TcodAjuste): string;
function StrTocodAjuste(var ok: boolean; const s: string): TcodAjuste;

function indNIFToStr(const t: TindNIF): string;
function StrToindNIF(var ok: boolean; const s: string): TindNIF;

function indTpDeducaoToStr(const t: TindTpDeducao): string;
function StrToindTpDeducao(var ok: boolean; const s: string): TindTpDeducao;

function tpIsencaoToStr(const t: TtpIsencao): string;
function StrTotpIsencao(var ok: boolean; const s: string): TtpIsencao;

function indPerReferenciaToStr(const t: TindPerReferencia): string;
function StrToindPerReferencia(var ok: boolean; const s: string): TindPerReferencia;

function indOrigemRecursosToStr(const t: TindOrigemRecursos): string;
function StrToindOrigemRecursos(var ok: boolean; const s: string): TindOrigemRecursos;

function tpCompeticaoToStr(const t: TtpCompeticao): string;
function StrTotpCompeticao(var ok: boolean; const s: string): TtpCompeticao;

function categEventoToStr(const t: TcategEvento): string;
function StrTocategEvento(var ok: boolean; const s: string): TcategEvento;

function tpIngressoToStr(const t: TtpIngresso): string;
function StrTotpIngresso(var ok: boolean; const s: string): TtpIngresso;

function tpReceitaToStr(const t: TtpReceita): string;
function StrTotpReceita(var ok: boolean; const s: string): TtpReceita;

function indExistInfoToStr(const t: TindExistInfo): string;
function StrToindExistInfo(var ok: boolean; const s: string): TindExistInfo;

function TipoOperacaoToStr(const t: TTipoOperacao): string;
function StrToTipoOperacao(var ok: boolean; const s: string): TTipoOperacao;

function tpClassTribToStr(const t: TpClassTrib): string;
function StrTotpClassTrib(var ok: boolean; const s: string): TpClassTrib;

function tpDependenteToStr(const t: TtpDependente): string;
function StrToTpDependente(var ok: boolean; const s: string): TtpDependente;

function tpEntLigToStr(const t: TtpEntLig): string;
function StrToTpEntLig(var ok: boolean; const s: string): TtpEntLig;

function tpIsencaoImunidadeToStr(const t: TtpIsencaoImunidade): string;
function StrToTpIsencaoImunidade(var ok: boolean; const s: string): TtpIsencaoImunidade;

function tpPerApurQuiToStr(const t: TtpPerApurQui): string;
function StrToTpPerApurQui(var ok: boolean; const s: string): TtpPerApurQui;

function tpPerApurDecToStr(const t: TtpPerApurDec): string;
function StrToTpPerApurDec(var ok: boolean; const s: string): TtpPerApurDec;

function tpPerApurSemToStr(const t: TtpPerApurSem): string;
function StrToTpPerApurSem(var ok: boolean; const s: string): TtpPerApurSem;

function tpFechRetToStr(const t: TtpFechRet): string;
function StrTotpFechRet(var ok: boolean; const s: string): TtpFechRet;

implementation

uses
  pcnConversao, typinfo;

function ServicoToLayOut(out ok: Boolean; const s: String): TLayOutReinf;
begin
   Result := StrToEnumerado(ok, s,
    ['EnviarLoteEventos', 'ConsultarLoteEventos'],
    [LayEnvioLoteEventos, LayConsultaLoteEventos]);
end;

function SchemaReinfToStr(const t: TReinfSchema): String;
begin
  Result := GetEnumName(TypeInfo(TReinfSchema), Integer(t));
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function TipoEventiToSchemaReinf(const t: TTipoEvento): TReinfSchema;
begin
   case t of
     teR1000: Result := schevtInfoContribuinte;
     teR1050: Result := schevt1050TabLig;
     teR1070: Result := schevtTabProcesso;
     teR2010: Result := schevtTomadorServicos;
     teR2020: Result := schevtPrestadorServicos;
     teR2030: Result := schevtRecursoRecebidoAssociacao;
     teR2040: Result := schevtRecursoRepassadoAssociacao;
     teR2050: Result := schevtInfoProdRural;
     teR2055: Result := schevtAquisicaoProdRural;
     teR2060: Result := schevtInfoCPRB;
     teR2070: Result := schevtPgtosDivs;
     teR2098: Result := schevtReabreEvPer;
     teR2099: Result := schevtFechamento;
     teR3010: Result := schevtEspDesportivo;
     teR4010: Result := schevt4010PagtoBeneficiarioPF;
     teR4020: Result := schevt4020PagtoBeneficiarioPJ;
     teR4040: Result := schevt4040PagtoBenefNaoIdentificado;
     teR4080: Result := schevt4080RetencaoRecebimento;
     teR4099: Result := schevt4099FechamentoDirf;
     teR5001: Result := schevtTotal;
     teR5011: Result := schevtTotalConsolid;
     teR9000: Result := schevtExclusao;
     teR9001: Result := schevtTotal;
     teR9005: Result := schevtRet;
     teR9011: Result := schevtTotalConsolid;
     teR9015: Result := schevtRetConsolid;
  else
    Result := schErro;
  end;
end;

function LayOutReinfToSchema(const t: TLayOutReinf): TReinfSchema;
begin
   case t of
    LayEnvioLoteEventos:    Result := schEnvioLoteEventos;
    LayConsultaLoteEventos: Result := schConsultaLoteEventos;
  else
    Result := schErro;
  end;
end;

function LayOutReinfToServico(const t: TLayOutReinf): String;
begin
   Result := EnumeradoToStr(t,
    ['EnviarLoteEventos', 'ConsultarLoteEventos'],
    [LayEnvioLoteEventos, LayConsultaLoteEventos]);
end;

function VersaoReinfToDbl(const t: TVersaoReinf): Real;
begin
  // a versão do Reinf em formato Double foi suprimido os zeros para ficar
  // compativel com a procedure: LerServicoChaveDeParams em ACBrDFe
  case t of
    v1_03_00: result := 1.30;
    v1_03_02: result := 1.32;
    v1_04_00: Result := 1.40;
    v1_05_00: Result := 1.50;
    v1_05_01: Result := 1.51;
    v2_01_01: Result := 2.21;
    v2_01_02: Result := 2.22;
  else
    result := 0;
  end;
end;

function VersaoReinfToStr(const t: TVersaoReinf): String;
begin
  result := EnumeradoToStr(t, ['1_03_00', '1_03_02', '1_04_00',
                               '1_05_00', '1_05_01', '2_01_01',
                               '2_01_02'],
                           [v1_03_00, v1_03_02, v1_04_00,
                            v1_05_00, v1_05_01, v2_01_01,
                            v2_01_02]);
end;

function StrToVersaoReinf(out ok: Boolean; const s: String): TVersaoReinf;
begin
  result := StrToEnumerado(ok, s, ['1_03_00', '1_03_02', '1_04_00',
                                   '1_05_00', '1_05_01', '2_01_01',
                                   '2_01_02'],
                           [v1_03_00, v1_03_02, v1_04_00,
                            v1_05_00, v1_05_01, v2_01_01,
                            v2_01_02]);
end;

function TipoEventoToStr(const t: TTipoEvento): string;
begin
  result := EnumeradoToStr2(t, TTipoEventoString);
end;

function StrToTipoEvento(var ok: boolean; const s: string): TTipoEvento;
begin
  result  := TTipoEvento(StrToEnumerado2(ok , s, TTipoEventoString));
end;

function StrEventoToTipoEvento(var ok: boolean; const s: string): TTipoEvento;
begin
  result := TTipoEvento(StrToEnumerado2(ok , s, TEventoString));
end;

function StringINIToTipoEvento(out ok: boolean; const s: string): TTipoEvento;
var
  i: integer;
begin
  ok := False;
  result := TTipoEvento(0);

  try
    for i := 0 to High(TEventoString) do
      if Pos('[' + TEventoString[i] + ']', s) > 0 then
      begin
        ok := True;
        result := TTipoEvento(i);
        exit;
      end;
  except
    ok := False;
  end;
end;

function StringXMLToTipoEvento(out ok: boolean; const s: string): TTipoEvento;
var
  i: integer;
begin
  ok := False;
  result := TTipoEvento(0);

  try
    for i := 0 to High(TEventoString) do
      if Pos('<' + TEventoString[i], s) > 0 then
      begin
        ok := True;
        result := TTipoEvento(i);
        exit;
      end;
  except
    ok := False;
  end;
end;

function TipoEventoToStrEvento(const t: TTipoEvento): string;
begin
  result := EnumeradoToStr2(t, TEventoString);
end;

function TpInscricaoToStr(const t:TtpInsc): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4']);
end;

function StrToTpInscricao(out ok: boolean; const s: string): TtpInsc;
begin
  result := TtpInsc(StrToEnumerado2(ok , s, ['1', '2', '3', '4']));
end;

function ContribuinteToStr(const t: TContribuinte): string;
begin
  result := EnumeradoToStr2(t, ['0', '1', '2']);
end;

function ContribuinteEnumToStr(const t: TContribuinte): string;
begin
  result := GetEnumName(TypeInfo(TContribuinte), Integer(t));
end;

function StrToContribuinte(var ok: boolean; const s: string): TContribuinte;
begin
  result := TContribuinte(StrToEnumerado2(ok , s, ['0', '1', '2']));
end;

function ProcEmiReinfToStr(const t: TprocEmi): string;
begin
  result := EnumeradoToStr2(t, ['0', '1', '2']);
end;

function StrToProcEmiReinf(var ok: boolean; const s: string): TprocEmi;
begin
  result := TprocEmi(StrToEnumerado2(ok , s, ['0', '1', '2']));
end;

function indEscrituracaoToStr(const t: TindEscrituracao): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrToindEscrituracao(var ok: boolean; const s: string): TindEscrituracao;
begin
  result := TindEscrituracao(StrToEnumerado2(ok , s, ['0', '1']));
end;

function indDesoneracaoToStr(const t: TindDesoneracao): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrToindDesoneracao(var ok: boolean; const s: string): TindDesoneracao;
begin
  result := TindDesoneracao(StrToEnumerado2(ok , s, ['0', '1']));
end;

function indAcordoIsenMultaToStr(const t: TindAcordoIsenMulta): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrToindAcordoIsenMulta(var ok: boolean; const s: string): TindAcordoIsenMulta;
begin
  result := TindAcordoIsenMulta(StrToEnumerado2(ok , s, ['0', '1']));
end;

function indSitPJToStr(const t: TindSitPJ): string;
begin
  result := EnumeradoToStr2(t, ['0', '1', '2', '3', '4']);
end;

function StrToindSitPJ(var ok: boolean; const s: string): TindSitPJ;
begin
  result := TindSitPJ(StrToEnumerado2(ok , s, ['0', '1', '2', '3', '4']));
end;

function SimNaoToStr(const t: TtpSimNao): string;
begin
  result := EnumeradoToStr2(t, ['S', 'N']);
end;

function StrToSimNao(var ok: boolean; const s: string): TtpSimNao;
begin
  result := TtpSimNao(StrToEnumerado2(ok , s, ['S', 'N']));
end;

function TpProcToStr(const t: TtpProc): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3']);
end;

function StrToTpProc(var ok: boolean; const s: string): TtpProc;
begin
  result := TtpProc(StrToEnumerado2(ok , s, ['1', '2', '3']));
end;

function indAutoriaToStr(const t: TindAutoria): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrToindAutoria(var ok: boolean; const s: string): TindAutoria;
begin
  result := TindAutoria(StrToEnumerado2(ok , s, ['1', '2']));
end;

function IndSuspToStr(const t: TindSusp): string;
begin
  result := EnumeradoToStr2(t, ['01', '02', '03', '04', '05', '08', '09', '10',
                                '11', '12', '13', '90', '92']);
end;

function StrToIndSusp(var ok: boolean; const s: string): TindSusp;
begin
  result := TindSusp(StrToEnumerado2(ok , s, ['01', '02', '03', '04', '05',
                                               '08', '09', '10', '11', '12',
                                               '13', '90', '92']));
end;

function IndRetificacaoToStr(const t: TIndRetificacao): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrToIndRetificacao(out ok: boolean; const s: string): TIndRetificacao;
begin
  result := TIndRetificacao(StrToEnumerado2(ok , s, ['1', '2']));
end;

function indObraToStr(const t: TpindObra): string;
begin
  result := EnumeradoToStr2(t, ['0', '1', '2']);
end;

function StrToindObra(var ok: boolean; const s: string): TpindObra;
begin
  result := TpindObra(StrToEnumerado2(ok , s, ['0', '1', '2']));
end;

function indCPRBToStr(const t: TpindCPRB): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrToindCPRB(var ok: boolean; const s: string): TpindCPRB;
begin
  result := TpindCPRB(StrToEnumerado2(ok , s, ['0', '1']));
end;

function tpProcRetPrincToStr(const t: TtpProcRetPrinc): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3']);
end;

function StrTotpProcRetPrinc(var ok: boolean; const s: string): TtpProcRetPrinc;
begin
  result := TtpProcRetPrinc(StrToEnumerado2(ok , s, ['1', '2', '3']));
end;

function tpRepasseToStr(const t: TtpRepasse): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5']);
end;

function StrTotpRepasse(var ok: boolean; const s: string): TtpRepasse;
begin
  result := TtpRepasse(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5']));
end;

function indComToStr(const t: TindCom): string;
begin
  result := EnumeradoToStr2(t, ['1', '7', '8', '9']);
end;

function StrToindCom(var ok: boolean; const s: string): TindCom;
begin
  result := TindCom(StrToEnumerado2(ok , s, ['1', '7', '8', '9']));
end;

function detAquisToStr(const t: TdetAquis): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5', '6', '7']);
end;

function StrToDetAquis(var ok: boolean; const s: string): TdetAquis;
begin
  result := TdetAquis(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5', '6',
                                                '7']));
end;

function tpAjusteToStr(const t: TtpAjuste): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrTotpAjuste(var ok: boolean; const s: string): TtpAjuste;
begin
  result := TtpAjuste(StrToEnumerado2(ok , s, ['0', '1']));
end;

function codAjusteToStr(const t: TcodAjuste): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                '10', '11']);
end;

function StrTocodAjuste(var ok: boolean; const s: string): TcodAjuste;
begin
  result := TcodAjuste(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5', '6',
                                                 '7', '8', '9', '10', '11']));
end;

function indNIFToStr(const t: TindNIF): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3']);
end;

function StrToindNIF(var ok: boolean; const s: string): TindNIF;
begin
  result := TindNIF(StrToEnumerado2(ok , s, ['1', '2', '3']));
end;

function indTpDeducaoToStr(const t: TindTpDeducao): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5', '7', '8']);
end;

function StrToindTpDeducao(var ok: boolean; const s: string): TindTpDeducao;
begin
  result := TindTpDeducao(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5',
                                                    '7', '8']));
end;

function tpIsencaoToStr(const t: TtpIsencao): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                '10', '11', '12', '99']);
end;

function StrTotpIsencao(var ok: boolean; const s: string): TtpIsencao;
begin
  result := TtpIsencao(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5', '6',
                                                 '7', '8', '9', '10', '11', '12', '99']));
end;

function indPerReferenciaToStr(const t: TindPerReferencia): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrToindPerReferencia(var ok: boolean; const s: string): TindPerReferencia;
begin
  result := TindPerReferencia(StrToEnumerado2(ok , s, ['1', '2']));
end;

function indOrigemRecursosToStr(const t: TindOrigemRecursos): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrToindOrigemRecursos(var ok: boolean; const s: string): TindOrigemRecursos;
begin
  result := TindOrigemRecursos(StrToEnumerado2(ok , s, ['1', '2']));
end;

function tpCompeticaoToStr(const t: TtpCompeticao): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrTotpCompeticao(var ok: boolean; const s: string): TtpCompeticao;
begin
  result := TtpCompeticao(StrToEnumerado2(ok , s, ['1', '2']));
end;

function categEventoToStr(const t: TcategEvento): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4']);
end;

function StrTocategEvento(var ok: boolean; const s: string): TcategEvento;
begin
  result := TcategEvento(StrToEnumerado2(ok , s, ['1', '2', '3', '4']));
end;

function tpIngressoToStr(const t: TtpIngresso): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4']);
end;

function StrTotpIngresso(var ok: boolean; const s: string): TtpIngresso;
begin
  result := TtpIngresso(StrToEnumerado2(ok , s, ['1', '2', '3', '4']));
end;

function tpReceitaToStr(const t: TtpReceita): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5']);
end;

function StrTotpReceita(var ok: boolean; const s: string): TtpReceita;
begin
  result := TtpReceita(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5']));
end;

function indExistInfoToStr(const t: TindExistInfo): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3']);
end;

function StrToindExistInfo(var ok: boolean; const s: string): TindExistInfo;
begin
  result := TindExistInfo(StrToEnumerado2(ok , s, ['1', '2', '3']));
end;

function TipoOperacaoToStr(const t: TTipoOperacao): string;
begin
  result := EnumeradoToStr2(t, ['inclusao', 'alteracao', 'exclusao']);
end;

function StrToTipoOperacao(var ok: boolean; const s: string): TTipoOperacao;
begin
  result := TTipoOperacao(StrToEnumerado2(ok , s, ['inclusao', 'alteracao',
                                                    'exclusao']));
end;

function tpClassTribToStr(const t: TpClassTrib): string;
begin
  result := EnumeradoToStr(t, ['00', '01', '02', '03', '04', '06', '07', '08',
                               '09', '10', '11', '13', '14', '21', '22', '60',
                               '70', '80', '85', '99'],
                              [ct00, ct01, ct02, ct03, ct04, ct06, ct07, ct08,
                               ct09, ct10, ct11, ct13, ct14, ct21, ct22, ct60,
                               ct70, ct80, ct85, ct99]);
end;

function StrTotpClassTrib(var ok: boolean; const s: string): TpClassTrib;
begin
  result := StrToEnumerado(ok, s, ['00', '01', '02', '03', '04', '06', '07', '08',
                                   '09', '10', '11', '13', '14', '21', '22', '60',
                                   '70', '80', '85', '99'],
                              [ct00, ct01, ct02, ct03, ct04, ct06, ct07, ct08,
                               ct09, ct10, ct11, ct13, ct14, ct21, ct22, ct60,
                               ct70, ct80, ct85, ct99]);
end;

function tpDependenteToStr(const t: TtpDependente): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '6', '9',
                                '10', '11', '12', '99']);
end;

function StrToTpDependente(var ok: boolean; const s: string): TtpDependente;
begin
  result := TtpDependente(StrToEnumerado2(ok , s, ['1', '2', '3', '6', '9',
                                                   '10', '11', '12', '99']));
end;

function tpEntLigToStr(const t: TtpEntLig): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4']);
end;

function StrToTpEntLig(var ok: boolean; const s: string): TtpEntLig;
begin
  result := TtpEntLig(StrToEnumerado2(ok , s, ['1', '2', '3', '4']));
end;

function tpIsencaoImunidadeToStr(const t: TtpIsencaoImunidade): string;
begin
  result := EnumeradoToStr2(t, ['', '1', '2', '3']);
end;

function StrToTpIsencaoImunidade(var ok: boolean; const s: string): TtpIsencaoImunidade;
begin
  result := TTpIsencaoImunidade(StrToEnumerado2(ok , s, ['', '1', '2', '3']));
end;

function tpPerApurQuiToStr(const t: TtpPerApurQui): string;
begin
  result := EnumeradoToStr2(t, ['1', '2']);
end;

function StrToTpPerApurQui(var ok: boolean; const s: string): TtpPerApurQui;
begin
  result := TtpPerApurQui(StrToEnumerado2(ok , s, ['1', '2']));
end;

function tpPerApurDecToStr(const t: TtpPerApurDec): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3']);
end;

function StrToTpPerApurDec(var ok: boolean; const s: string): TtpPerApurDec;
begin
  result := TtpPerApurDec(StrToEnumerado2(ok , s, ['1', '2', '3']));
end;

function tpPerApurSemToStr(const t: TtpPerApurSem): string;
begin
  result := EnumeradoToStr2(t, ['1', '2', '3', '4', '5']);
end;

function StrToTpPerApurSem(var ok: boolean; const s: string): TtpPerApurSem;
begin
  result := TtpPerApurSem(StrToEnumerado2(ok , s, ['1', '2', '3', '4', '5']));
end;

function tpFechRetToStr(const t: TtpFechRet): string;
begin
  result := EnumeradoToStr2(t, ['0', '1']);
end;

function StrTotpFechRet(var ok: boolean; const s: string): TtpFechRet;
begin
  result := TtpFechRet(StrToEnumerado2(ok , s, ['0', '1']));
end;

end.
