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

unit ACBrDeRE.D2101.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREDebOpOfPublicIniReader - le o INI do evento evtDebOpOfPublic (D-2101) }

  TDeREDebOpOfPublicIniReader = class(TDeREIniReader)
  private
    function Evt: TevtDebOpOfPublic;

    procedure Ler_infoDebOpOfPublic(AINIRec: TMemIniFile; A: TinfoDebOpOfPublicD2101; const ASufixo: string);
    procedure Ler_infoTitulos(AINIRec: TMemIniFile; A: TinfoTitulosD2101; const ASufixo: string);
    procedure Ler_detTitulo(AINIRec: TMemIniFile; A: TdetTituloCollectionItemD2101; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREDebOpOfPublicIniReader }

function TDeREDebOpOfPublicIniReader.Evt: TevtDebOpOfPublic;
begin
  Result := (DeRE as TDeRED2101).evtDebOpOfPublic;
end;

procedure TDeREDebOpOfPublicIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic := AINIRec.SectionExists('infoDebOpOfPublic');
  if Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic then
    Ler_infoDebOpOfPublic(AINIRec, Evt.infoDebOpOfPublic, '');
end;

procedure TDeREDebOpOfPublicIniReader.Ler_infoDebOpOfPublic(AINIRec: TMemIniFile; A: TinfoDebOpOfPublicD2101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoDebOpOfPublic' + ASufixo;

  A.semTitulos := (AINIRec.ReadString(sSecao, 'semTitulos', '') = '1');

  A.TeminfoTitulos := AINIRec.SectionExists('detTitulo' + ASufixo + '001');
  if A.TeminfoTitulos then
    Ler_infoTitulos(AINIRec, A.infoTitulos, ASufixo);
end;

procedure TDeREDebOpOfPublicIniReader.Ler_infoTitulos(AINIRec: TMemIniFile; A: TinfoTitulosD2101; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('detTitulo' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detTitulo(AINIRec, A.detTitulo.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREDebOpOfPublicIniReader.Ler_detTitulo(AINIRec: TMemIniFile; A: TdetTituloCollectionItemD2101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detTitulo' + ASufixo;

  A.idTitulo := AINIRec.ReadString(sSecao, 'idTitulo', '');
  A.cCta := AINIRec.ReadString(sSecao, 'cCta', '');
  A.TemdescFundo := AINIRec.ValueExists(sSecao, 'descFundo');
  if A.TemdescFundo then
    A.descFundo := AINIRec.ReadString(sSecao, 'descFundo', '');
  A.CNPJDevedor := AINIRec.ReadString(sSecao, 'CNPJDevedor', '');
  A.vSaldoContIni := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoContIni', '0'), 0);
  A.vEntradas := StringToFloatDef(AINIRec.ReadString(sSecao, 'vEntradas', '0'), 0);
  A.vSaidas := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaidas', '0'), 0);
  A.vJurosRec := StringToFloatDef(AINIRec.ReadString(sSecao, 'vJurosRec', '0'), 0);
  A.TemvVarMensal := AINIRec.ValueExists(sSecao, 'vVarMensal');
  if A.TemvVarMensal then
    A.vVarMensal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vVarMensal', '0'), 0);
  A.vSaldoContFin := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSaldoContFin', '0'), 0);
  A.vSelic := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSelic', '0'), 0);
  A.TemvPisCofins := AINIRec.ValueExists(sSecao, 'vPisCofins');
  if A.TemvPisCofins then
    A.vPisCofins := StringToFloatDef(AINIRec.ReadString(sSecao, 'vPisCofins', '0'), 0);
  A.vApur := StringToFloatDef(AINIRec.ReadString(sSecao, 'vApur', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teDebOpOfPublic, TDeREDebOpOfPublicIniReader);

end.
