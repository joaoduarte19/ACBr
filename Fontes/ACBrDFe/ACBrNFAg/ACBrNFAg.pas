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

unit ACBrNFAg;

interface

uses
  Classes, SysUtils, synautil,
  ACBrBase, ACBrDFe, ACBrDFeException, ACBrDFeConfiguracoes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAgConfiguracoes, ACBrNFAgWebServices, ACBrNFAgNotasFiscais,
  ACBrNFAgDANFAgClass,
  ACBrNFAg.Classes, ACBrNFAg.Conversao, ACBrNFAg.EnvEvento;

const
  ACBRNFAG_NAMESPACE = 'http://www.portalfiscal.inf.br/nfag';
  ACBRNFAG_CErroAmbienteDiferente = 'Ambiente do XML (tpAmb) é diferente do '+
     'configurado no Componente (Configuracoes.WebServices.Ambiente)';

type
  EACBrNFAgException = class(EACBrDFeException);

  { TACBrNFAg }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFAg = class(TACBrDFe)
  private
    FDANFAg: TACBrNFAgDANFAgClass;
    FNotasFiscais: TNotasFiscais;
    FEventoNFAg: TEventoNFAg;
    FStatus: TStatusNFAg;
    FWebServices: TWebServices;

    function GetConfiguracoes: TConfiguracoesNFAg;

    procedure SetConfiguracoes(AValue: TConfiguracoesNFAg);
    procedure SetDANFAg(const Value: TACBrNFAgDANFAgClass);
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
    function Cancelamento(const AJustificativa: string; ALote: Int64 = 0): Boolean;
    function Consultar(const AChave: string = ''; AExtrairEventos: Boolean = False): Boolean;
    function EnviarEvento(idLote: Int64): Boolean;

    procedure LerServicoDeParams(LayOutServico: TLayOut; var Versao: Double;
      var URL: string; var Servico: string; var SoapAction: string); reintroduce; overload;
    function LerVersaoDeParams(LayOutServico: TLayOut): string; reintroduce; overload;

    function AjustarVersaoQRCode( AVersaoQRCode: TVersaoQrCode;
      AVersaoXML: TVersaoNFAg): TVersaoQrCode;
    function GetURLConsultaNFAg(const CUF: integer;
      const TipoAmbiente: TACBrTipoAmbiente;
      const Versao: Double): string;
    function GetURLQRCode(FNFAg: TNFAg): string;

    function IdentificaSchema(const AXML: string): TSchemaNFAg;
    function GerarNomeArqSchema(const ALayOut: TLayOut; VersaoServico: Double): string;
    function GerarNomeArqSchemaEvento(ASchemaEventoNFAg: TSchemaNFAg; VersaoServico: Double): string;

    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property EventoNFAg: TEventoNFAg read FEventoNFAg write FEventoNFAg;
    property Status: TStatusNFAg read FStatus;

    procedure SetStatus(const stNewStatus: TStatusNFAg);
    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmailEvento(const sPara, sAssunto: string;
      sMensagem: TStrings = nil; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil);

  published
    property Configuracoes: TConfiguracoesNFAg
      read GetConfiguracoes write SetConfiguracoes;
    property DANFAg: TACBrNFAgDANFAgClass read FDANFAg write SetDANFAg;
  end;

implementation

uses
  dateutils, math,
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeSSL;

{$R ACBrNFAgServicos.res}

{ TACBrNFAg }

constructor TACBrNFAg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FNotasFiscais := TNotasFiscais.Create(Self, TNotaFiscal);
  FEventoNFAg := TEventoNFAg.Create;
  FWebServices := TWebServices.Create(Self);
end;

destructor TACBrNFAg.Destroy;
begin
  FNotasFiscais.Free;
  FEventoNFAg.Free;
  FWebServices.Free;

  inherited;
end;

procedure TACBrNFAg.EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings;
  sCC: TStrings; Anexos: TStrings; StreamNFAg: TStream; const NomeArq: string;
  sReplyTo: TStrings; sBCC: TStrings);
begin
  SetStatus( stNFAgEmail );

  try
    inherited EnviarEmail(sPara, sAssunto, sMensagem, sCC, Anexos, StreamNFAg, NomeArq,
      sReplyTo, sBCC);
  finally
    SetStatus( stIdle );
  end;
end;

procedure TACBrNFAg.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFAg <> nil) and
     (AComponent is TACBrNFAgDANFAgClass) then
    FDANFAg := nil;
end;

function TACBrNFAg.CreateConfiguracoes: TConfiguracoes;
begin
  Result := TConfiguracoesNFAg.Create(Self);
end;

procedure TACBrNFAg.SetDANFAg(const Value: TACBrNFAgDANFAgClass);
var
  OldValue: TACBrNFAgDANFAgClass;
begin
  if Value <> FDANFAg then
  begin
    if Assigned(FDANFAg) then
      FDANFAg.RemoveFreeNotification(Self);

    OldValue := FDANFAg;   // Usa outra variavel para evitar Loop Infinito
    FDANFAg := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.ACBrNFAg) then
        OldValue.ACBrNFAg := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      Value.ACBrNFAg := self;
    end;
  end;
end;

function TACBrNFAg.GetNomeModeloDFe: string;
begin
  Result := 'NFAg';
end;

function TACBrNFAg.GetNameSpaceURI: string;
begin
  Result := ACBRNFAg_NAMESPACE;
end;

function TACBrNFAg.CstatConfirmada(AValue: integer): Boolean;
begin
  case AValue of
    100, 150: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFAg.CstatProcessado(AValue: integer): Boolean;
begin
  case AValue of
    100, 150: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFAg.CstatCancelada(AValue: integer): Boolean;
begin
  case AValue of
    101, 135, 151, 155: Result := True;
  else
    Result := False;
  end;
end;

function TACBrNFAg.IdentificaSchema(const AXML: string): TSchemaNFAg;
var
  lTipoEvento: string;
  I: integer;
begin
  Result := schNFAg;
  I := pos('<infNFGas', AXML);

  if I = 0 then
  begin
    I := Pos('<infEvento', AXML);

    if I > 0 then
    begin
      lTipoEvento := Trim(RetornarConteudoEntre(AXML, '<tpEvento>', '</tpEvento>'));

      if lTipoEvento = '110111' then
        Result := schCancNFAg; // Cancelamento
    end;
  end;
end;

function TACBrNFAg.GerarNomeArqSchema(const ALayOut: TLayOut;
  VersaoServico: Double): string;
var
  NomeServico, NomeSchema, ArqSchema: string;
  Versao: Double;
begin
  // Procura por Versão na pasta de Schemas //
  NomeServico := LayOutToServico(ALayOut);
  NomeSchema := NomeServicoToNomeSchema(NomeServico);
  ArqSchema := '';

  if NaoEstaVazio(NomeSchema) then
  begin
    Versao := VersaoServico;
    AchaArquivoSchema(NomeSchema, Versao, ArqSchema);
  end;

  Result := ArqSchema;
end;

function TACBrNFAg.GerarNomeArqSchemaEvento(ASchemaEventoNFAg: TSchemaNFAg;
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
              SchemaEventoToStr(ASchemaEventoNFAg) + xComplemento + '_v' +
              FloatToString(VersaoServico, '.', '0.00') + '.xsd';
  end;
end;

function TACBrNFAg.GetConfiguracoes: TConfiguracoesNFAg;
begin
  Result := TConfiguracoesNFAg(FPConfiguracoes);
end;

procedure TACBrNFAg.SetConfiguracoes(AValue: TConfiguracoesNFAg);
begin
  FPConfiguracoes := AValue;
end;

function TACBrNFAg.LerVersaoDeParams(LayOutServico: TLayOut): string;
var
  Versao: Double;
begin
  Versao := LerVersaoDeParams(GetNomeModeloDFe, Configuracoes.WebServices.UF,
    Configuracoes.WebServices.Ambiente, LayOutToServico(LayOutServico),
    VersaoNFAgToDbl(Configuracoes.Geral.VersaoDF));

  Result := FloatToString(Versao, '.', '0.00');
end;

function TACBrNFAg.AjustarVersaoQRCode(AVersaoQRCode: TVersaoQrCode;
  AVersaoXML: TVersaoNFAg): TVersaoQrCode;
begin
  if (AVersaoXML <= ve100) then
    Result := veqr100
  else     // ve100 ou superior
    Result := TVersaoQrCode(max(Integer(AVersaoQRCode), Integer(veqr100)));
end;

procedure TACBrNFAg.LerServicoDeParams(LayOutServico: TLayOut;
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

  Versao := VersaoNFAgToDbl(Configuracoes.Geral.VersaoDF);
  URL := '';
  Servico := '';
  SoapAction := '';

  LerServicoDeParams(GetNomeModeloDFe, AUF,
    Configuracoes.WebServices.Ambiente, LayOutToServico(LayOutServico),
    Versao, URL, Servico, SoapAction);
end;

function TACBrNFAg.GetURLConsultaNFAg(const CUF: integer;
  const TipoAmbiente: TACBrTipoAmbiente; const Versao: Double): string;
var
  VersaoDFe: TVersaoNFAg;
  VersaoQrCode: TVersaoQrCode;
begin
  VersaoDFe := DblToVersaoNFAg(Versao);
  VersaoQrCode := AjustarVersaoQRCode(Configuracoes.Geral.VersaoQRCode, VersaoDFe);

  Result := LerURLDeParams('NFAg', CodigoUFparaUF(CUF), TipoAmbiente,
    'URL-ConsultaNFAg', VersaoQrCodeToDbl(VersaoQrCode));
end;

function TACBrNFAg.GetURLQRCode(FNFAg: TNFAg): string;
var
  idNFAg, sEntrada, urlUF, Passo2, sign: string;
  VersaoDFe: TVersaoNFAg;
  VersaoQrCode: TVersaoQrCode;
begin
  VersaoDFe := DblToVersaoNFAg(FNFAg.infNFAg.Versao);
  VersaoQrCode := AjustarVersaoQRCode(Configuracoes.Geral.VersaoQRCode, VersaoDFe);

  urlUF := LerURLDeParams('NFAg', CodigoUFparaUF(FNFAg.Ide.cUF), FNFAg.Ide.tpAmb,
    'URL-QRCode', VersaoQrCodeToDbl(VersaoQrCode));

  if Pos('?', urlUF) <= 0 then
    urlUF := urlUF + '?';

  idNFAg := Copy(FNFAg.infNFAg.ID, 5, 44);

  // Passo 1
  sEntrada := 'chNFAg=' + idNFAg + '&tpAmb=' + TipoAmbienteToStr(FNFAg.Ide.tpAmb);

  // Passo 2 calcular o SHA-1 da string idCTe se o Tipo de Emissão for EPEC ou FSDA
  if FNFAg.Ide.tpEmis = teOffLine then
  begin
    // Tipo de Emissão em Contingência
    SSL.CarregarCertificadoSeNecessario;
    sign := SSL.CalcHash(idNFAg, dgstSHA1, outBase64, True);
    Passo2 := '&sign=' + sign;

    sEntrada := sEntrada + Passo2;
  end;

  Result := urlUF + sEntrada;
end;

function TACBrNFAg.GravarStream(AStream: TStream): Boolean;
begin
  if EstaVazio(FEventoNFAg.XmlEnvio) then
    FEventoNFAg.GerarXML;

  AStream.Size := 0;
  WriteStrToStream(AStream, AnsiString(FEventoNFAg.XmlEnvio));
  Result := True;
end;

procedure TACBrNFAg.SetStatus(const stNewStatus: TStatusNFAg);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;

    if Assigned(OnStatusChange) then
      OnStatusChange(Self);
  end;
end;

function TACBrNFAg.Cancelamento(const AJustificativa: string; ALote: Int64 = 0): Boolean;
var
  i: integer;
begin
  if NotasFiscais.Count = 0 then
    GerarException(ACBrStr('ERRO: Nenhuma NFAg Informada!'));

  for i := 0 to NotasFiscais.Count - 1 do
  begin
    WebServices.Consulta.NFAgChave := NotasFiscais.Items[i].NumID;

    if not WebServices.Consulta.Executar then
      GerarException(WebServices.Consulta.Msg);

    EventoNFAg.Evento.Clear;
    with EventoNFAg.Evento.New do
    begin
      infEvento.CNPJ     := NotasFiscais.Items[i].NFAg.Emit.CNPJ;
      infEvento.cOrgao   := ExtrairUFChaveAcesso(WebServices.Consulta.NFAgChave);
      infEvento.dhEvento := now;
      infEvento.tpEvento := teCancelamento;
      infEvento.chNFAg   := WebServices.Consulta.NFAgChave;

      infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
      infEvento.detEvento.xJust := AJustificativa;
    end;

    try
      EnviarEvento(ALote);
    except
      GerarException(WebServices.EnvEvento.EventoRetorno.retInfEvento.xMotivo);
    end;
  end;

  Result := True;
end;

function TACBrNFAg.Consultar(const AChave: string; AExtrairEventos: Boolean): Boolean;
var
  i: integer;
begin
  if (NotasFiscais.Count = 0) and EstaVazio(AChave) then
    GerarException(ACBrStr('ERRO: Nenhuma NFAg ou Chave Informada!'));

  if NaoEstaVazio(AChave) then
  begin
    NotasFiscais.Clear;
    WebServices.Consulta.NFAgChave      := AChave;
    WebServices.Consulta.ExtrairEventos := AExtrairEventos;
    WebServices.Consulta.Executar;
  end
  else
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      WebServices.Consulta.NFAgChave      := NotasFiscais.Items[i].NumID;
      WebServices.Consulta.ExtrairEventos := AExtrairEventos;
      WebServices.Consulta.Executar;
    end;
  end;

  Result := True;
end;

function TACBrNFAg.Enviar(const ALote: string; Imprimir: Boolean): Boolean;
var
  i: integer;
begin
  WebServices.Enviar.Clear;

  if NotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhuma NFAg adicionada ao Lote'));

  if NotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NFAg transmitidos (máximo de 1 NFAg)' +
      ' excedido. Quantidade atual: ' + IntToStr(NotasFiscais.Count)));

  NotasFiscais.Assinar;
  NotasFiscais.Validar;

  Result := WebServices.Envia(ALote);

  if DANFAg <> nil then
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      if NotasFiscais[i].Confirmada and Imprimir then
        NotasFiscais[i].Imprimir;
    end;
  end;

end;

function TACBrNFAg.EnviarEvento(idLote: Int64): Boolean;
var
  i, j: integer;
  chNFAg: string;
begin
  if EventoNFAg.Evento.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum Evento adicionado ao Lote'));

  if EventoNFAg.Evento.Count > 20 then
    GerarException(ACBrStr('ERRO: Conjunto de Eventos transmitidos (máximo de 20) ' +
      'excedido. Quantidade atual: ' + IntToStr(EventoNFAg.Evento.Count)));

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i := 0 to EventoNFAg.Evento.Count - 1 do
  begin
    if EventoNFAg.Evento.Items[i].infEvento.nSeqEvento = 0 then
      EventoNFAg.Evento.Items[i].infEvento.nSeqEvento := 1;

    FEventoNFAg.Evento.Items[i].InfEvento.tpAmb := Configuracoes.WebServices.Ambiente;

    if NotasFiscais.Count > 0 then
    begin
      chNFAg := RemoverLiteralChave(EventoNFAg.Evento.Items[i].InfEvento.chNFAg);

      // Se tem a chave da NFAg no Evento, procure por ela nas notas carregadas //
      if NaoEstaVazio(chNFAg) then
      begin
        for j := 0 to NotasFiscais.Count - 1 do
        begin
          if chNFAg = NotasFiscais.Items[j].NumID then
            Break;
        end ;

        if j = NotasFiscais.Count then
          GerarException( ACBrStr('Não existe NFAg com a chave ['+chNFAg+'] carregada') );
      end
      else
        j := 0;

      if trim(EventoNFAg.Evento.Items[i].InfEvento.CNPJ) = '' then
        EventoNFAg.Evento.Items[i].InfEvento.CNPJ := NotasFiscais.Items[j].NFAg.Emit.CNPJ;

      if chNFAg = '' then
        EventoNFAg.Evento.Items[i].InfEvento.chNFAg := NotasFiscais.Items[j].NumID;

      if trim(EventoNFAg.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EventoNFAg.Evento.Items[i].infEvento.tpEvento = teCancelamento then
        begin
          EventoNFAg.Evento.Items[i].infEvento.detEvento.nProt := NotasFiscais.Items[j].NFAg.procNFAg.nProt;

          if trim(EventoNFAg.Evento.Items[i].infEvento.detEvento.nProt) = '' then
          begin
            WebServices.Consulta.NFAgChave := EventoNFAg.Evento.Items[i].InfEvento.chNFAg;

            if not WebServices.Consulta.Executar then
              GerarException(WebServices.Consulta.Msg);

            EventoNFAg.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
          end;
        end;
      end;
    end;
  end;

  Result := WebServices.EnvEvento.Executar;

  if not Result then
    GerarException( WebServices.EnvEvento.Msg );
end;

function TACBrNFAg.NomeServicoToNomeSchema(const NomeServico: string): string;
var
  ALayout: TLayOut;
begin
  ALayout := ServicoToLayOut(NomeServico);

  Result := SchemaNFAgToStr( LayOutToSchema( ALayout ) )
end;

procedure TACBrNFAg.ImprimirEvento;
begin
  if not Assigned(DANFAg) then
    GerarException('Componente DANFAg não associado.')
  else
    DANFAg.ImprimirEVENTO(nil);
end;

procedure TACBrNFAg.ImprimirEventoPDF;
begin
  if not Assigned(DANFAg) then
    GerarException('Componente DANFAg não associado.')
  else
    DANFAg.ImprimirEVENTOPDF(nil);
end;

procedure TACBrNFAg.EnviarEmailEvento(const sPara, sAssunto: string;
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
    AnexosEmail.Add(DANFAg.ArquivoPDF);

    NomeArq := RemoverLiteralChave(EventoNFAg.Evento[0].InfEvento.Id);
    EnviarEmail(sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFAg,
  	  NomeArq + '-procEventoNFAg.xml', sReplyTo);
  finally
    AnexosEmail.Free;
    StreamNFAg.Free;
  end;
end;

end.

