{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit ACBrNFeABI.ConsSit;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFeUtil;

type

  TConsSitNFeABI = class
  private
    FtpAmb: TACBrTipoAmbiente;
    FchNFeABI: string;
    FVersao: string;
  public
    function GerarXML: string;
    function ObterNomeArquivo: string;

    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property chNFeABI: string read FchNFeABI write FchNFeABI;
    property Versao: string read FVersao write FVersao;
  end;

implementation

uses
  ACBrUtil.Strings,
  ACBrNFeABI.Consts;

{ TConsSitNFeABI }

function TConsSitNFeABI.ObterNomeArquivo: string;
begin
  Result := RemoverLiteralChave(FchNFeABI) + '-ped-sit.xml';
end;

function TConsSitNFeABI.GerarXML: string;
begin
  Result := '<consSitNFeABI ' + NAME_SPACE_NFeABI + ' versao="' + versao + '">' +
              '<tpAmb>' + TipoAmbienteToStr(tpAmb) + '</tpAmb>' +
              '<xServ>CONSULTAR</xServ>' +
              '<chNFeABI>' + chNFeABI + '</chNFeABI>' +
            '</consSitNFeABI>';
end;

end.

