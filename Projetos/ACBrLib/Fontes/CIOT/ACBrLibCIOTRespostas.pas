{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrLibCIOTRespostas;

interface

uses
  Classes,
  SysUtils,
  ACBrBase,
  ACBrDFeUtil,
  ACBrDFe.Conversao,
  ACBrLibResposta,
  ACBrLibConfig,
  ACBrCIOT,
  ACBrCIOTConversao,
  pcnCIOT;

type
  { TLibCIOTResposta }
  TLibCIOTResposta = class(TACBrLibRespostaBase)
  private
    FMsg: string;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;
  published
    property Msg: string read FMsg write FMsg;
  end;

  { TLibCIOTServiceResposta }
  TLibCIOTServiceResposta = class abstract(TACBrLibResposta<TACBrCIOT>)
  private
    FtpAmb: string;
    FCodigo: integer;
    FMensagem: string;
    FdhRecbto: TDateTime;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const ACBrCIOT: TACBrCIOT); virtual; abstract; reintroduce;
  published
    property tpAmb: string read FtpAmb write FtpAmb;
    property Codigo: integer read FCodigo write FCodigo;
    property Mensagem: string read FMensagem write FMensagem;
    property DhRecbto: TDateTime read FdhRecbto write FdhRecbto;
  end;

  { TDocumentoViagemResposta }
  TDocumentoViagemResposta = class(TACBrLibRespostaBase)
  private
    FMensagem: string;
  public
    constructor Create(const Id: integer; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Processar(const AItem: TMensagemCollectionItem);
  published
    property Mensagem: string read FMensagem write FMensagem;
  end;

  { TDocumentoPagamentoResposta }
  TDocumentoPagamentoResposta = class(TACBrLibRespostaBase)
  private
    FMensagem: string;
  public
    constructor Create(const Id: integer; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Processar(const AItem: TMensagemCollectionItem);
  published
    property Mensagem: string read FMensagem write FMensagem;
  end;

  { TTipoCargaResposta }
  TTipoCargaResposta = class(TACBrLibRespostaBase)
  private
    FCodigo: Integer;
    FDescricao: string;
  public
    constructor Create(const Id: integer; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Processar(const AItem: TConsultaTipoCargaCollectionItem);
  published
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
  end;

  { TEnvioResposta }
  TEnvioResposta = class(TLibCIOTServiceResposta)
  private
    FToken: string;
    FNProt: string;
    FXmlEnvio: string;
    FXmlRetorno: string;
    FCodigoIdentificacaoOperacao: string;
    FDataRetificacao: TDateTime;
    FQuantidadeViagens: integer;
    FQuantidadePagamentos: integer;
    FIdPagamentoCliente: string;
    FValorLiquido: double;
    FValorQuebra: double;
    FValorDiferencaDeFrete: double;
    FDocumentoViagem: TACBrObjectList;
    FDocumentoPagamento: TACBrObjectList;
    FTipoCarga: TACBrObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Processar(const ACBrCIOT: TACBrCIOT); override;
  published
    property Token: String read FToken write FToken;
    property NProt: String read FNProt write FNProt;
    property XmlEnvio: String read FXmlEnvio write FXmlEnvio;
    property XmlRetorno: String read FXmlRetorno write FXmlRetorno;
    property CodigoIdentificacaoOperacao: string read FCodigoIdentificacaoOperacao write FCodigoIdentificacaoOperacao;
    property DataRetificacao: TDateTime read FDataRetificacao write FDataRetificacao;
    property QuantidadeViagens: integer read FQuantidadeViagens write FQuantidadeViagens;
    property QuantidadePagamentos: integer read FQuantidadePagamentos write FQuantidadePagamentos;
    property IdPagamentoCliente: string read FIdPagamentoCliente write FIdPagamentoCliente;
    property ValorLiquido: double read FValorLiquido write FValorLiquido;
    property ValorQuebra: double read FValorQuebra write FValorQuebra;
    property ValorDiferencaDeFrete: double read FValorDiferencaDeFrete write FValorDiferencaDeFrete;
    property DocumentoViagem: TACBrObjectList read FDocumentoViagem;
    property DocumentoPagamento: TACBrObjectList read FDocumentoPagamento;
    property TipoCarga: TACBrObjectList read FTipoCarga;
  end;

implementation

uses
  ACBrLibCIOTConsts,
  ACBrUtil.Base, ACBrUtil.FilesIO,
  ACBrUtil.Strings;

{ TLibCIOTResposta }
constructor TLibCIOTResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TLibCIOTServiceResposta }
constructor TLibCIOTServiceResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TDocumentoViagemResposta }
constructor TDocumentoViagemResposta.Create(const Id: integer; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespDocumentoViagem + IntToStrZero(Id, 3), ATipo, AFormato);

  Clear;
end;

destructor TDocumentoViagemResposta.Destroy;
begin
  inherited Destroy;
end;

procedure TDocumentoViagemResposta.Clear;
begin
  Self.Mensagem := EmptyStr;
end;

procedure TDocumentoViagemResposta.Processar(const AItem: TMensagemCollectionItem);
begin
  Self.Mensagem := AItem.Mensagem;
end;

{ TDocumentoPagamentoResposta }
constructor TDocumentoPagamentoResposta.Create(const Id: integer;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespDocumentoPagamento + IntToStrZero(Id, 3), ATipo, AFormato);

  Clear;
end;

destructor TDocumentoPagamentoResposta.Destroy;
begin
  inherited Destroy;
end;

procedure TDocumentoPagamentoResposta.Clear;
begin
  Self.Mensagem := EmptyStr;
end;

procedure TDocumentoPagamentoResposta.Processar(const AItem: TMensagemCollectionItem);
begin
  Self.Mensagem := AItem.Mensagem;
end;

{ TTipoCargaResposta }
constructor TTipoCargaResposta.Create(const Id: integer;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespTipoCarga + IntToStrZero(Id, 3), ATipo, AFormato);

  Clear;
end;

destructor TTipoCargaResposta.Destroy;
begin
  inherited Destroy;
end;

procedure TTipoCargaResposta.Clear;
begin
  Self.Codigo := 0;
  Self.Descricao := EmptyStr;
end;

procedure TTipoCargaResposta.Processar(const AItem: TConsultaTipoCargaCollectionItem);
begin
  Self.Codigo := AItem.Codigo;

  if Integer(AItem.Descricao) <= Integer(High(tpTipoCargaDescArrayStrings)) then
    Self.Descricao := ACBrStr(tpTipoCargaDescArrayStrings[AItem.Descricao]);
end;

{ TEnvioResposta }
constructor TEnvioResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespEnvio, ATipo, AFormato);

  FDocumentoViagem := TACBrObjectList.Create;
  FDocumentoPagamento := TACBrObjectList.Create;
  FTipoCarga := TACBrObjectList.Create;
end;

destructor TEnvioResposta.Destroy;
begin
  FDocumentoViagem.Free;
  FDocumentoPagamento.Free;
  FTipoCarga.Free;
end;

procedure TEnvioResposta.Processar(const ACBrCIOT: TACBrCIOT);
var
  I: Integer;
  LRetEnvio: TRetEnvio;
  LDocumentoViagem: TDocumentoViagemResposta;
  LDocumentoPagamento: TDocumentoPagamentoResposta;
  LTipoCarga: TTipoCargaResposta;
begin
  LRetEnvio := ACBrCIOT.WebServices.CIOTEnviar.RetornoEnvio.RetEnvio;

  Self.TpAmb := TipoAmbienteToStr(ACBrCIOT.Configuracoes.WebServices.Ambiente);
  Self.NProt := LRetEnvio.ProtocoloServico;
  Self.Codigo := StrToIntDef(LRetEnvio.Codigo, 0);
  Self.Mensagem := LRetEnvio.Mensagem;
  Self.DhRecbto := LRetEnvio.Data;

  Self.Token := LRetEnvio.Token;

  Self.XmlEnvio := ACBrCIOT.WebServices.CIOTEnviar.DadosMsg;
  Self.XmlRetorno := ACBrCIOT.WebServices.CIOTEnviar.RetWS;

  Self.CodigoIdentificacaoOperacao := LRetEnvio.CodigoIdentificacaoOperacao;
  Self.DataRetificacao := LRetEnvio.DataRetificacao;
  Self.QuantidadeViagens := LRetEnvio.QuantidadeViagens;
  Self.QuantidadePagamentos := LRetEnvio.QuantidadePagamentos;
  Self.IdPagamentoCliente := LRetEnvio.IdPagamentoCliente;
  Self.ValorLiquido := LRetEnvio.ValorLiquido;
  Self.ValorQuebra := LRetEnvio.ValorQuebra;
  Self.ValorDiferencaDeFrete := LRetEnvio.ValorDiferencaDeFrete;

  for I := 0 to LRetEnvio.DocumentoViagem.Count - 1 do
  begin
    LDocumentoViagem := TDocumentoViagemResposta.Create(I + 1, Tipo, Codificacao);
    LDocumentoViagem.Processar(LRetEnvio.DocumentoViagem.Items[i]);
    FDocumentoViagem.Add(LDocumentoViagem);
  end;

  for I := 0 to LRetEnvio.DocumentoPagamento.Count - 1 do
  begin
    LDocumentoPagamento := TDocumentoPagamentoResposta.Create(I + 1, Tipo, Codificacao);
    LDocumentoPagamento.Processar(LRetEnvio.DocumentoPagamento.Items[i]);
    FDocumentoPagamento.Add(LDocumentoPagamento);
  end;

  for I := 0 to LRetEnvio.TipoCarga.Count - 1 do
  begin
    LTipoCarga := TTipoCargaResposta.Create(I + 1, Tipo, Codificacao);
    LTipoCarga.Processar(LRetEnvio.TipoCarga.Items[i]);
    FTipoCarga.Add(LTipoCarga);
  end;
end;

end.

