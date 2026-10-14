using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBrLib.IMendes
{
    public sealed partial class ACBrIMendes
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Inicializar(string eArqConfig, string eChaveCrypt);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Finalizar();

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Nome(StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Versao(StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_OpenSSLInfo(StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_UltimoRetorno(StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigImportar(string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigExportar(StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigLer(string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigGravar(string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigLerValor(string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigGravarValor(string eSessao, string eChave, string valor);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarDescricao(string eDescricao, string eCNPJ, int nTipo, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarAlterados(string eUF, string eCNPJ, int nLimite, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_HistoricoAcesso(string eCNPJ, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarRegimesEspeciais(string eUF, bool bIncludeTrib, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_SaneamentoGrades(string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Inativar(string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_RemoveDevolvidos(string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        protected override void InitializeMethods()
        {
            AddMethod<IMendes_Inicializar>("IMendes_Inicializar");
            AddMethod<IMendes_Finalizar>("IMendes_Finalizar");
            AddMethod<IMendes_Nome>("IMendes_Nome");
            AddMethod<IMendes_Versao>("IMendes_Versao");
            AddMethod<IMendes_OpenSSLInfo>("IMendes_OpenSSLInfo");
            AddMethod<IMendes_UltimoRetorno>("IMendes_UltimoRetorno");
            AddMethod<IMendes_ConfigImportar>("IMendes_ConfigImportar");
            AddMethod<IMendes_ConfigExportar>("IMendes_ConfigExportar");
            AddMethod<IMendes_ConfigLer>("IMendes_ConfigLer");
            AddMethod<IMendes_ConfigGravar>("IMendes_ConfigGravar");
            AddMethod<IMendes_ConfigLerValor>("IMendes_ConfigLerValor");
            AddMethod<IMendes_ConfigGravarValor>("IMendes_ConfigGravarValor");
            AddMethod<IMendes_ConsultarDescricao>("IMendes_ConsultarDescricao");
            AddMethod<IMendes_ConsultarAlterados>("IMendes_ConsultarAlterados");
            AddMethod<IMendes_HistoricoAcesso>("IMendes_HistoricoAcesso");
            AddMethod<IMendes_ConsultarRegimesEspeciais>("IMendes_ConsultarRegimesEspeciais");
            AddMethod<IMendes_SaneamentoGrades>("IMendes_SaneamentoGrades");
            AddMethod<IMendes_Inativar>("IMendes_Inativar");
            AddMethod<IMendes_RemoveDevolvidos>("IMendes_RemoveDevolvidos");
        }
    }
}
