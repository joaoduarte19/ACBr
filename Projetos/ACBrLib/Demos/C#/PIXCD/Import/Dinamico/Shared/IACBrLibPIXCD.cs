using ACBrLib.Core;
using System;

namespace ACBrLib.PIXCD
{
    public interface IACBrLibPIXCD : IACBrLibBase, IDisposable
    {
        ACBrPIXCDConfig Config { get; }

        string GerarQRCodeEstatico(double AValor, string AinfoAdicional, string ATxID);
        string ConsultarPix(string Ae2eid);
        string ConsultarPixRecebidos(DateTime ADataInicio, DateTime ADataFim, string ATxId, string ACpfCnpj, int PagAtual, int ItensPorPagina);
        string SolicitarDevolucaoPix(string AInfDevolucao, string Ae2eid, string AidDevolucao);
        string ConsultarDevolucaoPix(string Ae2eid, string AidDevolucao);
        string CriarCobrancaImediata(string AInfCobSolicitada, string ATxId);
        string ConsultarCobrancaImediata(string ATxId, int ARevisao);
        string ConsultarCobrancasCob(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina);
        string RevisarCobrancaImediata(string AInfCobRevisada, string ATxId);
        string CancelarCobrancaImediata(string ATxId);
        string CriarCobranca(string AInfCobVSolicitada, string ATxId);
        string ConsultarCobranca(string ATxId, int ARevisao);
        string ConsultarCobrancasCobV(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina);
        string RevisarCobranca(string AInfCobVRevisada, string ATxId);
        string CancelarCobranca(string ATxId);


    }
}
