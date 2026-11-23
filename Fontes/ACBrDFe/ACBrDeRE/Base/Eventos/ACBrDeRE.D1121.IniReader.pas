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

unit ACBrDeRE.D1121.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1121.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeRERelDeducoesIniReader - le o INI do evento evtRelDeducoes (D-1121) }

  TDeRERelDeducoesIniReader = class(TDeREIniReader)
  private
    function Evt: TevtRelDeducoes;

    procedure Ler_infoDeducoes(AINIRec: TMemIniFile; A: TinfoDeducoesD1121; const ASufixo: string);
    procedure Ler_infoDeducao(AINIRec: TMemIniFile; A: TinfoDeducaoCollectionItemD1121; const ASufixo: string);
    procedure Ler_infoDFe(AINIRec: TMemIniFile; A: TinfoDFeD1121; const ASufixo: string);
    procedure Ler_infoImovel(AINIRec: TMemIniFile; A: TinfoImovelD1121; const ASufixo: string);
    procedure Ler_detDeducao(AINIRec: TMemIniFile; A: TdetDeducaoD1121; const ASufixo: string);
    procedure Ler_desdobDeducao(AINIRec: TMemIniFile; A: TdesdobDeducaoCollectionItemD1121; const ASufixo: string);
    procedure Ler_itemDFe(AINIRec: TMemIniFile; A: TitemDFeCollectionItemD1121; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeRERelDeducoesIniReader }

function TDeRERelDeducoesIniReader.Evt: TevtRelDeducoes;
begin
  Result := (DeRE as TDeRED1121).evtRelDeducoes;
end;

procedure TDeRERelDeducoesIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoDeducoes.TeminfoDeducoes := AINIRec.SectionExists('infoDeducoes');
  if Evt.infoDeducoes.TeminfoDeducoes then
    Ler_infoDeducoes(AINIRec, Evt.infoDeducoes, '');
end;

procedure TDeRERelDeducoesIniReader.Ler_infoDeducoes(AINIRec: TMemIniFile; A: TinfoDeducoesD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoDeducoes' + ASufixo;

  A.TemfinEvt := AINIRec.ValueExists(sSecao, 'finEvt');
  if A.TemfinEvt then
    A.finEvt := StrTofinEvtDeRE(AINIRec.ReadString(sSecao, 'finEvt', '1'));

  i := 1;
  while AINIRec.SectionExists('infoDFe' + ASufixo + IntToStrZero(i, 3)) or AINIRec.SectionExists('infoImovel' + ASufixo + IntToStrZero(i, 3)) or AINIRec.SectionExists('detDeducao' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_infoDeducao(AINIRec, A.infoDeducao.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeRERelDeducoesIniReader.Ler_infoDeducao(AINIRec: TMemIniFile; A: TinfoDeducaoCollectionItemD1121; const ASufixo: string);
begin

  A.TeminfoDFe := AINIRec.SectionExists('infoDFe' + ASufixo);
  if A.TeminfoDFe then
    Ler_infoDFe(AINIRec, A.infoDFe, ASufixo);
  A.TeminfoImovel := AINIRec.SectionExists('infoImovel' + ASufixo);
  if A.TeminfoImovel then
    Ler_infoImovel(AINIRec, A.infoImovel, ASufixo);
  A.TemdetDeducao := AINIRec.SectionExists('detDeducao' + ASufixo);
  if A.TemdetDeducao then
    Ler_detDeducao(AINIRec, A.detDeducao, ASufixo);
end;

procedure TDeRERelDeducoesIniReader.Ler_infoDFe(AINIRec: TMemIniFile; A: TinfoDFeD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoDFe' + ASufixo;

  A.chDFe := AINIRec.ReadString(sSecao, 'chDFe', '');
  A.chDFeRetif := AINIRec.ReadString(sSecao, 'chDFeRetif', '');
  A.TemtpDFe := AINIRec.ValueExists(sSecao, 'tpDFe');
  if A.TemtpDFe then
    A.tpDFe := StrTotpDFeDeRE(AINIRec.ReadString(sSecao, 'tpDFe', '01'));
  A.TemdtEmi := AINIRec.ValueExists(sSecao, 'dtEmi');
  if A.TemdtEmi then
    A.dtEmi := StringToDateTime(AINIRec.ReadString(sSecao, 'dtEmi', '0'));
end;

procedure TDeRERelDeducoesIniReader.Ler_infoImovel(AINIRec: TMemIniFile; A: TinfoImovelD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoImovel' + ASufixo;

  A.CPFAlien := AINIRec.ReadString(sSecao, 'CPFAlien', '');
end;

procedure TDeRERelDeducoesIniReader.Ler_detDeducao(AINIRec: TMemIniFile; A: TdetDeducaoD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'detDeducao' + ASufixo;

  A.vOper := StringToFloatDef(AINIRec.ReadString(sSecao, 'vOper', '0'), 0);

  i := 1;
  while AINIRec.SectionExists('desdobDeducao' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_desdobDeducao(AINIRec, A.desdobDeducoes.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeRERelDeducoesIniReader.Ler_desdobDeducao(AINIRec: TMemIniFile; A: TdesdobDeducaoCollectionItemD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'desdobDeducao' + ASufixo;

  A.tpAtiv := StrTotpAtivDedDeRE(AINIRec.ReadString(sSecao, 'tpAtiv', ''));
  A.cCta := AINIRec.ReadString(sSecao, 'cCta', '');
  A.TemvDedTotal := AINIRec.ValueExists(sSecao, 'vDedTotal');
  if A.TemvDedTotal then
    A.vDedTotal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDedTotal', '0'), 0);
  A.vDed := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDed', '0'), 0);

  i := 1;
  while AINIRec.SectionExists('itemDFe' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_itemDFe(AINIRec, A.itemsDFe.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeRERelDeducoesIniReader.Ler_itemDFe(AINIRec: TMemIniFile; A: TitemDFeCollectionItemD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'itemDFe' + ASufixo;

  A.nItem := AINIRec.ReadString(sSecao, 'nItem', '');
  A.vItem := StringToFloatDef(AINIRec.ReadString(sSecao, 'vItem', '0'), 0);
  A.TemvItemDedTotal := AINIRec.ValueExists(sSecao, 'vItemDedTotal');
  if A.TemvItemDedTotal then
    A.vItemDedTotal := StringToFloatDef(AINIRec.ReadString(sSecao, 'vItemDedTotal', '0'), 0);
  A.vItemDed := StringToFloatDef(AINIRec.ReadString(sSecao, 'vItemDed', '0'), 0);
end;

initialization
  RegistrarIniReaderDeRE(teRelDeducoes, TDeRERelDeducoesIniReader);

end.
