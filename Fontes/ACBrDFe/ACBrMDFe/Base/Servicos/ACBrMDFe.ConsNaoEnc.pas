{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

{$I ACBr.inc}

unit ACBrMDFe.ConsNaoEnc;

interface

uses
  SysUtils, Classes,
  pcnConversao;

type

  TConsMDFeNaoEnc = class(TObject)
  private
    FtpAmb: TpcnTipoAmbiente;
    FCNPJCPF: String;
    FVersao: String;
  public
    function GerarXML: string;

    property tpAmb: TpcnTipoAmbiente read FtpAmb   write FtpAmb;
    property CNPJCPF: String         read FCNPJCPF write FCNPJCPF;
    property Versao: String          read FVersao  write FVersao;
  end;

implementation

uses
  ACBrUtil.Strings,
  ACBrMDFe.Consts;

{ TConsMDFeNaoEnc }

function TConsMDFeNaoEnc.GerarXML: string;
var
  nDoc, xTagDoc: string;
begin
  nDoc := OnlyCPFCNPJAlphaNum(FCNPJCPF);

  if Length(nDoc) = 14 then
    xTagDoc := '<CNPJ>' + nDoc + '</CNPJ>'
  else
    xTagDoc := '<CPF>' + nDoc + '</CPF>';

  Result := '<consMDFeNaoEnc ' + NAME_SPACE_MDFe + ' versao="' + versao + '">' +
              '<tpAmb>' + tpAmbToStr(tpAmb) + '</tpAmb>' +
              '<xServ>' + ACBrStr('CONSULTAR NÃO ENCERRADOS') + '</xServ>' +
              xTagDoc +
            '</consMDFeNaoEnc>';
end;

end.

