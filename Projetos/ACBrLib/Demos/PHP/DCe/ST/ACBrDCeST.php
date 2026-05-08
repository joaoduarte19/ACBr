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

function Inicializar($ffi, $iniPath)
{
    $retorno = $ffi->DCE_Inicializar($iniPath, "");

    if ($retorno !== 0) {
        echo json_encode(["mensagem" => "Falha ao inicializar a biblioteca ACBr. Código de erro: $retorno"]);
        return -10;
    }

    return 0;
}

function Finalizar($ffi)
{
    $retorno = $ffi->DCE_Finalizar();

    if ($retorno !== 0) {
        echo json_encode(["mensagem" => "Falha ao finalizar a biblioteca ACBr. Código de erro: $retorno"]);
        return -10;
    }

    return 0;
}

function ConfigLer($ffi, $eArqConfig)
{
    $retorno = $ffi->DCE_ConfigLer($eArqConfig);
    $sMensagem = FFI::new("char[9048]");

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao carregar o arquivo ini. ") != 0)
        return -10;

    return 0;
}

function ConfigLerValor($ffi, $eSessao, $eChave, &$sValor)
{
    $sResposta = FFI::new("char[9048]");
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $retorno = $ffi->DCE_ConfigLerValor($eSessao, $eChave, $sResposta, FFI::addr($esTamanho));

    $sMensagem = FFI::new("char[9048]");

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao ler valor na secao[$eSessao] e chave[$eChave]. ", 1) != 0)
            return -10;
    }

    $sValor = FFI::string($sResposta);
    return 0;
}

function ConfigGravarValor($ffi, $eSessao, $eChave, $value)
{
    $retorno = $ffi->DCE_ConfigGravarValor($eSessao, $eChave, $value);
    $sMensagem = FFI::new("char[9048]");

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao gravar valores [$value] na secao[$eSessao] e chave[$eChave]. ") != 0)
        return -10;

    return 0;
}

function ConfigGravar($ffi, $eArqConfig)
{
    $retorno = $ffi->DCE_ConfigGravar($eArqConfig);
    $sMensagem = FFI::new("char[9048]");

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao gravar as configurações. ") != 0)
        return -10;

    return 0;
}

function UltimoRetorno($ffi, $retornolib, &$sMensagem, $msgErro, $retMensagem = 0)
{
    if (($retornolib !== 0) || ($retMensagem == 1)) {
        $esTamanho = FFI::new("long");
        $esTamanho->cdata = 144768;
        $resposta = $ffi->DCE_UltimoRetorno($sMensagem, FFI::addr($esTamanho));

        if ($retornolib !== 0) {
            $ultimoRetorno = FFI::string($sMensagem);
            $retorno = "$msgErro Código de erro: $retornolib. ";

            $retorno = $retorno;

            if ($ultimoRetorno != "") {
                $retorno = $retorno . "Último retorno: " . $ultimoRetorno;
            }

            echo json_encode(["mensagem" => $retorno]);
            return -10;
        }
    }

    return 0;
}

function OpenSSLInfo($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_OpenSSLInfo($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao verificar a OpenSSLInfo", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function StatusServico($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_StatusServico($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao consultar status do serviço", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function GerarChave(
    $ffi,
    $ACodigoUF,
    $ACodigoNumerico,
    $AModelo,
    $ASerie,
    $ANumero,
    $ATpEmi,
    $AEmissao,
    $ACNPJCPF,
    &$retornoGeral
) {
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_GerarChave(
        $ACodigoUF,
        $ACodigoNumerico,
        $AModelo,
        $ASerie,
        $ANumero,
        $ATpEmi,
        $AEmissao,
        $ACNPJCPF,
        $sMensagem,
        FFI::addr($esTamanho)
    );

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter o ini", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ObterCertificados($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_ObterCertificados($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter certificados", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function CarregarXmlDCe($ffi, $eArquivoOuXML, &$retornoGeral)
{
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_CarregarXML($eArquivoOuXML);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao carregar o XML da DCe", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function CarregarINI($ffi, $eArquivoOuINI, &$retornoGeral)
{
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_CarregarINI($eArquivoOuINI);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao carregar o INI", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ObterXml($ffi, $AIndex, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_ObterXml($AIndex, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter o xml", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function GravarXml($ffi, $AIndex, $eNomeArquivo, $ePathArquivo, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_GravarXml($AIndex, $eNomeArquivo, $ePathArquivo);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro gravar o xml da DCe.", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ObterIni($ffi, $AIndex, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_ObterIni($AIndex, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter o ini", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function GravarIni($ffi, $AIndex, $eNomeArquivo, $ePathArquivo, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_GravarIni($AIndex, $eNomeArquivo, $ePathArquivo);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro gravar o ini", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function CarregarEventoXML($ffi, $eArquivoOuXML, &$retornoGeral)
{
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_CarregarEventoXML($eArquivoOuXML);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao carregar o XML do evento", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function CarregarEventoINI($ffi, $eArquivoOuINI, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_CarregarEventoINI($eArquivoOuINI);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro carregar o ini do evento", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function LimparListaDCe($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_LimparLista();

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao limpar a lista de DCes.", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function LimparListaEventos($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_LimparListaEventos();

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao limpar a lista de eventos.", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ValidarDCe($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_Validar();

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro validar DCe.", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function AssinarDCe($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_Assinar();

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro assinar DCe.", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function Enviar($ffi, $ALote, $AImprimir, $AZipado, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_Enviar($ALote, $AImprimir, $AZipado, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao enviar DCe", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function Consultar($ffi, $eChaveOuDCe, $AExtrairEventos, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_Consultar($eChaveOuDCe, $AExtrairEventos, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao consultar a chave", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function Cancelar($ffi, $AeChave, $AeJustificativa, $AeCNPJCPF, $ALote, $AEmitenteDCe, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_Cancelar($AeChave, $AeJustificativa, $AeCNPJCPF, $ALote, $AEmitenteDCe, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao cancelar DCe", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ImprimirPDF($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_ImprimirPDF();

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao imprimir o pdf", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function SalvarPDF($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_SalvarPDF($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao salvar o pdf", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ImprimirEventoPDF($ffi, $AeArquivoXmlDCe, $AeArquivoXmlEvento, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_ImprimirEventoPDF($AeArquivoXmlDCe, $AeArquivoXmlEvento);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao imprimir o pdf do evento", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function SalvarEventoPDF($ffi, $AeArquivoXmlDCe, $AeArquivoXmlEvento, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_SalvarEventoPDF($AeArquivoXmlDCe, $AeArquivoXmlEvento, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao salvar o pdf do evento", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function ValidarRegrasdeNegocios($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_ValidarRegrasdeNegocios($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao validar regra de negócio", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function EnviarEmail($ffi, $AePara, $AeXmlDCe, $AEnviaPDF, $AeAssunto, $AeCC, $AeAnexos, $AeMensagem, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_EnviarEmail($AePara, $AeXmlDCe, $AEnviaPDF, $AeAssunto, $AeCC, $AeAnexos, $AeMensagem);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao enviar e-mail", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function EnviarEmailEvento($ffi, $AePara, $AeXmlEvento, $AeXmlDCe, $AEnviaPDF, $AeAssunto, $AeCC, $AeAnexos, $AeMensagem, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 144768;
    $sMensagem = FFI::new("char[144768]");
    $retorno = $ffi->DCE_EnviarEmailEvento($AePara, $AeXmlEvento, $AeXmlDCe, $AEnviaPDF, $AeAssunto, $AeCC, $AeAnexos, $AeMensagem);

    if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao enviar e-mail do evento", 1) != 0)
        return -10;

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function VerificarAssinatura($ffi, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_VerificarAssinatura($sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao verificar assinatura", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function GetPath($ffi, $ATipo, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_GetPath($ATipo, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter o caminnho", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}

function GetPathEvento($ffi, $ACodEvento, &$retornoGeral)
{
    $esTamanho = FFI::new("long");
    $esTamanho->cdata = 9048;
    $sMensagem = FFI::new("char[9048]");
    $retorno = $ffi->DCE_GetPathEvento($ACodEvento, $sMensagem, FFI::addr($esTamanho));

    if ($retorno !== 0) {
        if (UltimoRetorno($ffi, $retorno, $sMensagem, "Erro ao obter o caminnho do evento", 1) != 0)
            return -10;
    }

    $retornoGeral = FFI::string($sMensagem);

    return 0;
}
