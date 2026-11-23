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

unit pcnCIOTW_Pamcard;

interface

uses
{$IFDEF FPC}
  LResources, 
  Controls, 
{$ELSE}

{$ENDIF}
  SysUtils,
  Classes, 
  StrUtils,
  Variants,
  Math,
  synacode,
  ACBrConsts,
  pcnCIOTW, 
  pcnCIOTR,
  ACBrDFe.Conversao,
  pcnGerador, 
  pcnLeitor,
  pcnCIOT, 
  ACBrCIOTConversao,
  ACBrUtil.Base,
  ACBrUtil.Strings;

type
  { TCIOTW_Pamcard }

  TCIOTW_Pamcard = class(TCIOTWClass)
  private
    FIndiceFavorecido: Integer;
    FIndiceFavorecidoDocumento: Integer;
    FIndicePessoaFiscal: Integer;
    FVersaoDF: TVersaoCIOT;
  protected
    procedure AddFieldNoXml( const Tipo: TACBrTipoCampo; ID, TAG: string; const min, max, ocorrencias: smallint; const valor: variant; const Descricao: string = ''; ParseTextoXML: Boolean = True; Atributo: String = '' );

    procedure GerarAlterarContratoFrete;
    procedure GerarAlterarStatusParcela;
    procedure GerarAlterarStatusPedagio;
    procedure GerarAlterarValoresViagem;
    procedure GerarAlterarValoresContratoFrete;
    procedure GerarCancelaViagem;//ok
    procedure GerarConsultarTAG(Favorecido : TPessoa);
    procedure GerarConsultarRNTRC(Favorecido : TPessoa);
    procedure GerarConsultarFrota(Favorecido : TPessoa);
    procedure GerarConsultarConta(Favorecido : TPessoa);
    procedure GerarConsultarCartao;
    procedure GerarConsultarContratoFrete;//ok
    procedure GerarConsultarFavorecido(Favorecido : TPessoa);
    procedure GerarConsultarViagem;
    procedure GerarConsultaStatusParcela;
    procedure GerarEncerrarContratoFrete;//ok
    procedure GerarEncerrarContratoFreteTacAgregado;//ok
    procedure GerarFavorecido;
    procedure GerarIncluirCartaoPortadorFrete;//ok
    procedure GerarConta(Favorecido : TPessoa);
    procedure GerarPagamentoParcela;//ok
    procedure GerarPagamentoPedagio;//ok
    procedure GerarIncluirRota; //ok
    procedure GerarRoteirizar; //ok
    procedure GerarConsultarFreteMinimo;//ok

    procedure FavorecidoContratoFrete( TipoFavorecido: Integer; Pessoa: TPessoa );//ok
    procedure VeiculosContratoFrete;//ok
    procedure DocumentosContratoFrete;//ok
    procedure RotaOrigemDestinoPontosContratoFrete;//ok
    procedure PedagioContratoFrete;//ok
    procedure PostosContratoFrete;//ok
    procedure FreteContratoFrete;//ok
    procedure ParcelasContratoFrete;//ok
    procedure QuitacaoContratoFrete;//ok
    procedure ColetaEntregaContratoFrete;//ok
    procedure GerarInserirContratoFrete;//ok
    procedure GerarInserirContratoFreteTacAgregado;//ok
  public
    constructor Create(ACIOTW: TCIOTW); override;

    property VersaoDF: TVersaoCIOT   read FVersaoDF write FVersaoDF;

    function GerarXml: Boolean; override;
  end;

implementation

procedure TCIOTW_Pamcard.AddFieldNoXml(const Tipo: TACBrTipoCampo; ID, TAG: string; const min, max, ocorrencias: smallint; const valor: variant; const Descricao: string; ParseTextoXML: Boolean; Atributo: String);

  function IsEmptyDate(wAno, wMes, wDia: Word): Boolean;
  begin
    Result := ((wAno = 1899) and (wMes = 12) and (wDia = 30));
  end;

var
  valorDbl : Double;
  wAno, wMes, wDia : Word;
  ConteudoProcessado : String;
  EstaVazio : Boolean;
begin
  case Tipo of
    tcInt, tcInt64 : begin
      // Tipo Inteiro
      try
        if tipo = tcInt then
          ConteudoProcessado := IntToStr( StrToInt( VarToStr( valor ) ) )
        else
          ConteudoProcessado := IntToStr( StrToInt64( VarToStr( valor ) ) );
      except
        ConteudoProcessado := '0';
      end;

      EstaVazio := ( ConteudoProcessado = '0' ) and ( ocorrencias = 0 );
    end;

    tcDe2, tcDe3, tcDe4, tcDe5, tcDe6, tcDe7, tcDe8, tcDe10 : begin
      try
        valorDbl := valor; // Converte Variant para Double
      except
        valorDbl := 0;
      end;

      EstaVazio := ( valorDbl = 0 ) and ( ocorrencias = 0 );
    end;

    tcDat, tcDatCFe, tcDatVcto: begin
      DecodeDate(VarToDateTime(valor), wAno, wMes, wDia);
      EstaVazio := IsEmptyDate(wAno, wMes, wDia);
    end;
  else
    EstaVazio := VarToStrDef( valor, '' ) = '';
  end;

  if( ( ocorrencias > 0 ) or
      ( not EstaVazio ) )then
  begin
    Gerador.wGrupo( 'fields' );
    Gerador.wCampo( tcStr, ID, 'key', 01, 99, ocorrencias, TAG, Descricao, ParseTextoXML, Atributo );
    Gerador.wCampo( Tipo, ID, 'value', min, max, ocorrencias, valor, Trim( TAG + ' ' + Descricao ), ParseTextoXML, Atributo );
    Gerador.wGrupo( '/fields' );
  end;
end;

procedure TCIOTW_Pamcard.GerarConsultarFreteMinimo;
begin
  Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'FindMinimumFreight' );

  with CIOT.ConsultarFreteMinimo do
  begin
    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyNumber( MatrizCNPJ ) );

    if( OnlyNumber( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 01, 2, 1 ); //CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyNumber( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.veiculo.categoria', 01, 03, 1, VeiculoCategoria );
    AddFieldNoXml( tcInt, '', 'viagem.distancia.km', 01, 10, 1, DistanciaPercorrida );
    AddFieldNoXml( tcInt, '', 'viagem.carga.tipo', 01, 02, 1, StrToIntDef( TipoCargaToStr( TipoCarga ), 0 ) );
    AddFieldNoXml( tcStr, '', 'viagem.veiculo.altodesempenho.indicador', 01, 01, 1, IfThen( AltoDesempenho, 'S','N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.contratacao.tipo', 01, 01, 0, IfThen( ComposicaoVeicular, '1', '2' ) );
    AddFieldNoXml( tcStr, '', 'viagem.retorno.vazio.indicador', 01, 01, 1, IfThen( RetornoVazio, 'S', 'N' ) );
  end;
end;

constructor TCIOTW_Pamcard.Create(ACIOTW: TCIOTW);
begin
  inherited Create(ACIOTW);
end;

function TCIOTW_Pamcard.GerarXml: Boolean;
begin
  Gerador.ListaDeAlertas.Clear;
  Gerador.ArquivoFormatoXML := '';
  // Carrega Layout que sera utilizado para gera o txt
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoTXT := '';
  //versao := 1;

  Gerador.wGrupo( 'arg0' );

  case CIOT.Integradora.Operacao of
    opIncluirRota: GerarIncluirRota;
    opRoteirizar: GerarRoteirizar;
    opIncluirCartaoPortador : GerarIncluirCartaoPortadorFrete;
    opAdicionar: GerarInserirContratoFrete;
    opAdicionarTacAgregado: GerarInserirContratoFreteTacAgregado;
    opObterCodigoIOT: GerarConsultarContratoFrete;
    opRetificar:;
    opCancelar: GerarCancelaViagem;
    opAdicionarViagem:;
    opAdicionarPagamento: GerarPagamentoParcela;
    opPagamentoPedagio: GerarPagamentoPedagio;
    opCancelarPagamento:;
    opEncerrar: GerarEncerrarContratoFrete;
    opEncerrarTacAgregado: GerarEncerrarContratoFreteTacAgregado;
    opConsultarFreteMinimo: GerarConsultarFreteMinimo;
  end;

  Gerador.wGrupo( '/arg0' );

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TCIOTW_Pamcard.FavorecidoContratoFrete( TipoFavorecido: Integer; Pessoa: TPessoa );
var
  f, fd: string;
begin
  if( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) = '' )then
    Exit;

  Inc( FIndiceFavorecido );
  f := IntToStr( FIndiceFavorecido );

  FIndiceFavorecidoDocumento := 1;
  fd := IntToStr( FIndiceFavorecidoDocumento );

  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.tipo', 01, 01, 1, TipoFavorecido ); //1-Contratado, 2-Subcontratante, 3-Motorista

  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.tipo', 01, 01, 1, IfThen( Length( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) ) = 11, 2, 1 ) ); //1-CNPJ, 2-CPF
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.numero', 01, 30, 1, OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) );
  AddFieldNoXml( tcDatVcto, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissao.data', 01, 10, 0, 0 );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissor.id', 01, 02, 0, 0 );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.uf', 01, 02, 0, '' );

  if( OnlyNumber( Pessoa.RNTRC ) <> '' )then
  begin
    Inc( FIndiceFavorecidoDocumento );
    fd := IntToStr( FIndiceFavorecidoDocumento );

    AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.tipo', 01, 01, 0, IfThen( Length( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) ) = 11, 5, 6 ) ); //6-RNTRC-CNPJ, 5-RNTRC-CPF
    AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.numero', 01, 30, 0, OnlyNumber( Pessoa.RNTRC ) );
    AddFieldNoXml( tcDatVcto, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissao.data', 01, 10, 0, 0 );
    AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissor.id', 01, 02, 0, 0 );
    AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.uf', 01, 02, 0, '' );
  end;

  if( Length( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) ) = 11 )then
  begin
    if( OnlyNumber( Pessoa.Rg ) <> '' )then
    begin
      Inc( FIndiceFavorecidoDocumento );
      fd := IntToStr( FIndiceFavorecidoDocumento );

      AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.tipo', 01, 01, 0, 3 );
      AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.numero', 01, 30, 0, OnlyNumber( Pessoa.Rg ) );
      AddFieldNoXml( tcDatVcto, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissao.data', 01, 10, 0, 0 );
      AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissor.id', 01, 02, 0, 0 );
      AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.uf', 01, 02, 0, Pessoa.RgUf );
    end;

    if( OnlyNumber( Pessoa.PISPASEP ) <> '' )then
    begin
      Inc( FIndiceFavorecidoDocumento );
      fd := IntToStr( FIndiceFavorecidoDocumento );

      AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.tipo', 01, 01, 0, 7 );
      AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.numero', 01, 30, 0, OnlyNumber( Pessoa.PISPASEP ) );
      AddFieldNoXml( tcDatVcto, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissao.data', 01, 10, 0, 0 );
      AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento'+fd+'.emissor.id', 01, 02, 0, 0 );
      AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.documento'+fd+'.uf', 01, 02, 0, '' );
    end;
  end;

  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.documento.qtde', 01, 01, 1, FIndiceFavorecidoDocumento );

  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.nome', 01, 40, 1, Pessoa.NomeOuRazaoSocial );
  AddFieldNoXml( tcDatVcto, '', 'viagem.favorecido'+f+'.data.nascimento', 01, 10, 0, Pessoa.DataNascimento );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.logradouro', 01, 40, 1, Pessoa.Endereco.Rua );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.numero', 01, 05, 1, Pessoa.Endereco.Numero );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.bairro', 01, 30, 1, Pessoa.Endereco.Bairro );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.complemento', 01, 15, 0, Pessoa.Endereco.Complemento );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.cep', 01, 08, 1, OnlyNumber( Pessoa.Endereco.CEP ) );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.endereco.cidade.ibge', 01, 07, 0, Pessoa.Endereco.CodigoMunicipio );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.pais', 01, 30, 0, Pessoa.Endereco.xPais );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.uf', 01, 02, 0, Pessoa.Endereco.Uf );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.cidade', 01, 30, 0, Pessoa.Endereco.xMunicipio );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.endereco.propriedade.tipo.id', 01, 02, 0, Pessoa.Endereco.PropriedadeTipoId );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.endereco.reside.desde', 01, 07, 0, Pessoa.Endereco.ResideDesde ); // MM/YYYY
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.telefone.ddd', 03, 03, 1, Pessoa.Telefones.Fixo.DDD );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.telefone.numero', 08, 08, 1, Pessoa.Telefones.Fixo.Numero );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.celular.operadora.id', 01, 02, 0, Pessoa.Telefones.Celular.OperadoraId );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.celular.ddd', 03, 03, 0, Pessoa.Telefones.Celular.DDD );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.celular.numero', 09, 09, 0, Pessoa.Telefones.Celular.Numero );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.email', 01, 40, 0, Pessoa.EMail );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.sexo', 01, 01, 0, Pessoa.Sexo );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.nacionalidade.id', 01, 01, 0, Pessoa.NacionalidadeId );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.naturalidade.ibge', 01, 09, 0, Pessoa.NaturalidadeIbge );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.meio.pagamento', 01, 01, 0, Pessoa.MeioPagamentoId );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.consumo.responsavel.cpf', 01, 11, 0, OnlyNumber( Pessoa.ConsumoResponsavelCpf ) );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.consumo.responsavel.nome', 01, 50, 0, Pessoa.ConsumoResponsavelNome );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.conta.banco', 01, 04, 0, Pessoa.InformacoesBancarias.InstituicaoBancaria );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.conta.agencia', 01, 10, 0, Pessoa.InformacoesBancarias.Agencia );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.conta.agencia.digito', 01, 01, 0, Pessoa.InformacoesBancarias.DigitoAgencia );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.conta.numero', 01, 20, 0, Pessoa.InformacoesBancarias.Conta );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.conta.tipo', 01, 02, 0, TipoContaToIndex( Pessoa.InformacoesBancarias.TipoConta ) );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.conta.chavepix.tipo', 01, 01, 0, TipoChavePixToIndex( Pessoa.InformacoesBancarias.TipoChavePix ) );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.conta.chavepix', 01, 50, 0, Pessoa.InformacoesBancarias.ChavePix );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.cartao.numero', 01, 16, 0, Pessoa.InformacoesBancarias.Cartao.Numero );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.empresa.nome', 01, 50, 0, Pessoa.InformacoesBancarias.Cartao.EmpresaNome );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.empresa.cnpj', 01, 14, 0, Pessoa.InformacoesBancarias.Cartao.EmpresaCNPJ );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.empresa.rntrc', 01, 08, 0, OnlyNumber( Pessoa.InformacoesBancarias.Cartao.EmpresaRNTRC ) );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.escolaridade', 01, 02, 0, Pessoa.Escolaridade );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.qualificacao', 01, 02, 0, Pessoa.Qualificacao );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.estado.civil', 01, 02, 0, Pessoa.EstadoCivil );
  AddFieldNoXml( tcStr, '', 'viagem.favorecido'+f+'.nome.mae', 01, 60, 0, Pessoa.NomeMae );
  AddFieldNoXml( tcInt, '', 'viagem.favorecido'+f+'.numDependentes', 01, 02, 0, Pessoa.NumDependentes );
end;

procedure TCIOTW_Pamcard.VeiculosContratoFrete;
var
  i : Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcStr, '', 'viagem.veiculo.categoria', 01, 03, 1, VeiculoCategoria );
    AddFieldNoXml( tcStr, '', 'viagem.veiculo.categoria.eixo.suspenso', 01, 02, 0, VeiculoCategoriaEixoSuspenso );
    AddFieldNoXml( tcStr, '', 'viagem.veiculo.altodesempenho.indicador', 01, 01, 1, IfThen( AltoDesempenho, 'S','N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.veiculo.qtde', 01, 01, 1, Veiculos.Count );

    for i := 0 to Veiculos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.veiculo%d.placa', [i + 1] ), 01, 07, 1, OnlyAlphaNum( Veiculos.Items[i].Placa ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.veiculo%d.rntrc', [i + 1] ), 01, 08, 0, OnlyNumber( Veiculos.Items[i].RNTRC ) );
      AddFieldNoXml( tcInt, '', Format( 'viagem.veiculo%d.eixos.numero', [i + 1] ), 01, 02, 1, Veiculos.Items[i].NumeroEixos );
    end;
  end;
end;

procedure TCIOTW_Pamcard.DocumentosContratoFrete;

  procedure PessoaFiscal( id, Tipo: Integer; Pessoa: TPessoa );
  var
    p : Integer;
  begin
    if( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) = '' )then
      Exit;

    Inc( FIndicePessoaFiscal );
    p := FIndicePessoaFiscal;

    AddFieldNoXml( tcInt, '', Format('viagem.documento%d.pessoafiscal%d.tipo', [id+1, p] ), 01, 01, 1, Tipo ); //1-Remetente, 2-Destinatario, 3-Consignatario
    AddFieldNoXml( tcInt, '', Format('viagem.documento%d.pessoafiscal%d.codigo', [id+1, p] ), 01, 10, 0, Pessoa.CodigoNaIntegradora );

    if( Pessoa.CodigoNaIntegradora = 0 )then
    begin
      AddFieldNoXml( tcInt, '', Format('viagem.documento%d.pessoafiscal%d.documento.tipo', [id+1, p] ), 01, 01, 1, IfThen( Length( OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) ) = 11, 2, 1 ) ); //1-CNPJ 2-CPF
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.documento.numero', [id+1, p] ), 01, 20, 1, OnlyCPFCNPJAlphaNum( Pessoa.CpfOuCnpj ) );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.nome', [id+1, p] ), 01, 40, 1, Pessoa.NomeOuRazaoSocial );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.endereco.logradouro', [id+1, p]), 01, 40, 1, Pessoa.Endereco.Rua );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.endereco.numero', [id+1, p] ), 01, 05, 1, Pessoa.Endereco.Numero );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.endereco.complemento', [id+1, p] ), 01, 15, 0, Pessoa.Endereco.Complemento );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.endereco.bairro', [id+1, p] ), 01, 30, 1, Pessoa.Endereco.Bairro );
      AddFieldNoXml( tcInt, '', Format('viagem.documento%d.pessoafiscal%d.endereco.cidade.ibge', [id+1, p] ), 01, 07, 0, Pessoa.Endereco.CodigoMunicipio );
      AddFieldNoXml( tcStr, '', Format('viagem.documento%d.pessoafiscal%d.endereco.cep', [id+1, p] ), 01, 08, 0, OnlyNumber( Pessoa.Endereco.CEP ) );
    end;
  end;

var
  i : Integer;
  Item: TNotaFiscalCollectionItem;
  PessoaFiscalQtd : Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    if( Viagens.Count = 0 )then
      Exit;

    AddFieldNoXml( tcInt, '', 'viagem.documento.qtde', 01, 10, 1, Viagens[0].NotasFiscais.Count );

    for i := 0 to Viagens[0].NotasFiscais.Count -1 do
    begin
      Item := Viagens[0].NotasFiscais[i];

      FIndicePessoaFiscal := 0;
      PessoaFiscalQtd := 0;

      if( OnlyCPFCNPJAlphaNum( Item.Remetente.CpfOuCnpj ) <> '' )then
        Inc( PessoaFiscalQtd );

      if( OnlyCPFCNPJAlphaNum( Item.Destinatario.CpfOuCnpj ) <> '' )then
        Inc( PessoaFiscalQtd );

      if( OnlyCPFCNPJAlphaNum( Item.Consignatario.CpfOuCnpj ) <> '' )then
        Inc( PessoaFiscalQtd );

      AddFieldNoXml( tcInt, '', Format( 'viagem.documento%d.tipo', [i+1] ), 01, 02, 1, TipoDocumentoPamcardToStr( Item.TipoDocumentoPamcard ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.documento%d.numero', [i+1] ), 01, 30, 01, Item.Numero );
      AddFieldNoXml( tcStr, '', Format( 'viagem.documento%d.serie', [i+1] ), 01, 05, 0, Item.Serie );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.documento%d.quantidade', [i+1] ), 01, 09, 0, Item.QuantidadeDaMercadoriaNoEmbarque );
      AddFieldNoXml( tcStr, '', Format( 'viagem.documento%d.especie', [i+1] ), 01, 15, 0, Item.Especie );
      AddFieldNoXml( tcDe3, '', Format( 'viagem.documento%d.cubagem', [i+1] ), 01, 07, 0, Item.Cubagem );
      AddFieldNoXml( tcInt, '', Format( 'viagem.documento%d.natureza', [i+1] ), 04, 04, 0, Item.CodigoNCMNaturezaCarga );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.documento%d.peso', [i+1] ), 01, 07, 0, Item.Peso );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.documento%d.mercadoria.valor', [i+1] ), 01, 19, 0, Item.ValorTotal );
      AddFieldNoXml( tcStr, '', Format( 'viagem.documento%d.chaveacesso', [i+1] ), 01, 46, 0, Item.ChaveAcesso );
      AddFieldNoXml( tcInt, '', Format( 'viagem.documento%d.pessoafiscal.qtde', [i+1] ), 01, 02, 1, PessoaFiscalQtd );

      PessoaFiscal( i, 1, Item.Remetente );
      PessoaFiscal( i, 2, Item.Destinatario );
      PessoaFiscal( i, 3, Item.Consignatario );
    end;

    //Implementar lista futuramente se necessario
    {AddFieldNoXml( tcStr, '', 'viagem.documento.complementar.qtde', 01, 02, 0, 0 );

    for i := 0 to Qtd do
    begin
      AddFieldNoXml( tcStr, '', Format('viagem.documento.complementar%d.tipo', [i+1] ), 01, 02, 0, 0 );
    end;}
  end;
end;

procedure TCIOTW_Pamcard.RotaOrigemDestinoPontosContratoFrete;
var
  i: Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcInt, '', 'viagem.rota.id', 01, 10, 0, Rota.Id );
    AddFieldNoXml( tcStr, '', 'viagem.rota.nome', 01, 50, 0, Rota.Nome );

    AddFieldNoXml( tcInt, '', 'viagem.origem.cidade.ibge', 01, 07, 0, Rota.OrigemCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.latitude', 01, 10, 0, Rota.OrigemCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.longitude', 01, 10, 0, Rota.OrigemCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.cep', 01, 08, 0, OnlyNumber( Rota.OrigemCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.origem.eixo.indicador', 01, 01, 1, IfThen( Rota.OrigemEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcInt, '', 'viagem.destino.cidade.ibge', 01, 07, 0, Rota.DestinoCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.latitude', 01, 10, 0, Rota.DestinoCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.longitude', 01, 10, 0, Rota.DestinoCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.cep', 01, 08, 0, OnlyNumber( Rota.DestinoCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.destino.eixo.indicador', 01, 01, 1, IfThen( Rota.DestinoEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcInt, '', 'viagem.ponto.qtde', 01, 10, 0, Rota.Pontos.Count );

    for i := 0 to Rota.Pontos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.pais.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[i].PaisNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.estado.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[i].EstadoNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[i].CidadeNome );
      AddFieldNoXml( tcInt, '', Format( 'viagem.ponto%d.cidade.ibge', [i+1] ), 01, 07, 0, Rota.Pontos.Items[i].CidadeIbge );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.cep', [i+1] ), 01, 08, 0, OnlyNumber( Rota.Pontos.Items[i].CidadeCep ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.latitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[i].CidadeLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.longitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[i].CidadeLongitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.eixo.indicador', [i+1] ), 01, 01, 1, IfThen( Rota.Pontos.Items[i].EixoSuspenso, 'S', 'N' ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.obter.postos', 01, 01, 0, IfThen( Rota.ObterPostos, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.uf', 01, 01, 0, IfThen( Rota.ObterUf, 'S', 'N' ) );
  end;
end;


procedure TCIOTW_Pamcard.PedagioContratoFrete;
var
  i: Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.idavolta', 01, 01, 0, IfThen( Pedagio.IdaVolta, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.obter.praca', 01, 01, 0, IfThen( Pedagio.ObterPraca, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.roteirizar', 01, 01, 0, IfThen( Pedagio.Roteirizar, 'S', 'N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.solucao.id', 01, 01, 0, Pedagio.SolucaoId );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.status.id', 01, 02, 0, Pedagio.StatusId );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.tag.emissor.id', 01, 04, 0, Pedagio.TagEmissorId );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.tag.emissor.tipo', 01, 04, 0, Pedagio.TagEmissorTipo );

    AddFieldNoXml( tcInt, '', 'viagem.pedagio.roteirizar.tipo', 01, 01, 0, 1 );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.caminho', 01, 01, 0, Pedagio.Caminho );

    AddFieldNoXml( tcInt, '', 'viagem.pedagio.praca.qtde', 01, 02, 0, Pedagio.Pracas.Count );

    for i := 0 to Pedagio.Pracas.Count - 1 do
    begin
      AddFieldNoXml( tcInt, '', Format( 'viagem.pedagio.praca%d.id', [i+1] ), 01, 05, 0, Pedagio.Pracas.Items[i].Id );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.pedagio.praca%d.valor', [i+1] ), 01, 10, 0, Pedagio.Pracas.Items[i].Valor );
    end;
  end;
end;

procedure TCIOTW_Pamcard.PostosContratoFrete;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.FreteContratoFrete;
var
  i: Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcDe2, '', 'viagem.frete.valor.bruto', 01, 10, 1, Frete.ValorBruto );
    AddFieldNoXml( tcInt, '', 'viagem.frete.pagamento.indicador', 01, 01, 1, IndicadorPagamentoPamcardToIndex( Frete.IndicadorPagamento ) );
    AddFieldNoXml( tcInt, '', 'viagem.frete.item.qtde', 01, 02, 1, Frete.Itens.Count );

    for i := 0 to Frete.Itens.Count - 1 do
    begin
      AddFieldNoXml( tcInt, '', Format( 'viagem.frete.item%d.tipo', [i+1] ), 01, 03, 1, Frete.Itens.Items[i].Tipo );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.frete.item%d.valor', [i+1] ), 01, 19, 1, Frete.Itens.Items[i].Valor );
    end;
  end;
end;

procedure TCIOTW_Pamcard.ParcelasContratoFrete;
var
  i: Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcInt, '', 'viagem.parcela.qtde', 01, 10, 0, Parcelas.Count );

    for i := 0 to Parcelas.Count - 1 do
    begin
      AddFieldNoXml( tcDatVcto, '', Format( 'viagem.parcela%d.data', [i+1] ), 01, 10, 1, Parcelas.Items[i].Data );
      AddFieldNoXml( tcInt, '', Format( 'viagem.parcela%d.efetivacao.tipo', [i+1] ), 01, 02, 1, Parcelas.Items[i].EfetivacaoTipo );
      AddFieldNoXml( tcInt, '', Format( 'viagem.parcela%d.favorecido.tipo.id', [i+1] ), 01, 02, 1, Parcelas.Items[i].FavorecidoTipoId );
      AddFieldNoXml( tcStr, '', Format( 'viagem.parcela%d.numero.cliente', [i+1] ), 01, 18, 1, Parcelas.Items[i].NumeroCliente );
      AddFieldNoXml( tcInt, '', Format( 'viagem.parcela%d.status.id', [i+1] ), 01, 02, 1, Parcelas.Items[i].StatusId );
      AddFieldNoXml( tcStr, '', Format( 'viagem.parcela%d.subtipo', [i+1] ), 01, 02, 1, Parcelas.Items[i].Subtipo );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.parcela%d.valor', [i+1] ), 01, 11, 1, Parcelas.Items[i].Valor );
    end;
  end;
end;

procedure TCIOTW_Pamcard.QuitacaoContratoFrete;
var
  i: Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcStr, '', 'viagem.quitacao.indicador', 01, 01, 0, IfThen( Quitacao.Indicador, 'S', '' ) );
    AddFieldNoXml( tcInt, '', 'viagem.quitacao.origem.pagamento', 01, 02, 0,  Quitacao.OrigemPagamento );
    AddFieldNoXml( tcInt, '', 'viagem.quitacao.prazo', 01, 02, 0, Quitacao.Prazo );
    AddFieldNoXml( tcStr, '', 'viagem.quitacao.entrega.ressalva', 01, 01, 0, IfThen( Quitacao.EntregaRessalva, 'S', '' ) );
    AddFieldNoXml( tcInt, '', 'viagem.quitacao.desconto.tipo', 01, 01, 0, Quitacao.DescontoTipo );
    AddFieldNoXml( tcDe2, '', 'viagem.quitacao.desconto.tolerancia', 01, 03, 0,  Quitacao.DescontoTolerancia );
    AddFieldNoXml( tcInt, '', 'viagem.quitacao.desconto.faixa.qtde', 01, 09, 0, Quitacao.DescontoFaixas.Count );

    for i := 0 to Quitacao.DescontoFaixas.Count - 1 do
    begin
      AddFieldNoXml( tcDe3, '', Format( 'viagem.quitacao.desconto.faixa%d.ate', [i+1] ), 01, 09, 1, Quitacao.DescontoFaixas.Items[i].Ate );
      AddFieldNoXml( tcDe2, '', Format( 'viagem.quitacao.desconto.faixa%d.percentual', [i+1] ), 01, 03, 1, Quitacao.DescontoFaixas.Items[i].Percentual );
    end;
  end;
end;

procedure TCIOTW_Pamcard.ColetaEntregaContratoFrete;
var
  i : Integer;
begin
  with CIOT.AdicionarOperacao do
  begin
    AddFieldNoXml( tcInt, '', 'viagem.coletaentrega.qtde', 01, 02, 1, ColetaEntrega.Count );

    for i := 0 to ColetaEntrega.Count - 1 do
    begin
      AddFieldNoXml( tcInt, '', Format( 'viagem.coletaentrega%d.origem.ibge', [i + 1] ), 01, 07, 0, ColetaEntrega.Items[i].OrigemIBGE );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.origem.cep', [i + 1] ), 01, 08, 0, OnlyNumber( ColetaEntrega.Items[i].OrigemCEP ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.origem.latitude', [i + 1] ), 01, 10, 0, ColetaEntrega.Items[i].OrigemLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.origem.longitude', [i + 1] ), 01, 10, 0, ColetaEntrega.Items[i].OrigemLongitude );

      AddFieldNoXml( tcInt, '', Format( 'viagem.coletaentrega%d.destino.ibge', [i + 1] ), 01, 07, 0, ColetaEntrega.Items[i].DestinoIBGE );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.destino.cep', [i + 1] ), 01, 08, 0, OnlyNumber( ColetaEntrega.Items[i].DestinoCEP ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.destino.latitude', [i + 1] ), 01, 10, 0, ColetaEntrega.Items[i].DestinoLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.coletaentrega%d.destino.longitude', [i + 1] ), 01, 10, 0, ColetaEntrega.Items[i].DestinoLongitude );

      AddFieldNoXml( tcInt, '', Format( 'viagem.coletaentrega%d.distancia', [i + 1] ), 01, 09, 1, ColetaEntrega.Items[i].Distancia );
    end;
  end;
end;

procedure TCIOTW_Pamcard.GerarInserirContratoFrete;
var
  FavorecidoQtd, I : Integer;
begin
  Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'InsertFreightContract' );

  FIndiceFavorecido := 0;
  FavorecidoQtd := 0;

  with CIOT.AdicionarOperacao do
  begin
    if( OnlyCPFCNPJAlphaNum( Contratado.CpfOuCnpj ) <> '' )then
      Inc( FavorecidoQtd );

    if( OnlyCPFCNPJAlphaNum( Subcontratante.CpfOuCnpj ) <> '' )then
      Inc( FavorecidoQtd );

    if( OnlyCPFCNPJAlphaNum( Motorista.CpfOuCnpj ) <> '' )then
      Inc( FavorecidoQtd );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 01, 2, 1 ); //CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcInt, '', 'viagem.favorecido.qtde', 01, 02, 1, FavorecidoQtd );

    FavorecidoContratoFrete( 1, Contratado );
    FavorecidoContratoFrete( 2, Subcontratante );
    FavorecidoContratoFrete( 3, Motorista );

    AddFieldNoXml( tcStr, '', 'viagem.contrato.numero', 01, 30, 0, CodigoIdentificacaoOperacaoPrincipal );
    AddFieldNoXml( tcInt, '', 'viagem.id.cliente', 01, 18, 1, IdOperacaoCliente );
    AddFieldNoXml( tcDatVcto, '', 'viagem.data.partida', 01, 10, 1, DataInicioViagem );
    AddFieldNoXml( tcDatVcto, '', 'viagem.data.termino', 01, 10, 1, DataFimViagem );

    VeiculosContratoFrete;

    if( Viagens.Count > 0 )then
      AddFieldNoXml( tcInt, '', 'viagem.distancia.km', 01, 10, 1, Viagens[0].DistanciaPercorrida );

    AddFieldNoXml( tcInt, '', 'viagem.carga.tipo', 01, 02, 1, TipoCargaToStr( CodigoTipoCarga ) );
    AddFieldNoXml( tcInt, '', 'viagem.carga.natureza', 04, 04, 1, CodigoNCMNaturezaCarga );
    AddFieldNoXml( tcDe2, '', 'viagem.carga.peso', 01, 07, 1, PesoCarga );
    AddFieldNoXml( tcInt, '', 'viagem.carga.perfil.id', 01, 01, 0, CargaPerfilId );
    AddFieldNoXml( tcDe2, '', 'viagem.carga.valorunitario', 01, 11, 0, CargaValorUnitario );

    DocumentosContratoFrete;

    RotaOrigemDestinoPontosContratoFrete;

    PedagioContratoFrete;

    FreteContratoFrete;

    ParcelasContratoFrete;

    QuitacaoContratoFrete;

    AddFieldNoXml( tcInt, '', 'viagem.diferencafrete.credito', 01, 01, 0, IfThen( DiferencaFreteCredito, 1, 0 ) );
    AddFieldNoXml( tcInt, '', 'viagem.diferencafrete.debito', 01, 01, 0, IfThen( DiferencaFreteDebito, 1, 0 ) );
    AddFieldNoXml( tcDe2, '', 'viagem.diferencafrete.tarifamotorista', 01, 11, 0, DiferencaFreteTarifaMotorista );
    AddFieldNoXml( tcStr, '', 'viagem.comprovacao.observacao', 01, 4000, 0, ComprovacaoObservacao );

    if( OnlyCPFCNPJAlphaNum( CiotEmissor.CpfOuCnpj ) <> '' )then
    begin
      AddFieldNoXml( tcStr, '', 'viagem.ciot.emissor.cliente.documento.tipo', 01, 01, 0, IfThen( Length( OnlyCPFCNPJAlphaNum( CiotEmissor.CpfOuCnpj ) ) = 11, 2, 1 ) );
      AddFieldNoXml( tcStr, '', 'viagem.ciot.emissor.cliente.documento.numero', 01, 14, 0, CiotEmissor.CpfOuCnpj );
      AddFieldNoXml( tcStr, '', 'viagem.ciot.emissor.cliente.nome', 01, 60, 0, CiotEmissor.NomeOuRazaoSocial );
    end;

    AddFieldNoXml( tcInt, '', 'viagem.contratacao.tipo', 01, 01, 0, IfThen( ComposicaoVeicular, '1', '2' ) );
    AddFieldNoXml( tcStr, '', 'viagem.retorno.vazio.indicador', 01, 01, 1, IfThen( RetornoVazio, 'S', 'N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.operacao.tipo', 01, 01, 1, TipoOperacaoPamcardToIndex( TipoOperacao ) );

    if( TipoOperacao = topFracionada )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.contratante.carga.fracionada.qtde', 01, 02, 1, ContratantesCargaFracionada.Count );

      for i := 0 to ContratantesCargaFracionada.Count - 1 do
      begin
        AddFieldNoXml( tcInt, '', Format( 'viagem.contratante.carga.fracionada.documento%d.tipo', [i+1] ), 01, 14, 1, IfThen( Length( OnlyNumber( ContratantesCargaFracionada.Items[i].CpfOuCnpj ) ) = 11, 2, 1 ) ); //1-CNPJ, 2-CPF
        AddFieldNoXml( tcStr, '', Format( 'viagem.contratante.carga.fracionada.documento%d.numero', [i+1] ), 01, 14, 1, ContratantesCargaFracionada.Items[i].CpfOuCnpj );
      end;
    end;

    ColetaEntregaContratoFrete;
  end;
end;

procedure TCIOTW_Pamcard.GerarInserirContratoFreteTacAgregado;
var
  FavorecidoQtd, I : Integer;
begin
  Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'InsertTacFreightContract' );

  FIndiceFavorecido := 0;
  FavorecidoQtd := 0;

  with CIOT.AdicionarOperacao do
  begin
    if( OnlyNumber( Contratado.CpfOuCnpj ) <> '' )then
      Inc( FavorecidoQtd );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyNumber( MatrizCNPJ ) );

    if( OnlyNumber( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 01, 2, 1 ); //CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyNumber( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcInt, '', 'viagem.favorecido.qtde', 01, 02, 1, FavorecidoQtd );// Obrigatório que o favorecido seja CONTRATADO = Cod. 01

    FavorecidoContratoFrete( 1, Contratado );

    AddFieldNoXml( tcStr, '', 'viagem.contrato.numero', 01, 30, 0, CodigoIdentificacaoOperacaoPrincipal );
    AddFieldNoXml( tcInt, '', 'viagem.id.cliente', 01, 18, 1, IdOperacaoCliente );
    AddFieldNoXml( tcDatVcto, '', 'viagem.data.termino', 01, 10, 1, DataFimViagem );

    AddFieldNoXml( tcInt, '', 'viagem.veiculo.qtde', 01, 01, 1, Veiculos.Count );

    for i := 0 to Veiculos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.veiculo%d.placa', [i + 1] ), 01, 07, 1, OnlyAlphaNum( Veiculos.Items[i].Placa ) );
      AddFieldNoXml( tcInt, '', Format( 'viagem.veiculo%d.eixos.numero', [i + 1] ), 01, 02, 1, Veiculos.Items[i].NumeroEixos );
    end;

    DocumentosContratoFrete;
    FreteContratoFrete;
    ParcelasContratoFrete;
  end;
end;

procedure TCIOTW_Pamcard.GerarAlterarContratoFrete;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarAlterarStatusParcela;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarAlterarStatusPedagio;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarAlterarValoresContratoFrete;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarAlterarValoresViagem;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarCancelaViagem;
begin
  with CIOT.CancelarOperacao do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'CancelTrip' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( CIOT.CancelarOperacao.MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 01, 2, 1 ); //CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.id', 01, 10, 0, CIOT.CancelarOperacao.IdOperacaoIntegradora );
    AddFieldNoXml( tcStr, '', 'viagem.id.cliente', 01, 18, 0, CIOT.CancelarOperacao.IdOperacaoCliente );
    AddFieldNoXml( tcStr, '', 'viagem.antt.ciot.numero', 01, 12, 0, CIOT.CancelarOperacao.CodigoIdentificacaoOperacao );
    AddFieldNoXml( tcStr, '', 'viagem.antt.cancelamento.motivo', 01, 500, 1, CIOT.CancelarOperacao.Motivo );
  end;
end;

procedure TCIOTW_Pamcard.GerarConsultarContratoFrete;
begin
  with CIOT.ObterCodigoOperacaoTransporte do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'FindFreightContract' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( CIOT.ObterCodigoOperacaoTransporte.MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 01, 2, 1 ); //CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.id', 01, 10, 0, CIOT.ObterCodigoOperacaoTransporte.IdOperacaoIntegradora );
    AddFieldNoXml( tcStr, '', 'viagem.id.cliente', 01, 18, 0, CIOT.ObterCodigoOperacaoTransporte.IdOperacaoCliente );
    AddFieldNoXml( tcStr, '', 'viagem.antt.ciot.numero', 01, 12, 0, CIOT.ObterCodigoOperacaoTransporte.CodigoIdentificacaoOperacao );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.obter.praca', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.PedagioObterPraca, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.obter.rota', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.PedagioObterRota, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.favorecido', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterFavorecido, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.documento', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterDocumento, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.valores', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterValores, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.veiculo', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterVeiculo, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.quitacao', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterQuitacao, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.uf', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterUf, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.postos', 01, 01, 1, IfThen( CIOT.ObterCodigoOperacaoTransporte.ObterPostos, 'S', 'N' ) );
  end;
end;

procedure TCIOTW_Pamcard.GerarConsultarCartao;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarConta(Favorecido: TPessoa);
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarFavorecido(Favorecido: TPessoa);
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarFrota(Favorecido: TPessoa);
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarRNTRC(Favorecido: TPessoa);
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarTAG(Favorecido : TPessoa);
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultarViagem;
begin
  //verificar e remover
end;

procedure TCIOTW_Pamcard.GerarConsultaStatusParcela;
begin
	//verificar e remover
end;

procedure TCIOTW_Pamcard.GerarEncerrarContratoFrete;
var
  I : Integer;
begin
  with CIOT.EncerrarOperacao do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'CloseFreightContract' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 02, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.id.cliente', 01, 18, 0, IdOperacaoCliente );
    AddFieldNoXml( tcStr, '', 'viagem.id', 01, 10, 0, IdOperacaoIntegradora );
    AddFieldNoXml( tcStr, '', 'viagem.antt.ciot.numero', 01, 12, 0, CodigoIdentificacaoOperacao );

    AddFieldNoXml( tcDe2, '', 'viagem.carga.peso', 01, 05, 1, PesoCarga );
  end;
end;

procedure TCIOTW_Pamcard.GerarEncerrarContratoFreteTacAgregado;
var
  I : Integer;
begin
  with CIOT.EncerrarOperacao do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'CloseTACFreightContract' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyNumber( MatrizCNPJ ) );

    if( OnlyNumber( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 02, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyNumber( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.id.cliente', 01, 18, 0, IdOperacaoCliente );
    AddFieldNoXml( tcStr, '', 'viagem.id', 01, 10, 0, IdOperacaoIntegradora );
    AddFieldNoXml( tcStr, '', 'viagem.antt.ciot.numero', 01, 12, 0, CodigoIdentificacaoOperacao );

    AddFieldNoXml( tcInt, '', 'viagem.rota.qtde', 01, 02, 1, RotasTacAgregado.Count );

    for i := 0 to RotasTacAgregado.Count - 1 do
      AddFieldNoXml( tcInt, '', Format( 'viagem.rota%d.quantidade.viagens', [i + 1] ), 01, 05, 1, RotasTacAgregado.Items[i].QtdViagens );

    for i := 0 to OrigensDestinosTacAgregado.Count - 1 do
    begin
      AddFieldNoXml( tcInt, '', Format( 'viagem.origem%d.cidade.ibge', [i + 1] ), 01, 07, 0, OrigensDestinosTacAgregado.Items[i].OrigemIBGE );
      AddFieldNoXml( tcStr, '', Format( 'viagem.origem%d.cidade.cep', [i + 1] ), 01, 08, 0, OnlyNumber( OrigensDestinosTacAgregado.Items[i].OrigemCEP ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.origem%d.cidade.latitude', [i + 1] ), 01, 10, 0, OrigensDestinosTacAgregado.Items[i].OrigemLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.origem%d.cidade.longitude', [i + 1] ), 01, 10, 0, OrigensDestinosTacAgregado.Items[i].OrigemLongitude );

      AddFieldNoXml( tcInt, '', Format( 'viagem.destino%d.cidade.ibge', [i + 1] ), 01, 07, 0, OrigensDestinosTacAgregado.Items[i].DestinoIBGE );
      AddFieldNoXml( tcStr, '', Format( 'viagem.destino%d.cidade.cep', [i + 1] ), 01, 08, 0, OnlyNumber( OrigensDestinosTacAgregado.Items[i].DestinoCEP ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.destino%d.cidade.latitude', [i + 1] ), 01, 10, 0, OrigensDestinosTacAgregado.Items[i].DestinoLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.destino%d.cidade.longitude', [i + 1] ), 01, 10, 0, OrigensDestinosTacAgregado.Items[i].DestinoLongitude );

      AddFieldNoXml( tcInt, '', Format( 'viagem.distancia%d.km', [i + 1] ), 01, 09, 1, OrigensDestinosTacAgregado.Items[i].Distancia );
    end;
  end;
end;

procedure TCIOTW_Pamcard.GerarConta(Favorecido : TPessoa);
begin
	//sem implementação verificar remover
end;

procedure TCIOTW_Pamcard.GerarPagamentoParcela;
var
  I : Integer;
begin
  with CIOT.AdicionarPagamento do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'PayParcel' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 02, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.id', 01, 10, 0, IdOperacaoIntegradora );
    AddFieldNoXml( tcStr, '', 'viagem.id.cliente', 01, 18, 0, IdOperacaoCliente );
    AddFieldNoXml( tcStr, '', 'viagem.antt.ciot.numero', 01, 12, 0, CodigoIdentificacaoOperacao );
    AddFieldNoXml( tcInt, '', 'viagem.parcela.qtde', 01, 10, 0, Pagamentos.Count );

    for i := 0 to Pagamentos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.parcela%d.numero', [i+1] ), 01, 02, 0, Pagamentos.Items[i].IdIntegradora );
      AddFieldNoXml( tcStr, '', Format( 'viagem.parcela%d.numero.cliente', [i+1] ), 01, 18, 0, Pagamentos.Items[i].IdPagamentoCliente );
    end;
  end;
end;

procedure TCIOTW_Pamcard.GerarPagamentoPedagio;
begin
  with CIOT.PagamentoPedagio do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'PayToll' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 2, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcInt, '', 'viagem.id', 01, 10, 0, IdOperacaoIntegradora );
    AddFieldNoXml( tcInt, '', 'viagem.id.cliente', 01, 18, 0, IdOperacaoCliente );
    AddFieldNoXml( tcInt, '', 'viagem.antt.ciot.numero', 01, 12, 0, CodigoIdentificacaoOperacao );
  end;
end;

procedure TCIOTW_Pamcard.GerarIncluirRota;
var
  I : Integer;
begin
  with CIOT.IncluirRota do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'InsertRoute' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 2, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcInt, '', 'viagem.rota.id.cliente', 01, 10, 0, Rota.IdCliente );
    AddFieldNoXml( tcStr, '', 'viagem.rota.nome', 01, 50, 0, Rota.Nome );

    AddFieldNoXml( tcStr, '', 'viagem.origem.pais.nome', 01, 50, 0, Rota.OrigemPaisNome );
    AddFieldNoXml( tcStr, '', 'viagem.origem.estado.nome', 01, 50, 0, Rota.OrigemEstadoNome );
    AddFieldNoXml( tcInt, '', 'viagem.origem.cidade.ibge', 01, 07, 0, Rota.OrigemCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.nome', 01, 50, 0, Rota.OrigemCidadeNome );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.latitude', 01, 10, 0, Rota.OrigemCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.longitude', 01, 10, 0, Rota.OrigemCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.cep', 01, 08, 0, OnlyNumber( Rota.OrigemCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.origem.eixo.indicador', 01, 01, 1, IfThen( Rota.OrigemEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcStr, '', 'viagem.destino.pais.nome', 01, 50, 0, Rota.DestinoPaisNome );
    AddFieldNoXml( tcStr, '', 'viagem.destino.estado.nome', 01, 50, 0, Rota.DestinoEstadoNome );
    AddFieldNoXml( tcInt, '', 'viagem.destino.cidade.ibge', 01, 07, 0, Rota.DestinoCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.nome', 01, 50, 0, Rota.DestinoCidadeNome );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.latitude', 01, 10, 0, Rota.DestinoCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.longitude', 01, 10, 0, Rota.DestinoCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.cep', 01, 08, 0, OnlyNumber( Rota.DestinoCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.destino.eixo.indicador', 01, 01, 1, IfThen( Rota.DestinoEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcInt, '', 'viagem.ponto.qtde', 01, 10, 0, Rota.Pontos.Count );

    for i := 0 to Rota.Pontos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.pais.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].PaisNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.estado.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].EstadoNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].CidadeNome );
      AddFieldNoXml( tcInt, '', Format( 'viagem.ponto%d.cidade.ibge', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].CidadeIbge );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.cep', [i+1] ), 01, 08, 0, OnlyNumber( Rota.Pontos.Items[I].CidadeCep ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.latitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[I].CidadeLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.longitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[I].CidadeLongitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.eixo.indicador', [i+1] ), 01, 01, 1, IfThen( Rota.Pontos.Items[I].EixoSuspenso, 'S', 'N' ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.rota.idavolta', 01, 01, 0, IfThen( Pedagio.IdaVolta, 'S', 'N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.caminho', 01, 1, 01, Pedagio.Caminho );
  end;
end;

procedure TCIOTW_Pamcard.GerarRoteirizar;
var
  I : Integer;
begin
  with CIOT.Roterizar do
  begin
    Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'Router' );

    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 2, 1, 1 );
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.veiculo.categoria', 01, 3, 0, VeiculoCategoria );
    AddFieldNoXml( tcStr, '', 'viagem.veiculo.categoria.eixo.suspenso', 01, 3, 1, VeiculoCategoriaEixoSuspenso );

    AddFieldNoXml( tcInt, '', 'viagem.rota.id', 01, 10, 0, Rota.Id );
    AddFieldNoXml( tcStr, '', 'viagem.rota.nome', 01, 50, 0, Rota.Nome );

    AddFieldNoXml( tcStr, '', 'viagem.origem.pais.nome', 01, 50, 0, Rota.OrigemPaisNome );
    AddFieldNoXml( tcStr, '', 'viagem.origem.estado.nome', 01, 50, 0, Rota.OrigemEstadoNome );
    AddFieldNoXml( tcInt, '', 'viagem.origem.cidade.ibge', 01, 07, 0, Rota.OrigemCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.nome', 01, 50, 0, Rota.OrigemCidadeNome );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.latitude', 01, 10, 0, Rota.OrigemCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.longitude', 01, 10, 0, Rota.OrigemCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.origem.cidade.cep', 01, 08, 0, OnlyNumber( Rota.OrigemCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.origem.eixo.indicador', 01, 01, 1, IfThen( Rota.OrigemEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcStr, '', 'viagem.destino.pais.nome', 01, 50, 0, Rota.DestinoPaisNome );
    AddFieldNoXml( tcStr, '', 'viagem.destino.estado.nome', 01, 50, 0, Rota.DestinoEstadoNome );
    AddFieldNoXml( tcInt, '', 'viagem.destino.cidade.ibge', 01, 07, 0, Rota.DestinoCidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.nome', 01, 50, 0, Rota.DestinoCidadeNome );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.latitude', 01, 10, 0, Rota.DestinoCidadeLatitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.longitude', 01, 10, 0, Rota.DestinoCidadeLongitude );
    AddFieldNoXml( tcStr, '', 'viagem.destino.cidade.cep', 01, 08, 0, OnlyNumber( Rota.DestinoCidadeCep ) );
    AddFieldNoXml( tcStr, '', 'viagem.destino.eixo.indicador', 01, 01, 1, IfThen( Rota.DestinoEixoSuspenso, 'S', 'N' ) );

    AddFieldNoXml( tcInt, '', 'viagem.ponto.qtde', 01, 10, 0, Rota.Pontos.Count );

    for i := 0 to Rota.Pontos.Count - 1 do
    begin
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.pais.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].PaisNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.estado.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].EstadoNome );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.nome', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].CidadeNome );
      AddFieldNoXml( tcInt, '', Format( 'viagem.ponto%d.cidade.ibge', [i+1] ), 01, 50, 0, Rota.Pontos.Items[I].CidadeIbge );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.cep', [i+1] ), 01, 08, 0, OnlyNumber( Rota.Pontos.Items[I].CidadeCep ) );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.latitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[I].CidadeLatitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.cidade.longitude', [i+1] ), 01, 10, 0, Rota.Pontos.Items[I].CidadeLongitude );
      AddFieldNoXml( tcStr, '', Format( 'viagem.ponto%d.eixo.indicador', [i+1] ), 01, 01, 1, IfThen( Rota.Pontos.Items[I].EixoSuspenso, 'S', 'N' ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.pedagio.obter.praca', 01, 01, 0, IfThen( Pedagio.ObterPraca, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.obter.rota', 01, 01, 0, IfThen( Pedagio.ObterRota, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.pedagio.idavolta', 01, 01, 0, IfThen( Pedagio.IdaVolta, 'S', 'N' ) );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.roteirizar.tipo', 01, 01, 0, 1 );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.solucao.id', 01, 01, 0, Pedagio.SolucaoId );
    AddFieldNoXml( tcInt, '', 'viagem.pedagio.caminho', 01, 1, 01, Pedagio.Caminho );

    AddFieldNoXml( tcStr, '', 'viagem.obter.uf', 01, 01, 1, IfThen( Rota.ObterUf, 'S', 'N' ) );
    AddFieldNoXml( tcStr, '', 'viagem.obter.posto', 01, 01, 1, IfThen( Rota.ObterPostos, 'S', 'N' ) );
  end;
end;

procedure TCIOTW_Pamcard.GerarIncluirCartaoPortadorFrete;
begin
  Gerador.wCampo( tcStr, '', 'context', 01, 99, 1, 'InsertCardFreight' );

  with CIOT.IncluirCartaoPortador do
  begin
    AddFieldNoXml( tcStr, '', 'viagem.contratante.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( MatrizCNPJ ) );

    if( OnlyCPFCNPJAlphaNum( FilialCNPJ ) <> '' )then
    begin
      AddFieldNoXml( tcInt, '', 'viagem.unidade.documento.tipo', 01, 2, 1, 1 ); // 1-CNPJ
      AddFieldNoXml( tcStr, '', 'viagem.unidade.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( FilialCNPJ ) );
    end;

    AddFieldNoXml( tcStr, '', 'viagem.cartao.numero', 01, 16, 1, Portador.InformacoesBancarias.Cartao.Numero );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.numero.controle', 01, 10, 0, Portador.InformacoesBancarias.Cartao.NumeroControle );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.documento.tipo', 01, 02, 1, IfThen( Length( OnlyCPFCNPJAlphaNum( Portador.CpfOuCnpj ) ) = 11, 2, 1 ) ); //1-CNPJ, 2-CPF
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.documento.numero', 01, 20, 1, OnlyCPFCNPJAlphaNum( Portador.CpfOuCnpj ) );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.rg', 01, 17, 1, OnlyNumber( Portador.Rg ) );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.uf.rg', 01, 02, 1, Portador.RgUf );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.rg.emissor.id', 01, 02, 0, Portador.RgEmissorId );
    AddFieldNoXml( tcDatVcto, '', 'viagem.cartao.portador.rg.emissao.data', 01, 10, 0, Portador.RgDataEmissao );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.rntrc', 01, 14, 0, OnlyNumber( Portador.RNTRC ) );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.nome', 01, 40, 1, Portador.NomeOuRazaoSocial );
    AddFieldNoXml( tcDatVcto, '', 'viagem.cartao.portador.data.nascimento', 01, 10, 0, Portador.DataNascimento );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.nacionalidade.id', 01, 01, 0, Portador.NacionalidadeId );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.naturalidade.ibge', 01, 09, 0, Portador.NaturalidadeIbge );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.sexo', 01, 01, 0, Portador.Sexo );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.logradouro', 01, 40, 1, Portador.Endereco.Rua );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.numero', 01, 05, 1, Portador.Endereco.Numero );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.complemento', 01, 15, 0, Portador.Endereco.Complemento );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.bairro', 01, 30, 1, Portador.Endereco.Bairro );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.cidade', 01, 30, 1, Portador.Endereco.xMunicipio );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.uf', 01, 02, 1, Portador.Endereco.UF );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.pais', 01, 30, 1, Portador.Endereco.xPais );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.cep', 01, 08, 1, OnlyNumber( Portador.Endereco.CEP ) );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.endereco.propriedade.tipo.id', 01, 2, 0, Portador.Endereco.PropriedadeTipoId );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.endereco.reside.desde', 01, 07, 0, Portador.Endereco.ResideDesde );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.telefone.ddd', 03, 03, 1, Portador.Telefones.Fixo.DDD );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.telefone.numero', 08, 08, 1, Portador.Telefones.Fixo.Numero );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.celular.operadora.id', 01, 02, 0, Portador.Telefones.Celular.OperadoraID );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.celular.ddd', 03, 03, 0, Portador.Telefones.Celular.DDD );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.portador.celular.numero', 09, 09, 0, Portador.Telefones.Celular.Numero );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.portador.email', 01, 40, 0, Portador.Email );
    AddFieldNoXml( tcStr, '', 'viagem.cartao.empresa.nome', 01, 50, 0, Portador.InformacoesBancarias.Cartao.EmpresaNome );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.empresa.cnpj', 01, 14, 0, OnlyCPFCNPJAlphaNum( Portador.InformacoesBancarias.Cartao.EmpresaCNPJ ) );
    AddFieldNoXml( tcInt, '', 'viagem.cartao.empresa.rntrc', 01, 08, 0, OnlyNumber( Portador.InformacoesBancarias.Cartao.EmpresaRNTRC ) );
  end;
end;

procedure TCIOTW_Pamcard.GerarFavorecido;
begin
	//sem implementação verificar remover
end;

end.
