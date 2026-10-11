{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior                           }
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

unit ACBrLibIMendesConfig;

interface

uses
  Classes, SysUtils, IniFiles, synachar,
  ACBrLibConfig, ACBrIMendes;

type

{ TIMendesConfig }
TIMendesConfig = class
  private
    FAmbiente: TACBrIMendesAmbiente;
    FCNPJ: String;
    FSenha: String;
    FArqLog: String;
    FNivelLog: Byte;
    FTimeOut: Integer;
    FMaxProdutosPorEnvio: Integer;
    FChaveCrypt: AnsiString;

  public
    constructor Create(AChaveCrypt: AnsiString = '');
    destructor Destroy; override;

    procedure DefinirValoresPadroes;
    procedure LerIni(const AIni: TCustomIniFile);
    procedure GravarIni(const AIni: TCustomIniFile);

    property Ambiente: TACBrIMendesAmbiente read FAmbiente write FAmbiente;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Senha: String read FSenha write FSenha;
    property ArqLog: String read FArqLog write FArqLog;
    property NivelLog: Byte read FNivelLog write FNivelLog;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property MaxProdutosPorEnvio: Integer read FMaxProdutosPorEnvio write FMaxProdutosPorEnvio;
end;

{ TLibIMendesConfig }
TLibIMendesConfig = class(TLibConfig)
  private
    FIMendesConfig: TIMendesConfig;

  protected
    function AtualizarArquivoConfiguracao: Boolean; override;
    function PrecisaCriptografar(ASessao, AChave: String): Boolean; override;

    procedure INIParaClasse; override;
    procedure ClasseParaINI; override;
    procedure ClasseParaComponentes; override;

    procedure Travar; override;
    procedure Destravar; override;

  public
    constructor Create(AOwner: TObject; ANomeArquivo: String = ''; AChaveCrypt: AnsiString = ''); override;
    destructor Destroy; override;

    property IMendesConfig: TIMendesConfig read FIMendesConfig;
end;

implementation

Uses
  ACBrLibComum, ACBrLibIMendesBase, ACBrLibIMendesConsts, ACBrLibConsts, ACBrUtil.FilesIO;

{ TIMendesConfig }

constructor TIMendesConfig.Create(AChaveCrypt: AnsiString);
begin
  inherited Create;
  FChaveCrypt := AChaveCrypt;
  DefinirValoresPadroes;
end;

destructor TIMendesConfig.Destroy;
begin
  inherited Destroy;
end;

procedure TIMendesConfig.DefinirValoresPadroes;
begin
  FAmbiente := imaNenhum;
  FCNPJ := EmptyStr;
  FSenha := EmptyStr;
  FArqLog := EmptyStr;
  FNivelLog := 1;
  FTimeOut := cIMendesTimeOutPadrao;
  FMaxProdutosPorEnvio := cIMendesMaxProdutosPorEnvio;
end;

procedure TIMendesConfig.LerIni(const AIni: TCustomIniFile);
var
  wAmb: Integer;
begin
  wAmb := AIni.ReadInteger(CSessaoIMendes, CChaveAmbiente, Integer(FAmbiente));
  if (wAmb < Integer(Low(TACBrIMendesAmbiente))) or (wAmb > Integer(High(TACBrIMendesAmbiente))) then
    wAmb := Integer(imaNenhum);
  FAmbiente := TACBrIMendesAmbiente(wAmb);

  FCNPJ := AIni.ReadString(CSessaoIMendes, CChaveCNPJ, FCNPJ);
  FSenha := B64CryptToString(AIni.ReadString(CSessaoIMendes, CChaveSenha, ''), FChaveCrypt);
  FArqLog := AIni.ReadString(CSessaoIMendes, CChaveArqLog, FArqLog);
  FNivelLog := AIni.ReadInteger(CSessaoIMendes, CChaveNivelLog, FNivelLog);
  FTimeOut := AIni.ReadInteger(CSessaoIMendes, CChaveTimeOut, FTimeOut);

  // O componente aceita de 1 a cIMendesMaxProdutosPorEnvio (300); fora da faixa o valor e limitado
  FMaxProdutosPorEnvio := AIni.ReadInteger(CSessaoIMendes, CChaveMaxProdutosPorEnvio, FMaxProdutosPorEnvio);
  if (FMaxProdutosPorEnvio < 1) then
    FMaxProdutosPorEnvio := 1
  else if (FMaxProdutosPorEnvio > cIMendesMaxProdutosPorEnvio) then
    FMaxProdutosPorEnvio := cIMendesMaxProdutosPorEnvio;
end;

procedure TIMendesConfig.GravarIni(const AIni: TCustomIniFile);
begin
  AIni.WriteInteger(CSessaoIMendes, CChaveAmbiente, Integer(FAmbiente));
  AIni.WriteString(CSessaoIMendes, CChaveCNPJ, FCNPJ);
  AIni.WriteString(CSessaoIMendes, CChaveSenha, StringToB64Crypt(FSenha, FChaveCrypt));
  AIni.WriteString(CSessaoIMendes, CChaveArqLog, FArqLog);
  AIni.WriteInteger(CSessaoIMendes, CChaveNivelLog, FNivelLog);
  AIni.WriteInteger(CSessaoIMendes, CChaveTimeOut, FTimeOut);
  AIni.WriteInteger(CSessaoIMendes, CChaveMaxProdutosPorEnvio, FMaxProdutosPorEnvio);
end;

{ TLibIMendesConfig }

function TLibIMendesConfig.AtualizarArquivoConfiguracao: Boolean;
var
  Versao: String;
begin
  Versao := Ini.ReadString(CSessaoVersao, CLibIMendesNome, '0');
  Result := (CompareVersions(CLibIMendesVersao, Versao) > 0) or
            (inherited AtualizarArquivoConfiguracao);
end;

function TLibIMendesConfig.PrecisaCriptografar(ASessao, AChave: String): Boolean;
begin
  Result := (ASessao = CSessaoIMendes) and (AChave = CChaveSenha);

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

procedure TLibIMendesConfig.INIParaClasse;
begin
  inherited INIParaClasse;

  FIMendesConfig.LerIni(Ini);
end;

procedure TLibIMendesConfig.ClasseParaINI;
begin
  inherited ClasseParaINI;

  Ini.WriteString(CSessaoVersao, CLibIMendesNome, CLibIMendesVersao);

  FIMendesConfig.GravarIni(Ini);
end;

procedure TLibIMendesConfig.ClasseParaComponentes;
begin
  if Assigned(Owner) then
  begin
    TACBrLibIMendes(Owner).IMendesDM.AplicarConfiguracoes;
  end;
end;

procedure TLibIMendesConfig.Travar;
begin
  if Assigned(Owner) then
  begin
    with TACBrLibIMendes(Owner) do
    IMendesDM.Travar;
  end;
end;

procedure TLibIMendesConfig.Destravar;
begin
  if Assigned(Owner) then
  begin
    with TACBrLibIMendes(Owner) do
    IMendesDM.Destravar;
  end;
end;

constructor TLibIMendesConfig.Create(AOwner: TObject; ANomeArquivo: String;
  AChaveCrypt: AnsiString);
begin
  inherited Create(AOwner, ANomeArquivo, AChaveCrypt);

  FIMendesConfig := TIMendesConfig.Create(ChaveCrypt);
end;

destructor TLibIMendesConfig.Destroy;
begin
  FIMendesConfig.Free;
  inherited Destroy;
end;

end.

