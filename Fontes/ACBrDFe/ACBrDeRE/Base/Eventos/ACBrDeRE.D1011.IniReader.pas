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

unit ACBrDeRE.D1011.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1011.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREPGCCIniReader - le o INI do evento evtPGCC (D-1011) }

  TDeREPGCCIniReader = class(TDeREIniReader)
  private
    function Evt: TevtPGCC;

    procedure Ler_infoPGCC(AINIRec: TMemIniFile; A: TinfoPGCCD1011; const ASufixo: string);
    procedure Ler_infoContas(AINIRec: TMemIniFile; A: TinfoContaCollectionD1011; const ASufixo: string);
    procedure Ler_infoConta(AINIRec: TMemIniFile; A: TinfoContaCollectionItemD1011; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREPGCCIniReader }

function TDeREPGCCIniReader.Evt: TevtPGCC;
begin
  Result := (DeRE as TDeRED1011).evtPGCC;
end;

procedure TDeREPGCCIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEvento(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodo(AINIRec, Evt.idePeriodo);

  Evt.infoPGCC.TeminfoPGCC := AINIRec.SectionExists('infoPGCC');
  if Evt.infoPGCC.TeminfoPGCC then
    Ler_infoPGCC(AINIRec, Evt.infoPGCC, '');
end;

procedure TDeREPGCCIniReader.Ler_infoPGCC(AINIRec: TMemIniFile; A: TinfoPGCCD1011; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoPGCC' + ASufixo;

  A.planoCtaRef := StrToplanoCtaRefDeRE(AINIRec.ReadString(sSecao, 'planoCtaRef', '1'));
  A.freqEncerr := StrTofreqEncerrDeRE(AINIRec.ReadString(sSecao, 'freqEncerr', 'A'));

  Ler_infoContas(AINIRec, A.infoContas, ASufixo);
end;

procedure TDeREPGCCIniReader.Ler_infoContas(AINIRec: TMemIniFile; A: TinfoContaCollectionD1011; const ASufixo: string);
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

procedure TDeREPGCCIniReader.Ler_infoConta(AINIRec: TMemIniFile; A: TinfoContaCollectionItemD1011; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoConta' + ASufixo;

  A.cCta := AINIRec.ReadString(sSecao, 'cCta', '');
  A.cCtaInterna := AINIRec.ReadString(sSecao, 'cCtaInterna', '');
  A.cDbrMista := AINIRec.ReadString(sSecao, 'cDbrMista', '');
  A.nomeCta := AINIRec.ReadString(sSecao, 'nomeCta', '');
  A.indCta := StrToindCtaDeRE(AINIRec.ReadString(sSecao, 'indCta', 'S'));
  A.TemdescCta := AINIRec.ValueExists(sSecao, 'descCta');
  if A.TemdescCta then
    A.descCta := AINIRec.ReadString(sSecao, 'descCta', '');
  A.TemcCtaSup := AINIRec.ValueExists(sSecao, 'cCtaSup');
  if A.TemcCtaSup then
    A.cCtaSup := AINIRec.ReadString(sSecao, 'cCtaSup', '');
  A.cCtaRef := AINIRec.ReadString(sSecao, 'cCtaRef', '');
  A.nivelCta := StrToIntDef(AINIRec.ReadString(sSecao, 'nivelCta', '0'), 0);
  A.natCta := StrTonatCtaDeRE(AINIRec.ReadString(sSecao, 'natCta', 'C'));
  A.codNat := StrTocodNatDeRE(AINIRec.ReadString(sSecao, 'codNat', '1'));
  A.TemcodTrib := AINIRec.ValueExists(sSecao, 'codTrib');
  if A.TemcodTrib then
    A.codTrib := StrToIntDef(AINIRec.ReadString(sSecao, 'codTrib', '0'), 0);
  A.TemindTribISS := AINIRec.ValueExists(sSecao, 'indTribISS');
  if A.TemindTribISS then
    A.indTribISS := StrToindTribISSDeRE(AINIRec.ReadString(sSecao, 'indTribISS', '0'));
  A.TemidLeiDisp := AINIRec.ValueExists(sSecao, 'idLeiDisp');
  if A.TemidLeiDisp then
    A.idLeiDisp := AINIRec.ReadString(sSecao, 'idLeiDisp', '');
  A.iniVig := StringToDateTime(AINIRec.ReadString(sSecao, 'iniVig', '0'));
  A.TemfimVig := AINIRec.ValueExists(sSecao, 'fimVig');
  if A.TemfimVig then
    A.fimVig := StringToDateTime(AINIRec.ReadString(sSecao, 'fimVig', '0'));
end;

initialization
  RegistrarIniReaderDeRE(tePGCC, TDeREPGCCIniReader);

end.
