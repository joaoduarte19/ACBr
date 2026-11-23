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

unit ACBrDeRE.D1106.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1106.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREAplicResTecIniWriter - grava o INI do evento evtAplicResTec (D-1106) }

  TDeREAplicResTecIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtAplicResTec;

    procedure Gravar_infoAplicResTec(AINIRec: TMemIniFile; A: TinfoAplicResTecD1106; const ASufixo: string);
    procedure Gravar_infoAplic(AINIRec: TMemIniFile; A: TinfoAplicCollectionItemD1106; const ASufixo: string);
    procedure Gravar_detAtivo(AINIRec: TMemIniFile; A: TdetAtivoCollectionItemD1106; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREAplicResTecIniWriter }

function TDeREAplicResTecIniWriter.Evt: TevtAplicResTec;
begin
  Result := (DeRE as TDeRED1106).evtAplicResTec;
end;

procedure TDeREAplicResTecIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoAplicResTec.TeminfoAplicResTec then
    Gravar_infoAplicResTec(AINIRec, Evt.infoAplicResTec, '');
end;

procedure TDeREAplicResTecIniWriter.Gravar_infoAplicResTec(AINIRec: TMemIniFile; A: TinfoAplicResTecD1106; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoAplicResTec' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.semAplic then
    AINIRec.WriteString(sSecao, 'semAplic', '1');

  for i := 0 to A.infoAplic.Count - 1 do
    Gravar_infoAplic(AINIRec, A.infoAplic[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREAplicResTecIniWriter.Gravar_infoAplic(AINIRec: TMemIniFile; A: TinfoAplicCollectionItemD1106; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoAplic' + ASufixo;

  AINIRec.WriteString(sSecao, 'cCta', A.cCta);

  for i := 0 to A.detAtivo.Count - 1 do
    Gravar_detAtivo(AINIRec, A.detAtivo[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREAplicResTecIniWriter.Gravar_detAtivo(AINIRec: TMemIniFile; A: TdetAtivoCollectionItemD1106; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detAtivo' + ASufixo;

  AINIRec.WriteString(sSecao, 'idAtivo', A.idAtivo);
  AINIRec.WriteString(sSecao, 'descAtivo', A.descAtivo);
  AINIRec.WriteString(sSecao, 'vSaldoInic', StringReplace(FormatFloat('0.00', A.vSaldoInic), ',', '.', []));
  if A.TemvRendPerReceb then
    AINIRec.WriteString(sSecao, 'vRendPerReceb', StringReplace(FormatFloat('0.00', A.vRendPerReceb), ',', '.', []));
  if A.TemvVarMensal then
    AINIRec.WriteString(sSecao, 'vVarMensal', StringReplace(FormatFloat('0.00', A.vVarMensal), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vPrincLiqResg', StringReplace(FormatFloat('0.00', A.vPrincLiqResg), ',', '.', []));
  if A.TemvRendLiqResg then
    AINIRec.WriteString(sSecao, 'vRendLiqResg', StringReplace(FormatFloat('0.00', A.vRendLiqResg), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vSaldoFinal', StringReplace(FormatFloat('0.00', A.vSaldoFinal), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vApur', StringReplace(FormatFloat('0.00', A.vApur), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teAplicResTec, TDeREAplicResTecIniWriter);

end.
