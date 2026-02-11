using System;

namespace ACBrLib.Core
{

    /// <summary>
    /// Interface base para todas as bibliotecas ACBrLib.
    /// Define o contrato para operações comuns para classes de alto nível Da ACBrLib em C# 
    public interface IACBrLibBase
    {
        /// <summary>
        /// Método usado para gravar a configuração da biblioteca no arquivo INI informado.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo INI onde a configuração será gravada. Se vazio, utiliza o padrão da biblioteca.</param>
        void ConfigGravar(string eArqConfig = "");

        /// <summary>
        /// Método usado para ler a configuração da biblioteca a partir do arquivo INI informado.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo INI de onde a configuração será lida. Se vazio, utiliza o padrão da biblioteca.</param>
        void ConfigLer(string eArqConfig = "");

        /// <summary>
        /// Método usado para ler um valor específico da configuração da biblioteca.
        /// </summary>
        /// <typeparam name="T">Tipo do valor a ser lido.</typeparam>
        /// <param name="eSessao">Sessão da configuração.</param>
        /// <param name="eChave">Chave da configuração.</param>
        /// <returns>Valor da configuração.</returns>
        T ConfigLerValor<T>(ACBrSessao eSessao, string eChave);

        /// <summary>
        /// Método usado para gravar um valor específico na configuração da biblioteca.
        /// </summary>
        /// <param name="eSessao">Sessão da configuração.</param>
        /// <param name="eChave">Chave da configuração.</param>
        /// <param name="value">Valor a ser gravado.</param>
        void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value);

        /// <summary>
        /// Método usado para importar a configuração da biblioteca a partir de um arquivo INI.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo INI de onde a configuração será importada.</param>
        void ImportarConfig(string eArqConfig);

        /// <summary>
        /// Método usado para exportar a configuração da biblioteca para uma string.
        /// </summary>
        /// <returns>Configuração da biblioteca em formato de string.</returns>
        string ExportarConfig();
    }
}