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

unit ACBrDeRE.D4201.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D4201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREIdApostPremIniReader - le o INI do evento evtIdApostPrem (D-4201) }

  TDeREIdApostPremIniReader = class(TDeREIniReader)
  private
    function Evt: TevtIdApostPrem;

    procedure Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD4201; const ASufixo: string);
    procedure Ler_gOper(AINIRec: TMemIniFile; A: TgOperD4201; const ASufixo: string);
    procedure Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD4201; const ASufixo: string);
    procedure Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD4201; const ASufixo: string);
    procedure Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD4201; const ASufixo: string);
    procedure Ler_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD4201; const ASufixo: string);
    procedure Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD4201; const ASufixo: string);
    procedure Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD4201; const ASufixo: string);
    procedure Ler_infoAposta(AINIRec: TMemIniFile; A: TinfoApostaD4201; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREIdApostPremIniReader }

function TDeREIdApostPremIniReader.Evt: TevtIdApostPrem;
begin
  Result := (DeRE as TDeRED4201).evtIdApostPrem;
end;

procedure TDeREIdApostPremIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoFin(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Ler_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeREIdApostPremIniReader.Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD4201; const ASufixo: string);
begin

  Ler_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeREIdApostPremIniReader.Ler_gOper(AINIRec: TMemIniFile; A: TgOperD4201; const ASufixo: string);
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

procedure TDeREIdApostPremIniReader.Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD4201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'idePartes' + ASufixo;

  A.indApostaPresenc := (AINIRec.ReadString(sSecao, 'indApostaPresenc', '0') = '1');

  A.TeminfoAdq := AINIRec.SectionExists('infoAdq' + ASufixo);
  if A.TeminfoAdq then
    Ler_infoAdq(AINIRec, A.infoAdq, ASufixo);
  A.TeminfoPDV := AINIRec.SectionExists('infoPDV' + ASufixo);
  if A.TeminfoPDV then
    Ler_infoPDV(AINIRec, A.infoPDV, ASufixo);
end;

procedure TDeREIdApostPremIniReader.Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD4201; const ASufixo: string);
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

procedure TDeREIdApostPremIniReader.Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD4201; const ASufixo: string);
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

procedure TDeREIdApostPremIniReader.Ler_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD4201; const ASufixo: string);
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

procedure TDeREIdApostPremIniReader.Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD4201; const ASufixo: string);
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

procedure TDeREIdApostPremIniReader.Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD4201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  A.seq := AINIRec.ReadString(sSecao, 'seq', '');
  A.TemseqRef := AINIRec.ValueExists(sSecao, 'seqRef');
  if A.TemseqRef then
    A.seqRef := AINIRec.ReadString(sSecao, 'seqRef', '');
  A.dhOper := StringToDateTime(AINIRec.ReadString(sSecao, 'dhOper', '0'));

  Ler_infoAposta(AINIRec, A.infoAposta, ASufixo);
end;

procedure TDeREIdApostPremIniReader.Ler_infoAposta(AINIRec: TMemIniFile; A: TinfoApostaD4201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoAposta' + ASufixo;

  A.TemcMunOper := AINIRec.ValueExists(sSecao, 'cMunOper');
  if A.TemcMunOper then
    A.cMunOper := AINIRec.ReadString(sSecao, 'cMunOper', '');
  A.vOper := StringToFloatDef(AINIRec.ReadString(sSecao, 'vOper', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teIdApostPrem, TDeREIdApostPremIniReader);

end.
