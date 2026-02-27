using System;
using ACBrLib.Core;
using ACBrLib.Core.ETQ;

namespace ACBrLib.ETQ
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrETQ.
    /// <para>
    /// Permite controle de etiquetadoras e impressão de etiquetas (código de barras, texto, imagens, QR Code, etc.),
    /// conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Documentação oficial dos métodos ETQ:
    /// <see href="https://acbr.sourceforge.io/ACBrLib/MetodosETQ.html">Métodos ETQ - ACBrLib</see>
    /// </para>
    /// </summary>
    public interface IACBrLibETQ : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Obtém as configurações da biblioteca ACBrETQ.
        /// </summary>
        ACBrETQConfig Config { get; }

        /// <summary>
        /// Ativa a etiquetadora para impressão.
        /// </summary>
        void Ativar();

        /// <summary>
        /// Desativa a etiquetadora.
        /// </summary>
        void Desativar();

        /// <summary>
        /// Inicia o modo de edição de etiqueta (bloco de impressão).
        /// </summary>
        void IniciarEtiqueta();

        /// <summary>
        /// Finaliza a etiqueta em edição e imprime.
        /// </summary>
        /// <param name="aCopias">Número de cópias a imprimir.</param>
        /// <param name="aAvancoEtq">Avanço entre etiquetas (em unidades configuradas).</param>
        void FinalizarEtiqueta(int aCopias = 1, int aAvancoEtq = 0);

        /// <summary>
        /// Carrega uma imagem do disco para uso na etiqueta.
        /// </summary>
        /// <param name="eArquivoImagem">Caminho do arquivo de imagem (BMP, PCX, etc.).</param>
        /// <param name="eNomeImagem">Nome identificador para referência ao imprimir.</param>
        /// <param name="flipped">Se <c>true</c>, a imagem é espelhada ao carregar.</param>
        void CarregarImagem(string eArquivoImagem, string eNomeImagem, bool flipped = true);

        /// <summary>
        /// Imprime o conteúdo atual da etiqueta (após comandos de texto, barras, imagem, etc.).
        /// </summary>
        /// <param name="aCopias">Número de cópias a imprimir.</param>
        /// <param name="aAvancoEtq">Avanço entre etiquetas.</param>
        void Imprimir(int aCopias = 1, int aAvancoEtq = 0);

        /// <summary>
        /// Imprime texto na etiqueta usando fonte identificada por número.
        /// </summary>
        /// <param name="orientacao">Orientação do texto (normal, 90°, 180°, 270°).</param>
        /// <param name="fonte">Número da fonte (modelo dependente).</param>
        /// <param name="multiplicadorH">Multiplicador horizontal do tamanho.</param>
        /// <param name="multiplicadorV">Multiplicador vertical do tamanho.</param>
        /// <param name="vertical">Posição vertical (unidade configurada).</param>
        /// <param name="horizontal">Posição horizontal (unidade configurada).</param>
        /// <param name="eTexto">Texto a imprimir.</param>
        /// <param name="subFonte">Subfonte (0 = padrão).</param>
        /// <param name="imprimirReverso">Se <c>true</c>, imprime em modo reverso (negativo).</param>
        void ImprimirTexto(ETQOrientacao orientacao, int fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte = 0, bool imprimirReverso = false);

        /// <summary>
        /// Imprime texto na etiqueta usando fonte identificada por nome/caractere.
        /// </summary>
        /// <param name="orientacao">Orientação do texto.</param>
        /// <param name="fonte">Nome ou caractere da fonte (ex: "T", "S", "G").</param>
        /// <param name="multiplicadorH">Multiplicador horizontal.</param>
        /// <param name="multiplicadorV">Multiplicador vertical.</param>
        /// <param name="vertical">Posição vertical.</param>
        /// <param name="horizontal">Posição horizontal.</param>
        /// <param name="eTexto">Texto a imprimir.</param>
        /// <param name="subFonte">Subfonte (0 = padrão).</param>
        /// <param name="imprimirReverso">Se <c>true</c>, imprime em modo reverso.</param>
        void ImprimirTexto(ETQOrientacao orientacao, string fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte = 0, bool imprimirReverso = false);

        /// <summary>
        /// Imprime código de barras na etiqueta (EAN-13, Code128, etc.).
        /// </summary>
        /// <param name="orientacao">Orientação do código de barras.</param>
        /// <param name="tipoBarras">Tipo do código (EAN13, Code128, etc.).</param>
        /// <param name="larguraBarraLarga">Largura da barra larga.</param>
        /// <param name="larguraBarraFina">Largura da barra fina.</param>
        /// <param name="vertical">Posição vertical.</param>
        /// <param name="horizontal">Posição horizontal.</param>
        /// <param name="eTexto">Conteúdo do código (dígitos/conteúdo conforme o tipo).</param>
        /// <param name="alturaCodBarras">Altura do código em pontos (0 = padrão).</param>
        /// <param name="exibeCodigo">Se e como exibir o texto abaixo das barras.</param>
        void ImprimirBarras(ETQOrientacao orientacao, TipoCodBarra tipoBarras, int larguraBarraLarga, int larguraBarraFina,
            int vertical, int horizontal, string eTexto, int alturaCodBarras = 0,
            ETQBarraExibeCodigo exibeCodigo = ETQBarraExibeCodigo.becPadrao);

        /// <summary>
        /// Imprime uma linha na etiqueta (retângulo com uma dimensão reduzida).
        /// </summary>
        /// <param name="vertical">Posição vertical do início.</param>
        /// <param name="horizontal">Posição horizontal do início.</param>
        /// <param name="largura">Largura da linha.</param>
        /// <param name="altura">Altura/espessura da linha.</param>
        void ImprimirLinha(int vertical, int horizontal, int largura, int altura);

        /// <summary>
        /// Imprime uma caixa (retângulo) na etiqueta com bordas configuráveis.
        /// </summary>
        /// <param name="vertical">Posição vertical do canto superior esquerdo.</param>
        /// <param name="horizontal">Posição horizontal do canto superior esquerdo.</param>
        /// <param name="largura">Largura da caixa.</param>
        /// <param name="altura">Altura da caixa.</param>
        /// <param name="espessuraVertical">Espessura das bordas verticais.</param>
        /// <param name="espessuraHorizontal">Espessura das bordas horizontais.</param>
        void ImprimirCaixa(int vertical, int horizontal, int largura, int altura, int espessuraVertical,
            int espessuraHorizontal);

        /// <summary>
        /// Imprime na etiqueta uma imagem previamente carregada com <see cref="CarregarImagem"/>.
        /// </summary>
        /// <param name="multiplicadorImagem">Fator de escala da imagem (1 = tamanho original).</param>
        /// <param name="vertical">Posição vertical.</param>
        /// <param name="horizontal">Posição horizontal.</param>
        /// <param name="eNomeImagem">Nome identificador informado em <see cref="CarregarImagem"/>.</param>
        void ImprimirImagem(int multiplicadorImagem, int vertical, int horizontal, string eNomeImagem);

        /// <summary>
        /// Imprime um QR Code na etiqueta.
        /// </summary>
        /// <param name="vertical">Posição vertical do QR Code.</param>
        /// <param name="horizontal">Posição horizontal do QR Code.</param>
        /// <param name="texto">Conteúdo a ser codificado (URL, texto, etc.).</param>
        /// <param name="larguraModulo">Tamanho do módulo (célula) em pontos.</param>
        /// <param name="errorLevel">Nível de correção de erro (0 a 3).</param>
        /// <param name="tipo">Tipo/versão do QR Code (modelo dependente).</param>
        void ImprimirQRCode(int vertical, int horizontal, string texto, int larguraModulo, int errorLevel, int tipo);
    }
}
