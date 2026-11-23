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

unit ACBrDeRE;

interface

uses
  Classes, SysUtils,
  ACBrBase,
  ACBrDFe, ACBrDFeException, ACBrDFeConfiguracoes,
  ACBrDeREConfiguracoes, ACBrDeREWebServices, ACBrDeREEventos,
  ACBrDeRE.Conversao;

resourcestring
  ACBRDERE_CErroSignLib = 'Necessário DigestMethod Algorithm SHA256. use xsXmlSec ou xsLibXml2 na propriedade SSLXmlSignLib.';
  ACBRDERE_CErroCryptLib = 'Necessário DigestMethod Algorithm SHA256. use cryOpenSSL ou cryWinCrypt na propriedade SSLCryptLib.';

type
  EACBrDeREException = class(EACBrDFeException);
  TNotifyEventosDeRE = procedure(const AXML: string; ATipo: TEventosDeRE) of object;

  { TACBrDeRE }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrDeRE = class(TACBrDFe)
  private
    FEventos: TEventos;
    FWebServices: TWebServices;
    FStatus: TStatusDeRE;
    FOnTransmissaoEventos: TNotifyEventosDeRE;

    function GetConfiguracoes: TConfiguracoesDeRE;
    procedure SetConfiguracoes(AValue: TConfiguracoesDeRE);
  protected
    function CreateConfiguracoes: TConfiguracoes; override;
    function NomeServicoToNomeSchema(const NomeServico: string): string; override;
    function VersaoSchemaDoubleToString(AVersao: Double): string; override;
    function VersaoSchemaStringToDouble(const AVersao: string): Double; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetNomeModeloDFe: string; override;
    function GetNameSpaceURI: string; override;

    // Gera, assina e valida os XMLs dos eventos (e salva, se Configuracoes.Geral.Salvar)
    procedure AssinarEventos;
    procedure LerServicoDeParams(ALayOut: TLayOutDeRE; var Versao: Double; var URL: string);
    function LerVersaoDeParams(ALayOut: TLayOutDeRE): string; reintroduce; overload;
    procedure SetStatus(const stNewStatus: TStatusDeRE);

    // Resolve o caminho completo do XSD (schema) a partir do enum TSchemaDeRE
    function GerarNomeArqSchema(const ASchema: TSchemaDeRE): string;

    function ObterToken: Boolean;
    function EnviarLote: Boolean;
    function ConsultarLote(const AProtocolo: string): Boolean;
    // Apaga os dados do contribuinte na Producao Restrita (somente taHomologacao).
    // ANrInsc = CNPJ base (8 posicoes); vazio usa Geral.IdContribuinte.
    function LimparDados(const ANrInsc: string = ''): Boolean;

    property Eventos: TEventos read FEventos write FEventos;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property Status: TStatusDeRE read FStatus;
  published
    property Configuracoes: TConfiguracoesDeRE read GetConfiguracoes write SetConfiguracoes;
    property OnTransmissaoEventos: TNotifyEventosDeRE read FOnTransmissaoEventos write FOnTransmissaoEventos;
  end;

implementation

{$R ACBrDeREServicos.res}

uses
  ACBrDFeSSL,
  ACBrDFe.Conversao,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrDeRE.Consts;

{ TACBrDeRE }

constructor TACBrDeRE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Os XSD da DeRE usam o separador "-v" (ex.: evtInfoContrib-v1_0_1.xsd)
  FPSeparadorVersaoSchema := '-v';

  SSL.SSLDgst := dgstSHA256;

  FStatus := stDeREIdle;
  FEventos := TEventos.Create(Self);
  FWebServices := TWebServices.Create(Self);
end;

destructor TACBrDeRE.Destroy;
begin
  FEventos.Free;
  FWebServices.Free;

  inherited Destroy;
end;

function TACBrDeRE.GetConfiguracoes: TConfiguracoesDeRE;
begin
  Result := TConfiguracoesDeRE(FPConfiguracoes);
end;

procedure TACBrDeRE.SetConfiguracoes(AValue: TConfiguracoesDeRE);
begin
  FPConfiguracoes := AValue;
end;

function TACBrDeRE.CreateConfiguracoes: TConfiguracoes;
begin
  Result := TConfiguracoesDeRE.Create(Self);
end;

function TACBrDeRE.NomeServicoToNomeSchema(const NomeServico: string): string;
begin
  // Para a DeRE o "nome do servico" ja corresponde ao nome-base do schema.
  Result := NomeServico;
end;

function TACBrDeRE.VersaoSchemaDoubleToString(AVersao: Double): string;
var
  StrVer: string;
begin
  Result := '';

  if (AVersao > 0) then
  begin
    StrVer := FloatToString(AVersao, '.', '0.00');
    StrVer := StringReplace(StrVer, '.', '', [rfReplaceAll]);
    Result := StrVer[1] + '_' + StrVer[2] + '_' + StrVer[3];
  end;
end;

function TACBrDeRE.VersaoSchemaStringToDouble(const AVersao: string): Double;
var
  StrVer: string;
begin
  Result := 0;
  if (AVersao <> '') then
  begin
    StrVer := StringReplace(AVersao, '_', '', [rfReplaceAll]);
    StrVer := PadRight(StrVer, 3, '0');
    Result := StringToFloatDef(StrVer[1] + '.' + StrVer[2] + StrVer[3], 0);
  end;
end;

function TACBrDeRE.GerarNomeArqSchema(const ASchema: TSchemaDeRE): string;
var
  NomeSchema, ArqSchema: string;
  Versao: Double;
begin
  NomeSchema := NomeServicoToNomeSchema(SchemaDeREToStr(ASchema));
  ArqSchema := '';

  if NomeSchema <> '' then
  begin
    // O nome do XSD segue a versao do leiaute selecionada em Configuracoes.Geral.VersaoDF:
    // cada evento tem a sua propria versao dentro de cada ve10x (ver TSchemaDeREVersoes).
    if not SchemaDeREDisponivel(ASchema, Configuracoes.Geral.VersaoDF) then
      raise EACBrDFeException.CreateFmt(
        'O schema %s nao existe na versao %s do leiaute da DeRE.',
        [NomeSchema, VersaoDeREToStr(Configuracoes.Geral.VersaoDF)]);

    Versao := VersaoSchemaDeREToDbl(ASchema, Configuracoes.Geral.VersaoDF);

    AchaArquivoSchema(NomeSchema, Versao, ArqSchema);
  end;

  Result := ArqSchema;
end;

function TACBrDeRE.ObterToken: Boolean;
begin
  SetStatus(stDeREToken);
  try
    Result := WebServices.ObterToken.Executar;
  finally
    // Garante o retorno a Idle mesmo quando ha excecao antes do envio
    // (ex.: ClientId nao informado).
    SetStatus(stDeREIdle);
  end;
end;

function TACBrDeRE.EnviarLote: Boolean;
begin
  SetStatus(stDeRERecepcao);
  try
    Result := WebServices.Envia;
  finally
    SetStatus(stDeREIdle);
  end;
end;

function TACBrDeRE.ConsultarLote(const AProtocolo: string): Boolean;
begin
  SetStatus(stDeREConsulta);
  try
    Result := WebServices.Consulta(AProtocolo);
  finally
    SetStatus(stDeREIdle);
  end;
end;

function TACBrDeRE.LimparDados(const ANrInsc: string): Boolean;
begin
  SetStatus(stDeRELimpeza);
  try
    Result := WebServices.Limpa(ANrInsc);
  finally
    SetStatus(stDeREIdle);
  end;
end;

procedure TACBrDeRE.LerServicoDeParams(ALayOut: TLayOutDeRE; var Versao: Double;
  var URL: string);
var
  LSessao: string;
begin
  // taHomologacao representa a Producao Restrita da DeRE (DeRE_PR);
  // taProducao e a Producao (DeRE_P).
  if Configuracoes.WebServices.Ambiente = taHomologacao then
    LSessao := 'DeRE_PR'
  else
    LSessao := 'DeRE_P';

  Versao := VersaoDeREToDbl(Configuracoes.Geral.VersaoDF);
  URL := '';
  LerServicoChaveDeParams(LSessao, LayOutDeREToServico(ALayOut), Versao, URL);
end;

procedure TACBrDeRE.AssinarEventos;
begin
  Eventos.GerarXMLs;
  if Configuracoes.Geral.Salvar then
    Eventos.SaveToFiles;
end;

function TACBrDeRE.LerVersaoDeParams(ALayOut: TLayOutDeRE): string;
var
  Versao: Double;
  URL: string;
begin
  LerServicoDeParams(ALayOut, Versao, URL);
  Result := FloatToString(Versao, '.', '0.00');
end;

procedure TACBrDeRE.SetStatus(const stNewStatus: TStatusDeRE);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;
    if Assigned(OnStatusChange) then
      OnStatusChange(Self);
  end;
end;

function TACBrDeRE.GetNomeModeloDFe: string;
begin
  Result := 'DeRE';
end;

function TACBrDeRE.GetNameSpaceURI: string;
begin
  Result := ACBRDERE_NAMESPACE;
end;

end.
