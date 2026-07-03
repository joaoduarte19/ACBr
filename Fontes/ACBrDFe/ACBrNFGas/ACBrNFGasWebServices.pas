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

unit ACBrNFGasWebServices;

interface

uses
  Classes, SysUtils, DateUtils,
  blcksock, synacode,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe, ACBrDFeWebService,
  ACBrDFeComum.RetConsReciDFe,
  ACBrDFeComum.Proc,
  ACBrDFeComum.RetEnvio,
  ACBrNFGasNotasFiscais, ACBrNFGasConfiguracoes,
  ACBrNFGas.Classes, ACBrNFGas.Conversao,
  ACBrNFGas.EnvEvento, ACBrNFGas.RetEnvEvento,
  ACBrNFGas.RetConsSit;

type

  { TNFGasWebService }

  TNFGasWebService = class(TDFeWebService)
  private
    FOldSSLType: TSSLType;
    FOldHeaderElement: string;
  protected
    FPStatus: TStatusNFGas;
    FPLayout: TLayOutNFGas;
    FPConfiguracoesNFGas: TConfiguracoesNFGas;

    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: string; override;
    procedure FinalizarServico; override;
    procedure RemoverNameSpace;
  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusNFGas read FPStatus;
    property Layout: TLayOutNFGas read FPLayout;
  end;

  { TNFGasStatusServico }

  TNFGasStatusServico = class(TNFGasWebService)
  private
    Fversao: string;
    FTpAmb: TACBrTipoAmbiente;
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
    property tpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: string read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property dhRetorno: TDateTime read FdhRetorno;
    property xObs: string read FxObs;
  end;

  { TNFGasRecepcao }

  TNFGasRecepcao = class(TNFGasWebService)
  private
    FLote: string;
    FNotasFiscais: TNotasFiscais;
    Fversao: string;
    FTpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: string;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FVersaoDF: TVersaoNFGas;

    FNFGasRetornoSincrono: TRetConsSitNFGas;
    FNFGasRetorno: TretEnvDFe;
    FMsgUnZip: string;

    FNProt: string;
    FChNFGas: string;
    FXMLRetorno: string;
    FProtocolo: string;

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
    property Lote: string read GetLote write FLote;
    property MsgUnZip: string read FMsgUnZip;
    property NFGasRetornoSincrono: TRetConsSitNFGas read FNFGasRetornoSincrono;

    property Protocolo: string read FProtocolo;
    property NProt: string read FNProt;
    property ChNFGas: string read FChNFGas;
    property XMLRetorno: string read FXMLRetorno;
  end;

  { TNFGasConsulta }

  TNFGasConsulta = class(TNFGasWebService)
  private
    FOwner: TACBrDFe;
    FNFGasChave: string;
    FExtrairEventos: Boolean;
    FNotasFiscais: TNotasFiscais;
    FProtocolo: string;
    FDhRecbto: TDateTime;
    FXMotivo: string;
    Fversao: string;
    FTpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FcUF: Integer;
    FRetNFGasDFe: string;

    FprotNFGas: TProcDFe;
    FprocEventoNFGas: TRetEventoNFGasCollection;
    FNFGasRetorno: TRetConsSitNFGas;

    procedure SetNFGasChave(const AValue: string);
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

    property NFGasChave: string read FNFGasChave write SetNFGasChave;
    property ExtrairEventos: Boolean read FExtrairEventos write FExtrairEventos;
    property Protocolo: string read FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto;
    property XMotivo: string read FXMotivo;
    property versao: string read Fversao;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property RetNFGasDFe: string read FRetNFGasDFe;

    property protNFGas: TProcDFe read FprotNFGas;
    property procEventoNFGas: TRetEventoNFGasCollection read FprocEventoNFGas;
  end;

  { TNFGasEnvEvento }

  TNFGasEnvEvento = class(TNFGasWebService)
  private
    FIdLote: Int64;
    FEvento: TEventoNFGas;
    FcStat: Integer;
    FxMotivo: string;
    FTpAmb: TACBrTipoAmbiente;
    FCNPJ: string;

    FEventoRetorno: TRetEventoNFGas;

    function GerarPathEvento(const ACNPJ: string = ''; const AIE: string = ''): string;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarPrefixoArquivo: string; override;
  public
    constructor Create(AOwner: TACBrDFe; AEvento: TEventoNFGas); reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property IdLote: Int64 read FIdLote write FIdLote;
    property cStat: Integer read FcStat;
    property xMotivo: string read FxMotivo;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property EventoRetorno: TRetEventoNFGas read FEventoRetorno;
  end;

  { TNFGasEnvioWebService }

  TNFGasEnvioWebService = class(TNFGasWebService)
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
    FACBrNFGas: TACBrDFe;
    FStatusServico: TNFGasStatusServico;
    FEnviar: TNFGasRecepcao;
    FConsulta: TNFGasConsulta;
    FEnvEvento: TNFGasEnvEvento;
    FEnvioWebService: TNFGasEnvioWebService;
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function Envia(const ALote: string): Boolean;

    property ACBrNFGas: TACBrDFe read FACBrNFGas write FACBrNFGas;
    property StatusServico: TNFGasStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFGasRecepcao read FEnviar write FEnviar;
    property Consulta: TNFGasConsulta read FConsulta write FConsulta;
    property EnvEvento: TNFGasEnvEvento read FEnvEvento write FEnvEvento;
    property EnvioWebService: TNFGasEnvioWebService read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
  StrUtils, Math,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.FilesIO,
  ACBrDFeConsts,
  ACBrDFeUtil,
  ACBrDFeComum.ConsStatServ,
  ACBrDFeComum.RetConsStatServ,
  ACBrCompress,
  ACBrNFGas,
  ACBrNFGas.Consts,
  ACBrNFGas.ConsSit;

{ TNFGasWebService }

constructor TNFGasWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesNFGas := TConfiguracoesNFGas(FPConfiguracoes);
  FPLayout := LayNFGasStatusServico;

  FPHeaderElement := '';
  FPBodyElement := 'nfgasDadosMsg';
end;

procedure TNFGasWebService.Clear;
begin
  inherited Clear;

  FPStatus := stNFGasIdle;

  if Assigned(FPDFeOwner) and Assigned(FPDFeOwner.SSL) then
    FPDFeOwner.SSL.UseCertificateHTTP := True;
end;

procedure TNFGasWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }
  inherited InicializarServico;

  FOldSSLType := FPDFeOwner.SSL.SSLType;
  FOldHeaderElement := FPHeaderElement;

  FPHeaderElement := '';

  TACBrNFGas(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TNFGasWebService.RemoverNameSpace;
begin
  FPRetWS := StringReplace(FPRetWS, ' xmlns="http://www.portalfiscal.inf.br/nfgas"',
                                    '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TNFGasWebService.DefinirURL;
var
  Versao: Double;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';
  FPServico := '';
  FPSoapAction := '';

  TACBrNFGas(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL, FPServico, FPSoapAction);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TNFGasWebService.GerarVersaoDadosSoap: string;
begin
  { Sobrescrever apenas se necessário }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrNFGas(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

procedure TNFGasWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  // Retornar configurações anteriores
  FPDFeOwner.SSL.SSLType := FOldSSLType;
  FPHeaderElement := FOldHeaderElement;

  TACBrNFGas(FPDFeOwner).SetStatus(stNFGasIdle);
end;

{ TNFGasStatusServico }

procedure TNFGasStatusServico.Clear;
begin
  inherited Clear;

  FPStatus := stNFGasStatusServico;
  FPLayout := LayNFGasStatusServico;
  FPArqEnv := 'ped-sta';
  FPArqResp := 'sta';

  Fversao := '';
  FTpAmb := taHomologacao;
  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FcUF := 0;
  FdhRecbto := 0;
  FTMed := 0;
  FdhRetorno := 0;
  FxObs := '';

  if Assigned(FPConfiguracoesNFGas) then
  begin
    FTpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFGas.WebServices.UFCodigo;
  end;
end;

procedure TNFGasStatusServico.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFGasStatusServico';
  FPSoapAction := FPServico + '/NFGasStatusServicoNF';
end;

procedure TNFGasStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.Create(FPVersaoServico, NAME_SPACE_NFGAS, 'NFGas', False);
  try
    ConsStatServ.TpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;
    ConsStatServ.CUF := FPConfiguracoesNFGas.WebServices.UFCodigo;
    FPDadosMsg := ConsStatServ.GerarXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TNFGasStatusServico.TratarResposta: Boolean;
var
  NFGasRetorno: TRetConsStatServ;
begin
  FPRetWS := SeparaDadosArray(['NFGasResultMsg', 'nfgasResultMsg'], FPRetornoWS);

  if EstaVazio(FPRetWS) then
    FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');

  VerificarSemResposta;
  RemoverNameSpace;

  NFGasRetorno := TRetConsStatServ.Create('NFGas');
  try
    NFGasRetorno.XmlRetorno := ParseText(FPRetWS);
    NFGasRetorno.LerXml;

    Fversao := NFGasRetorno.versao;
    FTpAmb := NFGasRetorno.tpAmb;
    FverAplic := NFGasRetorno.verAplic;
    FcStat := NFGasRetorno.cStat;
    FxMotivo := NFGasRetorno.xMotivo;
    FcUF := NFGasRetorno.cUF;

    { WebService do RS retorna horário de verão mesmo pros estados que não
      adotam esse horário, ao utilizar esta hora para basear a emissão da nota
      acontece o erro. }
    if (Pos('svrs.rs.gov.br', FPURL) > 0) and
       (MinutesBetween(NFGasRetorno.dhRecbto, Now) > 50) and
       (not IsHorarioDeVerao(CodigoUFparaUF(FcUF), NFGasRetorno.dhRecbto)) then
      FdhRecbto := IncHour(NFGasRetorno.dhRecbto, -1)
    else
      FdhRecbto := NFGasRetorno.dhRecbto;

    FTMed := NFGasRetorno.TMed;
    FdhRetorno := NFGasRetorno.dhRetorno;
    FxObs := NFGasRetorno.xObs;
    FPMsg := FxMotivo + sLineBreak + FxObs;

    if Assigned(FPConfiguracoesNFGas) and
       Assigned(FPConfiguracoesNFGas.WebServices) and
       FPConfiguracoesNFGas.WebServices.AjustaAguardaConsultaRet then
      FPConfiguracoesNFGas.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);
  finally
    NFGasRetorno.Free;
  end;
end;

function TNFGasStatusServico.GerarMsgLog: string;
begin
  {(*}
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
                    FxMotivo, CodigoUFparaUF(FcUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    IntToStr(FTMed),
                    IfThen(FdhRetorno = 0, '', FormatDateTimeBr(FdhRetorno)),
                    FxObs]);
  {*)}
end;

function TNFGasStatusServico.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService Consulta Status serviço:' + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TNFGasRecepcao }

constructor TNFGasRecepcao.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFGasRecepcao.Destroy;
begin
  FNFGasRetornoSincrono.Free;
  FNFGasRetorno.Free;

  inherited Destroy;
end;

procedure TNFGasRecepcao.Clear;
begin
  inherited Clear;

  FPStatus := stNFGasRecepcao;
  FPLayout := LayNFGasRecepcao;
  FPArqEnv := 'env';
  FPArqResp := 'rec';

  FNProt := '';
  FChNFGas := '';
  FXMLRetorno := '';
  FMsgUnZip := '';
  Fversao := '';
  FverAplic := '';
  FcStat := 0;
  FcUF := 0;
  FxMotivo := '';
  FdhRecbto := 0;
  FTMed := 0;

  if Assigned(FPConfiguracoesNFGas) then
  begin
    FTpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFGas.WebServices.UFCodigo;
  end;

  if Assigned(FNFGasRetornoSincrono) then
    FNFGasRetornoSincrono.Free;

  if Assigned(FNFGasRetorno) then
    FNFGasRetorno.Free;

  FNFGasRetornoSincrono := TRetConsSitNFGas.Create;
  FNFGasRetorno := TretEnvDFe.Create;
end;

function TNFGasRecepcao.GetLote: string;
begin
  Result := Trim(FLote);
end;

procedure TNFGasRecepcao.InicializarServico;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFGas ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFGas(FNotasFiscais.Items[0].NFGas.infNFGas.Versao)
  else
    FVersaoDF := FPConfiguracoesNFGas.Geral.VersaoDF;

  inherited InicializarServico;

  FPHeaderElement := '';
end;

procedure TNFGasRecepcao.DefinirURL;
var
  xUF: string;
  VerServ: Double;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFGas ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFGas.Ide.cUF;

    if Integer(FPConfiguracoesNFGas.WebServices.Ambiente) <>
       Integer(FNotasFiscais.Items[0].NFGas.Ide.tpAmb) then
      raise EACBrNFGasException.Create(ACBRNFGas_CErroAmbienteDiferente);
  end
  else
  begin // Se não tem NFGas, use as configurações do componente
    FcUF := FPConfiguracoesNFGas.WebServices.UFCodigo;
  end;

  VerServ := VersaoNFGasToDbl(FVersaoDF);
  FTpAmb := TACBrTipoAmbiente(FPConfiguracoesNFGas.WebServices.Ambiente);
  FPVersaoServico := '';
  FPURL := '';

  FPLayout := LayNFGasRecepcao;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFGas.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFGas(FPDFeOwner).LerServicoDeParams(
    'NFGas',
    xUF,
    FTpAmb,
    LayOutNFGasToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFGasRecepcao.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFGasRecepcao';
  FPSoapAction := FPServico + '/nfgasRecepcao';
end;

procedure TNFGasRecepcao.DefinirDadosMsg;
begin
  // No envio só podemos ter apena UM NFGas, pois o seu processamento é síncrono
  if FNotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NFGas transmitidos (máximo de 1 NFGas)' +
           ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  if FNotasFiscais.Count > 0 then
    FPDadosMsg := '<NFGas' +
      RetornarConteudoEntre(FNotasFiscais.Items[0].XMLAssinado, '<NFGas', '</NFGas>') +
      '</NFGas>';

  FMsgUnZip := FPDadosMsg;
  FPDadosMsg := EncodeBase64(GZipCompress(FPDadosMsg));

  // Lote tem mais de 1 Mb ? //
  if Length(FPDadosMsg) > (1024 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 1 Mbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));
end;

function TNFGasRecepcao.TratarResposta: Boolean;
var
  I: Integer;
  chNFGas, AXML, NomeXMLSalvo: string;
  AProcNFGas: TProcDFe;
  SalvarXML: Boolean;
begin
  FPRetWS := SeparaDadosArray(['nfgasResultMsg'], FPRetornoWS );

  if pos('retNFGas', FPRetWS) > 0 then
    AXML := StringReplace(FPRetWS, 'retNFGas', 'retConsSitNFGas',
                                   [rfReplaceAll, rfIgnoreCase])
  else if pos('retConsReciNFGas', FPRetWS) > 0 then
    AXML := StringReplace(FPRetWS, 'retConsReciNFGas', 'retConsSitNFGas',
                                   [rfReplaceAll, rfIgnoreCase])
  else
    AXML := FPRetWS;

  FNFGasRetornoSincrono.XmlRetorno := ParseText(AXML);
  FNFGasRetornoSincrono.LerXml;

  Fversao := FNFGasRetornoSincrono.versao;
  FTpAmb := FNFGasRetornoSincrono.TpAmb;
  FverAplic := FNFGasRetornoSincrono.verAplic;

  FcUF := FNFGasRetornoSincrono.cUF;
  chNFGas := FNFGasRetornoSincrono.ProtNFGas.chDFe;

  if (FNFGasRetornoSincrono.ProtNFGas.cStat > 0) then
    FcStat := FNFGasRetornoSincrono.ProtNFGas.cStat
  else
    FcStat := FNFGasRetornoSincrono.cStat;

  if (FNFGasRetornoSincrono.ProtNFGas.xMotivo <> '') then
  begin
    FPMsg := FNFGasRetornoSincrono.ProtNFGas.xMotivo;
    FxMotivo := FNFGasRetornoSincrono.ProtNFGas.xMotivo;
  end
  else
  begin
    FPMsg := FNFGasRetornoSincrono.xMotivo;
    FxMotivo := FNFGasRetornoSincrono.xMotivo;
  end;

  // Verificar se a NFAg foi autorizada com sucesso
  Result := (FNFGasRetornoSincrono.cStat = 100) and
    (TACBrNFGas(FPDFeOwner).CstatProcessado(FNFGasRetornoSincrono.ProtNFGas.cStat));

  if Result then
  begin
    // Pega o numero do protocolo
    FProtocolo := FNFGasRetornoSincrono.ProtNFGas.nProt;

    for I := 0 to TACBrNFGas(FPDFeOwner).NotasFiscais.Count - 1 do
    begin
      with TACBrNFGas(FPDFeOwner).NotasFiscais.Items[I] do
      begin
        if RemoverLiteralChave(chNFGas) = NumID then
        begin

          if (FPConfiguracoesNFGas.Geral.ValidarDigest) and
             (FNFGasRetornoSincrono.ProtNFGas.digVal <> '') and
             (NFGas.signature.DigestValue <> FNFGasRetornoSincrono.ProtNFGas.digVal) then
          begin
            raise EACBrNFGasException.Create('DigestValue do documento ' + NumID + ' não confere.');
          end;

          NFGas.procNFGas.cStat := FNFGasRetornoSincrono.ProtNFGas.cStat;
          NFGas.procNFGas.tpAmb := FNFGasRetornoSincrono.tpAmb;
          NFGas.procNFGas.verAplic := FNFGasRetornoSincrono.verAplic;
          NFGas.procNFGas.chDFe := FNFGasRetornoSincrono.ProtNFGas.chDFe;
          NFGas.procNFGas.dhRecbto := FNFGasRetornoSincrono.ProtNFGas.dhRecbto;
          NFGas.procNFGas.nProt := FNFGasRetornoSincrono.ProtNFGas.nProt;
          NFGas.procNFGas.digVal := FNFGasRetornoSincrono.ProtNFGas.digVal;
          NFGas.procNFGas.xMotivo := FNFGasRetornoSincrono.ProtNFGas.xMotivo;

          AProcNFGas := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFGAS, 'nfgasProc', 'NFGas');
          try
            // Processando em UTF8, para poder gravar arquivo corretamente //
            AProcNFGas.XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
            AProcNFGas.XML_Prot := FNFGasRetornoSincrono.XMLprotNFGas;
            XMLOriginal := AProcNFGas.GerarXML;

            if FPConfiguracoesNFGas.Arquivos.Salvar then
            begin
              SalvarXML := Processada;

              // Salva o XML do NFGas assinado e protocolado
              if SalvarXML then
              begin
                NomeXMLSalvo := '';
                if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                begin
                  FPDFeOwner.Gravar( NomeArq, XMLOriginal ); // Atualiza o XML carregado
                  NomeXMLSalvo := NomeArq;
                end;

                if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                  GravarXML; // Salva na pasta baseado nas configurações do PathNFGas
              end;
            end ;
          finally
            AProcNFGas.Free;
          end;

          Break;
        end;
      end;
    end;
  end;
end;

function TNFGasRecepcao.GerarMsgLog: string;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                         'Ambiente: %s ' + sLineBreak +
                         'Versão Aplicativo: %s ' + sLineBreak +
                         'Status Código: %s ' + sLineBreak +
                         'Status Descrição: %s ' + sLineBreak +
                         'UF: %s ' + sLineBreak +
                         'Recebimento: %s ' + sLineBreak +
                         'Protocolo: %s ' + sLineBreak +
                         'Chave: %s ' + sLineBreak),
                   [versao,
                    TipoAmbienteToStr(TpAmb),
                    verAplic,
                    IntToStr(cStat),
                    xMotivo,
                    CodigoUFparaUF(cUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    FNProt,
                    FChNFGas]);
end;

function TNFGasRecepcao.GerarPrefixoArquivo: string;
begin
  Result := Lote;
  FPArqResp := 'pro-lot';
end;

{ TNFGasConsulta }

constructor TNFGasConsulta.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
  FNotasFiscais := ANotasFiscais;

  if Assigned(FNFGasRetorno) then
    FNFGasRetorno.Free;
end;

destructor TNFGasConsulta.Destroy;
begin
  FprotNFGas.Free;
  FprocEventoNFGas.Free;

  inherited Destroy;
end;

procedure TNFGasConsulta.Clear;
begin
  inherited Clear;

  FPStatus := stNFGasConsulta;
  FPLayout := LayNFGasConsulta;
  FPArqEnv := 'ped-sit';
  FPArqResp := 'sit';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FProtocolo := '';
  FDhRecbto := 0;
  Fversao := '';
  FRetNFGasDFe := '';

  if Assigned(FPConfiguracoesNFGas) then
  begin
    FTpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFGas.WebServices.UFCodigo;
  end;

  if Assigned(FprotNFGas) then
    FprotNFGas.Free;

  if Assigned(FprocEventoNFGas) then
    FprocEventoNFGas.Free;

  FprotNFGas := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFGAS, 'NFGasProc', 'NFGas');
  FprocEventoNFGas := TRetEventoNFGasCollection.Create;
end;

procedure TNFGasConsulta.SetNFGasChave(const AValue: string);
var
  NumChave: string;
begin
  if FNFGasChave = AValue then Exit;

  NumChave := RemoverLiteralChave(AValue);

  if not ValidarChave(NumChave) then
    raise EACBrNFGasException.Create('Chave "' + AValue + '" inválida.');

  FNFGasChave := NumChave;
end;

procedure TNFGasConsulta.DefinirURL;
var
  VerServ: Double;
  xUF: string;
begin
  FPVersaoServico := '';
  FPURL := '';

  FcUF := ExtrairUFChaveAcesso(FNFGasChave);
  VerServ := VersaoNFGasToDbl(FPConfiguracoesNFGas.Geral.VersaoDF);

  if FNotasFiscais.Count > 0 then
    FTpAmb := FNotasFiscais.Items[0].NFGas.Ide.tpAmb
  else
    FTpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;

  // Se a nota foi enviada para o SVC a consulta tem que ser realizada no SVC e
  // não na SEFAZ-Autorizadora
  case FPConfiguracoesNFGas.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFGas(FPDFeOwner).LerServicoDeParams(
    'NFGas',
    xUF,
    FTpAmb,
    LayOutNFGasToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFGasConsulta.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFGasConsulta';
  FPSoapAction := FPServico + '/NFGasConsultaNF';
end;

procedure TNFGasConsulta.DefinirDadosMsg;
var
  ConsSitNFGas: TConsSitNFGas;
begin
  ConsSitNFGas := TConsSitNFGas.Create;
  try
    ConsSitNFGas.TpAmb := TpAmb;
    ConsSitNFGas.chNFGas := FNFGasChave;
    ConsSitNFGas.Versao := FPVersaoServico;

    FPDadosMsg := ConsSitNFGas.GerarXML;
  finally
    ConsSitNFGas.Free;
  end;
end;

function TNFGasConsulta.GerarUFSoap: string;
begin
  Result := '<cUF>' + IntToStr(FcUF) + '</cUF>';
end;

function TNFGasConsulta.TratarResposta: Boolean;

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
    Inicio := Pos('<procEventoNFGas', Retorno);
    Fim    := Pos('</procEventoNFGas>', Retorno) + 15;

    aEvento := Copy(Retorno, Inicio, Fim - Inicio + 1);

    Retorno := Copy(Retorno, Fim + 1, Length(Retorno));

    aProcEvento := '<procEventoNFGas versao="' + FVersao + '" ' + NAME_SPACE_NFGAS + '>' +
                      SeparaDados(aEvento, 'procEventoNFGas') +
                   '</procEventoNFGas>';

    Inicio := Pos('Id=', aProcEvento) + 6;
    Fim    := 52;

    if Inicio = 6 then
      aIDEvento := FormatDateTime('yyyymmddhhnnss', Now)
    else
      aIDEvento := Copy(aProcEvento, Inicio, Fim);

    TipoEvento  := StrToTpEventoNFGas(Ok, SeparaDados(aEvento, 'tpEvento'));
    DhEvt       := EncodeDataHora(SeparaDados(aEvento, 'dhEvento'), 'YYYY-MM-DD');
    sCNPJCPF    := SeparaDados(aEvento, 'CNPJ');

    if EstaVazio(sCNPJCPF) then
      sCNPJCPF := SeparaDados(aEvento, 'CPF');

    sPathEvento := PathWithDelim(FPConfiguracoesNFGas.Arquivos.GetPathEvento(TipoEvento, sCNPJCPF, '', DhEvt));

    if FPConfiguracoesNFGas.Arquivos.SalvarEvento and (aProcEvento <> '') then
      FPDFeOwner.Gravar( aIDEvento + '-procEventoNFGas.xml', aProcEvento, sPathEvento);
  end;
end;

var
  SalvarXML, NFGasCancelado, Atualiza: Boolean;
  aEventos, sPathNFGas, NomeXMLSalvo: string;
  AProcNFGas: TProcDFe;
  I, Inicio, Fim: Integer;
  dhEmissao: TDateTime;
begin
  FNFGasRetorno := TRetConsSitNFGas.Create;

  try
    FPRetWS := SeparaDados(FPRetornoWS, 'nfgasResultMsg');

    FNFGasRetorno.XmlRetorno := ParseText(FPRetWS);
    FNFGasRetorno.LerXML;

    NFGasCancelado := False;
    aEventos := '';

    // <retConsSitNFGas> - Retorno da consulta da situação da DC-e
    // Este é o status oficial da DC-e
    Fversao := FNFGasRetorno.versao;
    FTpAmb := FNFGasRetorno.tpAmb;
    FverAplic := FNFGasRetorno.verAplic;
    FcStat := FNFGasRetorno.cStat;
    FXMotivo := FNFGasRetorno.xMotivo;
    FcUF := FNFGasRetorno.cUF;
    FNFGasChave := FNFGasRetorno.chNFGas;
    FPMsg := FXMotivo;

    // <protNFGas> - Retorno dos dados do ENVIO da DC-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFGas.PathDFe            := FNFGasRetorno.protNFGas.PathDFe;
    FprotNFGas.PathRetConsReciDFe := FNFGasRetorno.protNFGas.PathRetConsReciDFe;
    FprotNFGas.PathRetConsSitDFe  := FNFGasRetorno.protNFGas.PathRetConsSitDFe;
    FprotNFGas.tpAmb              := FNFGasRetorno.protNFGas.tpAmb;
    FprotNFGas.verAplic           := FNFGasRetorno.protNFGas.verAplic;
    FprotNFGas.chDFe              := FNFGasRetorno.protNFGas.chDFe;
    FprotNFGas.dhRecbto           := FNFGasRetorno.protNFGas.dhRecbto;
    FprotNFGas.nProt              := FNFGasRetorno.protNFGas.nProt;
    FprotNFGas.digVal             := FNFGasRetorno.protNFGas.digVal;
    FprotNFGas.cStat              := FNFGasRetorno.protNFGas.cStat;
    FprotNFGas.xMotivo            := FNFGasRetorno.protNFGas.xMotivo;

    if Assigned(FNFGasRetorno.procEventoNFGas) and (FNFGasRetorno.procEventoNFGas.Count > 0) then
    begin
      aEventos := '=====================================================' +
        sLineBreak + '================== Eventos da NFGas ==================' +
        sLineBreak + '=====================================================' +
        sLineBreak + '' + sLineBreak + 'Quantidade total de eventos: ' +
        IntToStr(FNFGasRetorno.procEventoNFGas.Count);

      FprocEventoNFGas.Clear;
      for I := 0 to FNFGasRetorno.procEventoNFGas.Count - 1 do
      begin
        with FprocEventoNFGas.New.RetEventoNFGas.retInfEvento do
        begin
//          idLote := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.idLote;
          tpAmb := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.tpAmb;
          verAplic := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.verAplic;
          cOrgao := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.cOrgao;
          cStat := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.cStat;
          xMotivo := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.xMotivo;
          XML := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.XML;

          ID := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.ID;
          tpAmb := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.tpAmb;
//          CNPJ := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.CNPJ;
          chNFGas := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.chNFGas;
//          dhEvento := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.dhEvento;
          TpEvento := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.TpEvento;
          nSeqEvento := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.nSeqEvento;
          nProt := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.nProt;
//          xJust := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retInfEvento.xJust;
          {
          retEvento.Clear;
          for J := 0 to FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Count-1 do
          begin
            with retEvento.New.RetInfEvento do
            begin
              Id          := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.Id;
              tpAmb       := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.tpAmb;
              verAplic    := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.verAplic;
              cOrgao      := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.cOrgao;
              cStat       := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.cStat;
              xMotivo     := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.xMotivo;
              chNFGas       := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.chNFGas;
              tpEvento    := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.tpEvento;
              xEvento     := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.xEvento;
              nSeqEvento  := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.nSeqEvento;
              CNPJDest    := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.CNPJDest;
              emailDest   := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.emailDest;
              dhRegEvento := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.dhRegEvento;
              nProt       := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.nProt;
              XML         := FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas.retEvento.Items[j].RetInfEvento.XML;
            end;
          end;
          }
        end;
        {
        with FNFGasRetorno.procEventoNFGas.Items[I].RetEventoNFGas do
        begin
          for j := 0 to retEvento.Count -1 do
          begin
            aEventos := aEventos + LineBreak + LineBreak +
              Format(ACBrStr('Número de sequência: %s ' + LineBreak +
                             'Código do evento: %s ' + LineBreak +
                             'Descrição do evento: %s ' + LineBreak +
                             'Status do evento: %s ' + LineBreak +
                             'Descrição do status: %s ' + LineBreak +
                             'Protocolo: %s ' + LineBreak +
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
              NFGasCancelado := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;
          end;
        end;
        }
      end;
    end;

    if (not NFGasCancelado) and (NaoEstaVazio(FNFGasRetorno.protNFGas.nProt))  then
    begin
      FProtocolo := FNFGasRetorno.protNFGas.nProt;
      FDhRecbto := FNFGasRetorno.protNFGas.dhRecbto;
      FPMsg := FNFGasRetorno.protNFGas.xMotivo;
    end;

    if not Assigned(FPDFeOwner) then //evita AV caso não atribua o Owner
    begin
     Result := True;
     Exit;
    end;

    with TACBrNFGas(FPDFeOwner) do
    begin
      Result := CstatProcessado(FNFGasRetorno.CStat) or
                CstatCancelada(FNFGasRetorno.CStat);
    end;

    if Result then
    begin
      if TACBrNFGas(FPDFeOwner).NotasFiscais.Count > 0 then
      begin
        for i := 0 to TACBrNFGas(FPDFeOwner).NotasFiscais.Count - 1 do
        begin
          with TACBrNFGas(FPDFeOwner).NotasFiscais.Items[i] do
          begin
            if RemoverLiteralChave(FNFGasChave) = NumID then
            begin
              Atualiza := (NaoEstaVazio(FNFGasRetorno.XMLprotNFGas));

              if Atualiza and
                 TACBrNFGas(FPDFeOwner).cStatCancelada(FNFGasRetorno.cStat) then
                Atualiza := False;

              // No retorno pode constar que a nota esta cancelada, mas traz o grupo
              // <protNFGas> com as informações da sua autorização
              if not Atualiza and TACBrNFGas(FPDFeOwner).cstatProcessado(FNFGasRetorno.protNFGas.cStat) then
                Atualiza := True;

              if (FPConfiguracoesNFGas.Geral.ValidarDigest) and
                 (FNFGasRetorno.protNFGas.digVal <> '') and (NFGas.signature.DigestValue <> '') and
                 (UpperCase(NFGas.signature.DigestValue) <> UpperCase(FNFGasRetorno.protNFGas.digVal)) then
              begin
                raise EACBrNFGasException.Create('DigestValue do documento ' +
                    NumID + ' não confere.');
              end;

              // Atualiza o Status da NFGas interna //
              NFGas.procNFGas.cStat := FNFGasRetorno.cStat;

              if Atualiza then
              begin
                if TACBrNFGas(FPDFeOwner).CstatCancelada(FNFGasRetorno.CStat) then
                begin
                  NFGas.procNFGas.tpAmb := FNFGasRetorno.tpAmb;
                  NFGas.procNFGas.verAplic := FNFGasRetorno.verAplic;
                  NFGas.procNFGas.chDFe := FNFGasRetorno.chNFGas;
                  NFGas.procNFGas.dhRecbto := FDhRecbto;
                  NFGas.procNFGas.nProt := FProtocolo;
                  NFGas.procNFGas.digVal := FNFGasRetorno.protNFGas.digVal;
                  NFGas.procNFGas.cStat := FNFGasRetorno.cStat;
                  NFGas.procNFGas.xMotivo := FNFGasRetorno.xMotivo;

                  GerarXML;
                end
                else
                begin
                  NFGas.procNFGas.tpAmb := FNFGasRetorno.protNFGas.tpAmb;
                  NFGas.procNFGas.verAplic := FNFGasRetorno.protNFGas.verAplic;
                  NFGas.procNFGas.chDFe := FNFGasRetorno.protNFGas.chDFe;
                  NFGas.procNFGas.dhRecbto := FNFGasRetorno.protNFGas.dhRecbto;
                  NFGas.procNFGas.nProt := FNFGasRetorno.protNFGas.nProt;
                  NFGas.procNFGas.digVal := FNFGasRetorno.protNFGas.digVal;
                  NFGas.procNFGas.cStat := FNFGasRetorno.protNFGas.cStat;
                  NFGas.procNFGas.xMotivo := FNFGasRetorno.protNFGas.xMotivo;

                  // O código abaixo é bem mais rápido que "GerarXML" (acima)...
                  AProcNFGas := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFGAS, 'NFGasProc', 'NFGas');
                  try
                    AProcNFGas.XML_DFe := RemoverDeclaracaoXML(XMLOriginal);
                    AProcNFGas.XML_Prot := FNFGasRetorno.XMLprotNFGas;

                    XMLOriginal := AProcNFGas.GerarXML;
                  finally
                    AProcNFGas.Free;
                  end;
                end;
              end;

              { Se no retorno da consulta constar que a nota possui eventos vinculados
               será disponibilizado na propriedade FRetNFGasDFe, e conforme configurado
               em "ConfiguracoesNFGas.Arquivos.Salvar", também será gerado o arquivo:
               <chave>-NFGasDFe.xml}

              FRetNFGasDFe := '';

              if (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFGas'))) then
              begin
                Inicio := Pos('<procEventoNFGas', FPRetWS);
                Fim    := Pos('</retConsSitNFGas', FPRetWS) -1;

                aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

                FRetNFGasDFe := '<' + ENCODING_UTF8 + '>' +
                              '<NFGasDFe>' +
                               '<NFGasProc versao="' + FVersao + '">' +
                                 SeparaDados(XMLOriginal, 'NFGasProc') +
                               '</NFGasProc>' +
                               '<procEventoNFGas versao="' + FVersao + '">' +
                                 aEventos +
                               '</procEventoNFGas>' +
                              '</NFGasDFe>';
              end;

              SalvarXML := Result and FPConfiguracoesNFGas.Arquivos.Salvar and Atualiza;

              if SalvarXML then
              begin
                // Salva o XML da NFGas assinado, protocolado e com os eventos
                if FPConfiguracoesNFGas.Arquivos.EmissaoPathNFGas then
                  dhEmissao := NFGas.Ide.dhEmi
                else
                  dhEmissao := Now;

                sPathNFGas := PathWithDelim(FPConfiguracoesNFGas.Arquivos.GetPathNFGas(dhEmissao, NFGas.Emit.CNPJ));

                if (FRetNFGasDFe <> '') then
                  FPDFeOwner.Gravar( FNFGasChave + '-NFGasDFe.xml', FRetNFGasDFe, sPathNFGas);

                if Atualiza then
                begin
                  // Salva o XML da NFGas assinado e protocolado
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal );  // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  // Salva na pasta baseado nas configurações do PathNFGas
                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML;

                  // Salva o XML de eventos retornados ao consultar um NFGas
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
        if ExtrairEventos and FPConfiguracoesNFGas.Arquivos.SalvarEvento and
           (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFGas'))) then
        begin
          Inicio := Pos('<procEventoNFGas', FPRetWS);
          Fim    := Pos('</retConsSitNFGas', FPRetWS) -1;

          aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

          // Salva o XML de eventos retornados ao consultar um NFGas
          SalvarEventos(aEventos);
        end;
      end;
    end;
  finally
    Result := True;
    FNFGasRetorno.Free;
  end;
end;

function TNFGasConsulta.GerarMsgLog: string;
begin
  {(*}
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
                   [Fversao, FNFGasChave, TipoAmbienteToStr(FTpAmb), FverAplic,
                    IntToStr(FcStat), FXMotivo, CodigoUFparaUF(FcUF), FNFGasChave,
                    FormatDateTimeBr(FDhRecbto), FProtocolo, FprotNFGas.digVal]);
  {*)}
end;

function TNFGasConsulta.GerarPrefixoArquivo: string;
begin
  Result := Trim(FNFGasChave);
end;

{ TNFGasEnvEvento }

constructor TNFGasEnvEvento.Create(AOwner: TACBrDFe; AEvento: TEventoNFGas);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TNFGasEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  inherited Destroy;
end;

procedure TNFGasEnvEvento.Clear;
begin
  inherited Clear;

  FPStatus := stNFGasEvento;
  FPLayout := LayNFGasEvento;
  FPArqEnv := 'ped-eve';
  FPArqResp := 'eve';

  FcStat := 0;
  FxMotivo := '';
  FCNPJ := '';

  if Assigned(FPConfiguracoesNFGas) then
    FTpAmb := FPConfiguracoesNFGas.WebServices.Ambiente;

  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  FEventoRetorno := TRetEventoNFGas.Create;
end;

function TNFGasEnvEvento.GerarPathEvento(const ACNPJ: string; const AIE: string): string;
begin
  with FEvento.Evento.Items[0].InfEvento do
  begin
    Result := FPConfiguracoesNFGas.Arquivos.GetPathEvento(tpEvento, ACNPJ, AIE);
  end;
end;

procedure TNFGasEnvEvento.DefinirURL;
var
  UF: string;
  VerServ: Double;
begin
  FPLayout := LayNFGasEvento;
  VerServ := VersaoNFGasToDbl(FPConfiguracoesNFGas.Geral.VersaoDF);
  FCNPJ   := FEvento.Evento.Items[0].InfEvento.CNPJ;
  FTpAmb  := FEvento.Evento.Items[0].InfEvento.tpAmb;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFGas.Geral.FormaEmissao of
    teSVCAN: UF := 'SVC-AN';
    teSVCRS: UF := 'SVC-RS';
  else
    UF := CodigoUFparaUF(ExtrairUFChaveAcesso(FEvento.Evento.Items[0].InfEvento.chNFGas));
  end;

  FPURL := '';

  TACBrNFGas(FPDFeOwner).LerServicoDeParams(
    'NFGas',
    UF,
    FTpAmb,
    LayOutNFGasToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFGasEnvEvento.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFGasRecepcaoEvento';
  FPSoapAction := FPServico + '/NFGasRecepcaoEvento';
end;

procedure TNFGasEnvEvento.DefinirDadosMsg;
var
  EventoNFGas: TEventoNFGas;
  I, F: Integer;
  Evento, Eventos, EventosAssinados, AXMLEvento: AnsiString;
  FErroValidacao: string;
  EventoEhValido: Boolean;
  SchemaEventoNFGas: TSchemaNFGas;
begin
  EventoNFGas := TEventoNFGas.Create;
  try
    EventoNFGas.IdLote := FIdLote;
    SchemaEventoNFGas := schErroNFGas;

    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      with EventoNFGas.Evento.New do
      begin
        InfEvento.tpAmb := FTpAmb;
        InfEvento.CNPJ := FEvento.Evento[I].InfEvento.CNPJ;
        InfEvento.cOrgao := FEvento.Evento[I].InfEvento.cOrgao;
        InfEvento.chNFGas := FEvento.Evento[I].InfEvento.chNFGas;
        InfEvento.dhEvento := FEvento.Evento[I].InfEvento.dhEvento;
        InfEvento.tpEvento := FEvento.Evento[I].InfEvento.tpEvento;
        InfEvento.nSeqEvento := FEvento.Evento[I].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
            begin
              SchemaEventoNFGas := schevCancNFGas;
              InfEvento.detEvento.nProt := FEvento.Evento[I].InfEvento.detEvento.nProt;
              InfEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;
            end;
        else
          raise EACBrNFGasException.Create('Tipo de evento nao implementado para NFGas');
        end;
      end;
    end;

    EventoNFGas.Versao := FPVersaoServico;
    AjustarOpcoes(EventoNFGas.Opcoes);
    EventoNFGas.GerarXML;

    Eventos := NativeStringToUTF8(EventoNFGas.XmlEnvio);
    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos('</eventoNFGas>', Eventos);

      if F > 0 then
      begin
        Evento := Copy(Eventos, 1, F + 13);
        Eventos := Copy(Eventos, F + 14, length(Eventos));

        AssinarXML(Evento, 'eventoNFGas', 'infEvento', 'Falha ao assinar o Envio de Evento ');
        EventosAssinados := EventosAssinados + FPDadosMsg;
      end
      else
        Break;
    end;

    // Separa o XML especifico do Evento para ser Validado.
    AXMLEvento := SeparaDados(FPDadosMsg, 'detEvento');

    case SchemaEventoNFGas of
      schevCancNFGas:
        begin
          AXMLEvento := '<evCancNFGas xmlns="' + ACBRNFGAS_NAMESPACE + '">' +
                          Trim(RetornarConteudoEntre(AXMLEvento, '<evCancNFGas>', '</evCancNFGas>')) +
                        '</evCancNFGas>';
        end;
    else
      AXMLEvento := '';
    end;

    AXMLEvento := '<' + ENCODING_UTF8 + '>' + AXMLEvento;

    with TACBrNFGas(FPDFeOwner) do
    begin
      EventoEhValido := SSL.Validar(FPDadosMsg,
                                    GerarNomeArqSchema(FPLayout,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg) and
                        SSL.Validar(AXMLEvento,
                                    GerarNomeArqSchemaEvento(SchemaEventoNFGas,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg);
    end;

    if not EventoEhValido then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados do Evento: ') +
        FPMsg;

      raise EACBrNFGasException.CreateDef(FErroValidacao);
    end;

    for I := 0 to FEvento.Evento.Count - 1 do
      FEvento.Evento[I].InfEvento.id := EventoNFGas.Evento[I].InfEvento.id;
  finally
    EventoNFGas.Free;
  end;
end;

function TNFGasEnvEvento.TratarResposta: Boolean;
var
  I, J: Integer;
  NomeArq, PathArq, VersaoEvento, Texto: string;
begin
  FEvento.idLote := idLote;

  FPRetWS := SeparaDadosArray(['NFGasResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  EventoRetorno.XmlRetorno := ParseText(FPRetWS);
  EventoRetorno.LerXml;

  FcStat := EventoRetorno.retInfEvento.cStat;
  FxMotivo := EventoRetorno.retInfEvento.xMotivo;
  FPMsg := EventoRetorno.retInfEvento.xMotivo;
  FTpAmb := EventoRetorno.retInfEvento.tpAmb;

  Result := (FcStat = 128);

  //gerar arquivo proc de evento
  if Result then
  begin
    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      for J := 0 to EventoRetorno.retEvento.Count - 1 do
      begin
        if FEvento.Evento.Items[I].InfEvento.chNFGas =
          EventoRetorno.retEvento.Items[J].RetInfEvento.chNFGas then
        begin
          FEvento.Evento.Items[I].RetInfEvento.tpAmb := EventoRetorno.retEvento.Items[J].RetInfEvento.tpAmb;
          FEvento.Evento.Items[I].RetInfEvento.nProt := EventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
          FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := EventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
          FEvento.Evento.Items[I].RetInfEvento.cStat := EventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
          FEvento.Evento.Items[I].RetInfEvento.xMotivo := EventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;

          Texto := '';

          if EventoRetorno.retEvento.Items[J].RetInfEvento.cStat in [135, 136, 155] then
          begin
            VersaoEvento := TACBrNFGas(FPDFeOwner).LerVersaoDeParams(LayNFGasEvento);

            Texto := '<evento versao="' + VersaoEvento + '">' +
                         SeparaDados(FPDadosMsg, 'infEvento', True) +
                         '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
                         SeparaDados(FPDadosMsg, 'Signature', False) +
                         '</Signature>'+
                     '</evento>';

            Texto := Texto +
                       '<retEvento versao="' + VersaoEvento + '">' +
                          SeparaDados(FPRetWS, 'infEvento', True) +
                       '</retEvento>';

            Texto := '<procEventoNFGas versao="' + VersaoEvento + '" xmlns="' + ACBRNFGas_NAMESPACE + '">' +
                       Texto +
                     '</procEventoNFGas>';

            if FPConfiguracoesNFGas.Arquivos.SalvarEvento then
            begin
              NomeArq := RemoverLiteralChave(FEvento.Evento.Items[i].InfEvento.Id) + '-procEventoNFGas.xml';
              PathArq := PathWithDelim(GerarPathEvento(FEvento.Evento.Items[I].InfEvento.CNPJ));

              FPDFeOwner.Gravar(NomeArq, Texto, PathArq);
              FEventoRetorno.retEvento.Items[J].RetInfEvento.NomeArquivo := PathArq + NomeArq;
              FEvento.Evento.Items[I].RetInfEvento.NomeArquivo := PathArq + NomeArq;
            end;

            { Converte de UTF8 para a string nativa e Decodificar caracteres HTML Entity }
            Texto := ParseText(Texto);
          end;

          // Se o evento for rejeitado a propriedade XML conterá uma string vazia
          FEventoRetorno.retEvento.Items[J].RetInfEvento.XML := Texto;
          FEvento.Evento.Items[I].RetInfEvento.XML := Texto;

          break;
        end;
      end;
    end;
  end;
end;

function TNFGasEnvEvento.GerarMsgLog: string;
var
  aMsg: string;
begin
  {(*}
  aMsg := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                         'Ambiente: %s ' + sLineBreak +
                         'Versão Aplicativo: %s ' + sLineBreak +
                         'Status Código: %s ' + sLineBreak +
                         'Status Descrição: %s ' + sLineBreak),
                 [FEventoRetorno.versao, TipoAmbienteToStr(FEventoRetorno.retInfEvento.tpAmb),
                  FEventoRetorno.retInfEvento.verAplic, IntToStr(FEventoRetorno.retInfEvento.cStat),
                  FEventoRetorno.retInfEvento.xMotivo]);
  Result := aMsg;
  {*)}
end;

function TNFGasEnvEvento.GerarPrefixoArquivo: string;
begin
  Result := IntToStr(FIdLote);
end;

{ TNFGasEnvioWebService }

constructor TNFGasEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPStatus := stNFGasEnvioWebService;
end;

destructor TNFGasEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TNFGasEnvioWebService.Clear;
begin
  inherited Clear;

  FVersao := '';
end;

function TNFGasEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFGasEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TNFGasEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;
end;

procedure TNFGasEnvioWebService.DefinirDadosMsg;
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

function TNFGasEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');

  VerificarSemResposta;

  RemoverNameSpace;

  Result := True;
end;

function TNFGasEnvioWebService.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService: '+FPServico + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TNFGasEnvioWebService.GerarVersaoDadosSoap: string;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrNFGas := TACBrNFGas(AOwner);

  FStatusServico := TNFGasStatusServico.Create(FACBrNFGas);
  FEnviar := TNFGasRecepcao.Create(FACBrNFGas, TACBrNFGas(FACBrNFGas).NotasFiscais);
  FConsulta := TNFGasConsulta.Create(FACBrNFGas, TACBrNFGas(FACBrNFGas).NotasFiscais);
  FEnvEvento := TNFGasEnvEvento.Create(FACBrNFGas, TACBrNFGas(FACBrNFGas).EventoNFGas);
  FEnvioWebService := TNFGasEnvioWebService.Create(FACBrNFGas);
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

function TWebServices.Envia(const ALote: string): Boolean;
begin
  FEnviar.Clear;

  FEnviar.Lote := ALote;

  if not Enviar.Executar then
    Enviar.GerarException(Enviar.Msg);

  Result := True;
end;

end.
