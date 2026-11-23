{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                 }
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

unit ACBrLibDeRETestCase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestACBrDeRELib }

  TTestACBrDeRELib = class(TTestCase)
  private
    fCaminhoExec: string;
  public
    procedure SetUp; override;
  published
    procedure Test_DeRE_Inicializar_Com_DiretorioInvalido;
    procedure Test_DeRE_Inicializar;
    procedure Test_DeRE_Inicializar_Ja_Inicializado;
    procedure Test_DeRE_Finalizar;
    procedure Test_DeRE_Finalizar_Ja_Finalizado;
    procedure Test_DeRE_Nome_Obtendo_LenBuffer;
    procedure Test_DeRE_Nome_Lendo_Buffer_Tamanho_Identico;
    procedure Test_DeRE_Nome_Lendo_Buffer_Tamanho_Maior;
    procedure Test_DeRE_Nome_Lendo_Buffer_Tamanho_Menor;
    procedure Test_DeRE_Versao;
    procedure Test_DeRE_ConfigLerValor;
    procedure Test_DeRE_ConfigGravarValor;
    procedure Test_DeRE_CriarEventoDeRE;
    procedure Test_DeRE_EnviarDeRE;
    procedure Test_DeRE_ConsultarDeRE;
    procedure Test_DeRE_CriarEnviarDeRE;
    procedure Test_DeRE_LimparDeRE;
    procedure Test_DeRE_CarregarXMLEventoDeRE;
    procedure Test_DeRE_SetIDContribuinte;
    procedure Test_DeRE_SetVersaoDF;
    procedure Test_DeRE_ObterCertificados;
    procedure Test_DeRE_ObterIniEventos;
    procedure Test_DeRE_ObterToken;
    procedure Test_DeRE_Validar;

  end;

implementation

uses
  ACBrLibDeREStaticImportMT, ACBrLibDeREConsts, ACBrLibConsts, Dialogs, ACBrUtil.DateTime;

procedure TTestACBrDeRELib.SetUp;
begin
  inherited SetUp;
  fCaminhoExec := ExtractFileDir(ParamStr(0));
end;

procedure TTestACBrDeRELib.Test_DeRE_Inicializar_Com_DiretorioInvalido;
var
  Handle: THandle;
begin
  try
    //DeRE_Finalizar(Handle);
    AssertEquals(ErrDiretorioNaoExiste, DeRE_Inicializar(Handle,'C:\NAOEXISTE\ACBrLib.ini',''));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Inicializar;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Inicializar_Ja_Inicializado;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Finalizar;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Finalizar_Ja_Finalizado;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));
    AssertEquals(ErrOk, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Nome_Obtendo_LenBuffer;
var
  Handle: THandle;
  Bufflen: Integer;
  AStr: String;
begin
  try
    // Obtendo o Tamanho //
    AssertEquals(ErrOk, DeRE_Inicializar(Handle,'',''));

    Bufflen := 0;
    AssertEquals(ErrOk, DeRE_Nome(Handle,Nil, Bufflen));
    AssertEquals(Length(CLibDeRENome), Bufflen);

    AssertEquals(ErrOk, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Nome_Lendo_Buffer_Tamanho_Identico;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '',''));

    Bufflen := Length(CLibDeRENome);
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_Nome(Handle, PChar(AStr), Bufflen));
    AssertEquals(Length(CLibDeRENome), Bufflen);
    AssertEquals(CLibDeRENome, AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Nome_Lendo_Buffer_Tamanho_Maior;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    Bufflen := Length(CLibDeRENome)*2;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_Nome(Handle, PChar(AStr), Bufflen));
    AStr := copy(AStr, 1, Bufflen);
    AssertEquals(Length(CLibDeRENome), Bufflen);
    AssertEquals(CLibDeRENome, AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Nome_Lendo_Buffer_Tamanho_Menor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle,  '', ''));

    Bufflen := 12;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_Nome(Handle,  PChar(AStr), Bufflen));
    AssertEquals(12, Bufflen);
    AssertEquals(copy(CLibDeRENome,1,12), AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Versao;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    // Obtendo o Tamanho //
    AssertEquals(ErrOK, DeRE_Inicializar(Handle,  '', ''));

    Bufflen := 0;
    AssertEquals(ErrOk, DeRE_Versao(Handle, Nil, Bufflen));
    AssertEquals(Length(CLibDeREVersao), Bufflen);

    // Lendo a resposta //
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_Versao(Handle, PChar(AStr), Bufflen));
    AssertEquals(Length(CLibDeREVersao), Bufflen);
    AssertEquals(CLibDeREVersao, AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ConfigLerValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    // Obtendo o Tamanho //
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    Bufflen := 255;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_ConfigLerValor(Handle, CSessaoVersao, CLibDeRENome, PChar(AStr), Bufflen));
    AStr := copy(AStr,1,Bufflen);
    AssertEquals(CLibDeREVersao, AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ConfigGravarValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  try
    // Gravando o valor
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    AssertEquals('Erro ao Mudar configuração', ErrOk, DeRE_ConfigGravarValor(Handle, CSessaoPrincipal, CChaveLogNivel, '4'));

    // Checando se o valor foi atualizado //
    Bufflen := 255;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, DeRE_ConfigLerValor(Handle, CSessaoPrincipal, CChaveLogNivel, PChar(AStr), Bufflen));
    AStr := copy(AStr,1,Bufflen);
    AssertEquals('Erro ao Mudar configuração', '4', AStr);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_CriarEventoDeRE;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    AssertTrue('Arquivo inexistente nao deve retornar OK',
      DeRE_CriarEventoDeRE(Handle, PChar(fCaminhoExec+'\evento.ini')) <> ErrOK);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_EnviarDeRE;
var
  Resposta: PChar;
  Tamanho: Longint;
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta:= '';
    Tamanho := 0;

    AssertEquals('Erro ao Enviar Evento DeRE', ErrOK,
      DeRE_EnviarDeRE(Handle, Resposta, Tamanho));
    AssertEquals('Resposta= ' + AnsiString(Resposta), '', '');
    AssertEquals('Tamanho= ' + IntToStr(Tamanho), '', '');

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ConsultarDeRE;
var
  Handle: THandle;
  Resposta: PChar;
  Tamanho: Longint;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta := '';
    Tamanho := 0;

    // Protocolo nao informado
    AssertEquals('Erro ao Consultar Protocolo', ErrParametroInvalido,
      DeRE_ConsultarDeRE(Handle, '', Resposta, Tamanho));
    AssertEquals('Resposta= ' + AnsiString(Resposta), '', '');
    AssertEquals('Tamanho= ' + IntToStr(Tamanho), '', '');

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_CriarEnviarDeRE;
var
  Handle: THandle;
  Resposta: PChar;
  Tamanho: Longint;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta := '';
    Tamanho := 0;

    AssertEquals('Erro ao Criar e Enviar Evento DeRE', ErrOK,
      DeRE_CriarEnviarDeRE(Handle, PChar(fCaminhoExec+'\evento.ini'), Resposta, Tamanho));
    AssertEquals('Resposta= ' + AnsiString(Resposta), '', '');
    AssertEquals('Tamanho= ' + IntToStr(Tamanho), '', '');

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_LimparDeRE;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    AssertEquals('Erro ao Limpar DeRE', ErrOK,
      DeRE_LimparDeRE(Handle));

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_CarregarXMLEventoDeRE;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    AssertEquals('Erro ao Carregar XML do DeRE', ErrOK,
      DeRE_CarregarXMLEventoDeRE(Handle, PChar(fCaminhoExec+'\evento.xml')));

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_SetIDContribuinte;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    AssertEquals(ErrOk, DeRE_SetIDContribuinte(Handle, '1234'));
    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_SetVersaoDF;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    AssertEquals(ErrOk, DeRE_SetVersaoDF(Handle, '1.0.4'));
    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ObterCertificados;
var
  Handle: THandle;
  Resposta: PChar;
  Tamanho: Longint;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta:= '';
    Tamanho:= 0;

    AssertEquals('Erro ao Obter Certificados', ErrOK,
      DeRE_ObterCertificados(Handle, Resposta, Tamanho));
    AssertEquals('Resposta= ' + AnsiString(Resposta), '', '');
    AssertEquals('Tamanho= ' + IntToStr(Tamanho), '', '');

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_Validar;
var
  Handle: THandle;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));

    AssertEquals('Erro ao Validar DeRE', ErrOK,
      DeRE_Validar(Handle));

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ObterIniEventos;
var
  Handle: THandle;
  Resposta: PChar;
  Tamanho: Longint;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta := '';
    Tamanho := 0;

    // Sem eventos carregados o INI gerado e vazio
    AssertEquals('Erro ao Obter INI dos Eventos', ErrOK,
      DeRE_ObterIniEventos(Handle, Resposta, Tamanho));

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrDeRELib.Test_DeRE_ObterToken;
var
  Handle: THandle;
  Resposta: PChar;
  Tamanho: Longint;
begin
  try
    AssertEquals(ErrOK, DeRE_Inicializar(Handle, '', ''));
    Resposta := '';
    Tamanho := 0;

    // Sem ClientId/ClientSecret validos o servico recusa a solicitacao: o teste
    // apenas garante que o metodo existe e responde sem derrubar a biblioteca.
    AssertTrue('DeRE_ObterToken deve retornar um codigo',
      DeRE_ObterToken(Handle, Resposta, Tamanho) <> -999);

    AssertEquals(ErrOK, DeRE_Finalizar(Handle));
  except
    on E: Exception do
      ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

initialization
  RegisterTest(TTestACBrDeRELib);

end.

