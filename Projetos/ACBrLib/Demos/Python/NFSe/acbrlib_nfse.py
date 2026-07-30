

#!/usr/bin/env python3
import ctypes
import os
from datetime import date, datetime, timezone




TAMANHO_BUFFER_PADRAO = 1024

# Baseado em ACBrDateConverter (ACBrLib-Nodejs/acbrlib-base-node/src/utils/index.ts):
# Pascal TDateTime = dias desde 30/12/1899, com a parte fracionaria representando a hora do dia.
_MILLIS_PER_DAY = 86_400_000.0
_UNIX_EPOCH_START_PASCAL = 25_569.0


def _paraDataDelphi(valor):
    if isinstance(valor, (int, float)):
        return float(valor)
    if isinstance(valor, datetime):
        dt = valor
    elif isinstance(valor, date):
        dt = datetime(valor.year, valor.month, valor.day)
    else:
        raise TypeError("A data deve ser datetime.date, datetime.datetime ou um TDateTime (double)")
    # dt e "naive" (sem timezone): tratamos como UTC para o calculo ser deterministico,
    # independente do fuso horario da maquina que executa o script.
    millis = dt.replace(tzinfo=timezone.utc).timestamp() * 1000.0
    if millis < 0:
        raise ValueError("Data anterior ao epoch Unix (1970-01-01) nao e suportada")
    return millis / _MILLIS_PER_DAY + _UNIX_EPOCH_START_PASCAL


def carregar_acbrlib_nfe(libraryPath):

    loadLibraryFunction = (ctypes.CDLL,ctypes.cdll.LoadLibrary)[os.name == "nt"]
    lib = loadLibraryFunction(libraryPath)
    # metodos da lib comum 
    lib.NFSE_Inicializar.argtypes = [ctypes.POINTER(ctypes.c_void_p), ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_Inicializar.restype = ctypes.c_int 
    lib.NFSE_Finalizar.argtypes = [ctypes.c_void_p]
    lib.NFSE_Finalizar.restype = ctypes.c_int
    lib.NFSE_UltimoRetorno.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_UltimoRetorno.restype = ctypes.c_int
    lib.NFSE_ConfigExportar.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConfigExportar.restype = ctypes.c_int
    lib.NFSE_ConfigGravarValor.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_ConfigGravarValor.restype = ctypes.c_int
    lib.NFSE_ConfigGravar.argtypes = [ctypes.c_void_p]
    lib.NFSE_ConfigGravar.restype = ctypes.c_int
    lib.NFSE_ConfigImportar.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.NFSE_ConfigImportar.restype = ctypes.c_int
    lib.NFSE_ConfigLer.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.NFSE_ConfigLer.restype = ctypes.c_int
    lib.NFSE_ConfigLerValor.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConfigLerValor.restype = ctypes.c_int

    #metodos da bibliteca
    lib.NFSE_Nome.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_Nome.restype = ctypes.c_int
    lib.NFSE_Versao.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_Versao.restype = ctypes.c_int
    lib.NFSE_OpenSSLInfo.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_OpenSSLInfo.restype = ctypes.c_int

    #metodos NFSe
    lib.NFSE_CarregarINI.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.NFSE_CarregarINI.restype = ctypes.c_int
    lib.NFSE_CarregarXML.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.NFSE_CarregarXML.restype = ctypes.c_int
    lib.NFSE_CarregarLoteXML.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.NFSE_CarregarLoteXML.restype = ctypes.c_int
    lib.NFSE_Emitir.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_bool, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_Emitir.restype = ctypes.c_int
    lib.NFSE_LimparLista.argtypes = [ctypes.c_void_p]
    lib.NFSE_LimparLista.restype = ctypes.c_int
    lib.NFSE_ObterXml.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ObterXml.restype = ctypes.c_int
    lib.NFSE_ObterXmlRps.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ObterXmlRps.restype = ctypes.c_int
    lib.NFSE_GravarXml.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_GravarXml.restype = ctypes.c_int
    lib.NFSE_ObterIni.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ObterIni.restype = ctypes.c_int
    lib.NFSE_GravarIni.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_GravarIni.restype = ctypes.c_int
    lib.NFSE_ObterCertificados.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ObterCertificados.restype = ctypes.c_int
    lib.NFSE_Cancelar.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_Cancelar.restype = ctypes.c_int
    lib.NFSE_SubstituirNFSe.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_SubstituirNFSe.restype = ctypes.c_int
    lib.NFSE_LinkNFSe.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_LinkNFSe.restype = ctypes.c_int
    lib.NFSE_GerarLote.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_GerarLote.restype = ctypes.c_int
    lib.NFSE_GerarToken.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_GerarToken.restype = ctypes.c_int
    lib.NFSE_ConsultarSituacao.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarSituacao.restype = ctypes.c_int
    lib.NFSE_ConsultarLoteRps.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarLoteRps.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSePorRps.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSePorRps.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSePorNumero.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSePorNumero.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSePorPeriodo.argtypes = [ctypes.c_void_p, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSePorPeriodo.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSePorFaixa.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSePorFaixa.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeGenerico.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeGenerico.restype = ctypes.c_int
    lib.NFSE_ConsultarLinkNFSe.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarLinkNFSe.restype = ctypes.c_int
    lib.NFSE_EnviarEmail.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_bool, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_EnviarEmail.restype = ctypes.c_int
    lib.NFSE_Imprimir.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]
    lib.NFSE_Imprimir.restype = ctypes.c_int
    lib.NFSE_ImprimirPDF.argtypes = [ctypes.c_void_p]
    lib.NFSE_ImprimirPDF.restype = ctypes.c_int
    lib.NFSE_SalvarPDF.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_SalvarPDF.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoPrestadoPorNumero.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoPrestadoPorNumero.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoPrestadoPorPeriodo.argtypes = [ctypes.c_void_p, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoPrestadoPorPeriodo.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoPrestadoPorTomador.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoPrestadoPorTomador.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoPrestadoPorIntermediario.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoPrestadoPorIntermediario.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoTomadoPorNumero.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoTomadoPorNumero.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoTomadoPorPrestador.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoTomadoPorPrestador.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoTomadoPorTomador.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoTomadoPorTomador.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoTomadoPorPeriodo.argtypes = [ctypes.c_void_p, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoTomadoPorPeriodo.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSeServicoTomadoPorIntermediario.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSeServicoTomadoPorIntermediario.restype = ctypes.c_int
    lib.NFSE_EnviarEvento.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_EnviarEvento.restype = ctypes.c_int
    lib.NFSE_ConsultarDPSPorChave.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarDPSPorChave.restype = ctypes.c_int
    lib.NFSE_ConsultarNFSePorChave.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarNFSePorChave.restype = ctypes.c_int
    lib.NFSE_ConsultarEvento.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarEvento.restype = ctypes.c_int
    lib.NFSE_ConsultarDFe.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ConsultarDFe.restype = ctypes.c_int
    lib.NFSE_ObterDANFSE.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_int)]
    lib.NFSE_ObterDANFSE.restype = ctypes.c_int

    return lib

"""
ACBrNFSe é uma classe que encapsula a funcionalidade da biblioteca ACBrLibNFSe, fornecendo uma interface python amigável para interagir com a biblioteca. Ela permite inicializar e finalizar a biblioteca, configurar parâmetros, exportar configurações, obter informações sobre a biblioteca e emitir NFSe a partir de arquivos XML.
A classe ACBrNFSe oferece os seguintes métodos:
- Emitir NFSe a partir de arquivos XML.
"""
class ACBrNFSeMT:

    """
    Cria uma instância da classe ACBrNFSe.
    :param libraryPath: Caminho para a biblioteca ACBrLibNFSe.
    :param arquivoINI: Caminho para o arquivo de configuração INI.
    :param chaveCrypt: Chave de criptografia (opcional).
    """
    def __init__(self, libraryPath, arquivoINI, chaveCrypt=""):
        self._libraryPath = libraryPath
        self.arquivoINI = arquivoINI
        self.chaveCrypt = chaveCrypt
        self._lib = carregar_acbrlib_nfe(libraryPath)
        self._plibHandle = ctypes.c_void_p()
    
    def __del__(self):
        self.finalizar()
    
    def inicializar(self):
        result = self._lib.NFSE_Inicializar(ctypes.byref(self._plibHandle), self.arquivoINI.encode('utf-8'), self.chaveCrypt.encode('utf-8'))
        if result != 0:
            raise Exception(f"Erro ao inicializar: {result}")

    def finalizar(self):
        if self._plibHandle.value is not None:
            result = self._lib.NFSE_Finalizar(self._plibHandle)
            self._plibHandle = ctypes.c_void_p() # Reinicia o ponteiro para None
            return result

    def configExportar(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConfigExportar(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def configGravarValor(self, eSessao, eChave, eValor):
        result = self._lib.NFSE_ConfigGravarValor(self._plibHandle, eSessao.encode('utf-8'), eChave.encode('utf-8'), eValor.encode('utf-8'))
        self._checkResult(result)
        return result


    def nome(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_Nome(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def versao(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_Versao(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def configGravar(self, eArquivoINI = None):
        if eArquivoINI is None:
            eArquivoINI = self.arquivoINI
        result = self._lib.NFSE_ConfigGravar(self._plibHandle,eArquivoINI.encode('utf-8'))
        self._checkResult(result)
        return result

    def _ultimoRetorno(self, size = TAMANHO_BUFFER_PADRAO):
        buffer = ctypes.create_string_buffer(size)
        size_out = ctypes.c_int(size)
        result = self._lib.NFSE_UltimoRetorno(self._plibHandle, buffer, ctypes.byref(size_out))
        return buffer, size_out.value

    #  metodo auxiliar para verificar se o tamanho do buffer é suficiente
    def _isRequiredBufferSize(self, size):
        return size > TAMANHO_BUFFER_PADRAO

    # metodo auxiliar para verificar o conteudo do buffer
    def _checkBuffer(self,buffer,requiredBufferSize):
        newSize = requiredBufferSize
        if self._isRequiredBufferSize(requiredBufferSize):
            newSize = int(requiredBufferSize * 1.3)
            newBuffer, size = self._ultimoRetorno(newSize)
            return newBuffer.value.decode('utf-8')
        return buffer.value.decode('utf-8')

    def _checkResult(self, result):
        if result < 0:
            erroMessage = self.ultimoRetorno()
            raise Exception(f"Erro: {result} - {erroMessage}")
        
    def ultimoRetorno(self):
        buffer, size = self._ultimoRetorno()
        return self._checkBuffer(buffer, size)

    def carregarINI(self, eArquivoINI):
        result = self._lib.NFSE_CarregarINI(self._plibHandle, eArquivoINI.encode('utf-8'))
        self._checkResult(result)
        return result

    def emitir(self, aLote, modoEnvio, bImprimir = False):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_Emitir(self._plibHandle, aLote.encode("utf-8"), modoEnvio, bImprimir, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def openSSLInfo(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_OpenSSLInfo(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def configImportar(self, eArqConfig):
        result = self._lib.NFSE_ConfigImportar(self._plibHandle, eArqConfig.encode('utf-8'))
        self._checkResult(result)
        return result

    def configLer(self, eArqConfig):
        result = self._lib.NFSE_ConfigLer(self._plibHandle, eArqConfig.encode('utf-8'))
        self._checkResult(result)
        return result

    def configLerValor(self, eSessao, eChave):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConfigLerValor(self._plibHandle, eSessao.encode('utf-8'), eChave.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def carregarXML(self, eArquivoOuXML):
        result = self._lib.NFSE_CarregarXML(self._plibHandle, eArquivoOuXML.encode('utf-8'))
        self._checkResult(result)
        return result

    def carregarLoteXML(self, eArquivoOuXML):
        result = self._lib.NFSE_CarregarLoteXML(self._plibHandle, eArquivoOuXML.encode('utf-8'))
        self._checkResult(result)
        return result

    def obterXml(self, AIndex):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ObterXml(self._plibHandle, AIndex, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def obterXmlRps(self, AIndex):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ObterXmlRps(self._plibHandle, AIndex, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def gravarXml(self, AIndex, eNomeArquivo, ePathArquivo):
        result = self._lib.NFSE_GravarXml(self._plibHandle, AIndex, eNomeArquivo.encode('utf-8'), ePathArquivo.encode('utf-8'))
        self._checkResult(result)
        return result

    def obterIni(self, AIndex):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ObterIni(self._plibHandle, AIndex, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def gravarIni(self, AIndex, eNomeArquivo, ePathArquivo):
        result = self._lib.NFSE_GravarIni(self._plibHandle, AIndex, eNomeArquivo.encode('utf-8'), ePathArquivo.encode('utf-8'))
        self._checkResult(result)
        return result

    def obterCertificados(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ObterCertificados(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def cancelar(self, aInfCancelamentoNFSe):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_Cancelar(self._plibHandle, aInfCancelamentoNFSe.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def substituirNFSe(self, aNumeroNFSe, aSerieNFSe, aCodigoCancelamento, aMotivoCancelamento, aNumeroLote, aCodigoVerificacao):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_SubstituirNFSe(self._plibHandle, aNumeroNFSe.encode('utf-8'), aSerieNFSe.encode('utf-8'), aCodigoCancelamento.encode('utf-8'), aMotivoCancelamento.encode('utf-8'), aNumeroLote.encode('utf-8'), aCodigoVerificacao.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def linkNFSe(self, aNumeroNFSe, aCodigoVerificacao, aChaveAcesso, aValorServico):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_LinkNFSe(self._plibHandle, aNumeroNFSe.encode('utf-8'), aCodigoVerificacao.encode('utf-8'), aChaveAcesso.encode('utf-8'), aValorServico.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def gerarLote(self, aLote, aQtdMaximaRps, aModoEnvio):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_GerarLote(self._plibHandle, aLote.encode('utf-8'), aQtdMaximaRps, aModoEnvio, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def gerarToken(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_GerarToken(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarSituacao(self, AProtocolo, ANumLote):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarSituacao(self._plibHandle, AProtocolo.encode('utf-8'), ANumLote.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarLoteRps(self, AProtocolo, ANumLote):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarLoteRps(self._plibHandle, AProtocolo.encode('utf-8'), ANumLote.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSePorRps(self, ANumeroRps, ASerie, ATipo, ACodigoVerificacao):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSePorRps(self._plibHandle, ANumeroRps.encode('utf-8'), ASerie.encode('utf-8'), ATipo.encode('utf-8'), ACodigoVerificacao.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSePorNumero(self, ANumero, APagina):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSePorNumero(self._plibHandle, ANumero.encode('utf-8'), APagina, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSePorPeriodo(self, aDataInicial, aDataFinal, aPagina, aNumeroLote, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSePorPeriodo(self._plibHandle, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aPagina, aNumeroLote.encode('utf-8'), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSePorFaixa(self, aNumeroInicial, aNumeroFinal, aPagina):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSePorFaixa(self._plibHandle, aNumeroInicial.encode('utf-8'), aNumeroFinal.encode('utf-8'), aPagina, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeGenerico(self, aInfConsultaNFSe):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeGenerico(self._plibHandle, aInfConsultaNFSe.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarLinkNFSe(self, aInfConsultaLinkNFSe):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarLinkNFSe(self._plibHandle, aInfConsultaLinkNFSe.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def enviarEmail(self, ePara, eXmlNFSe, AEnviaPDF, eAssunto="", eCC="", eAnexos="", eMensagem=""):
        result = self._lib.NFSE_EnviarEmail(self._plibHandle, ePara.encode('utf-8'), eXmlNFSe.encode('utf-8'), AEnviaPDF, eAssunto.encode('utf-8'), eCC.encode('utf-8'), eAnexos.encode('utf-8'), eMensagem.encode('utf-8'))
        self._checkResult(result)
        return result

    def imprimir(self, cImpressora="", nNumCopias=1, bGerarPDF="0", bMostrarPreview="0", cCancelada="0"):
        result = self._lib.NFSE_Imprimir(self._plibHandle, cImpressora.encode('utf-8'), nNumCopias, bGerarPDF.encode('utf-8'), bMostrarPreview.encode('utf-8'), cCancelada.encode('utf-8'))
        self._checkResult(result)
        return result

    def imprimirPDF(self):
        result = self._lib.NFSE_ImprimirPDF(self._plibHandle)
        self._checkResult(result)
        return result

    def salvarPDF(self):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_SalvarPDF(self._plibHandle, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoPrestadoPorNumero(self, aNumero, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoPrestadoPorNumero(self._plibHandle, aNumero.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoPrestadoPorPeriodo(self, aDataInicial, aDataFinal, aPagina, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoPrestadoPorPeriodo(self._plibHandle, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aPagina, aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoPrestadoPorTomador(self, aCNPJ, aInscMun, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoPrestadoPorTomador(self._plibHandle, aCNPJ.encode('utf-8'), aInscMun.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoPrestadoPorIntermediario(self, aCNPJ, aInscMun, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoPrestadoPorIntermediario(self._plibHandle, aCNPJ.encode('utf-8'), aInscMun.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoTomadoPorNumero(self, aNumero, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoTomadoPorNumero(self._plibHandle, aNumero.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoTomadoPorPrestador(self, aCNPJ, aInscMun, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoTomadoPorPrestador(self._plibHandle, aCNPJ.encode('utf-8'), aInscMun.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoTomadoPorTomador(self, aCNPJ, aInscMun, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoTomadoPorTomador(self._plibHandle, aCNPJ.encode('utf-8'), aInscMun.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoTomadoPorPeriodo(self, aDataInicial, aDataFinal, aPagina, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoTomadoPorPeriodo(self._plibHandle, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aPagina, aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSeServicoTomadoPorIntermediario(self, aCNPJ, aInscMun, aPagina, aDataInicial, aDataFinal, aTipoPeriodo):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSeServicoTomadoPorIntermediario(self._plibHandle, aCNPJ.encode('utf-8'), aInscMun.encode('utf-8'), aPagina, _paraDataDelphi(aDataInicial), _paraDataDelphi(aDataFinal), aTipoPeriodo, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def enviarEvento(self, aInfEvento):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_EnviarEvento(self._plibHandle, aInfEvento.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarDPSPorChave(self, aChaveDPS):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarDPSPorChave(self._plibHandle, aChaveDPS.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarNFSePorChave(self, aChaveNFSe):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarNFSePorChave(self._plibHandle, aChaveNFSe.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarEvento(self, aChave, aTipoEvento, aNumSeq):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarEvento(self._plibHandle, aChave.encode('utf-8'), aTipoEvento, aNumSeq, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def consultarDFe(self, aNSU):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ConsultarDFe(self._plibHandle, aNSU, buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)

    def obterDANFSE(self, aChaveNFSe):
        buffer = ctypes.create_string_buffer(TAMANHO_BUFFER_PADRAO)
        size = ctypes.c_int(TAMANHO_BUFFER_PADRAO)
        result = self._lib.NFSE_ObterDANFSE(self._plibHandle, aChaveNFSe.encode('utf-8'), buffer, ctypes.byref(size))
        self._checkResult(result)
        return self._checkBuffer(buffer, size.value)