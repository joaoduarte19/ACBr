using ACBrLib.Core;
using ACBrLib.Core.Boleto;
using System;
using System.IO;
namespace ACBrLib.Boleto
{
    public interface IACBrLibBoleto : IACBrLibBase, IDisposable
    {
        ACBrBoletoConfig Config { get; }

        void ConfigurarDados(params BoletoInfo[] infos);
        void ConfigurarDados(string eArquivoIni);
        void IncluirTitulos(params Titulo[] titulos);
        void IncluirTitulos(BoletoTpSaida eTpSaida, params Titulo[] titulos);
        void IncluirTitulos(string eArquivoIni, BoletoTpSaida? eTpSaida = null);
        void LimparLista();
        int TotalTitulosLista();
        void Imprimir(string eNomeImpressora = "");
        void Imprimir(int indice, string eNomeImpressora = "");
        void GerarPDF();
        void GerarPDF(Stream aStream);
        void GerarPDF(int indice);
        string GerarToken();
        string InformarToken(string eToken, DateTime eData);
        void GerarPDF(int indice, Stream aStream);
        void GerarHTML();
        void GerarRemessa(string eDir, int eNumArquivo, string eNomeArq);
        void GerarRemessaStream(int eNumArquivo, Stream aStream);
        RetornoBoleto ObterRetorno(string eDir, string eNomeArq);
        void LerRetorno(string eDir, string eNomeArq);
        string LerRetornoStream(string ARetornoBase64);
        void EnviarEmail(string ePara, string eAssunto, string eMensagem, string eCC);
        void EnviarEmailBoleto(int eIndex, string ePara, string eAssunto, string eMensagem, string eCC);
        void SetDiretorioArquivo(string eDir, string eArq = "");
        string[] ListaBancos();
        string[] ListaCaractTitulo();
        string[] ListaOcorrencias();
        string[] ListaOcorrenciasEX();
        int TamNossoNumero(string eCarteira, string enossoNumero, string eConvenio);
        string CodigosMoraAceitos();
        void SelecionaBanco(string eCodBanco);
        string MontarNossoNumero(int eIndex);
        string RetornaLinhaDigitavel(int eIndex);
        string RetornaCodigoBarras(int eIndex);
        RetornoWeb EnviarBoleto(OperacaoBoleto opercao);
        string ConsultarTitulosPorPeriodo(string eArquivoIni);


    }
}
