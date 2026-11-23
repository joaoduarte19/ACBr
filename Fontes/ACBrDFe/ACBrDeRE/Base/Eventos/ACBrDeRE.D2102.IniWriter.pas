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

unit ACBrDeRE.D2102.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREInfoCotistasIniWriter - grava o INI do evento evtInfoCotistas (D-2102) }

  TDeREInfoCotistasIniWriter = class(TDeREIniWriter)
  private
    function Evt: TevtInfoCotistas;

    procedure Gravar_infoCotistas(AINIRec: TMemIniFile; A: TinfoCotistasD2102; const ASufixo: string);
    procedure Gravar_classes(AINIRec: TMemIniFile; A: TclassesD2102; const ASufixo: string);
    procedure Gravar_classe(AINIRec: TMemIniFile; A: TclasseCollectionItemD2102; const ASufixo: string);
    procedure Gravar_cotistas(AINIRec: TMemIniFile; A: TcotistasD2102; const ASufixo: string);
    procedure Gravar_cotista(AINIRec: TMemIniFile; A: TcotistaCollectionItemD2102; const ASufixo: string);
    procedure Gravar_cotas(AINIRec: TMemIniFile; A: TcotasD2102; const ASufixo: string);
    procedure Gravar_cota(AINIRec: TMemIniFile; A: TcotaCollectionItemD2102; const ASufixo: string);
  protected
    procedure Gravar_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREInfoCotistasIniWriter }

function TDeREInfoCotistasIniWriter.Evt: TevtInfoCotistas;
begin
  Result := (DeRE as TDeRED2102).evtInfoCotistas;
end;

procedure TDeREInfoCotistasIniWriter.Gravar_Evento(AINIRec: TMemIniFile);
begin
  Gravar_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Gravar_ideContrib(AINIRec, Evt.ideContrib);
  Gravar_idePeriodoApur(AINIRec, Evt.idePeriodo);

  if Evt.infoCotistas.TeminfoCotistas then
    Gravar_infoCotistas(AINIRec, Evt.infoCotistas, '');
end;

procedure TDeREInfoCotistasIniWriter.Gravar_infoCotistas(AINIRec: TMemIniFile; A: TinfoCotistasD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoCotistas' + ASufixo;

  AINIRec.WriteString(sSecao, 'tpDeclarante', tpDeclaranteDeREToStr(A.tpDeclarante));

  Gravar_classes(AINIRec, A.classes, ASufixo);
end;

procedure TDeREInfoCotistasIniWriter.Gravar_classes(AINIRec: TMemIniFile; A: TclassesD2102; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.classe.Count - 1 do
    Gravar_classe(AINIRec, A.classe[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREInfoCotistasIniWriter.Gravar_classe(AINIRec: TMemIniFile; A: TclasseCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'classe' + ASufixo;

  AINIRec.WriteString(sSecao, 'idClasse', A.idClasse);
  AINIRec.WriteString(sSecao, 'quantidadeCotas', A.quantidadeCotas);
  AINIRec.WriteString(sSecao, 'quantidadeCotistas', A.quantidadeCotistas);
  if A.TemplClasse then
    AINIRec.WriteString(sSecao, 'plClasse', StringReplace(FormatFloat('0.00', A.plClasse), ',', '.', []));
  AINIRec.WriteString(sSecao, 'cnpjFundo', A.cnpjFundo);

  Gravar_cotistas(AINIRec, A.cotistas, ASufixo);
end;

procedure TDeREInfoCotistasIniWriter.Gravar_cotistas(AINIRec: TMemIniFile; A: TcotistasD2102; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.cotista.Count - 1 do
    Gravar_cotista(AINIRec, A.cotista[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREInfoCotistasIniWriter.Gravar_cotista(AINIRec: TMemIniFile; A: TcotistaCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'cotista' + ASufixo;

  AINIRec.WriteString(sSecao, 'tipoPessoa', tipoPessoaDeREToStr(A.tipoPessoa));
  AINIRec.WriteString(sSecao, 'identificacao', A.identificacao);
  AINIRec.WriteString(sSecao, 'classificacao', classificacaoDeREToStr(A.classificacao));

  Gravar_cotas(AINIRec, A.cotas, ASufixo);
end;

procedure TDeREInfoCotistasIniWriter.Gravar_cotas(AINIRec: TMemIniFile; A: TcotasD2102; const ASufixo: string);
var
  i: Integer;
begin

  for i := 0 to A.cota.Count - 1 do
    Gravar_cota(AINIRec, A.cota[i], ASufixo + IntToStrZero(i + 1, 3));
end;

procedure TDeREInfoCotistasIniWriter.Gravar_cota(AINIRec: TMemIniFile; A: TcotaCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'cota' + ASufixo;

  AINIRec.WriteString(sSecao, 'tipoCota', A.tipoCota);
  AINIRec.WriteString(sSecao, 'subclasse', A.subclasse);
  AINIRec.WriteString(sSecao, 'qtdeCotas', A.qtdeCotas);
  AINIRec.WriteString(sSecao, 'valorCota', A.valorCota);
end;

initialization
  RegistrarIniWriterDeRE(teInfoCotistas, TDeREInfoCotistasIniWriter);

end.
