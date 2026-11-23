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

unit ACBrDeRE.D1001.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D1001.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREInfoContribIniWriter - grava o INI do evento evtInfoContrib (D-1001) }

  TDeREInfoContribIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtInfoContrib;

    procedure Gravar_infoContrib(AINIRec: TMemIniFile);
    procedure Gravar_regTribSecund(AINIRec: TMemIniFile; ALista: TregTribSecundCollectionD1001);
    procedure Gravar_tpAtividades(AINIRec: TMemIniFile; const ASecao: string;
      ALista: TtpAtividadeCollectionD1001);
    procedure Gravar_prognosticos(AINIRec: TMemIniFile; AProg: TprognosticosD1001);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREInfoContribIniWriter }

function TDeREInfoContribIniWriter.Evt: TevtInfoContrib;
begin
  Result := (DeRE as TDeRED1001).evtInfoContrib;
end;

procedure TDeREInfoContribIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEvento(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodo(AINIRec, Evt.idePeriodo);

  if Evt.infoContrib.TeminfoContrib then
    Gravar_infoContrib(AINIRec);
end;

procedure TDeREInfoContribIniWriter.Gravar_infoContrib(AINIRec: TMemIniFile);
const
  sSecao = 'infoContrib';
var
  LInfo: TinfoContribD1001;
begin
  LInfo := Evt.infoContrib;

  AINIRec.WriteString(sSecao, 'regTribPrinc', regTribDeREToStr(LInfo.regTribPrinc));
  AINIRec.WriteString(sSecao, 'indNatTrib', indNatTribDeREToStr(LInfo.indNatTrib));

  Gravar_regTribSecund(AINIRec, LInfo.regTribSecund);

  // Os grupos opcionais existem no INI somente se estiverem presentes no evento
  if LInfo.TemservFinanc then
    Gravar_tpAtividades(AINIRec, 'servFinanc', LInfo.servFinanc.tpAtividades);

  if LInfo.TemplAssistSaude then
    Gravar_tpAtividades(AINIRec, 'plAssistSaude', LInfo.plAssistSaude.tpAtividades);

  if LInfo.Temprognosticos then
    Gravar_prognosticos(AINIRec, LInfo.prognosticos);
end;

procedure TDeREInfoContribIniWriter.Gravar_regTribSecund(AINIRec: TMemIniFile;
  ALista: TregTribSecundCollectionD1001);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to ALista.Count - 1 do
  begin
    sSecao := 'regTribSecund' + IntToStrZero(i + 1, 3);

    AINIRec.WriteString(sSecao, 'regTribSecund', regTribDeREToStr(ALista[i].regTribSecund));
  end;
end;

procedure TDeREInfoContribIniWriter.Gravar_tpAtividades(AINIRec: TMemIniFile;
  const ASecao: string; ALista: TtpAtividadeCollectionD1001);
var
  i: Integer;
begin
  for i := 0 to ALista.Count - 1 do
    AINIRec.WriteString(ASecao, 'tpAtividade' + IntToStrZero(i + 1, 3), ALista[i].tpAtividade);
end;

procedure TDeREInfoContribIniWriter.Gravar_prognosticos(AINIRec: TMemIniFile;
  AProg: TprognosticosD1001);
const
  sSecao = 'prognosticos';
var
  i: Integer;
begin
  Gravar_tpAtividades(AINIRec, sSecao, AProg.tpAtividades);

  for i := 0 to AProg.UFsCredenc.Count - 1 do
    AINIRec.WriteInteger(sSecao, 'UFCredenc' + IntToStrZero(i + 1, 3), AProg.UFsCredenc[i].UFCredenc);
end;

initialization
  RegistrarIniWriterDeRE(teInfoContrib, TDeREInfoContribIniWriter);

end.
