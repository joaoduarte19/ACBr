{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimen-}
{ to de Transporte eletrônico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Desenvolvimento                                                              }
{         de Cte: Wiliam Zacarias da Silva Rosa                                }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeConfiguracoes;

interface

uses
  Classes, Sysutils, ACBrDFeConfiguracoes, pcnConversao, pcnConversaoCTe;

type

  { TGeralConfCTe }

  TGeralConfCTe = class(TGeralConf)
  private
    FVersaoDF: TpcnVersaoDF;

    procedure SetVersaoDF(const Value: TpcnVersaoDF);
  public
    constructor Create(AOwner: TConfiguracoes); override;
  published
    property VersaoDF: TpcnVersaoDF read FVersaoDF write SetVersaoDF default ve200;
  end;

  { TArquivosConfCTe }

  TArquivosConfCTe = class(TArquivosConf)
  private
    FEmissaoPathCTe: Boolean;
    FSalvarEvento: Boolean;
    FSalvarApenasCTeProcessados: Boolean;
    FPathCTe: String;
    FPathInu: String;
    FPathEvento: String;
  public
    constructor Create(AOwner: TConfiguracoes); override;

    function GetPathCTe(Data: TDateTime = 0; CNPJ : String = ''): String;
    function GetPathInu(Data: TDateTime = 0; CNPJ : String = ''): String;
    function GetPathEvento(tipoEvento: TpcnTpEvento; Data: TDateTime = 0; CNPJ : String = ''): String;
  published
    property EmissaoPathCTe: Boolean     read FEmissaoPathCte write FEmissaoPathCTe default False;
    property SalvarEvento: Boolean       read FSalvarEvento   write FSalvarEvento   default False;
    property SalvarApenasCTeProcessados: Boolean read FSalvarApenasCTeProcessados write FSalvarApenasCTeProcessados default False;
    property PathCTe: String             read FPathCTe        write FPathCTe;
    property PathInu: String             read FPathInu        write FPathInu;
    property PathEvento: String          read FPathEvento     write FPathEvento;
  end;

  { TConfiguracoesCTe }

  TConfiguracoesCTe = class(TConfiguracoes)
  private
    function GetGeral: TGeralConfCTe;
    function GetArquivos: TArquivosConfCTe;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Geral: TGeralConfCTe            read GetGeral;
    property Arquivos: TArquivosConfCTe      read GetArquivos;
    property WebServices;
    property Certificados;
  end;

implementation

uses
  ACBrUtil, DateUtils;

{ TConfiguracoesCTe }

constructor TConfiguracoesCTe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TConfiguracoesCTe.GetGeral: TGeralConfCTe;
begin
  Result := TGeralConfCTe(FPGeral);
end;

function TConfiguracoesCTe.GetArquivos: TArquivosConfCTe;
begin
  Result := TArquivosConfCTe(FPArquivos);
end;

procedure TConfiguracoesCTe.CreateGeralConf;
begin
  FPGeral := TGeralConfCTe.Create(Self);
end;

procedure TConfiguracoesCTe.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfCTe.Create(Self);
end;

{ TGeralConfCTe }

constructor TGeralConfCTe.Create(AOwner: TConfiguracoes);
begin
  Inherited Create(AOwner);

  FVersaoDF := ve200;
end;

procedure TGeralConfCTe.SetVersaoDF(const Value: TpcnVersaoDF);
begin
  FVersaoDF := Value;
end;

{ TArquivosConfCTe }

constructor TArquivosConfCTe.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathCTe := False;
  FSalvarEvento := False;
  FSalvarApenasCTeProcessados := False;
  FPathCTe := '';
  FPathInu := '';
  FPathEvento := '';
end;

function TArquivosConf.GetPathCTe(Data: TDateTime = 0; CNPJ : String = ''): String;
//var
//  wDia, wMes, wAno: Word;
//  Dir: String;
begin
  Result := GetPath(FPathCTe, 'CTe');
(*
  if EstaVazio(FPathCTe) then
     Dir := TConfiguracoes(Self.Owner).Geral.PathSalvar
  else
     Dir := FPathCTe;

  if FSepararCNPJ then
     Dir := PathWithDelim(Dir) + TConfiguracoes(Self.Owner).Certificados.CNPJ;

  if FMensal then
   begin
     if Data = 0 then
        Data := Now;
     DecodeDate(Data, wAno, wMes, wDia);
     if Pos(IntToStr(wAno) + IntToStrZero(wMes, 2), Dir) <= 0 then
        Dir := PathWithDelim(Dir) + IntToStr(wAno) + IntToStrZero(wMes, 2);
   end;

  if FLiteral then
   begin
     if copy(Dir, length(Dir)-2, 3) <> 'CTe' then
        Dir := PathWithDelim(Dir) + 'CTe';
   end;

  if not DirectoryExists(Dir) then
     ForceDirectories(Dir);

  Result := Dir;
*)
end;

function TArquivosConf.GetPathInu(Data: TDateTime = 0; CNPJ : String = ''): String;
//var
//  wDia, wMes, wAno: Word;
//  Dir: String;
begin
  Result := GetPath(FPathInu, 'Inu');
(*
  if EstaVazio(FPathInu) then
     Dir := TConfiguracoes(Self.Owner).Geral.PathSalvar
  else
     Dir := FPathInu;

  if FSepararCNPJ then
     Dir := PathWithDelim(Dir) + TConfiguracoes(Self.Owner).Certificados.CNPJ;

  if FMensal then
   begin
     if Data = 0 then
        Data := Now;
     DecodeDate(Data, wAno, wMes, wDia);
     if Pos(IntToStr(wAno) + IntToStrZero(wMes, 2), Dir) <= 0 then
        Dir := PathWithDelim(Dir) + IntToStr(wAno) + IntToStrZero(wMes, 2);
   end;

  if FLiteral then
   begin
     if copy(Dir, length(Dir)-2, 3) <> 'Inu' then
        Dir := PathWithDelim(Dir) + 'Inu';
   end;

  if not DirectoryExists(Dir) then
     ForceDirectories(Dir);

  Result := Dir;
*)
end;

function TArquivosConf.GetPathEvento(tipoEvento: TpcnTpEvento; Data: TDateTime = 0; CNPJ : String = ''): String;
var
//  wDia, wMes, wAno: Word;
  Dir, Evento: String;
begin
  Dir := GetPath(FPathEvento, 'Evento');

  if AdicionarLiteral then
  begin
    case tipoEvento of
      teCCe:          Evento := 'CCe';
      teCancelamento: Evento := 'Cancelamento';
      teEPEC:         Evento := 'EPEC';
      teMultimodal:   Evento := 'Multimodal';
    end;
  end;

  Dir := PathWithDelim(Dir) + 'Evento';

  if not DirectoryExists(Dir) then
     ForceDirectories(Dir);

  Result := Dir;

(*
  if EstaVazio(FPathEvento) then
     Dir := TConfiguracoes(Self.Owner).Geral.PathSalvar
  else
     Dir := FPathEvento;

  if FSepararCNPJ then
     Dir := PathWithDelim(Dir) + TConfiguracoes(Self.Owner).Certificados.CNPJ;

  if FMensal then
   begin
     if Data = 0 then
        Data := Now;
     DecodeDate(Data, wAno, wMes, wDia);
     if Pos(IntToStr(wAno) + IntToStrZero(wMes, 2), Dir) <= 0 then
        Dir := PathWithDelim(Dir) + IntToStr(wAno) + IntToStrZero(wMes, 2);
   end;

  if FLiteral then
   begin
     if copy(Dir, length(Dir) - 2, 3) <> 'Evento' then
        Dir := PathWithDelim(Dir) + 'Evento';
   end;

  case tipoEvento of
    teCCe                      : Dir := PathWithDelim(Dir)+'CCe';
    teCancelamento             : Dir := PathWithDelim(Dir)+'Cancelamento';
    teEPEC                     : Dir := PathWithDelim(Dir)+'EPEC';
    teManifDestConfirmacao     : Dir := PathWithDelim(Dir)+'Confirmacao';
    teManifDestCiencia         : Dir := PathWithDelim(Dir)+'Ciencia';
    teManifDestDesconhecimento : Dir := PathWithDelim(Dir)+'Desconhecimento';
    teManifDestOperNaoRealizada: Dir := PathWithDelim(Dir)+'NaoRealizada';
    teMultimodal               : Dir := PathWithDelim(Dir)+'Multimodal';
  end;

  if not DirectoryExists(Dir) then
     ForceDirectories(Dir);

  Result := Dir;
*)
end;

end.
