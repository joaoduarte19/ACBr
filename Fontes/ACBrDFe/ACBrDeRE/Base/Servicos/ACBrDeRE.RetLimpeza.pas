{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

{$I ACBr.inc}

unit ACBrDeRE.RetLimpeza;

interface

uses
  SysUtils, Classes;

type
  { TRetLimpezaDeRE - retorno da limpeza. O manual (v1.0.2, item 4.7) so define os
    codigos HTTP: 200 sucesso; 400 CNPJ invalido; 401 token; 403 sem permissao para o
    CNPJ; 405 metodo diferente de DELETE; 500 erro interno. }

  TRetLimpezaDeRE = class(TObject)
  private
    FHttpCodigo: Integer;
    FCorpo: string;
    FMsg: string;
  public
    procedure Clear;
    // True se a limpeza foi realizada. Msg traz a descricao do codigo HTTP.
    // HttpCodigo = 0: transmissao feita pela aplicacao (OnTransmit) sem informar o
    // codigo; considera-se sucesso apenas se o corpo vier vazio.
    function Interpretar: Boolean;

    property HttpCodigo: Integer read FHttpCodigo write FHttpCodigo;
    property Corpo: string read FCorpo write FCorpo;
    property Msg: string read FMsg;
  end;

implementation

{ TRetLimpezaDeRE }

procedure TRetLimpezaDeRE.Clear;
begin
  FHttpCodigo := 0;
  FCorpo := '';
  FMsg := '';
end;

function TRetLimpezaDeRE.Interpretar: Boolean;
begin
  Result := False;

  case FHttpCodigo of
    0:   begin
           // Nenhum codigo HTTP retornado: a requisicao nao foi realizada
           FMsg := 'Sem resposta HTTP do servidor (codigo HTTP nao informado).';
         end;
    200: begin
           Result := True;
           FMsg := 'Limpeza realizada com sucesso.';
           Exit;
         end;
    400: FMsg := 'CNPJ do declarante invalido.';
    401: FMsg := 'Falha na autenticacao do token do Receita Integra.';
    403: FMsg := 'Credencial sem permissao para limpar os dados do CNPJ informado.';
    405: FMsg := 'Metodo HTTP diferente de DELETE.';
    500: FMsg := 'Erro interno nao esperado.';
  else
    FMsg := 'Erro HTTP ' + IntToStr(FHttpCodigo) + '.';
  end;

  // O corpo da resposta nao entra na mensagem; segue em Corpo, no log e no arquivo salvo.
  FMsg := FMsg + ' (HTTP ' + IntToStr(FHttpCodigo) + ')';
end;

end.
