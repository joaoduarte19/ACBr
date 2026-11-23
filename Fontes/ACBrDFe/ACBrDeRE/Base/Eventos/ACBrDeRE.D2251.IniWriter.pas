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

unit ACBrDeRE.D2251.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeRESegPrevCapIniWriter - grava o INI do evento evtSegPrevCap (D-2251) }

  TDeRESegPrevCapIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtSegPrevCap;

    procedure Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2251; const ASufixo: string);
    procedure Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD2251; const ASufixo: string);
    procedure Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD2251; const ASufixo: string);
    procedure Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2251; const ASufixo: string);
    procedure Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2251; const ASufixo: string);
    procedure Gravar_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD2251; const ASufixo: string);
    procedure Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2251; const ASufixo: string);
    procedure Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2251; const ASufixo: string);
    procedure Gravar_gSemCobert(AINIRec: TMemIniFile; A: TgSemCobertD2251; const ASufixo: string);
    procedure Gravar_gComCobertPrev(AINIRec: TMemIniFile; A: TgComCobertPrevD2251; const ASufixo: string);
    procedure Gravar_gIdSegurados(AINIRec: TMemIniFile; A: TgIdSeguradosD2251; const ASufixo: string);
    procedure Gravar_detSegurado(AINIRec: TMemIniFile; A: TdetSeguradoCollectionItemD2251; const ASufixo: string);
    procedure Gravar_segExterior(AINIRec: TMemIniFile; A: TsegExteriorD2251; const ASufixo: string);
    procedure Gravar_gCapitalizacao(AINIRec: TMemIniFile; A: TgCapitalizacaoD2251; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeRESegPrevCapIniWriter }

function TDeRESegPrevCapIniWriter.Evt: TevtSegPrevCap;
begin
  Result := (DeRE as TDeRED2251).evtSegPrevCap;
end;

procedure TDeRESegPrevCapIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoFin(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Gravar_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeRESegPrevCapIniWriter.Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD2251; const ASufixo: string);
begin

  Gravar_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniWriter.Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'idePartes' + ASufixo;

  if A.TemindIdentifAdq then
    AINIRec.WriteString(sSecao, 'indIdentifAdq', IntToStr(Ord(A.indIdentifAdq)));

  if A.TeminfoAdq then
    Gravar_infoAdq(AINIRec, A.infoAdq, ASufixo);
  if A.TeminfoPDV then
    Gravar_infoPDV(AINIRec, A.infoPDV, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoAdq' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.TemCPF then
    AINIRec.WriteString(sSecao, 'CPF', A.CPF);
  if A.TemCNPJ then
    AINIRec.WriteString(sSecao, 'CNPJ', A.CNPJ);
  if A.TemcMun then
    AINIRec.WriteString(sSecao, 'cMun', A.cMun);

  if A.TemadqExterior then
    Gravar_adqExterior(AINIRec, A.adqExterior, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD2251; const ASufixo: string);
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

procedure TDeRESegPrevCapIniWriter.Gravar_infoPDV(AINIRec: TMemIniFile; A: TinfoPDVD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoPDV' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.TemCPFPDV then
    AINIRec.WriteString(sSecao, 'CPFPDV', A.CPFPDV);
  if A.TemCNPJPDV then
    AINIRec.WriteString(sSecao, 'CNPJPDV', A.CNPJPDV);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD2251; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detOper.Count - 1 do
    Gravar_detOper(AINIRec, A.detOper[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeRESegPrevCapIniWriter.Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'seq', A.seq);
  if A.TemseqRef then
    AINIRec.WriteString(sSecao, 'seqRef', A.seqRef);
  AINIRec.WriteString(sSecao, 'dhOper', DateTimeToStr(A.dhOper));

  if A.TemgSemCobert then
    Gravar_gSemCobert(AINIRec, A.gSemCobert, ASufixo);
  if A.TemgComCobertPrev then
    Gravar_gComCobertPrev(AINIRec, A.gComCobertPrev, ASufixo);
  if A.TemgCapitalizacao then
    Gravar_gCapitalizacao(AINIRec, A.gCapitalizacao, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_gSemCobert(AINIRec: TMemIniFile; A: TgSemCobertD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gSemCobert' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCDistr', StringReplace(FormatFloat('0.00', A.vBCDistr), ',', '.', []));
end;

procedure TDeRESegPrevCapIniWriter.Gravar_gComCobertPrev(AINIRec: TMemIniFile; A: TgComCobertPrevD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gComCobertPrev' + ASufixo;

  AINIRec.WriteString(sSecao, 'tpContrato', tpContratoDeREToStr(A.tpContrato));
  AINIRec.WriteString(sSecao, 'vBCDistr', StringReplace(FormatFloat('0.00', A.vBCDistr), ',', '.', []));

  if A.TemgIdSegurados then
    Gravar_gIdSegurados(AINIRec, A.gIdSegurados, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_gIdSegurados(AINIRec: TMemIniFile; A: TgIdSeguradosD2251; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detSegurado.Count - 1 do
    Gravar_detSegurado(AINIRec, A.detSegurado[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeRESegPrevCapIniWriter.Gravar_detSegurado(AINIRec: TMemIniFile; A: TdetSeguradoCollectionItemD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detSegurado' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCDistrSeg', StringReplace(FormatFloat('0.00', A.vBCDistrSeg), ',', '.', []));
  if A.TemCPFSeg then
    AINIRec.WriteString(sSecao, 'CPFSeg', A.CPFSeg);
  if A.TemCNPJSeg then
    AINIRec.WriteString(sSecao, 'CNPJSeg', A.CNPJSeg);
  if A.TemcMunSeg then
    AINIRec.WriteString(sSecao, 'cMunSeg', A.cMunSeg);

  if A.TemsegExterior then
    Gravar_segExterior(AINIRec, A.segExterior, ASufixo);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_segExterior(AINIRec: TMemIniFile; A: TsegExteriorD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'segExterior' + ASufixo;

  if A.TemNIFSeg then
    AINIRec.WriteString(sSecao, 'NIFSeg', A.NIFSeg);
  if A.TemcNaoNIFSeg then
    AINIRec.WriteString(sSecao, 'cNaoNIFSeg', cNaoNIFDeREToStr(A.cNaoNIFSeg));
  if A.TemnrDocIdentSeg then
    AINIRec.WriteString(sSecao, 'nrDocIdentSeg', A.nrDocIdentSeg);
  AINIRec.WriteString(sSecao, 'cPaisSeg', A.cPaisSeg);
end;

procedure TDeRESegPrevCapIniWriter.Gravar_gCapitalizacao(AINIRec: TMemIniFile; A: TgCapitalizacaoD2251; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gCapitalizacao' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCDistr', StringReplace(FormatFloat('0.00', A.vBCDistr), ',', '.', []));
  if A.TemcMunOper then
    AINIRec.WriteString(sSecao, 'cMunOper', A.cMunOper);
end;

initialization
  RegistrarIniWriterDeRE(teSegPrevCap, TDeRESegPrevCapIniWriter);

end.
