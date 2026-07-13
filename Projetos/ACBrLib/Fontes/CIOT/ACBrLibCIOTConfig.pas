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

unit ACBrLibCIOTConfig;

interface

uses
  Classes, SysUtils, IniFiles, synachar,
  ACBrLibComum, ACBrLibConfig, ACBrCIOT,
  ACBrCIOTConfiguracoes,
  ACBrXmlBase;

type
  { TLibCIOTIntegradoraCIOTConfig }
  TLibCIOTIntegradoraCIOTConfig = class
  private
    FIntegradoraCIOT: String;
    FIntegradoraUsuario: String;
    FIntegradoraSenha: String;
    FIntegradoraHash: String;
    FIntegradoraToken: String;
    FTokenAtivo: String;
    FChaveCrypt: String;
  public
    constructor Create(AChaveCrypt: String); virtual;

    property IntegradoraCIOT: String read FIntegradoraCIOT write FIntegradoraCIOT;
    property IntegradoraUsuario: String read FIntegradoraUsuario write FIntegradoraUsuario;
    property IntegradoraSenha: String read FIntegradoraSenha write FIntegradoraSenha;
    property IntegradoraHash: String read FIntegradoraHash write FIntegradoraHash;
    property IntegradoraToken: String read FIntegradoraToken write FIntegradoraToken;
    property TokenAtivo: String read FTokenAtivo write FTokenAtivo;
  end;

  { TLibCIOTIntegradoraConfig }

  TLibCIOTIntegradoraConfig = class(TLibCIOTIntegradoraCIOTConfig)
  public
    constructor Create(AChaveCrypt: String); override;

    procedure LerIni(const AIni: TCustomIniFile);
    procedure GravarIni(const AIni: TCustomIniFile);
  end;

  { TLibCIOTConfig }
  TLibCIOTConfig = class(TLibConfig)
  private
    FCIOTConfig: TConfiguracoesCIOT;
    FIntegradoraConfig: TLibCIOTIntegradoraConfig;
  protected
    function AtualizarArquivoConfiguracao: Boolean; override;

    procedure INIParaClasse; override;
    procedure ClasseParaINI; override;
    procedure ClasseParaComponentes; override;

    procedure Travar; override;
    procedure Destravar; override;

  public
    constructor Create(AOwner: TObject; ANomeArquivo: String = ''; AChaveCrypt: AnsiString = ''); override;
    destructor Destroy; override;

    function PrecisaCriptografar(ASessao, AChave: String): Boolean; override;

    property CIOTConfig: TConfiguracoesCIOT read FCIOTConfig;
    property IntegradoraConfig: TLibCIOTIntegradoraConfig read FIntegradoraConfig write FIntegradoraConfig;
end;

implementation

uses
  ACBrLibCIOTBase, ACBrLibCIOTConsts, ACBrLibConsts, ACBrUtil.FilesIO;

{ TLibCIOTIntegradoraCIOTConfig }

constructor TLibCIOTIntegradoraCIOTConfig.Create(AChaveCrypt: String);
begin
  if AChaveCrypt = '' then
    FChaveCrypt := CLibChaveCrypt
  else
    FChaveCrypt := AChaveCrypt;
end;

{ TLibCIOTIntegradoraConfig }

constructor TLibCIOTIntegradoraConfig.Create(AChaveCrypt: String);
begin
  inherited Create(AChaveCrypt);

  FIntegradoraCIOT := EmptyStr;
  FIntegradoraUsuario := EmptyStr;
  FIntegradoraSenha := EmptyStr;
  FIntegradoraHash := EmptyStr;
  FIntegradoraToken := EmptyStr;
  FTokenAtivo := EmptyStr;
end;

procedure TLibCIOTIntegradoraConfig.LerIni(const AIni: TCustomIniFile);
begin
  IntegradoraCIOT := AIni.ReadString(CSessaoIntegradoraConfig, CIntegradoraCIOT, IntegradoraCIOT);
  IntegradoraUsuario := AIni.ReadString(CSessaoIntegradoraConfig, CIntegradoraUsuario, IntegradoraUsuario);
  IntegradoraSenha := B64CryptToString(AIni.ReadString(CSessaoIntegradoraConfig, CIntegradoraSenha, IntegradoraSenha), FChaveCrypt);
  IntegradoraHash := B64CryptToString(AIni.ReadString(CSessaoIntegradoraConfig, CIntegradoraHash, IntegradoraHash), FChaveCrypt);
  IntegradoraToken := B64CryptToString(AIni.ReadString(CSessaoIntegradoraConfig, CIntegradoraToken, IntegradoraToken), FChaveCrypt);
  TokenAtivo := IntegradoraToken;
end;

procedure TLibCIOTIntegradoraConfig.GravarIni(const AIni: TCustomIniFile);
begin
  AIni.WriteString(CSessaoIntegradoraConfig, CIntegradoraCIOT, IntegradoraCIOT);
  AIni.WriteString(CSessaoIntegradoraConfig, CIntegradoraUsuario, IntegradoraUsuario);
  AIni.WriteString(CSessaoIntegradoraConfig, CIntegradoraSenha, StringToB64Crypt(IntegradoraSenha, FChaveCrypt));
  AIni.WriteString(CSessaoIntegradoraConfig, CIntegradoraHash, StringToB64Crypt(IntegradoraHash, FChaveCrypt));
  AIni.WriteString(CSessaoIntegradoraConfig, CIntegradoraToken, StringToB64Crypt(IntegradoraToken, FChaveCrypt));
  TokenAtivo := IntegradoraToken;
end;

{ TLibCIOTConfig }
function TLibCIOTConfig.AtualizarArquivoConfiguracao: Boolean;
var
  Versao: String;
begin
  Versao := Ini.ReadString(CSessaoVersao, CLibCIOTNome, '0');
  Result := (CompareVersions(CLibCIOTVersao, Versao) > 0) or
            (inherited AtualizarArquivoConfiguracao);
end;

procedure TLibCIOTConfig.INIParaClasse;
begin
  inherited INIParaClasse;

  FCIOTConfig.ChaveCryptINI := ChaveCrypt;
  FCIOTConfig.LerIni(Ini);
  FIntegradoraConfig.LerIni(Ini);
end;

procedure TLibCIOTConfig.ClasseParaINI;
begin
  inherited ClasseParaINI;

  Ini.WriteString(CSessaoVersao, CLibCIOTNome, CLibCIOTVersao);

  FCIOTConfig.ChaveCryptINI := ChaveCrypt;
  FCIOTConfig.GravarIni(Ini);
  FIntegradoraConfig.GravarIni(Ini);
end;

procedure TLibCIOTConfig.ClasseParaComponentes;
begin
  FCIOTConfig.ChaveCryptINI := ChaveCrypt;

  if Assigned(Owner) then
    TACBrLibCIOT(Owner).CIOTDM.AplicarConfiguracoes;
end;

procedure TLibCIOTConfig.Travar;
begin
  if Assigned(Owner) then
    TACBrLibCIOT(Owner).CIOTDM.Travar;
end;

procedure TLibCIOTConfig.Destravar;
begin
  if Assigned(Owner) then
    TACBrLibCIOT(Owner).CIOTDM.Destravar;
end;

constructor TLibCIOTConfig.Create(AOwner: TObject; ANomeArquivo: String;
  AChaveCrypt: AnsiString);
begin
  inherited Create(AOwner, ANomeArquivo, AChaveCrypt);
  FCIOTConfig := TConfiguracoesCIOT.Create(nil);
  FCIOTConfig.ChaveCryptINI := AChaveCrypt;
  FIntegradoraConfig := TLibCIOTIntegradoraConfig.Create(AChaveCrypt);
end;

destructor TLibCIOTConfig.Destroy;
begin
  FCIOTConfig.Free;
  FIntegradoraConfig.Free;
  inherited Destroy;
end;

function TLibCIOTConfig.PrecisaCriptografar(ASessao, AChave: String): Boolean;
begin
  Result := (AChave = CIntegradoraSenha) or
            (AChave = CIntegradoraHash) or
            (AChave = CIntegradoraToken);

  if (not Result) then
    Result := inherited PrecisaCriptografar(ASessao, AChave)
  else
  begin
    with TACBrLib(Owner) do
    begin
      if (Config.Log.Nivel > logCompleto) then
        GravarLog(ClassName + '.PrecisaCriptografar(' + ASessao + ',' + AChave + ')', logParanoico);

      if (Config.Log.Nivel > logCompleto) then
        GravarLog(ClassName + '.PrecisaCriptografar - Feito Result: ' + BoolToStr(Result, True), logParanoico);
    end;
  end;
end;

end.

