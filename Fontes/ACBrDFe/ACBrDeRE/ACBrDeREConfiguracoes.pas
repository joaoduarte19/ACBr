{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDeREConfiguracoes;

interface

uses
  Classes, SysUtils, IniFiles, DateUtils,
  ACBrDFeConfiguracoes,
  ACBrDeRE.Conversao;

type
  { TGeralConfDeRE }
  TGeralConfDeRE = class(TGeralConf)
  private
    FVersaoDF: TVersaoDeRE;
    FIdContribuinte: string;
    FClientId: string;
    FClientSecret: string;
    FToken: string;
    FTokenExpira: TDateTime;

    procedure SetVersaoDF(const Value: TVersaoDeRE);
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfDeRE: TGeralConfDeRE); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;
  published
    property VersaoDF: TVersaoDeRE read FVersaoDF write SetVersaoDF default ve104;
    property IdContribuinte: string read FIdContribuinte write FIdContribuinte;
    property ClientId: string read FClientId write FClientId;
    property ClientSecret: string read FClientSecret write FClientSecret;
    // Token de acesso (OAuth2). Preenchido por TACBrDeRE.ObterToken ou manualmente;
    // os metodos de envio/consulta usam somente o que estiver nestas propriedades.
    property Token: string read FToken write FToken;
    property TokenExpira: TDateTime read FTokenExpira write FTokenExpira;
  end;

  { TArquivosConfDeRE }
  TArquivosConfDeRE = class(TArquivosConf)
  private
    FEmissaoPathDeRE: Boolean;
    FPathDeRE: string;
  public
    constructor Create(AOwner: TConfiguracoes); override;

    procedure Assign(DeArquivosConfDeRE: TArquivosConfDeRE); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

    function GetPathDeRE(Data: TDateTime = 0; const CNPJ: string = ''): string;
  published
    property EmissaoPathDeRE: Boolean read FEmissaoPathDeRE write FEmissaoPathDeRE default False;
    property PathDeRE: string read FPathDeRE write FPathDeRE;
  end;

  { TConfiguracoesDeRE }
  TConfiguracoesDeRE = class(TConfiguracoes)
  private
    function GetArquivos: TArquivosConfDeRE;
    function GetGeral: TGeralConfDeRE;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Assign(DeConfiguracoesDeRE: TConfiguracoesDeRE); reintroduce;
  published
    property Geral: TGeralConfDeRE read GetGeral;
    property Arquivos: TArquivosConfDeRE read GetArquivos;
    property WebServices;
    property Certificados;
  end;

implementation

uses
  ACBrDeRE.Consts;

{ TConfiguracoesDeRE }

constructor TConfiguracoesDeRE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPSessaoIni := 'DeRE';
  WebServices.ResourceName := 'ACBrDeREServicos';
end;

procedure TConfiguracoesDeRE.Assign(DeConfiguracoesDeRE: TConfiguracoesDeRE);
begin
  Geral.Assign(DeConfiguracoesDeRE.Geral);
  WebServices.Assign(DeConfiguracoesDeRE.WebServices);
  Certificados.Assign(DeConfiguracoesDeRE.Certificados);
  Arquivos.Assign(DeConfiguracoesDeRE.Arquivos);
end;

function TConfiguracoesDeRE.GetArquivos: TArquivosConfDeRE;
begin
  Result := TArquivosConfDeRE(FPArquivos);
end;

function TConfiguracoesDeRE.GetGeral: TGeralConfDeRE;
begin
  Result := TGeralConfDeRE(FPGeral);
end;

procedure TConfiguracoesDeRE.CreateGeralConf;
begin
  FPGeral := TGeralConfDeRE.Create(Self);
end;

procedure TConfiguracoesDeRE.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfDeRE.Create(Self);
end;

{ TGeralConfDeRE }

constructor TGeralConfDeRE.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FVersaoDF := VERSAO_DERE_PADRAO;
  FIdContribuinte := '';
  FClientId := '';
  FClientSecret := '';
  FToken := '';
  FTokenExpira := 0;
end;

procedure TGeralConfDeRE.Assign(DeGeralConfDeRE: TGeralConfDeRE);
begin
  inherited Assign(DeGeralConfDeRE);

  VersaoDF := DeGeralConfDeRE.VersaoDF;
  IdContribuinte := DeGeralConfDeRE.IdContribuinte;
  ClientId := DeGeralConfDeRE.ClientId;
  ClientSecret := DeGeralConfDeRE.ClientSecret;
  Token := DeGeralConfDeRE.Token;
  TokenExpira := DeGeralConfDeRE.TokenExpira;
end;

procedure TGeralConfDeRE.SetVersaoDF(const Value: TVersaoDeRE);
begin
  FVersaoDF := Value;
end;

procedure TGeralConfDeRE.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteString(fpConfiguracoes.SessaoIni, 'VersaoDF', VersaoDeREToStr(VersaoDF));
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'IdContribuinte', IdContribuinte);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'ClientId', ClientId);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'ClientSecret', ClientSecret);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'Token', Token);
  if TokenExpira = 0 then
    AIni.WriteString(fpConfiguracoes.SessaoIni, 'TokenExpira', '')
  else
    AIni.WriteString(fpConfiguracoes.SessaoIni, 'TokenExpira',
      FormatDateTime('dd/mm/yyyy hh:nn:ss', TokenExpira));
end;

procedure TGeralConfDeRE.LerIni(const AIni: TCustomIniFile);
var
  LExpira: string;
  LData: TDateTime;
begin
  inherited LerIni(AIni);

  VersaoDF := StrToVersaoDeREDef(AIni.ReadString(fpConfiguracoes.SessaoIni, 'VersaoDF', VersaoDeREToStr(VersaoDF)), VersaoDF);
  IdContribuinte := AIni.ReadString(fpConfiguracoes.SessaoIni, 'IdContribuinte', IdContribuinte);
  ClientId := AIni.ReadString(fpConfiguracoes.SessaoIni, 'ClientId', ClientId);
  ClientSecret := AIni.ReadString(fpConfiguracoes.SessaoIni, 'ClientSecret', ClientSecret);
  Token := AIni.ReadString(fpConfiguracoes.SessaoIni, 'Token', Token);

  // Data/hora no formato dd/mm/yyyy hh:nn:ss (vazio = sem data)
  LExpira := Trim(AIni.ReadString(fpConfiguracoes.SessaoIni, 'TokenExpira', ''));
  if LExpira = '' then
    TokenExpira := 0
  else if not TryEncodeDateTime(
      StrToIntDef(Copy(LExpira, 7, 4), 0), StrToIntDef(Copy(LExpira, 4, 2), 0),
      StrToIntDef(Copy(LExpira, 1, 2), 0), StrToIntDef(Copy(LExpira, 12, 2), 0),
      StrToIntDef(Copy(LExpira, 15, 2), 0), StrToIntDef(Copy(LExpira, 18, 2), 0), 0,
      LData) then
    TokenExpira := 0
  else
    TokenExpira := LData;
end;

{ TArquivosConfDeRE }

constructor TArquivosConfDeRE.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathDeRE := False;
  FPathDeRE := '';
end;

procedure TArquivosConfDeRE.Assign(DeArquivosConfDeRE: TArquivosConfDeRE);
begin
  inherited Assign(DeArquivosConfDeRE);

  EmissaoPathDeRE := DeArquivosConfDeRE.EmissaoPathDeRE;
  PathDeRE := DeArquivosConfDeRE.PathDeRE;
end;

function TArquivosConfDeRE.GetPathDeRE(Data: TDateTime; const CNPJ: string): string;
begin
  Result := GetPath(PathDeRE, ACBRDERE_MODELODF, CNPJ, '', Data, ACBRDERE_MODELODF);
end;

procedure TArquivosConfDeRE.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'EmissaoPathDeRE', EmissaoPathDeRE);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathDeRE', PathDeRE);
end;

procedure TArquivosConfDeRE.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  EmissaoPathDeRE := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'EmissaoPathDeRE', EmissaoPathDeRE);
  PathDeRE := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathDeRE', PathDeRE);
end;

end.
