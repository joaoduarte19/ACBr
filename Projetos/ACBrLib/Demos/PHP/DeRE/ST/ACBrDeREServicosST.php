<?php
/* {******************************************************************************}
// { Projeto: Componentes ACBr                                                    }
// {  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
// { mentos de Automação Comercial utilizados no Brasil                           }
// {                                                                              }
// { Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
// {                                                                              }
// { Colaboradores nesse arquivo: Renato Rubinho                                  }
// {                                                                              }
// {  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
// { Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
// {                                                                              }
// {  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
// { sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
// { Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
// { qualquer versão posterior.                                                   }
// {                                                                              }
// {  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
// { NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
// { ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
// { do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
// {                                                                              }
// {  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
// { com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
// { no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
// { Você também pode obter uma copia da licença em:                              }
// { http://www.opensource.org/licenses/lgpl-license.php                          }
// {                                                                              }
// { Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
// {       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
// {******************************************************************************}
*/
header('Content-Type: application/json; charset=UTF-8');

include 'ACBrDeREST.php';
include '../../ACBrComum/ACBrComum.php';

$nomeLib = "ACBrDeRE";
$metodo = $_POST['metodo'];

if (ValidaFFI() != 0)
    exit;

$dllPath = CarregaDll(__DIR__, $nomeLib);

if ($dllPath == -10)
    exit;

$importsPath = CarregaImports(__DIR__, $nomeLib, 'ST');

if ($importsPath == -10)
    exit;

$iniPath = CarregaIniPath(__DIR__, $nomeLib);

$processo = "file_get_contents";
$ffi = CarregaContents($importsPath, $dllPath);

try {
    $resultado = "";
    $processo = "Inicializar";

    $processo = "DeRE_Inicializar";
    if (Inicializar($ffi, $iniPath) != 0)
        exit;

    if ($metodo == "salvarConfiguracoes") {
        $processo = $metodo . "/" . "DeRE_ConfigGravarValor";

        if (ConfigGravarValor($ffi, "Principal", "LogPath", $_POST['LogPath']) != 0) exit;
        if (ConfigGravarValor($ffi, "Principal", "LogNivel", $_POST['LogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "DeRE", "ExibirErroSchema", $_POST['exibirErroSchema']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "FormatoAlerta", $_POST['formatoAlerta']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "FormaEmissao", $_POST['formaEmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "VersaoDF", $_POST['versaoDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "RetirarAcentos", $_POST['retirarAcentos']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SalvarGer", $_POST['SalvarGer']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "PathSalvar", $_POST['pathSalvar']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "PathSchemas", $_POST['pathSchemas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SSLType", $_POST['SSLType']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "Timeout", $_POST['timeout']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "Ambiente", $_POST['ambiente']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "Visualizar", $_POST['visualizar']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SalvarWS", $_POST['SalvarWS']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "AjustaAguardaConsultaRet", $_POST['ajustaAguardaConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "AguardarConsultaRet", $_POST['aguardarConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "Tentativas", $_POST['tentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "IntervaloTentativas", $_POST['intervaloTentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SalvarArq", $_POST['SalvarArq']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SepararPorMes", $_POST['SepararPorMes']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "AdicionarLiteral", $_POST['AdicionarLiteral']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SepararPorCNPJ", $_POST['SepararPorCNPJ']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "SepararPorModelo", $_POST['SepararPorModelo']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "PathDeRE", $_POST['PathDeRE']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "IdContribuinte", $_POST['IdContribuinte']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "ClientId", $_POST['ClientId']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "ClientSecret", $_POST['ClientSecret']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "Token", $_POST['Token']) != 0) exit;
        if (ConfigGravarValor($ffi, "DeRE", "TokenExpira", $_POST['TokenExpira']) != 0) exit;

        if (ConfigGravarValor($ffi, "Proxy", "Servidor", $_POST['proxyServidor']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Porta", $_POST['proxyPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Usuario", $_POST['proxyUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Senha", $_POST['proxySenha']) != 0) exit;

        if (ConfigGravarValor($ffi, "DFe", "UF", $_POST['UF']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLCryptLib", $_POST['SSLCryptLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLHttpLib", $_POST['SSLHttpLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLXmlSignLib", $_POST['SSLXmlSignLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "ArquivoPFX", $_POST['ArquivoPFX']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "DadosPFX", $_POST['DadosPFX']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "Senha", $_POST['senhaCertificado']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "NumeroSerie", $_POST['NumeroSerie']) != 0) exit;

        $resultado = "Configurações salvas com sucesso.";
    }

    if ($metodo == "carregarConfiguracoes") {
        $processo = $metodo . "/" . "DeRE_ConfigLer";

        if (ConfigLerValor($ffi, "Principal", "LogPath", $LogPath) != 0) exit;
        if (ConfigLerValor($ffi, "Principal", "LogNivel", $LogNivel) != 0) exit;

        if (ConfigLerValor($ffi, "DeRE", "ExibirErroSchema", $exibirErroSchema) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "FormatoAlerta", $formatoAlerta) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "FormaEmissao", $formaEmissao) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "VersaoDF", $versaoDF) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "RetirarAcentos", $retirarAcentos) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SalvarGer", $SalvarGer) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "PathSalvar", $pathSalvar) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "PathSchemas", $pathSchemas) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SSLType", $SSLType) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "Timeout", $timeout) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "Ambiente", $ambiente) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "Visualizar", $visualizar) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SalvarWS", $SalvarWS) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "AjustaAguardaConsultaRet", $ajustaAguardaConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "AguardarConsultaRet", $aguardarConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "Tentativas", $tentativas) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "IntervaloTentativas", $intervaloTentativas) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SalvarArq", $SalvarArq) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SepararPorMes", $SepararPorMes) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "AdicionarLiteral", $AdicionarLiteral) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SepararPorCNPJ", $SepararPorCNPJ) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "SepararPorModelo", $SepararPorModelo) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "PathDeRE", $PathDeRE) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "IdContribuinte", $IdContribuinte) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "ClientId", $ClientId) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "ClientSecret", $ClientSecret) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "Token", $Token) != 0) exit;
        if (ConfigLerValor($ffi, "DeRE", "TokenExpira", $TokenExpira) != 0) exit;

        if (ConfigLerValor($ffi, "Proxy", "Servidor", $proxyServidor) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Porta", $proxyPorta) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Usuario", $proxyUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Senha", $proxySenha) != 0) exit;

        if (ConfigLerValor($ffi, "DFe", "UF", $UF) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLCryptLib", $SSLCryptLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLHttpLib", $SSLHttpLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLXmlSignLib", $SSLXmlSignLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "ArquivoPFX", $ArquivoPFX) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "DadosPFX", $DadosPFX) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "Senha", $senhaCertificado) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "NumeroSerie", $NumeroSerie) != 0) exit;

        $processo = $metodo . "/" . "responseData";
        $responseData = [
            'dados' => [
                'LogPath' => $LogPath ?? '',
                'LogNivel' => $LogNivel ?? '',

                'exibirErroSchema' => $exibirErroSchema ?? '',
                'formatoAlerta' => $formatoAlerta ?? '',
                'formaEmissao' => $formaEmissao ?? '',
                'versaoDF' => $versaoDF ?? '',
                'retirarAcentos' => $retirarAcentos ?? '',
                'SalvarGer' => $SalvarGer ?? '',
                'pathSalvar' => $pathSalvar ?? '',
                'pathSchemas' => $pathSchemas ?? '',
                'SSLType' => $SSLType ?? '',
                'timeout' => $timeout ?? '',
                'ambiente' => $ambiente ?? '',
                'visualizar' => $visualizar ?? '',
                'SalvarWS' => $SalvarWS ?? '',
                'ajustaAguardaConsultaRet' => $ajustaAguardaConsultaRet ?? '',
                'aguardarConsultaRet' => $aguardarConsultaRet ?? '',
                'tentativas' => $tentativas ?? '',
                'intervaloTentativas' => $intervaloTentativas ?? '',
                'SalvarArq' => $SalvarArq ?? '',
                'SepararPorMes' => $SepararPorMes ?? '',
                'AdicionarLiteral' => $AdicionarLiteral ?? '',
                'SepararPorCNPJ' => $SepararPorCNPJ ?? '',
                'SepararPorModelo' => $SepararPorModelo ?? '',
                'PathDeRE' => $PathDeRE ?? '',
                'IdContribuinte' => $IdContribuinte ?? '',
                'ClientId' => $ClientId ?? '',
                'ClientSecret' => $ClientSecret ?? '',
                'Token' => $Token ?? '',
                'TokenExpira' => $TokenExpira ?? '',

                'proxyServidor' => $proxyServidor ?? '',
                'proxyPorta' => $proxyPorta ?? '',
                'proxyUsuario' => $proxyUsuario ?? '',
                'proxySenha' => $proxySenha ?? '',

                'UF' => $UF ?? '',
                'SSLCryptLib' => $SSLCryptLib ?? '',
                'SSLHttpLib' => $SSLHttpLib ?? '',
                'SSLXmlSignLib' => $SSLXmlSignLib ?? '',
                'ArquivoPFX' => $ArquivoPFX ?? '',
                'DadosPFX' => $DadosPFX ?? '',
                'senhaCertificado' => $senhaCertificado ?? '',
                'NumeroSerie' => $NumeroSerie ?? ''
            ]
        ];
    }

    if ($metodo == "OpenSSLInfo") {
        $processo = "DeRE_OpenSSLInfo";

        if (OpenSSLInfo($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterCertificados") {
        $processo = "DeRE_ObterCertificados";

        if (ObterCertificados($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterToken") {
        $processo = "DeRE_ObterToken";

        if (ObterToken($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "LimparDados") {
        $processo = "DeRE_LimparDados";

        if (LimparDados($ffi, isset($_POST['eCNPJBase']) ? $_POST['eCNPJBase'] : '', $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterIniEventos") {
        $processo = "DeRE_ObterIniEventos";

        if (ObterIniEventos($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CriarEnviarDeREIni") {
        $processo = "DeRE_CriarEnviarDeREIni";

        if (CriarEnviarDeRE($ffi, $_POST['eArqIni'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ConsultarProtocolo") {
        $processo = "DeRE_ConsultarProtocolo";

        if (ConsultarProtocolo($ffi, $_POST['eProtocolo'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CriarEnviarDeREXml") {
        $processo = "DeRE_CarregarXMLEventoDeRE";

        if (CarregarXMLEventoDeRE($ffi, $_POST['eArquivoOuXML'], $resultado) != 0) {
            exit;
        }

        $processo = "DeRE_EnviarDeRE";

        if (EnviarDeRE($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ValidarXml") {
        $processo = "DeRE_ValidarXml";

        if (CarregarXMLEventoDeRE($ffi, $_POST['eArquivoXML'], $resultado) != 0) {
            exit;
        }

        $processo = "DeRE_Validar";

        if (Validar($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo != "carregarConfiguracoes") {
        $processo = "responseData";
        $responseData = [
            'mensagem' => $resultado
        ];
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    echo json_encode(["mensagem" => "Exceção[$processo]: $erro"]);
    exit;
}

try {
    if ($processo != "DeRE_Inicializar") {
        $processo = "DeRE_Finalizar";
        if (Finalizar($ffi) != 0)
            exit;
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    echo json_encode(["mensagem" => "Exceção[$processo]: $erro"]);
    exit;
}

echo json_encode($responseData);
