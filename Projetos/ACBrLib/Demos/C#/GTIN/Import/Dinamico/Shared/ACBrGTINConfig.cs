using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.eSocial;
using ACBrLib.Core.DFe;

namespace ACBrLib.GTIN
{
    /// <summary>
    /// Configurações específicas da biblioteca ACBrLibGTIN.
    /// <para>Baseada na documentação oficial: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca19.html</para>
    /// </summary>
    /// <remarks>
    /// Principais chaves de configuração:
    /// <list type="bullet">
    /// <item><b>PathSalvar</b>: Caminho onde será salvo os XML em geral.</item>
    /// <item><b>PathSchemas</b>: Caminho dos arquivos XSD (Schemas).</item>
    /// <item><b>IniServicos</b>: Caminho e nome do arquivo INI das URLs de homologação e produção.</item>
    /// <item><b>SalvarGer</b>: Define se os XMLs de envio e retorno serão salvos em disco (0=Não, 1=Sim).</item>
    /// <item><b>AdicionarLiteral</b>: Cria pasta com literal GTIN (0=Não, 1=Sim).</item>
    /// <item><b>PathGTIN</b>: Caminho onde será salvo os XML do GTIN.</item>
    /// <item><b>FormaEmissao</b>: Forma de emissão do GNRe (0=teNormal).</item>
    /// <item><b>ExibirErroSchema</b>: Exibe erro de validação (0=Não, 1=Sim).</item>
    /// <item><b>FormatoAlerta</b>: Formato da mensagem de erro de validação.</item>
    /// <item><b>IdentarXML</b>: Indenta o XML (0=Não, 1=Sim).</item>
    /// <item><b>ValidarDigest</b>: Compara DigestValue do certificado (0=Não, 1=Sim).</item>
    /// <item><b>VersaoDF</b>: Versão do GTIN (0=ve100).</item>
    /// <item><b>Ambiente</b>: Ambiente de envio dos XML (0=Producao, 1=Homologacao).</item>
    /// <item><b>Timeout</b>: Tempo de espera por resposta do webservice (ms).</item>
    /// <item><b>TimeoutPorThread</b>: Tempo de espera por Thread (ms).</item>
    /// <item><b>Visualizar</b>: Exibe mensagens de retorno dos webservices (0=Não, 1=Sim).</item>
    /// <item><b>SalvarWS</b>: Salva XML de envio e retorno com envelopes (0=Não, 1=Sim).</item>
    /// <item><b>SSLType</b>: Tipo de comunicação segura (0=LT_all, ...).</item>
    /// <item><b>SalvarArq</b>: Salva XML dos eventos (0=Não, 1=Sim).</item>
    /// </list>
    /// </remarks>
    public sealed class ACBrGTINConfig : ACBrLibDFeConfig<IACBrLibGTIN>
    {
        #region Constructors

        public ACBrGTINConfig(IACBrLibGTIN acbrlib) : base(acbrlib, ACBrSessao.GTIN)
        {

        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Caminho onde será salvo os XML do GTIN.
        /// <para>Chave: PathGTIN</para>
        /// </summary>
        public string PathGTIN
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}