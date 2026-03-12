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

unit ACBrNFSeX.GravarIni;

interface

uses
  SysUtils, Classes, StrUtils, IniFiles,
  ACBrDFe.Conversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXInterface,
  ACBrNFSeXClass,
  ACBrNFSeXConversao;

type
  { TNFSeIniWriter }

  TNFSeIniWriter = class(TNFSeWClass)
  private
    FNFSe: TNFSe;

  protected
    FpAOwner: IACBrNFSeXProvider;
    LSecao: string;
    FpGerarSecaoOpcional: Boolean;
    FpDocumentar: Boolean;

    procedure PularLinha(const AINIRec: TMemIniFile; const Secao: string);
    procedure SecaoOpcional(const AINIRec: TMemIniFile; const Secao: string;
      const Complemento: string);
    procedure FaixadeValores(const AINIRec: TMemIniFile; const Secao: string;
      const Valores: string; Indice: Integer);
    procedure IndicesdeLista(const AINIRec: TMemIniFile; const Secao: string;
      IndiceMax: Integer);
    function ComentarCamposDocumentacao(const ArquivoIni: string): string;

    //====== Gerar o Arquivo INI=========================================
    procedure GerarINIIdentificacaoNFSe(const AINIRec: TMemIniFile);
    procedure GerarINIIdentificacaoRps(AINIRec: TMemIniFile);
    procedure GerarININFSeSubstituicao(AINIRec: TMemIniFile);
    procedure GerarINIRpsSubstituido(AINIRec: TMemIniFile);
    procedure GerarININFSeCancelamento(AINIRec: TMemIniFile);

    procedure GerarINIDadosPrestador(AINIRec: TMemIniFile);
    procedure GerarINIDadosTomador(AINIRec: TMemIniFile);
    procedure GerarINIDadosIntermediario(AINIRec: TMemIniFile);
    procedure GerarINIDadosServico(AINIRec: TMemIniFile);
    procedure GerarINIComercioExterior(AINIRec: TMemIniFile);
    procedure GerarINILocacaoSubLocacao(AINIRec: TMemIniFile);
    procedure GerarINIConstrucaoCivil(AINIRec: TMemIniFile);
    procedure GerarINIEvento(AINIRec: TMemIniFile);
    procedure GerarINIRodoviaria(AINIRec: TMemIniFile);
    procedure GerarINIInformacoesComplementares(AINIRec: TMemIniFile);
    procedure GerarINIInformacoesComplementaresgItemPed(AINIRec: TMemIniFile);
    procedure GerarINIValores(AINIRec: TMemIniFile);
    procedure GerarINIDocumentosDeducoes(AINIRec: TMemIniFile);
    procedure GerarINIDocumentosDeducoesFornecedor(AINIRec: TMemIniFile;
      fornec: TInfoPessoa; Indice: Integer);
    procedure GerarINIValoresTribMun(AINIRec: TMemIniFile);
    procedure GerarINIValoresTribFederal(AINIRec: TMemIniFile);
    procedure GerarINIValoresTotalTrib(AINIRec: TMemIniFile);
    procedure GerarINIQuartos(AINIRec: TMemIniFile);
    procedure GerarINIDespesas(AINIRec: TMemIniFile);
    procedure GerarINIGenericos(AINIRec: TMemIniFile);
    procedure GerarINIItens(AINIRec: TMemIniFile);
    procedure GerarINIDadosDeducao(AINIRec: TMemIniFile);
    procedure GerarINIImpostos(AINIRec: TMemIniFile);
    procedure GerarINIOrgaoGerador(AINIRec: TMemIniFile);
    procedure GerarINICondicaoPagamento(AINIRec: TMemIniFile);
    procedure GerarINIParcelas(AINIRec: TMemIniFile);
    procedure GerarINIEmail(AINIRec: TMemIniFile);
    procedure GerarINITransportadora(AINIRec: TMemIniFile);

    // NFS-e
    procedure GerarINIDadosEmitente(const AINIRec: TMemIniFile);
    procedure GerarINIValoresNFSe(const AINIRec: TMemIniFile);

    // Reforma Tributária DPS
    procedure GerarINIIBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBSDPS); virtual;
    procedure GerarINIgRefNFSe(AINIRec: TMemIniFile; gRefNFSe: TgRefNFSeCollection);
    procedure GerarINIDestinatario(AINIRec: TMemIniFile; Dest: TDadosdaPessoa);
    procedure GerarINIImovel(AINIRec: TMemIniFile; Imovel: TDadosimovel);
    procedure GerarINIIBSCBSValores(AINIRec: TMemIniFile; Valores: Tvalorestrib); virtual;
    procedure GerarINIDocumentos(AINIRec: TMemIniFile; Documentos: TdocumentosCollection);
    procedure GerarINITributacao(AINIRec: TMemIniFile; Tributacao: Ttrib);
    procedure GerarINIgIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS);
    procedure GerarINIgTribRegular(AINIRec: TMemIniFile; gTribRegular: TgTribRegular);
    procedure GerarINIgDif(AINIRec: TMemIniFile; gDif: TgDif);
    // Reforma Tributária NFSe
    procedure GerarINIIBSCBSNFSe(AINIRec: TMemIniFile; IBSCBS: TIBSCBSNfse);
    procedure GerarINIIBSCBSValoresNFSe(AINIRec: TMemIniFile; Valores: TvaloresIBSCBS);
    procedure GerarINITotCIBS(AINIRec: TMemIniFile; TotCIBS: TTotCIBS);
    procedure GerarINIgTribRegularNFSe(AINIRec: TMemIniFile; gTribRegularNFSe: TgTribRegularNFSe);
    procedure GerarINIgTribCompraGov(AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov);
    procedure GerarINITotgIBS(AINIRec: TMemIniFile; TotgIBS: TgIBS);
    procedure GerarINITotgCBS(AINIRec: TMemIniFile; TotgCBS: TgCBS);

    procedure GerarIniRps(AINIRec: TMemIniFile);
    procedure GerarIniNfse(AINIRec: TMemIniFile);
 public
    constructor Create(AOwner: TNFSe; AIOwner: IACBrNFSeXProvider); virtual;
    destructor Destroy; override;

    function GerarArquivoIni(AGerarTodasSecoes: Boolean = False;
      Documentar: Boolean = False): string; virtual;

    property NFSe: TNFSe read FNFSe write FNFSe;
  end;

implementation

uses
  synautil, types,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings;

{ TNFSeIniWriter }

procedure TNFSeIniWriter.PularLinha(const AINIRec: TMemIniFile;
  const Secao: string);
begin
  AINIRec.WriteString(Secao, 'ACBrPularLinha', 'PL');
end;

procedure TNFSeIniWriter.SecaoOpcional(const AINIRec: TMemIniFile; const Secao,
  Complemento: string);
begin
  if FpDocumentar then
    AINIRec.WriteString(Secao, 'ACBrDoc', 'Seção Opcional que contem dados ' + Complemento);
end;

procedure TNFSeIniWriter.FaixadeValores(const AINIRec: TMemIniFile; const Secao,
  Valores: string; Indice: Integer);
begin
  if FpDocumentar then
    AINIRec.WriteString(Secao, 'ACBrDoc' + IntToStr(Indice), Valores);
end;

procedure TNFSeIniWriter.IndicesdeLista(const AINIRec: TMemIniFile;
  const Secao: string; IndiceMax: Integer);
var
  QtdeDigitos: Integer;
begin
  QtdeDigitos := Length(IntToStr(IndiceMax));

  if FpDocumentar then
    AINIRec.WriteString(Secao + IntToStrZero(1, QtdeDigitos), 'ACBrDoc',
      'O Indice varia de ' + IntToStrZero(1, QtdeDigitos) + ' até ' +
      IntToStrZero(IndiceMax, QtdeDigitos) + ', deve ser informado com ' +
      IntToStr(QtdeDigitos) + ' digito(s).');
end;

function TNFSeIniWriter.ComentarCamposDocumentacao(
  const ArquivoIni: string): string;
var
  i: Integer;
begin
  Result := StringReplace(ArquivoIni, 'ACBrDoc=', '; ', [rfReplaceAll]);

  for i := 10 downto 1 do
    Result := StringReplace(Result, 'ACBrDoc' + IntToStr(i) + '=', '; ', [rfReplaceAll]);

  Result := StringReplace(Result, 'ACBrPularLinha=PL', '', [rfReplaceAll]);
end;

constructor TNFSeIniWriter.Create(AOwner: TNFSe; AIOwner: IACBrNFSeXProvider);
begin
  FpAOwner := AIOwner;
  FNFSe := AOwner;
end;

destructor TNFSeIniWriter.Destroy;
begin

  inherited Destroy;
end;

function TNFSeIniWriter.GerarArquivoIni(AGerarTodasSecoes: Boolean = False;
  Documentar: Boolean = False): string;
var
  INIRec: TMemIniFile;
  IniNFSe: TStringList;
begin
  Result:= '';
  FpGerarSecaoOpcional := AGerarTodasSecoes;
  FpDocumentar := Documentar;
// Usar FpAOwner no lugar de FProvider

  INIRec := TMemIniFile.Create('');
  try
    if NFSe.tpXML = txmlRPS then
      GerarIniRps(INIRec)
    else
      GerarIniNfse(INIRec);
  finally
    IniNFSe := TStringList.Create;
    try
      INIRec.GetStrings(IniNFSe);
      INIRec.Free;

      Result := StringReplace(IniNFSe.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);

      Result := ComentarCamposDocumentacao(Result);
    finally
      IniNFSe.Free;
    end;
  end;
end;

procedure TNFSeIniWriter.GerarIniRps(AINIRec: TMemIniFile);
begin
  GerarINIIdentificacaoNFSe(AINIRec);

  GerarINIIdentificacaoRps(AINIRec);
  GerarININFSeSubstituicao(AINIRec);
  GerarINIRpsSubstituido(AINIRec);

  GerarINIDadosPrestador(AINIRec);
  GerarINIDadosTomador(AINIRec);
  GerarINIDadosIntermediario(AINIRec);

  GerarINIComercioExterior(AINIRec);
  GerarINIConstrucaoCivil(AINIRec);
  GerarINIEvento(AINIRec);
  GerarINIInformacoesComplementares(AINIRec);
  GerarINIInformacoesComplementaresgItemPed(AINIRec);

  GerarINIDocumentosDeducoes(AINIRec);
  GerarINIValoresTribMun(AINIRec);
  GerarINIValoresTribFederal(AINIRec);
  GerarINIValoresTotalTrib(AINIRec);

  GerarINIItens(AINIRec);

  GerarINIDadosDeducao(AINIRec);
  GerarINILocacaoSubLocacao(AINIRec);
  GerarINIRodoviaria(AINIRec);
  GerarINIQuartos(AINIRec);
  GerarINIDespesas(AINIRec);
  GerarINIGenericos(AINIRec);
  GerarINIImpostos(AINIRec);
  GerarINIEmail(AINIRec);
  GerarINITransportadora(AINIRec);
  GerarINICondicaoPagamento(AINIRec);
  GerarINIParcelas(AINIRec);

  GerarINIDadosServico(AINIRec);
  GerarINIValores(AINIRec);

  // Reforma Tributária
  if (NFSe.IBSCBS.dest.xNome <> '') or (NFSe.IBSCBS.imovel.cCIB <> '') or
     (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum) then
    GerarINIIBSCBS(AINIRec, NFSe.IBSCBS);
end;

procedure TNFSeIniWriter.GerarIniNfse(AINIRec: TMemIniFile);
begin
  GerarINIIdentificacaoNFSe(AINIRec);
  GerarINIDadosEmitente(AINIRec);
  GerarINIValoresNFSe(AINIRec);
  GerarININFSeCancelamento(AINIRec);

  GerarINIIdentificacaoRps(AINIRec);
  GerarININFSeSubstituicao(AINIRec);
  GerarINIRpsSubstituido(AINIRec);

  GerarINIDadosPrestador(AINIRec);
  GerarINIDadosTomador(AINIRec);
  GerarINIDadosIntermediario(AINIRec);

  GerarINIComercioExterior(AINIRec);
  GerarINIConstrucaoCivil(AINIRec);
  GerarINIEvento(AINIRec);
  GerarINIInformacoesComplementares(AINIRec);
  GerarINIInformacoesComplementaresgItemPed(AINIRec);

  GerarINIDocumentosDeducoes(AINIRec);
  GerarINIValoresTribMun(AINIRec);
  GerarINIValoresTribFederal(AINIRec);
  GerarINIValoresTotalTrib(AINIRec);

  GerarINIItens(AINIRec);

  GerarINIDadosDeducao(AINIRec);
  GerarINILocacaoSubLocacao(AINIRec);
  GerarINIRodoviaria(AINIRec);
  GerarINIQuartos(AINIRec);
  GerarINIDespesas(AINIRec);
  GerarINIGenericos(AINIRec);
  GerarINIImpostos(AINIRec);
  GerarINIEmail(AINIRec);
  GerarINITransportadora(AINIRec);
  GerarINICondicaoPagamento(AINIRec);
  GerarINIParcelas(AINIRec);

  GerarINIDadosServico(AINIRec);
  GerarINIValores(AINIRec);

  GerarINIOrgaoGerador(AINIRec);

  // Reforma Tributária
  if (NFSe.IBSCBS.dest.xNome <> '') or (NFSe.IBSCBS.imovel.cCIB <> '') or
     (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum) then
  begin
    GerarINIIBSCBS(AINIRec, NFSe.IBSCBS);
    GerarINIIBSCBSNFSe(AINIRec, NFSe.infNFSe.IBSCBS);
  end;
end;

procedure TNFSeIniWriter.GerarINIIdentificacaoNFSe(
  const AINIRec: TMemIniFile);
begin
  LSecao:= 'IdentificacaoNFSe';

  if NFSe.tpXML = txmlRPS then
    AINIRec.WriteString(LSecao, 'TipoXML', 'RPS')
  else
  begin
    AINIRec.WriteString(LSecao, 'TipoXML', 'NFSE');

    AINIRec.WriteString(LSecao, 'Numero', NFSe.Numero);
    AINIRec.WriteString(LSecao, 'NumeroLote', NFSe.NumeroLote);
    AINIRec.WriteString(LSecao, 'StatusNFSe', StatusNFSeToStr(NFSe.SituacaoNfse));

    if NFSe.CodigoVerificacao <> '' then
      AINIRec.WriteString(LSecao, 'CodigoVerificacao', NFSe.CodigoVerificacao);

    AINIRec.WriteString(LSecao, 'Id', NFSe.infNFSe.ID);
    AINIRec.WriteString(LSecao, 'xLocEmi', NFSe.infNFSe.xLocEmi);
    AINIRec.WriteString(LSecao, 'xLocPrestacao', NFSe.infNFSe.xLocPrestacao);
    AINIRec.WriteString(LSecao, 'nNFSe', NFSe.infNFSe.nNFSe);
    AINIRec.WriteInteger(LSecao, 'cLocIncid', NFSe.infNFSe.cLocIncid);
    AINIRec.WriteString(LSecao, 'xLocIncid', NFSe.infNFSe.xLocIncid);
    AINIRec.WriteString(LSecao, 'xTribNac', NFSe.infNFSe.xTribNac);
    AINIRec.WriteString(LSecao, 'xTribMun', NFSe.infNFSe.xTribMun);
    AINIRec.WriteString(LSecao, 'xNBS', NFSe.infNFSe.xNBS);
    AINIRec.WriteString(LSecao, 'verAplic', NFSe.infNFSe.verAplic);
    AINIRec.WriteString(LSecao, 'ambGer', ambGerToStr(NFSe.infNFSe.ambGer));
    AINIRec.WriteString(LSecao, 'tpEmis', tpEmisToStr(NFSe.infNFSe.tpEmis));
    AINIRec.WriteString(LSecao, 'procEmi', procEmisToStr(NFSe.infNFSe.procEmi));
    AINIRec.WriteInteger(LSecao, 'cStat', NFSe.infNFSe.cStat);
    AINIRec.WriteDateTime(LSecao, 'dhProc', NFSe.infNFSe.dhProc);
    AINIRec.WriteString(LSecao, 'nDFSe', NFSe.infNFSe.nDFSe);

    if NFSe.NfseSubstituida <> '' then
      AINIRec.WriteString(LSecao, 'NfseSubstituida', NFSe.NfseSubstituida);

    if NFSe.NfseSubstituidora <> '' then
      AINIRec.WriteString(LSecao, 'NfseSubstituidora', NFSe.NfseSubstituidora);

    AINIRec.WriteFloat(LSecao, 'ValorCredito', NFSe.ValorCredito);
    AINIRec.WriteString(LSecao, 'ChaveAcesso', NFSe.ChaveAcesso);
    AINIRec.WriteString(LSecao, 'Link', NFSe.Link);
    AINIRec.WriteString(LSecao, 'DescricaoCodigoTributacaoMunicipio', NFSe.DescricaoCodigoTributacaoMunicipio);
    AINIRec.WriteString(LSecao, 'refNF', NFSe.refNF);
    AINIRec.WriteString(LSecao, 'TipoEmissao', TipoEmissaoToStr(NFSe.TipoEmissao));
    AINIRec.WriteString(LSecao, 'EmpreitadaGlobal', EmpreitadaGlobalToStr(NFSe.EmpreitadaGlobal));
    AINIRec.WriteString(LSecao, 'ModeloNFSe', NFSe.ModeloNFSe);
    AINIRec.WriteString(LSecao, 'Canhoto', CanhotoToStr(NFSe.Canhoto));

    if Trim(NFSe.Assinatura) <> '' then
      AINIRec.WriteString(LSecao, 'Assinatura', NFSe.Assinatura);

    AINIRec.WriteString(LSecao, 'Transacao', FpAOwner.SimNaoToStr(NFSe.Transacao));
  end;

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIIdentificacaoRps(AINIRec: TMemIniFile);
begin
  LSecao := 'IdentificacaoRps';

  AINIRec.WriteString(LSecao, 'Numero', NFSe.IdentificacaoRps.Numero);
  AINIRec.WriteString(LSecao, 'Serie', NFSe.IdentificacaoRps.Serie);
  AINIRec.WriteDateTime(LSecao, 'DataEmissaoRPS', NFSe.DataEmissaoRps);
  AINIRec.WriteDateTime(LSecao, 'Competencia', NFSe.Competencia);
  AINIRec.WriteString(LSecao, 'verAplic', NFSe.verAplic);
  AINIRec.WriteString(LSecao, 'tpEmit', tpEmitToStr(NFSe.tpEmit));
  AINIRec.WriteString(LSecao, 'cMotivoEmisTI', cMotivoEmisTIToStr(NFSe.cMotivoEmisTI));
  AINIRec.WriteString(LSecao, 'cLocEmi', NFSe.cLocEmi);

  AINIRec.WriteString(LSecao, 'SituacaoTrib', FpAOwner.SituacaoTribToStr(NFSe.SituacaoTrib));
  AINIRec.WriteString(LSecao, 'Producao', FpAOwner.SimNaoToStr(NFSe.Producao));
  AINIRec.WriteString(LSecao, 'Status', FpAOwner.StatusRPSToStr(NFSe.StatusRps));
  AINIRec.WriteString(LSecao, 'OutrasInformacoes', StringReplace(NFSe.OutrasInformacoes, sLineBreak, FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]));

  //Provedores CTA, ISSBarueri, ISSSDSF, ISSSaoPaulo, Simple e SmarAPD.
  AINIRec.WriteString(LSecao, 'TipoTributacaoRps', FpAOwner.TipoTributacaoRPSToStr(NFSe.TipoTributacaoRPS));

  AINIRec.WriteString(LSecao, 'TipoRecolhimento', NFSe.TipoRecolhimento);

  // Provedores ISSDSF e Siat
  AINIRec.WriteString(LSecao, 'SeriePrestacao', NFSe.SeriePrestacao);
  AINIRec.WriteString(LSecao, 'IdentificacaoRemessa', NFSe.IdentificacaoRemessa);
  AINIRec.WriteString(LSecao, 'Tipo', FpAOwner.TipoRPSToStr(NFSe.IdentificacaoRps.Tipo));

  if NFSe.Vencimento > 0 then
    AINIRec.WriteDate(LSecao, 'Vencimento', NFSe.Vencimento)
  else
    AINIRec.WriteDate(LSecao, 'Vencimento', Now);

  if NFSe.DataPagamento > 0 then
    AINIRec.WriteDate(LSecao, 'DataPagamento', NFSe.DataPagamento)
  else
    AINIRec.WriteDate(LSecao, 'DataPagamento', Now);

  if NFSe.dhRecebimento > 0 then
    AINIRec.WriteDateTime(LSecao, 'dhRecebimento', NFSe.dhRecebimento)
  else
    AINIRec.WriteDateTime(LSecao, 'dhRecebimento', Now);

  AINIRec.WriteString(LSecao, 'NaturezaOperacao', NaturezaOperacaoToStr(NFSe.NaturezaOperacao));

  // Provedor Tecnos
  AINIRec.WriteFloat(LSecao, 'PercentualCargaTributaria', NFSe.PercentualCargaTributaria);
  AINIRec.WriteFloat(LSecao, 'ValorCargaTributaria', NFSe.ValorCargaTributaria);
  AINIRec.WriteFloat(LSecao, 'PercentualCargaTributariaMunicipal', NFSe.PercentualCargaTributariaMunicipal);
  AINIRec.WriteFloat(LSecao, 'ValorCargaTributariaMunicipal', NFSe.ValorCargaTributariaMunicipal);
  AINIRec.WriteFloat(LSecao, 'PercentualCargaTributariaEstadual', NFSe.PercentualCargaTributariaEstadual);
  AINIRec.WriteFloat(LSecao, 'ValorCargaTributariaEstadual', NFSe.ValorCargaTributariaEstadual);

  //Provedor Governa
  AINIRec.WriteString(LSecao, 'RegRec', RegRecToStr(NFSe.RegRec));
  AINIRec.WriteString(LSecao, 'FrmRec', FrmRecToStr(NFSe.FrmRec));

  AINIRec.WriteString(LSecao, 'InformacoesComplementares', NFSe.InformacoesComplementares);
  AINIRec.WriteInteger(LSecao, 'Situacao', NFSe.Situacao);
  AINIRec.WriteString(LSecao, 'EqptoRecibo', NFSe.EqptoRecibo);
  AINIRec.WriteInteger(LSecao, 'TipoNota', NFSe.TipoNota);
  //Tecnos
  AINIRec.WriteString(LSecao, 'SiglaUF', NFSe.SiglaUF);
  AINIRec.WriteInteger(LSecao, 'EspecieDocumento', NFSe.EspecieDocumento);
  AINIRec.WriteInteger(LSecao, 'SerieTalonario', NFSe.SerieTalonario);
  AINIRec.WriteInteger(LSecao, 'FormaPagamento', NFSe.FormaPagamento);
  AINIRec.WriteInteger(LSecao, 'NumeroParcelas', NFSe.NumeroParcelas);
  AINIRec.WriteInteger(LSecao, 'id_sis_legado', NFSe.id_sis_legado);
  AINIRec.WriteString(LSecao, 'DeducaoMateriais', FpAOwner.SimNaoToStr(NFSe.DeducaoMateriais));

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarININFSeSubstituicao(AINIRec: TMemIniFile);
begin
  LSecao := 'NFSeSubstituicao';

  SecaoOpcional(AINIRec, LSecao, 'da NFSe Substituição.');

  if (Trim(NFSe.subst.chSubstda) <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'chSubstda', NFSe.subst.chSubstda);
    AINIRec.WriteString(LSecao, 'cMotivo', cMotivoToStr(NFSe.subst.cMotivo));
    AINIRec.WriteString(LSecao, 'xMotivo', NFSe.subst.xMotivo);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIRpsSubstituido(AINIRec: TMemIniFile);
begin
  LSecao:= 'RpsSubstituido';

  SecaoOpcional(AINIRec, LSecao, 'do RPS/DPS Substituido.');

  if (NFSe.RpsSubstituido.Numero <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'Numero', NFSe.RpsSubstituido.Numero);
    AINIRec.WriteString(LSecao, 'Serie', NFSe.RpsSubstituido.Serie);
    AINIRec.WriteString(LSecao, 'Tipo', FpAOwner.TipoRPSToStr(NFSe.RpsSubstituido.Tipo));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarININFSeCancelamento(AINIRec: TMemIniFile);
begin
  LSecao := 'NFSeCancelamento';

  SecaoOpcional(AINIRec, LSecao, 'da NFSe Cancelamento.');

  if (NFSe.NfseCancelamento.DataHora > 0) or (Trim(NFSe.MotivoCancelamento) <> '') or
     FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'MotivoCancelamento', NFSe.MotivoCancelamento);
    AINIRec.WriteString(LSecao, 'JustificativaCancelamento', NFSe.JustificativaCancelamento);
    AINIRec.WriteString(LSecao, 'CodigoCancelamento', NFSe.CodigoCancelamento);
    AINIRec.WriteString(LSecao, 'NumeroNFSe', NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.Numero);
    AINIRec.WriteString(LSecao, 'CNPJ', NFSe.NfseCancelamento.Pedido.IdentificacaoNfse.Cnpj);
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.InscricaoMunicipal);
    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.CodigoMunicipio);
    AINIRec.WriteString(LSecao, 'CodCancel', NFSe.NfseCancelamento.Pedido.CodigoCancelamento);
    AINIRec.WriteBool(LSecao, 'Sucesso', NFSe.NFSeCancelamento.Sucesso);
    AINIRec.WriteDateTime(LSecao, 'DataHora', NFSe.NfSeCancelamento.DataHora);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDadosPrestador(AINIRec: TMemIniFile);
var
  LValores: string;
begin
  LSecao := 'Prestador';

  LValores := '1=PF Nao Identificada; 2=PF; 3=PJ do Municipio; ' +
      '4=PJ fora Municipio; 5=PJ fora Pais';
  FaixadeValores(AINIRec, LSecao, LValores, 1);

  AINIRec.WriteString(LSecao, 'TipoPessoa', FpAOwner.TipoPessoaToStr(NFSe.Prestador.IdentificacaoPrestador.Tipo));
  AINIRec.WriteString(LSecao, 'CNPJCPF', NFSe.Prestador.IdentificacaoPrestador.CpfCnpj);
  AINIRec.WriteString(LSecao, 'InscricaoMunicipal', NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal);
  AINIRec.WriteString(LSecao, 'InscricaoEstadual', NFSe.Prestador.IdentificacaoPrestador.InscricaoEstadual);
  AINIRec.WriteString(LSecao, 'NIF', NFSe.Prestador.IdentificacaoPrestador.NIF);
  AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(NFSe.Prestador.IdentificacaoPrestador.cNaoNIF));
  AINIRec.WriteString(LSecao, 'CAEPF', NFSe.Prestador.IdentificacaoPrestador.CAEPF);

  AINIRec.WriteString(LSecao, 'RazaoSocial', NFSe.Prestador.RazaoSocial);
  AINIRec.WriteString(LSecao, 'NomeFantasia', NFSe.Prestador.NomeFantasia);

  AINIRec.WriteString(LSecao, 'TipoLogradouro', NFSe.Prestador.Endereco.TipoLogradouro);
  AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.Prestador.Endereco.CodigoMunicipio);
  AINIRec.WriteString(LSecao, 'CEP', NFSe.Prestador.Endereco.CEP);
  AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Prestador.Endereco.CodigoPais);
  AINIRec.WriteString(LSecao, 'xPais', NFSe.Prestador.Endereco.xPais);
  AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Prestador.Endereco.xMunicipio);
  AINIRec.WriteString(LSecao, 'UF', NFSe.Prestador.Endereco.UF);
  AINIRec.WriteString(LSecao, 'Logradouro', NFSe.Prestador.Endereco.Endereco);
  AINIRec.WriteString(LSecao, 'Numero', NFSe.Prestador.Endereco.Numero);
  AINIRec.WriteString(LSecao, 'Complemento', NFSe.Prestador.Endereco.Complemento);
  AINIRec.WriteString(LSecao, 'Bairro', NFSe.Prestador.Endereco.Bairro);

  AINIRec.WriteString(LSecao, 'DDD', NFSe.Prestador.Contato.DDD);
  AINIRec.WriteString(LSecao, 'Telefone', NFSe.Prestador.Contato.Telefone);
  AINIRec.WriteString(LSecao, 'Email', NFSe.Prestador.Contato.Email);
  AINIRec.WriteString(LSecao, 'xSite', NFSe.Prestador.Contato.xSite);

  LValores := '1=Nao Optante; 2=OptanteMEI; 3 =Optante MEEPP';
  FaixadeValores(AINIRec, LSecao, LValores, 2);

  AINIRec.WriteString(LSecao, 'opSimpNac', OptanteSNToStr(NFSe.OptanteSN));
  AINIRec.WriteString(LSecao, 'OptanteSN', FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional));
  AINIRec.WriteString(LSecao, 'OptanteMEISimei', FpAOwner.SimNaoToStr(NFSe.OptanteMEISimei));

  AINIRec.WriteString(LSecao, 'RegimeApuracaoSN', RegimeApuracaoSNToStr(NFSe.RegimeApuracaoSN));
  AINIRec.WriteString(LSecao, 'RegimeEspTrib', FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao));

  if NFSe.DataOptanteSimplesNacional > 0 then
    AINIRec.WriteDateTime(LSecao, 'DataOptanteSimplesNacional', NFSe.DataOptanteSimplesNacional);

  AINIRec.WriteString(LSecao, 'crc', NFSe.Prestador.crc);
  AINIRec.WriteString(LSecao, 'crc_estado', NFSe.Prestador.crc_estado);
  AINIRec.WriteString(LSecao, 'IncentivadorCultural', FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural));

  // Para o provedor WebFisco
  if NFSe.Prestador.Anexo <> '' then
    AINIRec.WriteString(LSecao, 'Anexo', NFSe.Prestador.Anexo);

  if NFSe.Prestador.ValorReceitaBruta > 0 then
    AINIRec.WriteFloat(LSecao, 'ValorReceitaBruta', NFSe.Prestador.ValorReceitaBruta);

  if NFSe.Prestador.DataInicioAtividade > 0 then
    AINIRec.WriteDate(LSecao, 'DataInicioAtividade', NFSe.Prestador.DataInicioAtividade);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIDadosTomador(AINIRec: TMemIniFile);
var
  LValores: string;
begin
  LSecao := 'Tomador';

  SecaoOpcional(AINIRec, LSecao, 'do Tomador.');

  if (NFSe.Tomador.IdentificacaoTomador.CpfCnpj <> '') or FpGerarSecaoOpcional then
  begin
    LValores := '1=PF Nao Identificada; 2=PF; 3=PJ do Municipio; ' +
        '4=PJ fora Municipio; 5=PJ fora Pais';
    FaixadeValores(AINIRec, LSecao, LValores, 1);

    AINIRec.WriteString(LSecao, 'TipoPessoa', FpAOwner.TipoPessoaToStr(NFSe.Prestador.IdentificacaoPrestador.Tipo));
    AINIRec.WriteString(LSecao, 'CNPJCPF', NFSe.Tomador.IdentificacaoTomador.CpfCnpj);
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal);
    AINIRec.WriteString(LSecao, 'InscricaoEstadual', NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual);
    AINIRec.WriteString(LSecao, 'NIF', NFSe.Tomador.IdentificacaoTomador.NIF);
    AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(NFSe.Tomador.IdentificacaoTomador.cNaoNIF));
    AINIRec.WriteString(LSecao, 'CAEPF', NFSe.Tomador.IdentificacaoTomador.CAEPF);
    AINIRec.WriteString(LSecao, 'DocEstrangeiro', NFSe.Tomador.IdentificacaoTomador.DocEstrangeiro);

    AINIRec.WriteString(LSecao, 'RazaoSocial', NFSe.Tomador.RazaoSocial);
    AINIRec.WriteString(LSecao, 'NomeFantasia', NFSe.Tomador.NomeFantasia);

    AINIRec.WriteString(LSecao, 'EnderecoInformado', FpAOwner.SimNaoOpcToStr(NFSe.Tomador.Endereco.EnderecoInformado));
    AINIRec.WriteString(LSecao, 'TipoLogradouro', NFSe.Tomador.Endereco.TipoLogradouro);
    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.Tomador.Endereco.CodigoMunicipio);
    AINIRec.WriteString(LSecao, 'CEP', NFSe.Tomador.Endereco.CEP);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Tomador.Endereco.CodigoPais);
    AINIRec.WriteString(LSecao, 'xPais', NFSe.Tomador.Endereco.xPais);
    AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Tomador.Endereco.xMunicipio);
    AINIRec.WriteString(LSecao, 'UF', NFSe.Tomador.Endereco.UF);
    AINIRec.WriteString(LSecao, 'Logradouro', NFSe.Tomador.Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Numero', NFSe.Tomador.Endereco.Numero);
    AINIRec.WriteString(LSecao, 'Complemento', NFSe.Tomador.Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'Bairro', NFSe.Tomador.Endereco.Bairro);
    AINIRec.WriteString(LSecao, 'TipoBairro', NFSe.Tomador.Endereco.TipoBairro);
    AINIRec.WriteString(LSecao, 'PontoReferencia', NFSe.Tomador.Endereco.PontoReferencia);

    AINIRec.WriteString(LSecao, 'TipoTelefone', NFSe.Tomador.Contato.TipoTelefone);
    AINIRec.WriteString(LSecao, 'DDD', NFSe.Tomador.Contato.DDD);
    AINIRec.WriteString(LSecao, 'Telefone', NFSe.Tomador.Contato.Telefone);
    AINIRec.WriteString(LSecao, 'Email', NFSe.Tomador.Contato.Email);

    AINIRec.WriteString(LSecao, 'AtualizaTomador', FpAOwner.SimNaoToStr(NFSe.Tomador.AtualizaTomador));
    AINIRec.WriteString(LSecao, 'TomadorExterior', FpAOwner.SimNaoToStr(NFSe.Tomador.TomadorExterior));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDadosIntermediario(
  AINIRec: TMemIniFile);
begin
  LSecao := 'Intermediario';

  SecaoOpcional(AINIRec, LSecao, 'do Intermediário.');

  if (NFSe.Intermediario.Identificacao.CpfCnpj <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'CNPJCPF', NFSe.Intermediario.Identificacao.CpfCnpj);
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', NFSe.Intermediario.Identificacao.InscricaoMunicipal);
    AINIRec.WriteString(LSecao, 'NIF', NFSe.Intermediario.Identificacao.NIF);
    AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(NFSe.Intermediario.Identificacao.cNaoNIF));
    AINIRec.WriteString(LSecao, 'CAEPF', NFSe.Intermediario.Identificacao.CAEPF);

    AINIRec.WriteString(LSecao, 'RazaoSocial', NFSe.Intermediario.RazaoSocial);

    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.Intermediario.Endereco.CodigoMunicipio);
    AINIRec.WriteString(LSecao, 'CEP', NFSe.Intermediario.Endereco.CEP);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Intermediario.Endereco.CodigoPais);
    AINIRec.WriteString(LSecao, 'xPais', NFSe.Intermediario.Endereco.xPais);
    AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Intermediario.Endereco.xMunicipio);
    AINIRec.WriteString(LSecao, 'UF', NFSe.Intermediario.Endereco.UF);
    AINIRec.WriteString(LSecao, 'Logradouro', NFSe.Intermediario.Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Numero', NFSe.Intermediario.Endereco.Numero);
    AINIRec.WriteString(LSecao, 'Complemento', NFSe.Intermediario.Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'Bairro', NFSe.Intermediario.Endereco.Bairro);

    AINIRec.WriteString(LSecao, 'Telefone', NFSe.Intermediario.Contato.Telefone);
    AINIRec.WriteString(LSecao, 'Email', NFSe.Intermediario.Contato.Email);

    AINIRec.WriteString(LSecao, 'IssRetido', FpAOwner.SituacaoTributariaToStr(NFSe.Intermediario.IssRetido));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDadosServico(AINIRec: TMemIniFile);
begin
  LSecao := 'Servico';

  if NFSe.Servico.ItemServico.Count = 0 then
  begin
    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.Servico.CodigoMunicipio);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Servico.CodigoPais);
    AINIRec.WriteString(LSecao, 'ItemListaServico', NFSe.Servico.ItemListaServico);
    AINIRec.WriteString(LSecao, 'xItemListaServico', NFSe.Servico.xItemListaServico);
    AINIRec.WriteString(LSecao, 'CodigoTributacaoMunicipio', NFSe.Servico.CodigoTributacaoMunicipio);
    AINIRec.WriteString(LSecao, 'xCodigoTributacaoMunicipio', NFSe.Servico.xCodigoTributacaoMunicipio);
    AINIRec.WriteString(LSecao, 'Discriminacao', ChangeLineBreak(NFSe.Servico.Discriminacao, FpAOwner.ConfigGeral.QuebradeLinha));
    AINIRec.WriteString(LSecao, 'Discriminacao', NFSe.Servico.Discriminacao);
    AINIRec.WriteString(LSecao, 'CodigoNBS', NFSe.Servico.CodigoNBS);
    AINIRec.WriteString(LSecao, 'xNBS', NFSe.infNFSe.xNBS);
    AINIRec.WriteString(LSecao, 'CodigoInterContr', NFSe.Servico.CodigoInterContr);
    AINIRec.WriteString(LSecao, 'CodigoCnae', NFSe.Servico.CodigoCnae);
    AINIRec.WriteString(LSecao, 'Descricao', ChangeLineBreak(NFSe.Servico.Descricao, FpAOwner.ConfigGeral.QuebradeLinha));

    AINIRec.WriteString(LSecao, 'ExigibilidadeISS', FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS));
    AINIRec.WriteString(LSecao, 'IdentifNaoExigibilidade', NFSe.Servico.IdentifNaoExigibilidade);
    AINIRec.WriteInteger(LSecao, 'MunicipioIncidencia', NFSe.Servico.MunicipioIncidencia);
    AINIRec.WriteString(LSecao, 'xMunicipioIncidencia', NFSe.Servico.xMunicipioIncidencia);
    AINIRec.WriteString(LSecao, 'NumeroProcesso', NFSe.Servico.NumeroProcesso);
    AINIRec.WriteString(LSecao, 'MunicipioPrestacaoServico', NFSe.Servico.MunicipioPrestacaoServico);
    AINIRec.WriteString(LSecao, 'UFPrestacao', NFSe.Servico.UFPrestacao);
    AINIRec.WriteString(LSecao, 'ResponsavelRetencao', FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao));
    AINIRec.WriteString(LSecao, 'TipoLancamento', TipoLancamentoToStr(NFSe.Servico.TipoLancamento));
    AINIRec.WriteFloat(LSecao,'ValorTotalRecebido', NFSe.Servico.ValorTotalRecebido);
    //Provedor ISSDSF
    AINIRec.WriteString(LSecao, 'Operacao', OperacaoToStr(NFSe.Servico.Operacao));
    AINIRec.WriteString(LSecao, 'Tributacao', FpAOwner.TributacaoToStr(NFSe.Servico.Tributacao));
    // Provedor SoftPlan
    AINIRec.WriteString(LSecao, 'CFPS', NFSe.Servico.CFPS);

    // Provedor Giap Informações sobre o Endereço da Prestação de Serviço
    AINIRec.WriteString(LSecao, 'Bairro', NFSe.Servico.Endereco.Bairro);
    AINIRec.WriteString(LSecao, 'CEP', NFSe.Servico.Endereco.CEP);
    AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Servico.Endereco.xMunicipio);
    AINIRec.WriteString(LSecao, 'Complemento', NFSe.Servico.Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'Logradouro', NFSe.Servico.Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Numero', NFSe.Servico.Endereco.Numero);
    AINIRec.WriteString(LSecao, 'xPais', NFSe.Servico.Endereco.xPais);
    AINIRec.WriteString(LSecao, 'UF', NFSe.Servico.Endereco.UF);

    //Provedor IssSaoPaulo
    AINIRec.WriteFloat(LSecao, 'ValorTotalRecebido', NFSe.Servico.ValorTotalRecebido);
    AINIRec.WriteFloat(LSecao, 'ValorCargaTributaria', NFSe.Servico.ValorCargaTributaria);
    AINIRec.WriteFloat(LSecao, 'PercentualCargaTributaria', NFSe.Servico.PercentualCargaTributaria);
    AINIRec.WriteString(LSecao, 'FonteCargaTributaria', NFSe.Servico.FonteCargaTributaria);

    AINIRec.WriteString(LSecao,'LocalPrestacao', LocalPrestacaoToStr(NFSe.Servico.LocalPrestacao));
    AINIRec.WriteBool(LSecao, 'PrestadoEmViasPublicas', NFSe.Servico.PrestadoEmViasPublicas);

    //Provedor Megasoft
    AINIRec.WriteString(LSecao, 'InfAdicional', NFSe.Servico.InfAdicional);
    AINIRec.WriteString(LSecao, 'xFormaPagamento', NFSe.Servico.xFormaPagamento);

    //Provedor IssSalvador
    AINIRec.WriteString(LSecao, 'cClassTrib', NFSe.Servico.cClassTrib);
    AINIRec.WriteString(LSecao, 'INDOP', NFSe.Servico.INDOP);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIComercioExterior(AINIRec: TMemIniFile);
begin
  LSecao := 'ComercioExterior';

  SecaoOpcional(AINIRec, LSecao, 'do Comercio Exterior.');

  if (NFSe.Servico.comExt.tpMoeda <> 0) or (NFSe.Servico.comExt.vServMoeda > 0) or
     FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'mdPrestacao', mdPrestacaoToStr(NFSe.Servico.comExt.mdPrestacao));
    AINIRec.WriteString(LSecao, 'vincPrest', vincPrestToStr(NFSe.Servico.comExt.vincPrest));
    AINIRec.WriteInteger(LSecao, 'tpMoeda', NFSe.Servico.comExt.tpMoeda);
    AINIRec.WriteFloat(LSecao, 'vServMoeda', NFSe.Servico.comExt.vServMoeda);
    AINIRec.WriteString(LSecao, 'mecAFComexP', mecAFComexPToStr(NFSe.Servico.comExt.mecAFComexP));
    AINIRec.WriteString(LSecao, 'mecAFComexT', mecAFComexTToStr(NFSe.Servico.comExt.mecAFComexT));
    AINIRec.WriteString(LSecao, 'movTempBens', MovTempBensToStr(NFSe.Servico.comExt.movTempBens));
    AINIRec.WriteString(LSecao, 'nDI', NFSe.Servico.comExt.nDI);
    AINIRec.WriteString(LSecao, 'nRE', NFSe.Servico.comExt.nRE);
    AINIRec.WriteInteger(LSecao, 'mdic', NFSe.Servico.comExt.mdic);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINILocacaoSubLocacao(AINIRec: TMemIniFile);
begin
  LSecao := 'LocacaoSubLocacao';

  SecaoOpcional(AINIRec, LSecao, 'da Locação SubLocação.');

  if (NFSe.Servico.Locacao.extensao <> '') or (NFSe.Servico.Locacao.nPostes > 0) or
     FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'categ', categToStr(NFSe.Servico.Locacao.categ));
    AINIRec.WriteString(LSecao, 'objeto', objetoToStr(NFSe.Servico.Locacao.objeto));
    AINIRec.WriteString(LSecao, 'extensao', NFSe.Servico.Locacao.extensao);
    AINIRec.WriteInteger(LSecao, 'nPostes', NFSe.Servico.Locacao.nPostes);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIConstrucaoCivil(AINIRec: TMemIniFile);
begin
  LSecao:= 'ConstrucaoCivil';

  SecaoOpcional(AINIRec, LSecao, 'da Construção Civil.');

  if (NFSe.ConstrucaoCivil.CodigoObra <> '') or (NFSe.ConstrucaoCivil.nCei <> '') or
     (NFSe.ConstrucaoCivil.Endereco.CEP <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteInteger(LSecao, 'TipoIdentificacaoObra', NFSe.ConstrucaoCivil.Tipo);
    AINIRec.WriteString(LSecao, 'CodigoObra', NFSe.ConstrucaoCivil.CodigoObra);
    AINIRec.WriteString(LSecao, 'Art', NFSe.ConstrucaoCivil.Art);
    AINIRec.WriteString(LSecao, 'nCei', NFSe.ConstrucaoCivil.nCei);
    AINIRec.WriteString(LSecao, 'nProj', NFSe.ConstrucaoCivil.nProj);
    AINIRec.WriteString(LSecao, 'nMatri', NFSe.ConstrucaoCivil.nMatri);
    AINIRec.WriteString(LSecao, 'nNumeroEncapsulamento', NFSe.ConstrucaoCivil.nNumeroEncapsulamento);
    AINIRec.WriteString(LSecao, 'inscImobFisc', NFSe.ConstrucaoCivil.inscImobFisc);
    AINIRec.WriteInteger(LSecao, 'Cib', NFSe.ConstrucaoCivil.Cib);

    if (NFSe.ConstrucaoCivil.Endereco.Endereco <> '') or
       (NFSe.ConstrucaoCivil.Endereco.CEP <> '') or FpGerarSecaoOpcional then
    begin
      AINIRec.WriteString(LSecao, 'CEP', NFSe.ConstrucaoCivil.Endereco.CEP);
      AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.ConstrucaoCivil.Endereco.XMunicipio);
      AINIRec.WriteString(LSecao, 'UF', NFSe.ConstrucaoCivil.Endereco.UF);
      AINIRec.WriteString(LSecao, 'Logradouro', NFSe.ConstrucaoCivil.Endereco.Endereco);
      AINIRec.WriteString(LSecao, 'Numero', NFSe.ConstrucaoCivil.Endereco.Numero);
      AINIRec.WriteString(LSecao, 'Complemento', NFSe.ConstrucaoCivil.Endereco.Complemento);
      AINIRec.WriteString(LSecao, 'Bairro', NFSe.ConstrucaoCivil.Endereco.Bairro);
    end;

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIEvento(AINIRec: TMemIniFile);
begin
  LSecao := 'Evento';

  SecaoOpcional(AINIRec, LSecao, 'do Evento.');

  if (NFSe.Servico.Evento.xNome <> '') or (NFSe.Servico.Evento.dtIni > 0) or
     (NFSe.Servico.Evento.dtFim > 0) or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'xNome', NFSe.Servico.Evento.xNome);
    AINIRec.WriteDate(LSecao, 'dtIni', NFSe.Servico.Evento.dtIni);
    AINIRec.WriteDate(LSecao, 'dtFim', NFSe.Servico.Evento.dtFim);
    AINIRec.WriteString(LSecao, 'idAtvEvt', NFSe.Servico.Evento.idAtvEvt);

    AINIRec.WriteString(LSecao, 'CEP', NFSe.Servico.Evento.Endereco.CEP);
    AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Servico.Evento.Endereco.xMunicipio);
    AINIRec.WriteString(LSecao, 'UF', NFSe.Servico.Evento.Endereco.UF);
    AINIRec.WriteString(LSecao, 'Logradouro', NFSe.Servico.Evento.Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Complemento', NFSe.Servico.Evento.Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'Bairro', NFSe.Servico.Evento.Endereco.Bairro);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIRodoviaria(AINIRec: TMemIniFile);
begin
  LSecao := 'Rodoviaria';

  SecaoOpcional(AINIRec, LSecao, 'da Rodoviaria.');

  if (NFSe.Servico.explRod.placa <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'categVeic', categVeicToStr(NFSe.Servico.ExplRod.categVeic));
    AINIRec.WriteInteger(LSecao, 'nEixos', NFSe.Servico.ExplRod.nEixos);
    AINIRec.WriteString(LSecao, 'rodagem', rodagemToStr(NFSe.Servico.ExplRod.rodagem));
    AINIRec.WriteString(LSecao, 'placa', NFSe.Servico.ExplRod.placa);
    AINIRec.WriteString(LSecao, 'sentido', NFSe.Servico.ExplRod.sentido);
    AINIRec.WriteString(LSecao, 'codAcessoPed', NFSe.Servico.ExplRod.codAcessoPed);
    AINIRec.WriteString(LSecao, 'codContrato', NFSe.Servico.ExplRod.codContrato);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIInformacoesComplementares(
  AINIRec: TMemIniFile);
begin
  LSecao := 'InformacoesComplementares';

  SecaoOpcional(AINIRec, LSecao, 'de Informações Complementares.');

  if (NFSe.Servico.infoCompl.idDocTec <> '') or (NFSe.Servico.infoCompl.docRef <> '') or
     (NFSe.Servico.infoCompl.xInfComp <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'idDocTec', NFSe.Servico.infoCompl.idDocTec);
    AINIRec.WriteString(LSecao, 'docRef', NFSe.Servico.infoCompl.docRef);
    AINIRec.WriteString(LSecao, 'xInfComp', NFSe.Servico.infoCompl.xInfComp);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIInformacoesComplementaresgItemPed(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'gItemPed', 99);

  for i := 0 to NFSe.Servico.infoCompl.gItemPed.Count-1 do
  begin
    LSecao := 'gItemPed' + IntToStrZero(i + 1, 2);

    AINIRec.WriteString(LSecao, 'xItemPed', NFSe.Servico.infoCompl.gItemPed[i].xItemPed);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIValores(AINIRec: TMemIniFile);
begin
  LSecao := 'Valores';

  if NFSe.Servico.ItemServico.Count = 0 then
  begin
    AINIRec.WriteFloat(LSecao, 'ValorRecebido', NFSe.Servico.Valores.ValorRecebido);
    AINIRec.WriteFloat(LSecao, 'ValorServicos', NFSe.Servico.Valores.ValorServicos);
    AINIRec.WriteFloat(LSecao, 'DescontoIncondicionado', NFSe.Servico.Valores.DescontoIncondicionado);
    AINIRec.WriteFloat(LSecao, 'DescontoCondicionado', NFSe.Servico.Valores.DescontoCondicionado);
    AINIRec.WriteFloat(LSecao, 'AliquotaDeducoes', NFSe.Servico.Valores.AliquotaDeducoes);
    AINIRec.WriteFloat(LSecao, 'ValorDeducoes', NFSe.Servico.Valores.ValorDeducoes);
    AINIRec.WriteString(LSecao, 'JustificativaDeducao', NFSe.Servico.Valores.JustificativaDeducao);
    AINIRec.WriteFloat(LSecao, 'ValorPis', NFSe.Servico.Valores.ValorPis);
    AINIRec.WriteFloat(LSecao, 'AliquotaPis', NFSe.Servico.Valores.AliquotaPis);
    AINIRec.WriteString(LSecao, 'RetidoPis', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoPis));
    AINIRec.WriteFloat(LSecao, 'ValorCofins', NFSe.Servico.Valores.ValorCofins);
    AINIRec.WriteFloat(LSecao, 'AliquotaCofins', NFSe.Servico.Valores.AliquotaCofins);
    AINIRec.WriteString(LSecao, 'RetidoCofins', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCofins));
    AINIRec.WriteFloat(LSecao, 'ValorInss', NFSe.Servico.Valores.ValorInss);
    AINIRec.WriteFloat(LSecao, 'AliquotaInss', NFSe.Servico.Valores.AliquotaInss);
    AINIRec.WriteString(LSecao, 'RetidoInss', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoInss));
    AINIRec.WriteFloat(LSecao, 'ValorIr', NFSe.Servico.Valores.ValorIr);
    AINIRec.WriteFloat(LSecao, 'AliquotaIr', NFSe.Servico.Valores.AliquotaIr);
    AINIRec.WriteString(LSecao, 'RetidoIr', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoIr));
    AINIRec.WriteFloat(LSecao, 'ValorCsll', NFSe.Servico.Valores.ValorCsll);
    AINIRec.WriteFloat(LSecao, 'AliquotaCsll', NFSe.Servico.Valores.AliquotaCsll);
    AINIRec.WriteString(LSecao, 'RetidoCsll', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCsll));
    AINIRec.WriteString(LSecao, 'ISSRetido', FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido));
    AINIRec.WriteFloat(LSecao, 'AliquotaCpp', NFSe.Servico.Valores.AliquotaCpp);
    AINIRec.WriteFloat(LSecao, 'ValorCpp', NFSe.Servico.Valores.ValorCpp);
    AINIRec.WriteString(LSecao, 'RetidoCpp', FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCpp));
    AINIRec.WriteFloat(LSecao, 'valorOutrasRetencoes', NFSe.Servico.Valores.valorOutrasRetencoes);
    AINIRec.WriteFloat(LSecao, 'OutrasRetencoes', NFSe.Servico.Valores.OutrasRetencoes);
    AINIRec.WriteString(LSecao, 'DescricaoOutrasRetencoes', NFSe.Servico.Valores.DescricaoOutrasRetencoes);
    AINIRec.WriteFloat(LSecao, 'OutrosDescontos', NFSe.Servico.Valores.OutrosDescontos);
    AINIRec.WriteFloat(LSecao, 'ValorRepasse', NFSe.Servico.Valores.ValorRepasse);
    AINIRec.WriteFloat(LSecao, 'BaseCalculo', NFSe.Servico.Valores.BaseCalculo);
    AINIRec.WriteFloat(LSecao, 'Aliquota', NFSe.Servico.Valores.Aliquota);
    AINIRec.WriteFloat(LSecao, 'AliquotaSN', NFSe.Servico.Valores.AliquotaSN);
    AINIRec.WriteFloat(LSecao, 'ValorIss', NFSe.Servico.Valores.ValorIss);
    AINIRec.WriteFloat(LSecao, 'ValorIssRetido', NFSe.Servico.Valores.ValorIssRetido);
    AINIRec.WriteFloat(LSecao, 'ValorLiquidoNfse', NFSe.Servico.Valores.ValorLiquidoNfse);
    AINIRec.WriteFloat(LSecao, 'ValorTotalNotaFiscal', NFSe.Servico.Valores.ValorTotalNotaFiscal);
    AINIRec.WriteFloat(LSecao, 'ValorTotalTributos', NFSe.Servico.Valores.ValorTotalTributos);
    AINIRec.WriteFloat(LSecao, 'IrrfIndenizacao', NFSe.Servico.Valores.IrrfIndenizacao);
    AINIRec.WriteFloat(LSecao, 'RetencoesFederais', NFSe.Servico.Valores.RetencoesFederais);
    AINIRec.WriteFloat(LSecao, 'ValorIPI', NFSe.Servico.Valores.ValorIPI);
    AINIRec.WriteFloat(LSecao, 'ValorInicialCobrado', NFSe.Servico.Valores.ValorInicialCobrado);
    AINIRec.WriteFloat(LSecao, 'ValorFinalCobrado', NFSe.Servico.Valores.ValorFinalCobrado);
    AINIRec.WriteFloat(LSecao, 'totalAproxTrib', NFSe.Servico.Valores.totalAproxTrib);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDocumentosDeducoes(
  AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'DocumentosDeducoes', 1000);

  for i := 0 to NFSe.Servico.Valores.DocDeducao.Count - 1 do
  begin
    LSecao := 'DocumentosDeducoes' + IntToStrZero(i + 1, 4);

    AINIRec.WriteString(LSecao, 'chNFSe', NFSe.Servico.Valores.DocDeducao[i].chNFSe);
    AINIRec.WriteString(LSecao, 'chNFe', NFSe.Servico.Valores.DocDeducao[i].chNFe);
    AINIRec.WriteString(LSecao, 'nDocFisc', NFSe.Servico.Valores.DocDeducao[i].nDocFisc);
    AINIRec.WriteString(LSecao, 'nDoc', NFSe.Servico.Valores.DocDeducao[i].nDoc);
    AINIRec.WriteString(LSecao, 'tpDedRed', tpDedRedToStr(NFSe.Servico.Valores.DocDeducao[i].tpDedRed));
    AINIRec.WriteString(LSecao, 'xDescOutDed', NFSe.Servico.Valores.DocDeducao[i].xDescOutDed);
    AINIRec.WriteString(LSecao, 'dtEmiDoc', DateToStr(NFSe.Servico.Valores.DocDeducao[i].dtEmiDoc));
    AINIRec.WriteFloat(LSecao, 'vDedutivelRedutivel', NFSe.Servico.Valores.DocDeducao[i].vDedutivelRedutivel);
    AINIRec.WriteFloat(LSecao, 'vDeducaoReducao', NFSe.Servico.Valores.DocDeducao[i].vDeducaoReducao);

    AINIRec.WriteString(LSecao, 'cMunNFSeMun', NFSe.Servico.Valores.DocDeducao[i].NFSeMun.cMunNFSeMun);
    AINIRec.WriteString(LSecao, 'nNFSeMun', NFSe.Servico.Valores.DocDeducao[i].NFSeMun.nNFSeMun);
    AINIRec.WriteString(LSecao, 'cVerifNFSeMun', NFSe.Servico.Valores.DocDeducao[i].NFSeMun.cVerifNFSeMun);

    AINIRec.WriteString(LSecao, 'nNFS', NFSe.Servico.Valores.DocDeducao[i].NFNFS.nNFS);
    AINIRec.WriteString(LSecao, 'modNFS', NFSe.Servico.Valores.DocDeducao[i].NFNFS.modNFS);
    AINIRec.WriteString(LSecao, 'serieNFS', NFSe.Servico.Valores.DocDeducao[i].NFNFS.serieNFS);

    GerarINIDocumentosDeducoesFornecedor(AINIRec, NFSe.Servico.Valores.DocDeducao[i].fornec, i);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDocumentosDeducoesFornecedor(
  AINIRec: TMemIniFile; fornec: TInfoPessoa; Indice: Integer);
begin
  IndicesdeLista(AINIRec, 'DocumentosDeducoesFornecedor', 1000);

  LSecao := 'DocumentosDeducoesFornecedor' + IntToStrZero(Indice + 1, 4);

  if (fornec.Identificacao.CpfCnpj <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'CNPJCPF', fornec.Identificacao.CpfCnpj);
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', fornec.Identificacao.InscricaoMunicipal);
    AINIRec.WriteString(LSecao, 'NIF', fornec.Identificacao.NIF);
    AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(fornec.Identificacao.cNaoNIF));
    AINIRec.WriteString(LSecao, 'CAEPF', fornec.Identificacao.CAEPF);
    AINIRec.WriteString(LSecao, 'RazaoSocial', fornec.RazaoSocial);

    AINIRec.WriteString(LSecao, 'CEP', fornec.Endereco.CEP);
    AINIRec.WriteString(LSecao, 'xMunicipio', fornec.Endereco.xMunicipio);
    AINIRec.WriteString(LSecao, 'UF', fornec.Endereco.UF);
    AINIRec.WriteString(LSecao, 'Logradouro', fornec.Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Numero', fornec.Endereco.Numero);
    AINIRec.WriteString(LSecao, 'Complemento', fornec.Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'Bairro', fornec.Endereco.Bairro);

    AINIRec.WriteString(LSecao, 'Telefone', fornec.Contato.Telefone);
    AINIRec.WriteString(LSecao, 'Email', fornec.Contato.Email);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIValoresTribMun(AINIRec: TMemIniFile);
begin
  LSecao := 'tribMun';

  SecaoOpcional(AINIRec, LSecao, 'de Tributação Municipal.');

  if (NFSe.Servico.Valores.tribMun.pAliq > 0) or (NFSe.Servico.Valores.tribMun.pRedBCBM > 0) or
     (NFSe.Servico.Valores.tribMun.vRedBCBM > 0) or (NFSe.Servico.Valores.tribMun.cPaisResult > 0) or
     FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'tribISSQN', tribISSQNToStr(NFSe.Servico.Valores.tribMun.tribISSQN));
    AINIRec.WriteInteger(LSecao, 'cPaisResult', NFSe.Servico.Valores.tribMun.cPaisResult);
    AINIRec.WriteString(LSecao, 'nBM', NFSe.Servico.Valores.TribMun.nBM);
    AINIRec.WriteFloat(LSecao, 'vRedBCBM', NFSe.Servico.Valores.tribMun.vRedBCBM);
    AINIRec.WriteFloat(LSecao, 'pRedBCBM', NFSe.Servico.Valores.tribMun.pRedBCBM);
    AINIRec.WriteString(LSecao, 'tpSusp', tpSuspToStr(NFSe.Servico.Valores.tribMun.tpSusp));
    AINIRec.WriteString(LSecao, 'nProcesso', NFSe.Servico.Valores.tribMun.nProcesso);
    AINIRec.WriteString(LSecao, 'tpImunidade', tpImunidadeToStr(NFSe.Servico.Valores.tribMun.tpImunidade));
    AINIRec.WriteFloat(LSecao, 'pAliq', NFSe.Servico.Valores.tribMun.pAliq);
    AINIRec.WriteString(LSecao, 'tpRetISSQN', tpRetISSQNToStr(NFSe.Servico.Valores.tribMun.tpRetISSQN));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIValoresTribFederal(
  AINIRec: TMemIniFile);
begin
  LSecao := 'tribFederal';

  SecaoOpcional(AINIRec, LSecao, 'de Tributação Federal.');

  if (NFSe.Servico.Valores.tribFed.pAliqPis > 0) or (NFSe.Servico.Valores.tribFed.pAliqCofins > 0) or
     (NFSe.Servico.Valores.tribFed.vRetIRRF > 0) or (NFSe.Servico.Valores.tribFed.vRetCP > 0) or
     FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'CST', CSTToStr(NFSe.Servico.Valores.tribFed.CST));
    AINIRec.WriteFloat(LSecao, 'vBCPisCofins', NFSe.Servico.Valores.tribFed.vBCPisCofins);
    AINIRec.WriteFloat(LSecao, 'pAliqPis', NFSe.Servico.Valores.tribFed.pAliqPis);
    AINIRec.WriteFloat(LSecao, 'pAliqCofins', NFSe.Servico.Valores.tribFed.pAliqCofins);
    AINIRec.WriteFloat(LSecao, 'vPis', NFSe.Servico.Valores.tribFed.vPis);
    AINIRec.WriteFloat(LSecao, 'vCofins', NFSe.Servico.Valores.tribFed.vCofins);
    AINIRec.WriteString(LSecao, 'tpRetPisCofins', tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins));
    AINIRec.WriteFloat(LSecao, 'vRetCP', NFSe.Servico.Valores.tribFed.vRetCP);
    AINIRec.WriteFloat(LSecao, 'vRetIRRF', NFSe.Servico.Valores.tribFed.vRetIRRF);
    AINIRec.WriteFloat(LSecao, 'vRetCSLL', NFSe.Servico.Valores.tribFed.vRetCSLL);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIValoresTotalTrib(AINIRec: TMemIniFile);
begin
  LSecao := 'totTrib';

  AINIRec.WriteString(LSecao, 'indTotTrib', indTotTribToStr(NFSe.Servico.Valores.totTrib.indTotTrib));
  AINIRec.WriteFloat(LSecao, 'pTotTribSN', NFSe.Servico.Valores.totTrib.pTotTribSN);
  AINIRec.WriteFloat(LSecao, 'vTotTribFed', NFSe.Servico.Valores.totTrib.vTotTribFed);
  AINIRec.WriteFloat(LSecao, 'vTotTribEst', NFSe.Servico.Valores.totTrib.vTotTribEst);
  AINIRec.WriteFloat(LSecao, 'vTotTribMun', NFSe.Servico.Valores.totTrib.vTotTribMun);
  AINIRec.WriteFloat(LSecao, 'pTotTribFed', NFSe.Servico.Valores.totTrib.pTotTribFed);
  AINIRec.WriteFloat(LSecao, 'pTotTribEst', NFSe.Servico.Valores.totTrib.pTotTribEst);
  AINIRec.WriteFloat(LSecao, 'pTotTribMun', NFSe.Servico.Valores.totTrib.pTotTribMun);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIQuartos(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Quartos', 999);

  for I := 0 to NFSe.Quartos.Count - 1 do
  begin
    LSecao := 'Quartos' + IntToStrZero(I + 1, 3);

    AINIRec.WriteInteger(LSecao, 'CodigoInternoQuarto', NFSe.Quartos[I].CodigoInternoQuarto);
    AINIRec.WriteInteger(LSecao, 'QtdHospedes', NFSe.Quartos[I].QtdHospedes);
    AINIRec.WriteDateTime(LSecao, 'CheckIn', NFSe.Quartos[I].CheckIn);
    AINIRec.WriteFloat(LSecao, 'QtdDiarias', NFSe.Quartos[I].ValorDiaria);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDespesas(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Despesas', 999);

  for I := 0 to NFSe.Despesa.Count - 1 do
  begin
    LSecao := 'Despesas' + IntToStrZero(I + 1, 3);

    AINIRec.WriteString(LSecao, 'nItemDesp', NFSe.Despesa.Items[I].nItemDesp);
    AINIRec.WriteString(LSecao, 'xDesp', NFSe.Despesa.Items[I].xDesp);
    AINIRec.WriteDateTime(LSecao, 'dDesp', NFSe.Despesa.Items[I].dDesp);
    AINIRec.WriteFloat(LSecao, 'vDesp', NFSe.Despesa.Items[I].vDesp);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIGenericos(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Genericos', 9);

  for I := 0 to NFSe.Genericos.Count - 1 do
  begin
    LSecao := 'Genericos' + IntToStrZero(I + 1, 1);

    AINIRec.WriteString(LSecao, 'Titulo', NFSe.Genericos[I].Titulo);
    AINIRec.WriteString(LSecao, 'Descricao', NFSe.Genericos[I].Descricao);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIItens(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Itens', 999);

  for I := 0 to NFSe.Servico.ItemServico.Count - 1 do
  begin
    LSecao:= 'Itens' + IntToStrZero(I + 1, 3);

    // Local de execução do serviço
    AINIRec.WriteString(LSecao, 'EnderecoInformado', FpAOwner.SimNaoOpcToStr(NFSe.Servico.ItemServico[I].Endereco.EnderecoInformado));
    AINIRec.WriteString(LSecao, 'TipoLogradouro', NFSe.Servico.ItemServico[I].Endereco.TipoLogradouro);
    AINIRec.WriteString(LSecao, 'Endereco', NFSe.Servico.ItemServico[I].Endereco.Endereco);
    AINIRec.WriteString(LSecao, 'Numero', NFSe.Servico.ItemServico[I].Endereco.Numero);
    AINIRec.WriteString(LSecao, 'Complemento', NFSe.Servico.ItemServico[I].Endereco.Complemento);
    AINIRec.WriteString(LSecao, 'TipoBairro', NFSe.Servico.ItemServico[I].Endereco.TipoBairro);
    AINIRec.WriteString(LSecao, 'Bairro', NFSe.Servico.ItemServico[I].Endereco.Bairro);
    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.Servico.ItemServico[I].Endereco.CodigoMunicipio);
    AINIRec.WriteString(LSecao, 'UF', NFSe.Servico.ItemServico[I].Endereco.UF);
    AINIRec.WriteString(LSecao, 'CEP', NFSe.Servico.ItemServico[I].Endereco.CEP);
    AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.Servico.ItemServico[I].Endereco.xMunicipio);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Servico.ItemServico[I].Endereco.CodigoPais);
    AINIRec.WriteString(LSecao, 'xPais', NFSe.Servico.ItemServico[I].Endereco.xPais);
    AINIRec.WriteString(LSecao, 'PontoReferencia', NFSe.Servico.ItemServico[I].Endereco.PontoReferencia);

    AINIRec.WriteString(LSecao, 'Descricao', ChangeLineBreak(NFSe.Servico.ItemServico[I].Descricao, FpAOwner.ConfigGeral.QuebradeLinha));
    AINIRec.WriteString(LSecao, 'ItemListaServico', NFSe.Servico.ItemServico[I].ItemListaServico);
    AINIRec.WriteString(LSecao, 'xItemListaServico', NFSe.Servico.ItemServico[I].xItemListaServico);
    AINIRec.WriteString(LSecao, 'CodServico', NFSe.Servico.ItemServico[I].CodServ);
    AINIRec.WriteString(LSecao, 'codLCServico', NFSe.Servico.ItemServico[I].CodLCServ);
    AINIRec.WriteString(LSecao, 'CodigoCnae', NFSe.Servico.ItemServico[I].CodigoCnae);
    AINIRec.WriteString(LSecao, 'TipoUnidade', UnidadeToStr(NFSe.Servico.ItemServico[I].TipoUnidade));
    AINIRec.WriteString(LSecao, 'Unidade', NFSe.Servico.ItemServico[I].Unidade);
    AINIRec.WriteFloat(LSecao, 'Quantidade', NFSe.Servico.ItemServico[I].Quantidade);
    AINIRec.WriteFloat(LSecao, 'ValorUnitario', NFSe.Servico.ItemServico[I].ValorUnitario);
    AINIRec.WriteFloat(LSecao, 'QtdeDiaria', NFSe.Servico.ItemServico[I].QtdeDiaria);
    AINIRec.WriteFloat(LSecao, 'ValorTaxaTurismo', NFSe.Servico.ItemServico[I].ValorTaxaTurismo);
    AINIRec.WriteFloat(LSecao, 'AliquotaDeducoes', NFSe.Servico.ItemServico[I].AliqDeducoes);
    AINIRec.WriteFloat(LSecao, 'ValorDeducoes', NFSe.Servico.ItemServico[I].ValorDeducoes);
    AINIRec.WriteString(LSecao, 'xJustDeducao', NFSe.Servico.ItemServico[I].xJustDeducao);
    AINIRec.WriteFloat(LSecao, 'AliqReducao', NFSe.Servico.ItemServico[I].AliqReducao);
    AINIRec.WriteFloat(LSecao, 'ValorReducao', NFSe.Servico.ItemServico[I].ValorReducao);
    AINIRec.WriteFloat(LSecao, 'ValorIss', NFSe.Servico.ItemServico[I].ValorISS);
    AINIRec.WriteFloat(LSecao, 'Aliquota', NFSe.Servico.ItemServico[I].Aliquota);
    AINIRec.WriteFloat(LSecao, 'BaseCalculo', NFSe.Servico.ItemServico[I].BaseCalculo);
    AINIRec.WriteFloat(LSecao, 'DescontoIncondicionado', NFSe.Servico.ItemServico[I].DescontoIncondicionado);
    AINIRec.WriteFloat(LSecao, 'DescontoCondicionado', NFSe.Servico.ItemServico[I].DescontoCondicionado);
    AINIRec.WriteFloat(LSecao, 'AliqISSST', NFSe.Servico.ItemServico[I].AliqISSST);
    AINIRec.WriteFloat(LSecao, 'ValorISSST', NFSe.Servico.ItemServico[I].ValorISSST);

    AINIRec.WriteFloat(LSecao, 'ValorBCCSLL', NFSe.Servico.ItemServico[I].ValorBCCSLL);
    AINIRec.WriteFloat(LSecao, 'AliqRetCSLL', NFSe.Servico.ItemServico[I].AliqRetCSLL);
    AINIRec.WriteString(LSecao, 'RetidoCSLL', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoCSLL));
    AINIRec.WriteFloat(LSecao, 'ValorCSLL', NFSe.Servico.ItemServico[I].ValorCSLL);

    AINIRec.WriteFloat(LSecao, 'ValorBCPIS', NFSe.Servico.ItemServico[I].ValorBCPIS);
    AINIRec.WriteFloat(LSecao, 'AliqRetPIS', NFSe.Servico.ItemServico[I].AliqRetPIS);
    AINIRec.WriteString(LSecao, 'RetidoPIS', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoPIS));
    AINIRec.WriteFloat(LSecao, 'ValorPIS', NFSe.Servico.ItemServico[I].ValorPIS);

    AINIRec.WriteFloat(LSecao, 'ValorBCCOFINS', NFSe.Servico.ItemServico[I].ValorBCCOFINS);
    AINIRec.WriteFloat(LSecao, 'AliqRetCOFINS', NFSe.Servico.ItemServico[I].AliqRetCOFINS);
    AINIRec.WriteString(LSecao, 'RetidoCOFINS', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoCOFINS));
    AINIRec.WriteFloat(LSecao, 'ValorCOFINS', NFSe.Servico.ItemServico[I].ValorCOFINS);

    AINIRec.WriteFloat(LSecao, 'ValorBCINSS', NFSe.Servico.ItemServico[I].ValorBCINSS);
    AINIRec.WriteFloat(LSecao, 'AliqRetINSS', NFSe.Servico.ItemServico[I].AliqRetINSS);
    AINIRec.WriteString(LSecao, 'RetidoINSS', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoINSS));
    AINIRec.WriteFloat(LSecao, 'ValorINSS', NFSe.Servico.ItemServico[I].ValorINSS);

    AINIRec.WriteFloat(LSecao, 'ValorBCRetIRRF', NFSe.Servico.ItemServico[I].ValorBCRetIRRF);
    AINIRec.WriteFloat(LSecao, 'AliqRetIRRF', NFSe.Servico.ItemServico[I].AliqRetIRRF);
    AINIRec.WriteString(LSecao, 'RetidoIRRF', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoIRRF));
    AINIRec.WriteFloat(LSecao, 'ValorIRRF', NFSe.Servico.ItemServico[I].ValorIRRF);

    AINIRec.WriteFloat(LSecao, 'ValorBCCPP', NFSe.Servico.ItemServico[I].ValorBCCPP);
    AINIRec.WriteFloat(LSecao, 'AliqRetCPP', NFSe.Servico.ItemServico[I].AliqRetCPP);
    AINIRec.WriteString(LSecao, 'RetidoCPP', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].RetidoCPP));
    AINIRec.WriteFloat(LSecao, 'ValorCPP', NFSe.Servico.ItemServico[I].ValorCPP);

    AINIRec.WriteFloat(LSecao, 'ValorRecebido', NFSe.Servico.ItemServico[I].ValorRecebido);
    AINIRec.WriteFloat(LSecao, 'ValorTotal', NFSe.Servico.ItemServico[I].ValorTotal);

    AINIRec.WriteString(LSecao, 'Tributavel', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].Tributavel));

    AINIRec.WriteString(LSecao, 'CodMunPrestacao', NFSe.Servico.ItemServico[I].CodMunPrestacao);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', NFSe.Servico.ItemServico[I].CodigoPais);
    AINIRec.WriteString(LSecao, 'CodigoTributacaoMunicipio', NFSe.Servico.ItemServico[I].CodigoTributacaoMunicipio);
    AINIRec.WriteString(LSecao, 'CodigoNBS', NFSe.Servico.ItemServico[I].CodigoNBS);
    AINIRec.WriteString(LSecao, 'xNBS', NFSe.Servico.ItemServico[I].xNBS);
    AINIRec.WriteString(LSecao, 'CodigoInterContr', NFSe.Servico.ItemServico[I].CodigoInterContr);
    AINIRec.WriteString(LSecao, 'ResponsavelRetencao', FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ItemServico[I].ResponsavelRetencao));
    AINIRec.WriteString(LSecao, 'ExigibilidadeISS', FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ItemServico[I].ExigibilidadeISS));
    AINIRec.WriteInteger(LSecao, 'MunicipioIncidencia', NFSe.Servico.ItemServico[I].MunicipioIncidencia);
    AINIRec.WriteString(LSecao, 'xMunicipioIncidencia', NFSe.Servico.ItemServico[I].xMunicipioIncidencia);
    AINIRec.WriteString(LSecao, 'NumeroProcesso', NFSe.Servico.ItemServico[I].NumeroProcesso);
    AINIRec.WriteString(LSecao, 'InfAdicional', NFSe.Servico.ItemServico[I].InfAdicional);
    AINIRec.WriteString(LSecao, 'CodigoServicoNacional', NFSe.Servico.ItemServico[I].CodigoServicoNacional);
    AINIRec.WriteString(LSecao, 'CodigoTributacaoNacional', NFSe.Servico.ItemServico[I].CodigoTributacaoNacional);

    AINIRec.WriteString(LSecao, 'TribMunPrestador', FpAOwner.SimNaoToStr(NFSe.Servico.ItemServico[I].TribMunPrestador));
    AINIRec.WriteInteger(LSecao, 'SituacaoTributaria', NFSe.Servico.ItemServico[I].SituacaoTributaria);
    AINIRec.WriteFloat(LSecao, 'ValorISSRetido', NFSe.Servico.ItemServico[I].ValorISSRetido);
    AINIRec.WriteFloat(LSecao, 'ValorTributavel', NFSe.Servico.ItemServico[I].ValorTributavel);
    AINIRec.WriteString(LSecao, 'CodCNO', NFSe.Servico.ItemServico[I].CodCNO);

    AINIRec.WriteFloat(LSecao, 'TotalAproxTribServ', NFSe.Servico.ItemServico[I].totalAproxTribServ);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDadosDeducao(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'DadosDeducao', 999);

  for I := 0 to NFSe.Servico.Deducao.Count - 1 do
  begin
    LSecao := 'DadosDeducao' + IntToStrZero(I + 1, 3);

    AINIRec.WriteString(LSecao, 'TipoDeducao', FpAOwner.TipoDeducaoToStr(NFSe.Servico.Deducao[I].TipoDeducao));
    AINIRec.WriteString(LSecao, 'CNPJCPF', NFSe.Servico.Deducao[I].CpfCnpjReferencia);
    AINIRec.WriteString(LSecao, 'NumeroNFReferencia', NFSe.Servico.Deducao[I].NumeroNFReferencia);
    AINIRec.WriteFloat(LSecao, 'ValorTotalReferencia', NFSe.Servico.Deducao[I].ValorTotalReferencia);
    AINIRec.WriteFloat(LSecao, 'PercentualDeduzir', NFSe.Servico.Deducao[I].PercentualDeduzir);
    AINIRec.WriteFloat(LSecao, 'ValorDeduzir', NFSe.Servico.Deducao[I].ValorDeduzir);
    AINIRec.WriteString(LSecao, 'DeducaoPor', FpAOwner.DeducaoPorToStr(NFSe.Servico.Deducao[I].DeducaoPor));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIImpostos(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Impostos', 999);

  for I := 0 to NFSe.Servico.Imposto.Count - 1 do
  begin
    LSecao := 'Impostos' + IntToStrZero(I + 1, 3);

    AINIRec.WriteInteger(LSecao, 'Codigo', NFSe.Servico.Imposto[I].Codigo);
    AINIRec.WriteString(LSecao, 'Descricao', NFSe.Servico.Imposto[I].Descricao);
    AINIRec.WriteFloat(LSecao, 'Aliquota', NFSe.Servico.Imposto[I].Aliquota);
    AINIRec.WriteFloat(LSecao, 'Valor', NFSe.Servico.Imposto[I].Valor);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIOrgaoGerador(AINIRec: TMemIniFile);
begin
  LSecao := 'OrgaoGerador';

  SecaoOpcional(AINIRec, LSecao, 'do Orgão Gerador.');

  if (Trim(NFSe.OrgaoGerador.Uf) <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.OrgaoGerador.CodigoMunicipio);
    AINIRec.WriteString(LSecao, 'UF', NFSe.OrgaoGerador.Uf);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINICondicaoPagamento(AINIRec: TMemIniFile);
begin
  LSecao:= 'CondicaoPagamento';

  SecaoOpcional(AINIRec, LSecao, 'da Condição de Pagamento.');

  if (NFSe.CondicaoPagamento.QtdParcela > 0) or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteInteger(LSecao, 'QtdParcela', NFSe.CondicaoPagamento.QtdParcela);
    AINIRec.WriteString(LSecao, 'Condicao', FpAOwner.CondicaoPagToStr(NFSe.CondicaoPagamento.Condicao));

    // Provedor NFEletronica
    if (NFSe.CondicaoPagamento.DataVencimento > 0) or FpGerarSecaoOpcional then
    begin
      AINIRec.WriteDate(LSecao, 'DataVencimento', NFSe.CondicaoPagamento.DataVencimento);
      AINIRec.WriteString(LSecao, 'InstrucaoPagamento', NFSe.CondicaoPagamento.InstrucaoPagamento);
      AINIRec.WriteInteger(LSecao, 'CodigoVencimento', NFSe.CondicaoPagamento.CodigoVencimento);

      if NFSe.CondicaoPagamento.DataCriacao > 0 then
        AINIRec.ReadDateTime(LSecao, 'DataCriacao', NFSe.CondicaoPagamento.DataCriacao)
      else
        AINIRec.ReadDateTime(LSecao, 'DataCriacao', Now);
    end;

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIParcelas(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Parcelas', 99);

  for I := 0 to NFSe.CondicaoPagamento.Parcelas.Count - 1 do
  begin
    LSecao:= 'Parcelas' + IntToStrZero(I + 1, 2);

    AINIRec.WriteString(LSecao, 'Parcela', NFSe.CondicaoPagamento.Parcelas.Items[I].Parcela);
    AINIRec.WriteDate(LSecao, 'DataVencimento', NFSe.CondicaoPagamento.Parcelas.Items[I].DataVencimento);
    AINIRec.WriteFloat(LSecao, 'Valor', NFSe.CondicaoPagamento.Parcelas.Items[I].Valor);
    AINIRec.WriteString(LSecao, 'Condicao', FpAOwner.CondicaoPagToStr(NFSe.CondicaoPagamento.Parcelas.Items[I].Condicao));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIEmail(AINIRec: TMemIniFile);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Email', 9);

  for I := 0 to NFSe.email.Count - 1 do
  begin
    LSecao := 'Email' + IntToStrZero(I + 1, 1);

    AINIRec.WriteString(LSecao, 'emailCC', NFSe.email[I].emailCC);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINITransportadora(AINIRec: TMemIniFile);
begin
  LSecao := 'Transportadora';

  SecaoOpcional(AINIRec, LSecao, 'da Transportadora.');

  if (Trim(NFSe.Transportadora.xCpfCnpjTrans) <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'xNomeTrans', NFSe.Transportadora.xNomeTrans);
    AINIRec.WriteString(LSecao, 'xCpfCnpjTrans', NFSe.Transportadora.xCpfCnpjTrans);
    AINIRec.WriteString(LSecao, 'xInscEstTrans', NFSe.Transportadora.xInscEstTrans);
    AINIRec.WriteString(LSecao, 'xPlacaTrans', NFSe.Transportadora.xPlacaTrans);
    AINIRec.WriteString(LSecao, 'xEndTrans', NFSe.Transportadora.xEndTrans);
    AINIRec.WriteInteger(LSecao, 'cMunTrans', NFSe.Transportadora.cMunTrans);
    AINIRec.WriteString(LSecao, 'xMunTrans', NFSe.Transportadora.xMunTrans);
    AINIRec.WriteString(LSecao, 'xUFTrans', NFSe.Transportadora.xUFTrans);
    AINIRec.WriteString(LSecao, 'xPaisTrans', NFSe.Transportadora.xPaisTrans);
    AINIRec.WriteString(LSecao, 'vTipoFreteTrans', TipoFreteToStr(NFSe.Transportadora.vTipoFreteTrans));

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDadosEmitente(
  const AINIRec: TMemIniFile);
begin
  LSecao := 'Emitente';

  AINIRec.WriteString(LSecao, 'CNPJCPF', NFSe.infNFSe.emit.Identificacao.CpfCnpj);
  AINIRec.WriteString(LSecao, 'InscricaoMunicipal', NFSe.infNFSe.emit.Identificacao.InscricaoMunicipal);

  AINIRec.WriteString(LSecao, 'RazaoSocial', NFSe.infNFSe.emit.RazaoSocial);
  AINIRec.WriteString(LSecao, 'NomeFantasia', NFSe.infNFSe.emit.NomeFantasia);

  AINIRec.WriteString(LSecao, 'Logradouro', NFSe.infNFSe.emit.Endereco.Endereco);
  AINIRec.WriteString(LSecao, 'Numero', NFSe.infNFSe.emit.Endereco.Numero);
  AINIRec.WriteString(LSecao, 'Complemento', NFSe.infNFSe.emit.Endereco.Complemento);
  AINIRec.WriteString(LSecao, 'Bairro', NFSe.infNFSe.emit.Endereco.Bairro);
  AINIRec.WriteString(LSecao, 'CodigoMunicipio', NFSe.infNFSe.emit.Endereco.CodigoMunicipio);
  AINIRec.WriteString(LSecao, 'CEP', NFSe.infNFSe.emit.Endereco.CEP);
  AINIRec.WriteString(LSecao, 'xMunicipio', NFSe.infNFSe.emit.Endereco.xMunicipio);
  AINIRec.WriteString(LSecao, 'UF', NFSe.infNFSe.emit.Endereco.UF);

  AINIRec.WriteString(LSecao, 'Telefone', NFSe.infNFSe.emit.Contato.Telefone);
  AINIRec.WriteString(LSecao, 'Email', NFSe.infNFSe.emit.Contato.Email);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIValoresNFSe(const AINIRec: TMemIniFile);
begin
  LSecao := 'ValoresNFSe';

  AINIRec.WriteFloat(LSecao, 'BaseCalculo', NFSe.ValoresNfse.BaseCalculo);
  AINIRec.WriteFloat(LSecao, 'Aliquota', NFSe.ValoresNfse.Aliquota);
  AINIRec.WriteFloat(LSecao, 'ValorLiquidoNfse', NFSe.ValoresNfse.ValorLiquidoNfse);
  AINIRec.WriteFloat(LSecao, 'ValorIss', NFSe.ValoresNfse.ValorIss);

  AINIRec.WriteFloat(LSecao, 'vCalcDR', NFSe.infNFSe.valores.vCalcDR);
  AINIRec.WriteString(LSecao, 'tpBM', NFSe.infNFSe.valores.tpBM);
  AINIRec.WriteFloat(LSecao, 'vCalcBM', NFSe.infNFSe.valores.vCalcBM);
  AINIRec.WriteFloat(LSecao, 'vBC', NFSe.infNFSe.valores.BaseCalculo);
  AINIRec.WriteFloat(LSecao, 'pAliqAplic', NFSe.infNFSe.valores.Aliquota);
  AINIRec.WriteFloat(LSecao, 'vISSQN', NFSe.infNFSe.valores.ValorIss);
  AINIRec.WriteFloat(LSecao, 'vTotalRet', NFSe.infNFSe.valores.vTotalRet);
  AINIRec.WriteFloat(LSecao, 'vLiq', NFSe.infNFSe.valores.ValorLiquidoNfse);

  AINIRec.WriteString(LSecao, 'xOutInf', NFSe.OutrasInformacoes);

  PularLinha(AINIRec, LSecao);
end;

(*  italo
        //Provedor Elotech
        LSecao := 'DadosDeducao' + IntToStrZero(I + 1, 3);
        AINIRec.WriteString(LSecao, 'TipoDeducao', FpAOwner.TipoDeducaoToStr(Servico.ItemServico.Items[I].DadosDeducao.TipoDeducao));
        AINIRec.WriteString(LSecao, 'CpfCnpj', Servico.ItemServico.Items[I].DadosDeducao.CpfCnpj);
        AINIRec.WriteString(LSecao, 'NumeroNotaFiscalReferencia', Servico.ItemServico.Items[I].DadosDeducao.NumeroNotaFiscalReferencia);
        AINIRec.WriteFloat(LSecao, 'ValorTotalNotaFiscal', Servico.ItemServico.Items[I].DadosDeducao.ValorTotalNotaFiscal);
        AINIRec.WriteFloat(LSecao, 'PercentualADeduzir', Servico.ItemServico.Items[I].DadosDeducao.PercentualADeduzir);
        AINIRec.WriteFloat(LSecao, 'ValorADeduzir', Servico.ItemServico.Items[I].DadosDeducao.ValorADeduzir);

        //Provedor Agili
        LSecao := 'DadosProssionalParceiro' + IntToStrZero(I + 1, 3);
        AINIRec.WriteString(LSecao, 'CpfCnpj', Servico.ItemServico.Items[I].DadosProfissionalParceiro.IdentificacaoParceiro.CpfCnpj);
        AINIRec.WriteString(LSecao, 'InscricaoMunicipal', Servico.ItemServico.Items[I].DadosProfissionalParceiro.IdentificacaoParceiro.InscricaoMunicipal);
        AINIRec.WriteString(LSecao, 'RazaoSocial', Servico.ItemServico.Items[I].DadosProfissionalParceiro.RazaoSocial);
        AINIRec.WriteFloat(LSecao, 'PercentualProfissionalParceiro', Servico.ItemServico.Items[I].DadosProfissionalParceiro.PercentualProfissionalParceiro);

    end;
*)
procedure TNFSeIniWriter.GerarINIIBSCBS(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBSDPS);
begin
  LSecao := 'IBSCBSDPS';

  AINIRec.WriteString(LSecao, 'finNFSe', finNFSeToStr(IBSCBS.finNFSe));
  AINIRec.WriteString(LSecao, 'indFinal', indFinalToStr(IBSCBS.indFinal));
  AINIRec.WriteString(LSecao, 'cIndOp', IBSCBS.cIndOp);
  AINIRec.WriteString(LSecao, 'tpOper', tpOperGovNFSeToStr(IBSCBS.tpOper));
  AINIRec.WriteString(LSecao, 'tpEnteGov', tpEnteGovToStr(IBSCBS.tpEnteGov));
  AINIRec.WriteString(LSecao, 'indDest', indDestToStr(IBSCBS.indDest));

  PularLinha(AINIRec, LSecao);

  GerarINIgRefNFSe(AINIRec, IBSCBS.gRefNFSe);
  GerarINIDestinatario(AINIRec, IBSCBS.dest);
  GerarINIImovel(AINIRec, IBSCBS.imovel);
  GerarINIIBSCBSValores(AINIRec, IBSCBS.valores);
end;

procedure TNFSeIniWriter.GerarINIgRefNFSe(AINIRec: TMemIniFile;
  gRefNFSe: TgRefNFSeCollection);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'gRefNFSe', 99);

  for i := 0 to gRefNFSe.Count - 1 do
  begin
    LSecao := 'gRefNFSe' + IntToStrZero(i + 1, 2);

    AINIRec.WriteString(LSecao, 'refNFSe', gRefNFSe[i].refNFSe);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIDestinatario(AINIRec: TMemIniFile;
  Dest: TDadosdaPessoa);
begin
  LSecao := 'Destinatario';

  SecaoOpcional(AINIRec, LSecao, 'do Destinatário.');

  if (Dest.CNPJCPF <> '') or (Dest.NIF <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'CNPJCPF', Dest.CNPJCPF);
    AINIRec.WriteString(LSecao, 'NIF', Dest.NIF);
    AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(Dest.cNaoNIF));
    AINIRec.WriteString(LSecao, 'RazaoSocial', Dest.xNome);

    AINIRec.WriteInteger(LSecao, 'CodigoMunicipio', Dest.ender.endNac.cMun);
    AINIRec.WriteString(LSecao, 'CEP', Dest.ender.endNac.CEP);
    AINIRec.WriteInteger(LSecao, 'CodigoPais', Dest.ender.endExt.cPais);
    AINIRec.WriteString(LSecao, 'xMunicipio', Dest.ender.endExt.xCidade);
    AINIRec.WriteString(LSecao, 'UF', Dest.ender.UF);
    AINIRec.WriteString(LSecao, 'Logradouro', Dest.ender.xLgr);
    AINIRec.WriteString(LSecao, 'Numero', Dest.ender.nro);
    AINIRec.WriteString(LSecao, 'Complemento', Dest.ender.xCpl);
    AINIRec.WriteString(LSecao, 'Bairro', Dest.ender.xBairro);

    AINIRec.WriteString(LSecao, 'Telefone', Dest.fone);
    AINIRec.WriteString(LSecao, 'Email', Dest.email);

    // Incluido para atender o provedor SigISSWeb
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', Dest.IM);
    AINIRec.WriteString(LSecao, 'InscricaoMunicipal', Dest.IE);
    AINIRec.WriteString(LSecao, 'xPais', Dest.xPais);

    // Incluido para atender o provedor Publica
    AINIRec.WriteString(LSecao, 'TipoServico', Dest.TipoServico);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIImovel(AINIRec: TMemIniFile;
  Imovel: TDadosimovel);
begin
  LSecao := 'Imovel';

  SecaoOpcional(AINIRec, LSecao, 'do Imovel.');

  if (Imovel.inscImobFisc <> '') or (Imovel.cCIB <> '') or FpGerarSecaoOpcional then
  begin
    AINIRec.WriteString(LSecao, 'inscImobFisc', Imovel.inscImobFisc);
    AINIRec.WriteString(LSecao, 'cCIB', Imovel.cCIB);

    AINIRec.WriteString(LSecao, 'CEP', Imovel.ender.CEP);
    AINIRec.WriteString(LSecao, 'Logradouro', Imovel.ender.xLgr);
    AINIRec.WriteString(LSecao, 'Numero', Imovel.ender.nro);
    AINIRec.WriteString(LSecao, 'Complemento', Imovel.ender.xCpl);
    AINIRec.WriteString(LSecao, 'Bairro', Imovel.ender.xBairro);

    AINIRec.WriteString(LSecao, 'cEndPost', Imovel.ender.endExt.cEndPost);
    AINIRec.WriteString(LSecao, 'xCidade', Imovel.ender.endExt.xCidade);
    AINIRec.WriteString(LSecao, 'xEstProvReg', Imovel.ender.endExt.xEstProvReg);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINIIBSCBSValores(AINIRec: TMemIniFile;
  Valores: Tvalorestrib);
begin
  GerarINIDocumentos(AINIRec, Valores.gReeRepRes.documentos);
  GerarINITributacao(AINIRec, Valores.trib);
end;

procedure TNFSeIniWriter.GerarINIDocumentos(AINIRec: TMemIniFile;
  Documentos: TdocumentosCollection);
var
  i: Integer;
begin
  IndicesdeLista(AINIRec, 'Documentos', 1000);

  for i := 0 to Documentos.Count - 1 do
  begin
    LSecao := 'Documentos' + IntToStrZero(i + 1, 4);

    AINIRec.WriteString(LSecao, 'tipoChaveDFe', tipoChaveDFeToStr(Documentos[i].dFeNacional.tipoChaveDFe));
    AINIRec.WriteString(LSecao, 'chaveDFe', Documentos[i].dFeNacional.chaveDFe);

    AINIRec.WriteInteger(LSecao, 'cMunDocFiscal', Documentos[i].docFiscalOutro.cMunDocFiscal);
    AINIRec.WriteString(LSecao, 'nDocFiscal', Documentos[i].docFiscalOutro.nDocFiscal);
    AINIRec.WriteString(LSecao, 'xDocFiscal', Documentos[i].docFiscalOutro.xDocFiscal);

    AINIRec.WriteString(LSecao, 'nDoc', Documentos[i].docOutro.nDoc);
    AINIRec.WriteString(LSecao, 'xDoc', Documentos[i].docOutro.xDoc);

    AINIRec.WriteString(LSecao, 'CNPJCPF', Documentos[i].fornec.CNPJCPF);
    AINIRec.WriteString(LSecao, 'NIF', Documentos[i].fornec.NIF);
    AINIRec.WriteString(LSecao, 'cNaoNIF', NaoNIFToStr(Documentos[i].fornec.cNaoNIF));
    AINIRec.WriteString(LSecao, 'xNome', Documentos[i].fornec.xNome);

    AINIRec.WriteString(LSecao, 'dtEmiDoc', DateToStr(Documentos[i].dtEmiDoc));
    AINIRec.WriteString(LSecao, 'dtCompDoc', DateToStr(Documentos[i].dtCompDoc));
    AINIRec.WriteString(LSecao, 'tpReeRepRes', tpReeRepResToStr(Documentos[i].tpReeRepRes));
    AINIRec.WriteString(LSecao, 'xTpReeRepRes', Documentos[i].xTpReeRepRes);
    AINIRec.WriteFloat(LSecao, 'vlrReeRepRes', Documentos[i].vlrReeRepRes);

    PularLinha(AINIRec, LSecao);
  end;
end;

procedure TNFSeIniWriter.GerarINITributacao(AINIRec: TMemIniFile;
  Tributacao: Ttrib);
begin
  GerarINIgIBSCBS(AINIRec, Tributacao.gIBSCBS);
end;

procedure TNFSeIniWriter.GerarINIgIBSCBS(AINIRec: TMemIniFile;
  gIBSCBS: TgIBSCBS);
begin
  LSecao := 'gIBSCBS';

  AINIRec.WriteString(LSecao, 'CST', CSTIBSCBSToStr(gIBSCBS.CST));
  AINIRec.WriteString(LSecao, 'cClassTrib', gIBSCBS.cClassTrib);
  AINIRec.WriteString(LSecao, 'cCredPres', cCredPresToStr(gIBSCBS.cCredPres));

  PularLinha(AINIRec, LSecao);

  GerarINIgTribRegular(AINIRec, gIBSCBS.gTribRegular);
  GerarINIgDif(AINIRec, gIBSCBS.gDif);
end;

procedure TNFSeIniWriter.GerarINIgTribRegular(AINIRec: TMemIniFile;
  gTribRegular: TgTribRegular);
begin
  LSecao := 'gTribRegular';

  AINIRec.WriteString(LSecao, 'CSTReg', CSTIBSCBSToStr(gTribRegular.CSTReg));
  AINIRec.WriteString(LSecao, 'cClassTribReg', gTribRegular.cClassTribReg);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIgDif(AINIRec: TMemIniFile; gDif: TgDif);
begin
  LSecao := 'gDif';

  AINIRec.WriteFloat(LSecao, 'pDifUF', gDif.pDifUF);
  AINIRec.WriteFloat(LSecao, 'pDifMun', gDif.pDifMun);
  AINIRec.WriteFloat(LSecao, 'pDifCBS', gDif.pDifCBS);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIIBSCBSNFSe(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBSNfse);
begin
  LSecao := 'IBSCBSNFSE';

  AINIRec.WriteInteger(LSecao, 'cLocalidadeIncid', IBSCBS.cLocalidadeIncid);
  AINIRec.WriteString(LSecao, 'xLocalidadeIncid', IBSCBS.xLocalidadeIncid);
  AINIRec.WriteFloat(LSecao, 'pRedutor', IBSCBS.pRedutor);

  PularLinha(AINIRec, LSecao);

  GerarINIIBSCBSValoresNFSe(AINIRec, IBSCBS.valores);
  GerarINITotCIBS(AINIRec, IBSCBS.totCIBS);
end;

procedure TNFSeIniWriter.GerarINIIBSCBSValoresNFSe(AINIRec: TMemIniFile;
  Valores: TvaloresIBSCBS);
begin
  LSecao := 'IBSCBSValoresNFSE';

  AINIRec.WriteFloat(LSecao, 'vBC', Valores.vBC);
  AINIRec.WriteFloat(LSecao, 'vCalcReeRepRes', Valores.vCalcReeRepRes);

  AINIRec.WriteFloat(LSecao, 'pIBSUF', Valores.uf.pIBSUF);
  AINIRec.WriteFloat(LSecao, 'pRedAliqUF', Valores.uf.pRedAliqUF);
  AINIRec.WriteFloat(LSecao, 'pAliqEfetUF', Valores.uf.pAliqEfetUF);

  AINIRec.WriteFloat(LSecao, 'pIBSMun', Valores.mun.pIBSMun);
  AINIRec.WriteFloat(LSecao, 'pRedAliqMun', Valores.mun.pRedAliqMun);
  AINIRec.WriteFloat(LSecao, 'pAliqEfetMun', Valores.mun.pAliqEfetMun);

  AINIRec.WriteFloat(LSecao, 'pCBS', Valores.Fed.pCBS);
  AINIRec.WriteFloat(LSecao, 'pRedAliqCBS', Valores.Fed.pRedAliqCBS);
  AINIRec.WriteFloat(LSecao, 'pAliqEfetCBS', Valores.Fed.pAliqEfetCBS);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINITotCIBS(AINIRec: TMemIniFile;
  TotCIBS: TTotCIBS);
begin
  LSecao := 'TotCIBS';

  AINIRec.WriteFloat(LSecao, 'vTotNF', TotCIBS.vTotNF);

  GerarINIgTribRegularNFSe(AINIRec, TotCIBS.gTribRegular);
  GerarINIgTribCompraGov(AINIRec, TotCIBS.gTribCompraGov);
  GerarINITotgIBS(AINIRec, TotCIBS.gIBS);
  GerarINITotgCBS(AINIRec, TotCIBS.gCBS);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIgTribRegularNFSe(AINIRec: TMemIniFile;
  gTribRegularNFSe: TgTribRegularNFSe);
begin
  LSecao := 'gTribRegularNFSe';

  AINIRec.WriteFloat(LSecao, 'pAliqEfeRegIBSUF', gTribRegularNFSe.pAliqEfeRegIBSUF);
  AINIRec.WriteFloat(LSecao, 'vTribRegIBSUF', gTribRegularNFSe.vTribRegIBSUF);
  AINIRec.WriteFloat(LSecao, 'pAliqEfeRegIBSMun', gTribRegularNFSe.pAliqEfeRegIBSMun);
  AINIRec.WriteFloat(LSecao, 'vTribRegIBSMun', gTribRegularNFSe.vTribRegIBSMun);
  AINIRec.WriteFloat(LSecao, 'pAliqEfeRegCBS', gTribRegularNFSe.pAliqEfeRegCBS);
  AINIRec.WriteFloat(LSecao, 'vTribRegCBS', gTribRegularNFSe.vTribRegCBS);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINIgTribCompraGov(AINIRec: TMemIniFile;
  gTribCompraGov: TgTribCompraGov);
begin
  LSecao := 'gTribCompraGov';

  AINIRec.WriteFloat(LSecao, 'pIBSUF', gTribCompraGov.pIBSUF);
  AINIRec.WriteFloat(LSecao, 'vIBSUF', gTribCompraGov.vIBSUF);
  AINIRec.WriteFloat(LSecao, 'pIBSMun', gTribCompraGov.pIBSMun);
  AINIRec.WriteFloat(LSecao, 'vIBSMun', gTribCompraGov.vIBSMun);
  AINIRec.WriteFloat(LSecao, 'pCBS', gTribCompraGov.pCBS);
  AINIRec.WriteFloat(LSecao, 'vCBS', gTribCompraGov.vCBS);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINITotgIBS(AINIRec: TMemIniFile;
  TotgIBS: TgIBS);
begin
  LSecao := 'TotgIBS';

  AINIRec.WriteFloat(LSecao, 'vIBSTot', TotgIBS.vIBSTot);

  AINIRec.WriteFloat(LSecao, 'pCredPresIBS', TotgIBS.gIBSCredPres.pCredPresIBS);
  AINIRec.WriteFloat(LSecao, 'vCredPresIBS', TotgIBS.gIBSCredPres.vCredPresIBS);

  AINIRec.WriteFloat(LSecao, 'vDifUF', TotgIBS.gIBSUFTot.vDifUF);
  AINIRec.WriteFloat(LSecao, 'vIBSUF', TotgIBS.gIBSUFTot.vIBSUF);

  AINIRec.WriteFloat(LSecao, 'vDifMun', TotgIBS.gIBSMunTot.vDifMun);
  AINIRec.WriteFloat(LSecao, 'vIBSMun', TotgIBS.gIBSMunTot.vIBSMun);

  PularLinha(AINIRec, LSecao);
end;

procedure TNFSeIniWriter.GerarINITotgCBS(AINIRec: TMemIniFile;
  TotgCBS: TgCBS);
begin
  LSecao := 'TotgCBS';

  AINIRec.WriteFloat(LSecao, 'vDifCBS', TotgCBS.vDifCBS);
  AINIRec.WriteFloat(LSecao, 'vCBS', TotgCBS.vCBS);

  AINIRec.WriteFloat(LSecao, 'pCredPresCBS', TotgCBS.gCBSCredPres.pCredPresCBS);
  AINIRec.WriteFloat(LSecao, 'vCredPresCBS', TotgCBS.gCBSCredPres.vCredPresCBS);

  PularLinha(AINIRec, LSecao);
end;

end.
