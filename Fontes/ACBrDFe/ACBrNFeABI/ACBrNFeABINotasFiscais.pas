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

unit ACBrNFeABINotasFiscais;

interface

uses
  Classes,
	SysUtils, 
	StrUtils,
  ACBrBase,
  ACBrNFeABIConfiguracoes,
  ACBrNFeABI.Classes,
	ACBrNFeABI.XmlReader,
	ACBrNFeABI.XmlWriter,
  ACBrNFeABI.IniReader,
  ACBrNFeABI.IniWriter,
	ACBrDFe.Conversao;

type

  { TNotaFiscal }

  TNotaFiscal = class(TCollectionItem)
  private
    FNFeABI: TNFeABI;
    // Xml
    FNFeABIW: TNFeABIXmlWriter;
    FNFeABIR: TNFeABIXmlReader;
    // Ini
    FNFeABIIniR: TNFeABIIniReader;
    FNFeABIIniW: TNFeABIIniWriter;

    FConfiguracoes: TConfiguracoesNFeABI;
    FXMLAssinado: String;
    FXMLOriginal: String;
    FAlertas: String;
    FErroValidacao: String;
    FErroValidacaoCompleto: String;
    FErroRegrasdeNegocios: String;
    FNomeArq: String;
    FNomeArqPDF: String;

    function GetConfirmado: Boolean;
    function GetProcessado: Boolean;
    function GetCancelado: Boolean;

    function GetMsg: String;
    function GetNumID: String;
    function GetXMLAssinado: String;
    procedure SetXML(const AValue: String);
    procedure SetXMLOriginal(const AValue: String);
    function ValidarConcatChave: Boolean;
    function CalcularNomeArquivo: String;
    function CalcularPathArquivo: String;
    function GetcStat: Integer;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;

    procedure Assinar;
    procedure Validar;
    function VerificarAssinatura: Boolean;
    function ValidarRegrasdeNegocios: Boolean;

    function LerXML(const AXML: String): Boolean;
    function LerArqIni(const AIniString: String): Boolean;
    function GerarNFeABIIni: String;

    function GerarXML: String;
    function GravarXML(const NomeArquivo: String = ''; const PathArquivo: String = ''): Boolean;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmail(const sPara, sAssunto: String; sMensagem: TStrings = nil;
      EnviaPDF: Boolean = True; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil; ManterPDFSalvo: Boolean = True;
      sBCC: Tstrings = nil);

    function CalcularNomeArquivoCompleto(NomeArquivo: String = '';
      PathArquivo: String = ''): String;

    property NomeArq: String read FNomeArq write FNomeArq;
    property NomeArqPDF: String read FNomeArqPDF write FNomeArqPDF;

    property NFeABI: TNFeABI read FNFeABI;

    // Atribuir a "XML", faz o componente transferir os dados lido para as propriedades internas e "XMLAssinado"
    property XML: String         read FXMLOriginal   write SetXML;
    // Atribuir a "XMLOriginal", reflete em XMLAssinado, se existir a tag de assinatura
    property XMLOriginal: String read FXMLOriginal   write SetXMLOriginal;
    property XMLAssinado: String read GetXMLAssinado write FXMLAssinado;

    property Confirmado: Boolean read GetConfirmado;
    property Processado: Boolean read GetProcessado;
    property Cancelado: Boolean  read GetCancelado;
    property cStat: Integer read GetcStat;
    property Msg: String read GetMsg;
    property NumID: String read GetNumID;

    property Alertas: String read FAlertas;
    property ErroValidacao: String read FErroValidacao;
    property ErroValidacaoCompleto: String read FErroValidacaoCompleto;
    property ErroRegrasdeNegocios: String read FErroRegrasdeNegocios;
  end;

  { TNotasFiscais }

  TNotasFiscais = class(TOwnedCollection)
  private
    FACBrNFeABI: TComponent;
    FConfiguracoes: TConfiguracoesNFeABI;

    function GetItem(Index: integer): TNotaFiscal;
    procedure SetItem(Index: integer; const Value: TNotaFiscal);

    procedure VerificarDANFeABI;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFeABI;
    procedure Assinar;
    procedure Validar;
    function VerificarAssinatura(out Erros: String): Boolean;
    function ValidarRegrasdeNegocios(out Erros: String): Boolean;
    procedure Imprimir;
    procedure ImprimirPDF;

    function Add: TNotaFiscal;
    function Insert(Index: integer): TNotaFiscal;

    property Items[Index: integer]: TNotaFiscal read GetItem write SetItem; default;

    function GetNamePath: String; override;
    // Incluido o Parametro AGerarNFeABI que determina se após carregar os dados do NFeABI
    // para o componente, será gerado ou não novamente o XML do NFeABI.
    function LoadFromFile(const CaminhoArquivo: String; AGerarNFeABI: Boolean = False): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFeABI: Boolean = False): Boolean;
    function LoadFromString(const AXMLString: String; AGerarNFeABI: Boolean = False): Boolean;
    function LoadFromIni(const AIniString: String): Boolean;

    function GerarIni: String;
    function GravarXML(const PathNomeArquivo: String = ''): Boolean;

    property ACBrNFeABI: TComponent read FACBrNFeABI;
  end;

implementation

uses
  Dateutils, 
	IniFiles,
  synautil,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
	ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFeABI,
	ACBrDFeUtil,
  ACBrNFeABI.ValidarRegrasdeNegocio,
	ACBrNFeABI.Conversao;

{ Declaracao }

constructor TNotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);

  FNFeABI := TNFeABI.Create;
  // Xml
  FNFeABIW := TNFeABIXmlWriter.Create(FNFeABI);
  FNFeABIR := TNFeABIXmlReader.Create(FNFeABI);
  // Ini
  FNFeABIIniR := TNFeABIIniReader.Create(FNFeABI);
  FNFeABIIniW := TNFeABIIniWriter.Create(FNFeABI);

  FConfiguracoes := TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).Configuracoes;

  FNFeABI.Ide.verProc := 'ACBrNFeABI';
  FNFeABI.Ide.modelo := 77;

  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    FNFeABI.infNFeABI.Versao := VersaoNFeABIToDbl(Configuracoes.Geral.VersaoDF);
    FNFeABI.Ide.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
    FNFeABI.Ide.tpEmis := TACBrTipoEmissao(Configuracoes.Geral.FormaEmissao);
  end;
end;

destructor TNotaFiscal.Destroy;
begin
  // Xml
  FNFeABIW.Free;
  FNFeABIR.Free;
  // Ini
  FNFeABIIniR.Free;
  FNFeABIIniW.Free;

  FNFeABI.Free;

  inherited Destroy;
end;

procedure TNotaFiscal.Imprimir;
begin
  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    if not Assigned(DANFEABI) then
      raise EACBrNFeABIException.Create('Componente DANFEABI não associado.')
    else
      DANFEABI.ImprimirDANFEABI(NFeABI);
  end;
end;

procedure TNotaFiscal.ImprimirPDF;
begin
  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    if not Assigned(DANFEABI) then
      raise EACBrNFeABIException.Create('Componente DANFEABI não associado.')
    else
      DANFEABI.ImprimirDANFEABIPDF(NFeABI);
  end;
end;

procedure TNotaFiscal.Assinar;
var
  XMLStr: String;
  XMLUTF8: AnsiString;
  Document: TACBrXmlDocument;
  ANode: TACBrXmlNode;
begin
  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    SSL.ValidarCNPJCertificado(NFeABI.Emit.CNPJCPF);
  end;

  // Gera novamente, para processar propriedades que podem ter sido modificadas
  XMLStr := GerarXML;

  // XML já deve estar em UTF8, para poder ser assinado //
  XMLUTF8 := ConverteXMLtoUTF8(XMLStr);

  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    FXMLAssinado := SSL.Assinar(String(XMLUTF8), 'NFeABI', 'infNFeABI');
    // SSL.Assinar() sempre responde em UTF8...
    FXMLOriginal := FXMLAssinado;

    Document := TACBrXmlDocument.Create;
    try
      Document.LoadFromXml(FXMLOriginal);
      ANode := Document.Root;

      LerSignature(ANode.Childrens.FindAnyNs('Signature'), NFeABI.signature);
    finally
      FreeAndNil(Document);
    end;

    NFeABI.infNFeSupl.qrCode := GetURLQRCode(NFeABI);
    NFeABI.infNFeSupl.urlChave := GetURLConsulta(NFeABI.Ide.cUF,
                 NFeABI.Ide.tpAmb, NFeABI.infNFeABI.Versao);

    GerarXML;

    if Configuracoes.Arquivos.Salvar and
      (not Configuracoes.Arquivos.SalvarApenasNFeABIProcessados) then
    begin
      if NaoEstaVazio(NomeArq) then
        Gravar(NomeArq, FXMLAssinado)
      else
        Gravar(CalcularNomeArquivoCompleto(), FXMLAssinado);
    end;
  end;
end;

procedure TNotaFiscal.Validar;
var
  Erro, AXML: String;
  NFeABIEhValida: Boolean;
  ALayout: TLayOutNFeABI;
begin
  AXML := FXMLAssinado;

  if AXML = '' then
    AXML := XMLOriginal;

  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    ALayout := LayNFeABIAutorizacao;

    // Extraindo apenas os dados da NFeABI (sem NFeABIProc)
    AXML := ObterDFeXML(AXML, 'NFeABI', ACBRNFeABI_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFeABI não encontrada no XML');
      NFeABIEhValida := False;
    end
    else
    begin
      NFeABIEhValida := SSL.Validar(AXML, GerarNomeArqSchema(ALayout, FNFeABI.infNFeABI.Versao), Erro);
    end;

    if not NFeABIEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados do Declaracao: ') +
        IntToStr(NFeABI.Ide.nNF) + sLineBreak + FAlertas ;
      FErroValidacaoCompleto := FErroValidacao + sLineBreak + Erro;

      raise EACBrNFeABIException.CreateDef(
        IfThen(Configuracoes.Geral.ExibirErroSchema, ErroValidacaoCompleto,
        ErroValidacao));
    end;
  end;
end;

function TNotaFiscal.VerificarAssinatura: Boolean;
var
  Erro, AXML: String;
  AssEhValida: Boolean;
begin
  AXML := XMLAssinado;

  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    // Extraindo apenas os dados da NFeABI (sem NFeABIProc)
    AXML := ObterDFeXML(AXML, 'NFeABI', ACBRNFeABI_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFeABI não encontrada no XML');
      AssEhValida := False;
    end
    else
      AssEhValida := SSL.VerificarAssinatura(AXML, Erro, 'infNFeABI');

    if not AssEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação da assinatura do Declaracao: ') +
        IntToStr(NFeABI.Ide.nNF) + sLineBreak + Erro;
    end;
  end;

  Result := AssEhValida;
end;

function TNotaFiscal.ValidarRegrasdeNegocios: Boolean;
var
  Agora: TDateTime;
  FValidarRegras: TNFeABIValidarRegras;
begin
  // Converte o DateTime do Sistema para o TimeZone configurado, para evitar
  // divergência de Fuso Horário.
  Agora := DataHoraTimeZoneModoDeteccao(TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI));

  FValidarRegras := TNFeABIValidarRegras.Create(FNFeABI);

  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    FValidarRegras.VersaoDF := Configuracoes.Geral.VersaoDF;
    FValidarRegras.Ambiente := Configuracoes.WebServices.Ambiente;
    FValidarRegras.tpEmis := Configuracoes.Geral.FormaEmissaoCodigo;
    FValidarRegras.CodigoUF := Configuracoes.WebServices.UFCodigo;
    FValidarRegras.UF := Configuracoes.WebServices.UF;
  end;

  Result := FValidarRegras.Validar(Agora);

  FErroRegrasdeNegocios := FValidarRegras.Erros;
end;

function TNotaFiscal.LerXML(const AXML: String): Boolean;
begin
  XMLOriginal := AXML;  // SetXMLOriginal() irá verificar se AXML está em UTF8

  FNFeABIR.Arquivo := XMLOriginal;
  FNFeABIR.LerXml;

  Result := True;
end;

function TNotaFiscal.GravarXML(const NomeArquivo: String; const PathArquivo: String): Boolean;
begin
  if EstaVazio(FXMLOriginal) then
    GerarXML;

  FNomeArq := CalcularNomeArquivoCompleto(NomeArquivo, PathArquivo);

  Result := TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).Gravar(FNomeArq, FXMLOriginal);
end;

function TNotaFiscal.GravarStream(AStream: TStream): Boolean;
begin
  if EstaVazio(FXMLOriginal) then
    GerarXML;

  AStream.Size := 0;
  WriteStrToStream(AStream, AnsiString(FXMLOriginal));
  Result := True;
end;

procedure TNotaFiscal.EnviarEmail(const sPara, sAssunto: String; sMensagem: TStrings;
  EnviaPDF: Boolean; sCC: TStrings; Anexos: TStrings; sReplyTo: TStrings;
  ManterPDFSalvo: Boolean; sBCC: Tstrings);
var
  NomeArqTemp: string;
  AnexosEmail: TStrings;
  StreamNFeABI: TMemoryStream;
begin
  if not Assigned(TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).MAIL) then
    raise EACBrNFeABIException.Create('Componente ACBrMail não associado');

  AnexosEmail := TStringList.Create;
  StreamNFeABI := TMemoryStream.Create;
  try
    AnexosEmail.Clear;
    if Assigned(Anexos) then
      AnexosEmail.Assign(Anexos);

    with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
    begin
      Self.GravarStream(StreamNFeABI);

      if (EnviaPDF) then
      begin
        if Assigned(DANFEABI) then
        begin
          DANFEABI.ImprimirDANFEABIPDF(FNFeABI);
          NomeArqTemp := PathWithDelim(DANFEABI.PathPDF) + NumID + '-NFeABI.pdf';
          AnexosEmail.Add(NomeArqTemp);
        end;
      end;

      EnviarEmail( sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFeABI,
                   NumID + '-NFeABI.xml', sReplyTo, sBCC);
    end;
  finally
    if not ManterPDFSalvo then
      DeleteFile(NomeArqTemp);

    AnexosEmail.Free;
    StreamNFeABI.Free;
  end;
end;

function TNotaFiscal.GerarNFeABIIni: String;
begin
  Result := FNFeABIIniW.GravarIni;
end;

function TNotaFiscal.GerarXML: String;
var
  IdAnterior : String;
begin
  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    IdAnterior := NFeABI.infNFeABI.ID;

    FNFeABIW.Opcoes.FormatoAlerta  := Configuracoes.Geral.FormatoAlerta;
    FNFeABIW.Opcoes.RetirarAcentos := Configuracoes.Geral.RetirarAcentos;
    FNFeABIW.Opcoes.RetirarEspacos := Configuracoes.Geral.RetirarEspacos;
    FNFeABIW.Opcoes.IdentarXML := Configuracoes.Geral.IdentarXML;
    FNFeABIW.Opcoes.NormatizarMunicipios  := Configuracoes.Arquivos.NormatizarMunicipios;
    FNFeABIW.Opcoes.PathArquivoMunicipios := Configuracoes.Arquivos.PathArquivoMunicipios;

    TimeZoneConf.Assign( Configuracoes.WebServices.TimeZoneConf );

    FNFeABIW.ModeloDF := 77;
    FNFeABIW.VersaoDF := Configuracoes.Geral.VersaoDF;
    FNFeABIW.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
//    FNFeABIW.tpEmis := TACBrTipoEmissao(Integer(Configuracoes.Geral.FormaEmissao));
  end;

  FNFeABIW.GerarXml;

  XMLOriginal := FNFeABIW.Document.Xml;  // SetXMLOriginal() irá converter para UTF8

  { XML gerado pode ter nova Chave e ID, então devemos calcular novamente o
    nome do arquivo, mantendo o PATH do arquivo carregado }
  if (NaoEstaVazio(FNomeArq) and (IdAnterior <> FNFeABI.infNFeABI.ID)) then
    FNomeArq := CalcularNomeArquivoCompleto('', ExtractFilePath(FNomeArq));

  FAlertas := ACBrStr( FNFeABIW.ListaDeAlertas.Text );
  Result := FXMLOriginal;
end;

function TNotaFiscal.CalcularNomeArquivo: String;
var
  xID: String;
begin
  xID := Self.NumID;

  if EstaVazio(xID) then
    raise EACBrNFeABIException.Create('ID Inválido. Impossível Salvar XML');

  Result := xID + '-NFeABI.xml';
end;

function TNotaFiscal.CalcularPathArquivo: String;
var
  Data: TDateTime;
begin
  with TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI) do
  begin
    if Configuracoes.Arquivos.EmissaoPathNFeABI then
      Data := FNFeABI.Ide.dhEmi
    else
      Data := Now;

    Result := PathWithDelim(Configuracoes.Arquivos.GetPathNFeABI(Data, FNFeABI.Emit.CNPJCPF, ''));
  end;
end;

function TNotaFiscal.CalcularNomeArquivoCompleto(NomeArquivo: String;
  PathArquivo: String): String;
var
  PathNoArquivo: String;
begin
  if EstaVazio(NomeArquivo) then
    NomeArquivo := CalcularNomeArquivo;

  PathNoArquivo := ExtractFilePath(NomeArquivo);
  if EstaVazio(PathNoArquivo) then
  begin
    if EstaVazio(PathArquivo) then
      PathArquivo := CalcularPathArquivo
    else
      PathArquivo := PathWithDelim(PathArquivo);
  end
  else
    PathArquivo := '';

  Result := PathArquivo + NomeArquivo;
end;

function TNotaFiscal.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: word;
begin
  DecodeDate(NFeABI.ide.dhEmi, wAno, wMes, wDia);

  Result := not
    ((Copy(NFeABI.infNFeABI.ID, 5, 2) <> IntToStrZero(NFeABI.Ide.cUF, 2)) or
    (Copy(NFeABI.infNFeABI.ID, 7, 2)  <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(NFeABI.infNFeABI.ID, 9, 2)  <> FormatFloat('00', wMes)) or
    (Copy(NFeABI.infNFeABI.ID, 11, 14)<> PadLeft(OnlyCPFCNPJAlphaNum(NFeABI.Emit.CNPJCPF), 14, '0')) or
    (Copy(NFeABI.infNFeABI.ID, 25, 2) <> IntToStr(NFeABI.Ide.modelo)) or
    (Copy(NFeABI.infNFeABI.ID, 27, 3) <> IntToStrZero(NFeABI.Ide.serie, 3)) or
    (Copy(NFeABI.infNFeABI.ID, 30, 9) <> IntToStrZero(NFeABI.Ide.nNF, 9)) or
    (Copy(NFeABI.infNFeABI.ID, 39, 1) <> IntToStr(Integer(NFeABI.Ide.tpEmis))) or
    (Copy(NFeABI.infNFeABI.ID, 40, 8) <> IntToStrZero(NFeABI.Ide.cNF, 8)));
end;

function TNotaFiscal.GetConfirmado: Boolean;
begin
  Result := TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).cStatConfirmado(
    FNFeABI.procNFeABI.cStat);
end;

function TNotaFiscal.GetcStat: Integer;
begin
  Result := FNFeABI.procNFeABI.cStat;
end;

function TNotaFiscal.GetProcessado: Boolean;
begin
  Result := TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).cStatProcessado(
    FNFeABI.procNFeABI.cStat);
end;

function TNotaFiscal.GetCancelado: Boolean;
begin
  Result := TACBrNFeABI(TNotasFiscais(Collection).ACBrNFeABI).cStatCancelado(
    FNFeABI.procNFeABI.cStat);
end;

function TNotaFiscal.GetMsg: String;
begin
  Result := FNFeABI.procNFeABI.xMotivo;
end;

function TNotaFiscal.GetNumID: String;
begin
  Result := RemoverLiteralChave(NFeABI.infNFeABI.ID);
end;

function TNotaFiscal.GetXMLAssinado: String;
begin
  if EstaVazio(FXMLAssinado) then
    Assinar;

  Result := FXMLAssinado;
end;

procedure TNotaFiscal.SetXML(const AValue: String);
begin
  LerXML(AValue);
end;

procedure TNotaFiscal.SetXMLOriginal(const AValue: String);
var
  XMLUTF8: String;
begin
  { Garante que o XML informado está em UTF8, se ele realmente estiver, nada
    será modificado por "ConverteXMLtoUTF8"  (mantendo-o "original") }
  XMLUTF8 := ConverteXMLtoUTF8(AValue);

  FXMLOriginal := XMLUTF8;

  if XmlEstaAssinado(FXMLOriginal) then
    FXMLAssinado := FXMLOriginal
  else
    FXMLAssinado := '';
end;

function TNotaFiscal.LerArqIni(const AIniString: String): Boolean;
begin
  FNFeABIIniR.VersaoDF := FConfiguracoes.Geral.VersaoDF;
  FNFeABIIniR.Ambiente := Integer(FConfiguracoes.WebServices.Ambiente);
  FNFeABIIniR.tpEmis := FConfiguracoes.Geral.FormaEmissaoCodigo;

  FNFeABIIniR.LerIni(AIniString);

  GerarXML;

  Result := True;
end;

{ TNotasFiscais }

constructor TNotasFiscais.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFeABI) then
    raise EACBrNFeABIException.Create('AOwner deve ser do tipo TACBrNFeABI');

  inherited Create(AOwner, ItemClass);

  FACBrNFeABI := TACBrNFeABI(AOwner);
  FConfiguracoes := TACBrNFeABI(FACBrNFeABI).Configuracoes;
end;

function TNotasFiscais.Add: TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].Assinar;
end;

function TNotasFiscais.GerarIni: String;
begin
  Result := '';
  if (Self.Count > 0) then
    Result := Self.Items[0].GerarNFeABIIni;
end;

procedure TNotasFiscais.GerarNFeABI;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].GerarXML;
end;

function TNotasFiscais.GetItem(Index: integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: String;
begin
  Result := 'Declaracao';
end;

procedure TNotasFiscais.VerificarDANFeABI;
begin
  if not Assigned(TACBrNFeABI(FACBrNFeABI).DANFEABI) then
    raise EACBrNFeABIException.Create('Componente DANFeABI não associado.');
end;

procedure TNotasFiscais.Imprimir;
begin
  VerificarDANFeABI;
  TACBrNFeABI(FACBrNFeABI).DANFEABI.ImprimirDANFEABI(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  VerificarDANFeABI;
  TACBrNFeABI(FACBrNFeABI).DANFEABI.ImprimirDANFEABIPDF;
end;

function TNotasFiscais.Insert(Index: integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: integer; const Value: TNotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Validar;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].Validar;   // Dispara exception em caso de erro
end;

function TNotasFiscais.VerificarAssinatura(out Erros: String): Boolean;
var
  i: integer;
begin
  Result := True;
  Erros := '';

  if Self.Count < 1 then
  begin
    Erros := 'Nenhum NFeABI carregado';
    Result := False;
    Exit;
  end;

  for i := 0 to Self.Count - 1 do
  begin
    if not Self.Items[i].VerificarAssinatura then
    begin
      Result := False;
      Erros := Erros + Self.Items[i].ErroValidacao + sLineBreak;
    end;
  end;
end;

function TNotasFiscais.ValidarRegrasdeNegocios(out Erros: String): Boolean;
var
  i: integer;
begin
  Result := True;
  Erros := '';

  for i := 0 to Self.Count - 1 do
  begin
    if not Self.Items[i].ValidarRegrasdeNegocios then
    begin
      Result := False;
      Erros := Erros + Self.Items[i].ErroRegrasdeNegocios + sLineBreak;
    end;
  end;
end;

function TNotasFiscais.LoadFromFile(const CaminhoArquivo: String;
  AGerarNFeABI: Boolean): Boolean;
var
  XMLUTF8: AnsiString;
  i, l: integer;
begin
  XMLUTF8 := CarregarArquivo(CaminhoArquivo);

  l := Self.Count; // Indice do último Declaracao já existente
  Result := LoadFromString(String(XMLUTF8), AGerarNFeABI);

  if Result then
  begin
    // Atribui Nome do arquivo a novos NotasFiscais inseridos //
    for i := l to Self.Count - 1 do
      Self.Items[i].NomeArq := CaminhoArquivo;
  end;
end;

function TNotasFiscais.LoadFromStream(AStream: TStringStream;
  AGerarNFeABI: Boolean): Boolean;
var
  AXML: AnsiString;
begin
  AStream.Position := 0;
  AXML := ReadStrFromStream(AStream, AStream.Size);

  Result := Self.LoadFromString(String(AXML), AGerarNFeABI);
end;

function TNotasFiscais.LoadFromString(const AXMLString: String;
  AGerarNFeABI: Boolean): Boolean;
var
  ANFeABIXML, XMLStr: AnsiString;
  P, N: integer;

  function PosNFeABI: integer;
  begin
    Result := pos('</NFeABI>', XMLStr);
  end;

begin
  // Verifica se precisa Converter de UTF8 para a String nativa da IDE //
  XMLStr := RemoverUTF8Bom(AXMLString);
  XMLStr := ConverteXMLtoNativeString(XMLStr);
  XMLStr := RemoverDeclaracaoXML(XMLStr);

  N := PosNFeABI;
  while N > 0 do
  begin
    P := pos('</NFeABIProc>', XMLStr);

    if P <= 0 then
      P := pos('</procNFeABI>', XMLStr);  // NFeABI obtido pelo Portal da Receita

    if P > 0 then
    begin
      ANFeABIXML := copy(XMLStr, 1, P + 11);
      XMLStr := Trim(copy(XMLStr, P + 11, length(XMLStr)));
    end
    else
    begin
      ANFeABIXML := copy(XMLStr, 1, N + 7);
      XMLStr := Trim(copy(XMLStr, N + 7, length(XMLStr)));
    end;

    with Self.Add do
    begin
      LerXML(ANFeABIXML);

      if AGerarNFeABI then // Recalcula o XML
        GerarXML;
    end;

    N := PosNFeABI;
  end;

  Result := Self.Count > 0;
end;

function TNotasFiscais.LoadFromIni(const AIniString: String): Boolean;
begin
  with Self.Add do
    LerArqIni(AIniString);

  Result := Self.Count > 0;
end;

function TNotasFiscais.GravarXML(const PathNomeArquivo: String): Boolean;
var
  i: integer;
  NomeArq, PathArq : String;
begin
  Result := True;
  i := 0;
  while Result and (i < Self.Count) do
  begin
    PathArq := ExtractFilePath(PathNomeArquivo);
    NomeArq := ExtractFileName(PathNomeArquivo);
    Result := Self.Items[i].GravarXML(NomeArq, PathArq);
    Inc(i);
  end;
end;

end.
