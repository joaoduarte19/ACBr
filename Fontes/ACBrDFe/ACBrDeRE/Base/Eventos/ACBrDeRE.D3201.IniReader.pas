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

unit ACBrDeRE.D3201.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREPlAssistSaudeIniReader - le o INI do evento evtPlAssistSaude (D-3201) }

  TDeREPlAssistSaudeIniReader = class(TDeREIniReader)
  private
    function Evt: TevtPlAssistSaude;

    procedure Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD3201; const ASufixo: string);
    procedure Ler_gOper(AINIRec: TMemIniFile; A: TgOperD3201; const ASufixo: string);
    procedure Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD3201; const ASufixo: string);
    procedure Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD3201; const ASufixo: string);
    procedure Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD3201; const ASufixo: string);
    procedure Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD3201; const ASufixo: string);
    procedure Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD3201; const ASufixo: string);
    procedure Ler_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD3201; const ASufixo: string);
    procedure Ler_gBC(AINIRec: TMemIniFile; A: TgBCD3201; const ASufixo: string);
    procedure Ler_gVOper(AINIRec: TMemIniFile; A: TgVOperD3201; const ASufixo: string);
    procedure Ler_detBC(AINIRec: TMemIniFile; A: TdetBCD3201; const ASufixo: string);
    procedure Ler_gIdBenef(AINIRec: TMemIniFile; A: TgIdBenefD3201; const ASufixo: string);
    procedure Ler_detBenef(AINIRec: TMemIniFile; A: TdetBenefCollectionItemD3201; const ASufixo: string);
    procedure Ler_detDependentes(AINIRec: TMemIniFile; A: TdetDependentesD3201; const ASufixo: string);
    procedure Ler_gTributos(AINIRec: TMemIniFile; A: TgTributosD3201; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREPlAssistSaudeIniReader }

function TDeREPlAssistSaudeIniReader.Evt: TevtPlAssistSaude;
begin
  Result := (DeRE as TDeRED3201).evtPlAssistSaude;
end;

procedure TDeREPlAssistSaudeIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoFin(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Ler_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeREPlAssistSaudeIniReader.Ler_infoOper(AINIRec: TMemIniFile; A: TinfoOperD3201; const ASufixo: string);
begin

  Ler_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_gOper(AINIRec: TMemIniFile; A: TgOperD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniReader.Ler_idePartes(AINIRec: TMemIniFile; A: TidePartesD3201; const ASufixo: string);
begin

  Ler_infoAdq(AINIRec, A.infoAdq, ASufixo);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniReader.Ler_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniReader.Ler_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniReader.Ler_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  A.seq := AINIRec.ReadString(sSecao, 'seq', '');
  A.TemseqRef := AINIRec.ValueExists(sSecao, 'seqRef');
  if A.TemseqRef then
    A.seqRef := AINIRec.ReadString(sSecao, 'seqRef', '');
  A.dhOper := StringToDateTime(AINIRec.ReadString(sSecao, 'dhOper', '0'));

  Ler_qualifOper(AINIRec, A.qualifOper, ASufixo);
  Ler_gBC(AINIRec, A.gBC, ASufixo);
  A.TemgTributos := AINIRec.SectionExists('gTributos' + ASufixo);
  if A.TemgTributos then
    Ler_gTributos(AINIRec, A.gTributos, ASufixo);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'qualifOper' + ASufixo;

  A.idContrato := AINIRec.ReadString(sSecao, 'idContrato', '');
  A.tpContrato := StrTotpContratoD3201(AINIRec.ReadString(sSecao, 'tpContrato', '1'));
  A.TemCNPJEntidRelac := AINIRec.ValueExists(sSecao, 'CNPJEntidRelac');
  if A.TemCNPJEntidRelac then
    A.CNPJEntidRelac := AINIRec.ReadString(sSecao, 'CNPJEntidRelac', '');
end;

procedure TDeREPlAssistSaudeIniReader.Ler_gBC(AINIRec: TMemIniFile; A: TgBCD3201; const ASufixo: string);
begin

  Ler_gVOper(AINIRec, A.gVOper, ASufixo);
  A.TemdetBC := AINIRec.SectionExists('detBC' + ASufixo);
  if A.TemdetBC then
    Ler_detBC(AINIRec, A.detBC, ASufixo);
  A.TemgIdBenef := AINIRec.SectionExists('detBenef' + ASufixo + '001');
  if A.TemgIdBenef then
    Ler_gIdBenef(AINIRec, A.gIdBenef, ASufixo);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_gVOper(AINIRec: TMemIniFile; A: TgVOperD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gVOper' + ASufixo;

  A.vOper := StringToFloatDef(AINIRec.ReadString(sSecao, 'vOper', '0'), 0);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_detBC(AINIRec: TMemIniFile; A: TdetBCD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBC' + ASufixo;

  A.vBCApur := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCApur', '0'), 0);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_gIdBenef(AINIRec: TMemIniFile; A: TgIdBenefD3201; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('detBenef' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detBenef(AINIRec, A.detBenef.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREPlAssistSaudeIniReader.Ler_detBenef(AINIRec: TMemIniFile; A: TdetBenefCollectionItemD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBenef' + ASufixo;

  A.TemCPFTitular := AINIRec.ValueExists(sSecao, 'CPFTitular');
  if A.TemCPFTitular then
    A.CPFTitular := AINIRec.ReadString(sSecao, 'CPFTitular', '');
  A.TemdtNascTitular := AINIRec.ValueExists(sSecao, 'dtNascTitular');
  if A.TemdtNascTitular then
    A.dtNascTitular := StringToDateTime(AINIRec.ReadString(sSecao, 'dtNascTitular', '0'));
  A.TemvTitularDep := AINIRec.ValueExists(sSecao, 'vTitularDep');
  if A.TemvTitularDep then
    A.vTitularDep := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTitularDep', '0'), 0);

  A.TemdetDependentes := AINIRec.SectionExists('detDependentes' + ASufixo);
  if A.TemdetDependentes then
    Ler_detDependentes(AINIRec, A.detDependentes, ASufixo);
end;

procedure TDeREPlAssistSaudeIniReader.Ler_detDependentes(AINIRec: TMemIniFile; A: TdetDependentesD3201; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'detDependentes' + ASufixo;

  i := 1;
  while AINIRec.ValueExists(sSecao, 'dtNascDep' + IntToStrZero(i, 3)) do
  begin
    A.dtNascDep.Add(StringToDateTime(AINIRec.ReadString(sSecao, 'dtNascDep' + IntToStrZero(i, 3), '0')));
    Inc(i);
  end;
end;

procedure TDeREPlAssistSaudeIniReader.Ler_gTributos(AINIRec: TMemIniFile; A: TgTributosD3201; const ASufixo: string);
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
  RegistrarIniReaderDeRE(tePlAssistSaude, TDeREPlAssistSaudeIniReader);

end.
