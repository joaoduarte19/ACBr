{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit ACBrNFAgConfiguracoes;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrDFeConfiguracoes,
  ACBrDFe.Conversao,
  ACBrNFAg.Conversao;

type

  { TGeralConfNFAg }

  TGeralConfNFAg = class(TGeralConf)
  private
    FVersaoDF: TVersaoNFAg;
    FIdCSC: string;
    FCSC: string;
    FVersaoQRCode: TVersaoQrCode;

    procedure SetVersaoDF(const Value: TVersaoNFAg);
    procedure SetIdCSC(const AValue: string);
    procedure SetCSC(const AValue: string);
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfNFAg: TGeralConfNFAg); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

  published
    property VersaoDF: TVersaoNFAg read FVersaoDF write SetVersaoDF default ve100;
    property IdCSC: string read FIdCSC write SetIdCSC;
    property CSC: string read FCSC write SetCSC;
    property VersaoQRCode: TVersaoQrCode read FVersaoQRCode write FVersaoQRCode default veqr100;
  end;

  { TArquivosConfNFAg }

  TArquivosConfNFAg = class(TArquivosConf)
  private
    FEmissaoPathNFAg: boolean;
    FSalvarEvento: boolean;
    FNormatizarMunicipios: Boolean;
    FPathNFAg: string;
    FPathEvento: string;
    FPathArquivoMunicipios: string;
  public
    constructor Create(AOwner: TConfiguracoes); override;
    destructor Destroy; override;
    procedure Assign(DeArquivosConfNFAg: TArquivosConfNFAg); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

    function GetPathNFAg(Data: TDateTime = 0; const CNPJ: string = ''; const IE: string = ''): string;
    function GetPathEvento(tipoEvento: TACBrTipoEvento; const CNPJ: string = ''; const IE: string = ''; Data: TDateTime = 0): string;
  published
    property EmissaoPathNFAg: boolean read FEmissaoPathNFAg
      write FEmissaoPathNFAg default False;
    property SalvarEvento: boolean read FSalvarEvento
      write FSalvarEvento default False;
    property NormatizarMunicipios: boolean
      read FNormatizarMunicipios write FNormatizarMunicipios default False;
    property PathNFAg: string read FPathNFAg write FPathNFAg;
    property PathEvento: string read FPathEvento write FPathEvento;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
  end;

  { TConfiguracoesNFAg }

  TConfiguracoesNFAg = class(TConfiguracoes)
  private
    function GetArquivos: TArquivosConfNFAg;
    function GetGeral: TGeralConfNFAg;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(DeConfiguracoesNFAg: TConfiguracoesNFAg); reintroduce;

  published
    property Geral: TGeralConfNFAg read GetGeral;
    property Arquivos: TArquivosConfNFAg read GetArquivos;
    property WebServices;
    property Certificados;
    property RespTec;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.FilesIO;

{ TConfiguracoesNFAg }

constructor TConfiguracoesNFAg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPSessaoIni := 'NFAg';
  WebServices.ResourceName := 'ACBrNFAgServicos';
end;

procedure TConfiguracoesNFAg.Assign(DeConfiguracoesNFAg: TConfiguracoesNFAg);
begin
  Geral.Assign(DeConfiguracoesNFAg.Geral);
  WebServices.Assign(DeConfiguracoesNFAg.WebServices);
  Certificados.Assign(DeConfiguracoesNFAg.Certificados);
  Arquivos.Assign(DeConfiguracoesNFAg.Arquivos);
  RespTec.Assign(DeConfiguracoesNFAg.RespTec);
end;

function TConfiguracoesNFAg.GetArquivos: TArquivosConfNFAg;
begin
  Result := TArquivosConfNFAg(FPArquivos);
end;

function TConfiguracoesNFAg.GetGeral: TGeralConfNFAg;
begin
  Result := TGeralConfNFAg(FPGeral);
end;

procedure TConfiguracoesNFAg.CreateGeralConf;
begin
  FPGeral := TGeralConfNFAg.Create(Self);
end;

procedure TConfiguracoesNFAg.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfNFAg.Create(self);
end;

{ TGeralConfNFAg }

constructor TGeralConfNFAg.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FVersaoDF     := ve100;
  FIdCSC        := '';
  FCSC          := '';
  FVersaoQRCode := veqr000;
end;

procedure TGeralConfNFAg.Assign(DeGeralConfNFAg: TGeralConfNFAg);
begin
  inherited Assign(DeGeralConfNFAg);

  VersaoDF     := DeGeralConfNFAg.VersaoDF;
  IdCSC        := DeGeralConfNFAg.IdCSC;
  CSC          := DeGeralConfNFAg.CSC;
  VersaoQRCode := DeGeralConfNFAg.VersaoQRCode;
end;

procedure TGeralConfNFAg.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteString(fpConfiguracoes.SessaoIni, 'IdCSC', IdCSC);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'CSC', CSC);
  AIni.WriteInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF));
  AIni.WriteInteger(fpConfiguracoes.SessaoIni, 'VersaoQRCode', Integer(VersaoQRCode));
end;

procedure TGeralConfNFAg.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  IdCSC        := AIni.ReadString(fpConfiguracoes.SessaoIni, 'IdCSC', IdCSC);
  CSC          := AIni.ReadString(fpConfiguracoes.SessaoIni, 'CSC', CSC);
  VersaoDF     := TVersaoNFAg(AIni.ReadInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF)));
  VersaoQRCode := TVersaoQrCode(AIni.ReadInteger(fpConfiguracoes.SessaoIni, 'VersaoQRCode', Integer(VersaoQRCode)));
end;

procedure TGeralConfNFAg.SetIdCSC(const AValue: string);
begin
  if FIdCSC = AValue then
    Exit;

  FIdCSC := IntToStrZero(StrToIntDef(AValue,0),6);
end;

procedure TGeralConfNFAg.SetCSC(const AValue: string);
begin
  if FCSC = AValue then
    Exit;

  FCSC := Trim(AValue);
end;

procedure TGeralConfNFAg.SetVersaoDF(const Value: TVersaoNFAg);
begin
  FVersaoDF := Value;
end;

{ TArquivosConfNFAg }

constructor TArquivosConfNFAg.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathNFAg             := False;
  FSalvarEvento                := False;
  FNormatizarMunicipios        := False;
  FPathNFAg                    := '';
  FPathEvento                  := '';
  FPathArquivoMunicipios       := '';
end;

destructor TArquivosConfNFAg.Destroy;
begin

  inherited;
end;

procedure TArquivosConfNFAg.Assign(DeArquivosConfNFAg: TArquivosConfNFAg);
begin
  inherited Assign(DeArquivosConfNFAg);

  EmissaoPathNFAg             := DeArquivosConfNFAg.EmissaoPathNFAg;
  SalvarEvento                := DeArquivosConfNFAg.SalvarEvento;
  NormatizarMunicipios        := DeArquivosConfNFAg.NormatizarMunicipios;
  PathNFAg                    := DeArquivosConfNFAg.PathNFAg;
  PathEvento                  := DeArquivosConfNFAg.PathEvento;
  PathArquivoMunicipios       := DeArquivosConfNFAg.PathArquivoMunicipios;
end;

procedure TArquivosConfNFAg.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFAg', EmissaoPathNFAg);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathNFAg', PathNFAg);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

procedure TArquivosConfNFAg.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  SalvarEvento := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  EmissaoPathNFAg := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFAg', EmissaoPathNFAg);
  NormatizarMunicipios := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  PathNFAg := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathNFAg', PathNFAg);
  PathEvento := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  PathArquivoMunicipios := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

function TArquivosConfNFAg.GetPathEvento(tipoEvento: TACBrTipoEvento; const CNPJ: string;
  const IE: string; Data: TDateTime): string;
var
  Dir: string;
begin
  Dir := GetPath(FPathEvento, 'Evento', CNPJ, IE, Data);

  if AdicionarLiteral then
    Dir := PathWithDelim(Dir) + TpEventoToDescStr(tipoEvento);

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;

function TArquivosConfNFAg.GetPathNFAg(Data: TDateTime = 0; const CNPJ: string = ''; const IE: string = ''): string;
begin
  Result := GetPath(FPathNFAg, 'NFAg', CNPJ, IE, Data, 'NFAg');
end;

end.

