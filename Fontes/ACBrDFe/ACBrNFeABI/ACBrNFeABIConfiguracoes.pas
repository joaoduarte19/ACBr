{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                              MXM Sistemas                                    }
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

unit ACBrNFeABIConfiguracoes;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrDFeConfiguracoes, ACBrDFe.Conversao, ACBrNFeABI.Conversao;

type

  { TGeralConfNFeABI }

  TGeralConfNFeABI = class(TGeralConf)
  private
    FVersaoDF: TVersaoNFeABI;

    procedure SetVersaoDF(const Value: TVersaoNFeABI);
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfNFeABI: TGeralConfNFeABI); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

  published
    property VersaoDF: TVersaoNFeABI read FVersaoDF write SetVersaoDF default ve100;
  end;

  { TArquivosConfNFeABI }

  TArquivosConfNFeABI = class(TArquivosConf)
  private
    FEmissaoPathNFeABI: boolean;
    FSalvarApenasNFeABIProcessados: boolean;
    FNormatizarMunicipios: Boolean;
    FPathNFeABI: String;
    FPathEvento: String;
    FPathArquivoMunicipios: String                                           ;
    FSalvarEvento: Boolean;
  public
    constructor Create(AOwner: TConfiguracoes); override;
    destructor Destroy; override;
    procedure Assign(DeArquivosConfNFeABI: TArquivosConfNFeABI); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

    function GetPathNFeABI(Data: TDateTime = 0; const CNPJ: String = ''; const IE: String = ''): String;
    function GetPathEvento(tipoEvento: TACBrTipoEvento; const CNPJ: String = ''; const IE: String = ''; Data: TDateTime = 0): String;
  published
    property EmissaoPathNFeABI: boolean read FEmissaoPathNFeABI
      write FEmissaoPathNFeABI default False;
    property SalvarEvento: Boolean read FSalvarEvento
      write FSalvarEvento default False;
    property SalvarApenasNFeABIProcessados: boolean
      read FSalvarApenasNFeABIProcessados write FSalvarApenasNFeABIProcessados default False;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios default False;
    property PathNFeABI: String read FPathNFeABI write FPathNFeABI;
    property PathEvento: String read FPathEvento write FPathEvento;
    property PathArquivoMunicipios: String read FPathArquivoMunicipios write FPathArquivoMunicipios;
  end;

  { TConfiguracoesNFeABI }

  TConfiguracoesNFeABI = class(TConfiguracoes)
  private
    function GetArquivos: TArquivosConfNFeABI;
    function GetGeral: TGeralConfNFeABI;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(DeConfiguracoesNFeABI: TConfiguracoesNFeABI); reintroduce;

  published
    property Geral: TGeralConfNFeABI read GetGeral;
    property Arquivos: TArquivosConfNFeABI read GetArquivos;
    property WebServices;
    property Certificados;
    property RespTec;
  end;

implementation

uses
  ACBrUtil.Strings, ACBrUtil.FilesIO,
  DateUtils;

{ TConfiguracoesNFeABI }

constructor TConfiguracoesNFeABI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPSessaoIni := 'NFeABI';
  WebServices.ResourceName := 'ACBrNFeABIServicos';
end;

function TConfiguracoesNFeABI.GetArquivos: TArquivosConfNFeABI;
begin
  Result := TArquivosConfNFeABI(FPArquivos);
end;

function TConfiguracoesNFeABI.GetGeral: TGeralConfNFeABI;
begin
  Result := TGeralConfNFeABI(FPGeral);
end;

procedure TConfiguracoesNFeABI.CreateGeralConf;
begin
  FPGeral := TGeralConfNFeABI.Create(Self);
end;

procedure TConfiguracoesNFeABI.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfNFeABI.Create(self);
end;

procedure TConfiguracoesNFeABI.Assign(DeConfiguracoesNFeABI: TConfiguracoesNFeABI);
begin
  Geral.Assign(DeConfiguracoesNFeABI.Geral);
  WebServices.Assign(DeConfiguracoesNFeABI.WebServices);
  Certificados.Assign(DeConfiguracoesNFeABI.Certificados);
  Arquivos.Assign(DeConfiguracoesNFeABI.Arquivos);
  RespTec.Assign(DeConfiguracoesNFeABI.RespTec);
end;

{ TGeralConfNFeABI }

procedure TGeralConfNFeABI.Assign(DeGeralConfNFeABI: TGeralConfNFeABI);
begin
  inherited Assign(DeGeralConfNFeABI);

  FVersaoDF := DeGeralConfNFeABI.VersaoDF;
end;

constructor TGeralConfNFeABI.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FVersaoDF := ve100;
end;

procedure TGeralConfNFeABI.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF));
end;

procedure TGeralConfNFeABI.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  VersaoDF := TVersaoNFeABI(AIni.ReadInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF)));
end;

procedure TGeralConfNFeABI.SetVersaoDF(const Value: TVersaoNFeABI);
begin
  FVersaoDF := Value;
end;

{ TArquivosConfNFeABI }

procedure TArquivosConfNFeABI.Assign(DeArquivosConfNFeABI: TArquivosConfNFeABI);
begin
  inherited Assign(DeArquivosConfNFeABI);

  FEmissaoPathNFeABI := DeArquivosConfNFeABI.EmissaoPathNFeABI;
  FSalvarEvento := DeArquivosConfNFeABI.SalvarEvento;
  FSalvarApenasNFeABIProcessados := DeArquivosConfNFeABI.SalvarApenasNFeABIProcessados;
  FNormatizarMunicipios := DeArquivosConfNFeABI.NormatizarMunicipios;
  FPathNFeABI := DeArquivosConfNFeABI.PathNFeABI;
  FPathEvento := DeArquivosConfNFeABI.PathEvento;
  FPathArquivoMunicipios := DeArquivosConfNFeABI.PathArquivoMunicipios;
end;

constructor TArquivosConfNFeABI.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathNFeABI := False;
  FSalvarEvento := False;
  FSalvarApenasNFeABIProcessados := False;
  FNormatizarMunicipios := False;
  FPathNFeABI := '';
  FPathEvento := '';
  FPathArquivoMunicipios := '';
end;

destructor TArquivosConfNFeABI.Destroy;
begin

  inherited;
end;

function TArquivosConfNFeABI.GetPathEvento(tipoEvento: TACBrTipoEvento;
  const CNPJ: String = ''; const IE: String = ''; Data: TDateTime = 0): String;
var
  Dir: String;
begin
  Dir := GetPath(FPathEvento, 'Evento', CNPJ, IE, Data);

  if AdicionarLiteral then
    Dir := PathWithDelim(Dir) + TpEventoToDescStr(tipoEvento);

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;

function TArquivosConfNFeABI.GetPathNFeABI(Data: TDateTime = 0; const CNPJ: String = ''; const IE: String = ''): String;
begin
  Result := GetPath(FPathNFeABI, 'NFeABI', CNPJ, IE, Data, 'NFeABI');
end;

procedure TArquivosConfNFeABI.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'SalvarApenasNFeABIProcessados', SalvarApenasNFeABIProcessados);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFeABI', EmissaoPathNFeABI);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathNFeABI', PathNFeABI);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

procedure TArquivosConfNFeABI.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  SalvarEvento := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  SalvarApenasNFeABIProcessados := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'SalvarApenasNFeABIProcessados', SalvarApenasNFeABIProcessados);
  EmissaoPathNFeABI := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFeABI', EmissaoPathNFeABI);
  NormatizarMunicipios := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  PathNFeABI := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathNFeABI', PathNFeABI);
  PathEvento := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  PathArquivoMunicipios := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

end.
