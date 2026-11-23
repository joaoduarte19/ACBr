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

unit ACBrDeRE.D1101.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREBalanceteIniReader - le o INI do evento evtBalancete (D-1101) }

  TDeREBalanceteIniReader = class(TDeREIniReader)
  private
    function Evt: TevtBalancete;

    procedure Ler_infoBalancete(AINIRec: TMemIniFile; A: TinfoBalanceteD1101; const ASufixo: string);
    procedure Ler_infoContas(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionD1101; const ASufixo: string);
    procedure Ler_infoConta(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionItemD1101; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREBalanceteIniReader }

function TDeREBalanceteIniReader.Evt: TevtBalancete;
begin
  Result := (DeRE as TDeRED1101).evtBalancete;
end;

procedure TDeREBalanceteIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoBalancete.TeminfoBalancete := AINIRec.SectionExists('infoConta' + '001');
  if Evt.infoBalancete.TeminfoBalancete then
    Ler_infoBalancete(AINIRec, Evt.infoBalancete, '');
end;

procedure TDeREBalanceteIniReader.Ler_infoBalancete(AINIRec: TMemIniFile; A: TinfoBalanceteD1101; const ASufixo: string);
begin

  Ler_infoContas(AINIRec, A.infoContas, ASufixo);
end;

procedure TDeREBalanceteIniReader.Ler_infoContas(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionD1101; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('infoConta' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_infoConta(AINIRec, A.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREBalanceteIniReader.Ler_infoConta(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionItemD1101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoConta' + ASufixo;

  A.cCta := AINIRec.ReadString(sSecao, 'cCta', '');
  A.natSaldoInic := StrTonatSaldoDeRE(AINIRec.ReadString(sSecao, 'natSaldoInic', 'D'));
  A.vSaldoInic := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoInic', '0'), 0);
  A.vMovDebt := StringToFloatDef(AINIRec.ReadString(sSecao, 'vMovDebt', '0'), 0);
  A.TemvAjusteDebt := AINIRec.ValueExists(sSecao, 'vAjusteDebt');
  if A.TemvAjusteDebt then
    A.vAjusteDebt := StringToFloatDef(AINIRec.ReadString(sSecao, 'vAjusteDebt', '0'), 0);
  A.vMovCred := StringToFloatDef(AINIRec.ReadString(sSecao, 'vMovCred', '0'), 0);
  A.TemvAjusteCred := AINIRec.ValueExists(sSecao, 'vAjusteCred');
  if A.TemvAjusteCred then
    A.vAjusteCred := StringToFloatDef(AINIRec.ReadString(sSecao, 'vAjusteCred', '0'), 0);
  A.natSaldoFinal := StrTonatSaldoDeRE(AINIRec.ReadString(sSecao, 'natSaldoFinal', 'D'));
  A.vSaldoFinal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoFinal', '0'), 0);
  A.TemnatVApur := AINIRec.ValueExists(sSecao, 'natVApur');
  if A.TemnatVApur then
    A.natVApur := StrTonatSaldoDeRE(AINIRec.ReadString(sSecao, 'natVApur', 'D'));
  A.vApur := StringToFloatDef(AINIRec.ReadString(sSecao, 'vApur', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teBalancete, TDeREBalanceteIniReader);

end.
