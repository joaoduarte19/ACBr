/*
   Demo ACBrLibConsultaCNPJ (padrao Harbour igual ao PIXCD).
   Documentacao: https://acbr.sourceforge.io/ACBrLib/SobreaACBrLibConsultaCNPJ.html
   CNPJ_Inicializar / CNPJ_Finalizar: https://acbr.sourceforge.io/ACBrLib/CNPJ_Inicializar.html
*/

Function Main()
   local oLib, cRet

   oLib := ACBrConsultaCNPJ():New()

   oLib:ConfigGravarValor("Principal", "LogNivel", "4")
   oLib:ConfigGravarValor("Principal", "LogPath", hb_dirBase() + "Logs")
   oLib:ConfigGravarValor("ConsultaCNPJ", "Provedor", "0")
   oLib:ConfigGravar()

   ? oLib:Nome()
   ? oLib:Versao()
                           
   cRet := oLib:Consultar("11111111111111")
   ? cRet

   oLib:Destroy()

RETURN NIL
