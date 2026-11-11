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

unit ACBrNFeABIWebServices;

interface

uses
  Classes, SysUtils, synacode,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe,
  ACBrDFeWebService,
  ACBrDFeComum.Proc,
  ACBrNFeABI.Classes,
  ACBrNFeABI.Conversao,
  ACBrNFeABI.RetConsSit,
  ACBrNFeABI.EnvEvento,
  ACBrNFeABI.RetEnvEvento,
  ACBrNFeABINotasFiscais,
  ACBrNFeABIConfiguracoes;

type

  { TNFeABIWebService }

  TNFeABIWebService = class(TDFeWebService)
  private
  protected
    FPStatus: TStatusNFeABI;
    FPLayout: TLayOutNFeABI;
    FPConfiguracoesNFeABI: TConfiguracoesNFeABI;

  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: string; override;
    procedure FinalizarServico; override;

  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusNFeABI read FPStatus;
    property Layout: TLayOutNFeABI read FPLayout;
  end;

  { TNFeABIStatusServico }

  TNFeABIStatusServico = class(TNFeABIWebService)
  private
    Fversao: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FxMotivo: string;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FdhRetorno: TDateTime;
    FxObs: string;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarMsgErro(E: Exception): string; override;
  public
    procedure Clear; override;

    property versao: string read Fversao;
    property tpAmb: TACBrTipoAmbiente read FtpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: string read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property dhRetorno: TDateTime read FdhRetorno;
    property xObs: string read FxObs;
  end;

  { TNFeABIRecepcao }

  TNFeABIRecepcao = class(TNFeABIWebService)
  private
    FLote: string;
    FZipado: Boolean;
    FNotasFiscais: TNotasFiscais;
    Fversao: string;
    FTpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: string;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FProtocolo: string;
    FVersaoDF: TVersaoNFeABI;
    FMsgUnZip: string;

    FNFeABIRetornoSincrono: TRetConsSitNFeABI;

    function GetLote: string;
  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarPrefixoArquivo: string; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property versao: string read Fversao;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: string read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Protocolo: string read FProtocolo;

    property Lote: string read GetLote write FLote;
    property Zipado: Boolean read FZipado write FZipado;
    property MsgUnZip: string read FMsgUnZip write FMsgUnZip;
  end;

  { TNFeABIConsulta }

  TNFeABIConsulta = class(TNFeABIWebService)
  private
    FOwner: TACBrDFe;
    FNotasFiscais: TNotasFiscais;
    FNFeABIChave: string;
    FExtrairEventos: Boolean;
    FProtocolo: string;
    FDhRecbto: TDateTime;
    FXMotivo: string;
    Fversao: string;
    FTpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FcUF: Integer;
    FRetNFeABIDFe: string;

    FprotNFeABI: TProcDFe;
    FprocEventoNFeABI: TRetEventoNFeABICollection;
    FNFeABIRetorno: TRetConsSitNFeABI;

    procedure SetNFeABIChave(const AValue: string);
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function GerarUFSoap: string; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarPrefixoArquivo: string; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NFeABIChave: string read FNFeABIChave write SetNFeABIChave;
    property ExtrairEventos: Boolean read FExtrairEventos write FExtrairEventos;
    property Protocolo: string read FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto;
    property XMotivo: string read FXMotivo;
    property versao: string read Fversao;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property RetNFeABIDFe: string read FRetNFeABIDFe;

    property protNFeABI: TProcDFe read FprotNFeABI;
    property procEventoNFeABI: TRetEventoNFeABICollection read FprocEventoNFeABI;
  end;

  { TNFeABIEnvEvento }

  TNFeABIEnvEvento = class(TNFeABIWebService)
  private
    FidLote: Integer;
    FEvento: TEventoNFeABI;
    FcStat: Integer;
    FxMotivo: string;
    FTpAmb: TACBrTipoAmbiente;
    FCNPJ: string;

    FEventoRetorno: TRetEventoNFeABI;

    function GerarPathEvento(const ACNPJ: string = ''; const AIE: string = ''): string;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarPrefixoArquivo: string; override;
  public
    constructor Create(AOwner: TACBrDFe; AEvento: TEventoNFeABI);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property idLote: Integer read FidLote write FidLote;
    property cStat: Integer read FcStat;
    property xMotivo: string read FxMotivo;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;

    property EventoRetorno: TRetEventoNFeABI read FEventoRetorno;
  end;

 { TNFeABIEnvioWebService }

  TNFeABIEnvioWebService = class(TNFeABIWebService)
  private
    FXMLEnvio: string;
    FPURLEnvio: string;
    FVersao: string;
    FSoapActionEnvio: string;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgErro(E: Exception): string; override;
    function GerarVersaoDadosSoap: string; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property Versao: string read FVersao;
    property XMLEnvio: string read FXMLEnvio write FXMLEnvio;
    property URLEnvio: string read FPURLEnvio write FPURLEnvio;
    property SoapActionEnvio: string read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebServices }

  TWebServices = class
  private
    FACBrNFeABI: TACBrDFe;
    FStatusServico: TNFeABIStatusServico;
    FEnviar: TNFeABIRecepcao;
    FConsulta: TNFeABIConsulta;
    FEnvEvento: TNFeABIEnvEvento;
    FEnvioWebService: TNFeABIEnvioWebService;
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function Envia(const ALote: string; Zipado: Boolean = True): Boolean;

    property ACBrNFeABI: TACBrDFe read FACBrNFeABI write FACBrNFeABI;
    property StatusServico: TNFeABIStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFeABIRecepcao read FEnviar write FEnviar;
    property Consulta: TNFeABIConsulta read FConsulta write FConsulta;
    property EnvEvento: TNFeABIEnvEvento read FEnvEvento write FEnvEvento;
    property EnvioWebService: TNFeABIEnvioWebService read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
  StrUtils, Math,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.FilesIO,
  ACBrCompress,
  ACBrConsts,
  ACBrDFeUtil,
  ACBrDFeConsts,
  ACBrDFeComum.ConsStatServ,
  ACBrDFeComum.RetConsStatServ,
  ACBrNFeABI,
  ACBrNFeABI.Consts,
  ACBrNFeABI.ConsSit;

{ TNFeABIWebService }

constructor TNFeABIWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesNFeABI := TConfiguracoesNFeABI(FPConfiguracoes);
  FPLayout := LayNFeABIStatusServico;

  FPHeaderElement := '';
  FPBodyElement := 'nfeabiDadosMsg';
end;

procedure TNFeABIWebService.Clear;
begin
  inherited Clear;

  FPStatus := stNFeABIIdle;
  FPDFeOwner.SSL.UseCertificateHTTP := True;
end;

procedure TNFeABIWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }
  inherited InicializarServico;

  TACBrNFeABI(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TNFeABIWebService.DefinirURL;
var
  Versao: Double;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';

  TACBrNFeABI(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TNFeABIWebService.GerarVersaoDadosSoap: string;
begin
  { Sobrescrever apenas se necessário }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrNFeABI(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

procedure TNFeABIWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrNFeABI(FPDFeOwner).SetStatus(stNFeABIIdle);
end;

{ TNFeABIStatusServico }

procedure TNFeABIStatusServico.Clear;
begin
  inherited Clear;

  FPStatus := stNFeABIStatusServico;
  FPLayout := LayNFeABIStatusServico;
  FPArqEnv := 'ped-sta';
  FPArqResp := 'sta';

  Fversao := '';
  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FdhRecbto := 0;
  FTMed := 0;
  FdhRetorno := 0;
  FxObs := '';

  if Assigned(FPConfiguracoesNFeABI) then
  begin
    FtpAmb := TACBrTipoAmbiente(FPConfiguracoesNFeABI.WebServices.Ambiente);
    FcUF := FPConfiguracoesNFeABI.WebServices.UFCodigo;
  end
end;

procedure TNFeABIStatusServico.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFeABIStatusServico';
  FPSoapAction := FPServico + '/NFeABIStatusServico';
end;

procedure TNFeABIStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.Create(FPVersaoServico, NAME_SPACE_NFeABI, 'NFeABI', True);
  try
    ConsStatServ.TpAmb := FPConfiguracoesNFeABI.WebServices.Ambiente;
    ConsStatServ.CUF := FPConfiguracoesNFeABI.WebServices.UFCodigo;

    FPDadosMsg := ConsStatServ.GerarXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TNFeABIStatusServico.TratarResposta: Boolean;
var
  NFeABIRetorno: TRetConsStatServ;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'NFeABIStatusServicoResult');

  NFeABIRetorno := TRetConsStatServ.Create('NFeABI');
  try
    NFeABIRetorno.XmlRetorno := ParseText(FPRetWS);
    NFeABIRetorno.LerXml;

    Fversao := NFeABIRetorno.versao;
    FtpAmb := NFeABIRetorno.tpAmb;
    FverAplic := NFeABIRetorno.verAplic;
    FcStat := NFeABIRetorno.cStat;
    FxMotivo := NFeABIRetorno.xMotivo;
    FcUF := NFeABIRetorno.cUF;
    FdhRecbto := NFeABIRetorno.dhRecbto;
    FTMed := NFeABIRetorno.TMed;
    FdhRetorno := NFeABIRetorno.dhRetorno;
    FxObs := NFeABIRetorno.xObs;
    FPMsg := FxMotivo + sLineBreak + FxObs;

    if FPConfiguracoesNFeABI.WebServices.AjustaAguardaConsultaRet then
      FPConfiguracoesNFeABI.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);
  finally
    NFeABIRetorno.Free;
  end;
end;

function TNFeABIStatusServico.GerarMsgLog: string;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                           'Ambiente: %s' + sLineBreak +
                           'Versão Aplicativo: %s ' + sLineBreak +
                           'Status Código: %s' + sLineBreak +
                           'Status Descrição: %s' + sLineBreak +
                           'UF: %s' + sLineBreak +
                           'Recebimento: %s' + sLineBreak +
                           'Tempo Médio: %s' + sLineBreak +
                           'Retorno: %s' + sLineBreak +
                           'Observação: %s' + sLineBreak),
                   [Fversao, TipoAmbienteToStr(FtpAmb), FverAplic, IntToStr(FcStat),
                    FxMotivo, CodigoUFParaUF(FcUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    IntToStr(FTMed),
                    IfThen(FdhRetorno = 0, '', FormatDateTimeBr(FdhRetorno)),
                    FxObs]);
end;

function TNFeABIStatusServico.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService Consulta Status serviço:' + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TNFeABIRecepcao }

constructor TNFeABIRecepcao.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;

  FZipado := True;
end;

destructor TNFeABIRecepcao.Destroy;
begin
  FNFeABIRetornoSincrono.Free;

  inherited Destroy;
end;

procedure TNFeABIRecepcao.Clear;
begin
  inherited Clear;

  FPStatus := stNFeABIAutorizacao;
  FPLayout := LayNFeABIAutorizacao;
  FPArqEnv := 'env-lot';
  FPArqResp := 'rec';

  Fversao    := '';
  FTMed      := 0;
  FverAplic  := '';
  FcStat     := 0;
  FxMotivo   := '';
  FdhRecbto  := 0;
  FProtocolo := '';

  if Assigned(FPConfiguracoesNFeABI) then
  begin
    FtpAmb := FPConfiguracoesNFeABI.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFeABI.WebServices.UFCodigo;
  end;

  if Assigned(FNFeABIRetornoSincrono) then
    FNFeABIRetornoSincrono.Free;

  FNFeABIRetornoSincrono := TRetConsSitNFeABI.Create;
end;

function TNFeABIRecepcao.GetLote: string;
begin
  Result := Trim(FLote);
end;

procedure TNFeABIRecepcao.InicializarServico;
//var
//  ok: Boolean;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFeABI ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFeABI({ok,} FNotasFiscais.Items[0].NFeABI.infNFeABI.Versao)
  else
    FVersaoDF := FPConfiguracoesNFeABI.Geral.VersaoDF;

  inherited InicializarServico;
end;

procedure TNFeABIRecepcao.DefinirURL;
var
  Modelo: string;
  VerServ: Double;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFeABI ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFeABI.Ide.cUF;

    if Integer(FPConfiguracoesNFeABI.WebServices.Ambiente) <> Integer(FNotasFiscais.Items[0].NFeABI.Ide.tpAmb) then
      raise EACBrNFeABIException.Create( ACBRNFeABI_CErroAmbDiferente );
  end
  else
  begin                              // Se não tem NFeABI, use as configurações do componente
    FcUF := FPConfiguracoesNFeABI.WebServices.UFCodigo;
  end;

  FPLayout := LayNFeABIAutorizacao;

  VerServ := VersaoNFeABIToDbl(FVersaoDF);
  Modelo := 'NFeABI';
  FTpAmb := FPConfiguracoesNFeABI.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  TACBrNFeABI(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CodigoUFparaUF(FcUF),
    FTpAmb,
    LayOutNFeABIToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFeABIRecepcao.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFeABIAutorizacao';

  if Zipado then
  begin
    FPBodyElement := 'nfeabiDadosMsgZip';
    FPSoapAction := FPServico + '/nfeabiAutorizacaoZip';
  end
  else
  begin
    FPBodyElement := 'nfeabiDadosMsg';
    FPSoapAction := FPServico + '/nfeabiAutorizacao';
  end;
end;

procedure TNFeABIRecepcao.DefinirDadosMsg;
begin
  if FNotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de DC-e transmitidos (máximo de 1 DC-e)' +
           ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  if FNotasFiscais.Count > 0 then
    FPDadosMsg := '<NFeABI' +
      RetornarConteudoEntre(FNotasFiscais.Items[0].XMLAssinado, '<NFeABI', '</NFeABI>') +
      '</NFeABI>';

  FMsgUnZip := FPDadosMsg;

  if Zipado then
    FPDadosMsg := EncodeBase64(GZipCompress(FMsgUnZip));

  // FPDadosMsg tem mais de 1024kb ? //
  if Length(FPDadosMsg) > (1024 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 1024 Kbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));
end;

function TNFeABIRecepcao.TratarResposta: Boolean;
var
  I: integer;
  chNFeABI, AXML, NomeXMLSalvo: string;
  AProcNFeABI: TProcDFe;
  SalvarXML: Boolean;
begin
  FPRetWS := SeparaDadosArray(['NFeABIAutorizacaoResult'], FPRetornoWS );

  if pos('retNFeABI', FPRetWS) > 0 then
    AXML := StringReplace(FPRetWS, 'retNFeABI', 'retConsSitNFeABI',
                                   [rfReplaceAll, rfIgnoreCase])
  else
    AXML := FPRetWS;

  FNFeABIRetornoSincrono.XmlRetorno := ParseText(AXML);
  FNFeABIRetornoSincrono.LerXml;

  Fversao := FNFeABIRetornoSincrono.versao;
  FTpAmb := FNFeABIRetornoSincrono.TpAmb;
  FverAplic := FNFeABIRetornoSincrono.verAplic;

  FcUF := FNFeABIRetornoSincrono.cUF;
  chNFeABI := FNFeABIRetornoSincrono.ProtNFeABI.chDFe;

  if (FNFeABIRetornoSincrono.protNFeABI.cStat > 0) then
    FcStat := FNFeABIRetornoSincrono.protNFeABI.cStat
  else
    FcStat := FNFeABIRetornoSincrono.cStat;

  if (FNFeABIRetornoSincrono.protNFeABI.xMotivo <> '') then
  begin
    FPMsg := FNFeABIRetornoSincrono.protNFeABI.xMotivo;
    FxMotivo := FNFeABIRetornoSincrono.protNFeABI.xMotivo;
  end
  else
  begin
    FPMsg := FNFeABIRetornoSincrono.xMotivo;
    FxMotivo := FNFeABIRetornoSincrono.xMotivo;
  end;

  // Verificar se a DC-e foi autorizado com sucesso
  Result := (FNFeABIRetornoSincrono.cStat = 100) and
    (TACBrNFeABI(FPDFeOwner).CstatProcessado(FNFeABIRetornoSincrono.protNFeABI.cStat));

  if Result then
  begin
    // Pega o numero do protocolo
    FProtocolo := FNFeABIRetornoSincrono.protNFeABI.nProt;

    for I := 0 to TACBrNFeABI(FPDFeOwner).NotasFiscais.Count - 1 do
    begin
      with TACBrNFeABI(FPDFeOwner).NotasFiscais.Items[I] do
      begin
        if RemoverLiteralChave(chNFeABI) = NumID then
        begin

          if (FPConfiguracoesNFeABI.Geral.ValidarDigest) and
             (FNFeABIRetornoSincrono.protNFeABI.digVal <> '') and
             (NFeABI.signature.DigestValue <> FNFeABIRetornoSincrono.protNFeABI.digVal) then
          begin
            raise EACBrNFeABIException.Create('DigestValue do documento ' + NumID + ' não confere.');
          end;

          NFeABI.procNFeABI.cStat := FNFeABIRetornoSincrono.protNFeABI.cStat;
          NFeABI.procNFeABI.tpAmb := FNFeABIRetornoSincrono.tpAmb;
          NFeABI.procNFeABI.verAplic := FNFeABIRetornoSincrono.verAplic;
          NFeABI.procNFeABI.chDFe := FNFeABIRetornoSincrono.protNFeABI.chDFe;
          NFeABI.procNFeABI.dhRecbto := FNFeABIRetornoSincrono.protNFeABI.dhRecbto;
          NFeABI.procNFeABI.nProt := FNFeABIRetornoSincrono.protNFeABI.nProt;
          NFeABI.procNFeABI.digVal := FNFeABIRetornoSincrono.protNFeABI.digVal;
          NFeABI.procNFeABI.xMotivo := FNFeABIRetornoSincrono.protNFeABI.xMotivo;

          AProcNFeABI := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFeABI, 'nfeabiProc', 'NFeABI');
          try
            // Processando em UTF8, para poder gravar arquivo corretamente //
            AProcNFeABI.XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
            AProcNFeABI.XML_Prot := FNFeABIRetornoSincrono.XMLprotNFeABI;
            XMLOriginal := AProcNFeABI.GerarXML;

            if FPConfiguracoesNFeABI.Arquivos.Salvar then
            begin
              SalvarXML := (not FPConfiguracoesNFeABI.Arquivos.SalvarApenasNFeABIProcessados) or
                           Processado;

              // Salva o XML do DC-e assinado e protocolado
              if SalvarXML then
              begin
                NomeXMLSalvo := '';
                if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                begin
                  FPDFeOwner.Gravar( NomeArq, XMLOriginal ); // Atualiza o XML carregado
                  NomeXMLSalvo := NomeArq;
                end;

                if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                  GravarXML; // Salva na pasta baseado nas configurações do PathNFeABI
              end;
            end ;
          finally
            AProcNFeABI.Free;
          end;

          Break;
        end;
      end;
    end;
  end;
end;

function TNFeABIRecepcao.GerarMsgLog: string;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                         'Ambiente: %s ' + sLineBreak +
                         'Versão Aplicativo: %s ' + sLineBreak +
                         'Status Código: %s ' + sLineBreak +
                         'Status Descrição: %s ' + sLineBreak +
                         'UF: %s ' + sLineBreak +
                         'dhRecbto: %s ' + sLineBreak +
                         'chNFeABI: %s ' + sLineBreak),
                   [FNFeABIRetornoSincrono.versao,
                    TipoAmbienteToStr(FNFeABIRetornoSincrono.TpAmb),
                    FNFeABIRetornoSincrono.verAplic,
                    IntToStr(FNFeABIRetornoSincrono.cStat),
                    FNFeABIRetornoSincrono.xMotivo,
                    CodigoUFParaUF(FNFeABIRetornoSincrono.cUF),
                    FormatDateTimeBr(FNFeABIRetornoSincrono.protNFeABI.dhRecbto),
                    FNFeABIRetornoSincrono.chNFeABI])
end;

function TNFeABIRecepcao.GerarPrefixoArquivo: string;
begin
  Result := Lote;
  FPArqResp := 'pro-lot';
end;

{ TNFeABIConsulta }

constructor TNFeABIConsulta.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
  FNotasFiscais := ANotasFiscais;

  if Assigned(FNFeABIRetorno) then
    FNFeABIRetorno.Free;
end;

destructor TNFeABIConsulta.Destroy;
begin
  FprotNFeABI.Free;
  FprocEventoNFeABI.Free;

  inherited Destroy;
end;

procedure TNFeABIConsulta.Clear;
begin
  inherited Clear;

  FPStatus := stNFeABIConsulta;
  FPLayout := LayNFeABIConsulta;
  FPArqEnv := 'ped-sit';
  FPArqResp := 'sit';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FProtocolo := '';
  FDhRecbto := 0;
  Fversao := '';
  FRetNFeABIDFe := '';

  if Assigned(FPConfiguracoesNFeABI) then
  begin
    FtpAmb := TACBrTipoAmbiente(FPConfiguracoesNFeABI.WebServices.Ambiente);
    FcUF := FPConfiguracoesNFeABI.WebServices.UFCodigo;
  end;

  if Assigned(FprotNFeABI) then
    FprotNFeABI.Free;

  if Assigned(FprocEventoNFeABI) then
    FprocEventoNFeABI.Free;

  FprotNFeABI       := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFeABI, 'NFeABIProc', 'NFeABI');
  FprocEventoNFeABI := TRetEventoNFeABICollection.Create;
end;

procedure TNFeABIConsulta.SetNFeABIChave(const AValue: string);
var
  NumChave: string;
begin
  if FNFeABIChave = AValue then Exit;

  NumChave := RemoverLiteralChave(AValue);

  if not ValidarChave(NumChave) then
    raise EACBrNFeABIException.Create(Format('Chave "%s" inválida.',[AValue]));

  FNFeABIChave := NumChave;
end;

procedure TNFeABIConsulta.DefinirURL;
var
  VerServ: Double;
  Modelo: string;
  Ambiente: TACBrTipoAmbiente;
begin
  FPVersaoServico := '';
  FPURL   := '';
  Modelo  := 'NFeABI';
  FcUF    := ExtrairUFChaveAcesso(FNFeABIChave);
  VerServ := VersaoNFeABIToDbl(FPConfiguracoesNFeABI.Geral.VersaoDF);

  if FNotasFiscais.Count > 0 then
    Ambiente := FNotasFiscais.Items[0].NFeABI.Ide.tpAmb
  else
    Ambiente := FPConfiguracoesNFeABI.WebServices.Ambiente;

  TACBrNFeABI(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CodigoUFparaUF(FcUF),
    Ambiente,
    LayOutNFeABIToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFeABIConsulta.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFeABIConsulta';
  FPSoapAction := FPServico + '/nfeabiConsulta';
end;

procedure TNFeABIConsulta.DefinirDadosMsg;
var
  ConsSitNFeABI: TConsSitNFeABI;
begin
  ConsSitNFeABI := TConsSitNFeABI.Create;
  try
    ConsSitNFeABI.TpAmb := TpAmb;
    ConsSitNFeABI.chNFeABI := FNFeABIChave;
    ConsSitNFeABI.Versao := FPVersaoServico;

    FPDadosMsg := ConsSitNFeABI.GerarXML;
  finally
    ConsSitNFeABI.Free;
  end;
end;

function TNFeABIConsulta.GerarUFSoap: string;
begin
  Result := '<cUF>' + IntToStr(FcUF) + '</cUF>';
end;

function TNFeABIConsulta.TratarResposta: Boolean;

procedure SalvarEventos(Retorno: string);
var
  aEvento, aProcEvento, aIDEvento, sPathEvento, sCNPJCPF: string;
  DhEvt: TDateTime;
  Inicio, Fim: Integer;
  TipoEvento: TACBrTipoEvento;
  Ok: Boolean;
begin
  while Retorno <> '' do
  begin
    Inicio := Pos('<procEventoNFeABI', Retorno);
    Fim    := Pos('</procEventoNFeABI>', Retorno) + 15;

    aEvento := Copy(Retorno, Inicio, Fim - Inicio + 1);

    Retorno := Copy(Retorno, Fim + 1, Length(Retorno));

    aProcEvento := '<procEventoNFeABI versao="' + FVersao + '" ' + NAME_SPACE_NFeABI + '>' +
                      SeparaDados(aEvento, 'procEventoNFeABI') +
                   '</procEventoNFeABI>';

    Inicio := Pos('Id=', aProcEvento) + 6;
    Fim    := 52;

    if Inicio = 6 then
      aIDEvento := FormatDateTime('yyyymmddhhnnss', Now)
    else
      aIDEvento := Copy(aProcEvento, Inicio, Fim);

    TipoEvento  := StrToTpEventoNFeABI(Ok, SeparaDados(aEvento, 'tpEvento'));
    DhEvt       := EncodeDataHora(SeparaDados(aEvento, 'dhEvento'), 'YYYY-MM-DD');
    sCNPJCPF    := SeparaDados(aEvento, 'CNPJ');

    if EstaVazio(sCNPJCPF) then
      sCNPJCPF := SeparaDados(aEvento, 'CPF');

    sPathEvento := PathWithDelim(FPConfiguracoesNFeABI.Arquivos.GetPathEvento(TipoEvento, sCNPJCPF, '', DhEvt));

    if FPConfiguracoesNFeABI.Arquivos.SalvarEvento and (aProcEvento <> '') then
      FPDFeOwner.Gravar( aIDEvento + '-procEventoNFeABI.xml', aProcEvento, sPathEvento);
  end;
end;

var
//  NFeABIRetorno: TRetConsSitNFeABI;
  SalvarXML, NFeABICancelado, Atualiza: Boolean;
  aEventos, sPathNFeABI, NomeXMLSalvo: string;
  AProcNFeABI: TProcDFe;
  I, Inicio, Fim: Integer;
  dhEmissao: TDateTime;
begin
  FNFeABIRetorno := TRetConsSitNFeABI.Create;

  try
    FPRetWS := SeparaDados(FPRetornoWS, 'nfeabiConsultaServicoResult');

    FNFeABIRetorno.XmlRetorno := ParseText(FPRetWS);
    FNFeABIRetorno.LerXML;

    NFeABICancelado := False;
    aEventos := '';

    // <retConsSitNFeABI> - Retorno da consulta da situação da DC-e
    // Este é o status oficial da DC-e
    Fversao := FNFeABIRetorno.versao;
    FTpAmb := FNFeABIRetorno.tpAmb;
    FverAplic := FNFeABIRetorno.verAplic;
    FcStat := FNFeABIRetorno.cStat;
    FXMotivo := FNFeABIRetorno.xMotivo;
    FcUF := FNFeABIRetorno.cUF;
    FNFeABIChave := FNFeABIRetorno.chNFeABI;
    FPMsg := FXMotivo;

    // <protNFeABI> - Retorno dos dados do ENVIO da DC-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFeABI.PathDFe            := FNFeABIRetorno.protNFeABI.PathDFe;
    FprotNFeABI.PathRetConsReciDFe := FNFeABIRetorno.protNFeABI.PathRetConsReciDFe;
    FprotNFeABI.PathRetConsSitDFe  := FNFeABIRetorno.protNFeABI.PathRetConsSitDFe;
    FprotNFeABI.tpAmb              := FNFeABIRetorno.protNFeABI.tpAmb;
    FprotNFeABI.verAplic           := FNFeABIRetorno.protNFeABI.verAplic;
    FprotNFeABI.chDFe              := FNFeABIRetorno.protNFeABI.chDFe;
    FprotNFeABI.dhRecbto           := FNFeABIRetorno.protNFeABI.dhRecbto;
    FprotNFeABI.nProt              := FNFeABIRetorno.protNFeABI.nProt;
    FprotNFeABI.digVal             := FNFeABIRetorno.protNFeABI.digVal;
    FprotNFeABI.cStat              := FNFeABIRetorno.protNFeABI.cStat;
    FprotNFeABI.xMotivo            := FNFeABIRetorno.protNFeABI.xMotivo;

    if Assigned(FNFeABIRetorno.procEventoNFeABI) and (FNFeABIRetorno.procEventoNFeABI.Count > 0) then
    begin
      aEventos := '=====================================================' +
        sLineBreak + '================== Eventos da DC-e ==================' +
        sLineBreak + '=====================================================' +
        sLineBreak + '' + sLineBreak + 'Quantidade total de eventos: ' +
        IntToStr(FNFeABIRetorno.procEventoNFeABI.Count);

      FprocEventoNFeABI.Clear;
      for I := 0 to FNFeABIRetorno.procEventoNFeABI.Count - 1 do
      begin
        with FprocEventoNFeABI.New.RetEventoNFeABI do
        begin
          idLote := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.idLote;
          tpAmb := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.tpAmb;
          verAplic := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.verAplic;
          cOrgao := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.cOrgao;
          cStat := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.cStat;
          xMotivo := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.xMotivo;
          XML := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.XML;

          Infevento.ID              := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.ID;
          Infevento.tpAmb           := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.tpAmb;
          InfEvento.CNPJCPF         := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.CNPJCPF;
          InfEvento.chNFeABI          := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.chNFeABI;
          InfEvento.dhEvento        := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.dhEvento;
          InfEvento.TpEvento        := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.TpEvento;
          InfEvento.nSeqEvento      := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.nSeqEvento;
//          InfEvento.VersaoEvento    := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.VersaoEvento;
          InfEvento.DetEvento.nProt := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.nProt;
          InfEvento.DetEvento.xJust := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.xJust;
          {
          InfEvento.DetEvento.xNome := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.xNome;
          InfEvento.DetEvento.CPF   := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.CPF;
          InfEvento.DetEvento.cUF   := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.cUF;
          InfEvento.DetEvento.cMun  := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.cMun;
          InfEvento.DetEvento.dtEnc := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.InfEvento.DetEvento.dtEnc;
          }
          {
          retEvento.Clear;
          for J := 0 to FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Count-1 do
          begin
            with retEvento.New.RetInfEvento do
            begin
              Id          := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.Id;
              tpAmb       := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.tpAmb;
              verAplic    := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.verAplic;
              cOrgao      := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.cOrgao;
              cStat       := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.cStat;
              xMotivo     := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.xMotivo;
              chNFeABI       := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.chNFeABI;
              tpEvento    := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.tpEvento;
              xEvento     := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.xEvento;
              nSeqEvento  := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.nSeqEvento;
              CNPJDest    := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.CNPJDest;
              emailDest   := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.emailDest;
              dhRegEvento := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.dhRegEvento;
              nProt       := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.nProt;
              XML         := FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI.retEvento.Items[j].RetInfEvento.XML;
            end;
          end;
          }
        end;

        with FNFeABIRetorno.procEventoNFeABI.Items[I].RetEventoNFeABI do
        begin
        {
          for j := 0 to retEvento.Count -1 do
          begin
            aEventos := aEventos + sLineBreak + sLineBreak +
              Format(ACBrStr('Número de sequência: %s ' + sLineBreak +
                             'Código do evento: %s ' + sLineBreak +
                             'Descrição do evento: %s ' + sLineBreak +
                             'Status do evento: %s ' + sLineBreak +
                             'Descrição do status: %s ' + sLineBreak +
                             'Protocolo: %s ' + sLineBreak +
                             'Data/Hora do registro: %s '),
                     [IntToStr(InfEvento.nSeqEvento),
                      TpEventoToStr(InfEvento.TpEvento),
                      InfEvento.DescEvento,
                      IntToStr(retEvento.Items[J].RetInfEvento.cStat),
                      retEvento.Items[J].RetInfEvento.xMotivo,
                      retEvento.Items[J].RetInfEvento.nProt,
                      FormatDateTimeBr(retEvento.Items[J].RetInfEvento.dhRegEvento)]);

            if retEvento.Items[J].RetInfEvento.tpEvento = teCancelamento then
            begin
              NFeABICancelado := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;

            if retEvento.Items[J].RetInfEvento.tpEvento = teEncerramento then
            begin
              NFeABIncerrado := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;
          end;
          }
        end;
      end;
    end;

    if (not NFeABICancelado) and (NaoEstaVazio(FNFeABIRetorno.protNFeABI.nProt))  then
    begin
      FProtocolo := FNFeABIRetorno.protNFeABI.nProt;
      FDhRecbto := FNFeABIRetorno.protNFeABI.dhRecbto;
      FPMsg := FNFeABIRetorno.protNFeABI.xMotivo;
    end;

    if Result then
    begin
      if TACBrNFeABI(FPDFeOwner).NotasFiscais.Count > 0 then
      begin
        for i := 0 to TACBrNFeABI(FPDFeOwner).NotasFiscais.Count - 1 do
        begin
          with TACBrNFeABI(FPDFeOwner).NotasFiscais.Items[i] do
          begin
            if (Copy(FNFeABIChave, 4, Length(FNFeABIChave)) = NumID) then
            begin
              Atualiza := (NaoEstaVazio(FNFeABIRetorno.XMLprotNFeABI));

              if Atualiza and
                 TACBrNFeABI(FPDFeOwner).cStatCancelado(FNFeABIRetorno.cStat) then
                Atualiza := False;

              if (FPConfiguracoesNFeABI.Geral.ValidarDigest) and
                 (FNFeABIRetorno.protNFeABI.digVal <> '') and (NFeABI.signature.DigestValue <> '') and
                 (UpperCase(NFeABI.signature.DigestValue) <> UpperCase(FNFeABIRetorno.protNFeABI.digVal)) then
              begin
                raise EACBrNFeABIException.Create('DigestValue do documento ' +
                    NumID + ' não confere.');
              end;

              // Atualiza o Status da NFeABI interna //
              NFeABI.procNFeABI.cStat := FNFeABIRetorno.cStat;

              if Atualiza then
              begin
                NFeABI.procNFeABI.tpAmb := FNFeABIRetorno.tpAmb;
                NFeABI.procNFeABI.verAplic := FNFeABIRetorno.verAplic;
                NFeABI.procNFeABI.chDFe := FNFeABIRetorno.chNFeABI;
                NFeABI.procNFeABI.dhRecbto := FDhRecbto;
                NFeABI.procNFeABI.nProt := FProtocolo;
                NFeABI.procNFeABI.digVal := FNFeABIRetorno.protNFeABI.digVal;
                NFeABI.procNFeABI.cStat := FNFeABIRetorno.cStat;
                NFeABI.procNFeABI.xMotivo := FNFeABIRetorno.xMotivo;

                AProcNFeABI := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFeABI, 'NFeABIProc', 'NFeABI');
                try
                  AProcNFeABI.XML_DFe := RemoverDeclaracaoXML(XMLOriginal);
                  AProcNFeABI.XML_Prot := FNFeABIRetorno.XMLprotNFeABI;
                  XMLOriginal := AProcNFeABI.GerarXML;

                  FRetNFeABIDFe := '';

                  if (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFeABI'))) then
                  begin
                    Inicio := Pos('<procEventoNFeABI', FPRetWS);
                    Fim    := Pos('</retConsSitNFeABI', FPRetWS) -1;

                    aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

                    FRetNFeABIDFe := '<NFeABIDFe>' +
                                    '<procNFeABI versao="' + FVersao + '">' +
                                      SeparaDados(XMLOriginal, 'NFeABIProc') +
                                    '</procNFeABI>' +
                                    '<procEventoNFeABI versao="' + FVersao + '">' +
                                      aEventos +
                                    '</procEventoNFeABI>' +
                                   '</NFeABIDFe>';

                  end;
                finally
                  AProcNFeABI.Free;
                end;

                SalvarXML := Result and
                           FPConfiguracoesNFeABI.Arquivos.Salvar and
                           ((not FPConfiguracoesNFeABI.Arquivos.SalvarApenasNFeABIProcessados) or
                             Processado);

                if SalvarXML then
                begin
                  if FPConfiguracoesNFeABI.Arquivos.EmissaoPathNFeABI then
                    dhEmissao := NFeABI.Ide.dhEmi
                  else
                    dhEmissao := Now;

                  sPathNFeABI := PathWithDelim(FPConfiguracoesNFeABI.Arquivos.GetPathNFeABI(dhEmissao, NFeABI.Emit.CNPJCPF, ''));

                  if (FRetNFeABIDFe <> '') then
                    FPDFeOwner.Gravar( FNFeABIChave + '-NFeABIDFe.xml', FRetNFeABIDFe, sPathNFeABI);

                  // Salva o XML do DC-e assinado e protocolado
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal );  // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  // Salva na pasta baseado nas configurações do PathCTe
                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML;

                  // Salva o XML de eventos retornados ao consultar um DC-e
                  if ExtrairEventos then
                    SalvarEventos(aEventos);
                end;
              end;

              break;
            end;
          end;
        end;
      end
      else
      begin
        if ExtrairEventos and FPConfiguracoesNFeABI.Arquivos.SalvarEvento and
           (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFeABI'))) then
        begin
          Inicio := Pos('<procEventoNFeABI', FPRetWS);
          Fim    := Pos('</retConsSitNFeABI', FPRetWS) -1;

          aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

          // Salva o XML de eventos retornados ao consultar um DC-e
          SalvarEventos(aEventos);
        end;
      end;
    end;
  finally
    Result := True;
    FNFeABIRetorno.Free;
  end;
end;

function TNFeABIConsulta.GerarMsgLog: string;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                           'Identificador: %s ' + sLineBreak +
                           'Ambiente: %s ' + sLineBreak +
                           'Versão Aplicativo: %s ' + sLineBreak +
                           'Status Código: %s ' + sLineBreak +
                           'Status Descrição: %s ' + sLineBreak +
                           'UF: %s ' + sLineBreak +
                           'Chave Acesso: %s ' + sLineBreak +
                           'Recebimento: %s ' + sLineBreak +
                           'Protocolo: %s ' + sLineBreak +
                           'Digest Value: %s ' + sLineBreak),
                   [Fversao, FNFeABIChave, TipoAmbienteToStr(FTpAmb), FverAplic,
                    IntToStr(FcStat), FXMotivo, CodigoUFParaUF(FcUF), FNFeABIChave,
                    FormatDateTimeBr(FDhRecbto), FProtocolo, FprotNFeABI.digVal]);
end;

function TNFeABIConsulta.GerarPrefixoArquivo: string;
begin
  Result := Trim(FNFeABIChave);
end;

{ TNFeABIEnvEvento }

constructor TNFeABIEnvEvento.Create(AOwner: TACBrDFe; AEvento: TEventoNFeABI);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TNFeABIEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  inherited;
end;

procedure TNFeABIEnvEvento.Clear;
begin
  inherited Clear;

  FPStatus := stNFeABIEvento;
  FPLayout := LayNFeABIEvento;
  FPArqEnv := 'ped-eve';
  FPArqResp := 'eve';

  FcStat   := 0;
  FxMotivo := '';
  FCNPJ := '';

  if Assigned(FPConfiguracoesNFeABI) then
    FtpAmb := TACBrTipoAmbiente(FPConfiguracoesNFeABI.WebServices.Ambiente);

  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  FEventoRetorno := TRetEventoNFeABI.Create;
end;

function TNFeABIEnvEvento.GerarPathEvento(const ACNPJ, AIE: string): string;
begin
  with FEvento.Evento.Items[0].InfEvento do
  begin
    Result := FPConfiguracoesNFeABI.Arquivos.GetPathEvento(tpEvento, ACNPJ, AIE);
  end;
end;

procedure TNFeABIEnvEvento.DefinirURL;
var
  UF, Modelo : string;
  VerServ: Double;
begin
  VerServ := VersaoNFeABIToDbl(FPConfiguracoesNFeABI.Geral.VersaoDF);
  FCNPJ   := FEvento.Evento.Items[0].InfEvento.CNPJCPF;
  FTpAmb  := FEvento.Evento.Items[0].InfEvento.tpAmb;
  Modelo  := 'NFeABI';
  UF      := CodigoUFparaUF(ExtrairUFChaveAcesso(FEvento.Evento.Items[0].InfEvento.chNFeABI));

  FPLayout := LayNFeABIEvento;

  FPURL := '';

  TACBrNFeABI(FPDFeOwner).LerServicoDeParams(
    Modelo,
    UF,
    FTpAmb,
    LayOutNFeABIToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFeABIEnvEvento.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFeABIRecepcaoEvento';
  FPSoapAction := FPServico + '/nfeabiRecepcaoEvento';
end;

procedure TNFeABIEnvEvento.DefinirDadosMsg;
var
  EventoNFeABI: TEventoNFeABI;
  I, F: Integer;
  Evento, Eventos, EventosAssinados, AXMLEvento: AnsiString;
  FErroValidacao: string;
  EventoEhValido: Boolean;
  SchemaEventoNFeABI: TSchemaNFeABI;
begin
  EventoNFeABI := TEventoNFeABI.Create;
  try
    EventoNFeABI.idLote := FidLote;
    SchemaEventoNFeABI := schErroNFeABI;

    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      with EventoNFeABI.Evento.New do
      begin
        infEvento.tpAmb := FTpAmb;
//        infEvento.tpEmit := FEvento.Evento[i].InfEvento.tpEmit;
        infEvento.CNPJCPF := FEvento.Evento[i].InfEvento.CNPJCPF;
        infEvento.CNPJCPFEmit := FEvento.Evento[i].InfEvento.CNPJCPFEmit;
        infEvento.IdOutrosEmit := FEvento.Evento[i].InfEvento.IdOutrosEmit;
        infEvento.chNFeABI := FEvento.Evento[i].InfEvento.chNFeABI;
        infEvento.dhEvento := FEvento.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento := FEvento.Evento[i].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[i].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
          begin
            SchemaEventoNFeABI := schevCancNFeABI;
            infEvento.detEvento.nProt := FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := FEvento.Evento[i].InfEvento.detEvento.xJust;
          end;
        end;
      end;
    end;

    EventoNFeABI.Versao := FPVersaoServico;
    AjustarOpcoes(EventoNFeABI.Opcoes);

    EventoNFeABI.GerarXML;

    Eventos := NativeStringToUTF8(EventoNFeABI.XmlEnvio);
    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos('</eventoNFeABI>', Eventos);

      if F > 0 then
      begin
        Evento := Copy(Eventos, 1, F + 12);
        Eventos := Copy(Eventos, F + 13, length(Eventos));

        AssinarXML(Evento, 'eventoNFeABI', 'infEvento', 'Falha ao assinar o Envio de Evento ');
        EventosAssinados := EventosAssinados + FPDadosMsg;
      end
      else
        Break;
    end;

    // Separa o XML especifico do Evento para ser Validado.
    AXMLEvento := SeparaDados(FPDadosMsg, 'detEvento');

    case SchemaEventoNFeABI of
      schevCancNFeABI:
        begin
          AXMLEvento := '<evCancNFeABI xmlns="' + ACBRNFeABI_NAMESPACE + '">' +
                          Trim(RetornarConteudoEntre(AXMLEvento, '<evCancNFeABI>', '</evCancNFeABI>')) +
                        '</evCancNFeABI>';
        end;
    else
      AXMLEvento := '';
    end;

    AXMLEvento := '<' + ENCODING_UTF8 + '>' + AXMLEvento;

    with TACBrNFeABI(FPDFeOwner) do
    begin
      EventoEhValido := SSL.Validar(FPDadosMsg,
                                    GerarNomeArqSchema(FPLayout,
                                                       StringToFloatDef(FPVersaoServico, 0)),
                                    FPMsg) and
                        SSL.Validar(AXMLEvento,
                                    GerarNomeArqSchemaEvento(SchemaEventoNFeABI,
                                                             StringToFloatDef(FPVersaoServico, 0)),
                                    FPMsg);
    end;

    if not EventoEhValido then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados do Evento: ') +
        FPMsg;

      raise EACBrNFeABIException.CreateDef(FErroValidacao);
    end;

    for I := 0 to FEvento.Evento.Count - 1 do
      FEvento.Evento[I].InfEvento.id := EventoNFeABI.Evento[I].InfEvento.id;
  finally
    EventoNFeABI.Free;
  end;
end;

function TNFeABIEnvEvento.TratarResposta: Boolean;
var
  PedEvento, RetEvento, NomeArq, PathArq, VersaoEvento, Texto: string;
begin
  FEvento.idLote := idLote;

  FPRetWS := SeparaDados(FPRetornoWS, 'nfeabiRecepcaoEventoResult');

  EventoRetorno.XmlRetorno := ParseText(FPRetWS);
  EventoRetorno.LerXml;

  FcStat := EventoRetorno.cStat;
  FxMotivo := EventoRetorno.xMotivo;
  FPMsg := EventoRetorno.xMotivo;
  FTpAmb := EventoRetorno.tpAmb;

  Result := (FcStat in [135, 136]);

  //gerar arquivo proc de evento
  if Result then
  begin
    if FEvento.Evento[0].InfEvento.chNFeABI = EventoRetorno.retInfEvento[0].RetInfEvento.chNFeABI then
    begin
      FEvento.Evento[0].RetInfEvento.tpAmb := EventoRetorno.retInfEvento[0].RetInfEvento.tpAmb;
      FEvento.Evento[0].RetInfEvento.nProt := EventoRetorno.retInfEvento[0].RetInfEvento.nProt;
      FEvento.Evento[0].RetInfEvento.dhRegEvento := EventoRetorno.retInfEvento[0].RetInfEvento.dhRegEvento;
      FEvento.Evento[0].RetInfEvento.cStat := EventoRetorno.retInfEvento[0].RetInfEvento.cStat;
      FEvento.Evento[0].RetInfEvento.xMotivo := EventoRetorno.retInfEvento[0].RetInfEvento.xMotivo;

      VersaoEvento := TACBrNFeABI(FPDFeOwner).LerVersaoDeParams(LayNFeABIEvento);

      PedEvento := SeparaDados(FPDadosMsg, 'eventoNFeABI');
      RetEvento := SeparaDados(FPRetWS, 'retEventoNFeABI');

      Texto := '<procEventoNFeABI versao="' + VersaoEvento + '" xmlns="' + ACBRNFeABI_NAMESPACE + '">' +
                '<eventoNFeABI versao="' + VersaoEvento + '">' +
                 PedEvento +
                '</eventoNFeABI>' +
                '<retEventoNFeABI versao="' + VersaoEvento + '">' +
                 RetEvento +
                '</retEventoNFeABI>' +
               '</procEventoNFeABI>';

      if FPConfiguracoesNFeABI.Arquivos.SalvarEvento then
      begin
        NomeArq := RemoverLiteralChave(FEvento.Evento[0].InfEvento.Id) + '-procEventoNFeABI.xml';
        PathArq := PathWithDelim(GerarPathEvento(FEvento.Evento[0].InfEvento.CNPJCPF));

        FPDFeOwner.Gravar(NomeArq, Texto, PathArq);
        FEventoRetorno.retInfEvento[0].RetInfEvento.NomeArquivo := PathArq + NomeArq;
        FEvento.Evento[0].RetInfEvento.NomeArquivo := PathArq + NomeArq;
      end;

      Texto := ParseText(Texto);
      FEventoRetorno.retInfEvento[0].RetInfEvento.XML := Texto;
      FEvento.Evento[0].RetInfEvento.XML := Texto;
    end;
  end;
end;

function TNFeABIEnvEvento.GerarMsgLog: string;
var
  aMsg: string;
begin
  aMsg := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                         'Ambiente: %s ' + sLineBreak +
                         'Versão Aplicativo: %s ' + sLineBreak +
                         'Status Código: %s ' + sLineBreak +
                         'Status Descrição: %s ' + sLineBreak),
                 [FEventoRetorno.versao, TipoAmbienteToStr(FEventoRetorno.tpAmb),
                  FEventoRetorno.verAplic, IntToStr(FEventoRetorno.cStat),
                  FEventoRetorno.xMotivo]);

  if FEventoRetorno.retInfEvento.Count > 0 then
    aMsg := aMsg + Format(ACBrStr('Recebimento: %s ' + sLineBreak),
       [IfThen(FEventoRetorno.retInfEvento[0].RetInfEvento.dhRegEvento = 0, '',
               FormatDateTimeBr(FEventoRetorno.retInfEvento[0].RetInfEvento.dhRegEvento))]);

  Result := aMsg;
end;

function TNFeABIEnvEvento.GerarPrefixoArquivo: string;
begin
//  Result := IntToStr(FEvento.idLote);
  Result := IntToStr(FidLote);
end;

{ TNFeABIEnvioWebService }

constructor TNFeABIEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPStatus := stNFeABIEnvioWebService;
end;

destructor TNFeABIEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TNFeABIEnvioWebService.Clear;
begin
  inherited Clear;

  FVersao := '';
end;

function TNFeABIEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFeABIEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TNFeABIEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;
end;

procedure TNFeABIEnvioWebService.DefinirDadosMsg;
//var
//  LeitorXML: TLeitor;
begin
{
  LeitorXML := TLeitor.Create;
  try
    LeitorXML.Arquivo := FXMLEnvio;
    LeitorXML.Grupo := FXMLEnvio;
    FVersao := LeitorXML.rAtributo('versao')
  finally
    LeitorXML.Free;
  end;
}
  FPDadosMsg := FXMLEnvio;
end;

function TNFeABIEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');
  Result := True;
end;

function TNFeABIEnvioWebService.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService: '+FPServico + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TNFeABIEnvioWebService.GerarVersaoDadosSoap: string;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrNFeABI := TACBrNFeABI(AOwner);

  FStatusServico := TNFeABIStatusServico.Create(FACBrNFeABI);
  FEnviar := TNFeABIRecepcao.Create(FACBrNFeABI, TACBrNFeABI(FACBrNFeABI).NotasFiscais);
  FConsulta := TNFeABIConsulta.Create(FACBrNFeABI, TACBrNFeABI(FACBrNFeABI).NotasFiscais);
  FEnvEvento := TNFeABIEnvEvento.Create(FACBrNFeABI, TACBrNFeABI(FACBrNFeABI).EventoNFeABI);
  FEnvioWebService := TNFeABIEnvioWebService.Create(FACBrNFeABI);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FConsulta.Free;
  FEnvEvento.Free;
  FEnvioWebService.Free;

  inherited Destroy;
end;

function TWebServices.Envia(const ALote: string; Zipado: Boolean = True): Boolean;
begin
  FEnviar.Clear;

  FEnviar.Lote := ALote;
  FEnviar.Zipado := Zipado;

  if not Enviar.Executar then
    Enviar.GerarException( Enviar.Msg );

  Result := True;
end;

end.
