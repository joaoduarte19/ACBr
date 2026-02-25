{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit ACBrNFAg.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAg.Classes,
  ACBrNFAg.Conversao,
  ACBrDFeComum.Proc;

type
  { TNFAgIniWriter }

  TNFAgIniWriter = class
  private
    FNFAg: TNFAg;
    {
    procedure Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
    procedure Gerar_Acessante(AINIRec: TMemIniFile; acessante: Tacessante);
    procedure Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
    procedure Gerar_gJudic(AINIRec: TMemIniFile; gJudic: TgJudic);
    procedure Gerar_gGrContrat(AINIRec: TMemIniFile; gGrContrat: TgGrContratCollection);
    procedure Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
    procedure Gerar_gSCEE(AINIRec: TMemIniFile; gSCEE: TgSCEE);
    procedure Gerar_gConsumidor(AINIRec: TMemIniFile; gConsumidor: TgConsumidorCollection);
    procedure Gerar_EnerAloc(AINIRec: TMemIniFile; enerAlocLista: TenerAlocCollection; Idx: Integer);
    procedure Gerar_EnerInjet(AINIRec: TMemIniFile; enerInjetLista: TenerInjetCollection; Idx: Integer);
    procedure Gerar_gSaldoCred(AINIRec: TMemIniFile; gSaldoCred: TgSaldoCredCollection);
    procedure Gerar_gTipoSaldo(AINIRec: TMemIniFile; gTipoSaldo: TgTipoSaldoCollection);
    procedure Gerar_gTipoSaldogSaldoCred(AINIRec: TMemIniFile; gSaldoCred: TgSaldoCredCollection; Idx: Integer);
    procedure Gerar_NFDet(AINIRec: TMemIniFile; NFDet: TNFDetCollection);
    procedure Gerar_det(AINIRec: TMemIniFile; Det: TDetCollection; Idx: Integer);
    procedure Gerar_DetItem(AINIRec: TMemIniFile; detItem: TdetItem; Idx1, Idx2: Integer);
    procedure Gerar_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; Idx1, Idx2: Integer);
    procedure Gerar_gAdBand(AINIRec: TMemIniFile; gAdBand: TgAdBandCollection; Idx1, Idx2: Integer);
    procedure Gerar_Prod(AINIRec: TMemIniFile; Prod: TProd; Idx1, Idx2: Integer);
    procedure Gerar_Imposto(AINIRec: TMemIniFile; Imposto: TImposto; Idx1, Idx2: Integer);
    procedure Gerar_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Idx1, Idx2: Integer);
    procedure Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Idx1, Idx2: Integer);
    procedure Gerar_PISEfet(AINIRec: TMemIniFile; PISEfet: TPISEfet; Idx1, Idx2: Integer);
    procedure Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Idx1, Idx2: Integer);
    procedure Gerar_COFINSEfet(AINIRec: TMemIniFile; COFINSEfet: TCOFINSEfet; Idx1, Idx2: Integer);
    procedure Gerar_RetTrib(AINIRec: TMemIniFile; retTrib: TretTrib; Idx1, Idx2: Integer);
    procedure Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; Idx1, Idx2: Integer);
    procedure Gerar_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; Idx1, Idx2: Integer);
    procedure Gerar_gContab(AINIRec: TMemIniFile; gContab: TgContabCollection; Idx1, Idx2: Integer);
    procedure Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);
    procedure Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
    procedure Gerar_gANEEL(AINIRec: TMemIniFile; gANEEL: TgANEEL);
    procedure Gerar_gHistFat(AINIRec: TMemIniFile; gHistFat: TgHistFatCollection);
    procedure Gerar_gGrandFat(AINIRec: TMemIniFile; gGrandFat: TgGrandFatCollection; Idx: Integer);
    procedure Gerar_AutorizadosXml(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
    procedure Gerar_InfRespTec(AINIRec: TMemIniFile; infRespTec: TinfRespTec);
    procedure Gerar_InfNFAgSupl(AINIRec: TMemIniFile; infNFAgSupl: TinfNFAgSupl);
    procedure Gerar_ProcessamentoNFAg(AINIRec: TMemIniFile; procNFAg: TProcDFe);

    // Reforma Tributária
    procedure Gerar_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBS_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_gIBSUF(AINIRec: TMemIniFile; gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
    procedure Gerar_gIBSMun(AINIRec: TMemIniFile; gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
    procedure Gerar_gCBS(AINIRec: TMemIniFile; gCBS: TgCBSValores; Idx1, Idx2: Integer);

    procedure Gerar_IBSCBS_gIBSCBS_gTribReg(AINIRec: TMemIniFile; gTribRegular: TgTribRegular;
      Idx1, Idx2: Integer);
    procedure Gerar_gIBSCredPres(AINIRec: TMemIniFile; gIBSCredPres: TgIBSCBSCredPres; Idx1, Idx2: Integer);
    procedure Gerar_gCBSCredPres(AINIRec: TMemIniFile; gCBSCredPres: TgIBSCBSCredPres; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBS_gIBSCBS_gTribCompraGov(AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov;
      Idx1, Idx2: Integer);

    procedure Gerar_IBSCBSTot(AINIRec: TMemIniFile; IBSCBSTot: TIBSCBSTot);
    procedure Gerar_IBSCBSTot_gIBS(AINIRec: TMemIniFile; gIBS: TgIBS);
    procedure Gerar_IBSCBSTot_gIBS_gIBSUFTot(AINIRec: TMemIniFile; gIBSUFTot: TgIBSUFTot);
    procedure Gerar_IBSCBSTot_gIBS_gIBSMunTot(AINIRec: TMemIniFile; gIBSMunTot: TgIBSMunTot);
    procedure Gerar_IBSCBSTot_gCBS(AINIRec: TMemIniFile; gCBS: TgCBS);
    }
  public
    constructor Create(AOwner: TNFAg); reintroduce;

    function GravarIni: string;

    property NFAg: TNFAg read FNFAg write FNFAg;
  end;


implementation

uses
  ACBrDFeUtil,
  ACBrNFAg,
  ACBrUtil.Base;

{ TNFAgIniWriter }

constructor TNFAgIniWriter.Create(AOwner: TNFAg);
begin
  inherited Create;

  FNFAg := AOwner;
end;

function TNFAgIniWriter.GravarIni: string;
var
  INIRec: TMemIniFile;
  IniNFAg: TStringList;
  Chave: string;
begin
  Result := '';

  Chave := Copy(FNFAg.infNFAg.ID, 5, 44);

  if not ValidarChave(Chave) then
    raise EACBrNFAgException.Create('NFAg Inconsistente para gerar INI. Chave Inválida.');

  INIRec := TMemIniFile.Create('');
  try
    INIRec.WriteString('infNFAg', 'ID', FNFAg.infNFAg.ID);
    INIRec.WriteString('infNFAg', 'versao', VersaoNFAgToStr(DblToVersaoNFAg(FNFAg.infNFAg.versao)));
    {
    Gerar_Identificacao(INIRec, FNFAg.Ide);
    Gerar_Emitente(INIRec, FNFAg.Emit);
    Gerar_Destinatario(INIRec, FNFAg.Dest);
    Gerar_Acessante(INIRec, FNFAg.acessante);
    Gerar_gSub(INIRec, FNFAg.gSub);
    Gerar_gJudic(INIRec, FNFAg.gJudic);
    Gerar_gGrContrat(INIRec, FNFAg.gGrContrat);
    Gerar_gMed(INIRec, FNFAg.gMed);
    Gerar_gSCEE(INIRec, FNFAg.gSCEE);
    Gerar_gConsumidor(INIRec, FNFAg.gSCEE.gConsumidor);
    Gerar_gSaldoCred(INIRec, FNFAg.gSCEE.gSaldoCred);
    Gerar_gTipoSaldo(INIRec, FNFAg.gSCEE.gTipoSaldo);
    Gerar_NFDet(INIRec, FNFAg.NFDet);
    Gerar_Total(INIRec, FNFAg.Total);
    Gerar_gFat(INIRec, FNFAg.gFat);
    Gerar_gANEEL(INIRec, FNFAg.gANEEL);
    Gerar_AutorizadosXml(INIRec, FNFAg.autXML);
    Gerar_InfAdic(INIRec, FNFAg.InfAdic);
    Gerar_InfRespTec(INIRec, FNFAg.infRespTec);
    Gerar_InfNFAgSupl(INIRec, FNFAg.infNFAgSupl);
    Gerar_ProcessamentoNFAg(INIRec, FNFAg.procNFAg);
    }
    IniNFAg := TStringList.Create;
    try
      INIRec.GetStrings(IniNFAg);
      Result := StringReplace(IniNFAg.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniNFAg.Free;
    end;
  finally
    INIRec.Free;
  end;
end;
{
procedure TNFAgIniWriter.Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
var
  sSecao: string;
begin
  sSecao := 'ide';
  AINIRec.WriteInteger(sSecao, 'cUF', Ide.cUF);
  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(Ide.tpAmb));
  AINIRec.WriteInteger(sSecao, 'Modelo', Ide.modelo);
  AINIRec.WriteInteger(sSecao, 'Serie', Ide.serie);
  AINIRec.WriteInteger(sSecao, 'nNF', Ide.nNF);
  AINIRec.WriteInteger(sSecao, 'cNF', Ide.cNF);
  AINIRec.WriteString(sSecao, 'dhEmi', DateTimeToStr(Ide.dhEmi));
  AINIRec.WriteString(sSecao, 'tpEmis', TipoEmissaoToStr(Ide.tpemis));
  AINIRec.WriteString(sSecao, 'nSiteAutoriz', SiteAutorizadorToStr(Ide.nSiteAutoriz));
  AINIRec.WriteInteger(sSecao, 'cMunFG', Ide.cMunFG);
  AINIRec.WriteString(sSecao, 'finNFAg', FinNFAgToStr(Ide.finNFAg));
  AINIRec.WriteString(sSecao, 'verProc', Ide.verProc);
  AINIRec.WriteString(sSecao, 'dhCont', DateToStr(Ide.dhCont));
  AINIRec.WriteString(sSecao, 'xJust', Ide.xJust);

  // Reforma Tritutaria
  if Ide.gCompraGov.pRedutor > 0 then
  begin
    AINIRec.WriteString(sSecao, 'tpEnteGov', tpEnteGovToStr(Ide.gCompraGov.tpEnteGov));
    AINIRec.WriteFloat(sSecao, 'pRedutor', Ide.gCompraGov.pRedutor);
  end;
end;

procedure TNFAgIniWriter.Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
var
  sSecao: string;
begin
  sSecao := 'emit';
  AINIRec.WriteString(sSecao, 'CNPJ', Emit.CNPJ);
  AINIRec.WriteString(sSecao, 'IE', Emit.IE);
  AINIRec.WriteString(sSecao, 'xNome', Emit.xNome);
  AINIRec.WriteString(sSecao, 'xFant', Emit.xFant);
  // Endereço do Emitente
  AINIRec.WriteString(sSecao, 'xLgr', Emit.EnderEmit.xLgr);
  AINIRec.WriteString(sSecao, 'nro', Emit.EnderEmit.nro);
  AINIRec.WriteString(sSecao, 'xCpl', Emit.EnderEmit.xCpl);
  AINIRec.WriteString(sSecao, 'xBairro', Emit.EnderEmit.xBairro);
  AINIRec.WriteInteger(sSecao, 'cMun', Emit.EnderEmit.cMun);
  AINIRec.WriteString(sSecao, 'xMun', Emit.EnderEmit.xMun);
  AINIRec.WriteInteger(sSecao, 'CEP', Emit.EnderEmit.CEP);
  AINIRec.WriteString(sSecao, 'UF', Emit.EnderEmit.UF);
  AINIRec.WriteString(sSecao, 'fone', Emit.EnderEmit.fone);
  AINIRec.WriteString(sSecao, 'email', Emit.EnderEmit.email);
end;

procedure TNFAgIniWriter.Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
var
  sSecao: string;
begin
  sSecao := 'dest';
  AINIRec.WriteString(sSecao, 'xNome', Dest.xNome);
  AINIRec.WriteString(sSecao, 'CNPJCPF', Dest.CNPJCPF);
  AINIRec.WriteString(sSecao, 'idOutros', Dest.idOutros);
  AINIRec.WriteString(sSecao, 'indIEDest', indIEDestToStr(Dest.indIEDest));
  AINIRec.WriteString(sSecao, 'IE', Dest.IE);
  AINIRec.WriteString(sSecao, 'IM', Dest.IM);
  AINIRec.WriteString(sSecao, 'cNIS', Dest.cNIS);
  AINIRec.WriteString(sSecao, 'NB', Dest.NB);
  AINIRec.WriteString(sSecao, 'xNomeAdicional', Dest.xNomeAdicional);
  // Endereço do Emitente
  AINIRec.WriteString(sSecao, 'xLgr', Dest.EnderDest.xLgr);
  AINIRec.WriteString(sSecao, 'nro', Dest.EnderDest.nro);
  AINIRec.WriteString(sSecao, 'xCpl', Dest.EnderDest.xCpl);
  AINIRec.WriteString(sSecao, 'xBairro', Dest.EnderDest.xBairro);
  AINIRec.WriteInteger(sSecao, 'cMun', Dest.EnderDest.cMun);
  AINIRec.WriteString(sSecao, 'xMun', Dest.EnderDest.xMun);
  AINIRec.WriteInteger(sSecao, 'CEP', Dest.EnderDest.CEP);
  AINIRec.WriteString(sSecao, 'UF', Dest.EnderDest.UF);
  AINIRec.WriteString(sSecao, 'fone', Dest.EnderDest.fone);
  AINIRec.WriteString(sSecao, 'email', Dest.EnderDest.email);
end;

procedure TNFAgIniWriter.Gerar_Acessante(AINIRec: TMemIniFile;
  acessante: Tacessante);
var
  sSecao: string;
begin
  sSecao := 'acessante';
  AINIRec.WriteString(sSecao, 'idAcesso', acessante.idAcesso);
  AINIRec.WriteString(sSecao, 'idCodCliente', acessante.idCodCliente);
  AINIRec.WriteString(sSecao, 'tpAcesso', tpAcessoToStr(acessante.tpAcesso));
  AINIRec.WriteString(sSecao, 'xNomeUC', acessante.xNomeUC);
  AINIRec.WriteString(sSecao, 'tpClasse', tpClasseToStr(acessante.tpClasse));
  AINIRec.WriteString(sSecao, 'tpSubClasse', tpSubClasseToStr(acessante.tpSubClasse));
  AINIRec.WriteString(sSecao, 'tpFase', tpFaseToStr(acessante.tpFase));
  AINIRec.WriteString(sSecao, 'tpGrpTensao', tpGrpTensaoToStr(acessante.tpGrpTensao));
  AINIRec.WriteString(sSecao, 'tpModTar', tpModTarToStr(acessante.tpModTar));
  AINIRec.WriteString(sSecao, 'latGPS', acessante.latGPS);
  AINIRec.WriteString(sSecao, 'longGPS', acessante.longGPS);
  AINIRec.WriteString(sSecao, 'codRoteiroLeitura', acessante.codRoteiroLeitura);
end;

procedure TNFAgIniWriter.Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
var
  sSecao: string;
begin
  sSecao := 'gSub';
  AINIRec.WriteString(sSecao, 'chNFAg', gSub.chNFAg);
  AINIRec.WriteString(sSecao, 'motSub', MotSubToStr(gSub.motSub));
  AINIRec.WriteString(sSecao, 'CNPJ', gSub.CNPJ);
  AINIRec.WriteString(sSecao, 'Serie', gSub.Serie);
  AINIRec.WriteInteger(sSecao, 'nNF', gSub.nNF);
  AINIRec.WriteString(sSecao, 'CompetEmis', DateTimeToStr(gSub.CompetEmis));
  AINIRec.WriteString(sSecao, 'CompetApur', DateTimeToStr(gSub.CompetApur));
  AINIRec.WriteString(sSecao, 'hash115', gSub.hash115);
end;

procedure TNFAgIniWriter.Gerar_gJudic(AINIRec: TMemIniFile; gJudic: TgJudic);
var
  sSecao: string;
begin
  sSecao := 'gJudic';
  AINIRec.WriteString(sSecao, 'chNFAg', gJudic.chNFAg);
end;

procedure TNFAgIniWriter.Gerar_gGrContrat(AINIRec: TMemIniFile;
  gGrContrat: TgGrContratCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gGrContrat.Count - 1 do
  begin
    sSecao := 'gGrContrat' + IntToStrZero(I + 1, 2);
    with gGrContrat[I] do
    begin
      AINIRec.WriteInteger(sSecao, 'nContrat', nContrat);
      AINIRec.WriteString(sSecao, 'tpGrContrat', tpGrContratToStr(tpGrContrat));
      AINIRec.WriteString(sSecao, 'tpPosTar', tpPosTarToStr(tpPosTar));
      AINIRec.WriteFloat(sSecao, 'qUnidContrat', qUnidContrat);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gMed.Count - 1 do
  begin
    sSecao := 'gMed' + IntToStrZero(I + 1, 2);
    with gMed[I] do
    begin
      AINIRec.WriteInteger(sSecao, 'nMed', nMed);
      AINIRec.WriteString(sSecao, 'idMedidor', idMedidor);
      AINIRec.WriteString(sSecao, 'dMedAnt', DateToStr(dMedAnt));
      AINIRec.WriteString(sSecao, 'dMedAtu', DateToStr(dMedAtu));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gSCEE(AINIRec: TMemIniFile; gSCEE: TgSCEE);
var
  sSecao: string;
begin
  sSecao := 'gSCEE';
  AINIRec.WriteString(sSecao, 'tpPartComp', tpPartCompToStr(gSCEE.tpPartComp));
end;

procedure TNFAgIniWriter.Gerar_gConsumidor(AINIRec: TMemIniFile;
  gConsumidor: TgConsumidorCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gConsumidor.Count - 1 do
  begin
    sSecao := 'gConsumidor' + IntToStrZero(I + 1, 3);
    with gConsumidor[I] do
    begin
      AINIRec.WriteString(sSecao, 'idAcessGer', idAcessGer);
      AINIRec.WriteFloat(sSecao, 'vPotInst', vPotInst);
      AINIRec.WriteString(sSecao, 'tpFonteEnergia', tpFonteEnergiaToStr(tpFonteEnergia));

      Gerar_EnerAloc(AINIRec, gConsumidor[i].enerAlocLista, i);
      Gerar_EnerInjet(AINIRec, gConsumidor[i].enerInjetLista, i);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_EnerAloc(AINIRec: TMemIniFile;
  enerAlocLista: TenerAlocCollection; Idx: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to enerAlocLista.Count - 1 do
  begin
    sSecao := 'EnerAloc' + IntToStrZero(Idx + 1, 3) + IntToStrZero(I + 1, 3);
    with enerAlocLista[I] do
    begin
      AINIRec.WriteFloat(sSecao, 'enerAloc', enerAloc);
      AINIRec.WriteString(sSecao, 'tpPosTar', tpPosTarToStr(tpPosTar));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_EnerInjet(AINIRec: TMemIniFile;
  enerInjetLista: TenerInjetCollection; Idx: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to enerInjetLista.Count - 1 do
  begin
    sSecao := 'EnerInjet' + IntToStrZero(Idx + 1, 3) + IntToStrZero(I + 1, 3);
    with enerInjetLista[I] do
    begin
      AINIRec.WriteFloat(sSecao, 'enerInjet', enerInjet);
      AINIRec.WriteString(sSecao, 'tpPosTarInjet', tpPosTarToStr(tpPosTarInjet));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gSaldoCred(AINIRec: TMemIniFile;
  gSaldoCred: TgSaldoCredCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gSaldoCred.Count - 1 do
  begin
    sSecao := 'gSCEEgSaldoCred' + IntToStrZero(I + 1, 1);
    with gSaldoCred[I] do
    begin
      AINIRec.WriteString(sSecao, 'tpPosTar', tpPosTarToStr(tpPosTar));
      AINIRec.WriteFloat(sSecao, 'vSaldAnt', vSaldAnt);
      AINIRec.WriteFloat(sSecao, 'vCredExpirado', vCredExpirado);
      AINIRec.WriteFloat(sSecao, 'vSaldAtual', vSaldAtual);
      AINIRec.WriteFloat(sSecao, 'vCredExpirar', vCredExpirar);
      AINIRec.WriteString(sSecao, 'CompetExpirar', DateToStr(CompetExpirar));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gTipoSaldo(AINIRec: TMemIniFile;
  gTipoSaldo: TgTipoSaldoCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gTipoSaldo.Count - 1 do
  begin
    sSecao := 'gTipoSaldo' + IntToStrZero(I + 1, 2);

    AINIRec.WriteInteger(sSecao, 'nTipoSaldo', i + 1);

    Gerar_gTipoSaldogSaldoCred(AINIRec, gTipoSaldo[i].gSaldoCred, i + 1);
  end;
end;

procedure TNFAgIniWriter.Gerar_gTipoSaldogSaldoCred(AINIRec: TMemIniFile;
  gSaldoCred: TgSaldoCredCollection; Idx: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gSaldoCred.Count - 1 do
  begin
    sSecao := 'gTipoSaldogSaldoCred' + IntToStrZero(Idx, 2) + IntToStrZero(i + 1, 1);
    with gSaldoCred[I] do
    begin
      AINIRec.WriteString(sSecao, 'tpPosTar', tpPosTarToStr(tpPosTar));
      AINIRec.WriteFloat(sSecao, 'vSaldAnt', vSaldAnt);
      AINIRec.WriteFloat(sSecao, 'vCredExpirado', vCredExpirado);
      AINIRec.WriteFloat(sSecao, 'vSaldAtual', vSaldAtual);
      AINIRec.WriteFloat(sSecao, 'vCredExpirar', vCredExpirar);
      AINIRec.WriteString(sSecao, 'CompetExpirar', DateToStr(CompetExpirar));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_NFDet(AINIRec: TMemIniFile;
  NFDet: TNFDetCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to NFDet.Count - 1 do
  begin
    sSecao := 'NFDet' + IntToStrZero(i + 1, 2);
    with NFDet[I] do
    begin
      AINIRec.WriteString(sSecao, 'chNFAgAnt', chNFAgAnt);
      AINIRec.WriteString(sSecao, 'mod6HashAnt', mod6HashAnt);

      Gerar_det(AINIRec, Det, i + 1);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_det(AINIRec: TMemIniFile; Det: TDetCollection;
  Idx: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to Det.Count - 1 do
  begin
    sSecao := 'Det' + IntToStrZero(Idx, 2) + IntToStrZero(i + 1, 3);
    with Det[I] do
    begin
      AINIRec.WriteInteger(sSecao, 'nItem', nItem);
      AINIRec.WriteString(sSecao, 'tpAjuste', tpAjusteToStr(gAjusteNFAgAnt.tpAjuste));
      AINIRec.WriteString(sSecao, 'motAjuste', motAjusteToStr(gAjusteNFAgAnt.motAjuste));

      AINIRec.WriteInteger(sSecao, 'nItemAnt', detItemAnt.nItemAnt);
      AINIRec.WriteFloat(sSecao, 'vItem', detItemAnt.vItem);
      AINIRec.WriteFloat(sSecao, 'qFaturada', detItemAnt.qFaturada);
      AINIRec.WriteFloat(sSecao, 'vProd', detItemAnt.vProd);
      AINIRec.WriteInteger(sSecao, 'cClass', detItemAnt.cClass);
      AINIRec.WriteFloat(sSecao, 'vBC', detItemAnt.vBC);
      AINIRec.WriteFloat(sSecao, 'pICMS', detItemAnt.pICMS);
      AINIRec.WriteFloat(sSecao, 'vICMS', detItemAnt.vICMS);
      AINIRec.WriteFloat(sSecao, 'vFCP', detItemAnt.vFCP);
      AINIRec.WriteFloat(sSecao, 'vBCST', detItemAnt.vBCST);
      AINIRec.WriteFloat(sSecao, 'vICMSST', detItemAnt.vICMSST);
      AINIRec.WriteFloat(sSecao, 'vFCPST', detItemAnt.vFCPST);
      AINIRec.WriteFloat(sSecao, 'vPIS', detItemAnt.vPIS);
      AINIRec.WriteFloat(sSecao, 'vPISEfet', detItemAnt.vPISEfet);
      AINIRec.WriteFloat(sSecao, 'vCOFINS', detItemAnt.vCOFINS);
      AINIRec.WriteFloat(sSecao, 'vCOFINSEfet', detItemAnt.vCOFINSEfet);
      AINIRec.WriteString(sSecao, 'indDevolucao', TIndicadorToStr(detItemAnt.indDevolucao));

      AINIRec.WriteFloat(sSecao, 'vRetPIS', detItemAnt.retTrib.vRetPIS);
      AINIRec.WriteFloat(sSecao, 'vRetCOFINS', detItemAnt.retTrib.vRetCOFINS);
      AINIRec.WriteFloat(sSecao, 'vRetCSLL', detItemAnt.retTrib.vRetCSLL);
      AINIRec.WriteFloat(sSecao, 'vBCIRRF', detItemAnt.retTrib.vBCIRRF);
      AINIRec.WriteFloat(sSecao, 'vIRRF', detItemAnt.retTrib.vIRRF);

      Gerar_DetItem(AINIRec, detItem, Idx, i + 1);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_DetItem(AINIRec: TMemIniFile; detItem: TdetItem;
  Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'detItem' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteInteger(sSecao, 'nItemAnt', detItem.nItemAnt);
  AINIRec.WriteString(sSecao, 'infAdProd', detItem.infAdProd);

  Gerar_gTarif(AINIRec, detItem.gTarif, Idx1, Idx2);
  Gerar_gAdBand(AINIRec, detItem.gAdBand, Idx1, Idx2);
  Gerar_Prod(AINIRec, detItem.Prod, Idx1, Idx2);
  Gerar_Imposto(AINIRec, detItem.Imposto, Idx1, Idx2);
  Gerar_gProcRef(AINIRec, detItem.gProcRef, Idx1, Idx2);
  Gerar_gContab(AINIRec, detItem.gContab, Idx1, Idx2);
end;

procedure TNFAgIniWriter.Gerar_gTarif(AINIRec: TMemIniFile;
  gTarif: TgTarifCollection; Idx1, Idx2: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gTarif.Count - 1 do
  begin
    sSecao := 'gTarif' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3) + IntToStrZero(i + 1, 1);

    with gTarif[I] do
    begin
      AINIRec.WriteString(sSecao, 'dIniTarif', DateToStr(dIniTarif));
      AINIRec.WriteString(sSecao, 'dFimTarif', DateToStr(dFimTarif));
      AINIRec.WriteString(sSecao, 'tpAto', tpAtoToStr(tpAto));
      AINIRec.WriteString(sSecao, 'nAto', nAto);
      AINIRec.WriteInteger(sSecao, 'anoAto', anoAto);
      AINIRec.WriteString(sSecao, 'tpTarif', tpTarifToStr(tpTarif));
      AINIRec.WriteString(sSecao, 'cPosTarif', cPosTarifToStr(cPosTarif));
      AINIRec.WriteString(sSecao, 'uMed', uMedToStr(uMed));
      AINIRec.WriteFloat(sSecao, 'vTarifHom', vTarifHom);
      AINIRec.WriteFloat(sSecao, 'vTarifAplic', vTarifAplic);
      AINIRec.WriteString(sSecao, 'motDifTarif', motDifTarifToStr(motDifTarif));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gAdBand(AINIRec: TMemIniFile;
  gAdBand: TgAdBandCollection; Idx1, Idx2: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gAdBand.Count - 1 do
  begin
    sSecao := 'gAdBand' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3) + IntToStrZero(i + 1, 1);

    with gAdBand[I] do
    begin
      AINIRec.WriteString(sSecao, 'dIniAdBand', DateToStr(dIniAdBand));
      AINIRec.WriteString(sSecao, 'dFimAdBand', DateToStr(dFimAdBand));
      AINIRec.WriteString(sSecao, 'tpBand', tpBandToStr(tpBand));
      AINIRec.WriteFloat(sSecao, 'vAdBand', vAdBand);
      AINIRec.WriteFloat(sSecao, 'vAdBandAplic', vAdBandAplic);
      AINIRec.WriteString(sSecao, 'motDifBand', motDifBandToStr(motDifBand));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_Prod(AINIRec: TMemIniFile; Prod: TProd; Idx1,
  Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'Prod' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'indOrigemQtd',indOrigemQtdToStr(Prod.indOrigemQtd));
  AINIRec.WriteString(sSecao, 'cProd', Prod.cProd);
  AINIRec.WriteString(sSecao, 'xProd', Prod.xProd);
  AINIRec.WriteInteger(sSecao, 'cClass', Prod.cClass);
  AINIRec.WriteInteger(sSecao, 'CFOP', Prod.CFOP);
  AINIRec.WriteString(sSecao, 'uMedProd', uMedFatToStr(Prod.uMed));
  AINIRec.WriteInteger(sSecao, 'qFaturada', Prod.qFaturada);
  AINIRec.WriteFloat(sSecao, 'vItem', Prod.vItem);
  AINIRec.WriteFloat(sSecao, 'vProd', Prod.vProd);
  AINIRec.WriteString(sSecao, 'indDevolucao', TIndicadorToStr(Prod.indDevolucao));
  AINIRec.WriteString(sSecao, 'indPrecoACL', TIndicadorToStr(Prod.indPrecoACL));

  AINIRec.WriteInteger(sSecao, 'nMed', Prod.gMedicao.nMed);
  AINIRec.WriteInteger(sSecao, 'nContrat', Prod.gMedicao.nContrat);
  AINIRec.WriteString(sSecao, 'tpGrMed', tpGrMedToStr(Prod.gMedicao.tpGrMed));
  AINIRec.WriteString(sSecao, 'cPosTarif', cPosTarifToStr(Prod.gMedicao.cPosTarif));
  AINIRec.WriteString(sSecao, 'uMedMedicao', uMedFatToStr(Prod.gMedicao.uMed));
  AINIRec.WriteFloat(sSecao, 'vMedAnt', Prod.gMedicao.vMedAnt);
  AINIRec.WriteFloat(sSecao, 'vMedAtu', Prod.gMedicao.vMedAtu);
  AINIRec.WriteFloat(sSecao, 'vConst', Prod.gMedicao.vConst);
  AINIRec.WriteFloat(sSecao, 'vMed', Prod.gMedicao.vMed);
  AINIRec.WriteFloat(sSecao, 'pPerdaTran', Prod.gMedicao.pPerdaTran);
  AINIRec.WriteFloat(sSecao, 'vMedPerdaTran', Prod.gMedicao.vMedPerdaTran);
  AINIRec.WriteFloat(sSecao, 'vMedPerdaTec', Prod.gMedicao.vMedPerdaTec);
  AINIRec.WriteString(sSecao, 'tpMotNaoLeitura', tpMotNaoLeituraToStr(Prod.gMedicao.tpMotNaoLeitura));
end;

procedure TNFAgIniWriter.Gerar_Imposto(AINIRec: TMemIniFile; Imposto: TImposto;
  Idx1, Idx2: Integer);
begin
  Gerar_ICMS(AINIRec, Imposto.ICMS, Idx1, Idx2);
  Gerar_PIS(AINIRec, Imposto.PIS, Idx1, Idx2);
  Gerar_PISEfet(AINIRec, Imposto.PISEfet, Idx1, Idx2);
  Gerar_COFINS(AINIRec, Imposto.COFINS, Idx1, Idx2);
  Gerar_COFINSEfet(AINIRec, Imposto.COFINSEfet, Idx1, Idx2);
  Gerar_RetTrib(AINIRec, Imposto.retTrib, Idx1, Idx2);
  // Reforma Tributária
  Gerar_IBSCBS(AINIRec, Imposto.IBSCBS, Idx1, Idx2);
end;

procedure TNFAgIniWriter.Gerar_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Idx1,
  Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'ICMS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'indSemCST', TIndicadorToStr(ICMS.indSemCST));
  AINIRec.WriteString(sSecao, 'CST', CSTICMSToStr(ICMS.CST));
  AINIRec.WriteFloat(sSecao, 'vBC', ICMS.vBC);
  AINIRec.WriteFloat(sSecao, 'pICMS', ICMS.pICMS);
  AINIRec.WriteFloat(sSecao, 'vICMS', ICMS.vICMS);
  AINIRec.WriteFloat(sSecao, 'pFCP', ICMS.pFCP);
  AINIRec.WriteFloat(sSecao, 'vFCP', ICMS.vFCP);
  AINIRec.WriteFloat(sSecao, 'vBCST', ICMS.vBCST);
  AINIRec.WriteFloat(sSecao, 'pICMSST', ICMS.pICMSST);
  AINIRec.WriteFloat(sSecao, 'vICMSST', ICMS.vICMSST);
  AINIRec.WriteFloat(sSecao, 'pFCPST', ICMS.pFCPST);
  AINIRec.WriteFloat(sSecao, 'vFCPST', ICMS.vFCPST);
  AINIRec.WriteFloat(sSecao, 'pRedBC', ICMS.pRedBC);
  AINIRec.WriteFloat(sSecao, 'vICMSDeson', ICMS.vICMSDeson);
  AINIRec.WriteString(sSecao, 'cBenef', ICMS.cBenef);
  AINIRec.WriteFloat(sSecao, 'vBCSTRet', ICMS.vBCSTRet);
  AINIRec.WriteFloat(sSecao, 'pICMSSTRet', ICMS.pICMSSTRet);
  AINIRec.WriteFloat(sSecao, 'vICMSSubstituto', ICMS.vICMSSubstituto);
  AINIRec.WriteFloat(sSecao, 'vICMSSTRet', ICMS.vICMSSTRet);
  AINIRec.WriteFloat(sSecao, 'vBCFCPSTRet', ICMS.vBCFCPSTRet);
  AINIRec.WriteFloat(sSecao, 'pFCPSTRet', ICMS.pFCPSTRet);
  AINIRec.WriteFloat(sSecao, 'vFCPSTRet', ICMS.vFCPSTRet);
  AINIRec.WriteFloat(sSecao, 'pRedBCEfet', ICMS.pRedBCEfet);
  AINIRec.WriteFloat(sSecao, 'vBCEfet', ICMS.vBCEfet);
  AINIRec.WriteFloat(sSecao, 'pICMSEfet', ICMS.pICMSEfet);
  AINIRec.WriteFloat(sSecao, 'vICMSEfet', ICMS.vICMSEfet);
end;

procedure TNFAgIniWriter.Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Idx1,
  Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'PIS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'CST', CSTPISToStr(PIS.CST));
  AINIRec.WriteFloat(sSecao, 'vBC', PIS.vBC);
  AINIRec.WriteFloat(sSecao, 'pPIS', PIS.pPIS);
  AINIRec.WriteFloat(sSecao, 'vPIS', PIS.vPIS);
end;

procedure TNFAgIniWriter.Gerar_PISEfet(AINIRec: TMemIniFile; PISEfet: TPISEfet;
  Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'PISEfet' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'vBCPISEfet', PISEfet.vBCPISEfet);
  AINIRec.WriteFloat(sSecao, 'pPISEfet', PISEfet.pPISEfet);
  AINIRec.WriteFloat(sSecao, 'vPISEfet', PISEfet.vPISEfet);
end;

procedure TNFAgIniWriter.Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Idx1,
  Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'COFINS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'CST', CSTCOFINSToStr(COFINS.CST));
  AINIRec.WriteFloat(sSecao, 'vBC', COFINS.vBC);
  AINIRec.WriteFloat(sSecao, 'pCOFINS', COFINS.pCOFINS);
  AINIRec.WriteFloat(sSecao, 'vCOFINS', COFINS.vCOFINS);
end;

procedure TNFAgIniWriter.Gerar_COFINSEfet(AINIRec: TMemIniFile;
  COFINSEfet: TCOFINSEfet; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'COFINSEfet' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'vBCCOFINSEfet', COFINSEfet.vBCCOFINSEfet);
  AINIRec.WriteFloat(sSecao, 'pCOFINSEfet', COFINSEfet.pCOFINSEfet);
  AINIRec.WriteFloat(sSecao, 'vCOFINSEfet', COFINSEfet.vCOFINSEfet);
end;

procedure TNFAgIniWriter.Gerar_RetTrib(AINIRec: TMemIniFile; retTrib: TretTrib;
  Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'retTrib' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'vRetPIS', retTrib.vRetPIS);
  AINIRec.WriteFloat(sSecao, 'vRetCOFINS', retTrib.vRetCOFINS);
  AINIRec.WriteFloat(sSecao, 'vRetCSLL', retTrib.vRetCSLL);
  AINIRec.WriteFloat(sSecao, 'vBCIRRF', retTrib.vBCIRRF);
  AINIRec.WriteFloat(sSecao, 'vIRRF', retTrib.vIRRF);
end;

procedure TNFAgIniWriter.Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef;
  Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gProcRef' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'vItem', gProcRef.vItem);
  AINIRec.WriteInteger(sSecao, 'qFaturada', gProcRef.qFaturada);
  AINIRec.WriteFloat(sSecao, 'vProd', gProcRef.vProd);
  AINIRec.WriteString(sSecao, 'indDevolucao', TIndicadorToStr(gProcRef.indDevolucao));
  AINIRec.WriteFloat(sSecao, 'vBC', gProcRef.vBC);
  AINIRec.WriteFloat(sSecao, 'pICMS', gProcRef.pICMS);
  AINIRec.WriteFloat(sSecao, 'vICMS', gProcRef.vICMS);
  AINIRec.WriteFloat(sSecao, 'pFCP', gProcRef.pFCP);
  AINIRec.WriteFloat(sSecao, 'vFCP', gProcRef.vFCP);
  AINIRec.WriteFloat(sSecao, 'vBCST', gProcRef.vBCST);
  AINIRec.WriteFloat(sSecao, 'pICMSST', gProcRef.pICMSST);
  AINIRec.WriteFloat(sSecao, 'vICMSST', gProcRef.vICMSST);
  AINIRec.WriteFloat(sSecao, 'pFCPST', gProcRef.pFCPST);
  AINIRec.WriteFloat(sSecao, 'vFCPST', gProcRef.vFCPST);
  AINIRec.WriteFloat(sSecao, 'vPIS', gProcRef.vPIS);
  AINIRec.WriteFloat(sSecao, 'vPISEfet', gProcRef.vPISEfet);
  AINIRec.WriteFloat(sSecao, 'vCOFINS', gProcRef.vCOFINS);
  AINIRec.WriteFloat(sSecao, 'vCOFINSEfet', gProcRef.vCOFINSEfet);

  Gerar_gProc(AINIRec, gProcRef.gProc, Idx1, Idx2);
end;

procedure TNFAgIniWriter.Gerar_gProc(AINIRec: TMemIniFile;
  gProc: TgProcCollection; Idx1, Idx2: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gProc.Count - 1 do
  begin
    sSecao := 'gProc' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3) + IntToStrZero(i + 1, 1);

    with gProc[I] do
    begin
      AINIRec.WriteString(sSecao, 'tpProc', tpProcToStr(tpProc));
      AINIRec.WriteString(sSecao, 'nProcesso', nProcesso);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gContab(AINIRec: TMemIniFile;
  gContab: TgContabCollection; Idx1, Idx2: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gContab.Count - 1 do
  begin
    sSecao := 'gContab' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3) + IntToStrZero(i + 1, 1);

    with gContab[I] do
    begin
      AINIRec.WriteString(sSecao, 'cContab', cContab);
      AINIRec.WriteString(sSecao, 'xContab', xContab);
      AINIRec.WriteFloat(sSecao, 'vContab', vContab);
      AINIRec.WriteString(sSecao, 'tpLanc', tpLancToStr(tpLanc));
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);
var
  sSecao: string;
begin
  sSecao := 'total';

  AINIRec.WriteFloat(sSecao, 'vProd', Total.vProd);
  AINIRec.WriteFloat(sSecao, 'vBC', Total.vBC);
  AINIRec.WriteFloat(sSecao, 'vICMSDeson', Total.vICMSDeson);
  AINIRec.WriteFloat(sSecao, 'vFCP', Total.vFCP);
  AINIRec.WriteFloat(sSecao, 'vBCST', Total.vBCST);
  AINIRec.WriteFloat(sSecao, 'vST', Total.vST);
  AINIRec.WriteFloat(sSecao, 'vFCPST', Total.vFCPST);
  AINIRec.WriteFloat(sSecao, 'vRetPIS', Total.vRetPIS);
  AINIRec.WriteFloat(sSecao, 'vRetCOFINS', Total.vRetCOFINS);
  AINIRec.WriteFloat(sSecao, 'vRetCSLL', Total.vRetCSLL);
  AINIRec.WriteFloat(sSecao, 'vIRRF', Total.vIRRF);
  AINIRec.WriteFloat(sSecao, 'vCOFINS', Total.vCOFINS);
  AINIRec.WriteFloat(sSecao, 'vCOFINSEfet', Total.vCOFINSEfet);
  AINIRec.WriteFloat(sSecao, 'vPIS', Total.vPIS);
  AINIRec.WriteFloat(sSecao, 'vPISEfet', Total.vPISEfet);
  AINIRec.WriteFloat(sSecao, 'vNF', Total.vNF);
  AINIRec.WriteFloat(sSecao, 'vTotDFe', Total.vTotDFe);

  // Reforma Tributária
  Gerar_IBSCBSTot(AINIRec, total.IBSCBSTot);
end;

procedure TNFAgIniWriter.Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
var
  sSecao: string;
begin
  sSecao := 'gFat';

  AINIRec.WriteString(sSecao, 'CompetFat', DateTimeToStr(gFat.CompetFat));
  AINIRec.WriteString(sSecao, 'dVencFat', DateTimeToStr(gFat.dVencFat));
  AINIRec.WriteString(sSecao, 'dApresFat', DateTimeToStr(gFat.dApresFat));
  AINIRec.WriteString(sSecao, 'dProxLeitura', DateTimeToStr(gFat.dProxLeitura));
  AINIRec.WriteString(sSecao, 'nFat', gFat.nFat);
  AINIRec.WriteString(sSecao, 'codBarras', gFat.codBarras);
  AINIRec.WriteString(sSecao, 'codDebAuto', gFat.codDebAuto);
  AINIRec.WriteString(sSecao, 'codBanco', gFat.codBanco);
  AINIRec.WriteString(sSecao, 'codAgencia', gFat.codAgencia);
  // Endereço do Destinatario
  AINIRec.WriteString(sSecao, 'xLgr', gFat.enderCorresp.xLgr);
  AINIRec.WriteString(sSecao, 'nro', gFat.enderCorresp.nro);
  AINIRec.WriteString(sSecao, 'xCpl', gFat.enderCorresp.xCpl);
  AINIRec.WriteString(sSecao, 'xBairro', gFat.enderCorresp.xBairro);
  AINIRec.WriteInteger(sSecao, 'cMun', gFat.enderCorresp.cMun);
  AINIRec.WriteString(sSecao, 'xMun', gFat.enderCorresp.xMun);
  AINIRec.WriteInteger(sSecao, 'CEP', gFat.enderCorresp.CEP);
  AINIRec.WriteString(sSecao, 'UF', gFat.enderCorresp.UF);
  AINIRec.WriteString(sSecao, 'fone', gFat.enderCorresp.fone);
  AINIRec.WriteString(sSecao, 'email', gFat.enderCorresp.email);
  // Chave PIX
  AINIRec.WriteString(sSecao, 'urlQRCodePIX', gFat.gPIX.urlQRCodePIX);
end;

procedure TNFAgIniWriter.Gerar_gANEEL(AINIRec: TMemIniFile; gANEEL: TgANEEL);
begin
  Gerar_gHistFat(AINIRec, gANEEL.gHistFat);
end;

procedure TNFAgIniWriter.Gerar_gHistFat(AINIRec: TMemIniFile;
  gHistFat: TgHistFatCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gHistFat.Count - 1 do
  begin
    sSecao := 'gHistFat' + IntToStrZero(i + 1, 1);

    with gHistFat[I] do
    begin
      AINIRec.WriteString(sSecao, 'xGrandFat', xGrandFat);

      Gerar_gGrandFat(AINIRec, gGrandFat, i + 1);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_gGrandFat(AINIRec: TMemIniFile;
  gGrandFat: TgGrandFatCollection; Idx: Integer);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to gGrandFat.Count - 1 do
  begin
    sSecao := 'gGrandFat' + IntToStrZero(Idx, 1) + IntToStrZero(i + 1, 2);

    with gGrandFat[I] do
    begin
      AINIRec.WriteString(sSecao, 'CompetFat', DateTimeToStr(CompetFat));
      AINIRec.WriteFloat(sSecao, 'vFat', vFat);
      AINIRec.WriteString(sSecao, 'uMed', uMedFatToStr(uMed));
      AINIRec.WriteInteger(sSecao, 'qtdDias', qtdDias);
    end;
  end;
end;

procedure TNFAgIniWriter.Gerar_AutorizadosXml(AINIRec: TMemIniFile;
  autXML: TautXMLCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to autXML.Count - 1 do
  begin
    sSecao := 'autXML' + IntToStrZero(i + 1, 2);

    AINIRec.WriteString(sSecao, 'CNPJCPF', autXML.Items[i].CNPJCPF);
  end;
end;

procedure TNFAgIniWriter.Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
var
  sSecao: string;
begin
  sSecao := 'infAdic';

  AINIRec.WriteString(sSecao, 'infAdFisco', InfAdic.infAdFisco);
  // Vai ser alterado pois é uma lista
  AINIRec.WriteString(sSecao, 'infCpl', InfAdic.infCpl);
end;

procedure TNFAgIniWriter.Gerar_InfRespTec(AINIRec: TMemIniFile;
  infRespTec: TinfRespTec);
var
  sSecao: string;
begin
  sSecao := 'infRespTec';

  AINIRec.WriteString(sSecao, 'CNPJ', infRespTec.CNPJ);
  AINIRec.WriteString(sSecao, 'xContato', infRespTec.xContato);
  AINIRec.WriteString(sSecao, 'email', infRespTec.email);
  AINIRec.WriteString(sSecao, 'fone', infRespTec.fone);
end;

procedure TNFAgIniWriter.Gerar_InfNFAgSupl(AINIRec: TMemIniFile;
  infNFAgSupl: TinfNFAgSupl);
var
  sSecao: string;
begin
  sSecao := 'infNFAgSupl';

  AINIRec.WriteString(sSecao, 'qrCodNFAg', infNFAgSupl.qrCodNFAg);
end;

procedure TNFAgIniWriter.Gerar_ProcessamentoNFAg(AINIRec: TMemIniFile;
  procNFAg: TProcDFe);
var
  sSecao: string;
begin
  sSecao := 'procNFAg';

  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(procNFAg.tpAmb));
  AINIRec.WriteString(sSecao, 'verAplic', procNFAg.verAplic);
  AINIRec.WriteString(sSecao, 'chNFAg', procNFAg.chDFe);
  AINIRec.WriteString(sSecao, 'dhRecbto', DateTimeToStr(procNFAg.dhRecbto));
  AINIRec.WriteString(sSecao, 'nProt', procNFAg.nProt);
  AINIRec.WriteString(sSecao, 'digVal', procNFAg.digVal);
  AINIRec.WriteInteger(sSecao, 'cStat', procNFAg.cStat);
  AINIRec.WriteString(sSecao, 'xMotivo', procNFAg.xMotivo);
  AINIRec.WriteInteger(sSecao, 'cMsg', procNFAg.cMsg);
  AINIRec.WriteString(sSecao, 'xMsg', procNFAg.xMsg);
end;

// Reforma Tributária
procedure TNFAgIniWriter.Gerar_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if (IBSCBS.gIBSCBS.vBC > 0) then
  begin
    sSecao := 'IBSCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

    AINIRec.WriteString(sSecao, 'CST', CSTIBSCBSToStr(IBSCBS.CST));
    AINIRec.WriteString(sSecao, 'cClassTrib', IBSCBS.cClassTrib);

    if IBSCBS.gIBSCBS.vBC > 0 then
      Gerar_IBSCBS_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
  end;
end;

procedure TNFAgIniWriter.Gerar_IBSCBS_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'vBC', gIBSCBS.vBC);
  AINIRec.WriteFloat(sSecao, 'vIBS', gIBSCBS.vIBS);

  Gerar_gIBSUF(AINIRec, gIBSCBS.gIBSUF, Idx1, Idx2);
  Gerar_gIBSMun(AINIRec, gIBSCBS.gIBSMun, Idx1, Idx2);
  Gerar_gCBS(AINIRec, gIBSCBS.gCBS, Idx1, Idx2);

  if gIBSCBS.gTribRegular.pAliqEfetRegIBSUF > 0 then
    Gerar_IBSCBS_gIBSCBS_gTribReg(AINIRec, gIBSCBS.gTribRegular, Idx1, Idx2);

  if gIBSCBS.gIBSCredPres.pCredPres > 0 then
    Gerar_gIBSCredPres(AINIRec, gIBSCBS.gIBSCredPres, Idx1, Idx2);

  if gIBSCBS.gCBSCredPres.pCredPres > 0 then
    Gerar_gCBSCredPres(AINIRec, gIBSCBS.gCBSCredPres, Idx1, Idx2);

  if gIBSCBS.gTribCompraGov.pAliqIBSUF > 0 then
    Gerar_IBSCBS_gIBSCBS_gTribCompraGov(AINIRec, gIBSCBS.gTribCompraGov, Idx1, Idx2);
end;

procedure TNFAgIniWriter.Gerar_gIBSUF(AINIRec: TMemIniFile;
  gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSUF' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'pIBSUF', gIBSUF.pIBS);
  AINIRec.WriteFloat(sSecao, 'vIBSUF', gIBSUF.vIBS);

  AINIRec.WriteFloat(sSecao, 'pDif', gIBSUF.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gIBSUF.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSUF.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gIBSUF.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gIBSUF.gRed.pAliqEfet);
end;

procedure TNFAgIniWriter.Gerar_gIBSMun(AINIRec: TMemIniFile;
  gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSMun' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'pIBSMun', gIBSMun.pIBS);
  AINIRec.WriteFloat(sSecao, 'vIBSMun', gIBSMun.vIBS);

  AINIRec.WriteFloat(sSecao, 'pDif', gIBSMun.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gIBSMun.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSMun.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gIBSMun.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gIBSMun.gRed.pAliqEfet);
end;

procedure TNFAgIniWriter.Gerar_gCBS(AINIRec: TMemIniFile; gCBS: TgCBSValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'pCBS', gCBS.pCBS);
  AINIRec.WriteFloat(sSecao, 'vCBS', gCBS.vCBS);

  AINIRec.WriteFloat(sSecao, 'pDif', gCBS.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gCBS.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'vDevTrib', gCBS.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gCBS.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gCBS.gRed.pAliqEfet);
end;

procedure TNFAgIniWriter.Gerar_IBSCBS_gIBSCBS_gTribReg(AINIRec: TMemIniFile;
  gTribRegular: TgTribRegular; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gTribRegular' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'CSTReg', CSTIBSCBSToStr(gTribRegular.CSTReg));
  AINIRec.WriteString(sSecao, 'cClassTribReg', gTribRegular.cClassTribReg);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegIBSUF', gTribRegular.pAliqEfetRegIBSUF);
  AINIRec.WriteFloat(sSecao, 'vTribRegIBSUF', gTribRegular.vTribRegIBSUF);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegIBSMun', gTribRegular.pAliqEfetRegIBSMun);
  AINIRec.WriteFloat(sSecao, 'vTribRegIBSMun', gTribRegular.vTribRegIBSMun);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegCBS', gTribRegular.pAliqEfetRegCBS);
  AINIRec.WriteFloat(sSecao, 'vTribRegCBS', gTribRegular.vTribRegCBS);
end;

procedure TNFAgIniWriter.Gerar_gIBSCredPres(AINIRec: TMemIniFile; gIBSCredPres: TgIBSCBSCredPres; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSCredPres' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'cCredPres', cCredPresToStr(gIBSCredPres.cCredPres));
  AINIRec.WriteFloat(sSecao, 'pCredPres', gIBSCredPres.pCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPres', gIBSCredPres.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gIBSCredPres.vCredPresCondSus);
end;

procedure TNFAgIniWriter.Gerar_gCBSCredPres(AINIRec: TMemIniFile; gCBSCredPres: TgIBSCBSCredPres; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCBSCredPres' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteString(sSecao, 'cCredPres', cCredPresToStr(gCBSCredPres.cCredPres));
  AINIRec.WriteFloat(sSecao, 'pCredPres', gCBSCredPres.pCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPres', gCBSCredPres.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gCBSCredPres.vCredPresCondSus);
end;

procedure TNFAgIniWriter.Gerar_IBSCBS_gIBSCBS_gTribCompraGov(
  AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  sSecao := 'gTribCompraGov' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);

  AINIRec.WriteFloat(sSecao, 'pAliqIBSUF', gTribCompraGov.pAliqIBSUF);
  AINIRec.WriteFloat(sSecao, 'vTribIBSUF', gTribCompraGov.vTribIBSUF);
  AINIRec.WriteFloat(sSecao, 'pAliqIBSMun', gTribCompraGov.pAliqIBSMun);
  AINIRec.WriteFloat(sSecao, 'vTribIBSMun', gTribCompraGov.vTribIBSMun);
  AINIRec.WriteFloat(sSecao, 'pAliqCBS', gTribCompraGov.pAliqCBS);
  AINIRec.WriteFloat(sSecao, 'vTribCBS', gTribCompraGov.vTribCBS);
end;

procedure TNFAgIniWriter.Gerar_IBSCBSTot(AINIRec: TMemIniFile;
  IBSCBSTot: TIBSCBSTot);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSTot';

  AINIRec.WriteFloat(sSecao, 'vBCIBSCBS', IBSCBSTot.vBCIBSCBS);

  Gerar_IBSCBSTot_gIBS(AINIRec, IBSCBSTot.gIBS);
  Gerar_IBSCBSTot_gCBS(AINIRec, IBSCBSTot.gCBS);
end;

procedure TNFAgIniWriter.Gerar_IBSCBSTot_gIBS(AINIRec: TMemIniFile;
  gIBS: TgIBS);
var
  sSecao: string;
begin
  sSecao := 'gIBS';

  AINIRec.WriteFloat(sSecao, 'vCredPres', gIBS.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gIBS.vCredPresCondSus);
  AINIRec.WriteFloat(sSecao, 'vIBS', gIBS.vIBS);

  Gerar_IBSCBSTot_gIBS_gIBSUFTot(AINIRec, gIBS.gIBSUFTot);
  Gerar_IBSCBSTot_gIBS_gIBSMunTot(AINIRec, gIBS.gIBSMunTot);
end;

procedure TNFAgIniWriter.Gerar_IBSCBSTot_gIBS_gIBSUFTot(AINIRec: TMemIniFile;
  gIBSUFTot: TgIBSUFTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSUFTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gIBSUFTot.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSUFTot.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vIBSUF', gIBSUFTot.vIBSUF);
end;

procedure TNFAgIniWriter.Gerar_IBSCBSTot_gIBS_gIBSMunTot(AINIRec: TMemIniFile;
  gIBSMunTot: TgIBSMunTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSMunTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gIBSMunTot.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSMunTot.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vIBSMun', gIBSMunTot.vIBSMun);
end;

procedure TNFAgIniWriter.Gerar_IBSCBSTot_gCBS(AINIRec: TMemIniFile;
  gCBS: TgCBS);
var
  sSecao: string;
begin
  sSecao := 'gCBSTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gCBS.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gCBS.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vCBS', gCBS.vCBS);
  AINIRec.WriteFloat(sSecao, 'vCredPres', gCBS.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gCBS.vCredPresCondSus);
end;
}
end.
