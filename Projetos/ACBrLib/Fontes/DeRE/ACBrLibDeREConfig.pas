{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                 }
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

unit ACBrLibDeREConfig;

interface

uses
  Classes, SysUtils, IniFiles, SynaChar,
  ACBrDeREConfiguracoes,
  ACBrLibConfig;

type

  { TLibDeREConfig }
  TLibDeREConfig = class(TLibConfig)
  private
    FDeREConfig: TConfiguracoesDeRE;

  protected
    function AtualizarArquivoConfiguracao: Boolean; override;

    procedure INIParaClasse; override;
    procedure ClasseParaINI; override;
    procedure ClasseParaComponentes; override;

    procedure Travar; override;
    procedure Destravar; override;

  public
    function PrecisaCriptografar(ASessao, AChave: String): Boolean; override;

    constructor Create(AOwner: TObject; ANomeArquivo: String = ''; AChaveCrypt: AnsiString = ''); override;
    destructor Destroy; override;

    property DeREConfig: TConfiguracoesDeRE read FDeREConfig;
  end;

implementation

uses
  ACBrLibDeREBase, ACBrLibDeREConsts, ACBrLibConsts, ACBrLibComum,
  ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.Strings, StrUtils;

{ TLibDeREConfig }

constructor TLibDeREConfig.Create(AOwner: TObject; ANomeArquivo: String; AChaveCrypt: AnsiString);
begin
  inherited Create(AOwner, ANomeArquivo, AChaveCrypt);

  FDeREConfig := TConfiguracoesDeRE.Create(nil);
end;

destructor TLibDeREConfig.Destroy;
begin
  FDeREConfig.Free;

  inherited Destroy;
end;

function TLibDeREConfig.AtualizarArquivoConfiguracao: Boolean;
var
  Versao: String;
begin
  Versao := Ini.ReadString(CSessaoVersao, CLibDeRENome, '0');
  Result := (CompareVersions(CLibDeREVersao, Versao) > 0) or
            (inherited AtualizarArquivoConfiguracao);
end;

procedure TLibDeREConfig.INIParaClasse;
begin
  inherited INIParaClasse;

  FDeREConfig.ChaveCryptINI := ChaveCrypt;
  FDeREConfig.LerIni(Ini);

  // ClientSecret e Token ficam criptografados no INI da Lib; o componente recebe o valor claro
  with FDeREConfig.Geral do
  begin
    if NaoEstaVazio(Ini.ReadString(CSessaoDeREConfig, CChaveDeREClientSecret, '')) then
      ClientSecret := B64CryptToString(Ini.ReadString(CSessaoDeREConfig, CChaveDeREClientSecret, ''), ChaveCrypt)
    else
      ClientSecret := '';

    if NaoEstaVazio(Ini.ReadString(CSessaoDeREConfig, CChaveDeREToken, '')) then
      Token := B64CryptToString(Ini.ReadString(CSessaoDeREConfig, CChaveDeREToken, ''), ChaveCrypt)
    else
      Token := '';
  end;
end;

procedure TLibDeREConfig.ClasseParaINI;
begin
  inherited ClasseParaINI;

  FDeREConfig.ChaveCryptINI := ChaveCrypt;
  FDeREConfig.GravarIni(Ini);

  // O componente grava em texto; a Lib regrava criptografados (igual a Senha do certificado)
  with FDeREConfig.Geral do
  begin
    Ini.WriteString(CSessaoDeREConfig, CChaveDeREClientSecret,
      IfThen(EstaVazio(ClientSecret), '', StringToB64Crypt(ClientSecret, ChaveCrypt)));
    Ini.WriteString(CSessaoDeREConfig, CChaveDeREToken,
      IfThen(EstaVazio(Token), '', StringToB64Crypt(Token, ChaveCrypt)));
  end;
end;

procedure TLibDeREConfig.ClasseParaComponentes;
begin
  FDeREConfig.ChaveCryptINI := ChaveCrypt;

  if Assigned(Owner) then
    TACBrLibDeRE(Owner).DeREDM.AplicarConfiguracoes;
end;

function TLibDeREConfig.PrecisaCriptografar(ASessao, AChave: String): Boolean;
begin
  Result := inherited PrecisaCriptografar(ASessao, AChave) or
            ((ASessao = CSessaoDeREConfig) and
             ((AChave = CChaveDeREClientSecret) or (AChave = CChaveDeREToken)));
end;

procedure TLibDeREConfig.Travar;
begin
  if Assigned(Owner) then
  begin
    with TACBrLibDeRE(Owner) do
      DeREDM.Travar;
  end;
end;

procedure TLibDeREConfig.Destravar;
begin
  if Assigned(Owner) then
  begin
    with TACBrLibDeRE(Owner) do
      DeREDM.Destravar;
  end;
end;

end.

