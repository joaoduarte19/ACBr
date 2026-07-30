#!/usr/bin/env python3
from dotenv import load_dotenv
import os
import platform
from acbrlib_nfse import ACBrNFSeMT

# funcao auxiliar para configurar a secao DFe
def configurarSecaoNFSe(nfse):

    emitenteUser =  os.getenv('EMITENTE_USER', '')
    emitentePassword = os.getenv('EMITENTE_PASSWORD', '')
    
    nfse.configGravarValor("NFSe", "PathSchemas", pathSchemas);
    nfse.configGravarValor("NFSe", "IniServicos", pathIniServicos);

    nfse.configGravarValor("NFSe", "CodigoMunicipio", codigoMunicipio);

    nfse.configGravarValor("NFSe", "Ambiente", str(ambienteDeEmissao)); #0 produção 1 homologação)

    nfse.configGravarValor("NFSe", "LayoutNFSe", str(layoutNFSe));

    nfse.configGravarValor("NFSe", "PathSalvar", pathGeral);

    nfse.configGravarValor("NFSe", "PathGer", pathGeral);

    nfse.configGravarValor("NFSe", "PathRps", pathRps);

    nfse.configGravarValor("NFSe", "PathNFSe", pathNFse);

    nfse.configGravarValor("NFSe", "Emitente.WSUser", emitenteUser);

    nfse.configGravarValor("NFSe", "Emitente.WSSenha", emitentePassword);


# funcao auxiliar para configurar a secao DFe
def configuraSecaoDFe(nfse):
    senha = os.getenv('PFX_PASSWORD', '')
    dadosPFX = os.getenv('PFX_DATA', '')
    #nfse.configGravarValor("DFe", "ArquivoPFX", pathCert);
    nfse.configGravarValor("DFe", "DadosPFX", dadosPFX);
    nfse.configGravarValor("DFe", "Senha", senha);
    nfse.configGravarValor("DFe", "SSLCryptLib", "1")
    nfse.configGravarValor("DFe", "SSLHttpLib", "3")
    nfse.configGravarValor("DFe", "SSLXmlSignLib", "4")

# funcao auxiliar para aplicar as configuracoes

def aplicarConfiguracoes(nfse):
    if nfse is None:
        raise Exception("ACBrLibNFSe não inicializado")
   
    nfse.inicializar()
    configurarSecaoNFSe(nfse)
    configuraSecaoDFe(nfse)
    nfse.configGravar();

# funcao auxiliar para obter o caminho da biblioteca ACBrLibNFSe
def getLibraryPath():

    arch = platform.machine().lower()
    if os.name == 'nt':
        return os.path.join(os.path.dirname(__file__),'lib', arch, "ACBrNFSe64.dll")
    else:
        return os.path.join(os.path.dirname(__file__), 'lib',arch, "libacbrnfse64.so")


load_dotenv()  # Carrega as variáveis de ambiente do arquivo .env

pathACBrLibNFSe = getLibraryPath()
eArqConfig = os.path.join(os.path.dirname(__file__), "data", "config", "acbrlib.ini")
logPath = os.path.join(os.path.dirname(__file__), "data", "log")
eChaveCrypt = ""
#pathCert = os.path.join(os.path.dirname(__file__), "data", "cert", "cert.pfx")
pathSchemas = os.path.join(os.path.dirname(__file__), "data", "Schemas", "NFSe")
pathGeral = os.path.join(os.path.dirname(__file__), "data", "notas")
pathRps = os.path.join(os.path.dirname(__file__), "data", "notas", "rps")
pathNFse = os.path.join(os.path.dirname(__file__), "data", "notas", "nfse")
pathIniServicos = os.path.join(os.path.dirname(__file__), "data", "config", "ACBrNFSeXServicos.ini")
codigoMunicipio = "3554003" # Tatui/sp
ambienteDeEmissao = 1 #0 produção 1 homologação
layoutNFSe = 0 


# cria uma instancia da classe ACBrNFSe
nfse = ACBrNFSeMT (pathACBrLibNFSe, eArqConfig, "")
strResult = ""
try:
    nfse.inicializar()
    aplicarConfiguracoes(nfse)
    #configExportado = nfse.configExportar()
    #'nfse.emitir("./nfse.xml")
    nfse.carregarINI("/tmp/ini-dps-funcional.ini")
    strResult = nfse.emitir("1",0,False)
    #print(configExportado)
    # print(nfse.nome() + " - " + nfse.versao())
    print("Resultado da emissão: " + strResult)
except Exception as e:
    print("Erro: " + str(e))
finally:
    nfse.finalizar() 


    