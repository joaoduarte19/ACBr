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

unit ACBrDeRE.D1198.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1198.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREReabertMensalIniReader - le o INI do evento evtReabertMensal (D-1198) }

  TDeREReabertMensalIniReader = class(TDeREIniReader)
  private
    function Evt: TevtReabertMensal;

    procedure Ler_infoReabertura(AINIRec: TMemIniFile; A: TinfoReaberturaD1198; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREReabertMensalIniReader }

function TDeREReabertMensalIniReader.Evt: TevtReabertMensal;
begin
  Result := (DeRE as TDeRED1198).evtReabertMensal;
end;

procedure TDeREReabertMensalIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEvento(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Ler_infoReabertura(AINIRec, Evt.infoReabertura, '');
end;

procedure TDeREReabertMensalIniReader.Ler_infoReabertura(AINIRec: TMemIniFile; A: TinfoReaberturaD1198; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoReabertura' + ASufixo;

  A.nrReciboReab := AINIRec.ReadString(sSecao, 'nrReciboReab', '');
end;

initialization
  RegistrarIniReaderDeRE(teReabertMensal, TDeREReabertMensalIniReader);

end.
