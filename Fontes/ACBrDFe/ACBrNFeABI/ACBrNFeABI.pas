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

unit ACBrNFeABI;

interface

uses
  Classes, SysUtils, synautil,
  ACBrDFe, ACBrDFeConfiguracoes, ACBrDFeException, ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFeABIConfiguracoes, ACBrNFeABIWebServices, ACBrNFeABINotasFiscais,
  ACBrNFeABI.DANFEABIClass, ACBrNFeABI.Classes, ACBrNFeABI.Conversao,
  ACBrNFeABI.EventoClass,
  ACBrNFeABI.EnvEvento, ACBrDFeUtil;

const
  ACBRNFeABI_NAMESPACE = 'http://www.portalfiscal.inf.br/nfeabi';
  ACBRNFeABI_CErroAmbDiferente = 'Ambiente do XML (tpAmb) é diferente do '+
     'configurado no Componente (Configuracoes.WebServices.Ambiente)';

type
  EACBrNFeABIException = class(EACBrDFeException);
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFeABI = class(TACBrDFe)
  private
    FDANFEABI: TACBrNFeABIDANFEABIClass;
    FNotasFiscais: TNotasFiscais;
    FEventoNFeABI: TEventoNFeABI;
    FStatus: TStatusNFeABI;
    FWebServices: TWebServices;

    function GetConfiguracoes: TConfiguracoesNFeABI;

    procedure SetConfiguracoes(AValue: TConfiguracoesNFeABI);
    procedure SetDANFEABI(const Value: TACBrNFeABIDANFEABIClass);
  protected
    function CreateConfiguracoes: TConfiguracoes; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function NomeServicoToNomeSchema(const NomeServico: String): String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmail(const sPara, sAssunto: String;
      sMensagem: TStrings = nil; sCC: TStrings = nil; Anexos: TStrings = nil;
      StreamNFeABI: TStream = nil; const NomeArq: String = '';
	  sReplyTo: TStrings = nil; sBCC: TStrings = nil); override;

    procedure EnviarEmailEvento(const sPara, sAssunto: String;
      sMensagem: TStrings = nil; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil);

    function Enviar(const ALote: String; Imprimir: Boolean = True;
      Zipado: Boolean = True): Boolean;

    function GetNomeModeloDFe: String; override;
    function GetNameSpaceURI: String; override;

    function cStatConfirmado(AValue: integer): Boolean;
    function cStatProcessado(AValue: integer): Boolean;
    function cStatCancelado(AValue: integer): Boolean;

    function Consultar(const AChave: String = ''; AExtrairEventos: Boolean = False): Boolean;
    function Cancelamento(const AJustificativa: String; ALote: integer = 0): Boolean;
    function EnviarEvento(idLote: integer): Boolean;

    procedure LerServicoDeParams(LayOutServico: TLayOutNFeABI; var Versao: Double;
      var URL: String); reintroduce; overload;
    function LerVersaoDeParams(LayOutServico: TLayOutNFeABI): String; reintroduce; overload;

    function GetURLConsulta(const CUF: integer; const TipoAmbiente: TACBrTipoAmbiente;
      const Versao: Double): String;

    function GetURLQRCode(FNFeABI: TNFeABI): String;

    function IdentificaSchema(const AXML: String): TSchemaNFeABI;
    function IdentificaSchemaEvento(const AXML: String): TSchemaNFeABI;

    function GerarNomeArqSchema(const ALayOut: TLayOutNFeABI; VersaoServico: Double): String;
    function GerarNomeArqSchemaEvento(ASchemaEventoNFeABI: TSchemaNFeABI; VersaoServico: Double): String;

    function GerarChaveContingencia(FNFeABI: TNFeABI): String;

    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property EventoNFeABI: TEventoNFeABI read FEventoNFeABI write FEventoNFeABI;
    property Status: TStatusNFeABI read FStatus;

    procedure SetStatus(const stNewStatus: TStatusNFeABI);
    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;

  published
    property Configuracoes: TConfiguracoesNFeABI
      read GetConfiguracoes write SetConfiguracoes;
    property DANFEABI: TACBrNFeABIDANFEABIClass read FDANFEABI write SetDANFEABI;
  end;

implementation

uses
  dateutils,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeSSL;

{$R ACBrNFeABIServicos.res}

{ TACBrNFeABI }

constructor TACBrNFeABI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FNotasFiscais := TNotasFiscais.Create(Self, TNotaFiscal);
  FEventoNFeABI := TEventoNFeABI.Create;
  FWebServices := TWebServices.Create(Self);
end;

destructor TACBrNFeABI.Destroy;
begin
  FNotasFiscais.Free;
  FEventoNFeABI.Free;
  FWebServices.Free;

  inherited;
end;

procedure TACBrNFeABI.EnviarEmail(const sPara, sAssunto: String; sMensagem: TStrings;
  sCC: TStrings; Anexos: TStrings; StreamNFeABI: TStream; const NomeArq: String;
  sReplyTo: TStrings; sBCC: TStrings);
begin
  SetStatus( stNFeABIEmail );

  try
    inherited EnviarEmail(sPara, sAssunto, sMensagem, sCC, Anexos, StreamNFeABI, NomeArq,
      sReplyTo, sBCC);
  finally
    SetStatus( stNFeABIIdle );
  end;
end;

procedure TACBrNFeABI.EnviarEmailEvento(const sPara, sAssunto: String; sMensagem, sCC, Anexos, sReplyTo: TStrings);
var
  NomeArq: String;
  AnexosEmail: TStrings;
  StreamNFeABI : TMemoryStream;
begin
  AnexosEmail := TStringList.Create;
  StreamNFeABI := TMemoryStream.Create;
  try
    AnexosEmail.Clear;

    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;

    GravarStream(StreamNFeABI);

    ImprimirEventoPDF;
    AnexosEmail.Add(DANFEABI.ArquivoPDF);

    NomeArq := RemoverLiteralChave(EventoNFeABI.Evento[0].InfEvento.Id);
    EnviarEmail(sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFeABI,
	    NomeArq + '-procEventoNFeABI.xml', sReplyTo);
  finally
    AnexosEmail.Free;
    StreamNFeABI.Free;
  end;
end;

procedure TACBrNFeABI.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFEABI <> nil) and
     (AComponent is TACBrNFeABIDANFEABIClass) then
    FDANFEABI := nil;
end;

function TACBrNFeABI.CreateConfiguracoes: TConfiguracoes;
begin
  Result := TConfiguracoesNFeABI.Create(Self);
end;

procedure TACBrNFeABI.SetDANFEABI(const Value: TACBrNFeABIDANFEABIClass);
var
 OldValue: TACBrNFeABIDANFEABIClass;
begin
  if Value <> FDANFEABI then
  begin
    if Assigned(FDANFEABI) then
      FDANFEABI.RemoveFreeNotification(Self);

    OldValue := FDANFEABI;   // Usa outra variavel para evitar Loop Infinito
    FDANFEABI  := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.ACBrNFeABI) then
        OldValue.ACBrNFeABI := nil;

    if Value <> nil then
     begin
       Value.FreeNotification(self);
       Value.ACBrNFeABI := self;
     end;
  end;
end;

function TACBrNFeABI.GetNomeModeloDFe: String;
begin
  Result := 'NFeABI';
end;

function TACBrNFeABI.GetURLConsulta(const CUF: integer;
  const TipoAmbiente: TACBrTipoAmbiente; const Versao: Double): String;
//var
//  VersaoDFe: TVersaoNFeABI;
//  ok: Boolean;
begin
  // Se futuramente viermos a ter versões diferentes de URL de consulta
  // devemos descomentar as linhas e trocar o zero da função abaixo pela variável
  // VersaoDFe
//  VersaoDFe := DblToVersaoNFeABI(ok, Versao);
  Result := LerURLDeParams('NFeABI', CodigoUFparaUF(CUF), TipoAmbiente, 'URL-Consulta', 0);
end;

function TACBrNFeABI.GetURLQRCode(FNFeABI: TNFeABI): String;
var
  idNFeABI,
  sEntrada, urlUF, Passo3, Passo4, Sign: String;
//  VersaoDFe: TVersaoNFeABI;
//  ok: Boolean;
begin
//  VersaoDFe := DblToVersaoNFeABI(ok, Versao);

  urlUF := LerURLDeParams('NFeABI', CodigoUFparaUF(FNFeABI.Ide.cUF),
                             FNFeABI.Ide.tpAmb, 'URL-QRCode', 0);

  if Pos('?', urlUF) <= 0 then
    urlUF := urlUF + '?';

  idNFeABI := RemoverLiteralChave(FNFeABI.infNFeABI.ID);

  // Passo 1
  sEntrada := 'chNFeABI=' + idNFeABI + '&tpAmb=' + TipoAmbienteToStr(FNFeABI.Ide.tpAmb);

  // Passo 2 calcular o SHA-1 da string idNFeABI se emissão em contingência
  if FNFeABI.ide.tpEmis = teContingencia then
  begin
  { italo
    if trim(FNFeABI.emit.idOutros) <> '' then
      Passo3 := '&idOutros=' + FNFeABI.emit.idOutros
    else
    begin
      if Length(FNFeABI.emit.CNPJCPF) = 14 then
        Passo3 := '&CNPJ=' + FNFeABI.emit.CNPJCPF
      else
        Passo3 := '&CPF=' + FNFeABI.emit.CNPJCPF;
    end;
    }
    // Tipo de Emissão em Contingência
    SSL.CarregarCertificadoSeNecessario;
    Sign := SSL.CalcHash(idNFeABI, dgstSHA1, outBase64, True);
    Passo4 := '&sign='+Sign;

    sEntrada := sEntrada + Passo3 + Passo4;
  end;

  Result := urlUF + sEntrada;
end;

function TACBrNFeABI.GravarStream(AStream: TStream): Boolean;
begin
//  if EstaVazio(FEventoNFeABI.Gerador.ArquivoFormatoXML) then
//    FEventoNFeABI.GerarXML;

  AStream.Size := 0;
//  WriteStrToStream(AStream, AnsiString(FEventoNFeABI.Gerador.ArquivoFormatoXML));
  Result := True;
end;

function TACBrNFeABI.GetNameSpaceURI: String;
begin
  Result := ACBRNFeABI_NAMESPACE;
end;

function TACBrNFeABI.cStatConfirmado(AValue: integer): Boolean;
begin
  case AValue of
    100, 150: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFeABI.cStatProcessado(AValue: integer): Boolean;
begin
  case AValue of
    100, 110, 150, 301, 302: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFeABI.cStatCancelado(AValue: integer): Boolean;
begin
  case AValue of
    101, 151, 155: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFeABI.IdentificaSchema(const AXML: String): TSchemaNFeABI;
var
 lTipoEvento: TACBrTipoEvento;
 I: Integer;
 Ok: Boolean;
begin
  Result := schNFeABI;

  I := pos('<infNFeABI', AXML);
  if I = 0 then
  begin
    I := pos('<infEvento', AXML);
    if I > 0 then
    begin
      lTipoEvento := StrToTpEventoNFeABI(Ok, Trim(RetornarConteudoEntre(AXML, '<tpEvento>', '</tpEvento>')));

      case lTipoEvento of
        teCancelamento: Result := schevCancNFeABI;
      else 
        Result := schErroNFeABI;
      end;
    end;
  end;
end;

function TACBrNFeABI.IdentificaSchemaEvento(const AXML: String): TSchemaNFeABI;
begin
  // Implementar
  Result := schErroNFeABI;
end;

function TACBrNFeABI.GerarNomeArqSchema(const ALayOut: TLayOutNFeABI;
  VersaoServico: Double): String;
var
  NomeServico, NomeSchema, ArqSchema: String;
  Versao: Double;
begin
  // Procura por Versão na pasta de Schemas //
  NomeServico := LayOutNFeABIToServico(ALayOut);
  NomeSchema := NomeServicoToNomeSchema(NomeServico);
  ArqSchema := '';
  if NaoEstaVazio(NomeSchema) then
  begin
    Versao := VersaoServico;
    AchaArquivoSchema( NomeSchema, Versao, ArqSchema );
  end;

  Result := ArqSchema;
end;

function TACBrNFeABI.GerarNomeArqSchemaEvento(ASchemaEventoNFeABI: TSchemaNFeABI;
  VersaoServico: Double): String;
begin
  if VersaoServico = 0 then
    Result := ''
  else
    Result := PathWithDelim( Configuracoes.Arquivos.PathSchemas ) +
              SchemaNFeABIToStr(ASchemaEventoNFeABI) + '_v' +
              FloatToString(VersaoServico, '.', '0.00') + '.xsd';
end;

function TACBrNFeABI.GerarChaveContingencia(FNFeABI: TNFeABI): String;

  function GerarDigito_Contigencia(out Digito: integer; chave: String): Boolean;
  var
    i, j: integer;
  const
    PESO = '43298765432987654329876543298765432';
  begin
    chave := Copy(chave, 4, Length(chave));
    j := 0;
    Digito := 0;
    Result := True;
    try
      for i := 1 to 35 do
        j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
      Digito := 11 - (j mod 11);
      if (j mod 11) < 2 then
        Digito := 0;
    except
      Result := False;
    end;
    if length(chave) <> 35 then
      Result := False;
  end;

var
  wchave: String;
//  Digito: integer;
begin
  wchave := '';

  Result := wchave;
end;

function TACBrNFeABI.GetConfiguracoes: TConfiguracoesNFeABI;
begin
  Result := TConfiguracoesNFeABI(FPConfiguracoes);
end;

procedure TACBrNFeABI.SetConfiguracoes(AValue: TConfiguracoesNFeABI);
begin
  FPConfiguracoes := AValue;
end;

function TACBrNFeABI.LerVersaoDeParams(LayOutServico: TLayOutNFeABI): String;
var
  Versao: Double;
begin
  Versao := LerVersaoDeParams(GetNomeModeloDFe, Configuracoes.WebServices.UF,
    Configuracoes.WebServices.Ambiente, LayOutNFeABIToServico(LayOutServico),
    VersaoNFeABIToDbl(Configuracoes.Geral.VersaoDF));

  Result := FloatToString(Versao, '.', '0.00');
end;

function TACBrNFeABI.NomeServicoToNomeSchema(const NomeServico: String): String;
var
  ALayout: TLayOutNFeABI;
begin
  ALayout := ServicoToLayOutNFeABI(NomeServico);
  Result := SchemaNFeABIToStr(LayOutNFeABIToSchema(ALayout));
end;

procedure TACBrNFeABI.LerServicoDeParams(LayOutServico: TLayOutNFeABI;
  var Versao: Double; var URL: String);
begin
  Versao := VersaoNFeABIToDbl(Configuracoes.Geral.VersaoDF);
  URL := '';
  LerServicoDeParams(GetNomeModeloDFe, Configuracoes.WebServices.UF,
    Configuracoes.WebServices.Ambiente, LayOutNFeABIToServico(LayOutServico),
    Versao, URL);
end;

procedure TACBrNFeABI.SetStatus(const stNewStatus: TStatusNFeABI);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;
    if Assigned(OnStatusChange) then
      OnStatusChange(Self);
  end;
end;

function TACBrNFeABI.Cancelamento(const AJustificativa: String; ALote: integer = 0): Boolean;
var
  i: integer;
begin
  if NotasFiscais.Count = 0 then
    GerarException(ACBrStr('ERRO: Nenhum NFeABI Informado!'));

  for i := 0 to NotasFiscais.Count - 1 do
  begin
    WebServices.Consulta.NFeABIChave := NotasFiscais.Items[i].NumID;

    if not WebServices.Consulta.Executar then
      raise Exception.Create(WebServices.Consulta.Msg);

    EventoNFeABI.Evento.Clear;
    with EventoNFeABI.Evento.New do
    begin
      infEvento.CNPJCPF := NotasFiscais.Items[i].NFeABI.Emit.CNPJCPF;
      infEvento.cOrgao := StrToIntDef(copy(RemoverLiteralChave(WebServices.Consulta.NFeABIChave), 1, 2), 0);
      infEvento.dhEvento := now;
      infEvento.tpEvento := teCancelamento;
      infEvento.chNFeABI := WebServices.Consulta.NFeABIChave;

      infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
      infEvento.detEvento.xJust := AJustificativa;
    end;

    try
      EnviarEvento(ALote);
    except
      raise Exception.Create(WebServices.EnvEvento.EventoRetorno.retInfEvento[0].retInfEvento.xMotivo);
    end;
  end;

  Result := True;
end;

function TACBrNFeABI.Consultar(const AChave: String; AExtrairEventos: Boolean): Boolean;
var
 i: Integer;
begin
  if (NotasFiscais.Count = 0) and EstaVazio(AChave) then
    GerarException(ACBrStr('ERRO: Nenhum NFeABI ou Chave Informada!'));

  if NaoEstaVazio(AChave) then
  begin
    NotasFiscais.Clear;
    WebServices.Consulta.NFeABIChave := AChave;
    WebServices.Consulta.ExtrairEventos := AExtrairEventos;
    WebServices.Consulta.Executar;
  end
  else
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      WebServices.Consulta.NFeABIChave := NotasFiscais.Items[i].NumID;
      WebServices.Consulta.ExtrairEventos := AExtrairEventos;
      WebServices.Consulta.Executar;
    end;
  end;

  Result := True;
end;

function TACBrNFeABI.Enviar(const ALote: String; Imprimir:Boolean = True;
  Zipado: Boolean = True): Boolean;
var
 i: Integer;
begin
  WebServices.Enviar.Clear;

  if NotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum DC-e adicionado ao Lote'));

  if NotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NFeABI transmitidos (máximo de 1 NFeABI)' +
      ' excedido. Quantidade atual: ' + IntToStr(NotasFiscais.Count)));

  NotasFiscais.Assinar;
  NotasFiscais.Validar;

  Result := WebServices.Envia(ALote, Zipado);

  if DANFEABI <> nil then
  begin
    for i := 0 to NotasFiscais.Count - 1 do
    begin
      if NotasFiscais.Items[i].Confirmado and Imprimir then
        NotasFiscais.Items[i].Imprimir;
    end;
  end;
end;

function TACBrNFeABI.EnviarEvento(idLote: Integer): Boolean;
var
  i, j: integer;
  chNFeABI: String;
begin
  if EventoNFeABI.Evento.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum Evento adicionado ao Lote'));

  if EventoNFeABI.Evento.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de Eventos transmitidos (máximo de 1) ' +
      'excedido. Quantidade atual: ' + IntToStr(EventoNFeABI.Evento.Count)));

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i := 0 to EventoNFeABI.Evento.Count - 1 do
  begin
    if EventoNFeABI.Evento.Items[i].InfEvento.nSeqEvento = 0 then
      EventoNFeABI.Evento.Items[i].infEvento.nSeqEvento := 1;

    FEventoNFeABI.Evento.Items[i].InfEvento.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);

    if NotasFiscais.Count > 0 then
    begin
      chNFeABI := RemoverLiteralChave(EventoNFeABI.Evento.Items[i].InfEvento.chNFeABI);

      // Se tem a chave do NFeABI no Evento, procure por ela nos NotasFiscais carregados //
      if NaoEstaVazio(chNFeABI) then
      begin
        for j := 0 to NotasFiscais.Count - 1 do
        begin
          if chNFeABI = NotasFiscais.Items[j].NumID then
            Break;
        end;

        if j = NotasFiscais.Count then
          GerarException( ACBrStr('Não existe NFeABI com a chave ['+chNFeABI+'] carregado') );
      end
      else
        j := 0;

      if trim(EventoNFeABI.Evento.Items[i].InfEvento.CNPJCPF) = '' then
        EventoNFeABI.Evento.Items[i].InfEvento.CNPJCPF := NotasFiscais.Items[j].NFeABI.Emit.CNPJCPF;

      if chNFeABI = '' then
        EventoNFeABI.Evento.Items[i].InfEvento.chNFeABI := NotasFiscais.Items[j].NumID;

      if trim(EventoNFeABI.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EventoNFeABI.Evento.Items[i].infEvento.tpEvento = teCancelamento then
        begin
          EventoNFeABI.Evento.Items[i].infEvento.detEvento.nProt := NotasFiscais.Items[j].NFeABI.procNFeABI.nProt;

          if trim(EventoNFeABI.Evento.Items[i].infEvento.detEvento.nProt) = '' then
          begin
            WebServices.Consulta.NFeABIChave := EventoNFeABI.Evento.Items[i].InfEvento.chNFeABI;

            if not WebServices.Consulta.Executar then
              GerarException(WebServices.Consulta.Msg);

            EventoNFeABI.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
          end;
        end;
      end;
    end;
  end;

  Result := WebServices.EnvEvento.Executar;

  if not Result then
    GerarException( WebServices.EnvEvento.Msg );
end;

procedure TACBrNFeABI.ImprimirEvento;
begin
  if not Assigned(DANFEABI) then
     raise EACBrNFeABIException.Create('Componente DANFEABI não associado.')
  else
     DANFEABI.ImprimirEVENTO(nil);
end;

procedure TACBrNFeABI.ImprimirEventoPDF;
begin
  if not Assigned(DANFEABI) then
     raise EACBrNFeABIException.Create('Componente DANFEABI não associado.')
  else
     DANFEABI.ImprimirEVENTOPDF;
end;

end.
