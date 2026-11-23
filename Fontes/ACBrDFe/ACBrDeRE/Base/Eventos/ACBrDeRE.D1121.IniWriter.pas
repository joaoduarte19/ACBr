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

unit ACBrDeRE.D1121.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1121.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeRERelDeducoesIniWriter - grava o INI do evento evtRelDeducoes (D-1121) }

  TDeRERelDeducoesIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtRelDeducoes;

    procedure Gravar_infoDeducoes(AINIRec: TMemIniFile; A: TinfoDeducoesD1121; const ASufixo: string);
    procedure Gravar_infoDeducao(AINIRec: TMemIniFile; A: TinfoDeducaoCollectionItemD1121; const ASufixo: string);
    procedure Gravar_infoDFe(AINIRec: TMemIniFile; A: TinfoDFeD1121; const ASufixo: string);
    procedure Gravar_infoImovel(AINIRec: TMemIniFile; A: TinfoImovelD1121; const ASufixo: string);
    procedure Gravar_detDeducao(AINIRec: TMemIniFile; A: TdetDeducaoD1121; const ASufixo: string);
    procedure Gravar_desdobDeducao(AINIRec: TMemIniFile; A: TdesdobDeducaoCollectionItemD1121; const ASufixo: string);
    procedure Gravar_itemDFe(AINIRec: TMemIniFile; A: TitemDFeCollectionItemD1121; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeRERelDeducoesIniWriter }

function TDeRERelDeducoesIniWriter.Evt: TevtRelDeducoes;
begin
  Result := (DeRE as TDeRED1121).evtRelDeducoes;
end;

procedure TDeRERelDeducoesIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoDeducoes.TeminfoDeducoes then
    Gravar_infoDeducoes(AINIRec, Evt.infoDeducoes, '');
end;

procedure TDeRERelDeducoesIniWriter.Gravar_infoDeducoes(AINIRec: TMemIniFile; A: TinfoDeducoesD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'infoDeducoes' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.TemfinEvt then
    AINIRec.WriteString(sSecao, 'finEvt', finEvtDeREToStr(A.finEvt));

  for i := 0 to A.infoDeducao.Count - 1 do
    Gravar_infoDeducao(AINIRec, A.infoDeducao[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeRERelDeducoesIniWriter.Gravar_infoDeducao(AINIRec: TMemIniFile; A: TinfoDeducaoCollectionItemD1121; const ASufixo: string);
begin

  if A.TeminfoDFe then
    Gravar_infoDFe(AINIRec, A.infoDFe, ASufixo);
  if A.TeminfoImovel then
    Gravar_infoImovel(AINIRec, A.infoImovel, ASufixo);
  if A.TemdetDeducao then
    Gravar_detDeducao(AINIRec, A.detDeducao, ASufixo);
end;

procedure TDeRERelDeducoesIniWriter.Gravar_infoDFe(AINIRec: TMemIniFile; A: TinfoDFeD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoDFe' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.chDFe <> '' then
    AINIRec.WriteString(sSecao, 'chDFe', A.chDFe);
  if A.chDFeRetif <> '' then
    AINIRec.WriteString(sSecao, 'chDFeRetif', A.chDFeRetif);
  if A.TemtpDFe then
    AINIRec.WriteString(sSecao, 'tpDFe', tpDFeDeREToStr(A.tpDFe));
  if A.TemdtEmi then
    AINIRec.WriteString(sSecao, 'dtEmi', DateToStr(A.dtEmi));
end;

procedure TDeRERelDeducoesIniWriter.Gravar_infoImovel(AINIRec: TMemIniFile; A: TinfoImovelD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoImovel' + ASufixo;

  AINIRec.WriteString(sSecao, 'CPFAlien', A.CPFAlien);
end;

procedure TDeRERelDeducoesIniWriter.Gravar_detDeducao(AINIRec: TMemIniFile; A: TdetDeducaoD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'detDeducao' + ASufixo;

  AINIRec.WriteString(sSecao, 'vOper', StringReplace(FormatFloat('0.00', A.vOper), ',', '.', []));

  for i := 0 to A.desdobDeducoes.Count - 1 do
    Gravar_desdobDeducao(AINIRec, A.desdobDeducoes[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeRERelDeducoesIniWriter.Gravar_desdobDeducao(AINIRec: TMemIniFile; A: TdesdobDeducaoCollectionItemD1121; const ASufixo: string);
var
  sSecao: string;
  i: Integer;
begin
  sSecao := 'desdobDeducao' + ASufixo;

  AINIRec.WriteString(sSecao, 'tpAtiv', tpAtivDedDeREToStr(A.tpAtiv));
  AINIRec.WriteString(sSecao, 'cCta', A.cCta);
  if A.TemvDedTotal then
    AINIRec.WriteString(sSecao, 'vDedTotal', StringReplace(FormatFloat('0.00', A.vDedTotal), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vDed', StringReplace(FormatFloat('0.00', A.vDed), ',', '.', []));

  for i := 0 to A.itemsDFe.Count - 1 do
    Gravar_itemDFe(AINIRec, A.itemsDFe[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeRERelDeducoesIniWriter.Gravar_itemDFe(AINIRec: TMemIniFile; A: TitemDFeCollectionItemD1121; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'itemDFe' + ASufixo;

  AINIRec.WriteString(sSecao, 'nItem', A.nItem);
  AINIRec.WriteString(sSecao, 'vItem', StringReplace(FormatFloat('0.00', A.vItem), ',', '.', []));
  if A.TemvItemDedTotal then
    AINIRec.WriteString(sSecao, 'vItemDedTotal', StringReplace(FormatFloat('0.00', A.vItemDedTotal), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vItemDed', StringReplace(FormatFloat('0.00', A.vItemDed), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teRelDeducoes, TDeRERelDeducoesIniWriter);

end.
