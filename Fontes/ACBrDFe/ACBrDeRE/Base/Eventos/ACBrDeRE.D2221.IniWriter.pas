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

unit ACBrDeRE.D2221.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2221.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREAntecRecebIniWriter - grava o INI do evento evtAntecReceb (D-2221) }

  TDeREAntecRecebIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtAntecReceb;

    procedure Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2221; const ASufixo: string);
    procedure Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD2221; const ASufixo: string);
    procedure Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD2221; const ASufixo: string);
    procedure Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2221; const ASufixo: string);
    procedure Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2221; const ASufixo: string);
    procedure Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2221; const ASufixo: string);
    procedure Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2221; const ASufixo: string);
    procedure Gravar_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD2221; const ASufixo: string);
    procedure Gravar_gBC(AINIRec: TMemIniFile; A: TgBCD2221; const ASufixo: string);
    procedure Gravar_gTributos(AINIRec: TMemIniFile; A: TgTributosD2221; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREAntecRecebIniWriter }

function TDeREAntecRecebIniWriter.Evt: TevtAntecReceb;
begin
  Result := (DeRE as TDeRED2221).evtAntecReceb;
end;

procedure TDeREAntecRecebIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoFin(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Gravar_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeREAntecRecebIniWriter.Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2221; const ASufixo: string);
begin

  Gravar_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeREAntecRecebIniWriter.Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'chAgrup', A.chAgrup);
  AINIRec.WriteString(sSecao, 'codBC', A.codBC);
  if A.TemchAgrupRef then
    AINIRec.WriteString(sSecao, 'chAgrupRef', A.chAgrupRef);

  Gravar_idePartes(AINIRec, A.idePartes, ASufixo);
  Gravar_dadosOper(AINIRec, A.dadosOper, ASufixo);
end;

procedure TDeREAntecRecebIniWriter.Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD2221; const ASufixo: string);
begin

  Gravar_infoAdq(AINIRec, A.infoAdq, ASufixo);
end;

procedure TDeREAntecRecebIniWriter.Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoAdq' + ASufixo;

  if A.TemCPF then
    AINIRec.WriteString(sSecao, 'CPF', A.CPF);
  if A.TemCNPJ then
    AINIRec.WriteString(sSecao, 'CNPJ', A.CNPJ);
  if A.TemcMun then
    AINIRec.WriteString(sSecao, 'cMun', A.cMun);

  if A.TemadqExterior then
    Gravar_adqExterior(AINIRec, A.adqExterior, ASufixo);
end;

procedure TDeREAntecRecebIniWriter.Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'adqExterior' + ASufixo;

  if A.TemNIF then
    AINIRec.WriteString(sSecao, 'NIF', A.NIF);
  if A.TemcNaoNIF then
    AINIRec.WriteString(sSecao, 'cNaoNIF', cNaoNIFDeREToStr(A.cNaoNIF));
  if A.TemnrDocIdent then
    AINIRec.WriteString(sSecao, 'nrDocIdent', A.nrDocIdent);
  AINIRec.WriteString(sSecao, 'cPais', A.cPais);
end;

procedure TDeREAntecRecebIniWriter.Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2221; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detOper.Count - 1 do
    Gravar_detOper(AINIRec, A.detOper[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREAntecRecebIniWriter.Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'seq', A.seq);
  if A.TemseqRef then
    AINIRec.WriteString(sSecao, 'seqRef', A.seqRef);
  AINIRec.WriteString(sSecao, 'dhOper', DateTimeToStr(A.dhOper));

  if A.TemqualifOper then
    Gravar_qualifOper(AINIRec, A.qualifOper, ASufixo);
  Gravar_gBC(AINIRec, A.gBC, ASufixo);
  Gravar_gTributos(AINIRec, A.gTributos, ASufixo);
end;

procedure TDeREAntecRecebIniWriter.Gravar_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'qualifOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'indMoedaEstr', IntToStr(Ord(A.indMoedaEstr)));
end;

procedure TDeREAntecRecebIniWriter.Gravar_gBC(AINIRec: TMemIniFile; A: TgBCD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gBC' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCApur', StringReplace(FormatFloat('0.00', A.vBCApur), ',', '.', []));
end;

procedure TDeREAntecRecebIniWriter.Gravar_gTributos(AINIRec: TMemIniFile; A: TgTributosD2221; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gTributos' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCTrib', StringReplace(FormatFloat('0.00', A.vBCTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'pIBSMunTrib', StringReplace(FormatFloat('0.000000', A.pIBSMunTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vIBSMunTrib', StringReplace(FormatFloat('0.00', A.vIBSMunTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'pIBSUFTrib', StringReplace(FormatFloat('0.000000', A.pIBSUFTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vIBSUFTrib', StringReplace(FormatFloat('0.00', A.vIBSUFTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'pCBSTrib', StringReplace(FormatFloat('0.000000', A.pCBSTrib), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vCBSTrib', StringReplace(FormatFloat('0.00', A.vCBSTrib), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teAntecReceb, TDeREAntecRecebIniWriter);

end.
