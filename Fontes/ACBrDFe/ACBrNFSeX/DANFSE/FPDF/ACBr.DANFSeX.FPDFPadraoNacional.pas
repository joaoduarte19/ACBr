{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Juliomar Marchetti                              }
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

unit ACBr.DANFSeX.FPDFPadraoNacional;

{$I ACBr.inc}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  DateUtils,
  Math,

  ACBr_fpdf,
  ACBr_fpdf_ext,
  ACBr_fpdf_report,

  ACBrNFSeXClass,
  ACBrValidador,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrDFeUtil,
  StrUtilsEx,

  TypInfo,

  ACBr.DANFSeX.Classes,
  ACBr.DANFSeX.FPDF.Utils;

const
  // NT 008, item 2.2 - Pagina A4 retrato (mm)
  cnPaginaLargura       = 210.0;
  cnPaginaAltura        = 297.0;
  cnMargem              = 3.0;     // 0,30 cm (entre 1,5 e 2,0 mm e' o exigido; 3 mm e' confortavel)
  cnLargUtil            = 204.0;   // 20,40 cm

  // NT 008, item 2.2.3 - Linhas e bordas
  cnEspBorda            = 1.0;     // 1 pt -> mm (1 pt = 0,3528 mm) - desenhado como 0,3528
  cnEspLinha            = 0.5;     // 0,5 pt -> 0,176 mm aprox.
  cnPt2Mm               = 0.3528;  // fator pt -> mm

  // NT 008, item 2.4 - Tamanhos de fonte (pontos)
  cnFTituloBloco        = 7.0;
  cnFLabelCampo         = 6.0;
  cnFLabelIdentNFSe     = 7.0;
  cnFConteudo           = 7.0;
  cnFTituloDoc          = 9.0;   // "DANFSe v2.0" e "Documento Auxiliar da NFS-e"
  cnFMunicipio          = 8.0;
  cnFAmbiente           = 6.0;
  cnFTextoQR            = 6.0;
  cnFMarcaDagua         = 50.0;
  cnFSemValidade        = 9.0;

  // NT 008, item 2.4.5 - Cabecalho
  cnCabH                = 11.6;
  cnLogoX               = 4.9;
  cnLogoY               = 4.4;
  cnLogoW               = 40.0;
  cnLogoH               = 8.5;
  cnTituloX             = 54.1;
  cnTituloW             = 101.9;
  cnIdentMunX           = 156.2;
  cnIdentMunW           = 50.9;

  // NT 008, item 2.4.3 - QR Code
  cnQRX                 = 174.8;
  cnQRY                 = 10.7;
  cnQRSize              = 15.2;
  cnQRComplX            = 158.0;
  cnQRComplY            = 23.6;
  cnQRComplW            = 47.2;
  cnQRComplH            = 6.8;
  cURLConsultaPublica   = 'https://www.nfse.gov.br/ConsultaPublica/?tpc=1&chave=';
  cTextoQRComplemento   = 'A autenticidade desta NFS-e pode ser verificada '+ #13+
                          'pela leitura deste codigo QR ou pela consulta da'+ #13+
                          'chave de acesso no portal nacional da NFS-e';

  // Cores - NT 008, item 2.2.3
  cCorCinzaClaroR       = 242;   // 5% K
  cCorCinzaClaroG       = 242;
  cCorCinzaClaroB       = 242;
  cCorCinzaMDR          = 166;   // 35% K (marca d'agua)
  cCorCinzaMDG          = 166;
  cCorCinzaMDB          = 166;
  cCorVermelhoR         = 237;   // M100 Y100 (homologacao)
  cCorVermelhoG         = 28;
  cCorVermelhoB         = 36;

  // Mensagens fixas - NT 008, item 2.3 e 2.5
  cMsgTomadorVazio      = 'TOMADOR/ADQUIRENTE DA OPERACAO NAO IDENTIFICADO NA NFS-e';
  cMsgDestVazio         = 'DESTINATARIO DA OPERACAO NAO IDENTIFICADO NA NFS-e';
  cMsgDestIgualTomador  = 'O DESTINATARIO E O PROPRIO TOMADOR/ADQUIRENTE DA OPERACAO';
  cMsgIntermVazio       = 'INTERMEDIARIO DA OPERACAO NAO IDENTIFICADO NA NFS-e';
  cMsgISSQNVazio        = 'TRIBUTACAO MUNICIPAL (ISSQN) - OPERACAO NAO SUJEITA AO ISSQN';
  cMsgSemValidade       = 'NFS-e SEM VALIDADE JURIDICA';
  cMsgCancelada         = 'CANCELADA';
  cMsgSubstituida       = 'SUBSTITUIDA';

  // Fontes - mapeamento NT 008 -> nucleos FPDF
  // NT 008 exige Arial (labels) e Microsoft Sans Serif (conteudos). Como sao
  // TTF nao-core, ficam como mapeamento logico para Helvetica (core)
  // ate que se embarque as TTFs via AddFont.
  cFontLabel            = 'Arial';  // -> "Arial"
  cFontConteudo         = 'Arial';  // -> "Microsoft Sans Serif"

type
  TACBrDANFSeFPDFPadraoNacional = class(TFPDFReport)
  {$IFDEF SUPPORTS_STRICT}
    strict private
  {$ELSE}
    private
  {$ENDIF}
    FNFSe: TNFSe;
    FCancelada: Boolean;
    FSubstituida: Boolean;
    FHomologacao: Boolean;
    FQRCode: Boolean;
    FLogoPrefeitura: Boolean;
    FLogoNFSe: Boolean;
    FLogoPrefeituraBytes: TBytes;
    FLogoNFSeBytes: TBytes;
    FCabecalhoLinha1: string;
    FCabecalhoLinha2: string;
    FQuebraDeLinha: string;
    FMensagemRodape: string;
    FFormatSettings: TFormatSettings;
    FInitialized: Boolean;
    FPage: TFPDFPage;
  private
    procedure InicializaValoresPadraoObjeto;

    function NN(const S: string): string;
    function Ellipsis(const S: string; MaxLen: Integer): string;
    function FormatVlr(V: Double): string;
    function FormatPerc(V: Double): string;
    function FormatCNPJCPFNIF(const ID: TIdentificacao): string;
    function FormatTelefone(const Contato: TContato): string;
    function FormatCEPBR(const CEP: string): string;
    function FormatMunicipioUF(const End_: TEndereco): string;
    function FormatIBGE_CEP(const End_: TEndereco): string;
    function FormatEnderecoCompleto(const End_: TEndereco): string;
    function FormatDataNT(D: TDateTime): string;
    function FormatDataHoraNT(D: TDateTime): string;

    function GetChaveAcesso: string;
    function GetSituacaoNFSeDescricao: string;
    function GetFinalidadeDescricao: string;
    function GetEmitenteDescricao: string;
    function GetTextoDescricaoServico: string;
    function GetTextoInformacoesComplementares: string;
    function GetTextoTotaisAproximados: string;

    function PossuiTomador: Boolean;
    function PossuiDestinatario: Boolean;
    function DestinatarioEhTomador: Boolean;
    function PossuiIntermediario: Boolean;
    function PossuiISSQN: Boolean;

    procedure DesenharBordaPagina(PDF: IFPDF);
    procedure DesenharRetangulo(PDF: IFPDF; X, Y, W, H: Double);
    procedure DesenharRetanguloSombreado(PDF: IFPDF; X, Y, W, H: Double);
    procedure DesenharTituloBloco(PDF: IFPDF; X, Y, W: Double; const Titulo: string);
    procedure DesenharCampo(PDF: IFPDF; X, Y, W, H: Double;
      const Labl, Valor: string; Sombreado: Boolean = False);
    procedure DesenharLinhaVazia(PDF: IFPDF; X, Y, W: Double; const Mensagem: string);

    procedure BandaCabecalho(Args: TFPDFBandDrawArgs);
    procedure BandaDadosNFSe(Args: TFPDFBandDrawArgs);
    procedure BandaPrestador(Args: TFPDFBandDrawArgs);
    procedure BandaTomador(Args: TFPDFBandDrawArgs);
    procedure BandaDestinatario(Args: TFPDFBandDrawArgs);
    procedure BandaIntermediario(Args: TFPDFBandDrawArgs);
    procedure BandaServicoPrestado(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoMunicipal(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoFederal(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoIBSCBS(Args: TFPDFBandDrawArgs);
    procedure BandaValorTotalNFSe(Args: TFPDFBandDrawArgs);
    procedure BandaInformacoesComplementares(Args: TFPDFBandDrawArgs);
    procedure BandaCanhoto(Args: TFPDFBandDrawArgs);
    procedure BandaMarcaDagua(Args: TFPDFBandDrawArgs);

    function CalcAlturaPrestador: Double;
    function CalcAlturaTomador: Double;
    function CalcAlturaDestinatario: Double;
    function CalcAlturaIntermediario: Double;
    function CalcAlturaServicoPrestado: Double;
    function CalcAlturaTributacaoMunicipal: Double;
    function CalcAlturaTributacaoIBSCBS: Double;
    function CalcAlturaInformacoesComplementares: Double;

  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;

  public
    constructor Create; reintroduce; overload;
    constructor Create(ANFSe: TNFSe); reintroduce; overload;

    procedure SalvarPDF(DadosAuxDANFSe: TDadosNecessariosParaDANFSeX; AStream: TStream); overload;
    procedure SalvarPDF(DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
      const NomeArquivoDestinoPDF: string); overload;
    procedure SalvarPDF(NFSe: TNFSe; DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
      const NomeArquivoDestinoPDF: string); overload;

    property Cancelada: Boolean read FCancelada write FCancelada;
    property Substituida: Boolean read FSubstituida write FSubstituida;
    property Homologacao: Boolean read FHomologacao write FHomologacao;
    property LogoPrefeitura: Boolean read FLogoPrefeitura write FLogoPrefeitura;
    property LogoNFSe: Boolean read FLogoNFSe write FLogoNFSe;
    property LogoPrefeituraBytes: TBytes read FLogoPrefeituraBytes write FLogoPrefeituraBytes;
    property LogoNFSeBytes: TBytes read FLogoNFSeBytes write FLogoNFSeBytes;
    property QRCode: Boolean read FQRCode write FQRCode;
    property CabecalhoLinha1: string read FCabecalhoLinha1 write FCabecalhoLinha1;
    property CabecalhoLinha2: string read FCabecalhoLinha2 write FCabecalhoLinha2;
    property QuebraDeLinha: string read FQuebraDeLinha write FQuebraDeLinha;
    property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
    property NFSe: TNFSe read FNFSe;
  end;

implementation

uses
  ACBrNFSeXConversao;

{ TACBrDANFSeFPDFPadraoNacional }

constructor TACBrDANFSeFPDFPadraoNacional.Create;
begin
  inherited Create;
  InicializaValoresPadraoObjeto;
end;

constructor TACBrDANFSeFPDFPadraoNacional.Create(ANFSe: TNFSe);
begin
  inherited Create;
  InicializaValoresPadraoObjeto;
  FNFSe := ANFSe;
end;

procedure TACBrDANFSeFPDFPadraoNacional.InicializaValoresPadraoObjeto;
begin
{$IFNDEF FPC}
{$IFDEF HAS_FORMATSETTINGS}
  FFormatSettings := TFormatSettings.Create;
{$ENDIF}
{$ENDIF}
  SetUTF8(False);
  FFormatSettings.DecimalSeparator := ',';
  FFormatSettings.ThousandSeparator := '.';

  SetFont(cFontLabel);
  // NT 008, item 2.2.2 - margem entre 1,5 e 2,0 mm; usando 3 mm (dentro da tolerancia)
  SetMargins(cnMargem, cnMargem, cnMargem, cnMargem);
end;

function TACBrDANFSeFPDFPadraoNacional.NN(const S: string): string;
begin
  // NT 008, Nota 12: campo sem informacao no XML deve ser preenchido com '-'
  if Trim(S) = '' then
    Result := '-'
  else
    Result := S;
end;

function TACBrDANFSeFPDFPadraoNacional.Ellipsis(const S: string; MaxLen: Integer): string;
begin
  if (MaxLen > 3) and (Length(S) > MaxLen) then
    Result := Copy(S, 1, MaxLen - 3) + '...'
  else
    Result := S;
end;

function TACBrDANFSeFPDFPadraoNacional.FormatVlr(V: Double): string;
begin
  Result := FormatFloat('#,##0.00', V, FFormatSettings);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatPerc(V: Double): string;
begin
  Result := FormatFloat('#,##0.00', V, FFormatSettings) + '%';
end;

function TACBrDANFSeFPDFPadraoNacional.FormatCNPJCPFNIF(const ID: TIdentificacao): string;
begin
  if ID = nil then
    Exit('-');
  if Trim(ID.CpfCnpj) <> '' then
    Result := FormatarCNPJouCPF(ID.CpfCnpj)
  else if Trim(ID.Nif) <> '' then
    Result := 'NIF: ' + ID.Nif
  else
    Result := '-';
end;

function TACBrDANFSeFPDFPadraoNacional.FormatTelefone(const Contato: TContato): string;
begin
  if Contato = nil then
    Exit('-');
  Result := Trim(Contato.DDD + ' ' + Contato.Telefone);
  if Result = '' then Result := '-';
end;

function TACBrDANFSeFPDFPadraoNacional.FormatCEPBR(const CEP: string): string;
var
  S: string;
begin
  S := OnlyNumber(CEP);
  if Length(S) = 8 then
    Result := Copy(S, 1, 2) + '.' + Copy(S, 3, 3) + '-' + Copy(S, 6, 3)
  else
    Result := NN(CEP);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatMunicipioUF(const End_: TEndereco): string;
begin
  if End_ = nil then Exit('-');
  // NT 008: "Municipio / UF" - usar xMunicipio quando preenchido
  if Trim(End_.xMunicipio) <> '' then
    Result := Ellipsis(End_.xMunicipio.ToUpper + ' / ' + End_.UF, 37)
  else if Trim(End_.CodigoMunicipio) <> '' then
    Result := End_.CodigoMunicipio + ' / ' + End_.UF
  else
    Result := '-';
end;

function TACBrDANFSeFPDFPadraoNacional.FormatIBGE_CEP(const End_: TEndereco): string;
begin
  // NT 008: "nnnnnnn / nn.nnn-nnn"
  if End_ = nil then Exit('-');
  Result := NN(End_.CodigoMunicipio) + ' / ' + FormatCEPBR(End_.CEP);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatEnderecoCompleto(const End_: TEndereco): string;
var
  S: string;
begin
  if End_ = nil then Exit('-');
  S := Trim(End_.Endereco);
  if Trim(End_.Numero) <> '' then
    S := S + ', ' + End_.Numero;
  if Trim(End_.Complemento) <> '' then
    S := S + ', ' + End_.Complemento;
  if Trim(End_.Bairro) <> '' then
    S := S + ', ' + End_.Bairro;
  Result := Ellipsis(NN(S), 77);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatDataNT(D: TDateTime): string;
begin
  if D <= 0 then
    Result := '-'
  else
    Result := FormatDateTime('dd/mm/yyyy', D);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatDataHoraNT(D: TDateTime): string;
begin
  if D <= 0 then
    Result := '-'
  else
    Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', D);
end;

function TACBrDANFSeFPDFPadraoNacional.GetChaveAcesso: string;
var
  S: string;
begin
  if FNFSe = nil then Exit('-');
  S := OnlyNumber(FNFSe.infNFSe.ID);
  if Length(S) = 50 then
    Result := S
  else if Trim(FNFSe.ChaveAcesso) <> '' then
    Result := FNFSe.ChaveAcesso
  else
    Result := '-';
end;

function TACBrDANFSeFPDFPadraoNacional.GetSituacaoNFSeDescricao: string;
begin
  // NT 008: Situacao da NFS-e - usar descricao da opcao prevista no leiaute
  case FNFSe.SituacaoNfse of
    snNormal:           Result := 'NFS-e regular';
    snCancelado:        Result := 'NFS-e cancelada';
    snSubstituido:      Result := 'NFS-e substituida';
  else
    Result := 'NFS-e regular';
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetFinalidadeDescricao: string;
begin
  // NT 008: leiaute preve 3 opcoes (1=Normal, 2=Substituicao, 3=Decisao Judicial/Adm).
  if Substituida or (Trim(FNFSe.NfseSubstituidora) <> '') then
    Result := 'NFS-e de Substituicao'
  else
    Result := 'NFS-e regular';
end;

function TACBrDANFSeFPDFPadraoNacional.GetEmitenteDescricao: string;
begin
  // NT 008: tpEmit - 1=Prestador, 2=Tomador, 3=Intermediario
  Result := 'Prestador';
  case Integer(FNFSe.tpEmit) of
    1: Result := 'Prestador';
    2: Result := 'Tomador';
    3: Result := 'Intermediario';
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoDescricaoServico: string;
var
  S: string;
begin
  if FNFSe = nil then Exit('-');
  S := Trim(FNFSe.Servico.Discriminacao);
  if S = '' then Exit('-');

  S := StringReplace(S, sLineBreak, #10, [rfReplaceAll]);
  S := StringReplace(S, #13, #10, [rfReplaceAll]);
  S := StringReplace(S, #10, sLineBreak, [rfReplaceAll]);
  if Trim(FQuebraDeLinha) <> '' then
    S := StringReplace(S, FQuebraDeLinha, sLineBreak, [rfReplaceAll, rfIgnoreCase]);
  Result := Ellipsis(S, 1297);
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoInformacoesComplementares: string;
var
  Linhas: TStringList;
  S: string;

  procedure AddIfDef(const Rotulo, Valor: string);
  begin
    if Trim(Valor) <> '' then
      Linhas.Add(Rotulo + ' ' + Valor);
  end;

begin
  // NT 008: ordem fixa, separadores '|', encerrando com Totais Aproximados.
  Linhas := TStringList.Create;
  try
    AddIfDef('Inf. Cont.:', FNFSe.OutrasInformacoes);
    AddIfDef('NFS-e Subst.:', FNFSe.NfseSubstituida);
    AddIfDef('Doc. Ref.:', FNFSe.refNF);

    // Campos novos (NT 008) - placeholders preenchiveis quando disponivel no XML
    // AddIfDef('Cod. Obra:',   FNFSe.ConstrucaoCivil.Obra);
    // AddIfDef('Insc. Imob.:', FNFSe.ConstrucaoCivil.InscricaoImobiliaria);
    // AddIfDef('Cod. Evt.:',   ... );

    AddIfDef('Inf. A. T. Mun.:', FNFSe.InformacoesComplementares);

    // Totais Aproximados dos Tributos - linha fixa (NT 008, Nota 10)
    Linhas.Add(GetTextoTotaisAproximados);

    S := Linhas.Text;
    S := StringReplace(S, sLineBreak, ' | ', [rfReplaceAll]);
    S := Trim(S);
    if EndsStr(' |', S) then
      Delete(S, Length(S) - 1, 2);
    Result := Ellipsis(S, 1997 + 200); // limite NT mais margem da linha fixa
  finally
    Linhas.Free;
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoTotaisAproximados: string;
var
  vFed, vEst, vMun: Double;
  Sufixo: string;
begin
  vFed := FNFSe.ValorCargaTributaria;            // tributos federais aproximados
  vEst := FNFSe.ValorCargaTributariaEstadual;
  vMun := FNFSe.ValorCargaTributariaMunicipal;

  if (vFed > 0) or (vEst > 0) or (vMun > 0) then
    Sufixo := Format('Federais: R$ %s; Estaduais: R$ %s; Municipais: R$ %s',
      [FormatVlr(vFed), FormatVlr(vEst), FormatVlr(vMun)])
  else
    Sufixo := Format('Federais: %s; Estaduais: %s; Municipais: %s',
      [FormatPerc(FNFSe.PercentualCargaTributaria),
       FormatPerc(FNFSe.PercentualCargaTributariaEstadual),
       FormatPerc(FNFSe.PercentualCargaTributariaMunicipal)]);

  Result := 'Totais Aproximados dos Tributos cfe. Lei no. 12.741/2012: ' + Sufixo;
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiTomador: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Tomador <> nil) and
            (FNFSe.Tomador.IdentificacaoTomador <> nil) and
            (Trim(FNFSe.Tomador.IdentificacaoTomador.CpfCnpj +
                  FNFSe.Tomador.IdentificacaoTomador.Nif +
                  FNFSe.Tomador.RazaoSocial) <> '');
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiDestinatario: Boolean;
begin
  // Destinatario vem do bloco IBSCBS na NT 008. Sem mapeamento legado:
  // suprimido por padrao.
  Result := False;
end;

function TACBrDANFSeFPDFPadraoNacional.DestinatarioEhTomador: Boolean;
begin
  // Quando destinatario == tomador (sem dados especificos), simplifica.
  Result := PossuiTomador and (not PossuiDestinatario);
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiIntermediario: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Intermediario <> nil) and
            (FNFSe.Intermediario.Identificacao <> nil) and
            (Trim(FNFSe.Intermediario.Identificacao.CpfCnpj +
                  FNFSe.Intermediario.RazaoSocial) <> '');
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiISSQN: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Servico <> nil) and
            (FNFSe.Servico.Valores.ValorIss > 0);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharBordaPagina(PDF: IFPDF);
begin
  // NT 008, item 2.2.3 - borda da pagina 1 pt
  PDF.SetLineWidth(cnPt2Mm * 1.0);
  PDF.SetDrawColor(0);
  PDF.Rect(cnMargem, cnMargem,
           cnPaginaLargura - 2 * cnMargem,
           cnPaginaAltura  - 2 * cnMargem);
  PDF.SetLineWidth(cnPt2Mm * cnEspLinha);   // restaura padrao 0,5 pt
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharRetangulo(PDF: IFPDF; X, Y, W, H: Double);
begin
  PDF.Rect(X, Y, W, H);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharRetanguloSombreado(PDF: IFPDF; X, Y, W, H: Double);
begin
  PDF.SetFillColor(cCorCinzaClaroR, cCorCinzaClaroG, cCorCinzaClaroB);
  PDF.Rect(X, Y, W, H, 'DF');
  PDF.SetFillColor(255, 255, 255);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharTituloBloco(PDF: IFPDF; X, Y, W: Double;
  const Titulo: string);
const
  cHTitulo = 3.5;   // ~1 linha de 7pt + folga
begin
  // NT 008, item 2.4.1: titulo de bloco 7 pt negrito CAIXA ALTA, fundo cinza 5% K
  DesenharRetanguloSombreado(PDF, X, Y, W, cHTitulo);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFTituloBloco, 'B');
  PDF.SetTextColor(0);
  PDF.TextBox(X, Y, W, cHTitulo, UpperCase(Titulo), 'C', 'C', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharCampo(PDF: IFPDF; X, Y, W, H: Double;
  const Labl, Valor: string; Sombreado: Boolean);
begin
  if Sombreado then
    DesenharRetanguloSombreado(PDF, X, Y, W, H)
  else
    DesenharRetangulo(PDF, X, Y, W, H);

  // Label - 6 pt negrito, alinhado ao topo
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelCampo, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, H, Labl, 'T', 'L', False, False, True);

  // Valor - 7 pt normal, alinhado abaixo do label
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  PDF.TextBox(X + 0.5, Y + 2.3, W - 1.0, H - 2.3,
              NN(Valor), 'T', 'L', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharLinhaVazia(PDF: IFPDF; X, Y, W: Double;
  const Mensagem: string);
const
  cHMin = 3.2;   // NT 008, Notas 2/3/4 - altura minima 0,32 cm
begin
  DesenharRetangulo(PDF, X, Y, W, cHMin);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFConteudo, 'B');
  PDF.TextBox(X, Y, W, cHMin, Mensagem, 'C', 'C', False, False, True);
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaPrestador: Double;
begin
  // NT 008: Prestador - 6 linhas de 6,3 mm + titulo 3,5 + folga
  Result := 3.5 + 6 * 6.3 + 1.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTomador: Double;
begin
  if not PossuiTomador then
    Result := 3.5 + 3.2 + 0.5
  else
    Result := 3.5 + 5 * 6.3 + 1.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaDestinatario: Double;
begin
  if not PossuiDestinatario then
    Result := 3.5 + 3.2 + 0.5
  else
    Result := 3.5 + 4 * 6.3 + 1.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaIntermediario: Double;
begin
  if not PossuiIntermediario then
    Result := 3.5 + 3.2 + 0.5
  else
    Result := 3.5 + 5 * 6.3 + 1.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaServicoPrestado: Double;
begin
  // Titulo + 4 linhas de cabeca (6,3 cada) + corpo da descricao (variavel,
  // minimo 14 mm).
  Result := 3.5 + 4 * 6.3 + 14.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTributacaoMunicipal: Double;
begin
  if not PossuiISSQN then
    Result := 3.5 + 3.2 + 0.5
  else
    Result := 3.5 + 6 * 6.3 + 1.0;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTributacaoIBSCBS: Double;
begin
  Result := 3.5 + 4 * 6.3 + 1.0;   // 4 linhas para o grid IBS/CBS
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaInformacoesComplementares: Double;
var
  PageSize: TFPDFPageSize;
  PDF: TFPDFExt;
  W, H: Double;
begin
  Result := 16.0;
  PageSize.w := FPage.PageWidth;
  PageSize.h := FPage.PageHeight;
  PDF := TFPDFExt.Create(FPage.Orientation, FPage.PageUnit, PageSize);
  try
    W := cnLargUtil - 2.0;
    PDF.SetFont(cFontConteudo, '', cnFConteudo);
    H := PDF.GetStringHeight(GetTextoInformacoesComplementares, W);
    if H + 6 > Result then
      Result := H + 6;
  finally
    PDF.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaCabecalho(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W: Double;
  Stream: TBytesStream;
  Municipio: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;

  // Borda externa do bloco - cinza claro
  DesenharRetanguloSombreado(PDF, X, Y, W, cnCabH);

  // Logomarca NFS-e (canto esquerdo) - usa LogoNFSeBytes como container
  // do PNG oficial da NFS-e (publicado em gov.br/nfse)
  if FLogoNFSe and (Length(FLogoNFSeBytes) > 0) then
  begin
    Stream := TBytesStream.Create(FLogoNFSeBytes);
    try
      PDF.Image(cnLogoX - cnMargem, cnLogoY - cnMargem,
                cnLogoW, cnLogoH, Stream, 'L', 'C');
    finally
      Stream.Free;
    end;
  end
  else
  begin
    // Placeholder textual da logomarca
    PDF.SetFont(cFontLabel);
    PDF.SetFont(11, 'B');
    PDF.TextBox(cnLogoX - cnMargem, cnLogoY - cnMargem + 2, cnLogoW, 5,
                'NFS-e', 'T', 'L', False, False, True);
  end;

  // Centro - DANFSe v2.0 + Documento Auxiliar da NFS-e
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFTituloDoc, 'B');
  PDF.SetTextColor(0);
  PDF.TextBox(cnTituloX - cnMargem, Y + 1.0, cnTituloW, 4.5,
              'DANFSe v2.0', 'T', 'C', False, False, True);
  PDF.TextBox(cnTituloX - cnMargem, Y + 5.0, cnTituloW, 4.5,
              'Documento Auxiliar da NFS-e', 'T', 'C', False, False, True);

  // NFS-e SEM VALIDADE JURIDICA - apenas em homologacao
  if FHomologacao then
  begin
    PDF.SetFont(cFontLabel);
    PDF.SetFont(cnFSemValidade, 'B');
    PDF.SetTextColor(cCorVermelhoR, cCorVermelhoG, cCorVermelhoB);
    PDF.TextBox(cnTituloX - cnMargem, Y + 8.0, cnTituloW, 3.5,
                cMsgSemValidade, 'T', 'C', False, False, True);
    PDF.SetTextColor(0);
  end;

  // Coluna direita - Municipio / Ambiente Gerador / Tipo de Ambiente
  Municipio := Trim(FCabecalhoLinha1);
  if Municipio = '' then
    Municipio := Trim(FNFSe.cLocEmi);

  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFMunicipio, '');
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 1.0, cnIdentMunW, 4.0,
              Ellipsis(Municipio, 37), 'T', 'C', False, False, True);

  PDF.SetFont(cnFAmbiente, '');
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 5.0, cnIdentMunW, 3.0,
              'Ambiente Gerador: ' + IfThen(FHomologacao, 'Homologacao', 'Producao'),
              'T', 'C', False, False, True);
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 8.0, cnIdentMunW, 3.0,
              'Tipo de Ambiente: ' + IfThen(FHomologacao, '2 - Homologacao', '1 - Producao'),
              'T', 'C', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaDadosNFSe(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW: Double;
  Chave: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;

  // ---- Chave de Acesso ----
  // NT 008, item 2.1.1 - bloco unico
  Chave := GetChaveAcesso;
  DesenharRetangulo(PDF, X, Y, W, 6.7);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelIdentNFSe, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, 3.0, 'CHAVE DE ACESSO DA NFS-e',
              'T', 'L', False, False, True);
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo + 1, 'B');
  PDF.TextBox(X, Y + 3.0, W, 3.5, Chave, 'T', 'C', False, False, True);

  Y := Y + 6.7;

  // ---- Linha 1: Numero / Competencia / Data emissao NFS-e ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'NUMERO DA NFS-e', NN(FNFSe.Numero));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'COMPETENCIA',
                IfThen(FNFSe.Competencia > 0, FormatDateTime('mm/yyyy', FNFSe.Competencia), '-'));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'DATA/HORA DA EMISSAO DA NFS-e',
                FormatDataHoraNT(FNFSe.DataEmissao));

  Y := Y + 6.7;

  // ---- Linha 2: Numero DPS / Serie DPS / Data emissao DPS ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'NUMERO DA DPS',
                NN(FNFSe.IdentificacaoRps.Numero));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'SERIE DA DPS',
                NN(FNFSe.IdentificacaoRps.Serie));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'DATA/HORA DA EMISSAO DA DPS',
                FormatDataHoraNT(FNFSe.DataEmissaoRps));

  Y := Y + 6.7;

  // ---- Linha 3: Emitente (sombreado) / Situacao / Finalidade ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'EMITENTE DA NFS-e',
                GetEmitenteDescricao, True);
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'SITUACAO DA NFS-e',
                GetSituacaoNFSeDescricao);
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'FINALIDADE',
                GetFinalidadeDescricao);

  // ---- QR Code (posicao absoluta em relacao a pagina) ----
  if FQRCode and (Trim(FNFSe.Link) <> '') then
  begin
    PDF.SetFillColor(0, 0, 0);
    PDF.QRCode(cnQRX - cnMargem, cnQRY - cnMargem, cnQRSize,
               cURLConsultaPublica + Chave);
    PDF.SetFillColor(255, 255, 255);

    // Texto complementar (3 linhas, 6 pt)
    PDF.SetFont(cFontConteudo);
    PDF.SetFont(cnFTextoQR, '');
    PDF.TextBox(cnQRComplX - cnMargem, cnQRComplY - cnMargem,
                cnQRComplW, cnQRComplH,
                cTextoQRComplemento, 'T', 'C', False, True, True);
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaPrestador(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  P: TDadosPrestador;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;


  P := FNFSe.Prestador;

  // Linha 1: CNPJ/CPF/NIF | IM | Telefone | (vazio reservado)
  DesenharTituloBloco(PDF, X + 0 * ColW, Y, ColW,  'Prestador / Fornecedor');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(P.IdentificacaoPrestador));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(P.IdentificacaoPrestador.InscricaoMunicipal));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(P.Contato));

  Y := Y + LineH;

  // Linha 2: Nome / Razao Social (largura cheia)
  DesenharCampo(PDF, X, Y, W, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(P.RazaoSocial), 167));
  // Linha 2: Municipio/UF | IBGE/CEP
  DesenharCampo(PDF, X + 0 * ColW, Y, 2 * ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(P.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(P.Endereco));

  Y := Y + LineH;
  // Linha 4: Endereco (largura cheia)
  DesenharCampo(PDF, X, Y, W, LineH, 'Endereco', FormatEnderecoCompleto(P.Endereco));

  // Linha 5: E-mail (supressivel - Nota 1)
  if Trim(P.Contato.Email) <> '' then
  begin
    DesenharCampo(PDF, X, Y, W, LineH, 'E-mail',
                  Ellipsis(LowerCase(P.Contato.Email), 77));
  end;
  Y := Y + LineH;



  // Linha 6: Simples Nacional / Regime de Apuracao SN
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Simples Nacional na Data de Competencia',
                IfThen(FNFSe.OptanteSimplesNacional = snSim, 'Optante', 'Nao Optante'));
  DesenharCampo(PDF, X + 1 * ColW, Y, 3 * ColW, LineH,
                'Regime de Apuracao Tributaria pelo SN',
                Ellipsis(GetEnumName(TypeInfo(TRegimeApuracaoSN),
                                     Ord(FNFSe.RegimeApuracaoSN)), 37));
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTomador(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  T: TDadosTomador;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  DesenharTituloBloco(PDF, X, Y, W, 'Tomador / Adquirente da Operacao');
  Y := Y + 3.5;

  if not PossuiTomador then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgTomadorVazio);
    Exit;
  end;

  T := FNFSe.Tomador;

  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(T.IdentificacaoTomador));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(T.IdentificacaoTomador.InscricaoMunicipal));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(T.Contato));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, '', '');

  Y := Y + LineH;
  DesenharCampo(PDF, X, Y, W, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(T.RazaoSocial), 167));

  Y := Y + LineH;
  DesenharCampo(PDF, X + 0 * ColW, Y, 2 * ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(T.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(T.Endereco));

  Y := Y + LineH;
  DesenharCampo(PDF, X, Y, W, LineH, 'Endereco', FormatEnderecoCompleto(T.Endereco));

  Y := Y + LineH;
  if Trim(T.Contato.Email) <> '' then
    DesenharCampo(PDF, X, Y, W, LineH, 'E-mail',
                  Ellipsis(LowerCase(T.Contato.Email), 77));
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaDestinatario(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;

  DesenharTituloBloco(PDF, X, Y, W, 'Destinatario da Operacao');
  Y := Y + 3.5;

  if DestinatarioEhTomador then
    DesenharLinhaVazia(PDF, X, Y, W, cMsgDestIgualTomador)
  else
    DesenharLinhaVazia(PDF, X, Y, W, cMsgDestVazio);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaIntermediario(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  I: TDadosIntermediario;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  DesenharTituloBloco(PDF, X, Y, W, 'Intermediario da Operacao');
  Y := Y + 3.5;

  if not PossuiIntermediario then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgIntermVazio);
    Exit;
  end;

  I := FNFSe.Intermediario;

  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(I.Identificacao));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(I.Identificacao.InscricaoMunicipal));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(I.Contato));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, '', '');

  Y := Y + LineH;
  DesenharCampo(PDF, X, Y, W, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(I.RazaoSocial), 167));

  Y := Y + LineH;
  DesenharCampo(PDF, X + 0 * ColW, Y, 2 * ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(I.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(I.Endereco));

  Y := Y + LineH;
  DesenharCampo(PDF, X, Y, W, LineH, 'Endereco', FormatEnderecoCompleto(I.Endereco));

  Y := Y + LineH;
  if Trim(I.Contato.Email) <> '' then
    DesenharCampo(PDF, X, Y, W, LineH, 'E-mail',
                  Ellipsis(LowerCase(I.Contato.Email), 77));
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaServicoPrestado(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  S: TDadosServico;
  PaisISO: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 2;
  LineH := 6.3;
  S := FNFSe.Servico;

  DesenharTituloBloco(PDF, X, Y, W, 'Servico Prestado');
  Y := Y + 3.5;

  // Linha 1: Codigo Tributacao Nacional / Municipal | NBS
  DesenharCampo(PDF, X, Y, ColW, LineH, 'Codigo de Tributacao Nacional / Municipal',
                NN(S.ItemListaServico) + ' / ' + NN(S.CodigoTributacaoMunicipio));
  DesenharCampo(PDF, X + ColW, Y, ColW, LineH, 'Codigo da NBS',
                NN(S.CodigoNbs));

  Y := Y + LineH;

  // Linha 2: Local da Prestacao / UF / Pais
  PaisISO := IfThen(Trim(S.MunicipioPrestacaoServico) <> '',
                    S.MunicipioPrestacaoServico + ' / ' + S.UFPrestacao + ' / BR',
                    '-');
  DesenharCampo(PDF, X, Y, W, LineH,
                'Local da Prestacao / Sigla UF / Pais', PaisISO);

  Y := Y + LineH;

  // Linha 3: Descricao do Codigo de Tributacao
  DesenharCampo(PDF, X, Y, W, LineH,
                'Descricao do Codigo de Tributacao Nacional / Municipal',
                Ellipsis(NN(S.xItemListaServico), 167));

  Y := Y + LineH;

  // Linha 4 ate o final: Descricao do Servico (texto livre, multi-linha)
  DesenharRetangulo(PDF, X, Y, W, Args.Band.Height - Y);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelCampo, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, 4.0,
              'Descricao do Servico', 'T', 'L', False, False, True);

  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  PDF.TextBox(X + 0.5, Y + 2.5, W - 1.0, Args.Band.Height - Y - 3.0,
              GetTextoDescricaoServico, 'T', 'L', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoMunicipal(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;
  V := FNFSe.Servico.Valores;

  DesenharTituloBloco(PDF, X, Y, W, 'Tributacao Municipal (ISSQN)');
  Y := Y + 3.5;

  if not PossuiISSQN then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgISSQNVazio);
    Exit;
  end;


  // Linha 1: Tipo Tributacao | Local Incidencia | Regime Especial
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Tipo de Tributacao do ISSQN', 'NN(SituacaoTributariaToStr(V.IssRetido))');
  DesenharCampo(PDF, X + 1 * ColW, Y, 2 * ColW, LineH,
                'Municipio / UF / Pais da Incidencia',
                FNFSe.infNFSe.xLocIncid + ' / BR');
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Regime Especial de Tributacao do ISSQN',
                Ellipsis(GetEnumName(TypeInfo(TnfseRegimeEspecialTributacao),
                                     Ord(FNFSe.RegimeEspecialTributacao)), 37));

  Y := Y + LineH;

  // Linha 2: Imunidade | Suspensao | nProcesso
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'Tipo de Imunidade do ISSQN', '-');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Suspensao da Exigibilidade', '-');
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'Numero do Processo de Suspensao', '-');

  Y := Y + LineH;

  // Linha 3: Beneficio Municipal | Calculo BM | Deducoes | Desconto Incond.
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'Beneficio Municipal', '-');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Calculo do BM',
                FormatVlr(0));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Total Deducoes / Reducoes',
                FormatVlr(V.ValorDeducoes));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Desconto Incondicionado',
                FormatVlr(V.DescontoIncondicionado));

  Y := Y + LineH;

  // Linha 4: BC | Aliquota | Retencao | ISSQN Apurado
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'BC ISSQN',
                FormatVlr(V.BaseCalculo));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Aliquota Aplicada',
                FormatPerc(V.Aliquota));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Retencao do ISSQN',
                IfThen(V.IssRetido = stRetencao, 'Retido', 'Nao Retido'));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'ISSQN Apurado',
                FormatVlr(V.ValorIss));
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoFederal(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 3;
  LineH := 6.3;
  V := FNFSe.Servico.Valores;

  DesenharTituloBloco(PDF, X, Y, W, 'Tributacao Federal (Exceto CBS)');
  Y := Y + 3.5;

  // Linha 1: IRRF | Contrib. Previdenciaria | Contrib. Sociais
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'IRRF', FormatVlr(V.ValorIr));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Contribuicao Previdenciaria Retida', FormatVlr(V.ValorInss));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Contribuicoes Sociais Retidas', FormatVlr(V.ValorCsll));

  Y := Y + LineH;

  // Linha 2: PIS | COFINS | Descricao Contrib. Sociais
  // NT 008 Nota 6: linha so para NFS-e com competencia ate fim de 2026
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'PIS - Debito de Apuracao Propria', FormatVlr(V.ValorPis));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'COFINS - Debito de Apuracao Propria', FormatVlr(V.ValorCofins));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Descricao das Contribuicoes Sociais Retidas', '-');
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoIBSCBS(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  DesenharTituloBloco(PDF, X, Y, W, 'Tributacao IBS / CBS');
  Y := Y + 3.5;

  // Linha 1: CST/cClassTrib | Indicador Op./IBGE/Mun./UF
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'CST / cClassTrib', '-');
  DesenharCampo(PDF, X + 1 * ColW, Y, 3 * ColW, LineH,
                'Indicador de Operacao / IBGE / Municipio / UF', '-');

  Y := Y + LineH;

  // Linha 2: Exclusoes | BC apos exclusoes | Red. Aliq. IBS | Red. Aliq. CBS
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Exclusoes e Reducoes da Base de Calculo', FormatVlr(0));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Base de Calculo apos Exclusoes e Reducoes', FormatVlr(0));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Reducao da Aliquota do IBS', FormatPerc(0));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Reducao da Aliquota da CBS', FormatPerc(0));

  Y := Y + LineH;

  // Linha 3: Aliq IBS UF | Aliq Efetiva UF | Valor Apurado UF | Total IBS
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Aliquota IBS UF / Mun', FormatPerc(0));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Aliquota Efetiva Municipal IBS', FormatPerc(0));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Valor Apurado IBS', FormatVlr(0));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Valor Total Apurado IBS', FormatVlr(0));

  Y := Y + LineH;

  // Linha 4: Aliq CBS | Aliq Efetiva CBS | Valor Apurado CBS
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Aliquota CBS', FormatPerc(0));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Aliquota Efetiva CBS', FormatPerc(0));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH,
                'Valor Total Apurado CBS', FormatVlr(0));
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaValorTotalNFSe(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
  vRetencoes, vTotalNFSe: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.7;
  V := FNFSe.Servico.Valores;

  DesenharTituloBloco(PDF, X, Y, W, 'Valor Total da NFS-e');
  Y := Y + 3.5;

  // Linha 1: V.Operacao | Desc.Incond | Desc.Cond | Total Retencoes
  vRetencoes := V.ValorIssRetido + V.ValorIr + V.ValorInss +
                V.ValorCsll + V.ValorPis + V.ValorCofins;

  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Valor da Operacao / Servico', FormatVlr(V.ValorServicos));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Desconto Incondicionado', FormatVlr(V.DescontoIncondicionado));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Desconto Condicionado', FormatVlr(V.DescontoCondicionado));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Total das Retencoes (ISSQN / Federais)', FormatVlr(vRetencoes));

  Y := Y + LineH;

  // Linha 2: V.Liquido NFS-e | Total IBS/CBS
  DesenharCampo(PDF, X + 0 * ColW, Y, 2 * ColW, LineH,
                'Valor Liquido da NFS-e', FormatVlr(V.ValorLiquidoNfse));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH,
                'Total do IBS / CBS', FormatVlr(0));

  Y := Y + LineH;

  // Linha 3: VALOR LIQUIDO NFS-e + IBS/CBS (destacado, sombreado)
  vTotalNFSe := V.ValorLiquidoNfse;  // + IBS/CBS quando disponivel
  DesenharRetanguloSombreado(PDF, X, Y, W, LineH);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelIdentNFSe, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, 3.0,
              'VALOR LIQUIDO DA NFS-e + IBS/CBS (R$)', 'T', 'L', False, False, True);
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo + 2, 'B');
  PDF.TextBox(X, Y + 1.8, W - 2.0, LineH - 1.8, FormatVlr(vTotalNFSe),
              'T', 'R', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaInformacoesComplementares(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, H: Double;
  Texto: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  H := Args.Band.Height;

  DesenharTituloBloco(PDF, X, Y, W, 'Informacoes Complementares');
  Y := Y + 3.5;

  DesenharRetangulo(PDF, X, Y, W, H - 3.5);

  Texto := GetTextoInformacoesComplementares;
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  PDF.TextBox(X + 0.8, Y + 0.6, W - 1.6, H - 4.5,
              Texto, 'T', 'L', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaCanhoto(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  LineH := 6.7;
  ColW := W * 0.25;

  DesenharTituloBloco(PDF, X, Y, W, 'Canhoto');
  Y := Y + 3.5;

  DesenharCampo(PDF, X, Y, ColW, LineH, 'Data Cientificacao', '');
  DesenharCampo(PDF, X + ColW, Y, 2 * ColW, LineH, 'Identificacao e Assinatura', '');
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'N. NFS-e / Chave NFS-e',
                NN(FNFSe.Numero) + sLineBreak + GetChaveAcesso);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaMarcaDagua(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  Texto, PrevColor: string;
begin
  // NT 008, item 2.5: marca d'agua diagonal, Arial >= 50 pt, cinza K35
  Texto := '';
  if FCancelada then
    Texto := cMsgCancelada
  else if FSubstituida then
    Texto := cMsgSubstituida;

  if Texto = '' then Exit;

  PDF := Args.PDF;
  PrevColor := Args.PDF.TextColor;
  try
    PDF.SetTextColor(cCorCinzaMDR, cCorCinzaMDG, cCorCinzaMDB);
    PDF.SetFont(cFontLabel);
    PDF.SetFont(cnFMarcaDagua, 'B');

    PDF.TextBox(cnMargem, cnPaginaAltura / 2 - 25,
                cnPaginaLargura - 2 * cnMargem, 50,
                Texto, 'C', 'C', False, False, True);
  finally
    Args.PDF.TextColor := PrevColor;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.OnStartReport(Args: TFPDFReportEventArgs);
begin
  if FInitialized then Exit;
  if FNFSe = nil then
    raise Exception.Create('TACBrDANFSeFPDFPadraoNacional: NFSe nao atribuida');

  FPage := AddPage(poPortrait, puMM, pfA4);

  // Ordem das bandas conforme NT 008, Anexo I
  AddBand(btPageHeader, cnCabH,                       BandaCabecalho);
  AddBand(btPageHeader, 26.8,                         BandaDadosNFSe);              // chave + 3 linhas (6,7 cada)
  AddBand(btPageHeader, CalcAlturaPrestador,          BandaPrestador);
  AddBand(btPageHeader, CalcAlturaTomador,            BandaTomador);
  AddBand(btPageHeader, CalcAlturaDestinatario,       BandaDestinatario);
  AddBand(btPageHeader, CalcAlturaIntermediario,      BandaIntermediario);

  // Descricao do servico ocupa o espaco livre entre header e footer
  AddBand(btData,       1,                            BandaServicoPrestado);

  AddBand(btPageFooter, CalcAlturaTributacaoMunicipal,BandaTributacaoMunicipal);
  AddBand(btPageFooter, 3.5 + 2 * 6.3 + 1.0,          BandaTributacaoFederal);
  AddBand(btPageFooter, CalcAlturaTributacaoIBSCBS,   BandaTributacaoIBSCBS);
  AddBand(btPageFooter, 3.5 + 3 * 6.7 + 0.5,          BandaValorTotalNFSe);
  AddBand(btPageFooter, CalcAlturaInformacoesComplementares,
                                                      BandaInformacoesComplementares);
  AddBand(btPageFooter, 3.5 + 6.7 + 0.5,              BandaCanhoto);

  AddBand(btOverlay, cnPaginaAltura,                  BandaMarcaDagua);

  FInitialized := True;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX; AStream: TStream);
var
  Engine: TFPDFEngine;
begin
  Engine := TFPDFEngine.Create(Self, False);
  try
    Engine.Compressed := True;
    Engine.SaveToStream(AStream);
  finally
    Engine.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
  const NomeArquivoDestinoPDF: string);
var
  Engine: TFPDFEngine;
begin
  Engine := TFPDFEngine.Create(Self, False);
  try
    Engine.Compressed := True;
    Engine.SaveToFile(NomeArquivoDestinoPDF);
  finally
    Engine.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(NFSe: TNFSe;
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
  const NomeArquivoDestinoPDF: string);
begin
  FNFSe := NFSe;
  SalvarPDF(DadosAuxDANFSe, NomeArquivoDestinoPDF);
end;

end.
