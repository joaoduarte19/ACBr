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

unit ACBrNFAgWebServices;

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
  ACBrNFAgNotasFiscais, ACBrNFAgConfiguracoes,
  ACBrNFAg.Classes, ACBrNFAg.Conversao,
  ACBrNFAg.EnvEvento, ACBrNFAg.RetEnvEvento,
  ACBrNFAg.RetConsSit;

type

  { TNFAgWebService }

  TNFAgWebService = class(TDFeWebService)
  private
    FOldSSLType: TSSLType;
    FOldHeaderElement: string;
  protected
    FPStatus: TStatusNFAg;
    FPLayout: TLayOut;
    FPConfiguracoesNFAg: TConfiguracoesNFAg;

  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: string; override;
    procedure FinalizarServico; override;
    procedure RemoverNameSpace;

  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusNFAg read FPStatus;
    property Layout: TLayOut read FPLayout;
  end;

  { TNFAgStatusServico }

  TNFAgStatusServico = class(TNFAgWebService)
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

  { TNFAgRecepcao }

  TNFAgRecepcao = class(TNFAgWebService)
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
    FVersaoDF: TVersaoNFAg;

    FNFAgRetornoSincrono: TRetConsSitNFAg;
    FNFAgRetorno: TretEnvDFe;
    FMsgUnZip: string;

    FNProt: string;
    FChNFAg: string;
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
    property MsgUnZip: string read FMsgUnZip write FMsgUnZip;
    property NFAgRetornoSincrono: TRetConsSitNFAg read FNFAgRetornoSincrono;

    property Protocolo: string read FProtocolo;
    property NProt: string read FNProt;
    property ChNFAg: string read FChNFAg;
    property XMLRetorno: string read FXMLRetorno;
  end;

  { TNFAgConsulta }

  TNFAgConsulta = class(TNFAgWebService)
  private
    FOwner: TACBrDFe;
    FNFAgChave: string;
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
    FRetNFAgDFe: string;

    FprotNFAg: TProcDFe;
    FprocEventoNFAg: TRetEventoNFAgCollection;
    FNFAgRetorno: TRetConsSitNFAg;

    procedure SetNFAgChave(const AValue: string);
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

    property NFAgChave: string read FNFAgChave write SetNFAgChave;
    property ExtrairEventos: Boolean read FExtrairEventos write FExtrairEventos;
    property Protocolo: string read FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto;
    property XMotivo: string read FXMotivo;
    property versao: string read Fversao;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: string read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property RetNFAgDFe: string read FRetNFAgDFe;

    property protNFAg: TProcDFe read FprotNFAg;
    property procEventoNFAg: TRetEventoNFAgCollection read FprocEventoNFAg;
  end;

  { TNFAgEnvEvento }

  TNFAgEnvEvento = class(TNFAgWebService)
  private
    FIdLote: Int64;
    FEvento: TEventoNFAg;
    FcStat: Integer;
    FxMotivo: string;
    FTpAmb: TACBrTipoAmbiente;
    FCNPJ: string;

    FEventoRetorno: TRetEventoNFAg;

    function GerarPathEvento(const ACNPJ: string = ''; const AIE: string = ''): string;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: string; override;
    function GerarPrefixoArquivo: string; override;
  public
    constructor Create(AOwner: TACBrDFe; AEvento: TEventoNFAg); reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property IdLote: Int64 read FIdLote write FIdLote;
    property cStat: Integer read FcStat;
    property xMotivo: string read FxMotivo;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property EventoRetorno: TRetEventoNFAg read FEventoRetorno;
  end;

  { TNFAgEnvioWebService }

  TNFAgEnvioWebService = class(TNFAgWebService)
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
    FACBrNFAg: TACBrDFe;
    FStatusServico: TNFAgStatusServico;
    FEnviar: TNFAgRecepcao;
    FConsulta: TNFAgConsulta;
    FEnvEvento: TNFAgEnvEvento;
    FEnvioWebService: TNFAgEnvioWebService;
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function Envia(const ALote: string): Boolean;

    property ACBrNFAg: TACBrDFe read FACBrNFAg write FACBrNFAg;
    property StatusServico: TNFAgStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFAgRecepcao read FEnviar write FEnviar;
    property Consulta: TNFAgConsulta read FConsulta write FConsulta;
    property EnvEvento: TNFAgEnvEvento read FEnvEvento write FEnvEvento;
    property EnvioWebService: TNFAgEnvioWebService read FEnvioWebService write FEnvioWebService;
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
  ACBrNFAg,
  ACBrNFAg.Consts,
  ACBrNFAg.ConsSit;

{ TNFAgWebService }

constructor TNFAgWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesNFAg := TConfiguracoesNFAg(FPConfiguracoes);
  FPLayout := LayNFAgStatusServico;

  FPHeaderElement := '';
  FPBodyElement := 'nfagDadosMsg';
end;

procedure TNFAgWebService.Clear;
begin
  inherited Clear;

  FPStatus := stIdle;
  if Assigned(FPDFeOwner) and Assigned(FPDFeOwner.SSL) then
    FPDFeOwner.SSL.UseCertificateHTTP := True;
end;

procedure TNFAgWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }
  inherited InicializarServico;

  FOldSSLType := FPDFeOwner.SSL.SSLType;
  FOldHeaderElement := FPHeaderElement;

  FPHeaderElement := '';

  TACBrNFAg(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TNFAgWebService.RemoverNameSpace;
begin
  FPRetWS := StringReplace(FPRetWS, ' xmlns="http://www.portalfiscal.inf.br/NFAg"',
                                    '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TNFAgWebService.DefinirURL;
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

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL, FPServico, FPSoapAction);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TNFAgWebService.GerarVersaoDadosSoap: string;
begin
  { Sobrescrever apenas se necessário }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrNFAg(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

procedure TNFAgWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  // Retornar configurações anteriores
  FPDFeOwner.SSL.SSLType := FOldSSLType;
  FPHeaderElement := FOldHeaderElement;

  TACBrNFAg(FPDFeOwner).SetStatus(stIdle);
end;

{ TNFAgStatusServico }

procedure TNFAgStatusServico.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgStatusServico;
  FPLayout := LayNFAgStatusServico;
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

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end
end;

procedure TNFAgStatusServico.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgStatusServico';
  FPSoapAction := FPServico + '/nfagStatusServicoNF';
end;

procedure TNFAgStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAg', False);
  try
    ConsStatServ.TpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    ConsStatServ.CUF := FPConfiguracoesNFAg.WebServices.UFCodigo;

    FPDadosMsg := ConsStatServ.GerarXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TNFAgStatusServico.TratarResposta: Boolean;
var
  NFAgRetorno: TRetConsStatServ;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

  if EstaVazio(FPRetWS) then
    FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');

  VerificarSemResposta;

  RemoverNameSpace;

  NFAgRetorno := TRetConsStatServ.Create('NFAg');
  try
    NFAgRetorno.XmlRetorno := ParseText(FPRetWS);
    NFAgRetorno.LerXml;

    Fversao := NFAgRetorno.versao;
    FtpAmb := NFAgRetorno.tpAmb;
    FverAplic := NFAgRetorno.verAplic;
    FcStat := NFAgRetorno.cStat;
    FxMotivo := NFAgRetorno.xMotivo;
    FcUF := NFAgRetorno.cUF;

    { WebService do RS retorna horário de verão mesmo pros estados que não
      adotam esse horário, ao utilizar esta hora para basear a emissão da nota
      acontece o erro. }
    if (Pos('svrs.rs.gov.br', FPURL) > 0) and
       (MinutesBetween(NFAgRetorno.dhRecbto, Now) > 50) and
       (not IsHorarioDeVerao(CodigoUFparaUF(FcUF), NFAgRetorno.dhRecbto)) then
      FdhRecbto := IncHour(NFAgRetorno.dhRecbto,-1)
    else
      FdhRecbto := NFAgRetorno.dhRecbto;

    FTMed := NFAgRetorno.TMed;
    FdhRetorno := NFAgRetorno.dhRetorno;
    FxObs := NFAgRetorno.xObs;
    FPMsg := FxMotivo + sLineBreak + FxObs;

    if Assigned(FPConfiguracoesNFAg) and
       Assigned(FPConfiguracoesNFAg.WebServices) and
       FPConfiguracoesNFAg.WebServices.AjustaAguardaConsultaRet then
      FPConfiguracoesNFAg.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);

  finally
    NFAgRetorno.Free;
  end;
end;

function TNFAgStatusServico.GerarMsgLog: string;
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

function TNFAgStatusServico.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService Consulta Status serviço:' + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TNFAgRecepcao }

constructor TNFAgRecepcao.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFAgRecepcao.Destroy;
begin
  FNFAgRetornoSincrono.Free;
  FNFAgRetorno.Free;

  inherited Destroy;
end;

procedure TNFAgRecepcao.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgRecepcao;
  FPLayout := LayNFAgRecepcao;
  FPArqEnv := 'env';
  FPArqResp := 'rec';

  FNProt := '';
  FChNFAg := '';
  FXMLRetorno := '';
  FMsgUnZip := '';
  Fversao := '';
  FTMed := 0;
  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FdhRecbto := 0;
  FTMed := 0;

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FNFAgRetornoSincrono) then
    FNFAgRetornoSincrono.Free;

  if Assigned(FNFAgRetorno) then
    FNFAgRetorno.Free;

  FNFAgRetornoSincrono := TRetConsSitNFAg.Create;
  FNFAgRetorno := TretEnvDFe.Create;
end;

function TNFAgRecepcao.GetLote: string;
begin
  Result := Trim(FLote);
end;

procedure TNFAgRecepcao.InicializarServico;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFAg(FNotasFiscais.Items[0].NFAg.infNFAg.Versao)
  else
    FVersaoDF := FPConfiguracoesNFAg.Geral.VersaoDF;

  inherited InicializarServico;

  FPHeaderElement := '';
end;

procedure TNFAgRecepcao.DefinirURL;
var
  xUF: string;
  VerServ: Double;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFAg.Ide.cUF;

    if Integer(FPConfiguracoesNFAg.WebServices.Ambiente) <>
       Integer(FNotasFiscais.Items[0].NFAg.Ide.tpAmb) then
      raise EACBrNFAgException.Create(ACBrNFAg_CErroAmbienteDiferente);
  end
  else
  begin // Se não tem NFAg, use as configurações do componente
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  VerServ := VersaoNFAgToDbl(FVersaoDF);
  FTpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  FPLayout := LayNFAgRecepcao;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgRecepcao.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgRecepcao';
  FPSoapAction := FPServico + '/nfagRecepcao';
end;

procedure TNFAgRecepcao.DefinirDadosMsg;
begin
  // No envio só podemos ter apena UM NFAg, pois o seu processamento é síncrono
  if FNotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NFAg transmitidos (máximo de 1 NFAg)' +
           ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  if FNotasFiscais.Count > 0 then
    FPDadosMsg := '<NFAg' +
      RetornarConteudoEntre(FNotasFiscais.Items[0].XMLAssinado, '<NFAg', '</NFAg>') +
      '</NFAg>';

  FMsgUnZip := FPDadosMsg;
  FPDadosMsg := EncodeBase64(GZipCompress(FPDadosMsg));

  // Lote tem mais de 1 Mb ? //
  if Length(FPDadosMsg) > (1024 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 1 Mbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));
end;

function TNFAgRecepcao.TratarResposta: Boolean;
var
  I: Integer;
  chNFAg, AXML, NomeXMLSalvo: string;
  AProcNFAg: TProcDFe;
  SalvarXML: Boolean;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'], FPRetornoWS );

  if pos('retNFAg', FPRetWS) > 0 then
    AXML := StringReplace(FPRetWS, 'retNFAg', 'retConsSitNFAg',
                                   [rfReplaceAll, rfIgnoreCase])
  else if pos('retConsReciNFAg', FPRetWS) > 0 then
    AXML := StringReplace(FPRetWS, 'retConsReciNFAg', 'retConsSitNFAg',
                                   [rfReplaceAll, rfIgnoreCase])
  else
    AXML := FPRetWS;

  FNFAgRetornoSincrono.XmlRetorno := ParseText(AXML);
  FNFAgRetornoSincrono.LerXml;

  Fversao := FNFAgRetornoSincrono.versao;
  FTpAmb := FNFAgRetornoSincrono.TpAmb;
  FverAplic := FNFAgRetornoSincrono.verAplic;

  FcUF := FNFAgRetornoSincrono.cUF;
  chNFAg := FNFAgRetornoSincrono.ProtNFAg.chDFe;

  if (FNFAgRetornoSincrono.protNFAg.cStat > 0) then
    FcStat := FNFAgRetornoSincrono.protNFAg.cStat
  else
    FcStat := FNFAgRetornoSincrono.cStat;

  if (FNFAgRetornoSincrono.protNFAg.xMotivo <> '') then
  begin
    FPMsg := FNFAgRetornoSincrono.protNFAg.xMotivo;
    FxMotivo := FNFAgRetornoSincrono.protNFAg.xMotivo;
  end
  else
  begin
    FPMsg := FNFAgRetornoSincrono.xMotivo;
    FxMotivo := FNFAgRetornoSincrono.xMotivo;
  end;

  // Verificar se a NFAg foi autorizada com sucesso
  Result := (FNFAgRetornoSincrono.cStat = 104) and
    (TACBrNFAg(FPDFeOwner).CstatProcessado(FNFAgRetornoSincrono.protNFAg.cStat));

  if Result then
  begin
    // Pega o numero do protocolo
    FProtocolo := FNFAgRetornoSincrono.ProtNFAg.nProt;

    for I := 0 to TACBrNFAg(FPDFeOwner).NotasFiscais.Count - 1 do
    begin
      with TACBrNFAg(FPDFeOwner).NotasFiscais.Items[I] do
      begin
        if RemoverLiteralChave(chNFAg) = NumID then
        begin
          if (FPConfiguracoesNFAg.Geral.ValidarDigest) and
             (FNFAgRetornoSincrono.protNFAg.digVal <> '') and
             (NFAg.signature.DigestValue <> FNFAgRetornoSincrono.protNFAg.digVal) then
          begin
            raise EACBrNFAgException.Create('DigestValue do documento ' + NumID + ' não confere.');
          end;

          NFAg.procNFAg.cStat := FNFAgRetornoSincrono.protNFAg.cStat;
          NFAg.procNFAg.tpAmb := FNFAgRetornoSincrono.tpAmb;
          NFAg.procNFAg.verAplic := FNFAgRetornoSincrono.verAplic;
          NFAg.procNFAg.chDFe := FNFAgRetornoSincrono.ProtNFAg.chDFe;
          NFAg.procNFAg.dhRecbto := FNFAgRetornoSincrono.protNFAg.dhRecbto;
          NFAg.procNFAg.nProt := FNFAgRetornoSincrono.ProtNFAg.nProt;
          NFAg.procNFAg.digVal := FNFAgRetornoSincrono.protNFAg.digVal;
          NFAg.procNFAg.xMotivo := FNFAgRetornoSincrono.protNFAg.xMotivo;

          AProcNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
          try
            // Processando em UTF8, para poder gravar arquivo corretamente //
            AProcNFAg.XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
            AProcNFAg.XML_Prot := FNFAgRetornoSincrono.XMLprotNFAg;
            XMLOriginal := AProcNFAg.GerarXML;

            if FPConfiguracoesNFAg.Arquivos.Salvar then
            begin
              SalvarXML := Processada;

              // Salva o XML da NFAg assinado e protocolado
              if SalvarXML then
              begin
                NomeXMLSalvo := '';
                if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                begin
                  FPDFeOwner.Gravar( NomeArq, XMLOriginal ); // Atualiza o XML carregado
                  NomeXMLSalvo := NomeArq;
                end;

                if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                  GravarXML; // Salva na pasta baseado nas configurações do PathNFAg
              end;
            end ;
          finally
            AProcNFAg.Free;
          end;

          Break;
        end;
      end;
    end;
  end;
end;

function TNFAgRecepcao.GerarMsgLog: string;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + sLineBreak +
                         'Ambiente: %s ' + sLineBreak +
                         'Versão Aplicativo: %s ' + sLineBreak +
                         'Status Código: %s ' + sLineBreak +
                         'Status Descrição: %s ' + sLineBreak +
                         'UF: %s ' + sLineBreak +
                         'dhRecbto: %s ' + sLineBreak +
                         'Protocolo: %s ' + sLineBreak +
                         'chNFAg: %s ' + sLineBreak),
                   [versao,
                    TipoAmbienteToStr(TpAmb),
                    verAplic,
                    IntToStr(cStat),
                    xMotivo,
                    CodigoUFparaUF(cUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    FNProt,
                    chNFAg]);
end;

function TNFAgRecepcao.GerarPrefixoArquivo: string;
begin
  Result := Lote;
  FPArqResp := 'pro-lot';
end;

{ TNFAgConsulta }

constructor TNFAgConsulta.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
  FNotasFiscais := ANotasFiscais;

  if Assigned(FNFAgRetorno) then
    FNFAgRetorno.Free;
end;

destructor TNFAgConsulta.Destroy;
begin
  FprotNFAg.Free;
  FprocEventoNFAg.Free;

  inherited Destroy;
end;

procedure TNFAgConsulta.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgConsulta;
  FPLayout := LayNFAgConsulta;
  FPArqEnv := 'ped-sit';
  FPArqResp := 'sit';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FProtocolo := '';
  FDhRecbto := 0;
  Fversao := '';
  FRetNFAgDFe := '';

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FprotNFAg) then
    FprotNFAg.Free;

  if Assigned(FprocEventoNFAg) then
    FprocEventoNFAg.Free;

  FprotNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAG, 'NFAgProc', 'NFAg');
  FprocEventoNFAg := TRetEventoNFAgCollection.Create;
end;

procedure TNFAgConsulta.SetNFAgChave(const AValue: string);
var
  NumChave: string;
begin
  if FNFAgChave = AValue then Exit;

  NumChave := RemoverLiteralChave(AValue);

  if not ValidarChave(NumChave) then
    raise EACBrNFAgException.Create('Chave "' + AValue + '" inválida.');

  FNFAgChave := NumChave;
end;

procedure TNFAgConsulta.DefinirURL;
var
  VerServ: Double;
  xUF: string;
begin
  FPVersaoServico := '';
  FPURL := '';

  FcUF := ExtrairUFChaveAcesso(FNFAgChave);
  VerServ := VersaoNFAgToDbl(FPConfiguracoesNFAg.Geral.VersaoDF);

  if FNotasFiscais.Count > 0 then
    FTpAmb := FNotasFiscais.Items[0].NFAg.Ide.tpAmb
  else
    FTpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;

  // Se a nota foi enviada para o SVC a consulta tem que ser realizada no SVC e
  // não na SEFAZ-Autorizadora
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgConsulta.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgConsulta';
  FPSoapAction := FPServico + '/nfagConsultaNF';
end;

procedure TNFAgConsulta.DefinirDadosMsg;
var
  ConsSitNFAg: TConsSitNFAg;
begin
  ConsSitNFAg := TConsSitNFAg.Create;
  try
    ConsSitNFAg.TpAmb := TACBrTipoAmbiente(FTpAmb);
    ConsSitNFAg.chNFAg := FNFAgChave;
    ConsSitNFAg.Versao := FPVersaoServico;

    FPDadosMsg := ConsSitNFAg.GerarXML;
  finally
    ConsSitNFAg.Free;
  end;
end;

function TNFAgConsulta.GerarUFSoap: string;
begin
  Result := '<cUF>' + IntToStr(FcUF) + '</cUF>';
end;

function TNFAgConsulta.TratarResposta: Boolean;

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
    Inicio := Pos('<procEventoNFAg', Retorno);
    Fim    := Pos('</procEventoNFAg>', Retorno) + 15;

    aEvento := Copy(Retorno, Inicio, Fim - Inicio + 1);

    Retorno := Copy(Retorno, Fim + 1, Length(Retorno));

    aProcEvento := '<procEventoNFAg versao="' + FVersao + '" xmlns="' + ACBRNFAg_NAMESPACE + '">' +
                      SeparaDados(aEvento, 'procEventoNFAg') +
                   '</procEventoNFAg>';

    Inicio := Pos('Id=', aProcEvento) + 6;
    Fim    := 52;

    if Inicio = 6 then
      aIDEvento := FormatDateTime('yyyymmddhhnnss', Now)
    else
      aIDEvento := Copy(aProcEvento, Inicio, Fim);

    TipoEvento  := StrToTpEventoNFAg(Ok, SeparaDados(aEvento, 'tpEvento'));
    DhEvt       := EncodeDataHora(SeparaDados(aEvento, 'dhEvento'), 'YYYY-MM-DD');
    sCNPJCPF    := SeparaDados(aEvento, 'CNPJ');

    if EstaVazio(sCNPJCPF) then
      sCNPJCPF := SeparaDados(aEvento, 'CPF');   

    sPathEvento := PathWithDelim(FPConfiguracoesNFAg.Arquivos.GetPathEvento(TipoEvento, sCNPJCPF, '', DhEvt));

    if FPConfiguracoesNFAg.Arquivos.SalvarEvento and (aProcEvento <> '') then
      FPDFeOwner.Gravar( aIDEvento + '-procEventoNFAg.xml', aProcEvento, sPathEvento);
  end;
end;

var
  SalvarXML, NFCancelada, Atualiza: Boolean;
  aEventos, sPathNFAg, NomeXMLSalvo: string;
  AProcNFAg: TProcDFe;
  I, Inicio, Fim: Integer;
  dhEmissao: TDateTime;
begin
  FNFAgRetorno := TRetConsSitNFAg.Create;

  try
    FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

    FNFAgRetorno.XmlRetorno := ParseText(FPRetWS);
    FNFAgRetorno.LerXML;

    NFCancelada := False;
    aEventos := '';

    // <retConsSitNFAg> - Retorno da consulta da situação da NFAg
    // Este é o status oficial da NFAg
    Fversao := FNFAgRetorno.versao;
    FTpAmb := FNFAgRetorno.tpAmb;
    FverAplic := FNFAgRetorno.verAplic;
    FcStat := FNFAgRetorno.cStat;
    FXMotivo := FNFAgRetorno.xMotivo;
    FcUF := FNFAgRetorno.cUF;
    FNFAgChave := FNFAgRetorno.chNFAg;
    FPMsg := FXMotivo;

    // <protNFAg> - Retorno dos dados do ENVIO da NFAg
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFAg.PathDFe := FNFAgRetorno.protNFAg.PathDFe;
    FprotNFAg.PathRetConsReciDFe := FNFAgRetorno.protNFAg.PathRetConsReciDFe;
    FprotNFAg.PathRetConsSitDFe := FNFAgRetorno.protNFAg.PathRetConsSitDFe;
    FprotNFAg.tpAmb := FNFAgRetorno.protNFAg.tpAmb;
    FprotNFAg.verAplic := FNFAgRetorno.protNFAg.verAplic;
    FprotNFAg.chDFe := FNFAgRetorno.protNFAg.chDFe;
    FprotNFAg.dhRecbto := FNFAgRetorno.protNFAg.dhRecbto;
    FprotNFAg.nProt := FNFAgRetorno.protNFAg.nProt;
    FprotNFAg.digVal := FNFAgRetorno.protNFAg.digVal;
    FprotNFAg.cStat := FNFAgRetorno.protNFAg.cStat;
    FprotNFAg.xMotivo := FNFAgRetorno.protNFAg.xMotivo;

    if Assigned(FNFAgRetorno.procEventoNFAg) and (FNFAgRetorno.procEventoNFAg.Count > 0) then
    begin
      aEventos := '=====================================================' +
        sLineBreak + '================== Eventos da NFAg ==================' +
        sLineBreak + '=====================================================' +
        sLineBreak + '' + sLineBreak + 'Quantidade total de eventos: ' +
        IntToStr(FNFAgRetorno.procEventoNFAg.Count);

      FprocEventoNFAg.Clear;
      for I := 0 to FNFAgRetorno.procEventoNFAg.Count - 1 do
      begin
        with FprocEventoNFAg.New.RetEventoNFAg.retInfEvento do
        begin
//          idLote := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.idLote;
          tpAmb := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.tpAmb;
          verAplic := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.verAplic;
          cOrgao := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.cOrgao;
          cStat := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.cStat;
          xMotivo := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.xMotivo;
          XML := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.XML;

          ID := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.ID;
          tpAmb := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.tpAmb;
//          CNPJ := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.CNPJ;
          chNFAg := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.chNFAg;
//          dhEvento := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.dhEvento;
          TpEvento := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.TpEvento;
          nSeqEvento := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.nSeqEvento;
          nProt := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.nProt;
//          xJust := FNFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.xJust;

          {
          retEvento.Clear;
          for J := 0 to NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Count-1 do
          begin
            with retEvento.New.RetInfEvento do
            begin
              Id := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.Id;
              tpAmb := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.tpAmb;
              verAplic := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.verAplic;
              cOrgao := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.cOrgao;
              cStat := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.cStat;
              xMotivo := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.xMotivo;
              chNFAg := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.chNFAg;
              tpEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.tpEvento;
              xEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.xEvento;
              nSeqEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.nSeqEvento;
              CNPJDest := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.CNPJDest;
              emailDest := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.emailDest;
              dhRegEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.dhRegEvento;
              nProt := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.nProt;
              XML := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.XML;
            end;
          end;
          }
        end;

        {
        with NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg do
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
              NFCancelada := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;
          end;
        end;
        }
      end;
    end;

    if (not NFCancelada) and (NaoEstaVazio(FNFAgRetorno.protNFAg.nProt))  then
    begin
      FProtocolo := FNFAgRetorno.protNFAg.nProt;
      FDhRecbto := FNFAgRetorno.protNFAg.dhRecbto;
      FPMsg := FNFAgRetorno.protNFAg.xMotivo;
    end;

    if not Assigned(FPDFeOwner) then //evita AV caso não atribua o Owner
    begin
     Result := True;
     Exit;
    end;

    with TACBrNFAg(FPDFeOwner) do
    begin
      Result := CstatProcessado(FNFAgRetorno.CStat) or
                CstatCancelada(FNFAgRetorno.CStat);
    end;

    if Result then
    begin
      if TACBrNFAg(FPDFeOwner).NotasFiscais.Count > 0 then
      begin
        for i := 0 to TACBrNFAg(FPDFeOwner).NotasFiscais.Count - 1 do
        begin
          with TACBrNFAg(FPDFeOwner).NotasFiscais.Items[i] do
          begin
            if (RemoverLiteralChave(FNFAgChave) = NumID) then
            begin
              Atualiza := (NaoEstaVazio(FNFAgRetorno.XMLprotNFAg));

              if Atualiza and
                 TACBrNFAg(FPDFeOwner).CstatCancelada(FNFAgRetorno.CStat) then
                Atualiza := False;

              // No retorno pode constar que a nota esta cancelada, mas traz o grupo
              // <protNFAg> com as informações da sua autorização
              if not Atualiza and TACBrNFAg(FPDFeOwner).cstatProcessado(FNFAgRetorno.protNFAg.cStat) then
                Atualiza := True;

              if (FPConfiguracoesNFAg.Geral.ValidarDigest) and
                (FNFAgRetorno.protNFAg.digVal <> '') and (NFAg.signature.DigestValue <> '') and
                (UpperCase(NFAg.signature.DigestValue) <> UpperCase(FNFAgRetorno.protNFAg.digVal)) then
              begin
                raise EACBrNFAgException.Create('DigestValue do documento ' +
                  NumID + ' não confere.');
              end;

              // Atualiza o Status da NFAg interna //
              NFAg.procNFAg.cStat := FNFAgRetorno.cStat;

              if Atualiza then
              begin
                if TACBrNFAg(FPDFeOwner).CstatCancelada(FNFAgRetorno.CStat) then
                begin
                  NFAg.procNFAg.tpAmb := FNFAgRetorno.tpAmb;
                  NFAg.procNFAg.verAplic := FNFAgRetorno.verAplic;
                  NFAg.procNFAg.chDFe := FNFAgRetorno.chNFAg;
                  NFAg.procNFAg.dhRecbto := FDhRecbto;
                  NFAg.procNFAg.nProt := FProtocolo;
                  NFAg.procNFAg.digVal := FNFAgRetorno.protNFAg.digVal;
                  NFAg.procNFAg.cStat := FNFAgRetorno.cStat;
                  NFAg.procNFAg.xMotivo := FNFAgRetorno.xMotivo;
   
                  GerarXML;
                end
                else
                begin
                  NFAg.procNFAg.tpAmb := FNFAgRetorno.protNFAg.tpAmb;
                  NFAg.procNFAg.verAplic := FNFAgRetorno.protNFAg.verAplic;
                  NFAg.procNFAg.chDFe := FNFAgRetorno.protNFAg.chDFe;
                  NFAg.procNFAg.dhRecbto := FNFAgRetorno.protNFAg.dhRecbto;
                  NFAg.procNFAg.nProt := FNFAgRetorno.protNFAg.nProt;
                  NFAg.procNFAg.digVal := FNFAgRetorno.protNFAg.digVal;
                  NFAg.procNFAg.cStat := FNFAgRetorno.protNFAg.cStat;
                  NFAg.procNFAg.xMotivo := FNFAgRetorno.protNFAg.xMotivo;

                  // O código abaixo é bem mais rápido que "GerarXML" (acima)...
                  AProcNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
                  try
                    AProcNFAg.XML_DFe := RemoverDeclaracaoXML(XMLOriginal);
                    AProcNFAg.XML_Prot := FNFAgRetorno.XMLprotNFAg;

                    XMLOriginal := AProcNFAg.GerarXML;
                  finally
                    AProcNFAg.Free;
                  end;
                end;
              end;

              { Se no retorno da consulta constar que a nota possui eventos vinculados
               será disponibilizado na propriedade FRetNFAgDFe, e conforme configurado
               em "ConfiguracoesNFAg.Arquivos.Salvar", também será gerado o arquivo:
               <chave>-NFAgDFe.xml}

              FRetNFAgDFe := '';

              if (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFAg'))) then
              begin
                Inicio := Pos('<procEventoNFAg', FPRetWS);
                Fim    := Pos('</retConsSitNFAg', FPRetWS) -1;

                aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

                FRetNFAgDFe := '<' + ENCODING_UTF8 + '>' +
                              '<NFAgDFe>' +
                               '<NFAgProc versao="' + FVersao + '">' +
                                 SeparaDados(XMLOriginal, 'NFAgProc') +
                               '</NFAgProc>' +
                               '<procEventoNFAg versao="' + FVersao + '">' +
                                 aEventos +
                               '</procEventoNFAg>' +
                              '</NFAgDFe>';
              end;

              SalvarXML := Result and FPConfiguracoesNFAg.Arquivos.Salvar and Atualiza;

              if SalvarXML then
              begin
                // Salva o XML da NFAg assinado, protocolado e com os eventos
                if FPConfiguracoesNFAg.Arquivos.EmissaoPathNFAg then
                  dhEmissao := NFAg.Ide.dhEmi
                else
                  dhEmissao := Now;

                sPathNFAg := PathWithDelim(FPConfiguracoesNFAg.Arquivos.GetPathNFAg(dhEmissao, NFAg.Emit.CNPJ));

                if (FRetNFAgDFe <> '') then
                  FPDFeOwner.Gravar( FNFAgChave + '-NFAgDFe.xml', FRetNFAgDFe, sPathNFAg);

                if Atualiza then
                begin
                  // Salva o XML da NFAg assinado e protocolado
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal );  // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  // Salva na pasta baseado nas configurações do PathNFAg
                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML;

                  // Salva o XML de eventos retornados ao consultar um NFAg
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
        if ExtrairEventos and FPConfiguracoesNFAg.Arquivos.SalvarEvento and
           (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFAg'))) then
        begin
          Inicio := Pos('<procEventoNFAg', FPRetWS);
          Fim    := Pos('</retConsSitNFAg', FPRetWS) -1;

          aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

          // Salva o XML de eventos retornados ao consultar um NFAg
          SalvarEventos(aEventos);
        end;
      end;
    end;
  finally
    Result := True;
    FNFAgRetorno.Free;
  end;
end;

function TNFAgConsulta.GerarMsgLog: string;
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
                   [Fversao, FNFAgChave, TipoAmbienteToStr(FTpAmb), FverAplic,
                    IntToStr(FcStat), FXMotivo, CodigoUFparaUF(FcUF), FNFAgChave,
                    FormatDateTimeBr(FDhRecbto), FProtocolo, FprotNFAg.digVal]);
  {*)}
end;

function TNFAgConsulta.GerarPrefixoArquivo: string;
begin
  Result := Trim(FNFAgChave);
end;

{ TNFAgEnvEvento }

constructor TNFAgEnvEvento.Create(AOwner: TACBrDFe; AEvento: TEventoNFAg);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TNFAgEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  inherited Destroy;
end;

procedure TNFAgEnvEvento.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgEvento;
  FPLayout := LayNFAgEvento;
  FPArqEnv := 'ped-eve';
  FPArqResp := 'eve';

  FcStat := 0;
  FxMotivo := '';
  FCNPJ := '';

  if Assigned(FPConfiguracoesNFAg) then
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;

  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  FEventoRetorno := TRetEventoNFAg.Create;
end;

function TNFAgEnvEvento.GerarPathEvento(const ACNPJ: string; const AIE: string): string;
begin
  with FEvento.Evento.Items[0].InfEvento do
  begin
    Result := FPConfiguracoesNFAg.Arquivos.GetPathEvento(tpEvento, ACNPJ, AIE);
  end;
end;

procedure TNFAgEnvEvento.DefinirURL;
var
  UF: string;
  VerServ: Double;
begin
  FPLayout := LayNFAgEvento;
  VerServ  := VersaoNFAgToDbl(FPConfiguracoesNFAg.Geral.VersaoDF);
  FCNPJ    := FEvento.Evento.Items[0].InfEvento.CNPJ;
  FTpAmb   := FEvento.Evento.Items[0].InfEvento.tpAmb;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: UF := 'SVC-AN';
    teSVCRS: UF := 'SVC-RS';
  else
    UF := CodigoUFparaUF(ExtrairUFChaveAcesso(FEvento.Evento.Items[0].InfEvento.chNFAg));
  end;

  FPURL := '';

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    UF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgEnvEvento.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgRecepcaoEvento';
  FPSoapAction := FPServico + '/nfagRecepcaoEvento';
end;

procedure TNFAgEnvEvento.DefinirDadosMsg;
var
  EventoNFAg: TEventoNFAg;
  I, F: Integer;
  Evento, Eventos, EventosAssinados, AXMLEvento: AnsiString;
  FErroValidacao: string;
  EventoEhValido: Boolean;
  SchemaEventoNFAg: TSchemaNFAg;
begin
  EventoNFAg := TEventoNFAg.Create;
  try
    EventoNFAg.idLote := FidLote;
    SchemaEventoNFAg  := schErro;

    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      with EventoNFAg.Evento.New do
      begin
        InfEvento.tpAmb := FTpAmb;
        infEvento.CNPJ := FEvento.Evento[I].InfEvento.CNPJ;
        infEvento.cOrgao := FEvento.Evento[I].InfEvento.cOrgao;
        infEvento.chNFAg := FEvento.Evento[I].InfEvento.chNFAg;
        infEvento.dhEvento := FEvento.Evento[I].InfEvento.dhEvento;
        infEvento.tpEvento := FEvento.Evento[I].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[I].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
            begin
              SchemaEventoNFAg := schCancNFAg;
              infEvento.detEvento.nProt := FEvento.Evento[I].InfEvento.detEvento.nProt;
              infEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;
            end;
        end;
      end;
    end;

    EventoNFAg.Versao := FPVersaoServico;
    AjustarOpcoes(EventoNFAg.Opcoes);
    EventoNFAg.GerarXML;

    Eventos := NativeStringToUTF8(EventoNFAg.XmlEnvio);
    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos('</eventoNFAg>', Eventos);

      if F > 0 then
      begin
        Evento := Copy(Eventos, 1, F + 12);
        Eventos := Copy(Eventos, F + 13, length(Eventos));

        AssinarXML(Evento, 'eventoNFAg', 'infEvento', 'Falha ao assinar o Envio de Evento ');
        EventosAssinados := EventosAssinados + FPDadosMsg;
      end
      else
        Break;
    end;

    // Separa o XML especifico do Evento para ser Validado.
    AXMLEvento := SeparaDados(FPDadosMsg, 'detEvento');

    case SchemaEventoNFAg of
      schCancNFAg:
        begin
          AXMLEvento := '<evCancNFAg xmlns="' + ACBRNFAg_NAMESPACE + '">' +
                          Trim(RetornarConteudoEntre(AXMLEvento, '<evCancNFAg>', '</evCancNFAg>')) +
                        '</evCancNFAg>';
        end;
    else
      AXMLEvento := '';
    end;

    AXMLEvento := '<' + ENCODING_UTF8 + '>' + AXMLEvento;

    with TACBrNFAg(FPDFeOwner) do
    begin
      EventoEhValido := SSL.Validar(FPDadosMsg,
                                    GerarNomeArqSchema(FPLayout,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg) and
                        SSL.Validar(AXMLEvento,
                                    GerarNomeArqSchemaEvento(SchemaEventoNFAg,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg);
    end;

    if not EventoEhValido then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados do Evento: ') +
        FPMsg;

      raise EACBrNFAgException.CreateDef(FErroValidacao);
    end;

    for I := 0 to FEvento.Evento.Count - 1 do
      FEvento.Evento[I].InfEvento.id := EventoNFAg.Evento[I].InfEvento.id;
  finally
    EventoNFAg.Free;
  end;
end;

function TNFAgEnvEvento.TratarResposta: Boolean;
var
  I, J: Integer;
  NomeArq, PathArq, VersaoEvento, Texto: string;
begin
  FEvento.idLote := idLote;

  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

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
        if FEvento.Evento.Items[I].InfEvento.chNFAg =
          EventoRetorno.retEvento.Items[J].RetInfEvento.chNFAg then
        begin
          FEvento.Evento.Items[I].RetInfEvento.tpAmb := EventoRetorno.retEvento.Items[J].RetInfEvento.tpAmb;
          FEvento.Evento.Items[I].RetInfEvento.nProt := EventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
          FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := EventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
          FEvento.Evento.Items[I].RetInfEvento.cStat := EventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
          FEvento.Evento.Items[I].RetInfEvento.xMotivo := EventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;

          Texto := '';

          if EventoRetorno.retEvento.Items[J].RetInfEvento.cStat in [135, 136, 155] then
          begin
            VersaoEvento := TACBrNFAg(FPDFeOwner).LerVersaoDeParams(LayNFAgEvento);

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

            Texto := '<procEventoNFAg versao="' + VersaoEvento + '" xmlns="' + ACBRNFAg_NAMESPACE + '">' +
                       Texto +
                     '</procEventoNFAg>';

            if FPConfiguracoesNFAg.Arquivos.SalvarEvento then
            begin
              NomeArq := RemoverLiteralChave(FEvento.Evento.Items[i].InfEvento.Id) + '-procEventoNFAg.xml';
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

function TNFAgEnvEvento.GerarMsgLog: string;
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

function TNFAgEnvEvento.GerarPrefixoArquivo: string;
begin
  Result := IntToStr(FidLote);
end;

{ TNFAgEnvioWebService }

constructor TNFAgEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPStatus := stEnvioWebService;
end;

destructor TNFAgEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TNFAgEnvioWebService.Clear;
begin
  inherited Clear;

  FVersao := '';
end;

function TNFAgEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFAgEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TNFAgEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;
end;

procedure TNFAgEnvioWebService.DefinirDadosMsg;
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

function TNFAgEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');

  VerificarSemResposta;

  RemoverNameSpace;

  Result := True;
end;

function TNFAgEnvioWebService.GerarMsgErro(E: Exception): string;
begin
  Result := ACBrStr('WebService: '+FPServico + sLineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TNFAgEnvioWebService.GerarVersaoDadosSoap: string;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrNFAg := TACBrNFAg(AOwner);

  FStatusServico := TNFAgStatusServico.Create(FACBrNFAg);
  FEnviar := TNFAgRecepcao.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FConsulta := TNFAgConsulta.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FEnvEvento := TNFAgEnvEvento.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).EventoNFAg);
  FEnvioWebService := TNFAgEnvioWebService.Create(FACBrNFAg);
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
