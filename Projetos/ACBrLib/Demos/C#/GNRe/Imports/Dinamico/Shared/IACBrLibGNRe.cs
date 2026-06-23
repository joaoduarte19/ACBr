
using ACBrLib.Core;
using System;
using ACBrLib.Core.DFe;

namespace ACBrLib.GNRe
{
    /// <summary>
    /// Interface de comunicação com a ACBrLib GNRe.
    /// </summary>
    public interface IACBrLibGNRe : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configuração da biblioteca GNRe.
        /// </summary>
        GNReConfig Config { get; }

        /// <summary>
        /// Carrega uma GNRe a partir de um arquivo ou string XML.
        /// </summary>
        /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML.</param>
        void CarregarXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega uma GNRe a partir de um arquivo ou string INI.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI.</param>
        void CarregarINI(string eArquivoOuIni);

        /// <summary>
        /// Retorna o XML da GNRe carregada no índice informado.
        /// </summary>
        /// <param name="aIndex">Índice da GNRe.</param>
        /// <returns>Conteúdo XML da GNRe.</returns>
        string ObterXml(int aIndex);

        /// <summary>
        /// Grava o XML da GNRe no disco.
        /// </summary>
        /// <param name="aIndex">Índice da GNRe.</param>
        /// <param name="eNomeArquivo">Nome do arquivo de saída.</param>
        /// <param name="ePathArquivo">Caminho do diretório de saída.</param>
        void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Carrega o XML de retorno de uma guia GNRe.
        /// </summary>
        /// <param name="eArquivoOuXml">Caminho do arquivo XML de retorno ou conteúdo XML.</param>
        void CarregarGuiaRetorno(string eArquivoOuXml);

        /// <summary>
        /// Limpa a lista de GNRe carregadas em memória.
        /// </summary>
        void LimparLista();

        /// <summary>
        /// Limpa a lista de guias de retorno carregadas em memória.
        /// </summary>
        void LimparListaGuiaRetorno();

        /// <summary>
        /// Realiza a assinatura digital das GNRe carregadas.
        /// </summary>
        void Assinar();

        /// <summary>
        /// Realiza a validação das GNRe carregadas (schema XML).
        /// </summary>
        void Validar();

        /// <summary>
        /// Verifica a assinatura digital das GNRe carregadas.
        /// </summary>
        /// <returns>Resultado da verificação da assinatura.</returns>
        string VerificarAssinatura();

        /// <summary>
        /// Obtém os certificados digitais disponíveis no repositório do sistema.
        /// </summary>
        /// <returns>Array com informações dos certificados encontrados.</returns>
        InfoCertificado[] ObterCertificados();

        /// <summary>
        /// Envia as GNRe carregadas para processamento no ambiente configurado.
        /// </summary>
        /// <returns>Resposta do envio.</returns>
        string Enviar();

        /// <summary>
        /// Consulta uma GNRe por UF favorecida e código de receita.
        /// </summary>
        /// <param name="uf">Sigla da UF favorecida.</param>
        /// <param name="receita">Código da receita.</param>
        /// <returns>Resposta da consulta.</returns>
        string Consultar(string uf, int receita);

        /// <summary>
        /// Envia o documento GNRe por e-mail.
        /// </summary>
        /// <param name="ePara">Destinatário principal.</param>
        /// <param name="eChaveNFe">Chave do documento relacionado.</param>
        /// <param name="aEnviaPDF">Define se deve anexar o PDF.</param>
        /// <param name="eAssunto">Assunto do e-mail.</param>
        /// <param name="eMensagem">Mensagem do e-mail.</param>
        /// <param name="eCc">Destinatários em cópia.</param>
        /// <param name="eAnexos">Arquivos anexos adicionais.</param>
        void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);

        /// <summary>
        /// Imprime a GNRe.
        /// </summary>
        /// <param name="impressora">Nome da impressora.</param>
        /// <param name="MostrarPreview">Define se deve exibir a pré-visualização.</param>
        void Imprimir(string impressora = "", bool? MostrarPreview = null);

        /// <summary>
        /// Gera o PDF da GNRe.
        /// </summary>
        void ImprimirPDF();

    }
}