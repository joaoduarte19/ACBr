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

unit ACBrNFAgNotasFiscais;

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAgConfiguracoes, ACBrNFAg.Classes,
  ACBrNFAg.IniReader, ACBrNFAg.IniWriter,
  ACBrNFAg.XmlReader, ACBrNFAg.XmlWriter;

type

  { TNotaFiscal }

  TNotaFiscal = class(TCollectionItem)
  private
    FNFAg: TNFAg;
    // Xml
    FNFAgW: TNFAgXmlWriter;
    FNFAgR: TNFAgXmlReader;
    // Ini
    FNFAgIniR: TNFAgIniReader;
    FNFAgIniW: TNFAgIniWriter;
    FConfiguracoes: TConfiguracoesNFAg;
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
    function GerarNFAgIni: string;

    function GerarXML: string;
    function GravarXML(const NomeArquivo: string = ''; const PathArquivo: string = ''): Boolean;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings = nil;
      EnviaPDF: Boolean = True; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil; ManterPDFSalvo: Boolean = True;
      sBCC: Tstrings = nil);

    function CalcularNomeArquivoCompleto(NomeArquivo: string = '';
      PathArquivo: string = ''): string;

    property NomeArq: string read FNomeArq write FNomeArq;
    property NFAg: TNFAg read FNFAg;

    // Atribuir a "XML", faz o componente transferir os dados lido para as propriedades internas e "XMLAssinado"
    property XML: string read FXMLOriginal   write SetXML;
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
    FACBrNFAg: TComponent;
    FConfiguracoes: TConfiguracoesNFAg;

    function GetItem(Index: Integer): TNotaFiscal;
    procedure SetItem(Index: Integer; const Value: TNotaFiscal);

    procedure VerificarDANFAg;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    function Add: TNotaFiscal;
    function Insert(Index: Integer): TNotaFiscal;

    procedure GerarNFAg;
    procedure Assinar;
    procedure Validar;
    function VerificarAssinatura(out Erros: string): Boolean;
    function ValidarRegrasdeNegocios(out Erros: string): Boolean;
    procedure Imprimir;
    procedure ImprimirCancelado;
    procedure ImprimirResumido;
    procedure ImprimirPDF;
    procedure ImprimirResumidoPDF;

    // Incluido o Parametro AGerarNFAg que determina se após carregar os dados da NFAg
    // para o componente, será gerado ou não novamente o XML da NFAg.
    function LoadFromFile(const CaminhoArquivo: string; AGerarNFAg: Boolean = False): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFAg: Boolean = False): Boolean;
    function LoadFromString(const AXMLString: string; AGerarNFAg: Boolean = False): Boolean;
    function LoadFromIni(const AIniString: string): Boolean;

    function GerarIni: string;
    function GravarXML(const APathNomeArquivo: string = ''): Boolean;

    function GetNamePath: string; override;

    property ACBrNFAg: TComponent read FACBrNFAg;
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
  ACBrNFAg,
  ACBrNFAg.Conversao,
  ACBrNFAg.ValidarRegrasdeNegocio,
  ACBrXmlDocument;

{ TNotaFiscal }

constructor TNotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);

  FNFAg := TNFAg.Create;
  // Xml
  FNFAgW := TNFAgXmlWriter.Create(FNFAg);
  FNFAgR := TNFAgXmlReader.Create(FNFAg);
  // Ini
  FNFAgIniR := TNFAgIniReader.Create(FNFAg);
  FNFAgIniW := TNFAgIniWriter.Create(FNFAg);

  FConfiguracoes := TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).Configuracoes;

  FNFAg.Ide.verProc := 'ACBrNFAg';

  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    FNFAg.Ide.modelo := 75;
    FNFAg.infNFAg.Versao := VersaoNFAgToDbl(Configuracoes.Geral.VersaoDF);
    FNFAg.Ide.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
    FNFAg.Ide.tpEmis := TACBrTipoEmissao(Configuracoes.Geral.FormaEmissao);
  end;
end;

destructor TNotaFiscal.Destroy;
begin
  // Xml
  FNFAgW.Free;
  FNFAgR.Free;
  // Ini
  FNFAgIniR.Free;
  FNFAgIniW.Free;

  FNFAg.Free;

  inherited Destroy;
end;

procedure TNotaFiscal.Imprimir;
begin
  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    if not Assigned(DANFAg) then
      raise EACBrNFAgException.Create('Componente DANFAg não associado.')
    else
      DANFAg.ImprimirDANFAg(NFAg);
  end;
end;

procedure TNotaFiscal.ImprimirPDF;
begin
  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    if not Assigned(DANFAg) then
      raise EACBrNFAgException.Create('Componente DANFAg não associado.')
    else
      DANFAg.ImprimirDANFAgPDF(NFAg);
  end;
end;

procedure TNotaFiscal.Assinar;
var
  XMLStr: string;
  XMLUTF8: AnsiString;
  Document: TACBrXmlDocument;
  ANode, SignatureNode, ReferenceNode, X509DataNode: TACBrXmlNode;
begin
  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    if not Assigned(SSL.AntesDeAssinar) then
      SSL.ValidarCNPJCertificado( NFAg.Emit.CNPJ );
  end;

  // Gera novamente, para processar propriedades que podem ter sido modificadas
  XMLStr := GerarXML;

  // XML já deve estar em UTF8, para poder ser assinado //
  XMLUTF8 := ConverteXMLtoUTF8(XMLStr);

  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    FXMLAssinado := SSL.Assinar(String(XMLUTF8), 'NFAg', 'infNFAg');
    // SSL.Assinar() sempre responde em UTF8...
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

          NFAg.Signature.URI := ObterConteudoTag(ReferenceNode.Attributes.Items['URI']);

          NFAg.Signature.DigestValue :=
            ObterConteudoTag(ReferenceNode.Childrens.FindAnyNs('DigestValue'), tcStr);

          NFAg.Signature.SignatureValue :=
            ObterConteudoTag(SignatureNode.Childrens.FindAnyNs('SignatureValue'), tcStr);

          NFAg.Signature.X509Certificate :=
            ObterConteudoTag(X509DataNode.Childrens.FindAnyNs('X509Certificate'), tcStr);
        end;
      end;
    finally
      FreeAndNil(Document);
    end;

    NFAg.infNFAgSupl.qrCodNFAg := GetURLQRCode(NFAg);
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
  NotaEhValida{, ok}: Boolean;
  ALayout: TLayOut;
  VerServ: Real;
begin
  AXML := FXMLAssinado;
  if AXML = '' then
    AXML := XMLOriginal;

  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    VerServ := FNFAg.infNFAg.Versao;
    ALayout := LayNFAgRecepcao;

    // Extraindo apenas os dados da NFAg (sem NFAgProc)
    AXML := ObterDFeXML(AXML, 'NFAg', ACBRNFAG_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFAg não encontrada no XML');
      NotaEhValida := False;
    end
    else
      NotaEhValida := SSL.Validar(AXML, GerarNomeArqSchema(ALayout, VerServ), Erro);

    if not NotaEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados da nota: ') +
        IntToStr(NFAg.Ide.nNF) + sLineBreak + FAlertas;
      FErroValidacaoCompleto := FErroValidacao + sLineBreak + Erro;

      raise EACBrNFAgException.CreateDef(
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

  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    // Extraindo apenas os dados da NFAg (sem NFAgProc)
    AXML := ObterDFeXML(AXML, 'NFAg', ACBRNFAG_NAMESPACE);

    if EstaVazio(AXML) then
    begin
      Erro := ACBrStr('NFAg não encontrada no XML');
      AssEhValida := False;
    end
    else
      AssEhValida := SSL.VerificarAssinatura(AXML, Erro, 'infNFAg');

    if not AssEhValida then
    begin
      FErroValidacao := ACBrStr('Falha na validação da assinatura da nota: ') +
        IntToStr(NFAg.Ide.nNF) + sLineBreak + Erro;
    end;
  end;

  Result := AssEhValida;
end;

function TNotaFiscal.ValidarRegrasdeNegocios: Boolean;
var
  Agora: TDateTime;
  FValidarRegras: TNFAgValidarRegras;
begin
  // Converte o DateTime do Sistema para o TimeZone configurado, para evitar
  // divergência de Fuso Horário.
  Agora := DataHoraTimeZoneModoDeteccao(TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg));

  FValidarRegras := TNFAgValidarRegras.Create(FNFAg);

  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
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

  FNFAgR.Arquivo := XMLOriginal;
  FNFAgR.LerXml;
  Result := True;
end;

function TNotaFiscal.LerArqIni(const AIniString: string): Boolean;
begin
  FNFAgIniR.VersaoDF := FConfiguracoes.Geral.VersaoDF;
  FNFAgIniR.Ambiente := Integer(FConfiguracoes.WebServices.Ambiente);
  FNFAgIniR.tpEmis := FConfiguracoes.Geral.FormaEmissaoCodigo;

  FNFAgIniR.LerIni(AIniString);

  GerarXML;

  Result := True;
end;

function TNotaFiscal.GerarNFAgIni: string;
begin
  Result := FNFAgIniW.GravarIni;
end;

function TNotaFiscal.GravarXML(const NomeArquivo: string; const PathArquivo: string): Boolean;
begin
  if EstaVazio(FXMLOriginal) then
    GerarXML;

  FNomeArq := CalcularNomeArquivoCompleto(NomeArquivo, PathArquivo);

  Result := TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).Gravar(FNomeArq, FXMLOriginal);
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
  StreamNFAg: TMemoryStream;
begin
  if not Assigned(TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).MAIL) then
    raise EACBrNFAgException.Create('Componente ACBrMail não associado');

  AnexosEmail := TStringList.Create;
  StreamNFAg := TMemoryStream.Create;
  try
    AnexosEmail.Clear;

    if Assigned(Anexos) then
      AnexosEmail.Assign(Anexos);

    with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
    begin
      Self.GravarStream(StreamNFAg);

      if (EnviaPDF) then
      begin
        if Assigned(DANFAg) then
        begin
          DANFAg.ImprimirDANFAgPDF(FNFAg);
          NomeArqTemp := PathWithDelim(DANFAg.PathPDF) + NumID + '-NFAg.pdf';
          AnexosEmail.Add(NomeArqTemp);
        end;
      end;

      EnviarEmail( sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFAg,
                   NumID +'-NFAg.xml', sReplyTo, sBCC);
    end;
  finally
    if not ManterPDFSalvo then
      DeleteFile(NomeArqTemp);

    AnexosEmail.Free;
    StreamNFAg.Free;
  end;
end;

function TNotaFiscal.GerarXML: string;
var
  IdAnterior : string;
begin
  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    IdAnterior := NFAg.infNFAg.ID;

    FNFAgW.Opcoes.FormatoAlerta  := Configuracoes.Geral.FormatoAlerta;
    FNFAgW.Opcoes.RetirarAcentos := Configuracoes.Geral.RetirarAcentos;
    FNFAgW.Opcoes.RetirarEspacos := Configuracoes.Geral.RetirarEspacos;
    FNFAgW.Opcoes.IdentarXML := Configuracoes.Geral.IdentarXML;
    FNFAgW.Opcoes.NormatizarMunicipios  := Configuracoes.Arquivos.NormatizarMunicipios;
    FNFAgW.Opcoes.PathArquivoMunicipios := Configuracoes.Arquivos.PathArquivoMunicipios;
    FNFAgW.Opcoes.QuebraLinha := Configuracoes.WebServices.QuebradeLinha;

    TimeZoneConf.Assign( Configuracoes.WebServices.TimeZoneConf );

    {
      Ao gerar o XML as tags e atributos tem que ser exatamente os da configuração
    }
    {
    FNFAgW.VersaoDF := Configuracoes.Geral.VersaoDF;
    FNFAgW.ModeloDF := 75;
    FNFAgW.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);
    FNFAgW.tpEmis := TACBrTipoEmissao(Configuracoes.Geral.FormaEmissao);
    }
    FNFAgW.idCSRT := Configuracoes.RespTec.IdCSRT;
    FNFAgW.CSRT   := Configuracoes.RespTec.CSRT;
  end;

  FNFAgW.GerarXml;
  //DEBUG
  //WriteToTXT('c:\temp\Notafiscal.xml', FNFAgW.Document.Xml, False, False);

  XMLOriginal := FNFAgW.Document.Xml;

  { XML gerado pode ter nova Chave e ID, então devemos calcular novamente o
    nome do arquivo, mantendo o PATH do arquivo carregado }
  FAlertas := ACBrStr( FNFAgW.ListaDeAlertas.Text );

  if (NaoEstaVazio(FNomeArq) and (IdAnterior <> FNFAg.infNFAg.ID)) then
    FNomeArq := CalcularNomeArquivoCompleto('', ExtractFilePath(FNomeArq));

  Result := FXMLOriginal;
end;

function TNotaFiscal.CalcularNomeArquivo: string;
var
  xID: string;
begin
  xID := Self.NumID;

  if EstaVazio(xID) then
    raise EACBrNFAgException.Create('ID Inválido. Impossível Salvar XML');

  Result := xID + '-NFAg.xml';
end;

function TNotaFiscal.CalcularPathArquivo: string;
var
  Data: TDateTime;
begin
  with TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg) do
  begin
    if Configuracoes.Arquivos.EmissaoPathNFAg then
      Data := FNFAg.Ide.dhEmi
    else
      Data := Now;

    Result := PathWithDelim(Configuracoes.Arquivos.GetPathNFAg(Data, FNFAg.Emit.CNPJ));
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
  chaveNFAg : string;
begin
  DecodeDate(NFAg.ide.dhEmi, wAno, wMes, wDia);

  chaveNFAg := RemoverLiteralChave(NFAg.infNFAg.ID);
  {(*}
  Result := not
    ((Copy(chaveNFAg, 1, 2) <> IntToStrZero(NFAg.Ide.cUF, 2)) or
    (Copy(chaveNFAg, 3, 2)  <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(chaveNFAg, 5, 2)  <> FormatFloat('00', wMes)) or
    (Copy(chaveNFAg, 7, 14)<> PadLeft(OnlyCPFCNPJAlphaNum(NFAg.Emit.CNPJ), 14, '0')) or
    (Copy(chaveNFAg, 21, 2) <> IntToStrZero(NFAg.Ide.modelo, 2)) or
    (Copy(chaveNFAg, 23, 3) <> IntToStrZero(NFAg.Ide.serie, 3)) or
    (Copy(chaveNFAg, 26, 9) <> IntToStrZero(NFAg.Ide.nNF, 9)) or
    (Copy(chaveNFAg, 35, 1) <> TipoEmissaoToStr(NFAg.Ide.tpEmis)) or
    (Copy(chaveNFAg, 36, 1) <> SiteAutorizadorToStr(NFAg.Ide.nSiteAutoriz)) or
    (Copy(chaveNFAg, 37, 7) <> IntToStrZero(NFAg.Ide.cNF, 7)));
  {*)}
end;

function TNotaFiscal.GetConfirmada: Boolean;
begin
  Result := TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).CstatConfirmada(
    FNFAg.procNFAg.cStat);
end;

function TNotaFiscal.GetcStat: Integer;
begin
  Result := FNFAg.procNFAg.cStat;
end;

function TNotaFiscal.GetProcessada: Boolean;
begin
  Result := TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).CstatProcessado(
    FNFAg.procNFAg.cStat);
end;

function TNotaFiscal.GetCancelada: Boolean;
begin
  Result := TACBrNFAg(TNotasFiscais(Collection).ACBrNFAg).CstatCancelada(
    FNFAg.procNFAg.cStat);
end;

function TNotaFiscal.GetMsg: string;
begin
  Result := FNFAg.procNFAg.xMotivo;
end;

function TNotaFiscal.GetNumID: string;
begin
  Result := RemoverLiteralChave(NFAg.infNFAg.ID);
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
  if not (AOwner is TACBrNFAg) then
    raise EACBrNFAgException.Create('AOwner deve ser do tipo TACBrNFAg');

  inherited Create(AOwner, ItemClass);

  FACBrNFAg := TACBrNFAg(AOwner);
  FConfiguracoes := TACBrNFAg(FACBrNFAg).Configuracoes;
end;

function TNotasFiscais.Add: TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].Assinar;
end;

procedure TNotasFiscais.GerarNFAg;
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].GerarXML;
end;

function TNotasFiscais.GetItem(Index: Integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.VerificarDANFAg;
begin
  if not Assigned(TACBrNFAg(FACBrNFAg).DANFAg) then
    raise EACBrNFAgException.Create('Componente DANFAg não associado.');
end;

procedure TNotasFiscais.Imprimir;
begin
  VerificarDANFAg;
  TACBrNFAg(FACBrNFAg).DANFAg.ImprimirDANFAg(nil);
end;

procedure TNotasFiscais.ImprimirCancelado;
begin
  VerificarDANFAg;
  TACBrNFAg(FACBrNFAg).DANFAg.ImprimirDANFAgCancelado(nil);
end;

procedure TNotasFiscais.ImprimirResumido;
begin
  VerificarDANFAg;
  TACBrNFAg(FACBrNFAg).DANFAg.ImprimirDANFAgResumido(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  VerificarDANFAg;
  TACBrNFAg(FACBrNFAg).DANFAg.ImprimirDANFAgPDF(nil);
end;

procedure TNotasFiscais.ImprimirResumidoPDF;
begin
  VerificarDANFAg;
  TACBrNFAg(FACBrNFAg).DANFAg.ImprimirDANFAgResumidoPDF(nil);
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
    Erros := 'Nenhuma NFAg carregada';
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
  AGerarNFAg: Boolean): Boolean;
var
  XMLUTF8: AnsiString;
  i, l: Integer;
begin
  XMLUTF8 := CarregarArquivo(CaminhoArquivo);

  l := Self.Count; // Indice da última nota já existente
  Result := LoadFromString(String(XMLUTF8), AGerarNFAg);

  if Result then
  begin
    // Atribui Nome do arquivo a novas notas inseridas //
    for i := l to Self.Count - 1 do
      Self.Items[i].NomeArq := CaminhoArquivo;
  end;
end;

function TNotasFiscais.LoadFromStream(AStream: TStringStream;
  AGerarNFAg: Boolean): Boolean;
var
  AXML: AnsiString;
begin
  AStream.Position := 0;
  AXML := ReadStrFromStream(AStream, AStream.Size);

  Result := Self.LoadFromString(String(AXML), AGerarNFAg);
end;

function TNotasFiscais.LoadFromString(const AXMLString: string;
  AGerarNFAg: Boolean): Boolean;
var
  ANFAgXML, XMLStr: AnsiString;
  P, N: Integer;

  function PosNFAg: Integer;
  begin
    Result := Pos('</NFAg>', XMLStr);
  end;

begin
  // Verifica se precisa Converter de UTF8 para a string nativa da IDE //
  XMLStr := RemoverUTF8Bom(AXMLString);
  XMLStr := ConverteXMLtoNativeString(XMLStr);
  XMLStr := RemoverDeclaracaoXML(XMLStr);

  N := PosNFAg;
  while N > 0 do
  begin
    P := Pos('</NFAgProc>', XMLStr);

    if P <= 0 then
      P := Pos('</procNFAg>', XMLStr);  // NFAg obtida pelo Portal da Receita

    if P > 0 then
    begin
      ANFAgXML := Copy(XMLStr, 1, P + 10);
      XMLStr := Trim(Copy(XMLStr, P + 10, length(XMLStr)));
    end
    else
    begin
      ANFAgXML := Copy(XMLStr, 1, N + 6);
      XMLStr := Trim(Copy(XMLStr, N + 6, length(XMLStr)));
    end;

    with Self.Add do
    begin
      LerXML(ANFAgXML);

      if AGerarNFAg then // Recalcula o XML
        GerarXML;
    end;

    N := PosNFAg;
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
    Result := Self.Items[0].GerarNFAgIni;
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
