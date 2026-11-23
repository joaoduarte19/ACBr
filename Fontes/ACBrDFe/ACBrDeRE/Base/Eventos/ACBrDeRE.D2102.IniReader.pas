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

unit ACBrDeRE.D2102.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrDeRE.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniReader;

type
  { TDeREInfoCotistasIniReader - le o INI do evento evtInfoCotistas (D-2102) }

  TDeREInfoCotistasIniReader = class(TDeREIniReader)
  private
    function Evt: TevtInfoCotistas;

    procedure Ler_infoCotistas(AINIRec: TMemIniFile; A: TinfoCotistasD2102; const ASufixo: string);
    procedure Ler_classes(AINIRec: TMemIniFile; A: TclassesD2102; const ASufixo: string);
    procedure Ler_classe(AINIRec: TMemIniFile; A: TclasseCollectionItemD2102; const ASufixo: string);
    procedure Ler_cotistas(AINIRec: TMemIniFile; A: TcotistasD2102; const ASufixo: string);
    procedure Ler_cotista(AINIRec: TMemIniFile; A: TcotistaCollectionItemD2102; const ASufixo: string);
    procedure Ler_cotas(AINIRec: TMemIniFile; A: TcotasD2102; const ASufixo: string);
    procedure Ler_cota(AINIRec: TMemIniFile; A: TcotaCollectionItemD2102; const ASufixo: string);
  protected
    procedure Ler_Evento(AINIRec: TMemIniFile); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrUtil.DateTime;

{ TDeREInfoCotistasIniReader }

function TDeREInfoCotistasIniReader.Evt: TevtInfoCotistas;
begin
  Result := (DeRE as TDeRED2102).evtInfoCotistas;
end;

procedure TDeREInfoCotistasIniReader.Ler_Evento(AINIRec: TMemIniFile);
begin
  Ler_ideEventoRecibo(AINIRec, Evt.ideEvento);
  Ler_ideContrib(AINIRec, Evt.ideContrib);
  Ler_idePeriodoApur(AINIRec, Evt.idePeriodo);

  Evt.infoCotistas.TeminfoCotistas := AINIRec.SectionExists('infoCotistas');
  if Evt.infoCotistas.TeminfoCotistas then
    Ler_infoCotistas(AINIRec, Evt.infoCotistas, '');
end;

procedure TDeREInfoCotistasIniReader.Ler_infoCotistas(AINIRec: TMemIniFile; A: TinfoCotistasD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'infoCotistas' + ASufixo;

  A.tpDeclarante := StrTotpDeclaranteDeRE(AINIRec.ReadString(sSecao, 'tpDeclarante', '1'));

  Ler_classes(AINIRec, A.classes, ASufixo);
end;

procedure TDeREInfoCotistasIniReader.Ler_classes(AINIRec: TMemIniFile; A: TclassesD2102; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('classe' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_classe(AINIRec, A.classe.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREInfoCotistasIniReader.Ler_classe(AINIRec: TMemIniFile; A: TclasseCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'classe' + ASufixo;

  A.idClasse := AINIRec.ReadString(sSecao, 'idClasse', '');
  A.quantidadeCotas := AINIRec.ReadString(sSecao, 'quantidadeCotas', '');
  A.quantidadeCotistas := AINIRec.ReadString(sSecao, 'quantidadeCotistas', '');
  A.TemplClasse := AINIRec.ValueExists(sSecao, 'plClasse');
  if A.TemplClasse then
    A.plClasse := StringToFloatDef(AINIRec.ReadString(sSecao, 'plClasse', '0'), 0);
  A.cnpjFundo := AINIRec.ReadString(sSecao, 'cnpjFundo', '');

  Ler_cotistas(AINIRec, A.cotistas, ASufixo);
end;

procedure TDeREInfoCotistasIniReader.Ler_cotistas(AINIRec: TMemIniFile; A: TcotistasD2102; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('cotista' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_cotista(AINIRec, A.cotista.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREInfoCotistasIniReader.Ler_cotista(AINIRec: TMemIniFile; A: TcotistaCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'cotista' + ASufixo;

  A.tipoPessoa := StrTotipoPessoaDeRE(AINIRec.ReadString(sSecao, 'tipoPessoa', '1'));
  A.identificacao := AINIRec.ReadString(sSecao, 'identificacao', '');
  A.classificacao := StrToclassificacaoDeRE(AINIRec.ReadString(sSecao, 'classificacao', '1'));

  Ler_cotas(AINIRec, A.cotas, ASufixo);
end;

procedure TDeREInfoCotistasIniReader.Ler_cotas(AINIRec: TMemIniFile; A: TcotasD2102; const ASufixo: string);
var
  i: Integer;
begin

  i := 1;
  while AINIRec.SectionExists('cota' + ASufixo + IntToStrZero(i, 3)) do
  begin
    Ler_cota(AINIRec, A.cota.New, ASufixo + IntToStrZero(i, 3));
    Inc(i);
  end;
end;

procedure TDeREInfoCotistasIniReader.Ler_cota(AINIRec: TMemIniFile; A: TcotaCollectionItemD2102; const ASufixo: string);
var
  sSecao: string;
begin
  sSecao := 'cota' + ASufixo;

  A.tipoCota := AINIRec.ReadString(sSecao, 'tipoCota', '');
  A.subclasse := AINIRec.ReadString(sSecao, 'subclasse', '');
  A.qtdeCotas := AINIRec.ReadString(sSecao, 'qtdeCotas', '');
  A.valorCota := AINIRec.ReadString(sSecao, 'valorCota', '');
end;

initialization
  RegistrarIniReaderDeRE(teInfoCotistas, TDeREInfoCotistasIniReader);

end.
