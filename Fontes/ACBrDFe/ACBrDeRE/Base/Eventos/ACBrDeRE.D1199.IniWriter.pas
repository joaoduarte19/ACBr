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

unit ACBrDeRE.D1199.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREFechMensalIniWriter - grava o INI do evento evtFechMensal (D-1199) }

  TDeREFechMensalIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtFechMensal;

    procedure Gravar_infoFechamento(AINIRec: TMemIniFile; A: TinfoFechamentoD1199; const ASufixo: string);
    procedure Gravar_infoParamFech(AINIRec: TMemIniFile; A: TinfoParamFechD1199; const ASufixo: string);
    procedure Gravar_gUtilizBCN(AINIRec: TMemIniFile; A: TgUtilizBCND1199; const ASufixo: string);
    procedure Gravar_infoBCN(AINIRec: TMemIniFile; A: TinfoBCNCollectionItemD1199; const ASufixo: string);
    procedure Gravar_detBCNeg(AINIRec: TMemIniFile; A: TdetBCNegCollectionItemD1199; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREFechMensalIniWriter }

function TDeREFechMensalIniWriter.Evt: TevtFechMensal;
begin
  Result := (DeRE as TDeRED1199).evtFechMensal;
end;

procedure TDeREFechMensalIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEvento(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoFechamento.TeminfoFechamento then
    Gravar_infoFechamento(AINIRec, Evt.infoFechamento, '');
end;

procedure TDeREFechMensalIniWriter.Gravar_infoFechamento(AINIRec: TMemIniFile; A: TinfoFechamentoD1199; const ASufixo: string);
begin

  if A.TeminfoParamFech then
    Gravar_infoParamFech(AINIRec, A.infoParamFech, ASufixo);
  if A.TemgUtilizBCN then
    Gravar_gUtilizBCN(AINIRec, A.gUtilizBCN, ASufixo);
end;

procedure TDeREFechMensalIniWriter.Gravar_infoParamFech(AINIRec: TMemIniFile; A: TinfoParamFechD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoParamFech' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.indInexistDedu then
    AINIRec.WriteString(sSecao, 'indInexistDedu', '1');
end;

procedure TDeREFechMensalIniWriter.Gravar_gUtilizBCN(AINIRec: TMemIniFile; A: TgUtilizBCND1199; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.infoBCN.Count - 1 do
    Gravar_infoBCN(AINIRec, A.infoBCN[i], ASufixo + IntToStrZero(i + 1, 3));
  for i := 0 to A.detBCNeg.Count - 1 do
    Gravar_detBCNeg(AINIRec, A.detBCNeg[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREFechMensalIniWriter.Gravar_infoBCN(AINIRec: TMemIniFile; A: TinfoBCNCollectionItemD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoBCN' + ASufixo;

  AINIRec.WriteString(sSecao, 'codBCNRaiz', A.codBCNRaiz);
  AINIRec.WriteString(sSecao, 'usarBCNAcum', IntToStr(Ord(A.usarBCNAcum)));
  if A.TemmetodoAproveit then
    AINIRec.WriteString(sSecao, 'metodoAproveit', metodoAproveitDeREToStr(A.metodoAproveit));
end;

procedure TDeREFechMensalIniWriter.Gravar_detBCNeg(AINIRec: TMemIniFile; A: TdetBCNegCollectionItemD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBCNeg' + ASufixo;

  AINIRec.WriteString(sSecao, 'codBCN', A.codBCN);
  if A.TemvUsarBCN then
    AINIRec.WriteString(sSecao, 'vUsarBCN', StringReplace(FormatFloat('0.00', A.vUsarBCN), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teFechMensal, TDeREFechMensalIniWriter);

end.
