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

unit ACBrDeRE.D1101.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREBalanceteIniWriter - grava o INI do evento evtBalancete (D-1101) }

  TDeREBalanceteIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtBalancete;

    procedure Gravar_infoBalancete(AINIRec: TMemIniFile; A: TinfoBalanceteD1101; const ASufixo: string);
    procedure Gravar_infoContas(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionD1101; const ASufixo: string);
    procedure Gravar_infoConta(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionItemD1101; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREBalanceteIniWriter }

function TDeREBalanceteIniWriter.Evt: TevtBalancete;
begin
  Result := (DeRE as TDeRED1101).evtBalancete;
end;

procedure TDeREBalanceteIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoBalancete.TeminfoBalancete then
    Gravar_infoBalancete(AINIRec, Evt.infoBalancete, '');
end;

procedure TDeREBalanceteIniWriter.Gravar_infoBalancete(AINIRec: TMemIniFile; A: TinfoBalanceteD1101; const ASufixo: string);
begin

  Gravar_infoContas(AINIRec, A.infoContas, ASufixo);
end;

procedure TDeREBalanceteIniWriter.Gravar_infoContas(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionD1101; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.Count - 1 do
    Gravar_infoConta(AINIRec, A[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREBalanceteIniWriter.Gravar_infoConta(AINIRec: TMemIniFile; A: TinfoContaBalanceteCollectionItemD1101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoConta' + ASufixo;

  AINIRec.WriteString(sSecao, 'cCta', A.cCta);
  AINIRec.WriteString(sSecao, 'natSaldoInic', natSaldoDeREToStr(A.natSaldoInic));
  AINIRec.WriteString(sSecao, 'vSaldoInic', StringReplace(FormatFloat('0.00', A.vSaldoInic), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vMovDebt', StringReplace(FormatFloat('0.00', A.vMovDebt), ',', '.', []));
  if A.TemvAjusteDebt then
    AINIRec.WriteString(sSecao, 'vAjusteDebt', StringReplace(FormatFloat('0.00', A.vAjusteDebt), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vMovCred', StringReplace(FormatFloat('0.00', A.vMovCred), ',', '.', []));
  if A.TemvAjusteCred then
    AINIRec.WriteString(sSecao, 'vAjusteCred', StringReplace(FormatFloat('0.00', A.vAjusteCred), ',', '.', []));
  AINIRec.WriteString(sSecao, 'natSaldoFinal', natSaldoDeREToStr(A.natSaldoFinal));
  AINIRec.WriteString(sSecao, 'vSaldoFinal', StringReplace(FormatFloat('0.00', A.vSaldoFinal), ',', '.', []));
  if A.TemnatVApur then
    AINIRec.WriteString(sSecao, 'natVApur', natSaldoDeREToStr(A.natVApur));
  AINIRec.WriteString(sSecao, 'vApur', StringReplace(FormatFloat('0.00', A.vApur), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teBalancete, TDeREBalanceteIniWriter);

end.
