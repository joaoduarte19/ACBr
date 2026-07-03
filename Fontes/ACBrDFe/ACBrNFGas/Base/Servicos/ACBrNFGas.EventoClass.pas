{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFGas.EventoClass;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGas.Conversao;

type
  EventoException = class(Exception);

  TDetEvento = class
  private
    FVersao: string;
    FDescEvento: string;
    FnProt: string;
    FxJust: string;
    FidPedidoCancelado: string;
  public
    property versao: string read FVersao write FVersao;
    property descEvento: string read FDescEvento write FDescEvento;
    property nProt: string read FnProt write FnProt;
    property xJust: string read FxJust write FxJust;
    property idPedidoCancelado: string read FidPedidoCancelado write FidPedidoCancelado;
  end;

  TInfEvento = class
  private
    FID: string;
    FtpAmbiente: TACBrTipoAmbiente;
    FCNPJ: string;
    FcOrgao: Integer;
    FChave: string;
    FDataEvento: TDateTime;
    FTpEvento: TACBrTipoEvento;
    FnSeqEvento: Integer;
    FDetEvento: TDetEvento;

    function getcOrgao: Integer;
    function getDescEvento: string;
    function getTipoEvento: string;
  public
    constructor Create;
    destructor Destroy; override;

    function DescricaoTipoEvento(TipoEvento: TACBrTipoEvento): string;

    property id: string read FID write FID;
    property cOrgao: Integer read getcOrgao write FcOrgao;
    property tpAmb: TACBrTipoAmbiente read FtpAmbiente write FtpAmbiente;
    property CNPJ: string read FCNPJ write FCNPJ;
    property chNFGas: string read FChave write FChave;
    property dhEvento: TDateTime read FDataEvento write FDataEvento;
    property tpEvento: TACBrTipoEvento read FTpEvento write FTpEvento;
    property nSeqEvento: Integer read FnSeqEvento write FnSeqEvento;
    property detEvento: TDetEvento read FDetEvento write FDetEvento;
    property DescEvento: string read getDescEvento;
    property TipoEvento: string read getTipoEvento;
  end;

  TRetInfEvento = class(TObject)
  private
    FId: string;
    FNomeArquivo: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcOrgao: Integer;
    FcStat: Integer;
    FxMotivo: string;
    FchNFGas: string;
    FtpEvento: TACBrTipoEvento;
    FxEvento: string;
    FnSeqEvento: Integer;
    FCNPJDest: string;
    FemailDest: string;
    FcOrgaoAutor: Integer;
    FdhRegEvento: TDateTime;
    FnProt: string;
    FXML: AnsiString;
  public
    property Id: string read FId write FId;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cOrgao: Integer read FcOrgao write FcOrgao;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property chNFGas: string read FchNFGas write FchNFGas;
    property tpEvento: TACBrTipoEvento read FtpEvento write FtpEvento;
    property xEvento: string read FxEvento write FxEvento;
    property nSeqEvento: Integer read FnSeqEvento write FnSeqEvento;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property emailDest: string read FemailDest write FemailDest;
    property cOrgaoAutor: Integer read FcOrgaoAutor write FcOrgaoAutor;
    property dhRegEvento: TDateTime read FdhRegEvento write FdhRegEvento;
    property nProt: string read FnProt write FnProt;
    property XML: AnsiString read FXML write FXML;
    property NomeArquivo: string read FNomeArquivo write FNomeArquivo;
  end;

implementation

constructor TInfEvento.Create;
begin
  inherited Create;
  FDetEvento := TDetEvento.Create;
end;

destructor TInfEvento.Destroy;
begin
  FDetEvento.Free;
  inherited;
end;

function TInfEvento.getcOrgao: Integer;
begin
  if FcOrgao <> 0 then
    Result := FcOrgao
  else
    Result := StrToIntDef(Copy(FChave, 1, 2), 0);
end;

function TInfEvento.getDescEvento: string;
begin
  case FTpEvento of
    teCancelamento:
      Result := 'Cancelamento';
  else
    Result := '';
  end;
end;

function TInfEvento.getTipoEvento: string;
begin
  try
    Result := TpEventoToStr(FTpEvento);
  except
    Result := '';
  end;
end;

function TInfEvento.DescricaoTipoEvento(TipoEvento: TACBrTipoEvento): string;
begin
  case TipoEvento of
    teCancelamento:
      Result := 'CANCELAMENTO DE NFGas';
  else
    Result := 'Nao Definido';
  end;
end;

end.
