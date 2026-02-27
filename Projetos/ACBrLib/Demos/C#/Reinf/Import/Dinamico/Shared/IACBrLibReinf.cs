using System;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.Reinf
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLibReinf.
    /// <para>
    /// Expõe os métodos de configuração e de envio/consulta de eventos EFD-Reinf,
    /// conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Documentação geral: <see href="https://acbr.sourceforge.io/ACBrLib/ACBrLibReinf.html">ACBrLibReinf</see>
    /// Métodos: <see href="https://acbr.sourceforge.io/ACBrLib/MetodosReinf.html">Métodos Reinf</see>
    /// </para>
    /// </summary>
    public interface IACBrLibReinf : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca ACBrLibReinf (sessão [Reinf] e DFe).
        /// </summary>
        ACBrReinfConfig Config { get; }

        /// <summary>
        /// Limpa a lista de eventos Reinf carregados na biblioteca.
        /// Corresponde a Reinf_LimparReinf.
        /// </summary>
        void LimparReinf();

        /// <summary>
        /// Cria um ou mais eventos Reinf a partir de um arquivo INI.
        /// Corresponde a Reinf_CriarEventoReinf.
        /// </summary>
        /// <param name="eArqIni">Caminho do arquivo INI do evento.</param>
        void CriarEventoReinf(string eArqIni);

        /// <summary>
        /// Envia para o webservice todos os eventos Reinf criados/carregados.
        /// Corresponde a Reinf_EnviarReinf.
        /// </summary>
        /// <returns>Retorno textual da operação, conforme ACBrLib.</returns>
        string EnviarReinf();

        /// <summary>
        /// Consulta o processamento de um lote de eventos Reinf pelo protocolo.
        /// Corresponde a Reinf_ConsultarReinf.
        /// </summary>
        /// <param name="eProtocolo">Protocolo retornado no envio.</param>
        /// <returns>Retorno textual da consulta.</returns>
        string ConsultarReinf(string eProtocolo);

        /// <summary>
        /// Consulta recibos de eventos Reinf já enviados, filtrando por período,
        /// tipo de evento e identificadores de estabelecimento, tomador,
        /// prestador, contribuinte e fonte pagadora.
        /// Corresponde a Reinf_ConsultarReciboReinf.
        /// </summary>
        /// <param name="ePerApur">Período de apuração.</param>
        /// <param name="aTipoEvento">Tipo de evento conforme documentação do Reinf.</param>
        /// <param name="eNrInscEstab">Número de inscrição do estabelecimento.</param>
        /// <param name="eCnpjPrestador">CNPJ do prestador, quando aplicável.</param>
        /// <param name="eNrInscTomador">Número de inscrição do tomador, quando aplicável.</param>
        /// <param name="eDtApur">Data de apuração.</param>
        /// <param name="eCpfCnpjBenef">CPF/CNPJ do beneficiário.</param>
        /// <param name="eCnpjFonte">CNPJ da fonte pagadora.</param>
        /// <returns>Retorno textual com os recibos localizados.</returns>
        string ConsultarReciboReinf(string ePerApur, int aTipoEvento, string eNrInscEstab,
            string eCnpjPrestador, string eNrInscTomador, string eDtApur, string eCpfCnpjBenef,
            string eCnpjFonte);

        /// <summary>
        /// Cria os eventos a partir do INI e já envia em uma única chamada.
        /// Corresponde a Reinf_CriarEnviarReinf.
        /// </summary>
        /// <param name="eArqIni">Caminho do arquivo INI do evento.</param>
        /// <returns>Retorno textual com resultado da criação e envio.</returns>
        string CriarEnviarReinf(string eArqIni);

        /// <summary>
        /// Carrega um XML de evento Reinf a partir de arquivo ou string.
        /// Corresponde a Reinf_CarregarXMLEventoReinf.
        /// </summary>
        /// <param name="eArquivoOuXML">Caminho do XML ou conteúdo XML.</param>
        void CarregarXMLEventoReinf(string eArquivoOuXML);

        /// <summary>
        /// Ajusta o identificador do contribuinte na biblioteca.
        /// Corresponde a Reinf_SetIDContribuinte.
        /// </summary>
        /// <param name="aIdContribuinte">Identificador do contribuinte.</param>
        void SetIDContribuinte(string aIdContribuinte);

        /// <summary>
        /// Define o tipo de contribuinte.
        /// Corresponde a Reinf_SetTipoContribuinte.
        /// </summary>
        /// <param name="aTipoContribuinte">Tipo conforme documentação (0, 1, 2,...).</param>
        void SetTipoContribuinte(int aTipoContribuinte);

        /// <summary>
        /// Ajusta o identificador do transmissor na biblioteca.
        /// Corresponde a Reinf_SetIDTransmissor.
        /// </summary>
        /// <param name="aIdTransmissor">Identificador do transmissor.</param>
        void SetIDTransmissor(string aIdTransmissor);

        /// <summary>
        /// Define a versão do layout Reinf a ser utilizada.
        /// Corresponde a Reinf_SetVersaoDF.
        /// </summary>
        /// <param name="sVersao">Versão do documento fiscal (por exemplo, "2.05.01").</param>
        void SetVersao(string sVersao);

        /// <summary>
        /// Obtém as informações dos certificados disponíveis para uso pelo Reinf,
        /// retornando uma lista de <see cref="InfoCertificado"/> preenchida a partir
        /// do retorno textual da ACBrLib (Reinf_ObterCertificados).
        /// </summary>
        /// <returns>Array de certificados conhecidos pela biblioteca.</returns>
        InfoCertificado[] ObterCertificados();
    }
}

