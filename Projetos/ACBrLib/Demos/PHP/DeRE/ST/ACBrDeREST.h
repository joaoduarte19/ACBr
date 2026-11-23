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

int DeRE_Inicializar(const char* eArqConfig, const char* eChaveCrypt);
int DeRE_ConfigLer(const char* eArqConfig);
int DeRE_ConfigLerValor (const char* eSessao, const char* eChave, char* sValor, long* esTamanho);
int DeRE_ConfigGravar(const char* eArqConfig);
int DeRE_ConfigGravarValor(const char* eSessao, const char* eChave, const char* eValor);
int DeRE_UltimoRetorno(char* sMensagem, long* esTamanho);
int DeRE_Finalizar();

int DeRE_Nome(const char* sNome, long* esTamanho);
int DeRE_Versao(const char* sVersao, long* esTamanho);
int DeRE_OpenSSLInfo(const char* sOpenSSLInfo, long* esTamanho);
int DeRE_ConfigImportar(const char* eArqConfig);
int DeRE_ConfigExportar(const char* sMensagem, long* esTamanho);

int DeRE_CriarEventoDeRE(const char* eArqIni);
int DeRE_EnviarDeRE(const char* sResposta, long* esTamanho);
int DeRE_ConsultarDeRE(const char* eProtocolo, const char* sResposta, long* esTamanho);
int DeRE_CriarEnviarDeRE(const char* eArqIni, const char* sResposta, long* esTamanho);
int DeRE_LimparDeRE();
int DeRE_CarregarXMLEventoDeRE (const char* eArquivoOuXML);
int DeRE_SetIDContribuinte (const char* aIdContribuinte);
int DeRE_SetVersaoDF (const char* sVersao);
int DeRE_ObterIniEventos(const char* sResposta, long* esTamanho);
int DeRE_ObterToken(const char* sResposta, long* esTamanho);
int DeRE_LimparDados(const char* eCNPJBase, const char* sResposta, long* esTamanho);
int DeRE_ObterCertificados (const char* sResposta, long* esTamanho);
int DeRE_Validar();
