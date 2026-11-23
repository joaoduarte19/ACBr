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

unit ACBrDeRE.D1198.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1198.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREReabertMensalIniWriter - grava o INI do evento evtReabertMensal (D-1198) }

  TDeREReabertMensalIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtReabertMensal;

    procedure Gravar_infoReabertura(AINIRec: TMemIniFile; A: TinfoReaberturaD1198; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREReabertMensalIniWriter }

function TDeREReabertMensalIniWriter.Evt: TevtReabertMensal;
begin
  Result := (DeRE as TDeRED1198).evtReabertMensal;
end;

procedure TDeREReabertMensalIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEvento(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Gravar_infoReabertura(AINIRec, Evt.infoReabertura, '');
end;

procedure TDeREReabertMensalIniWriter.Gravar_infoReabertura(AINIRec: TMemIniFile; A: TinfoReaberturaD1198; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoReabertura' + ASufixo;

  AINIRec.WriteString(sSecao, 'nrReciboReab', A.nrReciboReab);
end;

initialization
  RegistrarIniWriterDeRE(teReabertMensal, TDeREReabertMensalIniWriter);

end.
