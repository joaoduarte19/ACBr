using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using ACBrLib.Core;

namespace ACBrLib.CEP
{
    /// <summary>
    /// Handle class for ACBr CEP library operations.
    /// </summary>
    internal sealed class ACBrCEPHandle : ACBrLibHandleBase
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_Inicializar(ref IntPtr handle, string eArqConfig, string eChaveCrypt);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_Finalizar(IntPtr handle);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigImportar(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigLer(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigGravar(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_BuscarPorCEP(IntPtr handle, string eCEP, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_BuscarPorLogradouro(IntPtr handle, string eCidade, string eTipo_Logradouro, string eLogradouro, string eUF, string eBairro, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CEP_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        protected override void InitializeMethods()
        {
            AddMethod<CEP_Inicializar>("CEP_Inicializar");
            AddMethod<CEP_Finalizar>("CEP_Finalizar");
            AddMethod<CEP_Nome>("CEP_Nome");
            AddMethod<CEP_Versao>("CEP_Versao");
            AddMethod<CEP_UltimoRetorno>("CEP_UltimoRetorno");
            AddMethod<CEP_ConfigImportar>("CEP_ConfigImportar");
            AddMethod<CEP_ConfigExportar>("CEP_ConfigExportar");
            AddMethod<CEP_ConfigLer>("CEP_ConfigLer");
            AddMethod<CEP_ConfigGravar>("CEP_ConfigGravar");
            AddMethod<CEP_ConfigLerValor>("CEP_ConfigLerValor");
            AddMethod<CEP_ConfigGravarValor>("CEP_ConfigGravarValor");
            AddMethod<CEP_BuscarPorCEP>("CEP_BuscarPorCEP");
            AddMethod<CEP_BuscarPorLogradouro>("CEP_BuscarPorLogradouro");
            AddMethod<CEP_OpenSSLInfo>("CEP_OpenSSLInfo");
        }

        protected override string GetLibraryName()
        {
            var arch = Environment.Is64BitProcess ? "64" : "32";
            if ( PlatformID.Unix == Environment.OSVersion.Platform )
                return $"libacbrcep{arch}.so";
            
            
            return $"ACBrCEP{arch}.dll";
        }


       //singleton dessa classe, para garantir que apenas uma instância do handle seja criada durante a execução do programa
        private static readonly Lazy<ACBrCEPHandle> instance = new Lazy<ACBrCEPHandle>(() => new ACBrCEPHandle());
            public static ACBrCEPHandle Instance => instance.Value;


        
    }   
}