using ACBrLib.Core;
using ACBrLib.Core.PosPrinter;
using System;

namespace ACBrLib.PosPrinter
{

    public interface IACBrLibPosPrinter : IACBrLibBase, IDisposable
    {
        PosPrinterConfig Config { get; }


        void InicializarPos();
        void Ativar();
        void Desativar();
        void Zerar();
        void Reset();
        void PularLinhas(int numLinhas = 0);
        void CortarPapel(bool parcial = false);
        void AbrirGaveta();
        string LerInfoImpressora();
        ACBrPosTipoStatus LerStatusImpressora(int tentativas = 1);
        string[] RetornarTags(bool incluiAjuda = true);
        string[] AcharPortas();
        void GravarLogoArquivo(string aPath, int nAKC1, int nAKC2);
        void ApagarLogo(int nAKC1, int nAKC2);
        string LeituraCheque();
        string LerCMC7(bool AguardaCheque, int SegundosEspera);
        void EjetarCheque();
        bool PodeLerDaPorta();
        string LerCaracteristicas();

        void Imprimir(string aString = "", bool pulaLinha = false, bool decodificarTags = true, bool codificarPagina = true, int copias = 1);
        void ImprimirLinha(string aString);
        void ImprimirCmd(string aString);
        void ImprimirTags();
        void ImprimirImagemArquivo(string aPath);
        void ImprimirLogo(int nAKC1, int nAKC2, int nFatorX, int nFatorY);
        void ImprimirCheque(int CodBanco, decimal AValor, DateTime ADataEmissao, string AFavorecido,
           string ACidade, string AComplemento, bool LerCMC7, int SegundosEspera);
        void ImprimirTextoCheque(int X, int Y, string AString, bool AguardaCheque, int SegundosEspera);
        string TxRx(string aString, byte bytesToRead = 1, int aTimeOut = 500, bool waitForTerminator = false);

    }
}