#!/usr/bin/env python3
from dotenv import load_dotenv
import os
import platform
from acbrlib_nfse import ACBrNFSeMT

# funcao auxiliar para configurar a secao DFe
def configurarSecaoNFSe(nfse :'ACBrNFSeMT'):

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
def configuraSecaoDFe(nfse:'ACBrNFSeMT'):
    senha = os.getenv('PFX_PASSWORD', '')
    dadosPFX = os.getenv('PFX_DATA', '')
    #nfse.configGravarValor("DFe", "ArquivoPFX", pathCert);
    nfse.configGravarValor("DFe", "DadosPFX", dadosPFX);
    nfse.configGravarValor("DFe", "Senha", senha);
    nfse.configGravarValor("DFe", "SSLCryptLib", "1")
    nfse.configGravarValor("DFe", "SSLHttpLib", "3")
    nfse.configGravarValor("DFe", "SSLXmlSignLib", "4")

# funcao auxiliar para aplicar as configuracoes

#função auxiliar para configurar a secao principal
def configuraSecaoPrincipal(nfse:'ACBrNFSeMT'):
    nfse.configGravarValor("Principal", "LogPath",logPath)
    nfse.configGravarValor("Principal", "LogNivel", "4")


def aplicarConfiguracoes(nfse:'ACBrNFSeMT'):
    if nfse is None:
        raise Exception("ACBrLibNFSe não inicializado")
   
    nfse.inicializar()
    configuraSecaoPrincipal(nfse)
    configurarSecaoNFSe(nfse)
    configuraSecaoDFe(nfse)
    nfse.configGravar();

# funcao auxiliar para normalizar os nomes da arquitetura
# Windows/Linux podem retornar diferentes 
def getArch():
    arch = platform.machine().lower()
    if (  ( arch == "amd64" ) or (arch == "x86_64")):
        return "x86_64"
    elif ( arch == "arm64" or arch == "aarch64"):
        return "arm64"
    return arch

# funcao auxiliar para obter o caminho da biblioteca ACBrLibNFSe
def getLibraryPath():

    arch = getArch()
    libPath = ""
    if os.name == 'nt':
        libPath = os.path.join(os.path.dirname(__file__),'lib', arch, "ACBrNFSe64.dll")
    else:
        libPath = os.path.join(os.path.dirname(__file__), 'lib',arch, "libacbrnfse64.so")

    if not ( os.path.isfile(libPath)) :
        raise Exception( libPath +  "nao existe")
    return libPath


load_dotenv()  # Carrega as variáveis de ambiente do arquivo .env

pathACBrLibNFSe = getLibraryPath()
eArqConfig = "[Memory]"
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
pathExemploIniDPS = os.path.join(os.path.dirname(__file__), "data", "notas", "ini-dps-funcional.ini")


# cria uma instancia da classe ACBrNFSe
nfse = ACBrNFSeMT (pathACBrLibNFSe, eArqConfig, "")
strResult = ""
try:
    nfse.inicializar()
    aplicarConfiguracoes(nfse)
    nfse.carregarINI(pathExemploIniDPS)
    strResult = nfse.emitir("1",0,False)
    #print(configExportado)
    print("Resultado da emissão: " + strResult)
except Exception as e:
    print("Erro: " + str(e))
finally:
    nfse.finalizar() 