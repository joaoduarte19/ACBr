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

unit ACBrDeRE.D2101.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREDebOpOfPublicIniWriter - grava o INI do evento evtDebOpOfPublic (D-2101) }

  TDeREDebOpOfPublicIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtDebOpOfPublic;

    procedure Gravar_infoDebOpOfPublic(AINIRec: TMemIniFile; A: TinfoDebOpOfPublicD2101; const ASufixo: string);
    procedure Gravar_infoTitulos(AINIRec: TMemIniFile; A: TinfoTitulosD2101; const ASufixo: string);
    procedure Gravar_detTitulo(AINIRec: TMemIniFile; A: TdetTituloCollectionItemD2101; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREDebOpOfPublicIniWriter }

function TDeREDebOpOfPublicIniWriter.Evt: TevtDebOpOfPublic;
begin
  Result := (DeRE as TDeRED2101).evtDebOpOfPublic;
end;

procedure TDeREDebOpOfPublicIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic then
    Gravar_infoDebOpOfPublic(AINIRec, Evt.infoDebOpOfPublic, '');
end;

procedure TDeREDebOpOfPublicIniWriter.Gravar_infoDebOpOfPublic(AINIRec: TMemIniFile; A: TinfoDebOpOfPublicD2101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoDebOpOfPublic' + ASufixo;

  // Marcador: garante a existencia da secao quando todos os campos sao opcionais
  AINIRec.WriteString(sSecao, 'Informado', '1');

  if A.semTitulos then
    AINIRec.WriteString(sSecao, 'semTitulos', '1');

  if A.TeminfoTitulos then
    Gravar_infoTitulos(AINIRec, A.infoTitulos, ASufixo);
end;

procedure TDeREDebOpOfPublicIniWriter.Gravar_infoTitulos(AINIRec: TMemIniFile; A: TinfoTitulosD2101; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.detTitulo.Count - 1 do
    Gravar_detTitulo(AINIRec, A.detTitulo[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREDebOpOfPublicIniWriter.Gravar_detTitulo(AINIRec: TMemIniFile; A: TdetTituloCollectionItemD2101; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'detTitulo' + ASufixo;

  AINIRec.WriteString(sSecao, 'idTitulo', A.idTitulo);
  AINIRec.WriteString(sSecao, 'cCta', A.cCta);
  if A.TemdescFundo then
    AINIRec.WriteString(sSecao, 'descFundo', A.descFundo);
  AINIRec.WriteString(sSecao, 'CNPJDevedor', A.CNPJDevedor);
  AINIRec.WriteString(sSecao, 'vSaldoContIni', StringReplace(FormatFloat('0.00', A.vSaldoContIni), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vEntradas', StringReplace(FormatFloat('0.00', A.vEntradas), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vSaidas', StringReplace(FormatFloat('0.00', A.vSaidas), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vJurosRec', StringReplace(FormatFloat('0.00', A.vJurosRec), ',', '.', []));
  if A.TemvVarMensal then
    AINIRec.WriteString(sSecao, 'vVarMensal', StringReplace(FormatFloat('0.00', A.vVarMensal), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vSaldoContFin', StringReplace(FormatFloat('0.00', A.vSaldoContFin), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vSelic', StringReplace(FormatFloat('0.00', A.vSelic), ',', '.', []));
  if A.TemvPisCofins then
    AINIRec.WriteString(sSecao, 'vPisCofins', StringReplace(FormatFloat('0.00', A.vPisCofins), ',', '.', []));
  AINIRec.WriteString(sSecao, 'vApur', StringReplace(FormatFloat('0.00', A.vApur), ',', '.', []));
end;

initialization
  RegistrarIniWriterDeRE(teDebOpOfPublic, TDeREDebOpOfPublicIniWriter);

end.
