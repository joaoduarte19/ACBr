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

include 'ACBrCIOTST.php';
include '../../ACBrComum/ACBrComum.php';

$nomeLib = "ACBrCIOT";
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
    $responseData = [];
    $processo = "Inicializar";
    $tokenRetornado = $_POST['integradoraToken'];

    $processo = "CIOT_Inicializar";
    if (Inicializar($ffi, $iniPath) != 0)
        exit;

    if ($metodo == "salvarConfiguracoes") {
        $processo = $metodo . "/" . "CIOT_ConfigGravarValor";

        if (ConfigGravarValor($ffi, "Principal", "LogPath", $_POST['LogPath']) != 0) exit;
        if (ConfigGravarValor($ffi, "Principal", "LogNivel", $_POST['LogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "CIOT", "ExibirErroSchema", $_POST['exibirErroSchema']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "FormatoAlerta", $_POST['formatoAlerta']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "FormaEmissao", $_POST['formaEmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "versaoDF", $_POST['versaoDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "RetirarAcentos", $_POST['retirarAcentos']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SalvarGer", $_POST['SalvarGer']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "PathSalvar", $_POST['pathSalvar']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SSLType", $_POST['SSLType']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "Timeout", $_POST['timeout']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "Ambiente", $_POST['ambiente']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SalvarWS", $_POST['SalvarWS']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "AjustaAguardaConsultaRet", $_POST['ajustaAguardaConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "AguardarConsultaRet", $_POST['aguardarConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "Tentativas", $_POST['tentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "IntervaloTentativas", $_POST['intervaloTentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SalvarArq", $_POST['SalvarArq']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SepararPorMes", $_POST['SepararPorMes']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "AdicionarLiteral", $_POST['AdicionarLiteral']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "EmissaoPathCIOT", $_POST['EmissaoPathCIOT']) != 0) exit;
        if (ConfigGravarValor($ffi, "CIOT", "SepararPorCNPJ", $_POST['SepararPorCNPJ']) != 0) exit;

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

        if (ConfigGravarValor($ffi, "Integradora", "IntegradoraCIOT", $_POST['integradoraCIOT']) != 0) exit;
        if (ConfigGravarValor($ffi, "Integradora", "IntegradoraUsuario", $_POST['integradoraUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Integradora", "IntegradoraSenha", $_POST['integradoraSenha']) != 0) exit;
        if (ConfigGravarValor($ffi, "Integradora", "IntegradoraHash", $_POST['integradoraHash']) != 0) exit;
        if (ConfigGravarValor($ffi, "Integradora", "IntegradoraToken", $_POST['integradoraToken']) != 0) exit;

        $resultado = "Configurações salvas com sucesso.";
    }

    if ($metodo == "carregarConfiguracoes") {
        $processo = $metodo . "/" . "CIOT_ConfigLer";

        if (ConfigLerValor($ffi, "Principal", "LogPath", $LogPath) != 0) exit;
        if (ConfigLerValor($ffi, "Principal", "LogNivel", $LogNivel) != 0) exit;
  
        if (ConfigLerValor($ffi, "CIOT", "ExibirErroSchema", $exibirErroSchema) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "FormatoAlerta", $formatoAlerta) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "FormaEmissao", $formaEmissao) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "versaoDF", $versaoDF) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "RetirarAcentos", $retirarAcentos) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SalvarGer", $SalvarGer) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "PathSalvar", $pathSalvar) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SSLType", $SSLType) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "Timeout", $timeout) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "Ambiente", $ambiente) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SalvarWS", $SalvarWS) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "AjustaAguardaConsultaRet", $ajustaAguardaConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "AguardarConsultaRet", $aguardarConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "Tentativas", $tentativas) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "IntervaloTentativas", $intervaloTentativas) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SalvarArq", $SalvarArq) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SepararPorMes", $SepararPorMes) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "AdicionarLiteral", $AdicionarLiteral) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "EmissaoPathCIOT", $EmissaoPathCIOT) != 0) exit;
        if (ConfigLerValor($ffi, "CIOT", "SepararPorCNPJ", $SepararPorCNPJ) != 0) exit;

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

        if (ConfigLerValor($ffi, "Integradora", "IntegradoraCIOT", $integradoraCIOT) != 0) exit;
        if (ConfigLerValor($ffi, "Integradora", "IntegradoraUsuario", $integradoraUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Integradora", "IntegradoraSenha", $integradoraSenha) != 0) exit;
        if (ConfigLerValor($ffi, "Integradora", "IntegradoraHash", $integradoraHash) != 0) exit;
        if (ConfigLerValor($ffi, "Integradora", "IntegradoraToken", $integradoraToken) != 0) exit;

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
                'SSLType' => $SSLType ?? '',
                'timeout' => $timeout ?? '',
                'ambiente' => $ambiente ?? '',
                'SalvarWS' => $SalvarWS ?? '',
                'ajustaAguardaConsultaRet' => $ajustaAguardaConsultaRet ?? '',
                'aguardarConsultaRet' => $aguardarConsultaRet ?? '',
                'tentativas' => $tentativas ?? '',
                'intervaloTentativas' => $intervaloTentativas ?? '',
                'SalvarArq' => $SalvarArq ?? '',
                'SepararPorMes' => $SepararPorMes ?? '',
                'AdicionarLiteral' => $AdicionarLiteral ?? '',
                'EmissaoPathCIOT' => $EmissaoPathCIOT ?? '',
                'SepararPorCNPJ' => $SepararPorCNPJ ?? '',

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
                'NumeroSerie' => $NumeroSerie ?? '',

                'integradoraCIOT' => $integradoraCIOT ?? '',
                'integradoraUsuario' => $integradoraUsuario ?? '',
                'integradoraSenha' => $integradoraSenha ?? '',
                'integradoraHash' => $integradoraHash ?? '',
                'integradoraToken' => $integradoraToken ?? ''
            ]
        ];
    }

    if ($metodo == "OpenSSLInfo") {
        $processo = "CIOT_OpenSSLInfo";

        if (OpenSSLInfo($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterCertificados") {
        $processo = "NFCOM_ObterCertificados";

        if (ObterCertificados($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "Enviar") {
        if ($_POST['tipoArquivo'] == "xml") {
            $processo = "CIOT_CarregarXml";

            if (CarregarXmlCIOT($ffi, $_POST['AeArquivoCIOT'], $resultado) != 0) {
                exit;
            }
        } else {
            $processo = "CIOT_CarregarINI";

            if (CarregarINI($ffi, $_POST['AeArquivoCIOT'], $resultado) != 0) {
                exit;
            }
        }

        $processo = "CIOT_Enviar";

        if (Enviar(
            $ffi,
            $resultado
        ) != 0) {
            exit;
        }

        if (isset($resultado) && str_contains($resultado, "[Envio]")) {
            $config = parseIniToStr($resultado);

            if ($config !== false && isset($config['Envio']['Token'])) {
                $novoToken = $config['Envio']['Token'];

                if (!empty($novoToken) && ($novoToken !== $tokenRetornado)) {
                    $tokenRetornado = $novoToken;

                    ConfigGravarValor($ffi, "Integradora", "IntegradoraToken", $tokenRetornado);
                }
            }
        }
    }
    
    if ($metodo != "carregarConfiguracoes") {
        $processo = "responseData";
        $responseData = [
            'mensagem' => $resultado,
            'tokenRetornado' => $tokenRetornado
        ];
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    $responseData = ["mensagem" => "Exceção[$processo]: $erro"];
}

try {
    if ($processo != "CIOT_Inicializar") {
        $processo = "CIOT_Finalizar";
        if (Finalizar($ffi) != 0)
            $responseData = ["mensagem" => "Exceção[$processo]: Erro ao finalizar a biblioteca"];
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    $responseData = ["mensagem" => "Exceção[$processo]: $erro"];
}

if (!isset($responseData)) {
    $responseData = ["mensagem" => "Sem retorno"];
}

echo json_encode($responseData);
