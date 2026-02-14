using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using System.Runtime.ConstrainedExecution;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBrLib.Core
{



    /// <summary>
    ///     ACBrLibHandleBase é uma classe base para bridges de bibliotecas nativas, fornecendo funcionalidade para carregar bibliotecas, obter ponteiros de função e executar métodos com tratamento de erros.
    ///  As classes derivadas devem implementar o método GetLibraryName para especificar o nome da biblioteca a ser carregada e podem usar AddMethod para registrar os métodos nativos que desejam acessar.
    /// </summary>
    public abstract class ACBrLibHandleBase
    {
        public static readonly IntPtr MisusOne = new IntPtr(-1);
        private IntPtr libraryHandle = IntPtr.Zero;
        protected readonly Dictionary<Type, string> methodList;
        protected readonly Dictionary<string, Delegate> methodCache;

        /// <summary>
        /// Inicializa os métodos nativos que serão usados pela classe. As classes derivadas devem implementar este método para registrar os métodos nativos específicos que desejam acessar usando o método AddMethod.
        /// </summary>
        protected abstract void InitializeMethods();

        /// <summary>
        /// Retorna o nome correto da biblioteca a ser carregada, dependendo do sistema operacional e arquitetura. As classes derivadas devem implementar este método para fornecer o nome específico da biblioteca que desejam carregar.
        /// </summary> <returns>O nome da biblioteca a ser carregada.</returns>  
        protected abstract string GetLibraryName();


        public ACBrLibHandleBase()
        {
            methodList = new Dictionary<Type, string>();
            methodCache = new Dictionary<string, Delegate>();
            LoadLibrary();
            InitializeMethods();
        }



        /// <summary>
        ///     Adiciona um delegate a lista para a função informada.
        /// </summary>
        /// <param name="functionName">Nome da função para exportar</param>
        /// <typeparam name="T">Delegate da função</typeparam>
        protected virtual void AddMethod<T>(string functionName) where T : class => methodList.Add(typeof(T), functionName);

        /// <summary>
        ///     Retorna o delegate para uso.
        /// </summary>
        /// <typeparam name="T">Delegate</typeparam>
        /// <returns></returns>
        /// <exception cref="ArgumentNullException"></exception>
        public virtual T GetMethod<T>() where T : class
        {
            if (!methodList.ContainsKey(typeof(T)))
                throw new Exception($"Função não adicionada para o [{nameof(T)}].");

            var method = methodList[typeof(T)];
            if (methodCache.ContainsKey(method)) return methodCache[method] as T;

            var mHandler = LibLoader.GetProcAddress(libraryHandle, method);

            if (mHandler == IntPtr.Zero || mHandler == MisusOne)
                throw new ArgumentNullException("Função não encontrada: " + method);

            var methodHandler = LibLoader.LoadFunction<T>(mHandler);

            methodCache.Add(method, methodHandler as Delegate);
            return methodHandler;
        }

        /// <summary>
        ///     Executa a função e trata erros nativos.
        /// </summary>
        /// <param name="method"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        /// <exception cref="ApplicationException"></exception>
        [HandleProcessCorruptedStateExceptions]
        public virtual T ExecuteMethod<T>(Func<T> method)
        {
            try
            {
                return method();
            }
            catch (Exception exception)
            {
                throw new Exception(exception.Message, exception);
            }
        }


        /// <summary>
        /// Método para carregar uma biblioteca nativa usando caminhos de pesquisa específicos. Ele tenta localizar a biblioteca em vários diretórios, incluindo o diretório da aplicação e um subdiretório específico para a arquitetura (x64 ou x86). Se a biblioteca for encontrada, ela é carregada usando a classe LibLoader. Se a biblioteca não puder ser encontrada em nenhum dos caminhos especificados, uma DllNotFoundException é lançada
        /// </summary>
        /// <exception cref="DllNotFoundException"></exception>
        private void LoadLibrary()
        {
            var path = GetLibrarySearchPath();
            var libraryName = GetLibraryName();
            foreach (var p in path)
            {
                var fullPath = Path.Combine(p, libraryName);
                if (File.Exists(fullPath))
                {
                    libraryHandle = LibLoader.LoadLibrary(fullPath);
                    if (libraryHandle != IntPtr.Zero && libraryHandle != MisusOne)
                        return;
                }
            }
            throw new DllNotFoundException($"Unable to load library '{libraryName}' from paths: {string.Join(", ", path)}");
        }

        protected virtual string[] GetLibrarySearchPath()
        {
            var path = new List<string>();

            var assemblyLocation = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            if (!string.IsNullOrEmpty(assemblyLocation))
                path.Add(assemblyLocation);

            var currentDirectory = Directory.GetCurrentDirectory();
            if (!string.IsNullOrEmpty(currentDirectory) && !path.Contains(currentDirectory))
                path.Add(currentDirectory);

            var acbrlibPath = Path.Combine(assemblyLocation, "ACBrLib", Environment.Is64BitProcess ? "x64" : "x86");
            if (!path.Contains(acbrlibPath))
                path.Add(acbrlibPath);

            return path.ToArray();
        }


        protected class LibLoader
        {
            #region Constructors

            static LibLoader()
            {
                switch (Environment.OSVersion.Platform)
                {
                    case PlatformID.Win32S:
                    case PlatformID.Win32Windows:
                    case PlatformID.Win32NT:
                    case PlatformID.WinCE:
                        IsWindows = true;
                        break;

                    case PlatformID.Unix:
                        try
                        {
                            var num = Marshal.AllocHGlobal(8192);
                            if (uname(num) == 0 && Marshal.PtrToStringAnsi(num) == "Darwin")
                                IsOSX = true;

                            Marshal.FreeHGlobal(num);
                            break;
                        }
                        catch
                        {
                            break;
                        }

                    case PlatformID.MacOSX:
                        IsOSX = true;
                        break;

                    default:
                        throw new ArgumentOutOfRangeException();
                }
            }

            #endregion Constructors

            #region Exports

            [DllImport("libc")]
            private static extern int uname(IntPtr buf);

            #endregion Exports

            #region InnerTypes

            private static class Windows
            {
                [DllImport("kernel32", CharSet = CharSet.Ansi, SetLastError = true)]
                public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

                [DllImport("kernel32", CharSet = CharSet.Unicode, SetLastError = true)]
                public static extern IntPtr LoadLibraryW(string lpszLib);

                [DllImport("kernel32", SetLastError = true)]
                public static extern bool FreeLibrary(IntPtr hModule);
            }

            private static class Linux
            {
                [DllImport("libdl.so.2")]
                public static extern IntPtr dlopen(string path, int flags);

                [DllImport("libdl.so.2")]
                public static extern IntPtr dlsym(IntPtr handle, string symbol);

                [DllImport("libdl.so.2")]
                public static extern int dlclose(IntPtr handle);
            }

            private static class OSX
            {
                [DllImport("/usr/lib/libSystem.dylib")]
                public static extern IntPtr dlopen(string path, int flags);

                [DllImport("/usr/lib/libSystem.dylib")]
                public static extern IntPtr dlsym(IntPtr handle, string symbol);

                [DllImport("/usr/lib/libSystem.dylib")]
                public static extern int dlclose(IntPtr handle);
            }

            #endregion InnerTypes

            #region Properties

            public static readonly bool IsWindows;

            public static readonly bool IsOSX;

            #endregion Properties

            #region Methods

            public static IntPtr LoadLibrary(string libname)
            {
                if (IsWindows) return Windows.LoadLibraryW(libname);
                return IsOSX ? OSX.dlopen(libname, 1) : Linux.dlopen(libname, 1);
            }

            public static bool FreeLibrary(IntPtr library)
            {
                if (IsWindows) return Windows.FreeLibrary(library);
                // No Linux (MT) não é seguro tentar descarregar a biblioteca, pode causar condição de corrida se outro thread estiver usando a biblioteca ao mesmo tempo.
                return true;
            }


            public static IntPtr GetProcAddress(IntPtr library, string function)
            {
                var num = !IsWindows
                    ? !IsOSX ? Linux.dlsym(library, function) : OSX.dlsym(library, function)
                    : Windows.GetProcAddress(library, function);
                return num;
            }

            public static T LoadFunction<T>(IntPtr procaddress) where T : class
            {
                if (procaddress == IntPtr.Zero || procaddress == ACBrLibHandleBase.MisusOne) return null;
                var functionPointer = Marshal.GetDelegateForFunctionPointer(procaddress, typeof(T));

                return functionPointer as T;
            }

            #endregion Methods
        }

    }
}
