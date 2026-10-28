{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{                                                                              }
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

unit ACBrNFeDANFeRTC;

interface

uses
  SysUtils,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.Classes,
  ACBrNFe.Classes,
  pcnConversaoNFe;

type
  TACBrNFeDANFeRTCTributo = record
    Rotulo: String;
    Valor: Double;
  end;

  TACBrNFeDANFeRTCBases = array[0..3] of TACBrNFeDANFeRTCTributo;
  TACBrNFeDANFeRTCPares = array[0..2, 0..1] of TACBrNFeDANFeRTCTributo;

  TACBrNFeDANFeRTCItem = record
    CST: String;
    CFOP: String;
    NCM: String;
    cClassTrib: String;
    Bases: TACBrNFeDANFeRTCBases;
    Aliquotas: TACBrNFeDANFeRTCPares;
    Valores: TACBrNFeDANFeRTCPares;
  end;

  TACBrNFeDANFeRTCEmitente = record
    CRT: String;
    TipoRegimeApuracao: String;
  end;

  TACBrNFeDANFeRTCTotalNota = record
    vProd: Double;
    vFrete: Double;
    vSeg: Double;
    vDesc: Double;
    vOutro: Double;
    vNF: Double;
  end;

  TACBrNFeDANFeRTCTotalICMSIPI = record
    vBC: Double;
    vICMS: Double;
    vBCST: Double;
    vST: Double;
    vIPI: Double;
    vFCP: Double;
    vFCPST: Double;
    vICMSUFDest: Double;
    vFCPUFDest: Double;
    qBCMono: Double;
    vICMSMono: Double;
    qBCMonoReten: Double;
    vICMSMonoReten: Double;
    ExibeFCPDifal: Boolean;
    ExibeMonofasico: Boolean;
  end;

  TACBrNFeDANFeRTCTotalIBSCBSIS = record
    vCBS: Double;
    vIBSUF: Double;
    vIBSMun: Double;
    vIS: Double;
    vIBSMono: Double;
    vCBSMono: Double;
    vIBSMonoReten: Double;
    vCBSMonoReten: Double;
    ExibeMonofasico: Boolean;
  end;

  TACBrNFeDANFeRTCISSQN = record
    IM: String;
    vServ: Double;
    vBC: Double;
    vISS: Double;
    Exibe: Boolean;
  end;

  { TACBrNFeDANFeRTC }

  TACBrNFeDANFeRTC = class
  private
    FNFe: TNFe;

    function DescricaoCRT: String;
    function CSTItem(ADet: TDetCollectionItem): String;
  public
    constructor Create(ANFe: TNFe);

    class function AliquotaRTC(AAliquota: Double; ARed: TgRed): Double;
    class function FormatarValor(AValor: Double): String;
    class function FormatarAliquota(AAliquota: Double): String;

    function Emitente: TACBrNFeDANFeRTCEmitente;
    function TotalNota: TACBrNFeDANFeRTCTotalNota;
    function TotalICMSIPI: TACBrNFeDANFeRTCTotalICMSIPI;
    function TotalIBSCBSIS: TACBrNFeDANFeRTCTotalIBSCBSIS;
    function ISSQN: TACBrNFeDANFeRTCISSQN;

    function ExibeFatura: Boolean;
    function ExibeTransporte: Boolean;
    function ExibeQRCode: Boolean;
    function QRCode: String;

    function QuantidadeItens: Integer;
    function Item(AIndex: Integer): TACBrNFeDANFeRTCItem;
    function ClassificacaoItem(AIndex: Integer): String;

    property NFe: TNFe read FNFe;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings;

const
  cRotuloICMS = 'ICMS';
  cRotuloIBSCBS = 'IBS / CBS';
  cRotuloIS = 'IS';
  cRotuloIPI = 'IPI';
  cRotuloCBS = 'CBS';
  cRotuloIBSUF = 'IBS UF';
  cRotuloIBSMun = 'IBS MUN';

function Tributo(const ARotulo: String; AValor: Double): TACBrNFeDANFeRTCTributo;
begin
  Result.Rotulo := ARotulo;
  Result.Valor := AValor;
end;

{ TACBrNFeDANFeRTC }

constructor TACBrNFeDANFeRTC.Create(ANFe: TNFe);
begin
  inherited Create;

  if not Assigned(ANFe) then
    raise Exception.Create(ACBrStr('NFe não informada'));

  FNFe := ANFe;
end;

// NT 2026.010 item 4.3: com gRed informado imprime pAliqEfet, senão a alíquota vigente
class function TACBrNFeDANFeRTC.AliquotaRTC(AAliquota: Double; ARed: TgRed): Double;
begin
  if Assigned(ARed) and ((ARed.pRedAliq > 0) or (ARed.pAliqEfet > 0)) then
    Result := ARed.pAliqEfet
  else
    Result := AAliquota;
end;

class function TACBrNFeDANFeRTC.FormatarValor(AValor: Double): String;
begin
  Result := FormatFloatBr(AValor, ',0.00');
end;

class function TACBrNFeDANFeRTC.FormatarAliquota(AAliquota: Double): String;
begin
  Result := FormatFloatBr(AAliquota, ',0.00##') + '%';
end;

function TACBrNFeDANFeRTC.DescricaoCRT: String;
begin
  case FNFe.Emit.CRT of
    crtSimplesNacional:
      Result := 'SIMPLES NACIONAL';
    crtSimplesExcessoReceita:
      Result := 'SIMPLES NACIONAL - EXCESSO DE SUBLIMITE DE RECEITA BRUTA';
    crtMEI:
      Result := 'SIMPLES NACIONAL - MEI';
  else
    Result := 'REGIME NORMAL';
  end;

  Result := CRTToStr(FNFe.Emit.CRT) + ' - ' + Result;
end;

function TACBrNFeDANFeRTC.CSTItem(ADet: TDetCollectionItem): String;
var
  LICMS: TICMS;
begin
  LICMS := ADet.Imposto.ICMS;

  if (FNFe.Emit.CRT in [crtSimplesNacional, crtMEI]) and
     not (LICMS.CST in [cst02, cst15, cst53, cst61]) then
    Result := OrigToStr(LICMS.orig) + CSOSNIcmsToStr(LICMS.CSOSN)
  else
    Result := OrigToStr(LICMS.orig) + CSTICMSToStr(LICMS.CST);
end;

function TACBrNFeDANFeRTC.Emitente: TACBrNFeDANFeRTCEmitente;
begin
  Result.CRT := DescricaoCRT;
  Result.TipoRegimeApuracao := '';
end;

function TACBrNFeDANFeRTC.TotalNota: TACBrNFeDANFeRTCTotalNota;
var
  LTot: TICMSTot;
begin
  LTot := FNFe.Total.ICMSTot;

  Result.vProd := LTot.vProd;
  Result.vFrete := LTot.vFrete;
  Result.vSeg := LTot.vSeg;
  Result.vDesc := LTot.vDesc;
  Result.vOutro := LTot.vOutro;
  Result.vNF := LTot.vNF;
end;

function TACBrNFeDANFeRTC.TotalICMSIPI: TACBrNFeDANFeRTCTotalICMSIPI;
var
  LTot: TICMSTot;
begin
  LTot := FNFe.Total.ICMSTot;

  Result.vBC := LTot.vBC;
  Result.vICMS := LTot.vICMS;
  Result.vBCST := LTot.vBCST;
  Result.vST := LTot.vST;
  Result.vIPI := LTot.vIPI;
  Result.vFCP := LTot.vFCP;
  Result.vFCPST := LTot.vFCPST;
  Result.vICMSUFDest := LTot.vICMSUFDest;
  Result.vFCPUFDest := LTot.vFCPUFDest;
  Result.qBCMono := LTot.qBCMono;
  Result.vICMSMono := LTot.vICMSMono;
  Result.qBCMonoReten := LTot.qBCMonoReten;
  Result.vICMSMonoReten := LTot.vICMSMonoReten;

  Result.ExibeFCPDifal := (Result.vFCP > 0) or (Result.vFCPST > 0) or
                          (Result.vICMSUFDest > 0) or (Result.vFCPUFDest > 0);

  Result.ExibeMonofasico := (Result.qBCMono > 0) or (Result.vICMSMono > 0) or
                            (Result.qBCMonoReten > 0) or (Result.vICMSMonoReten > 0);
end;

function TACBrNFeDANFeRTC.TotalIBSCBSIS: TACBrNFeDANFeRTCTotalIBSCBSIS;
var
  LTot: TIBSCBSTot;
begin
  LTot := FNFe.Total.IBSCBSTot;

  Result.vCBS := LTot.gCBS.vCBS;
  Result.vIBSUF := LTot.gIBS.gIBSUFTot.vIBSUF;
  Result.vIBSMun := LTot.gIBS.gIBSMunTot.vIBSMun;
  Result.vIS := FNFe.Total.ISTot.vIS;
  Result.vIBSMono := LTot.gMono.vIBSMono;
  Result.vCBSMono := LTot.gMono.vCBSMono;
  Result.vIBSMonoReten := LTot.gMono.vIBSMonoReten;
  Result.vCBSMonoReten := LTot.gMono.vCBSMonoReten;

  Result.ExibeMonofasico := (Result.vIBSMono > 0) or (Result.vCBSMono > 0) or
                            (Result.vIBSMonoReten > 0) or (Result.vCBSMonoReten > 0);
end;

function TACBrNFeDANFeRTC.ISSQN: TACBrNFeDANFeRTCISSQN;
var
  LTot: TISSQNtot;
begin
  LTot := FNFe.Total.ISSQNtot;

  Result.IM := FNFe.Emit.IM;
  Result.vServ := LTot.vServ;
  Result.vBC := LTot.vBC;
  Result.vISS := LTot.vISS;
  Result.Exibe := (Result.vServ > 0) or (Result.vBC > 0) or (Result.vISS > 0);
end;

function TACBrNFeDANFeRTC.ExibeFatura: Boolean;
begin
  Result := (FNFe.Cobr.Dup.Count > 0);
end;

function TACBrNFeDANFeRTC.ExibeTransporte: Boolean;
var
  LTransp: TTransp;
begin
  LTransp := FNFe.Transp;

  Result := (Trim(LTransp.Transporta.CNPJCPF) <> '') or
            (Trim(LTransp.Transporta.xNome) <> '') or
            (Trim(LTransp.veicTransp.placa) <> '') or
            (LTransp.Vol.Count > 0);
end;

function TACBrNFeDANFeRTC.ExibeQRCode: Boolean;
begin
  Result := (QRCode <> '');
end;

function TACBrNFeDANFeRTC.QRCode: String;
begin
  Result := Trim(FNFe.infNFeSupl.qrCode);
end;

function TACBrNFeDANFeRTC.QuantidadeItens: Integer;
begin
  Result := FNFe.Det.Count;
end;

function TACBrNFeDANFeRTC.Item(AIndex: Integer): TACBrNFeDANFeRTCItem;
var
  LDet: TDetCollectionItem;
  LIBSCBS: TgIBSCBS;
begin
  LDet := FNFe.Det[AIndex];
  LIBSCBS := LDet.Imposto.IBSCBS.gIBSCBS;

  Result.CST := CSTItem(LDet);
  Result.CFOP := LDet.Prod.CFOP;
  Result.NCM := LDet.Prod.NCM;
  Result.cClassTrib := LDet.Imposto.IBSCBS.cClassTrib;

  Result.Bases[0] := Tributo(cRotuloICMS, LDet.Imposto.ICMS.vBC);
  Result.Bases[1] := Tributo(cRotuloIBSCBS, LIBSCBS.vBC);
  Result.Bases[2] := Tributo(cRotuloIS, LDet.Imposto.ISel.vBCIS);
  Result.Bases[3] := Tributo(cRotuloIPI, LDet.Imposto.IPI.vBC);

  Result.Aliquotas[0, 0] := Tributo(cRotuloICMS, LDet.Imposto.ICMS.pICMS);
  Result.Aliquotas[0, 1] := Tributo(cRotuloCBS,
    AliquotaRTC(LIBSCBS.gCBS.pCBS, LIBSCBS.gCBS.gRed));
  Result.Aliquotas[1, 0] := Tributo(cRotuloIBSUF,
    AliquotaRTC(LIBSCBS.gIBSUF.pIBSUF, LIBSCBS.gIBSUF.gRed));
  Result.Aliquotas[1, 1] := Tributo(cRotuloIPI, LDet.Imposto.IPI.pIPI);
  Result.Aliquotas[2, 0] := Tributo(cRotuloIBSMun,
    AliquotaRTC(LIBSCBS.gIBSMun.pIBSMun, LIBSCBS.gIBSMun.gRed));
  Result.Aliquotas[2, 1] := Tributo(cRotuloIS, LDet.Imposto.ISel.pIS);

  Result.Valores[0, 0] := Tributo(cRotuloICMS, LDet.Imposto.ICMS.vICMS);
  Result.Valores[0, 1] := Tributo(cRotuloCBS, LIBSCBS.gCBS.vCBS);
  Result.Valores[1, 0] := Tributo(cRotuloIBSUF, LIBSCBS.gIBSUF.vIBSUF);
  Result.Valores[1, 1] := Tributo(cRotuloIPI, LDet.Imposto.IPI.vIPI);
  Result.Valores[2, 0] := Tributo(cRotuloIBSMun, LIBSCBS.gIBSMun.vIBSMun);
  Result.Valores[2, 1] := Tributo(cRotuloIS, LDet.Imposto.ISel.vIS);
end;

function TACBrNFeDANFeRTC.ClassificacaoItem(AIndex: Integer): String;
var
  LItem: TACBrNFeDANFeRTCItem;
begin
  LItem := Item(AIndex);

  Result := '';
  if LItem.NCM <> '' then
    Result := '[NCM ' + LItem.NCM + ']';

  if LItem.cClassTrib <> '' then
    Result := Trim(Result + ' [cClassTrib ' + LItem.cClassTrib + ']');
end;

end.
