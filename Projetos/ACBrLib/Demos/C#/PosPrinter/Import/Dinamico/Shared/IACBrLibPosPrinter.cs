using ACBrLib.Core;
using ACBrLib.Core.PosPrinter;
using System;

namespace ACBrLib.PosPrinter
{

    /// <summary>
    /// Interface de alto nível para integração com impressoras POS via ACBrLib.
    /// Define métodos para controle, impressão, leitura de informações e operações específicas de impressoras POS.
    /// </summary>
    public interface IACBrLibPosPrinter : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da impressora POS.
        /// </summary>
        PosPrinterConfig Config { get; }


          /// <summary>
          /// Prepara o buffer para impressão.
          /// Equivalente ao método POS_InicializarPos.
          /// </summary>
          void InicializarPos();

          /// <summary>
          /// Ativa o componente ACBrPosPrinter.
          /// Equivalente ao método POS_Ativar.
          /// </summary>
          void Ativar();

          /// <summary>
          /// Desativa o componente ACBrPosPrinter.
          /// Equivalente ao método POS_Desativar.
          /// </summary>
          void Desativar();

          /// <summary>
          /// Zera o buffer de impressão.
          /// Equivalente ao método POS_Zerar.
          /// </summary>
          void Zerar();

          /// <summary>
          /// Reseta o estado da impressora.
          /// Equivalente ao método POS_Reset.
          /// </summary>
          void Reset();

          /// <summary>
          /// Pula linhas de impressão.
          /// Equivalente ao método POS_PularLinhas.
          /// </summary>
          /// <param name="numLinhas">Número de linhas para pular.</param>
          void PularLinhas(int numLinhas = 0);

          /// <summary>
          /// Corta o papel da impressora, se houver guilhotina.
          /// Equivalente ao método POS_CortarPapel.
          /// </summary>
          /// <param name="parcial">Indica se o corte deve ser parcial.</param>
          void CortarPapel(bool parcial = false);

          /// <summary>
          /// Abre a gaveta de dinheiro conectada à impressora.
          /// Equivalente ao método POS_AbrirGaveta.
          /// </summary>
          void AbrirGaveta();

          /// <summary>
          /// Lê informações da impressora.
          /// Equivalente ao método POS_LerInfoImpressora.
          /// </summary>
          /// <returns>Informações da impressora.</returns>
          string LerInfoImpressora();

          /// <summary>
          /// Lê o status da impressora.
          /// </summary>
          /// <param name="tentativas">Número de tentativas de leitura.</param>
          /// <returns>Status da impressora.</returns>
          ACBrPosTipoStatus LerStatusImpressora(int tentativas = 1);

          /// <summary>
          /// Retorna as tags disponíveis para a impressora.
          /// Equivalente ao método POS_RetornarTags.
          /// </summary>
          /// <param name="incluiAjuda">Inclui textos de ajuda nas tags.</param>
          /// <returns>Lista de tags.</returns>
          string[] RetornarTags(bool incluiAjuda = true);

          /// <summary>
          /// Retorna as portas disponíveis para comunicação.
          /// </summary>
          /// <returns>Lista de portas.</returns>
          string[] AcharPortas();

          /// <summary>
          /// Grava logo na impressora a partir de arquivo.
          /// </summary>
          /// <param name="aPath">Caminho do arquivo.</param>
          /// <param name="nAKC1">Código AKC1.</param>
          /// <param name="nAKC2">Código AKC2.</param>
          void GravarLogoArquivo(string aPath, int nAKC1, int nAKC2);

          /// <summary>
          /// Apaga logo da impressora.
          /// </summary>
          /// <param name="nAKC1">Código AKC1.</param>
          /// <param name="nAKC2">Código AKC2.</param>
          void ApagarLogo(int nAKC1, int nAKC2);

          /// <summary>
          /// Realiza leitura de cheque.
          /// </summary>
          /// <returns>Dados do cheque.</returns>
          string LeituraCheque();

          /// <summary>
          /// Lê código CMC7 do cheque.
          /// </summary>
          /// <param name="AguardaCheque">Indica se aguarda inserção do cheque.</param>
          /// <param name="SegundosEspera">Tempo de espera em segundos.</param>
          /// <returns>CMC7 lido.</returns>
          string LerCMC7(bool AguardaCheque, int SegundosEspera);

          /// <summary>
          /// Ejeta o cheque da impressora.
          /// </summary>
          void EjetarCheque();

          /// <summary>
          /// Indica se é possível ler da porta.
          /// </summary>
          /// <returns>True se pode ler da porta.</returns>
          bool PodeLerDaPorta();

          /// <summary>
          /// Lê características da impressora.
          /// </summary>
          /// <returns>Características.</returns>
          string LerCaracteristicas();

          /// <summary>
          /// Imprime texto na impressora.
          /// </summary>
          /// <param name="aString">Texto a imprimir.</param>
          /// <param name="pulaLinha">Indica se deve pular linha após imprimir.</param>
          /// <param name="decodificarTags">Indica se deve decodificar tags.</param>
          /// <param name="codificarPagina">Indica se deve codificar página.</param>
          /// <param name="copias">Número de cópias.</param>
          void Imprimir(string aString = "", bool pulaLinha = false, bool decodificarTags = true, bool codificarPagina = true, int copias = 1);

          /// <summary>
          /// Imprime uma linha de texto.
          /// </summary>
          /// <param name="aString">Texto da linha.</param>
          void ImprimirLinha(string aString);

          /// <summary>
          /// Imprime comando direto na impressora.
          /// </summary>
          /// <param name="aString">Comando a imprimir.</param>
          void ImprimirCmd(string aString);

          /// <summary>
          /// Imprime tags na impressora.
          /// </summary>
          void ImprimirTags();

          /// <summary>
          /// Imprime imagem a partir de arquivo.
          /// </summary>
          /// <param name="aPath">Caminho do arquivo.</param>
          void ImprimirImagemArquivo(string aPath);

          /// <summary>
          /// Imprime logo armazenado na impressora.
          /// </summary>
          /// <param name="nAKC1">Código AKC1.</param>
          /// <param name="nAKC2">Código AKC2.</param>
          /// <param name="nFatorX">Fator X.</param>
          /// <param name="nFatorY">Fator Y.</param>
          void ImprimirLogo(int nAKC1, int nAKC2, int nFatorX, int nFatorY);

          /// <summary>
          /// Imprime cheque com dados informados.
          /// </summary>
          /// <param name="CodBanco">Código do banco.</param>
          /// <param name="AValor">Valor do cheque.</param>
          /// <param name="ADataEmissao">Data de emissão.</param>
          /// <param name="AFavorecido">Favorecido.</param>
          /// <param name="ACidade">Cidade.</param>
          /// <param name="AComplemento">Complemento.</param>
          /// <param name="LerCMC7">Indica se deve ler CMC7.</param>
          /// <param name="SegundosEspera">Tempo de espera.</param>
          void ImprimirCheque(int CodBanco, decimal AValor, DateTime ADataEmissao, string AFavorecido,
              string ACidade, string AComplemento, bool LerCMC7, int SegundosEspera);

          /// <summary>
          /// Imprime texto no cheque em coordenadas específicas.
          /// </summary>
          /// <param name="X">Coordenada X.</param>
          /// <param name="Y">Coordenada Y.</param>
          /// <param name="AString">Texto a imprimir.</param>
          /// <param name="AguardaCheque">Indica se aguarda cheque.</param>
          /// <param name="SegundosEspera">Tempo de espera.</param>
          void ImprimirTextoCheque(int X, int Y, string AString, bool AguardaCheque, int SegundosEspera);

          /// <summary>
          /// Envia comando para impressora e recebe resposta.
          /// Equivalente ao método POS_TxRx.
          /// </summary>
          /// <param name="aString">Comando a enviar.</param>
          /// <param name="bytesToRead">Quantidade de bytes para ler.</param>
          /// <param name="aTimeOut">Timeout da comunicação.</param>
          /// <param name="waitForTerminator">Indica se deve esperar terminador.</param>
          /// <returns>Resposta da impressora.</returns>
          string TxRx(string aString, byte bytesToRead = 1, int aTimeOut = 500, bool waitForTerminator = false);

    }
}