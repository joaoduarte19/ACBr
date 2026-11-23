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

unit ACBrDeRE.D1011.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1011.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREPGCCIniWriter - grava o INI do evento evtPGCC (D-1011) }

  TDeREPGCCIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtPGCC;

    procedure Gravar_infoPGCC(AINIRec: TMemIniFile; A: TinfoPGCCD1011; const ASufixo: string);
    procedure Gravar_infoContas(AINIRec: TMemIniFile; A: TinfoContaCollectionD1011; const ASufixo: string);
    procedure Gravar_infoConta(AINIRec: TMemIniFile; A: TinfoContaCollectionItemD1011; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREPGCCIniWriter }

function TDeREPGCCIniWriter.Evt: TevtPGCC;
begin
  Result := (DeRE as TDeRED1011).evtPGCC;
end;

procedure TDeREPGCCIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEvento(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodo(AINIRec, Evt.idePeriodo);

  if Evt.infoPGCC.TeminfoPGCC then
    Gravar_infoPGCC(AINIRec, Evt.infoPGCC, '');
end;

procedure TDeREPGCCIniWriter.Gravar_infoPGCC(AINIRec: TMemIniFile; A: TinfoPGCCD1011; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoPGCC' + ASufixo;

  AINIRec.WriteString(sSecao, 'planoCtaRef', planoCtaRefDeREToStr(A.planoCtaRef));
  AINIRec.WriteString(sSecao, 'freqEncerr', freqEncerrDeREToStr(A.freqEncerr));

  Gravar_infoContas(AINIRec, A.infoContas, ASufixo);
end;

procedure TDeREPGCCIniWriter.Gravar_infoContas(AINIRec: TMemIniFile; A: TinfoContaCollectionD1011; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.Count - 1 do
    Gravar_infoConta(AINIRec, A[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREPGCCIniWriter.Gravar_infoConta(AINIRec: TMemIniFile; A: TinfoContaCollectionItemD1011; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoConta' + ASufixo;

  AINIRec.WriteString(sSecao, 'cCta', A.cCta);
  AINIRec.WriteString(sSecao, 'cCtaInterna', A.cCtaInterna);
  AINIRec.WriteString(sSecao, 'cDbrMista', A.cDbrMista);
  AINIRec.WriteString(sSecao, 'nomeCta', A.nomeCta);
  AINIRec.WriteString(sSecao, 'indCta', indCtaDeREToStr(A.indCta));
  if A.TemdescCta then
    AINIRec.WriteString(sSecao, 'descCta', A.descCta);
  if A.TemcCtaSup then
    AINIRec.WriteString(sSecao, 'cCtaSup', A.cCtaSup);
  AINIRec.WriteString(sSecao, 'cCtaRef', A.cCtaRef);
  AINIRec.WriteString(sSecao, 'nivelCta', IntToStr(A.nivelCta));
  AINIRec.WriteString(sSecao, 'natCta', natCtaDeREToStr(A.natCta));
  AINIRec.WriteString(sSecao, 'codNat', codNatDeREToStr(A.codNat));
  if A.TemcodTrib then
    AINIRec.WriteString(sSecao, 'codTrib', IntToStr(A.codTrib));
  if A.TemindTribISS then
    AINIRec.WriteString(sSecao, 'indTribISS', indTribISSDeREToStr(A.indTribISS));
  if A.TemidLeiDisp then
    AINIRec.WriteString(sSecao, 'idLeiDisp', A.idLeiDisp);
  AINIRec.WriteString(sSecao, 'iniVig', DateToStr(A.iniVig));
  if A.TemfimVig then
    AINIRec.WriteString(sSecao, 'fimVig', DateToStr(A.fimVig));
end;

initialization
  RegistrarIniWriterDeRE(tePGCC, TDeREPGCCIniWriter);

end.
