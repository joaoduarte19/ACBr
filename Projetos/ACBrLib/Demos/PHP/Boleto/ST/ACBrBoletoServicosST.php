<?php
/* {******************************************************************************}
// { Projeto: Componentes ACBr                                                    }
// {  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
// { mentos de Automação Comercial utilizados no Brasil                           }
// {                                                                              }
// { Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
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
// { ADEQUAÇÃO A UMA FINALIDADE ESPECÝFICA. Consulte a Licença Pública Geral Menor}
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

include 'ACBrBoletoST.php';
include '../../ACBrComum/ACBrComum.php';

$nomeLib = "ACBrBoleto";
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

    $processo = "Boleto_Inicializar";
    if (Inicializar($ffi, $iniPath) != 0)
        exit;

    if ($metodo == "salvarConfiguracoes") {
        $processo = $metodo . "/" . "Boleto_ConfigGravarValor";

        if (ConfigGravarValor($ffi, "Principal", "LogPath", $_POST['LogPath']) != 0) exit;
        if (ConfigGravarValor($ffi, "Principal", "LogNivel", $_POST['LogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "TipoInscricao", $_POST['TipoInscricao']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "CNPJCPF", $_POST['CNPJCPF']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Nome", $_POST['Nome']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Logradouro", $_POST['Logradouro']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "NumeroRes", $_POST['NumeroRes']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Bairro", $_POST['Bairro']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Complemento", $_POST['Complemento']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Cidade", $_POST['Cidade']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "UF", $_POST['UF']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "CEP", $_POST['CEP']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Telefone", $_POST['Telefone']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "TipoDocumento", $_POST['TipoDocumento']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "TipoCarteira", $_POST['TipoCarteira']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "ResponEmissao", $_POST['ResponEmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Agencia", $_POST['Agencia']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "AgenciaDigito", $_POST['AgenciaDigito']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Conta", $_POST['Conta']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "ContaDigito", $_POST['ContaDigito']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "CodigoTransmissao", $_POST['CodigoTransmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Convenio", $_POST['Convenio']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "Modalidade", $_POST['Modalidade']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteConfig", "CodigoCedente", $_POST['CodigoCedente']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoBancoFCFortesConfig", "PrinterName", $_POST['PrinterName']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoBancoFCFortesConfig", "Layout", $_POST['Layout']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoBancoFCFortesConfig", "DirLogo", $_POST['DirLogo']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoBancoFCFortesConfig", "NumeroCopias", $_POST['NumeroCopias']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoBancoFCFortesConfig", "NomeArquivo", $_POST['NomeArquivo']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoBancoConfig", "TipoCobranca", $_POST['TipoCobranca']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "LayoutRemessa", $_POST['LayoutRemessa']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "LeCedenteRetorno", $_POST['LeCedenteRetorno']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "DirArqRemessa", $_POST['DirArqRemessa']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "NomeArqRemessa", $_POST['NomeArqRemessa']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "DirArqRetorno", $_POST['DirArqRetorno']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoDiretorioConfig", "NomeArqRetorno", $_POST['NomeArqRetorno']) != 0) exit;

        if (ConfigGravarValor($ffi, "Email", "Nome", $_POST['emailNome']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Conta", $_POST['emailConta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Servidor", $_POST['emailServidor']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Porta", $_POST['emailPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "SSL", $_POST['emailSSL']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "TLS", $_POST['emailTLS']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Usuario", $_POST['emailUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Senha", $_POST['emailSenha']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoWebSevice", "ambiente", $_POST['ambiente']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "Operacao", $_POST['WSOperacao']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "SSLType", $_POST['SSLType']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "VersaoDF", $_POST['VersaoDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "Timeout", $_POST['Timeout']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "ArquivoCRT", $_POST['ArquivoCRT']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "ArquivoKEY", $_POST['ArquivoKEY']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "PathGravarRegistro", $_POST['PathGravarRegistro']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "NomeArquivoLog", $_POST['NomeArquivoLog']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoWebSevice", "LogNivel", $_POST['WSLogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "DFe", "SSLHttpLib", $_POST['SSLHttpLib']) != 0) exit;

        if (ConfigGravarValor($ffi, "BoletoCedenteWS", "ClientID", $_POST['ClientID']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteWS", "ClientSecret", $_POST['ClientSecret']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteWS", "KeyUser", $_POST['KeyUser']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteWS", "Scope", $_POST['Scope']) != 0) exit;
        if (ConfigGravarValor($ffi, "BoletoCedenteWS", "IndicadorPix", $_POST['IndicadorPix']) != 0) exit;

        $resultado = "Configurações salvas com sucesso.";
    }

    // Só não carrega as configurações quando for o método de gravar configurações
    if ($metodo != "salvarConfiguracoes") {
        $processo = $metodo . "/" . "Boleto_ConfigLer";

        if (ConfigLerValor($ffi, "Principal", "LogPath", $LogPath) != 0) exit;
        if (ConfigLerValor($ffi, "Principal", "LogNivel", $LogNivel) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "TipoInscricao", $TipoInscricao) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "CNPJCPF", $CNPJCPF) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Nome", $Nome) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Logradouro", $Logradouro) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "NumeroRes", $NumeroRes) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Bairro", $Bairro) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Complemento", $Complemento) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Cidade", $Cidade) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "UF", $UF) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "CEP", $CEP) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Telefone", $Telefone) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "TipoDocumento", $TipoDocumento) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "TipoCarteira", $TipoCarteira) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "ResponEmissao", $ResponEmissao) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Agencia", $Agencia) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "AgenciaDigito", $AgenciaDigito) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Conta", $Conta) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "ContaDigito", $ContaDigito) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "CodigoTransmissao", $CodigoTransmissao) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Convenio", $Convenio) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "Modalidade", $Modalidade) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteConfig", "CodigoCedente", $CodigoCedente) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoBancoFCFortesConfig", "PrinterName", $PrinterName) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoBancoFCFortesConfig", "Layout", $Layout) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoBancoFCFortesConfig", "DirLogo", $DirLogo) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoBancoFCFortesConfig", "NumeroCopias", $NumeroCopias) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoBancoFCFortesConfig", "NomeArquivo", $NomeArquivo) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoBancoConfig", "TipoCobranca", $TipoCobranca) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "LayoutRemessa", $LayoutRemessa) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "LeCedenteRetorno", $LeCedenteRetorno) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "DirArqRemessa", $DirArqRemessa) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "NomeArqRemessa", $NomeArqRemessa) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "DirArqRetorno", $DirArqRetorno) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoDiretorioConfig", "NomeArqRetorno", $NomeArqRetorno) != 0) exit;

        if (ConfigLerValor($ffi, "Email", "Nome", $emailNome) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Conta", $emailConta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Servidor", $emailServidor) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Porta", $emailPorta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "SSL", $emailSSL) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "TLS", $emailTLS) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Usuario", $emailUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Senha", $emailSenha) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoWebSevice", "ambiente", $ambiente) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "Operacao", $WSOperacao) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "SSLType", $SSLType) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "VersaoDF", $VersaoDF) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "Timeout", $Timeout) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "ArquivoCRT", $ArquivoCRT) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "ArquivoKEY", $ArquivoKEY) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "PathGravarRegistro", $PathGravarRegistro) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "NomeArquivoLog", $NomeArquivoLog) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoWebSevice", "LogNivel", $WSLogNivel) != 0) exit;

        if (ConfigLerValor($ffi, "DFe", "SSLHttpLib", $SSLHttpLib) != 0) exit;

        if (ConfigLerValor($ffi, "BoletoCedenteWS", "ClientID", $ClientID) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteWS", "ClientSecret", $ClientSecret) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteWS", "KeyUser", $KeyUser) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteWS", "Scope", $Scope) != 0) exit;
        if (ConfigLerValor($ffi, "BoletoCedenteWS", "IndicadorPix", $IndicadorPix) != 0) exit;

        if ($metodo == "carregarConfiguracoes") {
            $processo = $metodo . "/" . "responseData";
            $responseData = [
                'dados' => [
                    'LogPath' => $LogPath ?? '',
                    'LogNivel' => $LogNivel ?? '',

                    'TipoInscricao' => $TipoInscricao ?? '',
                    'CNPJCPF' => $CNPJCPF ?? '',
                    'Nome' => $Nome ?? '',
                    'Logradouro' => $Logradouro ?? '',
                    'NumeroRes' => $NumeroRes ?? '',
                    'Bairro' => $Bairro ?? '',
                    'Complemento' => $Complemento ?? '',
                    'Cidade' => $Cidade ?? '',
                    'UF' => $UF ?? '',
                    'CEP' => $CEP ?? '',
                    'Telefone' => $Telefone ?? '',
                    'TipoDocumento' => $TipoDocumento ?? '',
                    'TipoCarteira' => $TipoCarteira ?? '',
                    'ResponEmissao' => $ResponEmissao ?? '',
                    'Agencia' => $Agencia ?? '',
                    'AgenciaDigito' => $AgenciaDigito ?? '',
                    'Conta' => $Conta ?? '',
                    'ContaDigito' => $ContaDigito ?? '',
                    'CodigoTransmissao' => $CodigoTransmissao ?? '',
                    'Convenio' => $Convenio ?? '',
                    'Modalidade' => $Modalidade ?? '',
                    'CodigoCedente' => $CodigoCedente ?? '',

                    'PrinterName' => $PrinterName ?? '',
                    'Layout' => $Layout ?? '',
                    'DirLogo' => $DirLogo ?? '',
                    'NumeroCopias' => $NumeroCopias ?? '',
                    'NomeArquivo' => $NomeArquivo ?? '',

                    'TipoCobranca' => $TipoCobranca ?? '',

                    'LayoutRemessa' => $LayoutRemessa ?? '',
                    'LeCedenteRetorno' => $LeCedenteRetorno ?? '',
                    'DirArqRemessa' => $DirArqRemessa ?? '',
                    'NomeArqRemessa' => $NomeArqRemessa ?? '',
                    'DirArqRetorno' => $DirArqRetorno ?? '',
                    'NomeArqRetorno' => $NomeArqRetorno ?? '',

                    'emailNome' => $emailNome ?? '',
                    'emailConta' => $emailConta ?? '',
                    'emailServidor' => $emailServidor ?? '',
                    'emailPorta' => $emailPorta ?? '',
                    'emailSSL' => $emailSSL ?? '',
                    'emailTLS' => $emailTLS ?? '',
                    'emailUsuario' => $emailUsuario ?? '',
                    'emailSenha' => $emailSenha ?? '',

                    'ambiente' => $ambiente ?? '',
                    'WSOperacao' => $WSOperacao ?? '',
                    'SSLType' => $SSLType ?? '',
                    'VersaoDF' => $VersaoDF ?? '',
                    'Timeout' => $Timeout ?? '',
                    'ArquivoCRT' => $ArquivoCRT ?? '',
                    'ArquivoKEY' => $ArquivoKEY ?? '',
                    'PathGravarRegistro' => $PathGravarRegistro ?? '',
                    'NomeArquivoLog' => $NomeArquivoLog ?? '',
                    'WSLogNivel' => $WSLogNivel ?? '',

                    'SSLHttpLib' => $SSLHttpLib ?? '',

                    'ClientID' => $ClientID ?? '',
                    'ClientSecret' => $ClientSecret ?? '',
                    'KeyUser' => $KeyUser ?? '',
                    'Scope' => $Scope ?? '',
                    'IndicadorPix' => $IndicadorPix ?? ''
                ]
            ];
        }
    }

    if ($metodo == "GerarRemessaStream") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_GerarRemessaStream";

        if (GerarRemessaStream($ffi, 1, $resultado) != 0) {
            exit;
        }

        $resultado = base64_decode($resultado);
    }

    if ($metodo == "SalvarPDF") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_SalvarPDF";

        if (SalvarPDF($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "GerarPDF") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_GerarPDF";

        if (GerarPDF($ffi, $resultado) != 0) {
            exit;
        }

        $resultado = "ok";
    }

    if ($metodo == "LerRetornoStream") {
        $processo = "Boleto_LerRetornoStream";

        $arquivoBase64 = base64_encode($_POST['AeArquivoIni']);

        if (LerRetornoStream($ffi, $arquivoBase64, $resultado) != 0) {
            exit;
        }

        $resultado = base64_decode($resultado);
    }

    if ($metodo == "EnviarEmail") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_EnviarEmail";

        if (EnviarEmail($ffi, $_POST['AePara'], $_POST['AeAssunto'], $_POST['AeMensagem'], $_POST['AeCC'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarEmailBoleto") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_EnviarEmailBoleto";

        if (EnviarEmailBoleto($ffi, 0, $_POST['AePara'], $_POST['AeAssunto'], $_POST['AeMensagem'], $_POST['AeCC'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "RetornaLinhaDigitavel") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_RetornaLinhaDigitavel";

        if (RetornaLinhaDigitavel($ffi, 0, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "RetornaCodigoBarras") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_RetornaCodigoBarras";

        if (RetornaCodigoBarras($ffi, 0, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ListaOcorrencias") {
        $processo = "Boleto_SelecionaBanco";

        if (SelecionaBanco($ffi, $_POST['TipoCobranca'], $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_ListaOcorrencias";

        if (ListaOcorrencias($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ListaOcorrenciasEX") {
        $processo = "Boleto_SelecionaBanco";

        if (SelecionaBanco($ffi, $_POST['TipoCobranca'], $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_ListaOcorrenciasEX";

        if (ListaOcorrenciasEX($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ListaCaractTitulo") {
        $processo = "Boleto_SelecionaBanco";

        if (SelecionaBanco($ffi, $_POST['TipoCobranca'], $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_ListaCaractTitulo";

        if (ListaCaractTitulo($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CodigosMoraAceitos") {
        $processo = "Boleto_SelecionaBanco";

        if (SelecionaBanco($ffi, $_POST['TipoCobranca'], $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_CodigosMoraAceitos";

        if (CodigosMoraAceitos($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "TamNossoNumero") {
        $processo = "Boleto_SelecionaBanco";

        if (SelecionaBanco($ffi, $_POST['TipoCobranca'], $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_TamNossoNumero";

        if (TamNossoNumero($ffi, $_POST['AeCarteira'], $_POST['AenossoNumero'], $_POST['AeConvenio'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "MontarNossoNumero") {
        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_MontarNossoNumero";

        if (MontarNossoNumero($ffi, 0, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ListaBancos") {
        $processo = "Boleto_ListaBancos";

        if (ListaBancos($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarBoleto") {
        $operacao = $_POST['AeCodigoOperacao'];

        $processo = "Boleto_IncluirTitulos";

        if (IncluirTitulos($ffi, $_POST['AeArquivoIni'], "", $resultado) != 0) {
            exit;
        }

        $processo = "Boleto_EnviarBoleto(" . $operacao . ")";

        if (EnviarBoleto($ffi, $operacao, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ConsultarTitulosPorPeriodo") {
        $processo = "Boleto_ConsultarTitulosPorPeriodo";

        if (ConsultarTitulosPorPeriodo($ffi, $_POST['AeArquivoIni'], $resultado) != 0) {
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
    if ($processo != "NFE_Inicializar") {
        $processo = "NFE_Finalizar";
        if (Finalizar($ffi) != 0)
            exit;
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    echo json_encode(["mensagem" => "Exceção[$processo]: $erro"]);
    exit;
}

echo json_encode($responseData);
