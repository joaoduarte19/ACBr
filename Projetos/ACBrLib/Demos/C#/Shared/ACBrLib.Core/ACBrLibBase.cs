using System;
using System.IO;
using System.Text;

namespace ACBrLib.Core
{

    /// <summary>
    /// Classe base para as novas biblioteca ACBrLib C# Mono.
    /// É indica para uso em ambiente Linux, principalmente desenvolvimento de APIs REST, mas também pode ser usada em ambiente Windows.
    /// Diferente de ACBrLibHandle essa classe define apenas os métodos e propriedades comuns a todas as bibliotecas ACBrLib em alto nível, ou seja, sem lidar diretamente com ponteiros e buffers.
    /// Essa classe define os métodos e propriedades comuns a todas as bibliotecas ACBrLib em alto nível.
    /// </summary>
    public abstract class ACBrLibBase: IACBrLibBase
    {

        #region fields
        protected string arquivoConfig;
        protected string chaveCrypt;
        #endregion

        #region constructor
        public ACBrLibBase(string eArqConfig = "", string eChaveCrypt = "")
        {
            arquivoConfig = eArqConfig;
            chaveCrypt = eChaveCrypt;
        }

        #endregion

        public const int BUFFER_LEN = 1024;

        #region métodos  abstratos comuns
        
        public abstract void Inicializar( string eArqConfig = "", string eChaveCrypt = "");
        public abstract void Finalizar();
        public abstract void ConfigLer(string eArqConfig);
        public abstract void ConfigGravar(string eArqConfig);

        /// <summary>
        /// Método usado para ler um valor específico da configuração da biblioteca.
        /// </summary>
        /// <param name="eSessao">Sessão da configuração.</param>
        /// <param name="eChave">Chave da configuração.</param>
        /// <returns>Valor da configuração.</returns>
        public abstract string ConfigLerValor(string eSessao, string eChave);

        /// <summary>
        /// Método usado para gravar um valor específico na configuração da biblioteca.
        /// </summary>
        /// <param name="eSessao">Sessão da configuração.</param>
        /// <param name="eChave">Chave da configuração.</param>
        /// <param name="eValor">Valor da configuração.</param>
        public abstract void ConfigGravarValor(string eSessao, string eChave, string eValor);
        public abstract T ConfigLerValor<T>(ACBrSessao eSessao, string eChave);

        public abstract void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value);

        public abstract void ImportarConfig(string eArqConfig);

        public abstract string ExportarConfig();

        public abstract string Versao();
        public abstract string Nome();
        protected abstract string GetUltimoRetorno(int iniBufferLen = 0);
        public abstract string OpenSSLInfo();

        #endregion

        #region  metodos estaticos 
        protected static string ToUTF8(string value) => string.IsNullOrEmpty(value) ? value : Encoding.Default.GetString(Encoding.UTF8.GetBytes(value));

        protected static string FromUTF8(StringBuilder value)
        {
            if (value == null) return string.Empty;
            var ret = value.ToString();

            return ret.Length == 0
                ? string.Empty


                : Encoding.UTF8.GetString(Encoding.Default.GetBytes(ret));
        }

        #endregion
        protected virtual T ConvertValue<T>(string value)
        {
            if (typeof(T).IsEnum && !Attribute.IsDefined(typeof(T), typeof(FlagsAttribute))) return (T)Enum.ToObject(typeof(T), Convert.ToInt32(value));
            if (typeof(T).IsEnum && Attribute.IsDefined(typeof(T), typeof(FlagsAttribute))) return (T)Enum.Parse(typeof(T), value.Trim('[', ']'), true);
            if (typeof(T) == typeof(bool)) return (T)(object)Convert.ToBoolean(Convert.ToInt32(value));
            if (typeof(T) == typeof(byte[])) return (T)(object)Convert.FromBase64String(value);
            if (typeof(T) != typeof(Stream)) return (T)Convert.ChangeType(value, typeof(T));

            var dados = Convert.FromBase64String(value);
            var ms = new MemoryStream();
            ms.Write(dados, 0, dados.Length);
            return (T)(object)ms;
        }

        protected virtual string ConvertValue(object value)
        {
            var type = value.GetType();
            var propValue = value.ToString();
            if (type.IsEnum && !Attribute.IsDefined(type, typeof(FlagsAttribute))) propValue = ((int)value).ToString();
            if (type.IsEnum && Attribute.IsDefined(type, typeof(FlagsAttribute))) propValue = $"[{Enum.Format(type, value, "F")}]";
            if (type == typeof(bool)) propValue = Convert.ToInt32(value).ToString();
            if (type == typeof(byte[])) propValue = Convert.ToBase64String((byte[])value);
            if (type != typeof(Stream)) return propValue;

            using (var ms = new MemoryStream())
            {
                ((Stream)value).CopyTo(ms);
                propValue = Convert.ToBase64String(ms.ToArray());
            }

            return propValue;
        }

        protected async void Base64ToStream(string base64, Stream aStream)
        {
            var pdfBytes = Convert.FromBase64String(base64);
            await aStream.WriteAsync(pdfBytes, 0, pdfBytes.Length);
            await aStream.FlushAsync();

            aStream.Position = 0;
        }


        protected virtual void CheckResult(int ret)
        {
            if (ret >= 0) return;
            var message = $"Erro: {ret}: {GetUltimoRetorno()}";

            switch (ret)
            {
                case -1:
                    throw new Exception($"Erro: {ret} Biblioteca não inicializada");

                case -6:
                    throw new DirectoryNotFoundException(message);

                case -5:
                    throw new FileNotFoundException(message);

                case -19:
                    throw new ACBrLibTimeoutException(message);

                default:
                    throw new ApplicationException(message);
            }
        }

        protected string CheckBuffer(StringBuilder buffer, int bufferLen)
        {
            if (bufferLen > BUFFER_LEN)
            {
                bufferLen = (int)(bufferLen * 1.30);

                return GetUltimoRetorno(bufferLen);
            }
            return FromUTF8(buffer);
        }



        ///     Cria e dispara uma <see cref="ApplicationException" /> com a mensagem informada.
        /// </summary>
        /// <param name="errorMessage">Mensagem de erro.</param>
        /// <returns>
        ///     <see cref="ApplicationException" />
        /// </returns>
        protected virtual ApplicationException CreateException(string errorMessage) => new ApplicationException(errorMessage);

        /// <summary>
        ///     Tatar uma <see cref="Exception" /> e dispara uma <see cref="ApplicationException" /> com a mensagem da mesma.
        /// </summary>
        /// <param name="exception">Exception</param>
        /// <returns>
        ///     <see cref="ApplicationException" />
        /// </returns>
        protected virtual ApplicationException ProcessException(Exception exception) => new ApplicationException(exception.Message, exception);



    }
}