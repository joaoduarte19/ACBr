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

unit ACBrDeRE.D1106.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1106.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREAplicResTecIniReader - le o INI do evento evtAplicResTec (D-1106) }

  TDeREAplicResTecIniReader = class(TDeREIniReader)
  private
    function Evt: TevtAplicResTec;

    procedure Ler_infoAplicResTec(AINIRec: TMemIniFile; A: TinfoAplicResTecD1106; const ASufixo: string);
    procedure Ler_infoAplic(AINIRec: TMemIniFile; A: TinfoAplicCollectionItemD1106; const ASufixo: string);
    procedure Ler_detAtivo(AINIRec: TMemIniFile; A: TdetAtivoCollectionItemD1106; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREAplicResTecIniReader }

function TDeREAplicResTecIniReader.Evt: TevtAplicResTec;
begin
  Result := (DeRE as TDeRED1106).evtAplicResTec;
end;

procedure TDeREAplicResTecIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoAplicResTec.TeminfoAplicResTec := AINIRec.SectionExists('infoAplicResTec');
  if Evt.infoAplicResTec.TeminfoAplicResTec then
    Ler_infoAplicResTec(AINIRec, Evt.infoAplicResTec, '');
end;

procedure TDeREAplicResTecIniReader.Ler_infoAplicResTec(AINIRec: TMemIniFile; A: TinfoAplicResTecD1106; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoAplicResTec' + ASufixo;

  A.semAplic := (AINIRec.ReadString(sSecao, 'semAplic', '') = '1');

  i := 1;
  while AINIRec.SectionExists('infoAplic' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_infoAplic(AINIRec, A.infoAplic.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREAplicResTecIniReader.Ler_infoAplic(AINIRec: TMemIniFile; A: TinfoAplicCollectionItemD1106; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoAplic' + ASufixo;

  A.cCta := AINIRec.ReadString(sSecao, 'cCta', '');

  i := 1;
  while AINIRec.SectionExists('detAtivo' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detAtivo(AINIRec, A.detAtivo.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREAplicResTecIniReader.Ler_detAtivo(AINIRec: TMemIniFile; A: TdetAtivoCollectionItemD1106; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detAtivo' + ASufixo;

  A.idAtivo := AINIRec.ReadString(sSecao, 'idAtivo', '');
  A.descAtivo := AINIRec.ReadString(sSecao, 'descAtivo', '');
  A.vSaldoInic := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoInic', '0'), 0);
  A.TemvRendPerReceb := AINIRec.ValueExists(sSecao, 'vRendPerReceb');
  if A.TemvRendPerReceb then
    A.vRendPerReceb := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRendPerReceb', '0'), 0);
  A.TemvVarMensal := AINIRec.ValueExists(sSecao, 'vVarMensal');
  if A.TemvVarMensal then
    A.vVarMensal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vVarMensal', '0'), 0);
  A.vPrincLiqResg := StringToFloatDef(AINIRec.ReadString(sSecao, 'vPrincLiqResg', '0'), 0);
  A.TemvRendLiqResg := AINIRec.ValueExists(sSecao, 'vRendLiqResg');
  if A.TemvRendLiqResg then
    A.vRendLiqResg := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRendLiqResg', '0'), 0);
  A.vSaldoFinal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoFinal', '0'), 0);
  A.vApur := StringToFloatDef(AINIRec.ReadString(sSecao, 'vApur', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teAplicResTec, TDeREAplicResTecIniReader);

end.
