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

unit ACBrDeRE.D1001.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1001.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREInfoContribIniReader - le o INI do evento evtInfoContrib (D-1001) }

  TDeREInfoContribIniReader = class(TDeREIniReader)
  private
    function Evt: TevtInfoContrib;

    procedure Ler_infoContrib(AINIRec: TMemIniFile);
    procedure Ler_regTribSecund(AINIRec: TMemIniFile; ALista: TregTribSecundCollectionD1001);
    procedure Ler_tpAtividades(AINIRec: TMemIniFile; const ASecao: string;
      ALista: TtpAtividadeCollectionD1001);
    procedure Ler_prognosticos(AINIRec: TMemIniFile; AProg: TprognosticosD1001);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREInfoContribIniReader }

function TDeREInfoContribIniReader.Evt: TevtInfoContrib;
begin
  Result := (DeRE as TDeRED1001).evtInfoContrib;
end;

procedure TDeREInfoContribIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEvento(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodo(AINIRec, Evt.idePeriodo);

  Evt.infoContrib.TeminfoContrib := AINIRec.SectionExists('infoContrib');
  if Evt.infoContrib.TeminfoContrib then
    Ler_infoContrib(AINIRec);
end;

procedure TDeREInfoContribIniReader.Ler_infoContrib(AINIRec: TMemIniFile);
const
  sSecao = 'infoContrib';
var
  LInfo: TinfoContribD1001;
begin
  LInfo := Evt.infoContrib;

  LInfo.regTribPrinc := StrToregTribDeRE(AINIRec.ReadString(sSecao, 'regTribPrinc', ''));
  LInfo.indNatTrib := StrToindNatTribDeRE(AINIRec.ReadString(sSecao, 'indNatTrib', ''));

  Ler_regTribSecund(AINIRec, LInfo.regTribSecund);

  // Os grupos opcionais estao presentes no evento se a secao existir no INI
  LInfo.TemservFinanc := AINIRec.SectionExists('servFinanc');
  if LInfo.TemservFinanc then
    Ler_tpAtividades(AINIRec, 'servFinanc', LInfo.servFinanc.tpAtividades);

  LInfo.TemplAssistSaude := AINIRec.SectionExists('plAssistSaude');
  if LInfo.TemplAssistSaude then
    Ler_tpAtividades(AINIRec, 'plAssistSaude', LInfo.plAssistSaude.tpAtividades);

  LInfo.Temprognosticos := AINIRec.SectionExists('prognosticos');
  if LInfo.Temprognosticos then
    Ler_prognosticos(AINIRec, LInfo.prognosticos);
end;

procedure TDeREInfoContribIniReader.Ler_regTribSecund(AINIRec: TMemIniFile;
  ALista: TregTribSecundCollectionD1001);
var
  i: Integer;
  sSecao, sFim: string;
begin
  ALista.Clear;

  i := 1;
  while True do
  begin
    sSecao := 'regTribSecund' + IntToStrZero(i, 3);
    sFim := AINIRec.ReadString(sSecao, 'regTribSecund', '');
    if sFim = '' then
      Break;

    ALista.New.regTribSecund := StrToregTribDeRE(sFim);
    Inc(i);
  end;
end;

procedure TDeREInfoContribIniReader.Ler_tpAtividades(AINIRec: TMemIniFile;
  const ASecao: string; ALista: TtpAtividadeCollectionD1001);
var
  i: Integer;
  sAtiv: string;
begin
  ALista.Clear;

  i := 1;
  while True do
  begin
    sAtiv := AINIRec.ReadString(ASecao, 'tpAtividade' + IntToStrZero(i, 3), '');
    if sAtiv = '' then
      Break;

    ALista.New.tpAtividade := sAtiv;
    Inc(i);
  end;
end;

procedure TDeREInfoContribIniReader.Ler_prognosticos(AINIRec: TMemIniFile;
  AProg: TprognosticosD1001);
const
  sSecao = 'prognosticos';
var
  i, LUF: Integer;
begin
  Ler_tpAtividades(AINIRec, sSecao, AProg.tpAtividades);

  AProg.UFsCredenc.Clear;

  i := 1;
  while True do
  begin
    LUF := AINIRec.ReadInteger(sSecao, 'UFCredenc' + IntToStrZero(i, 3), 0);
    if LUF = 0 then
      Break;

    AProg.UFsCredenc.New.UFCredenc := LUF;
    Inc(i);
  end;
end;

initialization
  RegistrarIniReaderDeRE(teInfoContrib, TDeREInfoContribIniReader);

end.
