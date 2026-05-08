{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior, Renato Rubinho           }
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

unit ACBrLibDCeRespostas;

interface

uses
  Classes, SysUtils, Contnrs,
  ACBrLibConsReciDFe,
  ACBrDFeUtil,
  ACBrDFe.Conversao,
  ACBrLibResposta, ACBrLibConfig,
  ACBrDCe;

type
  { TLibDCeResposta }
  TLibDCeResposta = class(TACBrLibRespostaBase)
  private
    FMsg: string;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;
  published
    property Msg: string read FMsg write FMsg;
  end;

  { TLibDCeServiceResposta }
  TLibDCeServiceResposta = class abstract(TACBrLibResposta<TACBrDCe>)
  private
    FMsg: string;
    Fversao: string;
    FtpAmb: string;
    FverAplic: string;
    FcStat: integer;
    FxMotivo: string;
    FcUF: integer;
    FdhRecbto: TDateTime;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const ACBrDCe: TACBrDCe); virtual; abstract; reintroduce;
  published
    property Msg: string read FMsg write FMsg;
    property Versao: string read Fversao write Fversao;
    property tpAmb: string read FtpAmb write FtpAmb;
    property VerAplic: string read FverAplic write FverAplic;
    property CStat: integer read FcStat write FcStat;
    property XMotivo: string read FxMotivo write FxMotivo;
    property CUF: integer read FcUF write FcUF;
    property DhRecbto: TDateTime read FdhRecbto write FdhRecbto;
  end;

  { TStatusServicoResposta }
  TStatusServicoResposta = class(TLibDCeServiceResposta)
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const ACBrDCe: TACBrDCe); override;
  end;

  { TEnvioResposta }
  TEnvioResposta = class(TLibDCeServiceResposta)
  private
    FNProt: string;
    FItemRetorno: TRetornoItemResposta;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Processar(const ACBrDCe: TACBrDCe); override;
  published
    property NProt: String read FNProt write FNProt;
    property Retorno: TRetornoItemResposta read FItemRetorno;
  end;

  { TConsultaDCeResposta }
  TConsultaDCeResposta = class(TLibDCeServiceResposta)
  private
    FchDCe: String;
    FNProt: String;
    FDigVal: String;
    FcMsg: Integer;
    FxMsg: String;
    FEventos: TObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;

    procedure Processar(const ACBrDCe: TACBrDCe); override;

  published
    property chDCe: String read FchDCe write FchDCe;
    property NProt: String read FNProt write FNProt;
    property DigVal: String read FDigVal write FDigVal;
    property cMsg: Integer read FcMsg write FcMsg;
    property xMsg: String read FxMsg write FxMsg;
    property Eventos: TObjectList read FEventos;
  end;

  { TCancelamentoResposta }
  TCancelamentoResposta = class(TLibDCeServiceResposta)
  private
    FchDCe: String;
    FnProt: String;
    FtpEvento: String;
    FxEvento: String;
    FnSeqEvento: Integer;
    FCNPJDest: String;
    FemailDest: String;
    Fxml: String;
    FArquivo: String;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const ACBrDCe: TACBrDCe); override;
  published
    property chDCe: string read FchDCe write FchDCe;
    property nProt: string read FnProt write FnProt;
    property tpEvento: string read FtpEvento write FtpEvento;
    property xEvento: string read FxEvento write FxEvento;
    property nSeqEvento: integer read FnSeqEvento write FnSeqEvento;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property emailDest: string read FemailDest write FemailDest;
    property XML: string read Fxml write Fxml;
    property Arquivo: string read FArquivo write FArquivo;
  end;

implementation

uses
  ACBrLibDCeConsts,
  ACBrUtil.Base, ACBrUtil.FilesIO,
  ACBrUtil.Strings;

{ TLibDCeResposta }
constructor TLibDCeResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TLibDCeServiceResposta }
constructor TLibDCeServiceResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TStatusServicoResposta }
constructor TStatusServicoResposta.Create(const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespStatus, ATipo, AFormato);
end;

procedure TStatusServicoResposta.Processar(const ACBrDCe: TACBrDCe);
begin
  with ACBrDCe.WebServices do
  begin
    Msg := StatusServico.Msg;
    Versao := StatusServico.versao;
    TpAmb := TipoAmbienteToStr(StatusServico.TpAmb);
    VerAplic := StatusServico.VerAplic;
    CStat := StatusServico.CStat;
    XMotivo := StatusServico.XMotivo;
    CUF := StatusServico.CUF;
    DhRecbto := StatusServico.DhRecbto;
  end;
end;

{ TEnvioResposta }

constructor TEnvioResposta.Create(const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespEnvio, ATipo, AFormato);
end;

destructor TEnvioResposta.Destroy;
begin
  if Assigned(FItemRetorno) then FreeAndNil(FItemRetorno);
end;

procedure TEnvioResposta.Processar(const ACBrDCe: TACBrDCe);
var
  Numero: string;
begin
  if Assigned(FItemRetorno) then FreeAndNil(FItemRetorno);

  with ACBrDCe.WebServices do
  begin
    Versao := Enviar.versao;
    TpAmb := TipoAmbienteToStr(Enviar.TpAmb);
    verAplic := Enviar.verAplic;
    CStat := Enviar.cStat;
    XMotivo := Enviar.xMotivo;
    CUF := Enviar.cUF;
    DhRecbto := Enviar.dhRecbto;
    Msg := Enviar.Msg;
    NProt := Enviar.Protocolo;
  end;

  if ACBrDCe.Declaracoes.Count > 0 then
  begin
    Numero := IntToStr(ExtrairNumeroChaveAcesso(ACBrDCe.Declaracoes.Items[0].DCe.procDCe.chDFe));
    if Trim(Numero) = '' then Exit;
    if Trim(ACBrDCe.Declaracoes.Items[0].DCe.procDCe.nProt) = '' then Exit;

    FItemRetorno := TRetornoItemResposta.Create('DCe' + Numero, Tipo, Codificacao);
    FItemRetorno.Id := 'ID' + ACBrDCe.Declaracoes.Items[0].DCe.procDCe.nProt;
    FItemRetorno.tpAmb := TipoAmbienteToStr(ACBrDCe.Declaracoes.Items[0].DCe.procDCe.tpAmb);
    FItemRetorno.verAplic := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.verAplic;
    FItemRetorno.chDFe := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.chDFe;
    FItemRetorno.dhRecbto := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.dhRecbto;
    FItemRetorno.nProt := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.nProt;
    FItemRetorno.digVal := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.digVal;
    FItemRetorno.cStat := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.cStat;
    FItemRetorno.xMotivo := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.xMotivo;
    FItemRetorno.XML := ACBrDCe.Declaracoes.Items[0].DCe.procDCe.XML_prot;
    FItemRetorno.NomeArq := ACBrDCe.Declaracoes.Items[0].NomeArq;
  end;
end;

{ TConsultaDCeResposta }

constructor TConsultaDCeResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespConsulta, ATipo, AFormato);

  FEventos := TObjectList.Create;
end;

destructor TConsultaDCeResposta.Destroy;
begin
  FEventos.Clear;
  FEventos.Free;

  inherited Destroy;
end;

procedure TConsultaDCeResposta.Processar(const ACBrDCe: TACBrDCe);
begin
  with ACBrDCe.WebServices do
  begin
    Msg := Consulta.Msg;
    Versao := Consulta.versao;
    TpAmb := TipoAmbienteToStr(Consulta.TpAmb);
    VerAplic := Consulta.VerAplic;
    CStat := Consulta.CStat;
    XMotivo := Consulta.XMotivo;
    CUF := Consulta.CUF;
    DhRecbto := Consulta.DhRecbto;
    chDCe := Consulta.DCeChave;
    NProt := Consulta.Protocolo;
    DigVal := Consulta.protDCe.digVal;
    cMsg := Consulta.protDCe.cMsg;
    xMsg := Consulta.ProtDCe.xMsg;
  end;
end;

{ TCancelamentoResposta }

constructor TCancelamentoResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespCancelamento, ATipo, AFormato);
end;

procedure TCancelamentoResposta.Processar(const ACBrDCe: TACBrDCe);
begin
  if ACBrDCe.WebServices.EnvEvento.EventoRetorno.retInfEvento.Count > 0 then
  begin
    with ACBrDCe.WebServices.EnvEvento.EventoRetorno.retInfEvento.Items[0].RetInfEvento do
    begin
      Versao := verAplic;
      tpAmb := TACBrTipoAmbiente(tpAmb);
      VerAplic := verAplic;
      CStat := cStat;
      XMotivo := xMotivo;
      CUF := cOrgao;
      FchDCe := chDCe;
      FnProt := nProt;
      FtpEvento := TpEventoToStr(tpEvento);
      FxEvento := xEvento;
      FnSeqEvento := nSeqEvento;
      FCNPJDest := CNPJDest;
      FemailDest := emailDest;
      Fxml := XML;
      FArquivo := NomeArquivo;
    end;
  end;
end;

end.

