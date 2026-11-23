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

unit ACBrDeRE.D2242.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2242.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREArranjoParticIniReader - le o INI do evento evtArranjoPartic (D-2242) }

  TDeREArranjoParticIniReader = class(TDeREIniReader)
  private
    function Evt: TevtArranjoPartic;

    procedure Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2242; const ASufixo: string);
    procedure Ler_gOper(AINIRec: TMemIniFile; A: TgOperD2242; const ASufixo: string);
    procedure Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD2242; const ASufixo: string);
    procedure Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2242; const ASufixo: string);
    procedure Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2242; const ASufixo: string);
    procedure Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2242; const ASufixo: string);
    procedure Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2242; const ASufixo: string);
    procedure Ler_gBC(AINIRec: TMemIniFile; A: TgBCD2242; const ASufixo: string);
    procedure Ler_gVOper(AINIRec: TMemIniFile; A: TgVOperD2242; const ASufixo: string);
    procedure Ler_gDeducoes(AINIRec: TMemIniFile; A: TgDeducoesD2242; const ASufixo: string);
    procedure Ler_detBC(AINIRec: TMemIniFile; A: TdetBCD2242; const ASufixo: string);
    procedure Ler_gTributos(AINIRec: TMemIniFile; A: TgTributosD2242; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREArranjoParticIniReader }

function TDeREArranjoParticIniReader.Evt: TevtArranjoPartic;
begin
  Result := (DeRE as TDeRED2242).evtArranjoPartic;
end;

procedure TDeREArranjoParticIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoFin(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Evt.ideContrib.tpParticip := StrTotpParticipDeRE(AINIRec.ReadString('ideContrib', 'tpParticip', '1'));
  Ler_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Ler_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeREArranjoParticIniReader.Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2242; const ASufixo: string);
begin

  Ler_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_gOper(AINIRec: TMemIniFile; A: TgOperD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gOper' + ASufixo;

  A.chAgrup := AINIRec.ReadString(sSecao, 'chAgrup', '');
  A.codBC := AINIRec.ReadString(sSecao, 'codBC', '');
  A.TemchAgrupRef := AINIRec.ValueExists(sSecao, 'chAgrupRef');
  if A.TemchAgrupRef then
    A.chAgrupRef := AINIRec.ReadString(sSecao, 'chAgrupRef', '');

  Ler_idePartes(AINIRec, A.idePartes, ASufixo);
  Ler_dadosOper(AINIRec, A.dadosOper, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD2242; const ASufixo: string);
begin

  Ler_infoAdq(AINIRec, A.infoAdq, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoAdq' + ASufixo;

  A.TemCPF := AINIRec.ValueExists(sSecao, 'CPF');
  if A.TemCPF then
    A.CPF := AINIRec.ReadString(sSecao, 'CPF', '');
  A.TemCNPJ := AINIRec.ValueExists(sSecao, 'CNPJ');
  if A.TemCNPJ then
    A.CNPJ := AINIRec.ReadString(sSecao, 'CNPJ', '');
  A.TemcMun := AINIRec.ValueExists(sSecao, 'cMun');
  if A.TemcMun then
    A.cMun := AINIRec.ReadString(sSecao, 'cMun', '');

  A.TemadqExterior := AINIRec.SectionExists('adqExterior' + ASufixo);
  if A.TemadqExterior then
    Ler_adqExterior(AINIRec, A.adqExterior, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'adqExterior' + ASufixo;

  A.TemNIF := AINIRec.ValueExists(sSecao, 'NIF');
  if A.TemNIF then
    A.NIF := AINIRec.ReadString(sSecao, 'NIF', '');
  A.TemcNaoNIF := AINIRec.ValueExists(sSecao, 'cNaoNIF');
  if A.TemcNaoNIF then
    A.cNaoNIF := StrTocNaoNIFDeRE(AINIRec.ReadString(sSecao, 'cNaoNIF', '1'));
  A.TemnrDocIdent := AINIRec.ValueExists(sSecao, 'nrDocIdent');
  if A.TemnrDocIdent then
    A.nrDocIdent := AINIRec.ReadString(sSecao, 'nrDocIdent', '');
  A.cPais := AINIRec.ReadString(sSecao, 'cPais', '');
end;

procedure TDeREArranjoParticIniReader.Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2242; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('detOper' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detOper(AINIRec, A.detOper.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREArranjoParticIniReader.Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  A.seq := AINIRec.ReadString(sSecao, 'seq', '');
  A.TemseqRef := AINIRec.ValueExists(sSecao, 'seqRef');
  if A.TemseqRef then
    A.seqRef := AINIRec.ReadString(sSecao, 'seqRef', '');
  A.dhOper := StringToDateTime(AINIRec.ReadString(sSecao, 'dhOper', '0'));

  Ler_gBC(AINIRec, A.gBC, ASufixo);
  Ler_gTributos(AINIRec, A.gTributos, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_gBC(AINIRec: TMemIniFile; A: TgBCD2242; const ASufixo: string);
begin

  Ler_gVOper(AINIRec, A.gVOper, ASufixo);
  A.TemgDeducoes := AINIRec.SectionExists('gDeducoes' + ASufixo);
  if A.TemgDeducoes then
    Ler_gDeducoes(AINIRec, A.gDeducoes, ASufixo);
  Ler_detBC(AINIRec, A.detBC, ASufixo);
end;

procedure TDeREArranjoParticIniReader.Ler_gVOper(AINIRec: TMemIniFile; A: TgVOperD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gVOper' + ASufixo;

  A.vLiqOper := StringToFloatDef(AINIRec.ReadString(sSecao, 'vLiqOper', '0'), 0);
end;

procedure TDeREArranjoParticIniReader.Ler_gDeducoes(AINIRec: TMemIniFile; A: TgDeducoesD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gDeducoes' + ASufixo;

  A.TemvISSQNProp := AINIRec.ValueExists(sSecao, 'vISSQNProp');
  if A.TemvISSQNProp then
    A.vISSQNProp := StringToFloatDef(AINIRec.ReadString(sSecao, 'vISSQNProp', '0'), 0);
  A.TemvISSQNOutro := AINIRec.ValueExists(sSecao, 'vISSQNOutro');
  if A.TemvISSQNOutro then
    A.vISSQNOutro := StringToFloatDef(AINIRec.ReadString(sSecao, 'vISSQNOutro', '0'), 0);
  A.TemvPisCofins := AINIRec.ValueExists(sSecao, 'vPisCofins');
  if A.TemvPisCofins then
    A.vPisCofins := StringToFloatDef(AINIRec.ReadString(sSecao, 'vPisCofins', '0'), 0);
  A.TemvSomaDeducoes := AINIRec.ValueExists(sSecao, 'vSomaDeducoes');
  if A.TemvSomaDeducoes then
    A.vSomaDeducoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'vSomaDeducoes', '0'), 0);
end;

procedure TDeREArranjoParticIniReader.Ler_detBC(AINIRec: TMemIniFile; A: TdetBCD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBC' + ASufixo;

  A.vBCApur := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCApur', '0'), 0);
end;

procedure TDeREArranjoParticIniReader.Ler_gTributos(AINIRec: TMemIniFile; A: TgTributosD2242; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gTributos' + ASufixo;

  A.vBCTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCTrib', '0'), 0);
  A.pIBSMunTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSMunTrib', '0'), 0);
  A.vIBSMunTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMunTrib', '0'), 0);
  A.pIBSUFTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSUFTrib', '0'), 0);
  A.vIBSUFTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSUFTrib', '0'), 0);
  A.pCBSTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCBSTrib', '0'), 0);
  A.vCBSTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSTrib', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teArranjoPartic, TDeREArranjoParticIniReader);

end.
