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

unit ACBrDeRE.D1198.Classes;

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
  ACBrDeRE.Conversao,
  ACBrDeRE.Classes;

type

  { TinfoReaberturaD1198 }

  TinfoReaberturaD1198 = class(TObject)
  private
    FnrReciboReab: string;
  public
    // Recibo do evento D-1199 (Fechamento Mensal) do periodo a ser reaberto
    property nrReciboReab: string read FnrReciboReab write FnrReciboReab;
  end;

  { TevtReabertMensal }

  TevtReabertMensal = class(TDeREEvento)
  private
    FideEvento: TideEvento;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoReabertura: TinfoReaberturaD1198;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEvento read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoReabertura: TinfoReaberturaD1198 read FinfoReabertura write FinfoReabertura;
  end;

  { TDeRED1198 - documento DeRE do evento D-1198 }

  TDeRED1198 = class(TDeRE)
  private
    FevtReabertMensal: TevtReabertMensal;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtReabertMensal: TevtReabertMensal read FevtReabertMensal write FevtReabertMensal;
  end;

implementation

{ TevtReabertMensal }

constructor TevtReabertMensal.Create;
begin
  inherited Create;
  FideEvento := TideEvento.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoReabertura := TinfoReaberturaD1198.Create;
end;

destructor TevtReabertMensal.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoReabertura.Free;
  inherited Destroy;
end;

function TevtReabertMensal.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teReabertMensal;
end;

{ TDeRED1198 }

constructor TDeRED1198.Create;
begin
  inherited Create;
  FevtReabertMensal := TevtReabertMensal.Create;
end;

destructor TDeRED1198.Destroy;
begin
  FevtReabertMensal.Free;
  inherited Destroy;
end;

function TDeRED1198.GetEvento: TDeREEvento;
begin
  Result := FevtReabertMensal;
end;

initialization
  RegistrarDeRE(teReabertMensal, TDeRED1198);

end.
