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

unit ACBrDeRE.D2251.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeRESegPrevCapIniReader - le o INI do evento evtSegPrevCap (D-2251) }

  TDeRESegPrevCapIniReader = class(TDeREIniReader)
  private
    function Evt: TevtSegPrevCap;

    procedure Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2251; const ASufixo: string);
    procedure Ler_gOper(AINIRec: TMemIniFile; A: TgOperD2251; const ASufixo: string);
    procedure Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD2251; const ASufixo: string);
    procedure Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2251; const ASufixo: string);
    procedure Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2251; const ASufixo: string);
    procedure Ler_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD2251; const ASufixo: string);
    procedure Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2251; const ASufixo: string);
    procedure Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2251; const ASufixo: string);
    procedure Ler_gSemCobert(AINIRec: TMemIniFile; A: TgSemCobertD2251; const ASufixo: string);
    procedure Ler_gComCobertPrev(AINIRec: TMemIniFile; A: TgComCobertPrevD2251; const ASufixo: string);
    procedure Ler_gIdSegurados(AINIRec: TMemIniFile; A: TgIdSeguradosD2251; const ASufixo: string);
    procedure Ler_detSegurado(AINIRec: TMemIniFile; A: TdetSeguradoCollectionItemD2251; const ASufixo: string);
    procedure Ler_segExterior(AINIRec: TMemIniFile; A: TsegExteriorD2251; const ASufixo: string);
    procedure Ler_gCapitalizacao(AINIRec: TMemIniFile; A: TgCapitalizacaoD2251; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeRESegPrevCapIniReader }

function TDeRESegPrevCapIniReader.Evt: TevtSegPrevCap;
begin
  Result := (DeRE as TDeRED2251).evtSegPrevCap;
end;

procedure TDeRESegPrevCapIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoFin(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Ler_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeRESegPrevCapIniReader.Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2251; const ASufixo: string);
begin

  Ler_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeRESegPrevCapIniReader.Ler_gOper(AINIRec: TMemIniFile; A: TgOperD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniReader.Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'idePartes' + ASufixo;

  A.TemindIdentifAdq := AINIRec.ValueExists(sSecao, 'indIdentifAdq');
  if A.TemindIdentifAdq then
    A.indIdentifAdq := (AINIRec.ReadString(sSecao, 'indIdentifAdq', '0') = '1');

  A.TeminfoAdq := AINIRec.SectionExists('infoAdq' + ASufixo);
  if A.TeminfoAdq then
    Ler_infoAdq(AINIRec, A.infoAdq, ASufixo);
  A.TeminfoPDV := AINIRec.SectionExists('infoPDV' + ASufixo);
  if A.TeminfoPDV then
    Ler_infoPDV(AINIRec, A.infoPDV, ASufixo);
end;

procedure TDeRESegPrevCapIniReader.Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniReader.Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniReader.Ler_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoPDV' + ASufixo;

  A.TemCPFPDV := AINIRec.ValueExists(sSecao, 'CPFPDV');
  if A.TemCPFPDV then
    A.CPFPDV := AINIRec.ReadString(sSecao, 'CPFPDV', '');
  A.TemCNPJPDV := AINIRec.ValueExists(sSecao, 'CNPJPDV');
  if A.TemCNPJPDV then
    A.CNPJPDV := AINIRec.ReadString(sSecao, 'CNPJPDV', '');
end;

procedure TDeRESegPrevCapIniReader.Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniReader.Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  A.seq := AINIRec.ReadString(sSecao, 'seq', '');
  A.TemseqRef := AINIRec.ValueExists(sSecao, 'seqRef');
  if A.TemseqRef then
    A.seqRef := AINIRec.ReadString(sSecao, 'seqRef', '');
  A.dhOper := StringToDateTime(AINIRec.ReadString(sSecao, 'dhOper', '0'));

  A.TemgSemCobert := AINIRec.SectionExists('gSemCobert' + ASufixo);
  if A.TemgSemCobert then
    Ler_gSemCobert(AINIRec, A.gSemCobert, ASufixo);
  A.TemgComCobertPrev := AINIRec.SectionExists('gComCobertPrev' + ASufixo);
  if A.TemgComCobertPrev then
    Ler_gComCobertPrev(AINIRec, A.gComCobertPrev, ASufixo);
  A.TemgCapitalizacao := AINIRec.SectionExists('gCapitalizacao' + ASufixo);
  if A.TemgCapitalizacao then
    Ler_gCapitalizacao(AINIRec, A.gCapitalizacao, ASufixo);
end;

procedure TDeRESegPrevCapIniReader.Ler_gSemCobert(AINIRec: TMemIniFile; A: TgSemCobertD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gSemCobert' + ASufixo;

  A.vBCDistr := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCDistr', '0'), 0);
end;

procedure TDeRESegPrevCapIniReader.Ler_gComCobertPrev(AINIRec: TMemIniFile; A: TgComCobertPrevD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gComCobertPrev' + ASufixo;

  A.tpContrato := StrTotpContratoDeRE(AINIRec.ReadString(sSecao, 'tpContrato', '1'));
  A.vBCDistr := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCDistr', '0'), 0);

  A.TemgIdSegurados := AINIRec.SectionExists('detSegurado' + ASufixo + '001');
  if A.TemgIdSegurados then
    Ler_gIdSegurados(AINIRec, A.gIdSegurados, ASufixo);
end;

procedure TDeRESegPrevCapIniReader.Ler_gIdSegurados(AINIRec: TMemIniFile; A: TgIdSeguradosD2251; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('detSegurado' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detSegurado(AINIRec, A.detSegurado.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeRESegPrevCapIniReader.Ler_detSegurado(AINIRec: TMemIniFile; A: TdetSeguradoCollectionItemD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detSegurado' + ASufixo;

  A.vBCDistrSeg := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCDistrSeg', '0'), 0);
  A.TemCPFSeg := AINIRec.ValueExists(sSecao, 'CPFSeg');
  if A.TemCPFSeg then
    A.CPFSeg := AINIRec.ReadString(sSecao, 'CPFSeg', '');
  A.TemCNPJSeg := AINIRec.ValueExists(sSecao, 'CNPJSeg');
  if A.TemCNPJSeg then
    A.CNPJSeg := AINIRec.ReadString(sSecao, 'CNPJSeg', '');
  A.TemcMunSeg := AINIRec.ValueExists(sSecao, 'cMunSeg');
  if A.TemcMunSeg then
    A.cMunSeg := AINIRec.ReadString(sSecao, 'cMunSeg', '');

  A.TemsegExterior := AINIRec.SectionExists('segExterior' + ASufixo);
  if A.TemsegExterior then
    Ler_segExterior(AINIRec, A.segExterior, ASufixo);
end;

procedure TDeRESegPrevCapIniReader.Ler_segExterior(AINIRec: TMemIniFile; A: TsegExteriorD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'segExterior' + ASufixo;

  A.TemNIFSeg := AINIRec.ValueExists(sSecao, 'NIFSeg');
  if A.TemNIFSeg then
    A.NIFSeg := AINIRec.ReadString(sSecao, 'NIFSeg', '');
  A.TemcNaoNIFSeg := AINIRec.ValueExists(sSecao, 'cNaoNIFSeg');
  if A.TemcNaoNIFSeg then
    A.cNaoNIFSeg := StrTocNaoNIFDeRE(AINIRec.ReadString(sSecao, 'cNaoNIFSeg', '1'));
  A.TemnrDocIdentSeg := AINIRec.ValueExists(sSecao, 'nrDocIdentSeg');
  if A.TemnrDocIdentSeg then
    A.nrDocIdentSeg := AINIRec.ReadString(sSecao, 'nrDocIdentSeg', '');
  A.cPaisSeg := AINIRec.ReadString(sSecao, 'cPaisSeg', '');
end;

procedure TDeRESegPrevCapIniReader.Ler_gCapitalizacao(AINIRec: TMemIniFile; A: TgCapitalizacaoD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gCapitalizacao' + ASufixo;

  A.vBCDistr := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCDistr', '0'), 0);
  A.TemcMunOper := AINIRec.ValueExists(sSecao, 'cMunOper');
  if A.TemcMunOper then
    A.cMunOper := AINIRec.ReadString(sSecao, 'cMunOper', '');
end;

initialization
  RegistrarIniReaderDeRE(teSegPrevCap, TDeRESegPrevCapIniReader);

end.
