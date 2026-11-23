{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrDeRE.Consts;

interface

uses
  SysUtils;

const
  ACBRDERE_MODELODF = 'DeRE';
  ACBRDERE_NAMESPACE = 'http://www.dere.gov.br/schemas';

  // Prefixo do atributo "id" dos eventos (ex.: DeRE10011...)
  PREFIXO_ID_DERE = 'DeRE';

  // Tamanho fixo do atributo "id" do evento
  TAM_ID_DERE = 42;

  // Limite de eventos por lote (envioLoteDere / retornoLoteDere)
  MAX_EVENTOS_LOTE_DERE = 50;

  // Tamanho do numero de inscricao completo usado na composicao do id (14 posicoes)
  TAM_NRINSC_ID_DERE = 14;

  // Nomes-base dos schemas (sem sufixo de versao), usados para resolver o XSD
  SCHEMA_EVTINFOCONTRIB  = 'evtInfoContrib';
  SCHEMA_EVTPGCC         = 'evtPGCC';
  SCHEMA_EVTBALANCETE    = 'evtBalancete';
  SCHEMA_EVTRELDEDUCOES  = 'evtRelDeducoes';
  SCHEMA_EVTAPLICRESTEC  = 'evtAplicResTec';
  SCHEMA_EVTREABERTMENSAL = 'evtReabertMensal';
  SCHEMA_EVTFECHMENSAL = 'evtFechMensal';
  SCHEMA_EVTDEBOPOFPUBLIC = 'evtDebOpOfPublic';
  SCHEMA_EVTINFOCOTISTAS = 'evtInfoCotistas';
  SCHEMA_EVTSERVREMPRECO = 'evtServRemPreco';
  SCHEMA_EVTSERVREMTARIFA = 'evtServRemTarifa';
  SCHEMA_EVTOPERFINANC = 'evtOperFinanc';
  SCHEMA_EVTANTECRECEB = 'evtAntecReceb';
  SCHEMA_EVTARRENDMERC = 'evtArrendMerc';
  SCHEMA_EVTARRANJOCREDDEST = 'evtArranjoCredDest';
  SCHEMA_EVTARRANJOPARTIC = 'evtArranjoPartic';
  SCHEMA_EVTSEGPREVCAP = 'evtSegPrevCap';
  SCHEMA_EVTSEGELEMSCOB = 'evtSegElemSCob';
  SCHEMA_EVTPLASSISTSAUDE = 'evtPlAssistSaude';
  SCHEMA_EVTIDAPOSTPREM = 'evtIdApostPrem';
  SCHEMA_ENVIOLOTEDERE   = 'envioLoteDere';
  SCHEMA_RETORNOLOTEDERE = 'retornoLoteDere';
  SCHEMA_EVTRETORNOTABELA = 'evtRetornoTabela';

resourcestring
  // Descricao de Mensagens de Erro
  ERR_MSG_MAIOR = 'Tamanho maior que o maximo permitido';
  ERR_MSG_MENOR = 'Tamanho menor que o minimo permitido';
  ERR_MSG_VAZIO = 'Nenhum valor informado';
  ERR_MSG_INVALIDO = 'Conteudo invalido';
  ERR_MSG_MAIOR_MAXIMO = 'Numero de ocorrencias maior que o maximo permitido - Maximo ';
  ERR_MSG_MENOR_MINIMO = 'Numero de ocorrencias menor que o minimo permitido - Minimo ';

  // Descricao das tags do evtInfoContrib (D-1001)
  DSC_TPOPER = 'Tipo de operacao do evento';
  DSC_MOTEXCL = 'Motivo da exclusao';
  DSC_NRPROC = 'Numero do processo administrativo/judicial';
  DSC_TPAMB = 'Identificacao do ambiente';
  DSC_APLICEMI = 'Identificacao do aplicativo emissor do evento';
  DSC_VERAPLIC = 'Versao do aplicativo emissor do evento';
  DSC_NRINSC = 'Numero de inscricao do contribuinte';
  DSC_INIVALID = 'Data de inicio da validade';
  DSC_FIMVALID = 'Data de termino da validade';
  DSC_REGTRIBPRINC = 'Regime de tributacao preponderante';
  DSC_REGTRIBSECUND = 'Regime de tributacao secundario';
  DSC_INDNATTRIB = 'Indicador da natureza tributaria do declarante';
  DSC_TPATIVIDADE = 'Identificacao da atividade realizada pelo contribuinte';
  DSC_UFCREDENC = 'Unidade Federativa credenciadora';
  DSC_ID = 'Identificador unico do evento';

  // Descricao das tags do evtPGCC (D-1011)
  DSC_PLANOCTAREF = 'Identificacao do plano de contas referencial';
  DSC_FREQENCERR = 'Indicador de frequencia de encerramento contabil';
  DSC_CCTA = 'Codigo completo da conta';
  DSC_CCTAINTERNA = 'Codigo da conta contabil do plano de contas interno';
  DSC_CDBRMISTA = 'Desdobramento de conta mista';
  DSC_NOMECTA = 'Nome da conta';
  DSC_INDCTA = 'Indicador do tipo de conta';
  DSC_DESCCTA = 'Descricao detalhada da natureza das operacoes da conta';
  DSC_CCTASUP = 'Codigo da conta hierarquica imediatamente superior';
  DSC_CCTAREF = 'Codigo da conta do plano de contas referencial';
  DSC_NIVELCTA = 'Nivel hierarquico da conta';
  DSC_NATCTA = 'Natureza da conta';
  DSC_CODNAT = 'Codigo da natureza da conta';
  DSC_CODTRIB = 'Codigo de tributacao para fins de IBS, CBS e IS';
  DSC_INDTRIBISS = 'Indicador de sujeicao ou vinculacao ao ISSQN';
  DSC_IDLEIDISP = 'Codigo do fundamento legal';
  DSC_INIVIG = 'Data de inicio de vigencia da conta';
  DSC_FIMVIG = 'Data de termino de vigencia da conta';

  // Descricao das tags do evtBalancete (D-1101)
  DSC_NRRECIBO = 'Numero do recibo do arquivo a ser alterado/retificado ou excluido';
  DSC_PERAPUR = 'Periodo de apuracao';
  DSC_NATSALDOINIC = 'Natureza do saldo inicial da conta';
  DSC_VSALDOINIC = 'Valor do saldo inicial da conta';
  DSC_VMOVDEBT = 'Valor total dos lancamentos a debito';
  DSC_VAJUSTEDEBT = 'Valor dos ajustes a excluir no vMovDebt';
  DSC_VMOVCRED = 'Valor total dos lancamentos a credito';
  DSC_VAJUSTECRED = 'Valor dos ajustes a excluir no vMovCred';
  DSC_NATSALDOFINAL = 'Natureza do saldo final da conta';
  DSC_VSALDOFINAL = 'Valor do saldo final da conta';
  DSC_NATVAPUR = 'Natureza do movimento informado no vApur';
  DSC_VAPUR = 'Valor base de apuracao';

  // Descricao das tags do evtRelDeducoes (D-1121)
  DSC_FINevt = 'Finalidade do evento na retificacao analitica pos-fechamento';
  DSC_TPDFE = 'Tipo de documento fiscal';
  DSC_DTEMI = 'Data de emissao do documento fiscal';
  DSC_CHDFE = 'Chave de acesso do documento fiscal';
  DSC_CHDFERETIF = 'Chave do documento fiscal objeto de alteracao ou exclusao';
  DSC_CPFALIEN = 'CPF do alienante pessoa fisica do imovel';
  DSC_VOPER = 'Valor total da operacao';
  DSC_CCTA_DED = 'Codigo da conta analitica';
  DSC_VDEDTOTAL = 'Valor total dedutivel para a atividade';
  DSC_VDED = 'Valor efetivamente aproveitado como deducao no periodo';
  DSC_VITEM = 'Valor total do item conforme documento fiscal';
  DSC_VITEMDEDTOTAL = 'Valor total dedutivel correspondente ao item';
  DSC_VITEMDED = 'Valor efetivamente utilizado como deducao correspondente ao item';
  DSC_NITEM = 'Numero do item do documento fiscal';
  DSC_TPATIV = 'Tipo de atividade vinculada a deducao';

  // Descricao das tags do evtAplicResTec (D-1106)
  DSC_SEMAPLIC = 'Indicacao da inexistencia de aplicacoes financeiras sobre reserva tecnica';
  DSC_IDATIVO = 'Numero de identificacao do titulo/ativo';
  DSC_DESCATIVO = 'Descricao da denominacao do ativo financeiro vinculado a reserva tecnica';
  DSC_VRENDPERRECEB = 'Valor de rendimentos periodicos recebidos no periodo de apuracao';
  DSC_VVARMENSAL = 'Valor de variacao mensal a ser incorporado ao saldo do ativo';
  DSC_VPRINCLIQRESG = 'Valor do principal liquidado ou resgatado do ativo financeiro';
  DSC_VRENDLIQRESG = 'Valor dos rendimentos recebidos na liquidacao ou resgate do ativo';

  // Descricao das tags do evtReabertMensal (D-1198)
  DSC_NRRECIBOREAB = 'Numero do recibo do evento de Fechamento Mensal (D-1199) a ser reaberto';

  // Descricao das tags dos eventos transacionais
  DSC_FINEVTOPER = 'Finalidade do evento';
  DSC_SUBPER = 'Indicacao do subperiodo de agrupamento das operacoes';

  // Descricao das tags do evtFechMensal (D-1199)
  DSC_INDINEXISTDEDU = 'Declaracao de inexistencia de deducoes a detalhar no periodo, dispensando a transmissao...';
  DSC_CODBCNRAIZ = 'Informar o codigo identificador da base de calculo negativa especifica do qual se desej...';
  DSC_USARBCNACUM = 'Informar a opcao por utilizar (se existir) o valor de base de calculo negativa acumulad...';
  DSC_METODOAPROVEIT = 'Informar qual metodo o contribuinte deseja para o aproveitamento da base de calculo neg...';
  DSC_CODBCN = 'Informar o codigo da base de calculo negativa que sera utilizado para deducao nesta com...';
  DSC_VUSARBCN = 'Valor maximo da base de calculo negativa que o contribuinte deseja realizar o aproveita...';

  // Descricao das tags do evtDebOpOfPublic (D-2101)
  DSC_DESCFUNDO = 'Descricao do nome do fundo';
  DSC_CNPJDEVEDOR = 'Numero de inscricao no CNPJ do devedor emitente do titulo de divida';
  DSC_VSALDOCONTINI = 'Representa o valor do titulo sobre o qual havera a incidencia dos juros no periodo';
  DSC_VENTRADAS = 'Valor total das entradas (compras de novos titulos) da mesma emissao e serie de ativos...';
  DSC_VSAIDAS = 'Valor total das saidas (vendas de titulos e amortizacoes) da mesma emissao e serie de a...';
  DSC_VJUROSREC = 'Valor dos juros recebidos relativos a mesma emissao e serie de ativos, no periodo de ap...';
  DSC_VSALDOCONTFIN = 'Valor final do agrumento de titulos';
  DSC_VSELIC = 'Valor equivalente a variacao da taxa Selic diaria acumulada no periodo aplicada sobre o...';
  DSC_VPISCOFINS = 'Valor da deducao relativa ao PIS/COFINS incidente sobre a receita tributada';
  DSC_SEMTITULOS = 'Indicacao da inexistencia de titulos de divida com oferta publica movimentados no periodo';

  // Descricao das tags do evtInfoCotistas (D-2102)
  DSC_TPDECLARANTE = 'Indicador do tipo de declarante';

  // Descricao das tags do evtServRemPreco (D-2201)
  DSC_NIF = 'Numero de Identificacao Fiscal (NIF) do adquirente estrangeiro, fornecido por orgao de...';
  DSC_CNAONIF = 'Codigo do motivo para a nao informacao do NIF do adquirente estrangeiro';
  DSC_NRDOCIDENT = 'Numero do documento de identificacao oficial no exterior (passaporte, carteira de ident...';
  DSC_CPAIS = 'Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia f...';
  DSC_CPF = 'Numero de inscricao no CPF do adquirente, se pessoa fisica';
  DSC_CNPJ = 'Numero de inscricao no CNPJ do adquirente, se pessoa juridica';
  DSC_CMUN = 'Codigo IBGE do municipio do endereco do adquirente, conforme informacoes existentes na...';
  DSC_NIFDEST = 'Numero de Identificacao Fiscal (NIF) do destinatario estrangeiro, fornecido por orgao d...';
  DSC_CNAONIFDEST = 'Codigo do motivo para a nao informacao do NIF do destinatario estrangeiro';
  DSC_NRDOCIDENTDEST = 'Numero do documento de identificacao oficial no exterior (passaporte, carteira de ident...';
  DSC_CPAISDEST = 'Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia f...';
  DSC_CPFDEST = 'Numero de inscricao no CPF do destinatario do servico, se pessoa fisica';
  DSC_CNPJDEST = 'Numero de inscricao no CNPJ do destinatario do servico, se pessoa juridica';
  DSC_CMUNDEST = 'Codigo IBGE do municipio do endereco do destinatario, conforme informacoes existentes n...';
  DSC_VBCAPUR = 'Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos...';
  DSC_VBCTRIB = 'Valor da base de calculo oferecida a tributacao';
  DSC_PIBSMUNTRIB = 'Aliquota do IBS municipal incidente sobre a operacao';
  DSC_VIBSMUNTRIB = 'Valor do IBS Municipal';
  DSC_PIBSUFTRIB = 'Aliquota do IBS estadual incidente sobre a operacao';
  DSC_VIBSUFTRIB = 'Valor do IBS Estadual';
  DSC_PCBSTRIB = 'Aliquota da CBS incidente sobre a operacao';
  DSC_VCBSTRIB = 'Valor da CBS';
  DSC_SEQREF = 'Numero sequencial ({seq}) da operacao individualizada de origem registrada anteriorment...';
  DSC_DHOPER = 'Data e hora da operacao';
  DSC_CHAGRUP = 'Chave identificadora do agrupamento de operacoes da DeRE. Composta por 50 posicoes alfa...';
  DSC_CODBC = 'Codigo identificador da base de calculo, conforme [[Tabela 12  Codigos de Bases de Calc...';
  DSC_CHAGRUPREF = 'Chave do agrupamento de operacoes de origem registrado anteriormente na DeRE, objeto de...';

  // Descricao das tags do evtServRemTarifa (D-2202)
  DSC_INDPRESENC = 'Indicador que define se o servico prestado foi fruido presencialmente por pessoa fisica';
  DSC_CMUNOPER = 'Codigo do municipio correspondente ao local do estabelecimento onde o servico foi prest...';

  // Descricao das tags do evtOperFinanc (D-2211)
  DSC_INDMOEDAESTR = 'Indicador de contrato referenciado em moeda estrangeira';

  // Descricao das tags do evtArranjoCredDest (D-2241)
  DSC_VISSQNPROP = 'Informar o valor do ISSQN devido sobre a operacao propria';
  DSC_VISSQNOUTRO = 'Informar o valor do ISSQN devido sobre operacoes de outros participantes de arranjo';
  DSC_VSOMADEDUCOES = 'Valor total das deducoes';

  // Descricao das tags do evtArranjoPartic (D-2242)
  DSC_TPPARTICIP = 'Tipo de participacao do contribuinte no arranjo de pagamento';
  DSC_VLIQOPER = 'Valor liquido da operacao';

  // Descricao das tags do evtSegPrevCap (D-2251)
  DSC_CPFPDV = 'Numero de inscricao no CPF do ponto de venda';
  DSC_CNPJPDV = 'Numero de inscricao no CNPJ do ponto de venda';
  DSC_INDIDENTIFADQ = 'Indicador se o subscritor e obrigado a se identificar por ocasiao da aquisicao, nos ter...';
  DSC_VBCDISTR = 'Valor da base de calculo para distribuicao do IBS, correspondente ao montante integral...';
  DSC_NIFSEG = 'Numero de Identificacao Fiscal (NIF) do participante/segurado estrangeiro, fornecido po...';
  DSC_CNAONIFSEG = 'Codigo do motivo para a nao informacao do NIF do participante/segurado estrangeiro';
  DSC_NRDOCIDENTSEG = 'Numero do documento de identificacao oficial no exterior (passaporte, carteira de ident...';
  DSC_CPAISSEG = 'Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia f...';
  DSC_VBCDISTRSEG = 'Valor individualizado do seguro, cosseguro ou contribuicao recebida. Parcela da base de...';
  DSC_CPFSEG = 'Numero de inscricao no CPF do participante/segurado, se pessoa fisica';
  DSC_CNPJSEG = 'Numero de inscricao no CNPJ do participante/segurado, se pessoa juridica';
  DSC_CMUNSEG = 'Codigo IBGE do municipio do endereco do participante/segurado, conforme informacoes exi...';
  DSC_TPCONTRATO = 'Tipo de contrato';

  // Descricao das tags do evtPlAssistSaude (D-3201)
  DSC_IDCONTRATO = 'Numero de identificacao do contrato relativo a operacao. Codigo alfanumerico que identi...';
  DSC_CNPJENTIDRELAC = 'Numero de inscricao no CNPJ da outra entidade juridica participante da relacao do contr...';
  DSC_DTNASCDEP = 'Data de nascimento do beneficiario dependente vinculado ao titular do plano de saude';
  DSC_CPFTITULAR = 'Numero de inscricao no CPF do beneficiario titular do plano de saude';
  DSC_DTNASCTITULAR = 'Data de nascimento do beneficiario titular do plano de saude';
  DSC_VTITULARDEP = 'Valor total relativo ao titular do plano ou seguro, incluindo seus dependentes';

  // Descricao das tags do evtIdApostPrem (D-4201)
  DSC_INDAPOSTAPRESENC = 'Indicador se a aposta no concurso de prognosticos foi realizada de forma presencial';

implementation

end.
