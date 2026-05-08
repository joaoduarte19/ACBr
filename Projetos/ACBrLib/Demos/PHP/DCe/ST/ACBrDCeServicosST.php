<?php
/* {******************************************************************************}
// { Projeto: Componentes ACBr                                                    }
// {  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
// { mentos de Automação Comercial utilizados no Brasil                           }
// {                                                                              }
// { Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
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

include 'ACBrDCeST.php';
include '../../ACBrComum/ACBrComum.php';

$nomeLib = "ACBrDCe";
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

    $processo = "DCE_Inicializar";
    if (Inicializar($ffi, $iniPath) != 0)
        exit;

    if ($metodo == "salvarConfiguracoes") {
        $processo = $metodo . "/" . "DCE_ConfigGravarValor";

        if (ConfigGravarValor($ffi, "Principal", "LogPath", $_POST['LogPath']) != 0) exit;
        if (ConfigGravarValor($ffi, "Principal", "LogNivel", $_POST['LogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "DCe", "ExibirErroSchema", $_POST['exibirErroSchema']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "FormatoAlerta", $_POST['formatoAlerta']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "FormaEmissao", $_POST['formaEmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "versaoDF", $_POST['versaoDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "RetirarAcentos", $_POST['retirarAcentos']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SalvarGer", $_POST['SalvarGer']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "PathSalvar", $_POST['pathSalvar']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "PathSchemas", $_POST['pathSchemas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SSLType", $_POST['SSLType']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "Timeout", $_POST['timeout']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "Ambiente", $_POST['ambiente']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SalvarWS", $_POST['SalvarWS']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "AjustaAguardaConsultaRet", $_POST['ajustaAguardaConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "AguardarConsultaRet", $_POST['aguardarConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "Tentativas", $_POST['tentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "IntervaloTentativas", $_POST['intervaloTentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SalvarArq", $_POST['SalvarArq']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SepararPorMes", $_POST['SepararPorMes']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "AdicionarLiteral", $_POST['AdicionarLiteral']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "EmissaoPathDCe", $_POST['EmissaoPathDCe']) != 0) exit;
        if (ConfigGravarValor($ffi, "DCe", "SepararPorCNPJ", $_POST['SepararPorCNPJ']) != 0) exit;

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

        if (ConfigGravarValor($ffi, "DACe", "PathLogo", $_POST['PathLogo']) != 0) exit;
        if (ConfigGravarValor($ffi, "DACe", "PathPDF", $_POST['PathPDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "DACe", "MargemDireita", $_POST['MargemDireita']) != 0) exit;
        if (ConfigGravarValor($ffi, "DACe", "MargemEsquerda", $_POST['MargemEsquerda']) != 0) exit;
        if (ConfigGravarValor($ffi, "DACe", "MargemSuperior", $_POST['MargemSuperior']) != 0) exit;
        if (ConfigGravarValor($ffi, "DACe", "MargemInferior", $_POST['MargemInferior']) != 0) exit;

        if (ConfigGravarValor($ffi, "Email", "Nome", $_POST['emailNome']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Conta", $_POST['emailConta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Servidor", $_POST['emailServidor']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Porta", $_POST['emailPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "SSL", $_POST['emailSSL']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "TLS", $_POST['emailTLS']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Usuario", $_POST['emailUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Senha", $_POST['emailSenha']) != 0) exit;
  
        $resultado = "Configurações salvas com sucesso.";
    }

    if ($metodo == "carregarConfiguracoes") {
        $processo = $metodo . "/" . "DCE_ConfigLer";

        if (ConfigLerValor($ffi, "Principal", "LogPath", $LogPath) != 0) exit;
        if (ConfigLerValor($ffi, "Principal", "LogNivel", $LogNivel) != 0) exit;

        if (ConfigLerValor($ffi, "DCe", "ExibirErroSchema", $exibirErroSchema) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "FormatoAlerta", $formatoAlerta) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "FormaEmissao", $formaEmissao) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "versaoDF", $versaoDF) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "RetirarAcentos", $retirarAcentos) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SalvarGer", $SalvarGer) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "PathSalvar", $pathSalvar) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "PathSchemas", $pathSchemas) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SSLType", $SSLType) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "Timeout", $timeout) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "Ambiente", $ambiente) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SalvarWS", $SalvarWS) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "AjustaAguardaConsultaRet", $ajustaAguardaConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "AguardarConsultaRet", $aguardarConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "Tentativas", $tentativas) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "IntervaloTentativas", $intervaloTentativas) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SalvarArq", $SalvarArq) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SepararPorMes", $SepararPorMes) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "AdicionarLiteral", $AdicionarLiteral) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "EmissaoPathDCe", $EmissaoPathDCe) != 0) exit;
        if (ConfigLerValor($ffi, "DCe", "SepararPorCNPJ", $SepararPorCNPJ) != 0) exit;

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

        if (ConfigLerValor($ffi, "DACe", "PathLogo", $PathLogo) != 0) exit;
        if (ConfigLerValor($ffi, "DACe", "PathPDF", $PathPDF) != 0) exit;
        if (ConfigLerValor($ffi, "DACe", "MargemDireita", $MargemDireita) != 0) exit;
        if (ConfigLerValor($ffi, "DACe", "MargemEsquerda", $MargemEsquerda) != 0) exit;
        if (ConfigLerValor($ffi, "DACe", "MargemSuperior", $MargemSuperior) != 0) exit;
        if (ConfigLerValor($ffi, "DACe", "MargemInferior", $MargemInferior) != 0) exit;

        if (ConfigLerValor($ffi, "Email", "Nome", $emailNome) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Conta", $emailConta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Servidor", $emailServidor) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Porta", $emailPorta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "SSL", $emailSSL) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "TLS", $emailTLS) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Usuario", $emailUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Senha", $emailSenha) != 0) exit;

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
                'SalvarWS' => $SalvarWS ?? '',
                'ajustaAguardaConsultaRet' => $ajustaAguardaConsultaRet ?? '',
                'aguardarConsultaRet' => $aguardarConsultaRet ?? '',
                'tentativas' => $tentativas ?? '',
                'intervaloTentativas' => $intervaloTentativas ?? '',
                'SalvarArq' => $SalvarArq ?? '',
                'SepararPorMes' => $SepararPorMes ?? '',
                'AdicionarLiteral' => $AdicionarLiteral ?? '',
                'EmissaoPathDCe' => $EmissaoPathDCe ?? '',
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

                'PathLogo' => $PathLogo ?? '',
                'PathPDF' => $PathPDF ?? '',
                'MargemDireita' => $MargemDireita ?? '',
                'MargemEsquerda' => $MargemEsquerda ?? '',
                'MargemSuperior' => $MargemSuperior ?? '',
                'MargemInferior' => $MargemInferior ?? '',

                'emailNome' => $emailNome ?? '',
                'emailConta' => $emailConta ?? '',
                'emailServidor' => $emailServidor ?? '',
                'emailPorta' => $emailPorta ?? '',
                'emailSSL' => $emailSSL ?? '',
                'emailTLS' => $emailTLS ?? '',
                'emailUsuario' => $emailUsuario ?? '',
                'emailSenha' => $emailSenha ?? ''
            ]
        ];
    }

    if ($metodo == "OpenSSLInfo") {
        $processo = "DCE_OpenSSLInfo";

        if (OpenSSLInfo($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "statusServico") {
        $processo = "DCE_StatusServico";

        if (StatusServico($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "GerarChave") {
        $processo = "DCE_GerarChave";

        if (GerarChave(
            $ffi,
            $_POST['ACodigoUF'],
            $_POST['ACodigoNumerico'],
            $_POST['AModelo'],
            $_POST['ASerie'],
            $_POST['ANumero'],
            $_POST['ATpEmi'],
            $_POST['AEmissao'],
            $_POST['ACNPJCPF'],
            $resultado
        ) != 0) {
            exit;
        }
    }

    if ($metodo == "AssinarDCe") {
        $processo = "DCE_AssinarDCe";

        if (AssinarDCe($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "Enviar") {
        if ($_POST['tipoArquivo'] == "xml") {
            $processo = "DCE_CarregarXml";

            if (CarregarXmlDCe($ffi, $_POST['AeArquivoDCe'], $resultado) != 0) {
                exit;
            }
        } else {
            $processo = "DCE_CarregarINI";

            if (CarregarINI($ffi, $_POST['AeArquivoDCe'], $resultado) != 0) {
                exit;
            }
        }

        $processo = "DCE_Enviar";

        if (Enviar(
            $ffi,
            $_POST['ALote'],
            $_POST['AImprimir'],
            $_POST['AZipado'],
            $resultado
        ) != 0) {
            exit;
        }
    }

    if ($metodo == "Consultar") {
        $processo = "DCE_Consultar";

        if (Consultar($ffi, $_POST['eChaveOuDCe'], $_POST['AExtrairEventos'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CancelarDCe") {
        $processo = "DCE_Cancelar";

        if (Cancelar($ffi, $_POST['AeChave'], $_POST['AeJustificativa'], $_POST['AeCNPJCPF'], $_POST['ALote'], $_POST['AEmitenteDCe'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ImprimirPDF") {
        $processo = "DCE_CarregarXml";

        if (CarregarXmlDCe($ffi, $_POST['AeArquivoXmlDCe'], $resultado) != 0) {
            exit;
        }

        $processo = "DCE_ImprimirPDF";

        if (ImprimirPDF($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "SalvarPDF") {
        $processo = "DCE_CarregarXml";

        if (CarregarXmlDCe($ffi, $_POST['AeArquivoXmlDCe'], $resultado) != 0) {
            exit;
        }

        $processo = "DCE_SalvarPDF";

        if (SalvarPDF($ffi, $resultado) != 0) {
            exit;
        }

        $PathPDF = "";
        if (ConfigLerValor($ffi, "DACe", "PathPDF", $PathPDF) != 0) exit;
            file_put_contents($PathPDF . DIRECTORY_SEPARATOR . "DACE.pdf", base64_decode($resultado));
    }

    if ($metodo == "ImprimirEventoPDF") {
        $processo = "DCE_ImprimirEventoPDF";

        if (ImprimirEventoPDF($ffi, $_POST['AeArquivoXmlDCe'], $_POST['AeArquivoXmlEvento'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "SalvarEventoPDF") {
        $processo = "DCE_SalvarEventoPDF";

        if (SalvarEventoPDF($ffi, $_POST['AeArquivoXmlDCe'], $_POST['AeArquivoXmlEvento'], $resultado) != 0) {
            exit;
        }

        $PathPDF = "";
        if (ConfigLerValor($ffi, "DACe", "PathPDF", $PathPDF) != 0) exit;
            file_put_contents($PathPDF . DIRECTORY_SEPARATOR . "EVENTO.pdf", base64_decode($resultado));
    }

    if ($metodo == "ValidarRegrasdeNegocios") {
        $processo = "DCE_CarregarXml";

        if (CarregarXmlDCe($ffi, $_POST['AeArquivoXmlDCe'], $resultado) != 0) {
            exit;
        }

        $processo = "DCE_ValidarRegrasdeNegocios";

        if (ValidarRegrasdeNegocios($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarEmail") {
        $processo = "DCE_EnviarEmail";

        if (EnviarEmail($ffi, $_POST['AePara'], $_POST['AeArquivoXmlDCe'], $_POST['AEnviaPDF'], $_POST['AeAssunto'], $_POST['AeCC'], $_POST['AeAnexos'], $_POST['AeMensagem'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarEmailEvento") {
        $processo = "DCE_EnviarEmailEvento";

        if (EnviarEmailEvento($ffi, $_POST['AePara'], $_POST['AeXmlEvento'], $_POST['AeXmlDCe'], $_POST['AEnviaPDF'], $_POST['AeAssunto'], $_POST['AeCC'], $_POST['AeAnexos'], $_POST['AeMensagem'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterCertificados") {
        $processo = "NFCOM_ObterCertificados";

        if (ObterCertificados($ffi, $resultado) != 0) {
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
    $responseData = ["mensagem" => "Exceção[$processo]: $erro"];
}

try {
    if ($processo != "DCE_Inicializar") {
        $processo = "DCE_Finalizar";
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
