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

unit ACBrDeRE.Limpeza;

interface

uses
  SysUtils, Classes;

type
  { TLimpezaDeRE - pedido de limpeza dos dados do contribuinte na Producao Restrita
    (DELETE <URL>/<CNPJ base>) }

  TLimpezaDeRE = class(TObject)
  private
    FnrInsc: string;
  public
    // CNPJ base (8 posicoes, letras e numeros) valido para a requisicao
    function NrInscValido: Boolean;
    // Monta o endereco da limpeza: o CNPJ base e o ultimo segmento da URL
    function MontarURL(const AURLBase: string): string;

    property nrInsc: string read FnrInsc write FnrInsc;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TLimpezaDeRE }

function TLimpezaDeRE.NrInscValido: Boolean;
begin
  Result := Length(OnlyCPFCNPJAlphaNum(FnrInsc)) = 8;
end;

function TLimpezaDeRE.MontarURL(const AURLBase: string): string;
begin
  Result := AURLBase;

  while (Result <> '') and (Result[Length(Result)] = '/') do
    Delete(Result, Length(Result), 1);

  if Result <> '' then
    Result := Result + '/' + OnlyCPFCNPJAlphaNum(FnrInsc);
end;

end.
