{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                              Italo Giurizzato Junior                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
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

unit ACBrNFGasConfiguracoes;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrDFeConfiguracoes,
  ACBrDFe.Conversao,
  ACBrNFGas.Conversao;

type
  { TGeralConfNFGas }

  TGeralConfNFGas = class(TGeralConf)
  private
    FVersaoDF: TVersaoNFGas;
    FIdCSC: string;
    FCSC: string;
    FVersaoQRCode: TVersaoQrCode;

    procedure SetVersaoDF(const Value: TVersaoNFGas);
    procedure SetIdCSC(const AValue: string);
    procedure SetCSC(const AValue: string);
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfNFGas: TGeralConfNFGas); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;
  published
    property VersaoDF: TVersaoNFGas read FVersaoDF write SetVersaoDF default ve100;
    property IdCSC: string read FIdCSC write SetIdCSC;
    property CSC: string read FCSC write SetCSC;
    property VersaoQRCode: TVersaoQrCode read FVersaoQRCode write FVersaoQRCode default veqr100;
  end;

  { TArquivosConfNFGas }

  TArquivosConfNFGas = class(TArquivosConf)
  private
    FEmissaoPathNFGas: Boolean;
    FSalvarEvento: boolean;
    FNormatizarMunicipios: Boolean;
    FPathNFGas: string;
    FPathEvento: string;
    FPathArquivoMunicipios: string;
  public
    constructor Create(AOwner: TConfiguracoes); override;
    destructor Destroy; override;
    procedure Assign(DeArquivosConfNFGas: TArquivosConfNFGas); reintroduce;
    procedure GravarIni(const AIni: TCustomIniFile); override;
    procedure LerIni(const AIni: TCustomIniFile); override;

    function GetPathNFGas(Data: TDateTime = 0; const CNPJ: string = ''; const IE: string = ''): string;
    function GetPathEvento(tipoEvento: TACBrTipoEvento; const CNPJ: string = ''; const IE: string = ''; Data: TDateTime = 0): string;
  published
    property EmissaoPathNFGas: Boolean read FEmissaoPathNFGas
      write FEmissaoPathNFGas default False;
    property SalvarEvento: boolean read FSalvarEvento
      write FSalvarEvento default False;
    property NormatizarMunicipios: Boolean read FNormatizarMunicipios
      write FNormatizarMunicipios default False;
    property PathNFGas: string read FPathNFGas write FPathNFGas;
    property PathEvento: string read FPathEvento write FPathEvento;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios
      write FPathArquivoMunicipios;
  end;

  { TConfiguracoesNFGas }

  TConfiguracoesNFGas = class(TConfiguracoes)
  private
    function GetArquivos: TArquivosConfNFGas;
    function GetGeral: TGeralConfNFGas;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(DeConfiguracoesNFGas: TConfiguracoesNFGas); reintroduce;
  published
    property Geral: TGeralConfNFGas read GetGeral;
    property Arquivos: TArquivosConfNFGas read GetArquivos;
    property WebServices;
    property Certificados;
    property RespTec;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.FilesIO;

{ TConfiguracoesNFGas }

constructor TConfiguracoesNFGas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPSessaoIni := 'NFGas';
  WebServices.ResourceName := 'ACBrNFGasServicos';
end;

procedure TConfiguracoesNFGas.Assign(DeConfiguracoesNFGas: TConfiguracoesNFGas);
begin
  Geral.Assign(DeConfiguracoesNFGas.Geral);
  WebServices.Assign(DeConfiguracoesNFGas.WebServices);
  Certificados.Assign(DeConfiguracoesNFGas.Certificados);
  Arquivos.Assign(DeConfiguracoesNFGas.Arquivos);
  RespTec.Assign(DeConfiguracoesNFGas.RespTec);
end;

function TConfiguracoesNFGas.GetArquivos: TArquivosConfNFGas;
begin
  Result := TArquivosConfNFGas(FPArquivos);
end;

function TConfiguracoesNFGas.GetGeral: TGeralConfNFGas;
begin
  Result := TGeralConfNFGas(FPGeral);
end;

procedure TConfiguracoesNFGas.CreateGeralConf;
begin
  FPGeral := TGeralConfNFGas.Create(Self);
end;

procedure TConfiguracoesNFGas.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfNFGas.Create(Self);
end;

{ TGeralConfNFGas }

constructor TGeralConfNFGas.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FVersaoDF := ve100;
  FIdCSC := '';
  FCSC := '';
  FVersaoQRCode := veqr000;
end;

procedure TGeralConfNFGas.Assign(DeGeralConfNFGas: TGeralConfNFGas);
begin
  inherited Assign(DeGeralConfNFGas);

  VersaoDF := DeGeralConfNFGas.VersaoDF;
  IdCSC := DeGeralConfNFGas.IdCSC;
  CSC := DeGeralConfNFGas.CSC;
  VersaoQRCode := DeGeralConfNFGas.VersaoQRCode;
end;

procedure TGeralConfNFGas.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteString(fpConfiguracoes.SessaoIni, 'IdCSC', IdCSC);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'CSC', CSC);
  AIni.WriteInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF));
  AIni.WriteInteger(fpConfiguracoes.SessaoIni, 'VersaoQRCode', Integer(VersaoQRCode));
end;

procedure TGeralConfNFGas.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  IdCSC := AIni.ReadString(fpConfiguracoes.SessaoIni, 'IdCSC', IdCSC);
  CSC := AIni.ReadString(fpConfiguracoes.SessaoIni, 'CSC', CSC);
  VersaoDF := TVersaoNFGas(AIni.ReadInteger(fpConfiguracoes.SessaoIni, 'VersaoDF', Integer(VersaoDF)));
  VersaoQRCode := TVersaoQrCode(AIni.ReadInteger(fpConfiguracoes.SessaoIni, 'VersaoQRCode', Integer(VersaoQRCode)));
end;

procedure TGeralConfNFGas.SetIdCSC(const AValue: string);
begin
  if FIdCSC = AValue then
    Exit;

  FIdCSC := IntToStrZero(StrToIntDef(AValue,0),6);
end;

procedure TGeralConfNFGas.SetCSC(const AValue: string);
begin
  if FCSC = AValue then
    Exit;

  FCSC := Trim(AValue);
end;

procedure TGeralConfNFGas.SetVersaoDF(const Value: TVersaoNFGas);
begin
  FVersaoDF := Value;
end;

{ TArquivosConfNFGas }

constructor TArquivosConfNFGas.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathNFGas := False;
  FSalvarEvento := False;
  FNormatizarMunicipios := False;
  FPathNFGas := '';
  FPathEvento := '';
  FPathArquivoMunicipios := '';
end;

destructor TArquivosConfNFGas.Destroy;
begin

  inherited;
end;

procedure TArquivosConfNFGas.Assign(DeArquivosConfNFGas: TArquivosConfNFGas);
begin
  inherited Assign(DeArquivosConfNFGas);

  EmissaoPathNFGas := DeArquivosConfNFGas.EmissaoPathNFGas;
  SalvarEvento := DeArquivosConfNFGas.SalvarEvento;
  NormatizarMunicipios := DeArquivosConfNFGas.NormatizarMunicipios;
  PathNFGas := DeArquivosConfNFGas.PathNFGas;
  PathEvento := DeArquivosConfNFGas.PathEvento;
  PathArquivoMunicipios := DeArquivosConfNFGas.PathArquivoMunicipios;
end;

procedure TArquivosConfNFGas.GravarIni(const AIni: TCustomIniFile);
begin
  inherited GravarIni(AIni);

  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFAg', EmissaoPathNFGas);
  AIni.WriteBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathNFGas', PathNFGas);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  AIni.WriteString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

procedure TArquivosConfNFGas.LerIni(const AIni: TCustomIniFile);
begin
  inherited LerIni(AIni);

  SalvarEvento := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'SalvarEvento', SalvarEvento);
  EmissaoPathNFGas := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'EmissaoPathNFGas', EmissaoPathNFGas);
  NormatizarMunicipios := AIni.ReadBool(fpConfiguracoes.SessaoIni, 'NormatizarMunicipios', NormatizarMunicipios);
  PathNFGas := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathNFGas', PathNFGas);
  PathEvento := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathEvento', PathEvento);
  PathArquivoMunicipios := AIni.ReadString(fpConfiguracoes.SessaoIni, 'PathArquivoMunicipios', PathArquivoMunicipios);
end;

function TArquivosConfNFGas.GetPathEvento(tipoEvento: TACBrTipoEvento; const CNPJ: string;
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

function TArquivosConfNFGas.GetPathNFGas(Data: TDateTime; const CNPJ: string; const IE: string): string;
begin
  Result := GetPath(FPathNFGas, 'NFGas', CNPJ, IE, Data, 'NFGas');
end;

end.
