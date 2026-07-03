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

unit ACBrNFGas;

interface

uses
  Classes, SysUtils, synautil,
  ACBrBase, ACBrDFe, ACBrDFeException, ACBrDFeConfiguracoes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGasConfiguracoes, ACBrNFGasWebServices, ACBrNFGasNotasFiscais,
  ACBrNFGasDANFGasClass,
  ACBrNFGas.Classes, ACBrNFGas.Conversao, ACBrNFGas.EnvEvento;

const
  ACBRNFGAS_NAMESPACE = 'http://www.portalfiscal.inf.br/nfgas';
  ACBRNFGAS_CErroAmbienteDiferente =
    'Ambiente do XML (tpAmb) é diferente do configurado no Componente (Configuracoes.WebServices.Ambiente)';

type
  EACBrNFGasException = class(EACBrDFeException);

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFGas = class(TACBrDFe)
  private
    FDANFGas: TACBrNFGasDANFGasClass;
    FNotasFiscais: TNotasFiscais;
    FEventoNFGas: TEventoNFGas;
    FStatus: TStatusNFGas;
    FWebServices: TWebServices;

    function GetConfiguracoes: TConfiguracoesNFGas;
    procedure SetConfiguracoes(AValue: TConfiguracoesNFGas);
    procedure SetDANFGas(const Value: TACBrNFGasDANFGasClass);
  protected
    function CreateConfiguracoes: TConfiguracoes; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function NomeServicoToNomeSchema(const NomeServico: string): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure EnviarEmail(const sPara, sAssunto: string;
      sMensagem: TStrings = nil; sCC: TStrings = nil; Anexos: TStrings = nil;
      StreamNFAg: TStream = nil; const NomeArq: string = '';
	  sReplyTo: TStrings = nil; sBCC: TStrings = nil); override;

    function GetNomeModeloDFe: string; override;
    function GetNameSpaceURI: string; override;

    function CstatConfirmada(AValue: integer): Boolean;
    function CstatProcessado(AValue: integer): Boolean;
    function CstatCancelada(AValue: integer): Boolean;

    function Enviar(const ALote: string; Imprimir: Boolean = True): Boolean;
    function Cancelamento(const AJustificativa: string; ALote: Int64 = 0): Boolean; overload;
    function Cancelamento(const AChave, AProtocolo, AJustificativa: string;
      ALote: Int64 = 0): Boolean; overload;
    function Consultar(const AChave: string = ''; AExtrairEventos: Boolean = False): Boolean;
    function EnviarEvento(idLote: Int64): Boolean;
    function StatusServico: Boolean;

    procedure LerServicoDeParams(LayOutServico: TLayOutNFGas; var Versao: Double;
      var URL: string; var Servico: string; var SoapAction: string); reintroduce; overload;
    function LerVersaoDeParams(LayOutServico: TLayOutNFGas): string; reintroduce; overload;

    function AjustarVersaoQRCode(AVersaoQRCode: TVersaoQrCode;
      AVersaoXML: TVersaoNFGas): TVersaoQrCode;
    function GetURLConsultaNFGas(const CUF: integer;
      const TipoAmbiente: TACBrTipoAmbiente;
      const Versao: Double): string;
    function GetURLQRCode(FNFGas: TNFGas): string;

    function IdentificaSchema(const AXML: string): TSchemaNFGas;
    function GerarNomeArqSchema(const ALayOut: TLayOutNFGas;
      VersaoServico: Double): string;
    function GerarNomeArqSchemaEvento(ASchemaEventoNFGas: TSchemaNFGas;
      VersaoServico: Double): string;

    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property EventoNFGas: TEventoNFGas read FEventoNFGas write FEventoNFGas;
    property Status: TStatusNFGas read FStatus;

    procedure SetStatus(const stNewStatus: TStatusNFGas);
    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmailEvento(const sPara, sAssunto: string;
      sMensagem: TStrings = nil; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil);
  published
    property Configuracoes: TConfiguracoesNFGas
      read GetConfiguracoes write SetConfiguracoes;
    property DANFGas: TACBrNFGasDANFGasClass read FDANFGas write SetDANFGas;
  end;

implementation

uses
  dateutils, math,
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeSSL;

{$R ACBrNFGasServicos.res}

{ TACBrNFGas }

constructor TACBrNFGas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FNotasFiscais := TNotasFiscais.Create(Self, TNotaFiscal);
  FEventoNFGas := TEventoNFGas.Create;
  FWebServices := TWebServices.Create(Self);
  FStatus := stNFGasIdle;
end;

destructor TACBrNFGas.Destroy;
begin
  FNotasFiscais.Free;
  FEventoNFGas.Free;
  FWebServices.Free;

  inherited Destroy;
end;

procedure TACBrNFGas.EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings;
  sCC: TStrings; Anexos: TStrings; StreamNFAg: TStream; const NomeArq: string;
  sReplyTo: TStrings; sBCC: TStrings);
begin
  SetStatus( stNFGasEmail );

  try
    inherited EnviarEmail(sPara, sAssunto, sMensagem, sCC, Anexos, StreamNFAg, NomeArq,
      sReplyTo, sBCC);
  finally
    SetStatus( stNFGasIdle );
  end;
end;

procedure TACBrNFGas.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFGas <> nil) and
     (AComponent is TACBrNFGasDANFGasClass) then
    FDANFGas := nil;
end;

function TACBrNFGas.CreateConfiguracoes: TConfiguracoes;
begin
  Result := TConfiguracoesNFGas.Create(Self);
end;

procedure TACBrNFGas.SetDANFGas(const Value: TACBrNFGasDANFGasClass);
var
  OldValue: TACBrNFGasDANFGasClass;
begin
  if Value <> FDANFGas then
  begin
    if Assigned(FDANFGas) then
      FDANFGas.RemoveFreeNotification(Self);

    OldValue := FDANFGas;   // Usa outra variavel para evitar Loop Infinito
    FDANFGas := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.ACBrNFGas) then
        OldValue.ACBrNFGas := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      Value.ACBrNFGas := self;
    end;
  end;
end;

function TACBrNFGas.GetNomeModeloDFe: string;
begin
  Result := 'NFGas';
end;

function TACBrNFGas.GetNameSpaceURI: string;
begin
  Result := ACBRNFGas_NAMESPACE;
end;

function TACBrNFGas.CstatConfirmada(AValue: integer): Boolean;
begin
  case AValue of
    100, 150: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFGas.CstatProcessado(AValue: integer): Boolean;
begin
  case AValue of
    100, 150: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFGas.CstatCancelada(AValue: integer): Boolean;
begin
  case AValue of
    101, 135, 151, 155: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFGas.IdentificaSchema(const AXML: string): TSchemaNFGas;
var
  lTipoEvento: string;
  I: integer;
begin
  Result := schNFGas;
  I := pos('<infNFGas', AXML);

  if I = 0 then
  begin
    I := Pos('<infEvento', AXML);

    if I > 0 then
    begin
      lTipoEvento := Trim(RetornarConteudoEntre(AXML, '<tpEvento>', '</tpEvento>'));

      if lTipoEvento = '110111' then
        Result := schevCancNFGas; // Cancelamento
    end;
  end;
end;

function TACBrNFGas.GerarNomeArqSchema(const ALayOut: TLayOutNFGas;
  VersaoServico: Double): string;
var
  NomeServico: string;
  NomeSchema: string;
  ArqSchema: string;
  Versao: Double;
begin
  NomeServico := LayOutNFGasToServico(ALayOut);
  NomeSchema := NomeServicoToNomeSchema(NomeServico);
  ArqSchema := '';

  if NaoEstaVazio(NomeSchema) then
  begin
    Versao := VersaoServico;
    AchaArquivoSchema(NomeSchema, Versao, ArqSchema);
  end;

  Result := ArqSchema;
end;

function TACBrNFGas.GerarNomeArqSchemaEvento(ASchemaEventoNFGas: TSchemaNFGas;
  VersaoServico: Double): string;
var
  xComplemento: string;
begin
  if VersaoServico = 0 then
    Result := ''
  else
  begin
    xComplemento := '';

    Result := PathWithDelim(Configuracoes.Arquivos.PathSchemas) +
      SchemaEventoToStr(ASchemaEventoNFGas) + xComplemento + '_v' +
      FloatToString(VersaoServico, '.', '0.00') + '.xsd';
  end;
end;

function TACBrNFGas.GetConfiguracoes: TConfiguracoesNFGas;
begin
  Result := TConfiguracoesNFGas(FPConfiguracoes);
end;

procedure TACBrNFGas.SetConfiguracoes(AValue: TConfiguracoesNFGas);
begin
  FPConfiguracoes := AValue;
end;

function TACBrNFGas.LerVersaoDeParams(LayOutServico: TLayOutNFGas): string;
var
  Versao: Double;
begin
  Versao := LerVersaoDeParams(GetNomeModeloDFe, Configuracoes.WebServices.UF,
    Configuracoes.WebServices.Ambiente, LayOutNFGasToServico(LayOutServico),
    VersaoNFGasToDbl(Configuracoes.Geral.VersaoDF));

  Result := FloatToString(Versao, '.', '0.00');
end;

function TACBrNFGas.AjustarVersaoQRCode(AVersaoQRCode: TVersaoQrCode;
  AVersaoXML: TVersaoNFGas): TVersaoQrCode;
begin
  if (AVersaoXML <= ve100) then
    Result := veqr100
  else     // ve100 ou superior
    Result := TVersaoQrCode(max(Integer(AVersaoQRCode), Integer(veqr100)));
end;

procedure TACBrNFGas.LerServicoDeParams(LayOutServico: TLayOutNFGas;
  var Versao: Double; var URL: string; var Servico: string;
  var SoapAction: string);
var
  AUF: string;
begin
  case Configuracoes.Geral.FormaEmissao of
    teNormal: AUF := Configuracoes.WebServices.UF;
    teSVCAN: AUF := 'SVC-AN';
    teSVCRS: AUF := 'SVC-RS';
  else
    AUF := Configuracoes.WebServices.UF;
  end;

  Versao := VersaoNFGasToDbl(Configuracoes.Geral.VersaoDF);
  URL := '';
  Servico := '';
  SoapAction := '';

  LerServicoDeParams(GetNomeModeloDFe, AUF,
    Configuracoes.WebServices.Ambiente, LayOutNFGasToServico(LayOutServico),
    Versao, URL, Servico, SoapAction);
end;

function TACBrNFGas.GetURLConsultaNFGas(const CUF: integer;
  const TipoAmbiente: TACBrTipoAmbiente; const Versao: Double): string;
var
  VersaoDFe: TVersaoNFGas;
  VersaoQrCode: TVersaoQrCode;
begin
  VersaoDFe := DblToVersaoNFGas(Versao);
  VersaoQrCode := AjustarVersaoQRCode(Configuracoes.Geral.VersaoQRCode, VersaoDFe);

  Result := LerURLDeParams('NFGas', CodigoUFparaUF(CUF), TipoAmbiente,
    'URL-ConsultaNFGas', VersaoQrCodeToDbl(VersaoQrCode));
end;

function TACBrNFGas.GetURLQRCode(FNFGas: TNFGas): string;
var
  idNFAg, sEntrada, urlUF, Passo2, sign: string;
  VersaoDFe: TVersaoNFGas;
  VersaoQrCode: TVersaoQrCode;
begin
  VersaoDFe := DblToVersaoNFGas(FNFGas.infNFGas.Versao);
  VersaoQrCode := AjustarVersaoQRCode(Configuracoes.Geral.VersaoQRCode, VersaoDFe);

  urlUF := LerURLDeParams('NFGas', CodigoUFparaUF(FNFGas.Ide.cUF), FNFGas.Ide.tpAmb,
    'URL-QRCode', VersaoQrCodeToDbl(VersaoQrCode));

  if Pos('?', urlUF) <= 0 then
    urlUF := urlUF + '?';

  idNFAg := Copy(FNFGas.infNFGas.ID, 6, 44);

  // Passo 1
  sEntrada := 'chNFGas=' + idNFAg + '&tpAmb=' + TipoAmbienteToStr(FNFGas.Ide.tpAmb);

  // Passo 2 calcular o SHA-1 da string idCTe se o Tipo de Emissão for EPEC ou FSDA
  if FNFGas.Ide.tpEmis = teOffLine then
  begin
    // Tipo de Emissão em Contingência
    SSL.CarregarCertificadoSeNecessario;
    sign := SSL.CalcHash(idNFAg, dgstSHA1, outBase64, True);
    Passo2 := '&sign=' + sign;

    sEntrada := sEntrada + Passo2;
  end;

  Result := urlUF + sEntrada;
end;

function TACBrNFGas.GravarStream(AStream: TStream): Boolean;
begin
  if EstaVazio(FEventoNFGas.XmlEnvio) then
    FEventoNFGas.GerarXML;

  AStream.Size := 0;
  WriteStrToStream(AStream, AnsiString(FEventoNFGas.XmlEnvio));
  Result := True;
end;

procedure TACBrNFGas.SetStatus(const stNewStatus: TStatusNFGas);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;

    if Assigned(OnStatusChange) then
      OnStatusChange(Self);
  end;
end;

function TACBrNFGas.Cancelamento(const AJustificativa: string; ALote: Int64): Boolean;
var
  I: Integer;
begin
  if NotasFiscais.Count = 0 then
    raise EACBrNFGasException.Create('ERRO: Nenhuma NFGas informada');

  Result := True;
  for I := 0 to NotasFiscais.Count - 1 do
  begin
    WebServices.Consulta.NFGasChave := NotasFiscais.Items[I].NumID;
    WebServices.Consulta.Executar;

    Result := Cancelamento(
      WebServices.Consulta.NFGasChave,
      WebServices.Consulta.Protocolo,
      AJustificativa,
      ALote
    );
  end;
end;

function TACBrNFGas.Cancelamento(const AChave, AProtocolo,
  AJustificativa: string; ALote: Int64): Boolean;
var
  ChaveCancelamento: string;
begin
  ChaveCancelamento := RemoverLiteralChave(AChave);

  if EstaVazio(ChaveCancelamento) then
    raise EACBrNFGasException.Create('ERRO: Chave da NFGas nao informada');

  if not ValidarChave(ChaveCancelamento) then
    raise EACBrNFGasException.Create('ERRO: Chave da NFGas invalida');

  if Trim(AProtocolo) = '' then
    raise EACBrNFGasException.Create('ERRO: Protocolo de autorizacao nao informado');

  EventoNFGas.Evento.Clear;
  with EventoNFGas.Evento.New do
  begin
    InfEvento.CNPJ := ExtrairCNPJCPFChaveAcesso(ChaveCancelamento);
    InfEvento.cOrgao := StrToIntDef(Copy(ChaveCancelamento, 1, 2), 0);
    InfEvento.dhEvento := Now;
    InfEvento.tpEvento := teCancelamento;
    InfEvento.chNFGas := ChaveCancelamento;
    InfEvento.detEvento.nProt := Trim(AProtocolo);
    InfEvento.detEvento.xJust := AJustificativa;
  end;

  if not EnviarEvento(ALote) then
    raise EACBrNFGasException.Create(WebServices.EnvEvento.Msg);

  Result := True;
end;

function TACBrNFGas.Consultar(const AChave: string; AExtrairEventos: Boolean): Boolean;
var
  i: integer;
begin
  if (NotasFiscais.Count = 0) and EstaVazio(AChave) then
    GerarException(ACBrStr('ERRO: Nenhuma NFGas ou Chave Informada!'));

  if NaoEstaVazio(AChave) then
  begin
    NotasFiscais.Clear;
    WebServices.Consulta.NFGasChave := AChave;
    WebServices.Consulta.ExtrairEventos := AExtrairEventos;
    WebServices.Consulta.Executar;
  end
  else
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      WebServices.Consulta.NFGasChave := NotasFiscais.Items[i].NumID;
      WebServices.Consulta.ExtrairEventos := AExtrairEventos;
      WebServices.Consulta.Executar;
    end;
  end;

  Result := True;
end;

function TACBrNFGas.Enviar(const ALote: string; Imprimir: Boolean): Boolean;
var
 i: Integer;
begin
  WebServices.Enviar.Clear;

  if NotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhuma NFGas adicionada ao Lote'));

  if NotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NFGas transmitidos (máximo de 1 NFGas)' +
      ' excedido. Quantidade atual: ' + IntToStr(NotasFiscais.Count)));

  NotasFiscais.Assinar;
  NotasFiscais.Validar;

  Result := WebServices.Envia(ALote);

  if DANFGas <> nil then
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      if NotasFiscais[i].Confirmada and Imprimir then
        NotasFiscais[i].Imprimir;
    end;
  end;
end;

function TACBrNFGas.StatusServico: Boolean;
begin
  WebServices.StatusServico.Clear;

  if not WebServices.StatusServico.Executar then
    raise EACBrNFGasException.Create(WebServices.StatusServico.Msg);

  Result := True;
end;

function TACBrNFGas.EnviarEvento(idLote: Int64): Boolean;
var
  I, J: Integer;
  ChNFGas: string;
begin
  if EventoNFGas.Evento.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum Evento adicionado ao Lote'));

  if EventoNFGas.Evento.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de Eventos transmitidos (máximo de 20) ' +
      'excedido. Quantidade atual: ' + IntToStr(EventoNFGas.Evento.Count)));

  WebServices.EnvEvento.IdLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for I := 0 to EventoNFGas.Evento.Count - 1 do
  begin
    if EventoNFGas.Evento.Items[I].InfEvento.nSeqEvento = 0 then
      EventoNFGas.Evento.Items[I].InfEvento.nSeqEvento := 1;

    EventoNFGas.Evento.Items[I].InfEvento.tpAmb := Configuracoes.WebServices.Ambiente;

    if NotasFiscais.Count > 0 then
    begin
      ChNFGas := RemoverLiteralChave(EventoNFGas.Evento.Items[I].InfEvento.chNFGas);

      // Se tem a chave da NFGas no Evento, procure por ela nas notas carregadas //
      if NaoEstaVazio(ChNFGas) then
      begin
        for j := 0 to NotasFiscais.Count - 1 do
        begin
          if ChNFGas = NotasFiscais.Items[j].NumID then
            Break;
        end ;

        if j = NotasFiscais.Count then
          GerarException( ACBrStr('Não existe NFAg com a chave ['+ChNFGas+'] carregada') );
      end
      else
        j := 0;

      if trim(EventoNFGas.Evento.Items[i].InfEvento.CNPJ) = '' then
        EventoNFGas.Evento.Items[i].InfEvento.CNPJ := NotasFiscais.Items[j].NFGas.Emit.CNPJ;

      if ChNFGas = '' then
        EventoNFGas.Evento.Items[i].InfEvento.chNFGas := NotasFiscais.Items[j].NumID;

      if trim(EventoNFGas.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EventoNFGas.Evento.Items[i].infEvento.tpEvento = teCancelamento then
        begin
          EventoNFGas.Evento.Items[i].infEvento.detEvento.nProt := NotasFiscais.Items[j].NFGas.procNFGas.nProt;

          if trim(EventoNFGas.Evento.Items[i].infEvento.detEvento.nProt) = '' then
          begin
            WebServices.Consulta.NFGasChave := EventoNFGas.Evento.Items[i].InfEvento.chNFGas;

            if not WebServices.Consulta.Executar then
              GerarException(WebServices.Consulta.Msg);

            EventoNFGas.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
          end;
        end;
      end;
    end;
  end;

  Result := WebServices.EnvEvento.Executar;

  if not Result then
    GerarException( WebServices.EnvEvento.Msg );
end;

function TACBrNFGas.NomeServicoToNomeSchema(const NomeServico: string): string;
var
  ALayOut: TLayOutNFGas;
begin
  ALayOut := ServicoToLayOutNFGas(NomeServico);
  Result := SchemaNFGasToStr(LayOutNFGasToSchema(ALayOut));
end;

procedure TACBrNFGas.ImprimirEvento;
begin
  if not Assigned(DANFGas) then
    GerarException('Componente DANFGas não associado.')
  else
    DANFGas.ImprimirEVENTO(nil);
end;

procedure TACBrNFGas.ImprimirEventoPDF;
begin
  if not Assigned(DANFGas) then
    GerarException('Componente DANFGas não associado.')
  else
    DANFGas.ImprimirEVENTOPDF(nil);
end;

procedure TACBrNFGas.EnviarEmailEvento(const sPara, sAssunto: string;
  sMensagem: TStrings; sCC: TStrings; Anexos: TStrings;
  sReplyTo: TStrings);
var
  NomeArq: string;
  AnexosEmail: TStrings;
  StreamNFAg : TMemoryStream;
begin
  AnexosEmail := TStringList.Create;
  StreamNFAg := TMemoryStream.Create;
  try
    AnexosEmail.Clear;

    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;

    GravarStream(StreamNFAg);

    ImprimirEventoPDF;
    AnexosEmail.Add(DANFGas.ArquivoPDF);

    NomeArq := RemoverLiteralChave(EventoNFGas.Evento[0].InfEvento.Id);
    EnviarEmail(sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFAg,
  	  NomeArq + '-procEventoNFGas.xml', sReplyTo);
  finally
    AnexosEmail.Free;
    StreamNFAg.Free;
  end;
end;

end.
