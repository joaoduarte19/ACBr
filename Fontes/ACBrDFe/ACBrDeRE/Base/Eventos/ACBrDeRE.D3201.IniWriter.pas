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

unit ACBrDeRE.D3201.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREPlAssistSaudeIniWriter - grava o INI do evento evtPlAssistSaude (D-3201) }

  TDeREPlAssistSaudeIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtPlAssistSaude;

    procedure Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD3201; const ASufixo: string);
    procedure Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD3201; const ASufixo: string);
    procedure Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD3201; const ASufixo: string);
    procedure Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD3201; const ASufixo: string);
    procedure Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD3201; const ASufixo: string);
    procedure Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD3201; const ASufixo: string);
    procedure Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD3201; const ASufixo: string);
    procedure Gravar_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD3201; const ASufixo: string);
    procedure Gravar_gBC(AINIRec: TMemIniFile; A: TgBCD3201; const ASufixo: string);
    procedure Gravar_gVOper(AINIRec: TMemIniFile; A: TgVOperD3201; const ASufixo: string);
    procedure Gravar_detBC(AINIRec: TMemIniFile; A: TdetBCD3201; const ASufixo: string);
    procedure Gravar_gIdBenef(AINIRec: TMemIniFile; A: TgIdBenefD3201; const ASufixo: string);
    procedure Gravar_detBenef(AINIRec: TMemIniFile; A: TdetBenefCollectionItemD3201; const ASufixo: string);
    procedure Gravar_detDependentes(AINIRec: TMemIniFile; A: TdetDependentesD3201; const ASufixo: string);
    procedure Gravar_gTributos(AINIRec: TMemIniFile; A: TgTributosD3201; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREPlAssistSaudeIniWriter }

function TDeREPlAssistSaudeIniWriter.Evt: TevtPlAssistSaude;
begin
  Result := (DeRE as TDeRED3201).evtPlAssistSaude;
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoFin(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApurSub(AINIRec, Evt.idePeriodo);

  Gravar_infoOper(AINIRec, Evt.infoOper, '');
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_infoOper(AINIRec: TMemIniFile; A: TinfoOperD3201; const ASufixo: string);
begin

  Gravar_gOper(AINIRec, A.gOper, ASufixo);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_gOper(AINIRec: TMemIniFile; A: TgOperD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniWriter.Gravar_idePartes(AINIRec: TMemIniFile; A: TidePartesD3201; const ASufixo: string);
begin

  Gravar_infoAdq(AINIRec, A.infoAdq, ASufixo);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_infoAdq(AINIRec: TMemIniFile; A: TinfoAdqD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniWriter.Gravar_adqExterior(AINIRec: TMemIniFile; A: TadqExteriorD3201; const ASufixo: string);
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

procedure TDeREPlAssistSaudeIniWriter.Gravar_dadosOper(AINIRec: TMemIniFile; A: TdadosOperD3201; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detOper.Count - 1 do
    Gravar_detOper(AINIRec, A.detOper[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_detOper(AINIRec: TMemIniFile; A: TdetOperCollectionItemD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'seq', A.seq);
  if A.TemseqRef then
    AINIRec.WriteString(sSecao, 'seqRef', A.seqRef);
  AINIRec.WriteString(sSecao, 'dhOper', DateTimeToStr(A.dhOper));

  Gravar_qualifOper(AINIRec, A.qualifOper, ASufixo);
  Gravar_gBC(AINIRec, A.gBC, ASufixo);
  if A.TemgTributos then
    Gravar_gTributos(AINIRec, A.gTributos, ASufixo);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_qualifOper(AINIRec: TMemIniFile; A: TqualifOperD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'qualifOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'idContrato', A.idContrato);
  AINIRec.WriteString(sSecao, 'tpContrato', tpContratoD3201ToStr(A.tpContrato));
  if A.TemCNPJEntidRelac then
    AINIRec.WriteString(sSecao, 'CNPJEntidRelac', A.CNPJEntidRelac);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_gBC(AINIRec: TMemIniFile; A: TgBCD3201; const ASufixo: string);
begin

  Gravar_gVOper(AINIRec, A.gVOper, ASufixo);
  if A.TemdetBC then
    Gravar_detBC(AINIRec, A.detBC, ASufixo);
  if A.TemgIdBenef then
    Gravar_gIdBenef(AINIRec, A.gIdBenef, ASufixo);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_gVOper(AINIRec: TMemIniFile; A: TgVOperD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'gVOper' + ASufixo;

  AINIRec.WriteString(sSecao, 'vOper', StringReplace(FormatFloat('0.00', A.vOper), ',', '.', []));
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_detBC(AINIRec: TMemIniFile; A: TdetBCD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBC' + ASufixo;

  AINIRec.WriteString(sSecao, 'vBCApur', StringReplace(FormatFloat('0.00', A.vBCApur), ',', '.', []));
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_gIdBenef(AINIRec: TMemIniFile; A: TgIdBenefD3201; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detBenef.Count - 1 do
    Gravar_detBenef(AINIRec, A.detBenef[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_detBenef(AINIRec: TMemIniFile; A: TdetBenefCollectionItemD3201; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBenef' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.TemCPFTitular then
    AINIRec.WriteString(sSecao, 'CPFTitular', A.CPFTitular);
  if A.TemdtNascTitular then
    AINIRec.WriteString(sSecao, 'dtNascTitular', DateToStr(A.dtNascTitular));
  if A.TemvTitularDep then
    AINIRec.WriteString(sSecao, 'vTitularDep', StringReplace(FormatFloat('0.00', A.vTitularDep), ',', '.', []));

  if A.TemdetDependentes then
    Gravar_detDependentes(AINIRec, A.detDependentes, ASufixo);
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_detDependentes(AINIRec: TMemIniFile; A: TdetDependentesD3201; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'detDependentes' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  for i := 0 to A.dtNascDep.Count - 1 do
    AINIRec.WriteString(sSecao, 'dtNascDep' + IntToStrZero(i + 1, 3), DateToStr(A.dtNascDep[i]));
end;

procedure TDeREPlAssistSaudeIniWriter.Gravar_gTributos(AINIRec: TMemIniFile; A: TgTributosD3201; const ASufixo: string);
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
  RegistrarIniWriterDeRE(tePlAssistSaude, TDeREPlAssistSaudeIniWriter);

end.
