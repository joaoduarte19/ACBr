#include 'acbrlib.ch'

#ifdef __PLATFORM__WINDOWS
#define ACBrLIB 'ACBrConsultaCNPJ32.dll'
#else
#ifdef __PLATFORM__LINUX
#define ACBrLIB 'libacbrconsultacnpj64.so'
#else
#error ACBrLIB-FALTA DEFINICAO: PLATFORM__?
#endif
#endif

CREATE CLASS ACBrConsultaCNPJ
    HIDDEN:
    VAR hHandle

    METHOD CheckResult(hResult)
    METHOD ProcessResult(buffer, bufferLen)

    VISIBLE:
    METHOD New(eArqConfig, eChaveCrypt) CONSTRUCTOR
    DESTRUCTOR  Destroy

    METHOD Nome()
    METHOD Versao()
    METHOD OpenSSLInfo()

    METHOD ConfigLer(eArqConfig)
    METHOD ConfigGravar(eArqConfig)
    METHOD ConfigLerValor(eSessao, eChave)
    METHOD ConfigGravarValor(eSessao, eChave, eValor)
    METHOD ConfigImportar(eArqConfig)
    METHOD ConfigExportar()

    METHOD Consultar(eCNPJ)

END CLASS

METHOD New(eArqConfig, eChaveCrypt) CLASS ACBrConsultaCNPJ
    local hResult, oErr

    eArqConfig := if(eArqConfig = nil, '', eArqConfig)
    eChaveCrypt := if(eChaveCrypt = nil, '', eChaveCrypt)

    ::hHandle := DllLoad(ACBrLIB)
    if EMPTY(::hHandle)
        oErr := ErrorNew()
        oErr:Severity := ES_ERROR
        oErr:Description := "Erro a carregar a dll [" + ACBrLIB + "]"
        Throw(oErr)
    endif
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_Inicializar", hb_StrToUTF8(eArqConfig), hb_StrToUTF8(eChaveCrypt))
    ::CheckResult(hResult)
RETURN Self

PROCEDURE Destroy CLASS ACBrConsultaCNPJ
    DllCall(::hHandle, DLL_OSAPI, "CNPJ_Finalizar")
    DllUnload(::hHandle)
RETURN

METHOD CheckResult(hResult) CLASS ACBrConsultaCNPJ
    local buffer, bufferLen, oErr
    if hResult >= 0
        RETURN nil
    endif

    bufferLen := STR_LEN
    buffer := Space(bufferLen)

    DllCall(::hHandle, DLL_OSAPI, "CNPJ_UltimoRetorno", @buffer, @bufferLen)
    if bufferLen > STR_LEN
        buffer := Space(bufferLen)
        DllCall(::hHandle, DLL_OSAPI, "CNPJ_UltimoRetorno", @buffer, @bufferLen)
    endif

    oErr := ErrorNew()
    oErr:Severity := ES_ERROR
    oErr:Description := hb_UTF8ToStr(buffer)
    Throw(oErr)
RETURN nil

METHOD ProcessResult(buffer, bufferLen) CLASS ACBrConsultaCNPJ
    if bufferLen > STR_LEN
        buffer := Space(bufferLen)
        DllCall(::hHandle, DLL_OSAPI, "CNPJ_UltimoRetorno", @buffer, @bufferLen)
    endif
RETURN buffer

METHOD Nome CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_Nome", @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))

METHOD Versao CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_Versao", @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))

METHOD OpenSSLInfo CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_OpenSSLInfo", @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))

METHOD ConfigLer(eArqConfig) CLASS ACBrConsultaCNPJ
    local hResult
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigLer", hb_StrToUTF8(eArqConfig))
    ::CheckResult(hResult)
RETURN nil

METHOD ConfigGravar(eArqConfig) CLASS ACBrConsultaCNPJ
    local hResult
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigGravar", hb_StrToUTF8(eArqConfig))
    ::CheckResult(hResult)
RETURN nil

METHOD ConfigLerValor(eSessao, eChave) CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigLerValor", hb_StrToUTF8(eSessao), hb_StrToUTF8(eChave), @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))

METHOD ConfigGravarValor(eSessao, eChave, eValor) CLASS ACBrConsultaCNPJ
    local hResult
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigGravarValor", hb_StrToUTF8(eSessao), hb_StrToUTF8(eChave), hb_StrToUTF8(eValor))
    ::CheckResult(hResult)
RETURN nil

METHOD ConfigImportar(eArqConfig) CLASS ACBrConsultaCNPJ
    local hResult
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigImportar", hb_StrToUTF8(eArqConfig))
    ::CheckResult(hResult)
RETURN nil

METHOD ConfigExportar CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_ConfigExportar", @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))

METHOD Consultar(eCNPJ) CLASS ACBrConsultaCNPJ
    local hResult, buffer, bufferLen
    bufferLen := STR_LEN
    buffer := Space(bufferLen)
    hResult := DllCall(::hHandle, DLL_OSAPI, "CNPJ_Consultar", hb_StrToUTF8(eCNPJ), @buffer, @bufferLen)
    ::CheckResult(hResult)
RETURN hb_UTF8ToStr( AllTrim( ::ProcessResult(buffer, bufferLen) ))
