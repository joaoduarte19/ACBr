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

unit ACBrDeRE.D1199.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREFechMensalIniReader - le o INI do evento evtFechMensal (D-1199) }

  TDeREFechMensalIniReader = class(TDeREIniReader)
  private
    function Evt: TevtFechMensal;

    procedure Ler_infoFechamento(AINIRec: TMemIniFile; A: TinfoFechamentoD1199; const ASufixo: string);
    procedure Ler_infoParamFech(AINIRec: TMemIniFile; A: TinfoParamFechD1199; const ASufixo: string);
    procedure Ler_gUtilizBCN(AINIRec: TMemIniFile; A: TgUtilizBCND1199; const ASufixo: string);
    procedure Ler_infoBCN(AINIRec: TMemIniFile; A: TinfoBCNCollectionItemD1199; const ASufixo: string);
    procedure Ler_detBCNeg(AINIRec: TMemIniFile; A: TdetBCNegCollectionItemD1199; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREFechMensalIniReader }

function TDeREFechMensalIniReader.Evt: TevtFechMensal;
begin
  Result := (DeRE as TDeRED1199).evtFechMensal;
end;

procedure TDeREFechMensalIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEvento(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoFechamento.TeminfoFechamento := AINIRec.SectionExists('infoParamFech') or AINIRec.SectionExists('infoBCN' + '001') or AINIRec.SectionExists('detBCNeg' + '001');
  if Evt.infoFechamento.TeminfoFechamento then
    Ler_infoFechamento(AINIRec, Evt.infoFechamento, '');
end;

procedure TDeREFechMensalIniReader.Ler_infoFechamento(AINIRec: TMemIniFile; A: TinfoFechamentoD1199; const ASufixo: string);
begin

  A.TeminfoParamFech := AINIRec.SectionExists('infoParamFech' + ASufixo);
  if A.TeminfoParamFech then
    Ler_infoParamFech(AINIRec, A.infoParamFech, ASufixo);
  A.TemgUtilizBCN := AINIRec.SectionExists('infoBCN' + ASufixo + '001') or AINIRec.SectionExists('detBCNeg' + ASufixo + '001');
  if A.TemgUtilizBCN then
    Ler_gUtilizBCN(AINIRec, A.gUtilizBCN, ASufixo);
end;

procedure TDeREFechMensalIniReader.Ler_infoParamFech(AINIRec: TMemIniFile; A: TinfoParamFechD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoParamFech' + ASufixo;

  A.indInexistDedu := (AINIRec.ReadString(sSecao, 'indInexistDedu', '') = '1');
end;

procedure TDeREFechMensalIniReader.Ler_gUtilizBCN(AINIRec: TMemIniFile; A: TgUtilizBCND1199; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('infoBCN' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_infoBCN(AINIRec, A.infoBCN.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
  i := 1;
  while AINIRec.SectionExists('detBCNeg' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_detBCNeg(AINIRec, A.detBCNeg.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREFechMensalIniReader.Ler_infoBCN(AINIRec: TMemIniFile; A: TinfoBCNCollectionItemD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoBCN' + ASufixo;

  A.codBCNRaiz := AINIRec.ReadString(sSecao, 'codBCNRaiz', '');
  A.usarBCNAcum := (AINIRec.ReadString(sSecao, 'usarBCNAcum', '0') = '1');
  A.TemmetodoAproveit := AINIRec.ValueExists(sSecao, 'metodoAproveit');
  if A.TemmetodoAproveit then
    A.metodoAproveit := StrTometodoAproveitDeRE(AINIRec.ReadString(sSecao, 'metodoAproveit', '0'));
end;

procedure TDeREFechMensalIniReader.Ler_detBCNeg(AINIRec: TMemIniFile; A: TdetBCNegCollectionItemD1199; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detBCNeg' + ASufixo;

  A.codBCN := AINIRec.ReadString(sSecao, 'codBCN', '');
  A.TemvUsarBCN := AINIRec.ValueExists(sSecao, 'vUsarBCN');
  if A.TemvUsarBCN then
    A.vUsarBCN := StringToFloatDef(AINIRec.ReadString(sSecao, 'vUsarBCN', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teFechMensal, TDeREFechMensalIniReader);

end.
