{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Fábio Tellini                                   }
{                                                                              }
{                                                                              }
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

{******************************************************************************
|* Historico
|*
|* 29/09/2026: Fábio Tellini
|*  - Primeira Versao ACBrShoppingPrecos
|* 24/10/2026: Projeto ACBr
|*  - Integracao ao trunk: pacotes, Lazarus, encoding, datas e nomes da API
|*
|* Documentacao da API: https://apidoc.shoppingdeprecos.com.br/introducao
******************************************************************************}

{$I ACBr.inc}

unit FrmPrincipal;

interface

uses SysUtils, Classes, DateUtils, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, {$IFDEF FPC}DateTimePicker,{$ENDIF}
  ACBrShoppingPrecos, ACBrShoppingPrecosConfiguracoes, ACBrShoppingPrecosModelos,
  ACBrShoppingPrecosModelosAPI, ACBrBase, ACBrUtil.Strings;

type
  TFrmPrincipal = class(TForm)
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    lblToken: TLabel;
    edtToken: TEdit;
    lblPlataforma: TLabel;
    cbxPlataforma: TComboBox;
    lblIntegracao: TLabel;
    edtIntegracao: TEdit;
    grpConfiguracoes: TGroupBox;
    lblSKU: TLabel;
    edtSKU: TEdit;
    lblTitulo: TLabel;
    edtTitulo: TEdit;
    lblPreco: TLabel;
    edtPreco: TEdit;
    lblEstoque: TLabel;
    edtEstoque: TEdit;
    btnEnviarProduto: TButton;
    btnAtualizarEstoque: TButton;
    btnAtualizarPreco: TButton;
    btnCategorias: TButton;
    lblProdutoUso: TLabel;
    tabProdutos: TTabSheet;
    lblPedido: TLabel;
    edtPedido: TEdit;
    lblStatus: TLabel;
    cbxStatus: TComboBox;
    lblNF: TLabel;
    edtNF: TEdit;
    lblChave: TLabel;
    edtChave: TEdit;
    lblXML: TLabel;
    edtXML: TEdit;
    btnSelecionarXML: TButton;
    lblPeriodo: TLabel;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    btnBuscarFila: TButton;
    btnListarPedidos: TButton;
    btnConsultarPedido: TButton;
    btnAtualizarStatus: TButton;
    lblFilaID: TLabel;
    edtFilaID: TEdit;
    btnConfirmarFila: TButton;
    tabPedidos: TTabSheet;
    lblPedidoEtiqueta: TLabel;
    edtPedidoEtiqueta: TEdit;
    lblFormato: TLabel;
    cbxFormato: TComboBox;
    btnObterEtiqueta: TButton;
    btnSalvarEtiqueta: TButton;
    lblEtiquetasUso: TLabel;
    tabEtiquetas: TTabSheet;
    pgcOperacoes: TPageControl;
    memResposta: TMemo;
    ACBrShoppingPrecos1: TACBrShoppingPrecos;
    dlgSalvarEtiqueta: TSaveDialog;
    dlgAbrirXML: TOpenDialog;
    btnListarPlataformas: TButton;
    btnListarIntegracoes: TButton;
    btnObterIcone: TButton;
    btnSalvarIcone: TButton;
    lblCadastrosUso: TLabel;
    lblCadastrosUso2: TLabel;
    tabCadastros: TTabSheet;
    lblCategoriaAPI: TLabel;
    edtCategoriaAPI: TEdit;
    btnListarMarcas: TButton;
    btnListarAtributos: TButton;
    btnConsultarEstoques: TButton;
    btnConsultarPrecos: TButton;
    tabCatalogo: TTabSheet;
    lblProdutoInterno: TLabel;
    edtProdutoInterno: TEdit;
    lblSKUAnuncio: TLabel;
    edtSKUAnuncio: TEdit;
    lblPrecoAnuncio: TLabel;
    edtPrecoAnuncio: TEdit;
    lblEstoqueAnuncio: TLabel;
    edtEstoqueAnuncio: TEdit;
    lblMarcaAnuncio: TLabel;
    edtMarcaAnuncio: TEdit;
    lblCategoriaAnuncio: TLabel;
    edtCategoriaAnuncio: TEdit;
    lblDepartamentoAnuncio: TLabel;
    edtDepartamentoAnuncio: TEdit;
    btnPublicarProduto: TButton;
    btnEstoqueIntegracao: TButton;
    btnPrecoIntegracao: TButton;
    lblAnunciosUso: TLabel;
    tabAnuncios: TTabSheet;
    lblPedidoExtra: TLabel;
    edtPedidoExtra: TEdit;
    lblSituacaoExtra: TLabel;
    edtSituacaoExtra: TEdit;
    btnListarSituacoes: TButton;
    btnAtualizarSituacao: TButton;
    lblSKUAceite: TLabel;
    edtSKUAceite: TEdit;
    lblQuantidadeAceite: TLabel;
    edtQuantidadeAceite: TEdit;
    btnAceitarCompra: TButton;
    tabOperacoesPedido: TTabSheet;
    lblPedidosXML: TLabel;
    edtPedidosXML: TEdit;
    btnRecuperarXML: TButton;
    btnSalvarXML: TButton;
    lblXMLInicio: TLabel;
    dtpXMLInicio: TDateTimePicker;
    lblXMLFim: TLabel;
    dtpXMLFim: TDateTimePicker;
    lblRelatorioID: TLabel;
    edtRelatorioID: TEdit;
    btnSolicitarXML: TButton;
    btnConsultarXML: TButton;
    btnBaixarRelatorio: TButton;
    btnSalvarRelatorio: TButton;
    tabNotas: TTabSheet;
    cbTipoProduto: TComboBox;
    procedure btnListarPlataformasClick(Sender: TObject);
    procedure btnListarIntegracoesClick(Sender: TObject);
    procedure btnObterIconeClick(Sender: TObject);
    procedure btnSalvarIconeClick(Sender: TObject);
    procedure btnListarMarcasClick(Sender: TObject);
    procedure btnListarAtributosClick(Sender: TObject);
    procedure btnConsultarEstoquesClick(Sender: TObject);
    procedure btnConsultarPrecosClick(Sender: TObject);
    procedure btnPublicarProdutoClick(Sender: TObject);
    procedure btnEstoqueIntegracaoClick(Sender: TObject);
    procedure btnPrecoIntegracaoClick(Sender: TObject);
    procedure btnListarSituacoesClick(Sender: TObject);
    procedure btnAtualizarSituacaoClick(Sender: TObject);
    procedure btnAceitarCompraClick(Sender: TObject);
    procedure btnRecuperarXMLClick(Sender: TObject);
    procedure btnSalvarXMLClick(Sender: TObject);
    procedure btnSolicitarXMLClick(Sender: TObject);
    procedure btnConsultarXMLClick(Sender: TObject);
    procedure btnBaixarRelatorioClick(Sender: TObject);
    procedure btnSalvarRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEnviarProdutoClick(Sender: TObject);
    procedure btnAtualizarEstoqueClick(Sender: TObject);
    procedure btnAtualizarPrecoClick(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnSelecionarXMLClick(Sender: TObject);
    procedure btnBuscarFilaClick(Sender: TObject);
    procedure btnListarPedidosClick(Sender: TObject);
    procedure btnConsultarPedidoClick(Sender: TObject);
    procedure btnAtualizarStatusClick(Sender: TObject);
    procedure btnConfirmarFilaClick(Sender: TObject);
    procedure btnObterEtiquetaClick(Sender: TObject);
    procedure btnSalvarEtiquetaClick(Sender: TObject);
  private
    procedure Configurar;
    procedure PrepararPedido;
    procedure MostrarRetorno(Sucesso: Boolean);
    procedure MostrarCategorias(Lista: TSDPCategoriaLista; const Prefixo: string);
  end;

var FormPrincipal: TFrmPrincipal;

implementation

{$IfNDef FPC}
  {$R *.dfm}
{$Else}
  {$R *.lfm}
{$EndIf}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var I: Integer;
begin
  { Os controles e o componente estao no DFM. Aqui so preenchemos os valores. }
  for I := 0 to ACBrShoppingPrecos1.Configuracoes.CadastroPlataformas.Count - 1 do
    cbxPlataforma.Items.Add(IntToStr(ACBrShoppingPrecos1.Configuracoes.CadastroPlataformas[I].Codigo) +
      ' - ' + ACBrShoppingPrecos1.Configuracoes.CadastroPlataformas[I].Nome);
  dtpXMLInicio.DateTime := Date - 1;
  dtpXMLFim.DateTime := Date;
  dtpInicial.DateTime := Date - 1;
  dtpFinal.DateTime := Date;
  memResposta.Lines.Text := 'Selecione uma operacao. As operacoes de envio alteram os dados na API.';
end;

procedure TFrmPrincipal.Configurar;
begin
  ACBrShoppingPrecos1.Configuracoes.Usuario := edtUsuario.Text;
  ACBrShoppingPrecos1.Configuracoes.Senha := edtSenha.Text;
  ACBrShoppingPrecos1.Configuracoes.Token := edtToken.Text;
  ACBrShoppingPrecos1.Configuracoes.IntegracaoID := edtIntegracao.Text;
  ACBrShoppingPrecos1.Configuracoes.Plataforma := 0;

  if cbxPlataforma.ItemIndex >= 0 then
    ACBrShoppingPrecos1.Configuracoes.Plataforma := ACBrShoppingPrecos1.Configuracoes.CadastroPlataformas[cbxPlataforma.ItemIndex].Codigo;
end;

procedure TFrmPrincipal.PrepararPedido;
begin
  ACBrShoppingPrecos1.Pedido.Limpar;
  ACBrShoppingPrecos1.Pedido.PedidoID := edtPedido.Text;
end;

procedure TFrmPrincipal.MostrarRetorno(Sucesso: Boolean);
begin
  memResposta.Clear;

  if Sucesso then
    memResposta.Lines.Add('Operacao concluida')
  else
    memResposta.Lines.Add('Falha na operacao');

  memResposta.Lines.Add('HTTP: ' + IntToStr(ACBrShoppingPrecos1.Retorno.CodigoHTTP));
  memResposta.Lines.Add('Mensagem: ' + ACBrShoppingPrecos1.Retorno.Mensagem);
  memResposta.Lines.Add('Protocolo: ' + ACBrShoppingPrecos1.Retorno.Protocolo);
  memResposta.Lines.Add(ACBrShoppingPrecos1.Retorno.JSON);
end;

procedure TFrmPrincipal.btnEnviarProdutoClick(Sender: TObject);
var
  Produto: TSDPProduto;
  Imagem: TSDPImagem;
  Atributo: TSDPAtributo;
  Variacao: TSDPVariacao;
  ItemKit: TSDPItemKit;
begin
  Configurar;
  ACBrShoppingPrecos1.Produtos.Clear;
  Produto := ACBrShoppingPrecos1.Produto;
  Produto.Limpar;

  { Valores da tela tem prioridade. Somente campos vazios usam os exemplos;
    preco/estoque zero continuam sendo enviados como zero. }

  if Trim(edtSKU.Text) <> '' then
    Produto.SKU := Trim(edtSKU.Text)
  else
    Produto.SKU := 'ACBR-DEMO-001';

  if Trim(edtTitulo.Text) <> '' then
    Produto.Titulo := Trim(edtTitulo.Text)
  else
    Produto.Titulo := 'Produto demonstrativo ACBr Shopping de Precos';

  if Trim(edtPreco.Text) <> '' then
    Produto.Preco := StrToCurr(Trim(edtPreco.Text))
  else
    Produto.Preco := 49.90;

  if Trim(edtEstoque.Text) <> '' then
    Produto.Estoque := StrToInt(Trim(edtEstoque.Text))
  else
    Produto.Estoque := 10;

  { Identificacao e descricoes. Todos os dados fixos sao ficticios.
    Substitua URLs, codigos fiscais e registros pelos dados reais do produto. }
  Produto.Marca := 'Marca Demonstracao';
  Produto.Categoria := 'Produtos de demonstracao';
  Produto.Descricao := 'Produto ficticio para demonstrar todos os campos do cadastro.';
  Produto.DescricaoCurta := 'Exemplo completo de integracao com o Shopping de Precos.';
  Produto.Fabricante := 'Fabricante Demonstracao';
  Produto.Garantia := '90'; // Dias de garantia.
  Produto.Video := 'https://www.youtube.com/watch?v=VIDEO_EXEMPLO';

  { Valores monetarios e periodo de promocao.
    Os valores derivados acompanham o preco informado na tela. }
  Produto.PrecoCusto := Produto.Preco * 0.60;
  Produto.PrecoPromocao := Produto.Preco * 0.90;
  Produto.InicioPromocao := Date;
  Produto.TerminoPromocao := Date + 30;

  { Dimensoes em centimetros e pesos em quilogramas. }
  Produto.LarguraCm := 10;
  Produto.AlturaCm := 15;
  Produto.ComprimentoCm := 20;
  Produto.PesoKg := 0.50;
  Produto.LarguraEmbalagemCm := 12;
  Produto.AlturaEmbalagemCm := 17;
  Produto.ComprimentoEmbalagemCm := 22;
  Produto.PesoEmbalagemKg := 0.65;

  { Metadados para a loja. }
  Produto.MetaTag := 'demonstracao, acbr, shopping de precos';
  Produto.MetaTitle := 'Produto demonstrativo ACBr';
  Produto.MetaDescription := 'Cadastro ficticio com os campos disponiveis no componente.';

  { Codigos demonstrativos: nao representam a classificacao de um produto real. }
  Produto.CEST := '0000000';
  Produto.Origem := 0;
  Produto.UnidadeMedida := 'UN';
  Produto.CSOSN := '102';
  Produto.NCM := '00000000';
  Produto.EAN := '7890000000017';
  Produto.CodigoAnvisa := 'REGISTRO-ANVISA-EXEMPLO';
  Produto.CodigoInmetro := 'REGISTRO-INMETRO-EXEMPLO';
  Produto.CodigoMapa := 'REGISTRO-MAPA-EXEMPLO';
  Produto.Kit := cbTipoProduto.ItemIndex = 2;

  { Imagens do produto. URL deve apontar para uma imagem hospedada.
    Os enderecos example.invalid sao apenas marcadores demonstrativos. }
  Imagem := Produto.Imagens.Add;
  Imagem.URL := 'https://example.invalid/produtos/frente.jpg';
  Imagem.Etiqueta := 'Imagem principal';
  Imagem := Produto.Imagens.Add;
  Imagem.URL := 'https://example.invalid/produtos/verso.jpg';
  Imagem.Etiqueta := 'Vista traseira';

  { Atributos gerais; os atributos especificos de cada variacao ficam nela. }
  Atributo := Produto.Atributos.Add;
  Atributo.Tipo := 'Material';
  Atributo.Valor := 'Material demonstrativo';
  Atributo := Produto.Atributos.Add;
  Atributo.Tipo := 'Linha';
  Atributo.Valor := 'Demonstracao';

  if cbTipoProduto.ItemIndex = 1 then
  begin
    { Todos os campos disponiveis em uma variacao. }
    Variacao := Produto.Variacoes.Add;
    Variacao.SKU := Produto.SKU + '-AZUL';
    Variacao.EAN := '7890000000024';
    Variacao.Preco := Produto.Preco;
    Variacao.PrecoCusto := Produto.PrecoCusto;
    Variacao.Estoque := Produto.Estoque;
    Variacao.LarguraCm := 10;
    Variacao.AlturaCm := 15;
    Variacao.ComprimentoCm := 20;
    Variacao.PesoKg := 0.50;

    Imagem := Variacao.Imagens.Add;
    Imagem.URL := 'https://example.invalid/produtos/azul.jpg';
    Imagem.Etiqueta := 'Variacao azul';
    Atributo := Variacao.Atributos.Add;
    Atributo.Tipo := 'Cor';
    Atributo.Valor := 'Azul';

    { Uma segunda variacao ilustra a repeticao dos itens no array JSON. }
    Variacao := Produto.Variacoes.Add;
    Variacao.SKU := Produto.SKU + '-VERMELHO';
    Variacao.EAN := '7890000000031';
    Variacao.Preco := Produto.Preco;
    Variacao.PrecoCusto := Produto.PrecoCusto;
    Variacao.Estoque := Produto.Estoque;
    Variacao.LarguraCm := 10;
    Variacao.AlturaCm := 15;
    Variacao.ComprimentoCm := 20;
    Variacao.PesoKg := 0.50;

    Imagem := Variacao.Imagens.Add;
    Imagem.URL := 'https://example.invalid/produtos/vermelho.jpg';
    Imagem.Etiqueta := 'Variacao vermelha';
    Atributo := Variacao.Atributos.Add;
    Atributo.Tipo := 'Cor';
    Atributo.Valor := 'Vermelho';
  end;

  if cbTipoProduto.ItemIndex = 2 then
  begin
    { Troque os SKUs abaixo pelos componentes ja cadastrados no Shopping.
      Os percentuais do valor do kit devem totalizar 100%. }
    ItemKit := Produto.ItensKit.Add;
    ItemKit.SKU := 'ACBR-COMPONENTE-001';
    ItemKit.Quantidade := 2;
    ItemKit.PercentualValor := 60;
    ItemKit := Produto.ItensKit.Add;
    ItemKit.SKU := 'ACBR-COMPONENTE-002';
    ItemKit.Quantidade := 1;
    ItemKit.PercentualValor := 40;
  end;

  { O componente monta o JSON a partir das propriedades acima.
    Produto.GerarJSON permite inspecionar esse JSON antes do envio.
    Para omitir um campo use Omitir('nomeJSON'); para enviar null,
    DefinirNulo('nomeJSON'). Esses metodos nao equivalem a informar zero. }
  MostrarRetorno(ACBrShoppingPrecos1.EnviarProdutos);
end;

procedure TFrmPrincipal.btnAtualizarEstoqueClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.Produtos.Clear;
  ACBrShoppingPrecos1.Produto.Limpar;
  ACBrShoppingPrecos1.Produto.SKU     := edtSKU.Text;
  ACBrShoppingPrecos1.Produto.Estoque := StrToInt(edtEstoque.Text);
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarEstoque);
end;

procedure TFrmPrincipal.btnAtualizarPrecoClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.Produtos.Clear;
  ACBrShoppingPrecos1.Produto.Limpar;
  ACBrShoppingPrecos1.Produto.SKU   := edtSKU.Text;
  ACBrShoppingPrecos1.Produto.Preco := StrToCurr(edtPreco.Text);
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarPreco);
end;

procedure TFrmPrincipal.MostrarCategorias(Lista: TSDPCategoriaLista; const Prefixo: string);
var I: Integer;
begin
  for I := 0 to Lista.Count - 1 do
  begin
    memResposta.Lines.Add(Prefixo + Lista[I].ID + ' - ' + Lista[I].Nome);
    MostrarCategorias(Lista[I].Filhos, Prefixo + '  ');
  end;
end;

procedure TFrmPrincipal.btnCategoriasClick(Sender: TObject);
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ListarCategorias);
  MostrarCategorias(ACBrShoppingPrecos1.Categorias, '');
end;

procedure TFrmPrincipal.btnBuscarFilaClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.BuscarFilaPedidos);
  for I := 0 to ACBrShoppingPrecos1.FilaPedidos.Count - 1 do
    memResposta.Lines.Add('FilaID: ' + ACBrShoppingPrecos1.FilaPedidos[I].FilaID +
      ' | Pedido: ' + ACBrShoppingPrecos1.FilaPedidos[I].PedidoID +
      ' | Integracao: ' + ACBrShoppingPrecos1.FilaPedidos[I].IntegracaoID);
end;

procedure TFrmPrincipal.btnListarPedidosClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  ACBrShoppingPrecos1.FiltroPedidos.DataInicial := Trunc(dtpInicial.DateTime);
  { A API aceita no maximo 3 dias; inclui o dia final inteiro dentro desse limite }
  ACBrShoppingPrecos1.FiltroPedidos.DataFinal := EndOfTheDay(dtpFinal.DateTime);

  if ACBrShoppingPrecos1.FiltroPedidos.DataFinal - ACBrShoppingPrecos1.FiltroPedidos.DataInicial > 3 then
    ACBrShoppingPrecos1.FiltroPedidos.DataFinal := ACBrShoppingPrecos1.FiltroPedidos.DataInicial + 3;
  MostrarRetorno(ACBrShoppingPrecos1.ListarPedidos);
  for I := 0 to ACBrShoppingPrecos1.Pedidos.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.Pedidos[I].PedidoID + ' | ' +
      ACBrShoppingPrecos1.Pedidos[I].Status);
end;

procedure TFrmPrincipal.btnConsultarPedidoClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  PrepararPedido;
  MostrarRetorno(ACBrShoppingPrecos1.ConsultarPedido);

  if not ACBrShoppingPrecos1.Retorno.Sucesso then
    Exit;
  memResposta.Lines.Add('Comprador: ' + ACBrShoppingPrecos1.Pedido.Comprador.Nome);
  memResposta.Lines.Add('Total: ' + CurrToStr(ACBrShoppingPrecos1.Pedido.TotalPedido));
  for I := 0 to ACBrShoppingPrecos1.Pedido.Produtos.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.Pedido.Produtos[I].SKU + ' | ' +
      ACBrShoppingPrecos1.Pedido.Produtos[I].Descricao);
end;

procedure TFrmPrincipal.btnSelecionarXMLClick(Sender: TObject);
begin

  if dlgAbrirXML.Execute then
    edtXML.Text := dlgAbrirXML.FileName;
end;

procedure TFrmPrincipal.btnAtualizarStatusClick(Sender: TObject);
var
  Arquivo: TFileStream;
begin
  Configurar;
  PrepararPedido;
  ACBrShoppingPrecos1.AtualizacaoStatus.Limpar;
  ACBrShoppingPrecos1.AtualizacaoStatus.Status := cbxStatus.Text;

  if edtNF.Text <> '' then
    ACBrShoppingPrecos1.AtualizacaoStatus.NF := edtNF.Text;

  if edtChave.Text <> '' then
    ACBrShoppingPrecos1.AtualizacaoStatus.ChaveNFe := edtChave.Text;

  if edtXML.Text <> '' then
  begin
    Arquivo := TFileStream.Create(edtXML.Text, fmOpenRead or fmShareDenyWrite);
    try
      { Envia os bytes do arquivo assinado, sem conversao de codificacao }
      ACBrShoppingPrecos1.AtualizacaoStatus.CarregarXMLNFe(Arquivo);
    finally
      Arquivo.Free;
    end;
  end;
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarStatus);
end;

procedure TFrmPrincipal.btnConfirmarFilaClick(Sender: TObject);
begin
  { Confirme somente depois de salvar o pedido no ERP. }
  Configurar;
  ACBrShoppingPrecos1.FilaIDsImportados.Clear;
  ACBrShoppingPrecos1.FilaIDsImportados.Add(edtFilaID.Text);
  MostrarRetorno(ACBrShoppingPrecos1.ConfirmarImportacaoPedidos);
end;

procedure TFrmPrincipal.btnObterEtiquetaClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  ACBrShoppingPrecos1.Pedido.Limpar;
  ACBrShoppingPrecos1.Pedido.PedidoID := edtPedidoEtiqueta.Text;
  ACBrShoppingPrecos1.PedidosEtiquetas.Clear;
  ACBrShoppingPrecos1.FormatoEtiqueta := StrToFormatoEtiqueta(cbxFormato.Text);
  MostrarRetorno(ACBrShoppingPrecos1.ObterEtiquetas);
  for I := 0 to ACBrShoppingPrecos1.Etiquetas.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.Etiquetas[I].PedidoID + ' | ' +
      ACBrShoppingPrecos1.Etiquetas[I].Tipo + ' | ' +
      ACBrShoppingPrecos1.Etiquetas[I].Conteudo);
end;

procedure TFrmPrincipal.btnSalvarEtiquetaClick(Sender: TObject);
begin

  if ACBrShoppingPrecos1.ArquivoEtiqueta.Size = 0 then
  begin
    ShowMessage('Obtenha uma etiqueta do Mercado Livre antes de salvar. Nos demais marketplaces, consulte a URL/ZPL do retorno.');
    Exit;
  end;

  if ACBrShoppingPrecos1.Etiquetas[0].Tipo = 'pdf' then
  begin
    dlgSalvarEtiqueta.Filter := 'Arquivo PDF|*.pdf';
    dlgSalvarEtiqueta.DefaultExt := 'pdf';
  end
  else
  begin
    dlgSalvarEtiqueta.Filter := 'Arquivo ZIP (PLP e ZPL)|*.zip';
    dlgSalvarEtiqueta.DefaultExt := 'zip';
  end;

  if dlgSalvarEtiqueta.Execute then
    ACBrShoppingPrecos1.ArquivoEtiqueta.SaveToFile(dlgSalvarEtiqueta.FileName);
end;


procedure TFrmPrincipal.btnListarPlataformasClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ListarPlataformas);
  for I := 0 to ACBrShoppingPrecos1.Plataformas.Count - 1 do
    memResposta.Lines.Add(IntToStr(ACBrShoppingPrecos1.Plataformas[I].ID) + ' | ' +
      ACBrShoppingPrecos1.Plataformas[I].Titulo + ' | ' + ACBrShoppingPrecos1.Plataformas[I].Icone);
end;

procedure TFrmPrincipal.btnListarIntegracoesClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ListarIntegracoes);
  for I := 0 to ACBrShoppingPrecos1.Integracoes.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.Integracoes[I].IntegracaoID + ' | ' +
      ACBrShoppingPrecos1.Integracoes[I].DescricaoPlataforma + ' | ' +
      ACBrShoppingPrecos1.Integracoes[I].Plataforma);
end;

procedure TFrmPrincipal.btnObterIconeClick(Sender: TObject);
begin
  Configurar;
  { Primeiro liste as plataformas para obter a URL do icone. }
  MostrarRetorno(ACBrShoppingPrecos1.ObterIconePlataforma);
end;

procedure TFrmPrincipal.btnSalvarIconeClick(Sender: TObject);
begin

  if ACBrShoppingPrecos1.ArquivoIcone.Size = 0 then
    Exit;

  dlgSalvarEtiqueta.Filter := 'Imagem|*.*';
  dlgSalvarEtiqueta.DefaultExt := '';

  if dlgSalvarEtiqueta.Execute then
    ACBrShoppingPrecos1.ArquivoIcone.SaveToFile(dlgSalvarEtiqueta.FileName);
end;

procedure TFrmPrincipal.btnListarMarcasClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ListarMarcas);
  for I := 0 to ACBrShoppingPrecos1.Marcas.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.Marcas[I].ID + ' | ' + ACBrShoppingPrecos1.Marcas[I].Nome);
end;

procedure TFrmPrincipal.btnListarAtributosClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  ACBrShoppingPrecos1.CategoriaID := edtCategoriaAPI.Text;
  MostrarRetorno(ACBrShoppingPrecos1.ListarAtributos);
  for I := 0 to ACBrShoppingPrecos1.AtributosPlataforma.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.AtributosPlataforma[I].ID + ' | ' + ACBrShoppingPrecos1.AtributosPlataforma[I].Nome);
end;

procedure TFrmPrincipal.btnConsultarEstoquesClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ConsultarEstoquesIntegracao);
  for I := 0 to ACBrShoppingPrecos1.EstoquesIntegracao.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.EstoquesIntegracao[I].SKU + ' | ' +
      IntToStr(ACBrShoppingPrecos1.EstoquesIntegracao[I].Estoque));
end;

procedure TFrmPrincipal.btnConsultarPrecosClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ConsultarPrecosIntegracao);
  for I := 0 to ACBrShoppingPrecos1.PrecosIntegracao.Count - 1 do
    memResposta.Lines.Add(ACBrShoppingPrecos1.PrecosIntegracao[I].SKU + ' | ' +
      CurrToStr(ACBrShoppingPrecos1.PrecosIntegracao[I].Preco));
end;

procedure TFrmPrincipal.btnPublicarProdutoClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.ProdutoPlataforma.Limpar;
  ACBrShoppingPrecos1.ProdutoPlataforma.ProdutoID := edtProdutoInterno.Text;
  ACBrShoppingPrecos1.ProdutoPlataforma.SKU := edtSKUAnuncio.Text;
  ACBrShoppingPrecos1.ProdutoPlataforma.Preco := StrToCurr(edtPrecoAnuncio.Text);
  ACBrShoppingPrecos1.ProdutoPlataforma.Estoque := StrToInt(edtEstoqueAnuncio.Text);

  if edtMarcaAnuncio.Text <> '' then
    ACBrShoppingPrecos1.ProdutoPlataforma.MarcaID := edtMarcaAnuncio.Text;

  if edtCategoriaAnuncio.Text <> '' then
    ACBrShoppingPrecos1.ProdutoPlataforma.CategoriaID := edtCategoriaAnuncio.Text;

  if edtDepartamentoAnuncio.Text <> '' then
    ACBrShoppingPrecos1.ProdutoPlataforma.DepartamentoID := edtDepartamentoAnuncio.Text;

  { Categorias.Add, Atributos.Add e Variacoes.Add preenchem os dados opcionais. }
  MostrarRetorno(ACBrShoppingPrecos1.EnviarProdutoPlataforma);
end;

procedure TFrmPrincipal.btnEstoqueIntegracaoClick(Sender: TObject);
var Item: TSDPEstoqueAnuncio;
begin
  Configurar;
  ACBrShoppingPrecos1.EstoquesAnuncios.Clear;
  Item := ACBrShoppingPrecos1.EstoquesAnuncios.Add;
  Item.ProdutoID := edtProdutoInterno.Text;
  Item.SKU := edtSKUAnuncio.Text;
  Item.Estoque := StrToInt(edtEstoqueAnuncio.Text);
  { Para lote, adicione mais itens antes da chamada. }
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarEstoqueIntegracao);
end;

procedure TFrmPrincipal.btnPrecoIntegracaoClick(Sender: TObject);
var Item: TSDPPrecoAnuncio;
begin
  Configurar;
  ACBrShoppingPrecos1.PrecosAnuncios.Clear;
  Item := ACBrShoppingPrecos1.PrecosAnuncios.Add;
  Item.ProdutoID := edtProdutoInterno.Text;
  Item.SKU := edtSKUAnuncio.Text;
  Item.Preco := StrToCurr(edtPrecoAnuncio.Text);
  { Para lote, adicione mais itens antes da chamada. }
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarPrecosIntegracao);
end;

procedure TFrmPrincipal.btnListarSituacoesClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  MostrarRetorno(ACBrShoppingPrecos1.ListarSituacoesPersonalizadas);
  for I := 0 to ACBrShoppingPrecos1.SituacoesPersonalizadas.Count - 1 do
    memResposta.Lines.Add(IntToStr(ACBrShoppingPrecos1.SituacoesPersonalizadas[I].ID) + ' | ' +
      ACBrShoppingPrecos1.SituacoesPersonalizadas[I].Situacao);
end;

procedure TFrmPrincipal.btnAtualizarSituacaoClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.Pedido.Limpar;
  ACBrShoppingPrecos1.Pedido.PedidoID := edtPedidoExtra.Text;
  ACBrShoppingPrecos1.Pedido.SituacaoPersonalizadaID := StrToInt(edtSituacaoExtra.Text);
  MostrarRetorno(ACBrShoppingPrecos1.AtualizarSituacaoPersonalizada);
end;

procedure TFrmPrincipal.btnAceitarCompraClick(Sender: TObject);
var Item: TSDPAceiteItem;
begin
  Configurar;
  ACBrShoppingPrecos1.Pedido.Limpar;
  ACBrShoppingPrecos1.Pedido.PedidoID := edtPedidoExtra.Text;
  ACBrShoppingPrecos1.ItensAceite.Clear;
  Item := ACBrShoppingPrecos1.ItensAceite.Add;
  Item.SKU := edtSKUAceite.Text;
  Item.QuantidadeAceita := StrToInt(edtQuantidadeAceite.Text);
  MostrarRetorno(ACBrShoppingPrecos1.AceitarPedidoCompra);
end;

procedure TFrmPrincipal.btnRecuperarXMLClick(Sender: TObject);
var I: Integer;
begin
  Configurar;
  ACBrShoppingPrecos1.Pedido.Limpar;
  ACBrShoppingPrecos1.PedidosXML.CommaText := edtPedidosXML.Text;
  MostrarRetorno(ACBrShoppingPrecos1.RecuperarXMLPedidos);
  for I := 0 to ACBrShoppingPrecos1.NotasPedidos.Count - 1 do
    memResposta.Lines.Add('Pedido: ' + ACBrShoppingPrecos1.NotasPedidos[I].PedidoID +
      ' | Outras NFs: ' + IntToStr(ACBrShoppingPrecos1.NotasPedidos[I].OutrasNFs.Count));
end;

procedure TFrmPrincipal.btnSalvarXMLClick(Sender: TObject);
var XML: TMemoryStream;
begin

  if ACBrShoppingPrecos1.NotasPedidos.Count = 0 then
    Exit;

  if not ACBrShoppingPrecos1.NotasPedidos[0].Sucesso then
    Exit;

  dlgSalvarEtiqueta.Filter := 'Arquivo XML|*.xml';
  dlgSalvarEtiqueta.DefaultExt := 'xml';

  if dlgSalvarEtiqueta.Execute then
  begin
    XML := TMemoryStream.Create;
    try
      ACBrShoppingPrecos1.NotasPedidos[0].SalvarXML(XML);
      XML.SaveToFile(dlgSalvarEtiqueta.FileName);
    finally
      XML.Free;
    end;
  end;
end;

procedure TFrmPrincipal.btnSolicitarXMLClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.FiltroXML.DataInicial := Trunc(dtpXMLInicio.DateTime);
  ACBrShoppingPrecos1.FiltroXML.DataFinal := Trunc(dtpXMLFim.DateTime);
  MostrarRetorno(ACBrShoppingPrecos1.SolicitarXMLNotas);
  edtRelatorioID.Text := ACBrShoppingPrecos1.RelatorioXML.ID;
end;

procedure TFrmPrincipal.btnConsultarXMLClick(Sender: TObject);
begin
  Configurar;
  ACBrShoppingPrecos1.RelatorioXML.ID := edtRelatorioID.Text;
  MostrarRetorno(ACBrShoppingPrecos1.ConsultarSolicitacaoXML);
  memResposta.Lines.Add(ACBrShoppingPrecos1.RelatorioXML.Status);
  memResposta.Lines.Add(ACBrShoppingPrecos1.RelatorioXML.URLArquivo);
end;

procedure TFrmPrincipal.btnBaixarRelatorioClick(Sender: TObject);
begin
  MostrarRetorno(ACBrShoppingPrecos1.BaixarRelatorioXML);
end;

procedure TFrmPrincipal.btnSalvarRelatorioClick(Sender: TObject);
begin

  if ACBrShoppingPrecos1.ArquivoRelatorioXML.Size = 0 then
    Exit;

  dlgSalvarEtiqueta.Filter := 'Todos os arquivos|*.*';
  dlgSalvarEtiqueta.DefaultExt := '';

  if dlgSalvarEtiqueta.Execute then
    ACBrShoppingPrecos1.ArquivoRelatorioXML.SaveToFile(dlgSalvarEtiqueta.FileName);
end;

end.
