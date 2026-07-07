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

unit ACBrNFGasNotasFiscais;

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGasConfiguracoes, ACBrNFGas.Classes,
  ACBrNFGas.IniReader, ACBrNFGas.IniWriter,
  ACBrNFGas.XmlReader, ACBrNFGas.XmlWriter;

type
  { TNotaFiscal }

  TNotaFiscal = class(TCollectionItem)
  private
    FNFGas: TNFGas;
    // Xml
    FNFGasW: TNFGasXmlWriter;
    FNFGasR: TNFGasXmlReader;
    // Ini
    FNFGasIniR: TNFGasIniReader;
    FNFGasIniW: TNFGasIniWriter;
    FConfiguracoes: TConfiguracoesNFGas;
    FXMLAssinado: string;
    FXMLOriginal: string;
    FAlertas: string;
    FErroValidacao: string;
    FErroValidacaoCompleto: string;
    FErroRegrasdeNegocios: string;
    FNomeArq: string;

    function GetConfirmada: Boolean;
    function GetcStat: Integer;
    function GetProcessada: Boolean;
    function GetCancelada: Boolean;

    function GetMsg: string;
    function GetNumID: string;
    function GetXMLAssinado: string;
    procedure SetXML(const AValue: string);
    procedure SetXMLOriginal(const AValue: string);
    function ValidarConcatChave: Boolean;
    function CalcularNomeArquivo: string;
    function CalcularPathArquivo: string;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;

    procedure Imprimir;
    procedure ImprimirPDF;

    procedure Assinar;
    procedure Validar;
    function VerificarAssinatura: Boolean;
    function ValidarRegrasdeNegocios: Boolean;

    function LerXML(const AXML: string): Boolean;
    function LerArqIni(const AIniString: string): Boolean;
    function GerarNFGasIni: string;

    function GerarXML: string;
    function GravarXML(const NomeArquivo: string = ''; const PathArquivo: string = ''): Boolean;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings = nil;
      EnviaPDF: Boolean = True; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil; ManterPDFSalvo: Boolean = True;
      sBCC: Tstrings = nil);

    function CalcularNomeArquivoCompleto(NomeArquivo: string = ''; PathArquivo: string = ''): string;

    property NomeArq: string read FNomeArq write FNomeArq;
    property NFGas: TNFGas read FNFGas;

    // Atribuir a "XML", faz o componente transferir os dados lido para as propriedades internas e "XMLAssinado"
    property XML: string read FXMLOriginal write SetXML;
    // Atribuir a "XMLOriginal", reflete em XMLAssinado, se existir a tag de assinatura
    property XMLOriginal: string read FXMLOriginal write SetXMLOriginal;      // Sempre deve estar em UTF8
    property XMLAssinado: string read GetXMLAssinado write FXMLAssinado;      // Sempre deve estar em UTF8
    property Confirmada: Boolean read GetConfirmada;
    property Processada: Boolean read GetProcessada;
    property Cancelada: Boolean read GetCancelada;
    property cStat: Integer read GetcStat;
    property Msg: string read GetMsg;
    property NumID: string read GetNumID;

    property Alertas: string read FAlertas;
    property ErroValidacao: string read FErroValidacao;
    property ErroValidacaoCompleto: string read FErroValidacaoCompleto;
    property ErroRegrasdeNegocios: string read FErroRegrasdeNegocios;
  end;

  { TNotasFiscais }

  TNotasFiscais = class(TOwnedCollection)
  private
    FACBrNFGas: TComponent;
    FConfiguracoes: TConfiguracoesNFGas;

    function GetItem(Index: Integer): TNotaFiscal;
    procedure SetItem(Index: Integer; const Value: TNotaFiscal);

    procedure VerificarDANFGas;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    function Add: TNotaFiscal;
    function Insert(Index: Integer): TNotaFiscal;

    procedure GerarNFGas;
    procedure Assinar;
    procedure Validar;
    function VerificarAssinatura(out Erros: string): Boolean;
    function ValidarRegrasdeNegocios(out Erros: string): Boolean;
    procedure Imprimir;
    procedure ImprimirCancelado;
    procedure ImprimirResumido;
    procedure ImprimirPDF;
    procedure ImprimirResumidoPDF;

    // Incluido o Parametro AGerarNFGas que determina se após carregar os dados da NFGas
    // para o componente, será gerado ou não novamente o XML da NFGas.
    function LoadFromFile(const CaminhoArquivo: string; AGerarNFGas: Boolean = False): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFGas: Boolean = False): Boolean;
    function LoadFromString(const AXMLString: string; AGerarNFGas: Boolean = False): Boolean;
    function LoadFromIni(const AIniString: string): Boolean;

    function GerarIni: string;
    function GravarXML(const APathNomeArquivo: string = ''): Boolean;

    function GetNamePath: string; override;

    property ACBrNFGas: TComponent read FACBrNFGas;
    property Items[Index: Integer]: TNotaFiscal read GetItem write SetItem; default;
  end;

implementation

uses
  dateutils, IniFiles,
  synautil,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrDFeUtil,
  ACBrNFGas,
  ACBrNFGas.ValidarRegrasdeNegocio,
  ACBrNFGas.Conversao,
  ACBrXmlDocument;

{ TNotaFiscal }

constructor TNotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);

  FNFGas := TNFGas.Create;
  // Xml
  FNFGasW := TNFGasXmlWriter.Create(FNFGas);
  FNFGasR := TNFGasXmlReader.Create(FNFGas);
  // Ini
  FNFGasIniR := TNFGasIniReader.Create(FNFGas);
  FNFGasIniW := TNFGasIniWriter.Create(FNFGas);

  FConfiguracoes := TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).Configuracoes;

  FNFGas.Ide.verProc := 'ACBrNFGas';

  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    FNFGas.Ide.modelo := 76;
    FNFGas.infNFGas.Versao := VersaoNFGasToDbl(Configuracoes.Geral.VersaoDF);
    FNFGas.Ide.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
    FNFGas.Ide.tpEmis := TACBrTipoEmissao(Configuracoes.Geral.FormaEmissao);
  end;
end;

destructor TNotaFiscal.Destroy;
begin
  // Xml
  FNFGasW.Free;
  FNFGasR.Free;
  // Ini
  FNFGasIniR.Free;
  FNFGasIniW.Free;

  FNFGas.Free;

  inherited Destroy;
end;

procedure TNotaFiscal.Imprimir;
begin
  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    if not Assigned(DANFGas) then
      raise EACBrNFGasException.Create('Componente DANFGas não associado.')
    else
      DANFGas.ImprimirDANFGas(NFGas);
  end;
end;

procedure TNotaFiscal.ImprimirPDF;
begin
  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    if not Assigned(DANFGas) then
      raise EACBrNFGasException.Create('Componente DANFGas não associado.')
    else
      DANFGas.ImprimirDANFGasPDF(NFGas);
  end;
end;

procedure TNotaFiscal.Assinar;
var
  XMLStr: string;
  XMLUTF8: AnsiString;
  Document: TACBrXmlDocument;
  ANode, SignatureNode, ReferenceNode, X509DataNode: TACBrXmlNode;
begin
  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    if not Assigned(SSL.AntesDeAssinar) then
      SSL.ValidarCNPJCertificado(NFGas.Emit.CNPJ);
  end;

  // Gera novamente, para processar propriedades que podem ter sido modificadas
  XMLStr := GerarXML;

  // XML já deve estar em UTF8, para poder ser assinado //
  XMLUTF8 := ConverteXMLtoUTF8(XMLStr);

  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    FXMLAssinado := SSL.Assinar(String(XMLUTF8), 'NFGas', 'infNFGas');
    FXMLOriginal := FXMLAssinado;

    Document := TACBrXmlDocument.Create;
    try
      Document.LoadFromXml(FXMLOriginal);
      ANode := Document.Root;

      if ANode <> nil then
      begin
        SignatureNode := ANode.Childrens.FindAnyNs('Signature');

        if Assigned(SignatureNode) then
        begin
          ReferenceNode := SignatureNode.Childrens.FindAnyNs('SignedInfo')
                                        .Childrens.FindAnyNs('Reference');

          X509DataNode := SignatureNode.Childrens.FindAnyNs('KeyInfo')
                                       .Childrens.FindAnyNs('X509Data');

          NFGas.Signature.URI := ObterConteudoTag(ReferenceNode.Attributes.Items['URI']);

          NFGas.Signature.DigestValue :=
            ObterConteudoTag(ReferenceNode.Childrens.FindAnyNs('DigestValue'), tcStr);

          NFGas.Signature.SignatureValue :=
            ObterConteudoTag(SignatureNode.Childrens.FindAnyNs('SignatureValue'), tcStr);

          NFGas.Signature.X509Certificate :=
            ObterConteudoTag(X509DataNode.Childrens.FindAnyNs('X509Certificate'), tcStr);
        end;
      end;
    finally
      FreeAndNil(Document);
    end;

    NFGas.infNFGasSupl.qrCodNFGas := GetURLQRCode(NFGas);
    GerarXML;

    if Configuracoes.Arquivos.Salvar then
    begin
      if NaoEstaVazio(NomeArq) then
        Gravar(NomeArq, FXMLAssinado)
      else
      begin
        NomeArq := CalcularNomeArquivoCompleto();
        Gravar(NomeArq, FXMLAssinado);
      end;
    end;
  end;
end;

procedure TNotaFiscal.Validar;
var
  Erro, AXML: string;
  NotaEhValida: Boolean;
  ALayout: TLayOutNFGas;
  VerServ: Real;
begin
  AXML := FXMLAssinado;
  if AXML = '' then
    AXML := XMLOriginal;

  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    VerServ := FNFGas.infNFGas.Versao;
    ALayout := LayNFGasRecepcao;

    // Extraindo apenas os dados da NFAg (sem NFAgProc)
    AXML := ObterDFeXML(AXML, 'NFGas', ACBRNFGAS_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFGas não encontrada no XML');
      NotaEhValida := False;
    end
    else
      NotaEhValida := SSL.Validar(AXML, GerarNomeArqSchema(ALayout, VerServ), Erro);

    if not NotaEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados da nota: ') +
        IntToStr(NFGas.Ide.nNF) + sLineBreak + FAlertas;

      FErroValidacaoCompleto := FErroValidacao + sLineBreak + Erro;

      raise EACBrNFGasException.CreateDef(
        IfThen(Configuracoes.Geral.ExibirErroSchema, ErroValidacaoCompleto,
          ErroValidacao));
    end;
  end;
end;

function TNotaFiscal.VerificarAssinatura: Boolean;
var
  Erro, AXML: string;
  AssEhValida: Boolean;
begin
  AXML := FXMLAssinado;
  if AXML = '' then
    AXML := XMLOriginal;

  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    // Extraindo apenas os dados da NFGas (sem NFGasProc)
    AXML := ObterDFeXML(AXML, 'NFGas', ACBRNFGAS_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFGas não encontrada no XML');
      AssEhValida := False;
    end
    else
      AssEhValida := SSL.VerificarAssinatura(AXML, Erro, 'infNFGas');

    if not AssEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação da assinatura da nota: ') +
        IntToStr(NFGas.Ide.nNF) + sLineBreak + Erro;
    end;
  end;

  Result := AssEhValida;
end;

function TNotaFiscal.ValidarRegrasdeNegocios: Boolean;
var
  Agora: TDateTime;
  FValidarRegras: TNFGasValidarRegras;
begin
  // Converte o DateTime do Sistema para o TimeZone configurado, para evitar
  // divergência de Fuso Horário.
  Agora := DataHoraTimeZoneModoDeteccao(TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas));

  FValidarRegras := TNFGasValidarRegras.Create(FNFGas);

  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
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

function TNotaFiscal.LerXML(const AXML: string): Boolean;
begin
  XMLOriginal := AXML;

  FNFGasR.Arquivo := XMLOriginal;
  FNFGasR.LerXml;

  Result := True;
end;

function TNotaFiscal.LerArqIni(const AIniString: string): Boolean;
begin
  FNFGasIniR.VersaoDF := FConfiguracoes.Geral.VersaoDF;
  FNFGasIniR.Ambiente := Integer(FConfiguracoes.WebServices.Ambiente);
  FNFGasIniR.tpEmis := FConfiguracoes.Geral.FormaEmissaoCodigo;

  FNFGasIniR.LerIni(AIniString);

  GerarXML;

  Result := True;
end;

function TNotaFiscal.GerarNFGasIni: string;
begin
  Result := FNFGasIniW.GravarIni;
end;

function TNotaFiscal.GravarXML(const NomeArquivo: string; const PathArquivo: string): Boolean;
begin
  if EstaVazio(FXMLOriginal) then
    GerarXML;

  FNomeArq := CalcularNomeArquivoCompleto(NomeArquivo, PathArquivo);

  Result := TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).Gravar(FNomeArq, FXMLOriginal);
end;

function TNotaFiscal.GravarStream(AStream: TStream): Boolean;
begin
  if EstaVazio(FXMLOriginal) then
    GerarXML;

  AStream.Size := 0;
  WriteStrToStream(AStream, AnsiString(FXMLOriginal));

  Result := True;
end;

procedure TNotaFiscal.EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings;
  EnviaPDF: Boolean; sCC: TStrings; Anexos: TStrings; sReplyTo: TStrings;
  ManterPDFSalvo: Boolean; sBCC: Tstrings);
var
  NomeArqTemp: string;
  AnexosEmail: TStrings;
  StreamNFGas: TMemoryStream;
begin
  if not Assigned(TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).MAIL) then
    raise EACBrNFGasException.Create('Componente ACBrMail não associado');

  AnexosEmail := TStringList.Create;
  StreamNFGas := TMemoryStream.Create;
  try
    AnexosEmail.Clear;

    if Assigned(Anexos) then
      AnexosEmail.Assign(Anexos);

    with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
    begin
      Self.GravarStream(StreamNFGas);

      if (EnviaPDF) then
      begin
        if Assigned(DANFGas) then
        begin
          DANFGas.ImprimirDANFGasPDF(FNFGas);
          NomeArqTemp := PathWithDelim(DANFGas.PathPDF) + NumID + '-NFGas.pdf';
          AnexosEmail.Add(NomeArqTemp);
        end;
      end;

      EnviarEmail( sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFGas,
                   NumID +'-NFGas.xml', sReplyTo, sBCC);
    end;
  finally
    if not ManterPDFSalvo then
      DeleteFile(NomeArqTemp);

    AnexosEmail.Free;
    StreamNFGas.Free;
  end;
end;

function TNotaFiscal.GerarXML: string;
var
  IdAnterior: string;
begin
  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    IdAnterior := FNFGas.infNFGas.ID;

    FNFGasW.Opcoes.FormatoAlerta := Configuracoes.Geral.FormatoAlerta;
    FNFGasW.Opcoes.RetirarAcentos := Configuracoes.Geral.RetirarAcentos;
    FNFGasW.Opcoes.RetirarEspacos := Configuracoes.Geral.RetirarEspacos;
    FNFGasW.Opcoes.IdentarXML := Configuracoes.Geral.IdentarXML;
    FNFGasW.Opcoes.NormatizarMunicipios := Configuracoes.Arquivos.NormatizarMunicipios;
    FNFGasW.Opcoes.PathArquivoMunicipios := Configuracoes.Arquivos.PathArquivoMunicipios;
    FNFGasW.Opcoes.QuebraLinha := Configuracoes.WebServices.QuebradeLinha;

    TimeZoneConf.Assign( Configuracoes.WebServices.TimeZoneConf );

    {
      Ao gerar o XML as tags e atributos tem que ser exatamente os da configuração
    }
    {
    FNFGasW.VersaoDF := Configuracoes.Geral.VersaoDF;
    FNFGasW.ModeloDF := 76;
    FNFGasW.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
    FNFGasW.tpEmis := TACBrTipoEmissao(Configuracoes.Geral.FormaEmissao);
    }
    FNFGasW.idCSRT := Configuracoes.RespTec.IdCSRT;
    FNFGasW.CSRT   := Configuracoes.RespTec.CSRT;
  end;

  FNFGasW.GerarXml;
  //DEBUG
  //WriteToTXT('c:\temp\Notafiscal.xml', FNFGasW.Document.Xml, False, False);

  XMLOriginal := FNFGasW.Document.Xml;

  { XML gerado pode ter nova Chave e ID, então devemos calcular novamente o
    nome do arquivo, mantendo o PATH do arquivo carregado }
  FAlertas := ACBrStr(FNFGasW.ListaDeAlertas.Text);

  if NaoEstaVazio(FNomeArq) and (IdAnterior <> FNFGas.infNFGas.ID) then
    FNomeArq := CalcularNomeArquivoCompleto('', ExtractFilePath(FNomeArq));

  Result := FXMLOriginal;
end;

function TNotaFiscal.CalcularNomeArquivo: string;
var
  xID: string;
begin
  xID := NumID;

  if EstaVazio(xID) then
    raise EACBrNFGasException.Create('ID Inválido. Impossível Salvar XML');

  Result := xID + '-NFGas.xml';
end;

function TNotaFiscal.CalcularPathArquivo: string;
var
  Data: TDateTime;
begin
  with TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas) do
  begin
    if Configuracoes.Arquivos.EmissaoPathNFGas then
      Data := FNFGas.Ide.dhEmi
    else
      Data := Now;

    Result := PathWithDelim(Configuracoes.Arquivos.GetPathNFGas(Data, FNFGas.Emit.CNPJ));
  end;
end;

function TNotaFiscal.CalcularNomeArquivoCompleto(NomeArquivo: string;
  PathArquivo: string): string;
var
  PathNoArquivo: string;
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
  chaveNFGas : string;
begin
  DecodeDate(NFGas.ide.dhEmi, wAno, wMes, wDia);

  chaveNFGas := RemoverLiteralChave(NFGas.infNFGas.ID);
  {(*}
  Result := not
    ((Copy(chaveNFGas, 1, 2) <> IntToStrZero(NFGas.Ide.cUF, 2)) or
    (Copy(chaveNFGas, 3, 2)  <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(chaveNFGas, 5, 2)  <> FormatFloat('00', wMes)) or
    (Copy(chaveNFGas, 7, 14) <> PadLeft(OnlyCPFCNPJAlphaNum(NFGas.Emit.CNPJ), 14, '0')) or
    (Copy(chaveNFGas, 21, 2) <> IntToStrZero(NFGas.Ide.modelo, 2)) or
    (Copy(chaveNFGas, 23, 3) <> IntToStrZero(NFGas.Ide.serie, 3)) or
    (Copy(chaveNFGas, 26, 9) <> IntToStrZero(NFGas.Ide.nNF, 9)) or
    (Copy(chaveNFGas, 35, 1) <> TipoEmissaoToStr(NFGas.Ide.tpEmis)) or
    (Copy(chaveNFGas, 36, 1) <> SiteAutorizadorToStr(NFGas.Ide.nSiteAutoriz)) or
    (Copy(chaveNFGas, 37, 7) <> IntToStrZero(NFGas.Ide.cNF, 7)));
  {*)}
end;

function TNotaFiscal.GetConfirmada: Boolean;
begin
  Result := TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).CstatConfirmada(
    FNFGas.procNFGas.cStat);
end;

function TNotaFiscal.GetcStat: Integer;
begin
  Result := FNFGas.procNFGas.cStat;
end;

function TNotaFiscal.GetProcessada: Boolean;
begin
  Result := TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).CstatProcessado(
    FNFGas.procNFGas.cStat);
end;

function TNotaFiscal.GetCancelada: Boolean;
begin
  Result := TACBrNFGas(TNotasFiscais(Collection).ACBrNFGas).CstatCancelada(
    FNFGas.procNFGas.cStat);
end;

function TNotaFiscal.GetMsg: string;
begin
  Result := FNFGas.procNFGas.xMotivo;
end;

function TNotaFiscal.GetNumID: string;
begin
  Result := RemoverLiteralChave(NFGas.infNFGas.ID);
end;

function TNotaFiscal.GetXMLAssinado: string;
begin
  if EstaVazio(FXMLAssinado) then
    Assinar;

  Result := FXMLAssinado;
end;

procedure TNotaFiscal.SetXML(const AValue: string);
begin
  LerXML(AValue);
end;

procedure TNotaFiscal.SetXMLOriginal(const AValue: string);
var
  XMLUTF8: string;
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

{ TNotasFiscais }

constructor TNotasFiscais.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFGas) then
    raise EACBrNFGasException.Create('AOwner deve ser do tipo TACBrNFGas');

  inherited Create(AOwner, ItemClass);

  FACBrNFGas := TACBrNFGas(AOwner);
  FConfiguracoes := TACBrNFGas(FACBrNFGas).Configuracoes;
end;

function TNotasFiscais.Add: TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].Assinar;
  end;
end;

procedure TNotasFiscais.GerarNFGas;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].GerarXML;
  end;
end;

function TNotasFiscais.GetItem(Index: Integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.VerificarDANFGas;
begin
  if not Assigned(TACBrNFGas(FACBrNFGas).DANFGas) then
    raise EACBrNFGasException.Create('Componente DANFGas não associado.');
end;

procedure TNotasFiscais.Imprimir;
begin
  VerificarDANFGas;
  TACBrNFGas(FACBrNFGas).DANFGas.ImprimirDANFGas(nil);
end;

procedure TNotasFiscais.ImprimirCancelado;
begin
  VerificarDANFGas;
  TACBrNFGas(FACBrNFGas).DANFGas.ImprimirDANFGasCancelado(nil);
end;

procedure TNotasFiscais.ImprimirResumido;
begin
  VerificarDANFGas;
  TACBrNFGas(FACBrNFGas).DANFGas.ImprimirDANFGasResumido(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  VerificarDANFGas;
  TACBrNFGas(FACBrNFGas).DANFGas.ImprimirDANFGasPDF(nil);
end;

procedure TNotasFiscais.ImprimirResumidoPDF;
begin
  VerificarDANFGas;
  TACBrNFGas(FACBrNFGas).DANFGas.ImprimirDANFGasResumidoPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: TNotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Validar;
var
  I: Integer;
begin
  for I := 0 to Self.Count - 1 do
    Self.Items[I].Validar;   // Dispara exception em caso de erro
end;

function TNotasFiscais.VerificarAssinatura(out Erros: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  Erros := '';

  if Self.Count < 1 then
  begin
    Erros := 'Nenhuma NFGas carregada';
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

function TNotasFiscais.ValidarRegrasdeNegocios(out Erros: string): Boolean;
var
  i: Integer;
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

function TNotasFiscais.LoadFromFile(const CaminhoArquivo: string;
  AGerarNFGas: Boolean): Boolean;
var
  XMLUTF8: AnsiString;
  i, l: Integer;
begin
  XMLUTF8 := CarregarArquivo(CaminhoArquivo);

  l := Self.Count; // Indice da última nota já existente
  Result := LoadFromString(String(XMLUTF8), AGerarNFGas);

  if Result then
  begin
    // Atribui Nome do arquivo a novas notas inseridas //
    for i := l to Self.Count - 1 do
      Self.Items[i].NomeArq := CaminhoArquivo;
  end;
end;

function TNotasFiscais.LoadFromStream(AStream: TStringStream;
  AGerarNFGas: Boolean): Boolean;
var
  AXML: AnsiString;
begin
  AStream.Position := 0;
  AXML := ReadStrFromStream(AStream, AStream.Size);

  Result := Self.LoadFromString(String(AXML), AGerarNFGas);
end;

function TNotasFiscais.LoadFromString(const AXMLString: string;
  AGerarNFGas: Boolean): Boolean;
var
  ANFGasXML, XMLStr: AnsiString;
  P, N: Integer;

  function PosNFGas: Integer;
  begin
    Result := Pos('</NFGas>', XMLStr);
  end;

begin
  XMLStr := RemoverUTF8Bom(AXMLString);
  XMLStr := ConverteXMLtoNativeString(XMLStr);
  XMLStr := RemoverDeclaracaoXML(XMLStr);

  N := PosNFGas;

  while N > 0 do
  begin
    P := Pos('</NFGasProc>', XMLStr);

    if P <= 0 then
      P := Pos('</procNFGas>', XMLStr);  // NFGas obtida pelo Portal da Receita

    if P > 0 then
    begin
      ANFGasXML := Copy(XMLStr, 1, P + 11);
      XMLStr := Trim(Copy(XMLStr, P + 12, Length(XMLStr)));
    end
    else
    begin
      ANFGasXML := Copy(XMLStr, 1, P + 7);
      XMLStr := Trim(Copy(XMLStr, P + 8, Length(XMLStr)));
    end;

    with Self.Add do
    begin
      LerXML(ANFGasXML);

      if AGerarNFGas then // Recalcula o XML
        GerarXML;
    end;

    N := PosNFGas;
  end;

  Result := Self.Count > 0;
end;

function TNotasFiscais.LoadFromIni(const AIniString: string): Boolean;
begin
  with Self.Add do
    LerArqIni(AIniString);

  Result := Self.Count > 0;
end;

function TNotasFiscais.GerarIni: string;
begin
  Result := '';

  if Self.Count > 0 then
    Result := Self.Items[0].GerarNFGasIni;
end;

function TNotasFiscais.GravarXML(const APathNomeArquivo: string): Boolean;
var
  i: Integer;
  NomeArq, PathArq: string;
begin
  Result := True;
  i := 0;

  while Result and (i < Self.Count) do
  begin
    PathArq := ExtractFilePath(APathNomeArquivo);
    NomeArq := ExtractFileName(APathNomeArquivo);
    Result := Self.Items[i].GravarXML(NomeArq, PathArq);
    Inc(i);
  end;
end;

end.
