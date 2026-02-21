using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFSe;

namespace ACBrLib.NFSe
{
    /// <summary>
    /// Configurações específicas da ACBrLibNFSe, conforme documentação oficial da ACBrLib.
    /// Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca22.html
    /// </summary>
    public sealed class ACBrNFSeConfig : ACBrLibDFeConfig<IACBrLibNFSe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe ACBrNFSeConfig para configuração da ACBrLibNFSe.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de <see cref="IACBrLibNFSe"/>.</param>
        public ACBrNFSeConfig(IACBrLibNFSe acbrlib) : base(acbrlib, ACBrSessao.NFSe)
        {
            DANFSe = new DANFSeConfig(acbrlib);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações do DANFSe (Documento Auxiliar da Nota Fiscal de Serviço Eletrônica).
        /// </summary>
        public DANFSeConfig DANFSe { get; }

        /// <summary>
        /// Caminho onde será salvo o XML da NFSe.
        /// Chave: PathNFSe
        /// </summary>
        public string PathNFSe
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o XML de cancelamento deve ser atualizado.
        /// Chave: AtualizarXMLCancelado
        /// </summary>
        public bool AtualizarXMLCancelado
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o PathSchema deve ser montado automaticamente.
        /// Chave: MontarPathSchema
        /// </summary>
        public bool MontarPathSchema
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve consultar o lote após o envio.
        /// Chave: ConsultaLoteAposEnvio
        /// </summary>
        public bool ConsultaLoteAposEnvio
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve consultar a NFSe após o cancelamento.
        /// Chave: ConsultaAposCancelar
        /// </summary>
        public bool ConsultaAposCancelar
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o layout da NFSe utilizado.
        /// Chave: LayoutNFSe
        /// 0 = lnfsProvedor, 1 = lnfsPadraoNacionalv1, 2 = lnfsPadraoNacionalv101
        /// </summary>
        public LayoutNFSe LayoutNFSe
        {
            get => GetProperty<LayoutNFSe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se será utilizada a emissão de Path específico para NFSe.
        /// Chave: EmissaoPathNFSe
        /// </summary>
        public bool EmissaoPathNFSe
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o código do município utilizado nas operações da NFSe.
        /// Chave: CodigoMunicipio
        /// </summary>
        public CodigoMunicipio CodigoMunicipio
        {
            get => GetProperty<CodigoMunicipio>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}