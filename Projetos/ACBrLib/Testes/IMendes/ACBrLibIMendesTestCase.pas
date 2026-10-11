{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior                           }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

unit ACBrLibIMendesTestCase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles, fpcunit, testutils, testregistry;

type

  { TTestACBrIMendesLib }

  TTestACBrIMendesLib = class(TTestCase)
    private
      fCaminhoExec: string;
      procedure ConfigurarCredenciaisFicticias(Handle: THandle);
      function LerUltimoRetorno(Handle: THandle): String;
    public
      procedure SetUp; override;
    published
      procedure Test_IMendes_Inicializar_Com_DiretorioInvalido;
      procedure Test_IMendes_Inicializar;
      procedure Test_IMendes_Inicializar_Ja_Inicializado;
      procedure Test_IMendes_Finalizar;
      procedure Test_IMendes_Finalizar_Ja_Finalizado;
      procedure Test_IMendes_Nome_Obtendo_LenBuffer;
      procedure Test_IMendes_Nome_Lendo_Buffer_Tamanho_Identico;
      procedure Test_IMendes_Nome_Lendo_Buffer_Tamanho_Maior;
      procedure Test_IMendes_Nome_Lendo_Buffer_Tamanho_Menor;
      procedure Test_IMendes_Versao;
      procedure Test_IMendes_ConfigLerValor;
      procedure Test_IMendes_ConfigGravarValor;
      procedure Test_IMendes_ConfigGravarValor_Ambiente;
      procedure Test_IMendes_ConfigGravarValor_CNPJ;
      procedure Test_IMendes_ConfigGravarValor_Senha;
      procedure Test_IMendes_Senha_Criptografada_No_Ini;
      procedure Test_IMendes_SaneamentoGrades_ArquivoInexistente;
      procedure Test_IMendes_ConsultarRegimesEspeciais_SemConfiguracao;
      procedure Test_IMendes_ConfigGravarValor_ArqLog;
      procedure Test_IMendes_ConfigGravarValor_NivelLog;
      procedure Test_IMendes_ConfigGravarValor_TimeOut;
      procedure Test_IMendes_ConfigGravarValor_MaxProdutosPorEnvio;
      procedure Test_IMendes_Inativar_ArquivoInexistente;
      procedure Test_IMendes_RemoveDevolvidos_ArquivoInexistente;
      procedure Test_IMendes_Inativar_SemProdutos;
      procedure Test_IMendes_RemoveDevolvidos_SemProdutos;
  end;

  { TTestACBrIMendesLibAPI }

  // Testes que acessam a API IMendes.
  // A configuracao [IMendes] (Ambiente, CNPJ e Senha) e gravada pelo IMendes_ConfigGravarValor
  // a partir das constantes CIMendes* (secao implementation).
  TTestACBrIMendesLibAPI = class(TTestCase)
    private
      fCaminhoExec: string;
      procedure Preparar(var Handle: THandle; const ATipoResposta: String = '0');
      function LerUltimoRetorno(Handle: THandle; Bufflen: Integer): String;
      function ExecutarSaneamento(const ANomeArquivoIni: String): String;
      procedure VerificarSecao(const AResposta, ASecao: String; AExiste: Boolean);
      procedure VerificarFormato(const ATipoResposta, AMetodo, ARaiz, AResposta: String);
      procedure ExecutarTodasFuncoes(const ATipoResposta: String);
    public
      procedure SetUp; override;
    published
      procedure Test_IMendes_ConsultarRegimesEspeciais;
      procedure Test_IMendes_ConsultarDescricao;
      procedure Test_IMendes_ConsultarAlterados;
      procedure Test_IMendes_ConsultarAlterados_Limite;
      procedure Test_IMendes_HistoricoAcesso;
      procedure Test_IMendes_SaneamentoGrades;
      procedure Test_IMendes_SaneamentoGrades_CamposObrigatorios;
      procedure Test_IMendes_SaneamentoGrades_CamposOpcionais;
      procedure Test_IMendes_SaneamentoGrades_1UF_1CaracTrib;
      procedure Test_IMendes_SaneamentoGrades_2UF_1CaracTrib;
      procedure Test_IMendes_SaneamentoGrades_1UF_2CaracTrib;
      procedure Test_IMendes_SaneamentoGrades_2UF_2CaracTrib;
      procedure Test_IMendes_LogComponente;
      procedure Test_IMendes_TodasFuncoes_RespostaXML;
      procedure Test_IMendes_TodasFuncoes_RespostaJSON;
      procedure Test_IMendes_Inativar;
      procedure Test_IMendes_RemoveDevolvidos;
  end;

implementation

uses
  ACBrLibIMendesStaticImportMT, ACBrLibIMendesConsts, ACBrLibConsts, Dialogs;

const
  // Credenciais da conta IMendes usadas nos testes da API (TTestACBrIMendesLibAPI).
  // Preencha CIMendesCNPJ e CIMendesSenha para executar os testes da API (NAO versionar preenchidas).
  CIMendesAmbiente = '1';
  CIMendesCNPJ = '';
  CIMendesArqLog = 'IMendesComponente.log';
  CIMendesSenha = '';
  CIMendesTestarAlteracoes = False;

{ TTestACBrIMendesLib }

procedure TTestACBrIMendesLib.SetUp;
begin
  inherited SetUp;
  fCaminhoExec := ExtractFileDir(ParamStr(0));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Inicializar_Com_DiretorioInvalido;
var
  Handle: THandle;
begin
  try
    //IMendes_Inicializar(Handle);
    AssertEquals(ErrDiretorioNaoExiste, IMendes_Inicializar(Handle, 'C:\NAOEXISTE\ACBrLib.ini',''));
  except
    on E: Exception do
     ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrIMendesLib.Test_IMendes_Inicializar;
var
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '',''));
  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Inicializar_Ja_Inicializado;
var
  Handle: THandle;
begin
    AssertEquals(ErrOk, IMendes_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, IMendes_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Finalizar;
var
  Handle: THandle;
begin
    AssertEquals(ErrOk, IMendes_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Finalizar_Ja_Finalizado;
var
  Handle: THandle;
begin
    AssertEquals(ErrOk, IMendes_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, IMendes_Finalizar(Handle));
    //AssertEquals(ErrOk, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Nome_Obtendo_LenBuffer;
var
  Handle: THandle;
  Bufflen: Integer;
  AStr: String;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOk, IMendes_Inicializar(Handle,'',''));

  Bufflen := 0;
  AssertEquals(ErrOk, IMendes_Nome(Handle,Nil, Bufflen));
  AssertEquals(Length(CLibIMendesNome), Bufflen);

  AssertEquals(ErrOk, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Nome_Lendo_Buffer_Tamanho_Identico;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '',''));

  Bufflen := Length(CLibIMendesNome);
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_Nome(Handle, PChar(AStr), Bufflen));
  AssertEquals(Length(CLibIMendesNome), Bufflen);
  AssertEquals(CLibIMendesNome, AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Nome_Lendo_Buffer_Tamanho_Maior;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  Bufflen := Length(CLibIMendesNome)*2;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_Nome(Handle, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals(Length(CLibIMendesNome), Bufflen);
  AssertEquals(CLibIMendesNome, AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Nome_Lendo_Buffer_Tamanho_Menor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle,  '', ''));

  Bufflen := 10;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_Nome(Handle,  PChar(AStr), Bufflen));
  AssertEquals(Length(CLibIMendesNome), Bufflen);
  AssertEquals(copy(CLibIMendesNome,1,10), AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Versao;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOK, IMendes_Inicializar(Handle,  '', ''));

  Bufflen := 0;
  AssertEquals(ErrOk, IMendes_Versao(Handle,  Nil, Bufflen));
  AssertEquals(Length(CLibIMendesVersao), Bufflen);

  // Lendo a resposta //
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_Versao(Handle, PChar(AStr), Bufflen));
  AssertEquals(Length(CLibIMendesVersao), Bufflen);
  AssertEquals(CLibIMendesVersao, AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigLerValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoVersao, CLibIMendesNome, PChar(AStr), Bufflen));
  AStr := copy(AStr,1,Bufflen);
  AssertEquals(CLibIMendesVersao, AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
    // Gravando o valor
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao Mudar configuração', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoPrincipal, CChaveLogNivel, '4'));

  // Checando se o valor foi atualizado //
  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoPrincipal, CChaveLogNivel, PChar(AStr), Bufflen));
  AStr := copy(AStr,1,Bufflen);
  AssertEquals('Erro ao Mudar configuração', '4', AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_Ambiente;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar Ambiente', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveAmbiente, '2'));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveAmbiente, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler Ambiente', '2', AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_CNPJ;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar CNPJ', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveCNPJ, '18760540000139'));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveCNPJ, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler CNPJ', '18760540000139', AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_Senha;
const
  CSenhaTeste = 'SenhaTeste123';
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar Senha', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveSenha, CSenhaTeste));

  // ConfigLerValor deve devolver a senha descriptografada
  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveSenha, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Senha lida diferente da gravada', CSenhaTeste, AStr);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Senha_Criptografada_No_Ini;
const
  CSenhaTeste = 'SenhaTeste123';
var
  AStr, SenhaIni: String;
  Bufflen: Integer;
  Handle: THandle;
  SL: TStringList;
  Ini: TMemIniFile;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar Senha', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveSenha, CSenhaTeste));

  // Obtendo o tamanho do INI exportado
  Bufflen := 0;
  AssertEquals(ErrOk, IMendes_ConfigExportar(Handle, Nil, Bufflen));

  // Lendo o INI exportado
  AStr := StringOfChar(' ', Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigExportar(Handle, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);

  SL := TStringList.Create;
  Ini := TMemIniFile.Create('');
  try
    SL.Text := AStr;
    Ini.SetStrings(SL);
    SenhaIni := Ini.ReadString(CSessaoIMendes, CChaveSenha, '');
  finally
    Ini.Free;
    SL.Free;
  end;

  AssertTrue('Senha nao foi gravada no INI', SenhaIni <> '');
  AssertTrue('Senha gravada em texto puro no INI', SenhaIni <> CSenhaTeste);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_SaneamentoGrades_ArquivoInexistente;
var
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  Bufflen := 0;
  AssertEquals('Esperado erro de arquivo inexistente', ErrArquivoNaoExiste,
    IMendes_SaneamentoGrades(Handle, 'C:\NAOEXISTE\IMendes_SaneamentoGrades.ini', Nil, Bufflen));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConsultarRegimesEspeciais_SemConfiguracao;
var
  Bufflen: Integer;
  Handle: THandle;
begin
  // Sem CNPJ/Senha: o componente deve recusar antes de acessar a API
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveAmbiente, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveAmbiente, '1'));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveCNPJ, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveCNPJ, ''));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveSenha, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveSenha, ''));

  Bufflen := 0;
  AssertEquals('Esperado erro de configuracao incompleta', ErrExecutandoMetodo,
    IMendes_ConsultarRegimesEspeciais(Handle, 'SP', False, Nil, Bufflen));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_ArqLog;
var
  AStr, ArqLog: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  ArqLog := fCaminhoExec + PathDelim + 'IMendesComponente.log';

  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar ArqLog', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveArqLog, PChar(ArqLog)));

  Bufflen := 255;
  AStr := StringOfChar(' ', Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveArqLog, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler ArqLog', ArqLog, AStr);

  // Volta ao padrao (sem log do componente)
  AssertEquals(ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveArqLog, ''));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_NivelLog;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar NivelLog', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveNivelLog, '4'));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveNivelLog, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler NivelLog', '4', AStr);

  // Volta ao padrao
  AssertEquals(ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveNivelLog, '1'));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_TimeOut;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar TimeOut', ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveTimeOut, '30000'));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveTimeOut, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler TimeOut', '30000', AStr);

  // Volta ao padrao
  AssertEquals(ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveTimeOut, '300000'));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_ConfigGravarValor_MaxProdutosPorEnvio;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  AssertEquals('Erro ao gravar MaxProdutosPorEnvio', ErrOk,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveMaxProdutosPorEnvio, '100'));

  Bufflen := 255;
  AStr := Space(Bufflen);
  AssertEquals(ErrOk, IMendes_ConfigLerValor(Handle, CSessaoIMendes, CChaveMaxProdutosPorEnvio, PChar(AStr), Bufflen));
  AStr := copy(AStr, 1, Bufflen);
  AssertEquals('Erro ao ler MaxProdutosPorEnvio', '100', AStr);

  // Fora da faixa (1..300): a lib limita o valor, sem gerar erro no componente
  AssertEquals('Valor acima do maximo deveria ser limitado', ErrOk,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveMaxProdutosPorEnvio, '999'));
  AssertEquals('Valor abaixo do minimo deveria ser limitado', ErrOk,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveMaxProdutosPorEnvio, '0'));

  // Volta ao padrao
  AssertEquals(ErrOk, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveMaxProdutosPorEnvio, '300'));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_Inativar_ArquivoInexistente;
var
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  Bufflen := 0;
  AssertEquals('Esperado erro de arquivo inexistente', ErrArquivoNaoExiste,
    IMendes_Inativar(Handle, 'C:\NAOEXISTE\IMendes_Inativar.ini', Nil, Bufflen));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.Test_IMendes_RemoveDevolvidos_ArquivoInexistente;
var
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));

  Bufflen := 0;
  AssertEquals('Esperado erro de arquivo inexistente', ErrArquivoNaoExiste,
    IMendes_RemoveDevolvidos(Handle, 'C:\NAOEXISTE\IMendes_RemoveDevolvidos.ini', Nil, Bufflen));

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLib.ConfigurarCredenciaisFicticias(Handle: THandle);
begin
  // Configuracao ficticia: passa na validacao de configuracao do componente (CNPJ/Senha),
  // para que o teste chegue na validacao do request. Nenhum acesso a API e feito.
  AssertEquals(ErrOK, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveAmbiente, '1'));
  AssertEquals(ErrOK, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveCNPJ, '00000000000000'));
  AssertEquals(ErrOK, IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveSenha, 'SenhaTeste123'));
end;

function TTestACBrIMendesLib.LerUltimoRetorno(Handle: THandle): String;
var
  Bufflen: Integer;
begin
  // IMendes_UltimoRetorno devolve o codigo do ultimo retorno (ex.: -10), por isso nao e verificado aqui
  Bufflen := 0;
  IMendes_UltimoRetorno(Handle, Nil, Bufflen);
  Result := StringOfChar(' ', Bufflen);
  IMendes_UltimoRetorno(Handle, PChar(Result), Bufflen);
  Result := copy(Result, 1, Bufflen);
end;

procedure TTestACBrIMendesLib.Test_IMendes_Inativar_SemProdutos;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));
  try
    ConfigurarCredenciaisFicticias(Handle);

    // INI sem secoes [ProdutoNNN]: o componente gera excecao antes de qualquer acesso a API
    Bufflen := 0;
    AssertEquals('Esperado erro de request sem produtos', ErrExecutandoMetodo,
      IMendes_Inativar(Handle, PChar('[Inativar]' + sLineBreak + 'cnpj=00000000000000'), Nil, Bufflen));

    // Tem que ser o erro do request vazio, e nao o de configuracao (CNPJ/Senha)
    AStr := LerUltimoRetorno(Handle);
    AssertTrue('Erro diferente do esperado: ' + AStr, Pos('InativarRequest', AStr) > 0);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

procedure TTestACBrIMendesLib.Test_IMendes_RemoveDevolvidos_SemProdutos;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));
  try
    ConfigurarCredenciaisFicticias(Handle);

    // INI sem secoes [ProdutoNNN]: o componente gera excecao antes de qualquer acesso a API
    Bufflen := 0;
    AssertEquals('Esperado erro de request sem produtos', ErrExecutandoMetodo,
      IMendes_RemoveDevolvidos(Handle, PChar('[RemoveDevolvidos]' + sLineBreak + 'cnpj=00000000000000'), Nil, Bufflen));

    // Tem que ser o erro do request vazio, e nao o de configuracao (CNPJ/Senha)
    AStr := LerUltimoRetorno(Handle);
    AssertTrue('Erro diferente do esperado: ' + AStr, Pos('RemoveDevolvidosRequest', AStr) > 0);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

{ TTestACBrIMendesLibAPI }

procedure TTestACBrIMendesLibAPI.SetUp;
begin
  inherited SetUp;
  fCaminhoExec := ExtractFileDir(ParamStr(0));
end;

procedure TTestACBrIMendesLibAPI.Preparar(var Handle: THandle; const ATipoResposta: String);
begin
  AssertTrue('Preencha as constantes CIMendesCNPJ e CIMendesSenha para executar os testes da API',
    (CIMendesCNPJ <> '') and (CIMendesSenha <> ''));

  AssertEquals(ErrOK, IMendes_Inicializar(Handle, '', ''));
  // TipoResposta: 0 = INI (padrao), 1 = XML, 2 = JSON
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveTipoResposta, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoPrincipal, CChaveTipoResposta, PChar(ATipoResposta)));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveAmbiente, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveAmbiente, CIMendesAmbiente));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveCNPJ, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveCNPJ, CIMendesCNPJ));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveSenha, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveSenha, CIMendesSenha));

  // Log do componente em nivel 4: registra todas as chamadas (URL, headers, request e response)
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveArqLog, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveArqLog, PChar(fCaminhoExec + PathDelim + CIMendesArqLog)));
  AssertEquals('Erro ao Mudar configuracao: ' + CChaveNivelLog, ErrOK,
    IMendes_ConfigGravarValor(Handle, CSessaoIMendes, CChaveNivelLog, '4'));
end;

function TTestACBrIMendesLibAPI.LerUltimoRetorno(Handle: THandle; Bufflen: Integer): String;
begin
  // Space() do FPC recebe Byte e devolve ShortString (max. 255), por isso StringOfChar
  Result := StringOfChar(' ', Bufflen);
  AssertEquals(ErrOk, IMendes_UltimoRetorno(Handle, PChar(Result), Bufflen));
  Result := copy(Result, 1, Bufflen);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_ConsultarRegimesEspeciais;
var
  AStr: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  Preparar(Handle);

  Bufflen := 0;
  Ret := IMendes_ConsultarRegimesEspeciais(Handle, 'SP', False, Nil, Bufflen);
  AStr := LerUltimoRetorno(Handle, Bufflen);

  AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
  AssertTrue('Secao [RegimeEspecial001] nao encontrada', Pos('[RegimeEspecial001]', AStr) > 0);
  AssertTrue('InitialValidity nao preenchido', Pos('InitialValidity=' + sLineBreak, AStr) = 0);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_ConsultarDescricao;
var
  AStr: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  Preparar(Handle);

  Bufflen := 0;
  Ret := IMendes_ConsultarDescricao(Handle, 'MORTADELA', '', 0, Nil, Bufflen);
  AStr := LerUltimoRetorno(Handle, Bufflen);

  AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
  AssertTrue('Resposta vazia', Trim(AStr) <> '');

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_ConsultarAlterados;
var
  AStr: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  Preparar(Handle);

  Bufflen := 0;
  Ret := IMendes_ConsultarAlterados(Handle, 'SP', '', 0, Nil, Bufflen);
  AStr := LerUltimoRetorno(Handle, Bufflen);

  AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
  AssertTrue('Resposta vazia', Trim(AStr) <> '');

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_ConsultarAlterados_Limite;
var
  AStr: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  Preparar(Handle);
  try
    // nLimite = 1: a API retorna no maximo 1 produto ("CNPJ|UF|LIMITE")
    Bufflen := 0;
    Ret := IMendes_ConsultarAlterados(Handle, 'SP', '', 1, Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);

    AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
    VerificarSecao(AStr, 'Cabecalho', True);
    VerificarSecao(AStr, 'Produto002', False);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_HistoricoAcesso;
var
  AStr: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  Preparar(Handle);

  Bufflen := 0;
  Ret := IMendes_HistoricoAcesso(Handle, '', Nil, Bufflen);
  AStr := LerUltimoRetorno(Handle, Bufflen);

  AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
  AssertTrue('Resposta vazia', Trim(AStr) <> '');

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades;
var
  AStr, ArqIni: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  ArqIni := fCaminhoExec + PathDelim + 'IMendes_SaneamentoGrades.ini';
  AssertTrue('Arquivo de entrada nao encontrado: ' + ArqIni, FileExists(ArqIni));

  Preparar(Handle);

  Bufflen := 0;
  Ret := IMendes_SaneamentoGrades(Handle, PChar(ArqIni), Nil, Bufflen);
  AStr := LerUltimoRetorno(Handle, Bufflen);

  AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
  AssertTrue('Secao [Cabecalho] nao encontrada', Pos('[Cabecalho]', AStr) > 0);
  AssertTrue('Secao [Grupo001] nao encontrada', Pos('[Grupo001]', AStr) > 0);
  // INI de exemplo: 2 UFs (PR|SP) x 2 caracTrib (3|1)
  AssertTrue('Secao [UF001002] nao encontrada', Pos('[UF001002]', AStr) > 0);
  AssertTrue('Secao [CaracTrib001002002] nao encontrada', Pos('[CaracTrib001002002]', AStr) > 0);
  // Campos do manual 3.3.26 (presenca da chave; o valor depende da API)
  AssertTrue('Chave AliqAdRem (CBS) nao encontrada', Pos('AliqAdRem=', AStr) > 0);
  AssertTrue('Chave IdGrade (CaracTrib) nao encontrada', Pos('IdGrade=', AStr) > 0);
  AssertTrue('Chave CodGrade (CaracTrib) nao encontrada', Pos('CodGrade=', AStr) > 0);
  AssertTrue('Chave MotDesICMS (CaracTrib) nao encontrada', Pos('MotDesICMS=', AStr) > 0);
  AssertTrue('Chave PDiferIBSUF (IBS) nao encontrada', Pos('PDiferIBSUF=', AStr) > 0);
  AssertTrue('Chave PDiferIBSMun (IBS) nao encontrada', Pos('PDiferIBSMun=', AStr) > 0);
  AssertTrue('Chave ProdCodImendes (Grupo) nao encontrada', Pos('ProdCodImendes=', AStr) > 0);

  AssertEquals(ErrOK, IMendes_Finalizar(Handle));
end;

function TTestACBrIMendesLibAPI.ExecutarSaneamento(const ANomeArquivoIni: String): String;
var
  ArqIni: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  ArqIni := fCaminhoExec + PathDelim + ANomeArquivoIni;
  AssertTrue('Arquivo de entrada nao encontrado: ' + ArqIni, FileExists(ArqIni));

  Preparar(Handle);
  try
    Bufflen := 0;
    Ret := IMendes_SaneamentoGrades(Handle, PChar(ArqIni), Nil, Bufflen);
    Result := LerUltimoRetorno(Handle, Bufflen);

    AssertEquals('Retorno: ' + Result, ErrOK, Ret);
    VerificarSecao(Result, 'Cabecalho', True);
    VerificarSecao(Result, 'Grupo001', True);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

procedure TTestACBrIMendesLibAPI.VerificarSecao(const AResposta, ASecao: String; AExiste: Boolean);
begin
  if AExiste then
    AssertTrue('Secao [' + ASecao + '] nao encontrada', Pos('[' + ASecao + ']', AResposta) > 0)
  else
    AssertTrue('Secao [' + ASecao + '] nao deveria existir', Pos('[' + ASecao + ']', AResposta) = 0);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_CamposObrigatorios;
var
  AStr: String;
begin
  // Somente o conjunto minimo de campos (Manual de Integracao API 3.0 v3.3.25)
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_Obrigatorios.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_CamposOpcionais;
var
  AStr: String;
begin
  // Campos obrigatorios + opcionais do [Emitente], [Perfil] e [Produto001]
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_Opcionais.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_1UF_1CaracTrib;
var
  AStr: String;
begin
  // uf=SP / caracTrib=3
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_1UF_1CaracTrib.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
  VerificarSecao(AStr, 'UF001002', False);
  VerificarSecao(AStr, 'CaracTrib001001002', False);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_2UF_1CaracTrib;
var
  AStr: String;
begin
  // uf=PR|SP / caracTrib=3
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_2UF_1CaracTrib.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'UF001002', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
  VerificarSecao(AStr, 'CaracTrib001002001', True);
  VerificarSecao(AStr, 'CaracTrib001001002', False);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_1UF_2CaracTrib;
var
  AStr: String;
begin
  // uf=SP / caracTrib=3|1
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_1UF_2CaracTrib.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
  VerificarSecao(AStr, 'CaracTrib001001002', True);
  VerificarSecao(AStr, 'UF001002', False);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_SaneamentoGrades_2UF_2CaracTrib;
var
  AStr: String;
begin
  // uf=PR|SP / caracTrib=3|1
  AStr := ExecutarSaneamento('IMendes_SaneamentoGrades_2UF_2CaracTrib.ini');

  VerificarSecao(AStr, 'UF001001', True);
  VerificarSecao(AStr, 'UF001002', True);
  VerificarSecao(AStr, 'CaracTrib001001001', True);
  VerificarSecao(AStr, 'CaracTrib001001002', True);
  VerificarSecao(AStr, 'CaracTrib001002001', True);
  VerificarSecao(AStr, 'CaracTrib001002002', True);
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_LogComponente;
var
  ArqLog: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
  SL: TStringList;
begin
  // O Preparar configura o log do componente ([IMendes] ArqLog e NivelLog=4)
  ArqLog := fCaminhoExec + PathDelim + CIMendesArqLog;

  Preparar(Handle);
  try
    Bufflen := 0;
    Ret := IMendes_ConsultarRegimesEspeciais(Handle, 'SP', False, Nil, Bufflen);
    AssertEquals('Retorno: ' + LerUltimoRetorno(Handle, Bufflen), ErrOK, Ret);
  finally
    IMendes_Finalizar(Handle);
  end;

  AssertTrue('Log do componente nao foi criado: ' + ArqLog, FileExists(ArqLog));

  SL := TStringList.Create;
  try
    SL.LoadFromFile(ArqLog);
    AssertTrue('Log do componente nao registrou a chamada', Pos('SearchSpecialRegime', SL.Text) > 0);
  finally
    SL.Free;
  end;
end;

procedure TTestACBrIMendesLibAPI.VerificarFormato(const ATipoResposta, AMetodo, ARaiz, AResposta: String);
var
  wResp: String;
begin
  wResp := Trim(AResposta);
  AssertTrue(AMetodo + ': resposta vazia', wResp <> '');

  if ATipoResposta = '1' then
  begin
    // XML: elemento raiz = Sessao da resposta (ex.: <SaneamentoGrades>...</SaneamentoGrades>)
    AssertTrue(AMetodo + ': resposta nao e XML: ' + Copy(wResp, 1, 100), Copy(wResp, 1, 1) = '<');
    AssertTrue(AMetodo + ': tag <' + ARaiz + '> nao encontrada', Pos('<' + ARaiz, wResp) > 0);
    AssertTrue(AMetodo + ': tag </' + ARaiz + '> nao encontrada', Pos('</' + ARaiz + '>', wResp) > 0);
  end
  else
  begin
    // JSON: objeto com a Sessao da resposta como chave (ex.: {"SaneamentoGrades": {...}})
    AssertTrue(AMetodo + ': resposta nao e JSON: ' + Copy(wResp, 1, 100), Copy(wResp, 1, 1) = '{');
    AssertTrue(AMetodo + ': chave "' + ARaiz + '" nao encontrada', Pos('"' + ARaiz + '"', wResp) > 0);
    AssertTrue(AMetodo + ': JSON nao terminado em }', Copy(wResp, Length(wResp), 1) = '}');
  end;

  // Nao pode ter saido no formato INI
  AssertTrue(AMetodo + ': resposta saiu em formato INI', Pos('[' + ARaiz + ']', wResp) = 0);
end;

procedure TTestACBrIMendesLibAPI.ExecutarTodasFuncoes(const ATipoResposta: String);
var
  AStr, ArqIni: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  ArqIni := fCaminhoExec + PathDelim + 'IMendes_SaneamentoGrades.ini';
  AssertTrue('Arquivo de entrada nao encontrado: ' + ArqIni, FileExists(ArqIni));

  Preparar(Handle, ATipoResposta);
  try
    Bufflen := 0;
    Ret := IMendes_ConsultarRegimesEspeciais(Handle, 'SP', False, Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);
    AssertEquals('ConsultarRegimesEspeciais: ' + AStr, ErrOK, Ret);
    VerificarFormato(ATipoResposta, 'ConsultarRegimesEspeciais', CSessaoRespRegimesEspeciais, AStr);

    Bufflen := 0;
    Ret := IMendes_ConsultarDescricao(Handle, 'MORTADELA', '', 0, Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);
    AssertEquals('ConsultarDescricao: ' + AStr, ErrOK, Ret);
    VerificarFormato(ATipoResposta, 'ConsultarDescricao', CSessaoRespConsultarDescricao, AStr);

    Bufflen := 0;
    Ret := IMendes_ConsultarAlterados(Handle, 'SP', '', 0, Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);
    AssertEquals('ConsultarAlterados: ' + AStr, ErrOK, Ret);
    VerificarFormato(ATipoResposta, 'ConsultarAlterados', CSessaoRespConsultarAlterados, AStr);

    Bufflen := 0;
    Ret := IMendes_HistoricoAcesso(Handle, '', Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);
    AssertEquals('HistoricoAcesso: ' + AStr, ErrOK, Ret);
    VerificarFormato(ATipoResposta, 'HistoricoAcesso', CSessaoRespHistoricoAcesso, AStr);

    Bufflen := 0;
    Ret := IMendes_SaneamentoGrades(Handle, PChar(ArqIni), Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);
    AssertEquals('SaneamentoGrades: ' + AStr, ErrOK, Ret);
    VerificarFormato(ATipoResposta, 'SaneamentoGrades', CSessaoRespSaneamentoGrades, AStr);
  finally
    // Volta o ACBrLib.ini fisico para o padrao (INI)
    IMendes_ConfigGravarValor(Handle, CSessaoPrincipal, CChaveTipoResposta, '0');
    IMendes_Finalizar(Handle);
  end;
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_TodasFuncoes_RespostaXML;
begin
  ExecutarTodasFuncoes('1');
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_TodasFuncoes_RespostaJSON;
begin
  ExecutarTodasFuncoes('2');
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_Inativar;
var
  AStr, ArqIni: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  // Inativa produtos de verdade: so executa com CIMendesTestarAlteracoes = True
  if not CIMendesTestarAlteracoes then
    Exit;

  ArqIni := fCaminhoExec + PathDelim + 'IMendes_Inativar.ini';
  AssertTrue('Arquivo de entrada nao encontrado: ' + ArqIni, FileExists(ArqIni));

  Preparar(Handle);
  try
    Bufflen := 0;
    Ret := IMendes_Inativar(Handle, PChar(ArqIni), Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);

    AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
    VerificarSecao(AStr, CSessaoRespInativar, True);
    // Retorno da API: {"message": "Produtos inativados com sucesso."}
    AssertTrue('Sucesso nao informado: ' + AStr, Pos('Sucesso=1', AStr) > 0);
    AssertTrue('Mensagem de retorno vazia: ' + AStr, Pos('Mensagem=' + sLineBreak, AStr + sLineBreak) = 0);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

procedure TTestACBrIMendesLibAPI.Test_IMendes_RemoveDevolvidos;
var
  AStr, ArqIni: String;
  Bufflen, Ret: Integer;
  Handle: THandle;
begin
  // Remove produtos da lista de devolvidos: so executa com CIMendesTestarAlteracoes = True
  if not CIMendesTestarAlteracoes then
    Exit;

  ArqIni := fCaminhoExec + PathDelim + 'IMendes_RemoveDevolvidos.ini';
  AssertTrue('Arquivo de entrada nao encontrado: ' + ArqIni, FileExists(ArqIni));

  Preparar(Handle);
  try
    Bufflen := 0;
    Ret := IMendes_RemoveDevolvidos(Handle, PChar(ArqIni), Nil, Bufflen);
    AStr := LerUltimoRetorno(Handle, Bufflen);

    AssertEquals('Retorno: ' + AStr, ErrOK, Ret);
    VerificarSecao(AStr, CSessaoRespRemoveDevolvidos, True);
    // Retorno da API: {"sucesso": true, "mensagem": "N removido(s) com sucesso..."}
    AssertTrue('Sucesso nao informado: ' + AStr, Pos('Sucesso=1', AStr) > 0);
    AssertTrue('Mensagem de retorno nao encontrada: ' + AStr, Pos('removido(s)', AStr) > 0);
  finally
    IMendes_Finalizar(Handle);
  end;
end;

initialization

  RegisterTest(TTestACBrIMendesLib);
  RegisterTest(TTestACBrIMendesLibAPI);

end.

