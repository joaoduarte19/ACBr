using System;
using ACBrLib.Core;

namespace ACBrLib.BAL
{
    public interface IACBrLibBAL : IACBrLibBase, IDisposable
    {
        BALConfig Config { get; }
        void Ativar();
        void Desativar();
        decimal LePeso(int MillisecTimeOut = 1000);
        void SolicitarPeso();
        decimal UltimoPesoLido();
        decimal InterpretarRespostaPeso(string resposta);
    }
}