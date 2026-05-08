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

int DCE_Inicializar(const char* eArqConfig, const char* eChaveCrypt);
int DCE_Finalizar();
int DCE_Nome(const char* sNome, long* esTamanho);
int DCE_Versao(const char* sVersao, long* esTamanho);
int DCE_OpenSSLInfo(const char* sOpenSSLInfo, long* esTamanho);
int DCE_UltimoRetorno(const char* sMensagem, long* esTamanho);
int DCE_ConfigImportar(const char* eArqConfig);
int DCE_ConfigExportar(const char* sMensagem, long* esTamanho);
int DCE_ConfigLer(const char* eArqConfig);
int DCE_ConfigGravar(const char* eArqConfig);
int DCE_ConfigLerValor(const char* eSessao, const char* eChave, const char* sValor, long* esTamanho);
int DCE_ConfigGravarValor(const char* eSessao, const char* eChave, const char* eValor);
int DCE_StatusServico(char* sMensagem, long* esTamanho);
int DCE_GerarChave(long ACodigoUF, long ACodigoNumerico, long AModelo, 
    long ASerie, long ANumero, long ATpEmi, const char* AEmissao, const char* ACNPJCPF, 
    const char* sResposta, long* esTamanho);
int DCE_ObterCertificados(const char* sResposta, long* esTamanho);
int DCE_ValidarRegrasdeNegocios(const char* sResposta, long* esTamanho);
int DCE_Assinar();
int DCE_Enviar(int ALote, int AImprimir, int AZipado, const char* sResposta, long* esTamanho);
int DCE_Consultar(const char* eChaveOuDCe, int AExtrairEventos, const char* sResposta, long* esTamanho);
int DCE_Cancelar(const char* eChave, const char* eJustificativa, const char* eCNPJCPF,
    int ALote, int AEmitenteDCe, const char* sResposta, long* esTamanho);
int DCE_CarregarXML(const char* eArquivoOuXML);
int DCE_CarregarINI(const char* eArquivoOuINI);
int DCE_ObterXml(long AIndex, const char* sResposta, long* esTamanho);
int DCE_GravarXml(long AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int DCE_ObterIni(long AIndex, const char* sResposta, long* esTamanho);
int DCE_GravarIni(long AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int DCE_CarregarEventoXML(const char* eArquivoOuXML);
int DCE_LimparLista();
int DCE_LimparListaEventos();
int DCE_Validar();
int DCE_ImprimirPDF();
int DCE_SalvarPDF(const char* sResposta, long* esTamanho);
int DCE_ImprimirEventoPDF(const char* eArquivoXmlDCe, const char* eArquivoXmlEvento);
int DCE_SalvarEventoPDF(const char* eArquivoXmlDCe, const char* eArquivoXmlEvento, const char* sResposta, 
    long* esTamanho);
int DCE_EnviarEmail(const char* ePara, const char* eXmlDCe, int AEnviaPDF,
    const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int DCE_EnviarEmailEvento(const char* ePara, const char* eXmlEvento, const char* eXmlDCe, long AEnviaPDF, 
    const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int DCE_CarregarEventoINI(const char* eArquivoOuINI);
int DCE_VerificarAssinatura(const char* sResposta, long* esTamanho);
int DCE_GetPath(long ATipo, const char* sResposta, long* esTamanho);
int DCE_GetPathEvento(const char* ACodEvento, const char* sResposta, long* esTamanho);
