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

unit ACBrNFSeX.LerIni;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXLerXml,
  ACBrNFSeXConversao,
  ACBrNFSeXInterface;

type
  { TNFSeIniReader }

  TNFSeIniReader = class(TNFSeRClass)
  private
    FNFSe: TNFSe;
//    FVersaoDF: TVersaoNFSe;
//    FAmbiente: Integer;
//    FtpEmis: Integer;
//    FIniParams: TMemIniFile;

    procedure LerINIIdentificacaoNFSe(AINIRec: TMemIniFile);
    procedure LerINIIdentificacaoRps(AINIRec: TMemIniFile);
    procedure LerININFSeSubstituicao(AINIRec: TMemIniFile);
    procedure LerINIRpsSubstituido(AINIRec: TMemIniFile);
    procedure LerINIDadosEmitente(AINIRec: TMemIniFile);
    procedure LerINIValoresNFSe(AINIRec: TMemIniFile);

    procedure LerININFSeCancelamento(AINIRec: TMemIniFile);
    procedure LerINIDadosPrestador(AINIRec: TMemIniFile);
    procedure LerINIDadosTomador(AINIRec: TMemIniFile);
    procedure LerINIDadosIntermediario(AINIRec: TMemIniFile);
    procedure LerINIConstrucaoCivil(AINIRec: TMemIniFile);
    procedure LerINIDadosServico(AINIRec: TMemIniFile);
    procedure LerINIQuartos(AINIRec: TMemIniFile);
    procedure LerINIDespesas(AINIRec: TMemIniFile);
    procedure LerINIGenericos(AINIRec: TMemIniFile);
    procedure LerINIItens(AINIRec: TMemIniFile);
    procedure LerINIDadosDeducao(AINIRec: TMemIniFile);
    procedure LerINIComercioExterior(AINIRec: TMemIniFile);
    procedure LerINILocacaoSubLocacao(AINIRec: TMemIniFile);
    procedure LerINIEvento(AINIRec: TMemIniFile);
    procedure LerINIRodoviaria(AINIRec: TMemIniFile);
    procedure LerINIInformacoesComplementares(AINIRec: TMemIniFile);
    procedure LerINIInformacoesComplementaresgItemPed(AINIRec: TMemINIFile);
    procedure LerINIValores(AINIRec: TMemIniFile);
    procedure LerINIImpostos(AINIRec: TMemIniFile);
    procedure LerINIDocumentosDeducoes(AINIRec: TMemIniFile);
    procedure LerINIDocumentosDeducoesFornecedor(AINIRec: TMemIniFile;
      fornec: TInfoPessoa; Indice: Integer);
    procedure LerINIValoresTribMun(AINIRec: TMemIniFile);
    procedure LerINIValoresTribFederal(AINIRec: TMemIniFile);
    procedure LerINIValoresTotalTrib(AINIRec: TMemIniFile);
    procedure LerINIOrgaoGerador(AINIRec: TMemIniFile);
    procedure LerINICondicaoPagamento(AINIRec: TMemIniFile);
    procedure LerINIParcelas(AINIRec: TMemIniFile);
    procedure LerINIEmail(AINIRec: TMemIniFile);
    procedure LerINITransportadora(AINIRec: TMemIniFile);

    // Reforma Tributária DPS
    procedure LerINIIBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBSDPS);
    procedure LerINIgRefNFSe(AINIRec: TMemIniFile; gRefNFSe: TgRefNFSeCollection);
    procedure LerINIDestinatario(AINIRec: TMemIniFile; Dest: TDadosdaPessoa);
    procedure LerINIImovel(AINIRec: TMemIniFile; Imovel: TDadosimovel);
    procedure LerINIIBSCBSValores(AINIRec: TMemIniFile; Valores: Tvalorestrib);
    procedure LerINIDocumentos(AINIRec: TMemIniFile; Documentos: TdocumentosCollection);
    procedure LerINITributacao(AINIRec: TMemIniFile; Tributacao: Ttrib);
    procedure LerINIgIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS);
    procedure LerINIgTribRegular(AINIRec: TMemIniFile; gTribRegular: TgTribRegular);
    procedure LerINIgDif(AINIRec: TMemIniFile; gDif: TgDif);
    // Reforma Tributária NFSe
    procedure LerINIIBSCBSNFSe(AINIRec: TMemIniFile; IBSCBS: TIBSCBSNfse);
    procedure LerINIIBSCBSValoresNFSe(AINIRec: TMemIniFile; Valores: TvaloresIBSCBS);
    procedure LerINITotCIBS(AINIRec: TMemIniFile; TotCIBS: TTotCIBS);
    procedure LerINIgTribRegularNFSe(AINIRec: TMemIniFile; gTribRegularNFSe: TgTribRegularNFSe);
    procedure LerINIgTribCompraGov(AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov);
    procedure LerINITotgIBS(AINIRec: TMemIniFile; TotgIBS: TgIBS);
    procedure LerINITotgCBS(AINIRec: TMemIniFile; TotgCBS: TgCBS);

    procedure LerIniRps(AINIRec: TMemIniFile);
    procedure LerIniNfse(AINIRec: TMemIniFile);
  protected
    FpAOwner: IACBrNFSeXProvider;
  public
    constructor Create(AOwner: TNFSe; AIOwner: IACBrNFSeXProvider); reintroduce;
    destructor Destroy; override;

    function LerArquivoIni(const AIniString: string): Boolean;

    property NFSe: TNFSe read FNFSe write FNFSe;
//    property VersaoDF: TVersaoNFSe read FVersaoDF write FVersaoDF;
//    property Ambiente: Integer read FAmbiente write FAmbiente;
//    property tpEmis: Integer read FtpEmis write FtpEmis;
//    property IniParams: TMemIniFile read FIniParams write FIniParams;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

{ TNFSeIniReader }

constructor TNFSeIniReader.Create(AOwner: TNFSe; AIOwner: IACBrNFSeXProvider);
begin
  FpAOwner := AIOwner;
  FNFSe := AOwner;
end;

destructor TNFSeIniReader.Destroy;
begin

  inherited;
end;

function TNFSeIniReader.LerArquivoIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
  TipoXML: string;
begin
  INIRec := TMemIniFile.Create('');

  // Usar o FpAOwner em vez de  FProvider

  try
    LerIniArquivoOuString(AIniString, INIRec);

    TipoXML := INIRec.ReadString('IdentificacaoNFSe', 'TipoXML', '');

    if (TipoXML = '') or (TipoXML = 'RPS') then
      LerIniRps(INIRec)
    else
      LerIniNfse(INIRec);

  finally
    INIRec.Free;
  end;

  Result := True;
end;

procedure TNFSeIniReader.LerIniRps(AINIRec: TMemIniFile);
begin
  NFSe.tpXML := txmlRPS;

  LerINIIdentificacaoNFSe(AINIRec);
  LerINIDadosEmitente(AINIRec);
  LerINIIdentificacaoRps(AINIRec);
  LerININFSeSubstituicao(AINIRec);
  LerINIRpsSubstituido(AINIRec);
  LerINIDadosPrestador(AINIRec);
  LerINIDadosTomador(AINIRec);
  LerINIDadosIntermediario(AINIRec);
  LerINIDadosServico(AINIRec);
  LerINIQuartos(AINIRec);
  LerINIDespesas(AINIRec);
  LerINIGenericos(AINIRec);
  LerINIItens(AINIRec);
  LerINIComercioExterior(AINIRec);
  LerINILocacaoSubLocacao(AINIRec);
  LerINIConstrucaoCivil(AINIRec);
  LerINIEvento(AINIRec);
  LerINIRodoviaria(AINIRec);
  LerINIInformacoesComplementares(AINIRec);
  LerINIInformacoesComplementaresgItemPed(AINIRec);
  LerINIValores(AINIRec);
  LerINIDadosDeducao(AINIRec);
  LerINIImpostos(AINIRec);
  LerINIDocumentosDeducoes(AINIRec);
  LerINIValoresTribMun(AINIRec);
  LerINIValoresTribFederal(AINIRec);
  LerINIValoresTotalTrib(AINIRec);
  LerINIOrgaoGerador(AINIRec);
  LerINICondicaoPagamento(AINIRec);
  LerINIParcelas(AINIRec);
  LerINIEmail(AINIRec);
  LerINITransportadora(AINIRec);

  // Reforma Tributária
  LerINIIBSCBS(AINIRec, NFSe.IBSCBS);
end;

procedure TNFSeIniReader.LerIniNfse(AINIRec: TMemIniFile);
begin
  NFSe.tpXML := txmlNFSe;

  LerINIIdentificacaoNFSe(AINIRec);
  LerINIDadosEmitente(AINIRec);
  LerINIValoresNFSe(AINIRec);
  // Informações sobre o DPS
  LerINIIdentificacaoRps(AINIRec);
  LerININFSeSubstituicao(AINIRec);
  LerINIRpsSubstituido(AINIRec);
  LerININFSeCancelamento(AINIRec);
  LerINIDadosPrestador(AINIRec);
  LerINIDadosTomador(AINIRec);
  LerINIDadosIntermediario(AINIRec);
  LerINIDadosServico(AINIRec);
  LerINIQuartos(AINIRec);
  LerINIDespesas(AINIRec);
  LerINIGenericos(AINIRec);
  LerINIItens(AINIRec);
  LerINIComercioExterior(AINIRec);
  LerINILocacaoSubLocacao(AINIRec);
  LerINIConstrucaoCivil(AINIRec);
  LerINIEvento(AINIRec);
  LerINIRodoviaria(AINIRec);
  LerINIInformacoesComplementares(AINIRec);
  LerINIInformacoesComplementaresgItemPed(AINIRec);
  LerINIValores(AINIRec);
  LerINIDadosDeducao(AINIRec);
  LerINIImpostos(AINIRec);
  LerINIDocumentosDeducoes(AINIRec);
  LerINIValoresTribMun(AINIRec);
  LerINIValoresTribFederal(AINIRec);
  LerINIValoresTotalTrib(AINIRec);
  LerINIOrgaoGerador(AINIRec);
  LerINICondicaoPagamento(AINIRec);
  LerINIParcelas(AINIRec);
  LerINIEmail(AINIRec);
  LerINITransportadora(AINIRec);

  // Reforma Tributária
  LerINIIBSCBS(AINIRec, NFSe.IBSCBS);

  LerINIIBSCBSNFSe(AINIRec, NFSe.infNFSe.IBSCBS);

  if NFSe.Servico.Valores.BaseCalculo = 0 then
    NFSe.Servico.Valores.BaseCalculo := NFSe.infNFSe.valores.BaseCalculo;
//        BaseCalculo := ValorServicos - ValorDeducoes - DescontoIncondicionado;

  if NFSe.Servico.Valores.RetencoesFederais = 0 then
  begin
    case NFSe.Servico.Valores.tribFed.tpRetPisCofins of
      trpiscofinscsllNaoRetido:  // tpRetPisCofins = 0
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr;

      trpiscofinscsllRetido:  // tpRetPisCofins = 3
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorPis +
          NFSe.Servico.Valores.ValorCofins + NFSe.Servico.Valores.ValorCsll;

      trpiscofinsRetidocsllNaoRetido:   // tpRetPisCofins = 4
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorPis +
          NFSe.Servico.Valores.ValorCofins;

      trPisRetidoCofinsCsllNaoRetido:  // tpRetPisCofins = 5
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorPis;

      trCofinsRetidoPisCsllNaoRetido:  // tpRetPisCofins = 6
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorCofins;

      trCofinsCsllRetidoPisNaoRetido:  // tpRetPisCofins = 7
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorCofins +
          NFSe.Servico.Valores.ValorCsll;

      trCsllRetidoPisCofinsNaoRetido:  // tpRetPisCofins = 8
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorCsll;

      trPisCsllRetidoCofinsNaoRetido:  // tpRetPisCofins = 9
        NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
          NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorPis +
          NFSe.Servico.Valores.ValorCsll;
    else
      NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorInss +
        NFSe.Servico.Valores.ValorIr + NFSe.Servico.Valores.ValorPis +
        NFSe.Servico.Valores.ValorCofins + NFSe.Servico.Valores.ValorCsll;
    end;
  end;

  if NFSe.Servico.Valores.ValorLiquidoNfse = 0 then
    NFSe.Servico.Valores.ValorLiquidoNfse := NFSe.Servico.Valores.ValorServicos -
      NFSe.Servico.Valores.RetencoesFederais - NFSe.Servico.Valores.OutrasRetencoes -
      NFSe.Servico.Valores.ValorIssRetido - NFSe.Servico.Valores.DescontoIncondicionado -
      NFSe.Servico.Valores.DescontoCondicionado;

  if NFSe.Servico.Valores.ValorTotalNotaFiscal = 0 then
    NFSe.Servico.Valores.ValorTotalNotaFiscal := NFSe.Servico.Valores.ValorServicos -
      NFSe.Servico.Valores.DescontoCondicionado - NFSe.Servico.Valores.DescontoIncondicionado;

  NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.RetencoesFederais -
                                            NFSe.Servico.Valores.ValorIssRetido;
end;

procedure TNFSeIniReader.LerINIIdentificacaoNFSe(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'IdentificacaoNFSe';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    if NFSe.tpXML = txmlNFSe then
    begin
      NFSe.infNFSe.ID := AINIRec.ReadString(sSecao, 'Id', '');
      NFSe.infNFSe.xLocEmi := AINIRec.ReadString(sSecao, 'xLocEmi', '');
      NFSe.infNFSe.xLocPrestacao := AINIRec.ReadString(sSecao, 'xLocPrestacao', '');
      NFSe.infNFSe.nNFSe := AINIRec.ReadString(sSecao, 'nNFSe', '');
      NFSe.infNFSe.cLocIncid := AINIRec.ReadInteger(sSecao, 'cLocIncid', 0);
      NFSe.infNFSe.xLocIncid := AINIRec.ReadString(sSecao, 'xLocIncid', '');
      NFSe.infNFSe.xTribNac := AINIRec.ReadString(sSecao, 'xTribNac', '');
      NFSe.infNFSe.xTribMun := AINIRec.ReadString(sSecao, 'xTribMun', '');
      NFSe.infNFSe.xNBS := AINIRec.ReadString(sSecao, 'xNBS', '');
      NFSe.infNFSe.verAplic := AINIRec.ReadString(sSecao, 'verAplic', '');
      NFSe.infNFSe.ambGer := StrToambGer(Ok, AINIRec.ReadString(sSecao, 'ambGer', ''));
      NFSe.infNFSe.tpEmis := StrTotpEmis(Ok, AINIRec.ReadString(sSecao, 'tpEmis', ''));
      NFSe.infNFSe.procEmi := StrToprocEmis(Ok, AINIRec.ReadString(sSecao, 'procEmi', ''));
      NFSe.infNFSe.cStat := AINIRec.ReadInteger(sSecao, 'cStat', 0);
      NFSe.infNFSe.dhProc := StringToDateTimeDef(AINIRec.ReadString(sSecao, 'dhProc', ''), 0);
      NFSe.infNFSe.nDFSe := AINIRec.ReadString(sSecao, 'nDFSe', '');

      NFSe.Servico.MunicipioIncidencia := NFSe.infNFSe.cLocIncid;
      NFSe.Servico.xMunicipioIncidencia := NFSe.infNFSe.xLocIncid;

      NFSe.Numero := NFSe.infNFSe.nNFSe;
      NFSe.CodigoVerificacao := NFSe.infNFSe.ID;
    end;
  end;
end;

procedure TNFSeIniReader.LerINIIdentificacaoRps(AINIRec: TMemIniFile);
var
  sSecao, sCampo: string;
  Ok: Boolean;
begin
  sSecao := 'IdentificacaoRps';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.IdentificacaoRps.Numero := AINIRec.ReadString(sSecao, 'Numero', '0');
    NFSe.IdentificacaoRps.Serie := AINIRec.ReadString(sSecao, 'Serie', '0');
    NFSe.IdentificacaoRps.Tipo := FPAOwner.StrToTipoRPS(Ok, AINIRec.ReadString(sSecao, 'Tipo', ''));

    sCampo := AINIRec.ReadString(sSecao, 'DataEmissao', '');
    if sCampo = '' then
      sCampo := AINIRec.ReadString(sSecao, 'DataEmissaoRPS', '');

    if sCampo <> '' then
    begin
      NFSe.DataEmissao := StringToDateTimeDef(sCampo, 0);
      NFSe.DataEmissaoRps := NFSe.DataEmissao;
    end;

    sCampo := AINIRec.ReadString(sSecao, 'Competencia', '');
    if sCampo <> '' then
      NFSe.Competencia := StringToDateTimeDef(sCampo, 0);

    NFSe.verAplic := AINIRec.ReadString(sSecao, 'verAplic', 'ACBrNFSeX-1.00');
    NFSe.tpEmit := StrTotpEmit(Ok, AINIRec.ReadString(sSecao, 'tpEmit', '1'));
    NFSe.cLocEmi := AINIRec.ReadString(sSecao, 'cLocEmi', '');
    NFSe.cMotivoEmisTI := StrTocMotivoEmisTI(AINIRec.ReadString(sSecao, 'cMotivoEmisTI', ''));
    NFSe.NaturezaOperacao := StrToNaturezaOperacao(Ok, AINIRec.ReadString(sSecao, 'NaturezaOperacao', ''));
    NFSe.StatusRps := FpAOwner.StrToStatusRPS(Ok, AINIRec.ReadString(sSecao, 'Status', ''));
    NFSe.TipoRecolhimento := AINIRec.ReadString(sSecao, 'TipoRecolhimento', '');
    NFSe.OutrasInformacoes := StringReplace(AINIRec.ReadString(sSecao, 'OutrasInformacoes', ''), FpAOwner.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]) ;
    NFSe.InformacoesComplementares := AINIRec.ReadString(sSecao, 'InformacoesComplementares', '');
    NFSe.PercentualCargaTributaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'PercentualCargaTributaria', ''), 0);
    NFSe.ValorCargaTributaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCargaTributaria', ''), 0);
    NFSe.PercentualCargaTributariaMunicipal := StringToFloatDef(AINIRec.ReadString(sSecao, 'PercentualCargaTributariaMunicipal', ''), 0);
    NFSe.ValorCargaTributariaMunicipal := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCargaTributariaMunicipal', ''), 0);
    NFSe.PercentualCargaTributariaEstadual := StringToFloatDef(AINIRec.ReadString(sSecao, 'PercentualCargaTributariaEstadual', ''), 0);
    NFSe.ValorCargaTributariaEstadual := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCargaTributariaEstadual', ''), 0);
    NFSe.TipoNota := AINIRec.ReadInteger(sSecao, 'TipoNota', 0);
    NFSe.SiglaUF := AINIRec.ReadString(sSecao, 'SiglaUF', '');
    NFSe.EspecieDocumento := AINIRec.ReadInteger(sSecao, 'EspecieDocumento', 0);
    NFSe.SerieTalonario := AINIRec.ReadInteger(sSecao, 'SerieTalonario', 0);
    NFSe.FormaPagamento := AINIRec.ReadInteger(sSecao, 'FormaPagamento', 0);
    NFSe.NumeroParcelas := AINIRec.ReadInteger(sSecao, 'NumeroParcelas', 0);

    sCampo := AINIRec.ReadString(sSecao, 'DataPagamento', '');
    if sCampo <> '' then
      NFSe.DataPagamento := StringToDateTimeDef(sCampo, 0);

    // Provedor Infisc e SigISS
    NFSe.id_sis_legado := AINIRec.ReadInteger(sSecao, 'id_sis_legado', 0);

    // Provedor AssessorPublico
    NFSe.Situacao := AINIRec.ReadInteger(sSecao, 'Situacao', 0);

    sCampo := AINIRec.ReadString(sSecao, 'Vencimento', '');
    if sCampo <> '' then
      NFSe.Vencimento := StringToDateTimeDef(sCampo, 0);

    NFSe.SituacaoTrib := FpAOwner.StrToSituacaoTrib(Ok, AINIRec.ReadString(sSecao, 'SituacaoTrib', 'tp'));

    //Provedores CTA, ISSBarueri, ISSSDSF, ISSSaoPaulo, Simple e SmarAPD.
    sCampo := AINIRec.ReadString(sSecao, 'TipoTributacaoRPS', '');
    if sCampo <> '' then
      NFSe.TipoTributacaoRPS := FpAOwner.StrToTipoTributacaoRPS(Ok, sCampo);

    NFSe.Producao := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'Producao', '1'));

    // Provedores: Infisc, ISSDSF e Siat
    NFSe.SeriePrestacao := AINIRec.ReadString(sSecao, 'SeriePrestacao', '');

    NFSe.IdentificacaoRemessa := AINIRec.ReadString(sSecao, 'IdentificacaoRemessa', '');

    sCampo := AINIRec.ReadString(sSecao, 'dhRecebimento', '');
    if sCampo <> '' then
      NFSe.dhRecebimento := StringToDateTimeDef(sCampo, 0);

    sCampo := AINIRec.ReadString(sSecao, 'DataFatoGerador', '');
    if sCampo <> '' then
      NFSe.DataFatoGerador := StringToDateTimeDef(sCampo, 0);

    // Provedor Governa
    NFSe.RegRec := StrToRegRec(Ok, AINIRec.ReadString(sSecao, 'RegRec', ''));
    NFSe.EqptoRecibo := AINIRec.ReadString(sSecao, 'EqptoRecibo', '');
    // Provedor Governa e Prescon
    NFSe.FrmRec := StrToFrmRec(Ok, AINIRec.ReadString(sSecao, 'FrmRec', ''));

    // Provedor Prescon
    NFSe.DeducaoMateriais := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'DeducaoMateriais', ''));
  end;
end;

procedure TNFSeIniReader.LerININFSeSubstituicao(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'NFSeSubstituicao';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.subst.chSubstda := AINIRec.ReadString(sSecao, 'chSubstda', '');
    NFSe.subst.cMotivo := StrTocMotivo(Ok, AINIRec.ReadString(sSecao, 'cMotivo', ''));
    NFSe.subst.xMotivo := AINIRec.ReadString(sSecao, 'xMotivo', '');
  end;
end;

procedure TNFSeIniReader.LerINIRpsSubstituido(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'RpsSubstituido';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.RpsSubstituido.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.RpsSubstituido.Serie := AINIRec.ReadString(sSecao, 'Serie', '');
    NFSe.RpsSubstituido.Tipo := FpAOwner.StrToTipoRPS(Ok, AINIRec.ReadString(sSecao, 'Tipo', ''));
  end;
end;

procedure TNFSeIniReader.LerINIDadosEmitente(AINIRec: TMemIniFile);
var
  sSecao: string;
  xUF: string;
begin
  sSecao := 'Emitente'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.infNFSe.emit.Identificacao.CpfCnpj := AINIRec.ReadString(sSecao, 'CNPJCPF', AINIRec.ReadString(sSecao, 'CNPJ', ''));
    NFSe.infNFSe.emit.Identificacao.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');

    NFSe.infNFSe.emit.RazaoSocial := AINIRec.ReadString(sSecao, 'RazaoSocial', '');
    NFSe.infNFSe.emit.NomeFantasia := AINIRec.ReadString(sSecao, 'NomeFantasia', '');

    NFSe.infNFSe.emit.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.infNFSe.emit.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.infNFSe.emit.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.infNFSe.emit.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.infNFSe.emit.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.infNFSe.emit.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.infNFSe.emit.Endereco.xMunicipio := ObterNomeMunicipioUF(StrToIntDef(NFSe.infNFSe.emit.Endereco.CodigoMunicipio, 0), xUF);
    NFSe.infNFSe.emit.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');

    NFSe.infNFSe.emit.Contato.Telefone := AINIRec.ReadString(sSecao, 'Telefone', '');
    NFSe.infNFSe.emit.Contato.Email := AINIRec.ReadString(sSecao, 'Email', '');

    NFSe.Prestador.IdentificacaoPrestador.CpfCnpj := NFSe.infNFSe.emit.Identificacao.CpfCnpj;
    NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal := NFSe.infNFSe.emit.Identificacao.InscricaoMunicipal;

    NFSe.Prestador.RazaoSocial := NFSe.infNFSe.emit.RazaoSocial;
    NFSe.Prestador.NomeFantasia := NFSe.infNFSe.emit.NomeFantasia;

    NFSe.Prestador.Endereco.Endereco := NFSe.infNFSe.emit.Endereco.Endereco;
    NFSe.Prestador.Endereco.Numero := NFSe.infNFSe.emit.Endereco.Numero;
    NFSe.Prestador.Endereco.Complemento := NFSe.infNFSe.emit.Endereco.Complemento;
    NFSe.Prestador.Endereco.Bairro := NFSe.infNFSe.emit.Endereco.Bairro;
    NFSe.Prestador.Endereco.UF := NFSe.infNFSe.emit.Endereco.UF;
    NFSe.Prestador.Endereco.CEP := NFSe.infNFSe.emit.Endereco.CEP;
    NFSe.Prestador.Endereco.CodigoMunicipio := NFSe.infNFSe.emit.Endereco.CodigoMunicipio;
    NFSe.Prestador.Endereco.xMunicipio := NFSe.infNFSe.emit.Endereco.xMunicipio;

    NFSe.Prestador.Contato.Telefone := NFSe.infNFSe.emit.Contato.Telefone;
    NFSe.Prestador.Contato.Email := NFSe.infNFSe.emit.Contato.Email;
  end;
end;

procedure TNFSeIniReader.LerINIValoresNFSe(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'ValoresNFSe';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.infNFSe.valores.vCalcDR := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCalcDR', ''), 0);
    NFSe.infNFSe.valores.tpBM := AINIRec.ReadString(sSecao, 'tpBM', '');
    NFSe.infNFSe.valores.vCalcBM := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCalcBM', ''), 0);
    NFSe.infNFSe.valores.BaseCalculo := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBC', ''), 0);
    NFSe.infNFSe.valores.Aliquota := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqAplic', ''), 0);
    NFSe.infNFSe.valores.ValorIss := StringToFloatDef(AINIRec.ReadString(sSecao, 'vISSQN', ''), 0);
    NFSe.infNFSe.valores.vTotalRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotalRet', ''), 0);
    NFSe.infNFSe.valores.ValorLiquidoNfse := StringToFloatDef(AINIRec.ReadString(sSecao, 'vLiq', ''), 0);
    NFSe.OutrasInformacoes := AINIRec.ReadString(sSecao, 'xOutInf', '');

    NFSe.Servico.Valores.BaseCalculo := NFSe.infNFSe.valores.BaseCalculo;
    NFSe.Servico.Valores.Aliquota := NFSe.infNFSe.valores.Aliquota;
    NFSe.Servico.Valores.ValorIss := NFSe.infNFSe.valores.ValorIss;
    NFSe.Servico.Valores.ValorIssRetido := NFSe.infNFSe.valores.ValorIss;
    NFSe.Servico.Valores.RetencoesFederais := NFSe.infNFSe.valores.vTotalRet;
    NFSe.Servico.Valores.ValorLiquidoNfse := NFSe.infNFSe.valores.ValorLiquidoNfse;
  end;
end;

procedure TNFSeIniReader.LerININFSeCancelamento(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'NFSeCancelamento'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.Numero := AINIRec.ReadString(sSecao, 'NumeroNFSe', '');
    NFSe.NfseCancelamento.Pedido.IdentificacaoNfse.Cnpj := AINIRec.ReadString(sSecao, 'CNPJ', '');
    NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
    NFSe.NFSeCancelamento.Pedido.IdentificacaoNfse.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.NfseCancelamento.Pedido.CodigoCancelamento := AINIRec.ReadString(sSecao, 'CodigoCancelamento', AINIRec.ReadString(sSecao, 'CodCancel', ''));
    NFSe.NfSeCancelamento.DataHora := AINIRec.ReadDateTime(sSecao, 'DataHora', 0);

    NFSe.MotivoCancelamento := AINIRec.ReadString(sSecao, 'MotivoCancelamento', '');
    NFSe.NfSeCancelamento.Sucesso := AINIRec.ReadBool(sSecao, 'Sucesso', True);
  end;
end;

procedure TNFSeIniReader.LerINIDadosPrestador(AINIRec: TMemIniFile);
var
  sSecao, sCampo1: string;
  Ok: Boolean;
begin
  sSecao := 'Prestador'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Prestador.IdentificacaoPrestador.Tipo := FpAOwner.StrToTipoPessoa(Ok, AINIRec.ReadString(sSecao, 'TipoPessoa', ''));

    NFSe.Prestador.IdentificacaoPrestador.CpfCnpj := AINIRec.ReadString(sSecao, 'CNPJCPF', AINIRec.ReadString(sSecao, 'CNPJ', ''));
    NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
    NFSe.Prestador.IdentificacaoPrestador.InscricaoEstadual := AINIRec.ReadString(sSecao, 'InscricaoEstadual', '');

    NFSe.Prestador.IdentificacaoPrestador.Nif := AINIRec.ReadString(sSecao, 'NIF', '');
    NFSe.Prestador.IdentificacaoPrestador.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', '0'));
    NFSe.Prestador.IdentificacaoPrestador.CAEPF := AINIRec.ReadString(sSecao, 'CAEPF', '');

    NFSe.Prestador.RazaoSocial := AINIRec.ReadString(sSecao, 'RazaoSocial', '');
    NFSe.Prestador.NomeFantasia := AINIRec.ReadString(sSecao, 'NomeFantasia', '');

    NFSe.Prestador.Endereco.TipoLogradouro := AINIRec.ReadString(sSecao, 'TipoLogradouro', '');
    NFSe.Prestador.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.Prestador.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.Prestador.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.Prestador.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.Prestador.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.Prestador.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.Prestador.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');

    // Para o provedor ISSDigital deve-se informar também:
    NFSe.Prestador.cUF := UFparaCodigoUF(NFSe.Prestador.Endereco.UF);

    NFSe.Prestador.Endereco.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);

    NFSe.Prestador.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    NFSe.Prestador.Endereco.xPais := AINIRec.ReadString(sSecao, 'xPais', '');

    NFSe.Prestador.Contato.DDD := AINIRec.ReadString(sSecao, 'DDD', '');
    NFSe.Prestador.Contato.Telefone := AINIRec.ReadString(sSecao, 'Telefone', '');
    NFSe.Prestador.Contato.Email := AINIRec.ReadString(sSecao, 'Email', '');
    NFSe.Prestador.Contato.xSite := AINIRec.ReadString(sSecao, 'xSite', '');

    NFSe.Prestador.crc := AINIRec.ReadString(sSecao, 'crc', '');
    NFSe.Prestador.crc_estado := AINIRec.ReadString(sSecao, 'crc_estado', '');

    // Para o provedor WebFisco
    NFSe.Prestador.Anexo := AINIRec.ReadString(sSecao, 'Anexo', '');
    NFSe.Prestador.ValorReceitaBruta := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorReceitaBruta', ''), 0);
    NFSe.Prestador.DataInicioAtividade := StringToDateTimeDef(AINIRec.ReadString(sSecao, 'DataInicioAtividade', ''), 0);

    NFSe.OptanteSimplesNacional := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'OptanteSN', '1'));
    NFSe.OptanteSN := StrToOptanteSN(Ok, AINIRec.ReadString(sSecao, 'opSimpNac', '2'));
    NFSe.OptanteMEISimei := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'OptanteMEISimei', '1'));

    // raFederaisMunicipalpeloSN, raFederaisSN, raFederaisMunicipalforaSN
    sCampo1 := AINIRec.ReadString(sSecao, 'RegimeApuracaoSN', '');
    if sCampo1 <> '' then
      NFSe.RegimeApuracaoSN := StrToRegimeApuracaoSN(Ok, sCampo1);

    { retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais,
      retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP,
      retLucroReal, retLucroPresumido, retSimplesNacional, retImune,
      retEmpresaIndividualRELI, retEmpresaPP, retMicroEmpresario, retOutros,
      retMovimentoMensal, retISSQNAutonomos, retISSQNSociedade, retNotarioRegistrador,
      retTribFaturamentoVariavel, retFixo, retIsencao, retExigibSuspensaJudicial,
      retExigibSuspensaAdm
    }
    sCampo1 := AINIRec.ReadString(sSecao, 'RegimeEspTrib', AINIRec.ReadString(sSecao, 'Regime', '0'));
    NFSe.RegimeEspecialTributacao := FpAOwner.StrToRegimeEspecialTributacao(Ok, sCampo1);

    NFSe.DataOptanteSimplesNacional := AINIRec.ReadDateTime(sSecao, 'DataOptanteSimplesNacional', 0);

    NFSe.IncentivadorCultural := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'IncentivadorCultural', ''));
  end;
end;

procedure TNFSeIniReader.LerINIDadosTomador(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Tomador'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Tomador.IdentificacaoTomador.Tipo := FpAOwner.StrToTipoPessoa(Ok, AINIRec.ReadString(sSecao, 'TipoPessoa', '1'));
    NFSe.Tomador.IdentificacaoTomador.CpfCnpj := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
    NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual := AINIRec.ReadString(sSecao, 'InscricaoEstadual', '');

    NFSe.Tomador.IdentificacaoTomador.Nif := AINIRec.ReadString(sSecao, 'NIF', '');
    NFSe.Tomador.IdentificacaoTomador.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', '0'));
    NFSe.Tomador.IdentificacaoTomador.CAEPF := AINIRec.ReadString(sSecao, 'CAEPF', '');
    NFSe.Tomador.IdentificacaoTomador.DocEstrangeiro := AINIRec.ReadString(sSecao, 'DocEstrangeiro', '');

    NFSe.Tomador.RazaoSocial := AINIRec.ReadString(sSecao, 'RazaoSocial', '');
    NFSe.Tomador.NomeFantasia := AINIRec.ReadString(sSecao, 'NomeFantasia', '');

    NFSe.Tomador.Endereco.EnderecoInformado := FpAOwner.StrToSimNaoOpc(Ok, AINIRec.ReadString(sSecao, 'EnderecoInformado', ''));

    NFSe.Tomador.Endereco.TipoLogradouro := AINIRec.ReadString(sSecao, 'TipoLogradouro', '');
    NFSe.Tomador.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.Tomador.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.Tomador.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.Tomador.Endereco.TipoBairro := AINIRec.ReadString(sSecao, 'TipoBairro', '');
    NFSe.Tomador.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.Tomador.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.Tomador.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.Tomador.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');

    NFSe.Tomador.Endereco.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);
    NFSe.Tomador.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    NFSe.Tomador.Endereco.xPais := AINIRec.ReadString(sSecao, 'xPais', '');

    NFSe.Tomador.Endereco.PontoReferencia := AINIRec.ReadString(sSecao, 'PontoReferencia', '');

    NFSe.Tomador.Contato.DDD := AINIRec.ReadString(sSecao, 'DDD', '');
    NFSe.Tomador.Contato.TipoTelefone := AINIRec.ReadString(sSecao, 'TipoTelefone', '');
    NFSe.Tomador.Contato.Telefone := AINIRec.ReadString(sSecao, 'Telefone', '');
    NFSe.Tomador.Contato.Email := AINIRec.ReadString(sSecao, 'Email', '');

    NFSe.Tomador.AtualizaTomador := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'AtualizaTomador', '1'));
    NFSe.Tomador.TomadorExterior := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'TomadorExterior', '2'));
    NFSe.Tomador.TomadorSubstitutoTributario := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'TomadorSubstitutoTributario', '2'));
  end;
end;

procedure TNFSeIniReader.LerINIDadosIntermediario(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Intermediario'; // Completo
  if AINIRec.SectionExists(sSecao)then
  begin
    NFSe.Intermediario.Identificacao.CpfCnpj := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    NFSe.Intermediario.Identificacao.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');

    NFSe.Intermediario.Identificacao.Nif := AINIRec.ReadString(sSecao, 'NIF', '');
    NFSe.Intermediario.Identificacao.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', '0'));
    NFSe.Intermediario.Identificacao.CAEPF := AINIRec.ReadString(sSecao, 'CAEPF', '');

    NFSe.Intermediario.RazaoSocial := AINIRec.ReadString(sSecao, 'RazaoSocial', '');

    NFSe.Intermediario.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.Intermediario.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.Intermediario.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.Intermediario.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.Intermediario.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.Intermediario.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.Intermediario.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');
    NFSe.Intermediario.Endereco.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);
    NFSe.Intermediario.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');

    NFSe.Intermediario.Contato.Telefone := AINIRec.ReadString(sSecao, 'Telefone', '');
    NFSe.Intermediario.Contato.Email := AINIRec.ReadString(sSecao, 'Email', '');

    NFSe.Intermediario.IssRetido := FpAOwner.StrToSituacaoTributaria(Ok, AINIRec.ReadString(sSecao, 'IssRetido', ''));
  end;
end;

procedure TNFSeIniReader.LerINIQuartos(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao, sFim: string;
  Item: TQuartoCollectionItem;
begin
  // Provedor iiBrasil
  i := 1;
  while true do
  begin
    sSecao := 'Quartos' + IntToStrZero(i, 3); // Completo
    sFim := AINIRec.ReadString(sSecao, 'CodigoInternoQuarto', 'FIM');

    if(Length(sFim) <= 0) or (sFim = 'FIM')then
      break;

    Item := NFSe.Quartos.New;

    Item.CodigoInternoQuarto := StrToIntDef(sFim, 0);
    Item.QtdHospedes := AINIRec.ReadInteger(sSecao, 'QtdHospedes', 0);
    Item.CheckIn := AINIRec.ReadDateTime(sSecao, 'CheckIn', 0);
    Item.QtdDiarias := AINIRec.ReadInteger(sSecao, 'QtdDiarias', 0);
    Item.ValorDiaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorDiaria', ''), 0);

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDespesas(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao, sFim: string;
  Item: TDespesaCollectionItem;
begin
  // Provedor Infisc
  i := 1;
  while true do
  begin
    sSecao := 'Despesas' + IntToStrZero(I, 3); // Completo
    sFim := AINIRec.ReadString(sSecao, 'vDesp', 'FIM');

    if (Length(sFim) <= 0) or (sFim='FIM') then
      break;

    Item := NFSe.Despesa.New;

    Item.nItemDesp := AINIRec.ReadString(sSecao, 'nItemDesp', '');
    Item.xDesp := AINIRec.ReadString(sSecao, 'xDesp', '');
    Item.dDesp := AINIRec.ReadDateTime(sSecao, 'dDesp', 0);
    Item.vDesp := StringToFloatDef(sFim, 0);

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIGenericos(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao: string;
  Item: TGenericosCollectionItem;
begin
  // Provedor IPM
  i := 1;
  while true do
  begin
    sSecao := 'Genericos' + IntToStrZero(i, 1); // Completo
    if not AINIRec.SectionExists(sSecao) then
      break;

    Item := NFSe.Genericos.New;
    Item.Titulo := AINIRec.ReadString(sSecao, 'Titulo', '');
    Item.Descricao := AINIRec.ReadString(sSecao, 'Descricao', '');

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIItens(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao, sFim, sCampo: string;
  Item: TItemServicoCollectionItem;
  Ok: Boolean;
begin
  i := 1;
  while true do
  begin
    sSecao := 'Itens' + IntToStrZero(i, 3); // Completo
    sFim := AINIRec.ReadString(sSecao, 'Descricao'  ,'FIM');

    if (Length(sFim) <= 0) or (sFim = 'FIM') then
      break;

    Item := NFSe.Servico.ItemServico.New;

    // Local de execução do serviço
    Item.Endereco.EnderecoInformado := FpAOwner.StrToSimNaoOpc(Ok, AINIRec.ReadString(sSecao, 'EnderecoInformado', ''));
    Item.Endereco.TipoLogradouro := AINIRec.ReadString(sSecao, 'TipoLogradouro', '');
    Item.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Endereco', '');
    Item.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    Item.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    Item.Endereco.TipoBairro := AINIRec.ReadString(sSecao, 'TipoBairro', '');
    Item.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    Item.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    Item.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');
    Item.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    Item.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    Item.Endereco.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);
    Item.Endereco.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
    Item.Endereco.PontoReferencia := AINIRec.ReadString(sSecao, 'PontoReferencia', '');

    Item.Descricao := StringReplace(sFim, FpAOwner.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);
    Item.ItemListaServico := AINIRec.ReadString(sSecao, 'ItemListaServico', '');
    Item.xItemListaServico := AINIRec.ReadString(sSecao, 'xItemListaServico', '');

    Item.CodServ := AINIRec.ReadString(sSecao, 'CodServico', '');
    Item.codLCServ := AINIRec.ReadString(sSecao, 'codLCServico', '');

    sCampo := AINIRec.ReadString(sSecao, 'CodigoCnae', AINIRec.ReadString(sSecao, 'idCnae', ''));
    Item.CodigoCnae := sCampo;
    // Provedor SoftPlan
    Item.idCnae := sCampo;

    Item.TipoUnidade := StrToUnidade(Ok, AINIRec.ReadString(sSecao, 'TipoUnidade', '2'));
    Item.Unidade := AINIRec.ReadString(sSecao, 'Unidade', '');
    Item.Quantidade := StringToFloatDef(AINIRec.ReadString(sSecao, 'Quantidade', ''), 0);
    Item.ValorUnitario := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorUnitario', ''), 0);

    Item.QtdeDiaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'QtdeDiaria', ''), 0);
    Item.ValorTaxaTurismo := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorTaxaTurismo', ''), 0);

    Item.AliqDeducoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliquotaDeducoes', ''), 0);
    Item.ValorDeducoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorDeducoes', ''), 0);
    Item.xJustDeducao := AINIRec.ReadString(sSecao, 'xJustDeducao', '');

    Item.AliqReducao := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqReducao', ''), 0);
    Item.ValorReducao := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorReducao', ''), 0);

    Item.ValorISS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorISS', ''), 0);
    Item.Aliquota := StringToFloatDef(AINIRec.ReadString(sSecao, 'Aliquota', ''), 0);
    Item.BaseCalculo := StringToFloatDef(AINIRec.ReadString(sSecao, 'BaseCalculo', ''), 0);
    Item.DescontoIncondicionado := StringToFloatDef(AINIRec.ReadString(sSecao, 'DescontoIncondicionado', ''), 0);
    Item.DescontoCondicionado := StringToFloatDef(AINIRec.ReadString(sSecao, 'DescontoCondicionado', ''), 0);

    Item.AliqISSST := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqISSST', ''), 0);
    Item.ValorISSST := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorISSST', ''), 0);

    Item.ValorBCCSLL := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCCSLL', ''), 0);
    Item.AliqRetCSLL := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetCSLL', ''), 0);
    Item.RetidoCSLL := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCSLL', ''));
    Item.ValorCSLL := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCSLL', ''), 0);

    Item.ValorBCPIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCPIS', ''), 0);
    Item.AliqRetPIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetPIS', ''), 0);
    Item.RetidoPIS := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoPIS', ''));
    Item.ValorPIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorPIS', ''), 0);

    Item.ValorBCCOFINS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCCOFINS', ''), 0);
    Item.AliqRetCOFINS := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetCOFINS', ''), 0);
    Item.RetidoCOFINS := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCOFINS', ''));
    Item.ValorCOFINS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCOFINS', ''), 0);

    Item.ValorBCINSS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCINSS', ''), 0);
    Item.AliqRetINSS := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetINSS', ''), 0);
    Item.RetidoINSS := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoINSS', ''));
    Item.ValorINSS := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorINSS', ''), 0);

    Item.ValorBCRetIRRF := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCRetIRRF', ''), 0);
    Item.AliqRetIRRF := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetIRRF', ''), 0);
    Item.RetidoIRRF := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoIRRF', ''));
    Item.ValorIRRF := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorIRRF', ''), 0);

    Item.ValorBCCPP := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorBCCPP', ''), 0);
    Item.AliqRetCPP := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliqRetCPP', ''), 0);
    Item.RetidoCPP := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCPP', ''));
    Item.ValorCPP := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCPP', ''), 0);

    Item.ValorRecebido := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorRecebido', ''), 0);
    Item.ValorTotal := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorTotal',
                           AINIRec.ReadString(sSecao, 'ValorServicos', '')), 0);

    Item.Tributavel := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'Tributavel', '1'));

    // Provedores que usam o layout da ABRASF
    Item.CodMunPrestacao := AINIRec.ReadString(sSecao, 'CodigoMunicipio',
                             AINIRec.ReadString(sSecao, 'CodMunPrestacao', ''));
    Item.CodigoMunicipio := StrToIntDef(Item.CodMunPrestacao, 0);
    Item.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);
    Item.CodigoTributacaoMunicipio := AINIRec.ReadString(sSecao, 'CodigoTributacaoMunicipio', '');
    Item.CodigoNBS := AINIRec.ReadString(sSecao, 'CodigoNBS', '');
    Item.xNBS := AINIRec.ReadString(sSecao, 'xNBS', '');
    Item.CodigoInterContr := AINIRec.ReadString(sSecao, 'CodigoInterContr', '');
    Item.ResponsavelRetencao := FpAOwner.StrToResponsavelRetencao(Ok, AINIRec.ReadString(sSecao, 'ResponsavelRetencao', ''));
    Item.ExigibilidadeISS := FpAOwner.StrToExigibilidadeISS(Ok, AINIRec.ReadString(sSecao, 'ExigibilidadeISS', '1'));
    Item.MunicipioIncidencia := AINIRec.ReadInteger(sSecao, 'MunicipioIncidencia', 0);
    Item.xMunicipioIncidencia := AINIRec.ReadString(sSecao, 'xMunicipioIncidencia', '');
    Item.NumeroProcesso := AINIRec.ReadString(sSecao, 'NumeroProcesso', '');
    Item.InfAdicional := AINIRec.ReadString(sSecao, 'InfAdicional', '');
    Item.CodigoServicoNacional := AINIRec.ReadString(sSecao, 'CodigoServicoNacional', '');
    Item.CodigoTributacaoNacional := AINIRec.ReadString(sSecao, 'CodigoTributacaoNacional', '');

    // IPM
    Item.TribMunPrestador := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'TribMunPrestador', '1'));
    Item.SituacaoTributaria := AINIRec.ReadInteger(sSecao, 'SituacaoTributaria', 0);
    Item.ValorISSRetido := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorISSRetido', ''), 0);
    Item.ValorTributavel := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorTributavel', ''), 0);
    Item.CodCNO := AINIRec.ReadString(sSecao, 'CodCNO', '');

    // Provedor Infisc
    Item.totalAproxTribServ := StringToFloatDef(AINIRec.ReadString(sSecao, 'totalAproxTribServ', ''), 0);

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDadosDeducao(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
  i: Integer;
  Item: TDeducaoCollectionItem;
begin
  i := 1;
  while True do
  begin
    sSecao := 'DadosDeducao' + IntToStrZero(i, 3); // Completo

    if not AINIRec.SectionExists(sSecao) then
      break;

    Item := NFSe.Servico.Deducao.New;

    Item.TipoDeducao := FpAOwner.StrToTipoDeducao(Ok, AINIRec.ReadString(sSecao, 'TipoDeducao', ''));
    Item.CpfCnpjReferencia := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    Item.NumeroNFReferencia := AINIRec.ReadString(sSecao, 'NumeroNFReferencia', '');
    Item.ValorTotalReferencia := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorTotalReferencia', ''), 0);
    Item.PercentualDeduzir := StringToFloatDef(AINIRec.ReadString(sSecao, 'PercentualDeduzir', ''), 0);
    Item.ValorDeduzir := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorDeduzir', ''), 0);
    Item.DeducaoPor := FpAOwner.StrToDeducaoPor(Ok, AINIRec.ReadString(sSecao, 'DeducaoPor', ''));

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDadosServico(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Servico';
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.Servico.CodigoPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);
    NFSe.Servico.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
    NFSe.Servico.ItemListaServico := AINIRec.ReadString(sSecao, 'ItemListaServico', '');
    NFSe.Servico.xItemListaServico := AINIRec.ReadString(sSecao, 'xItemListaServico', '');
    NFSe.Servico.CodigoTributacaoMunicipio := AINIRec.ReadString(sSecao, 'CodigoTributacaoMunicipio', '');
    NFSe.Servico.xCodigoTributacaoMunicipio := AINIRec.ReadString(sSecao, 'xCodigoTributacaoMunicipio', '');
    NFSe.Servico.Discriminacao := AINIRec.ReadString(sSecao, 'Discriminacao', '');
    NFSe.Servico.Discriminacao := StringReplace(NFSe.Servico.Discriminacao,
                FpAOwner.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);
    NFSe.Servico.CodigoNBS := AINIRec.ReadString(sSecao, 'CodigoNBS', '');
    // Provedor IssNet e Padrão Nacional
    NFSe.infNFSe.xNBS := AINIRec.ReadString(sSecao, 'xNBS', '');
    NFSe.Servico.CodigoInterContr := AINIRec.ReadString(sSecao, 'CodigoInterContr', '');
    NFSe.Servico.CodigoCnae := AINIRec.ReadString(sSecao, 'CodigoCnae', '');
    NFSe.Servico.Descricao := AINIRec.ReadString(sSecao, 'Descricao', '');
    NFSe.Servico.Descricao := StringReplace(NFSe.Servico.Descricao,
                FpAOwner.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);

    if NFSe.Servico.Descricao = '' then
      NFSe.Servico.Descricao := NFSe.Servico.Discriminacao;

    NFSe.Servico.ExigibilidadeISS := FpAOwner.StrToExigibilidadeISS(Ok, AINIRec.ReadString(sSecao, 'ExigibilidadeISS', '1'));
    NFSe.Servico.IdentifNaoExigibilidade := AINIRec.ReadString(sSecao, 'IdentifNaoExigibilidade', '');
    NFSe.Servico.MunicipioIncidencia := AINIRec.ReadInteger(sSecao, 'MunicipioIncidencia', 0);
    NFSe.Servico.xMunicipioIncidencia := AINIRec.ReadString(sSecao, 'xMunicipioIncidencia', '');
    NFSe.Servico.NumeroProcesso := AINIRec.ReadString(sSecao, 'NumeroProcesso', '');
    NFSe.Servico.MunicipioPrestacaoServico := AINIRec.ReadString(sSecao, 'MunicipioPrestacaoServico', '');

    if Trim(NFSe.Servico.MunicipioPrestacaoServico) <> '' then
      FpAOwner.ConfigGeral.ImprimirLocalPrestServ := True
    else
      FpAOwner.ConfigGeral.ImprimirLocalPrestServ := False;

    NFSe.Servico.UFPrestacao := AINIRec.ReadString(sSecao, 'UFPrestacao', '');
    NFSe.Servico.ResponsavelRetencao := FpAOwner.StrToResponsavelRetencao(Ok, AINIRec.ReadString(sSecao, 'ResponsavelRetencao', ''));
    NFSe.Servico.TipoLancamento := StrToTipoLancamento(Ok, AINIRec.ReadString(sSecao, 'TipoLancamento', 'P'));

    // Provedor ISSDSF
    NFSe.Servico.Operacao := StrToOperacao(Ok, AINIRec.ReadString(sSecao, 'Operacao', ''));
    NFSe.Servico.Tributacao := FpAOwner.StrToTributacao(Ok, AINIRec.ReadString(sSecao, 'Tributacao', ''));
    // Provedor ISSSaoPaulo
    NFSe.Servico.ValorTotalRecebido := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorTotalRecebido', ''), 0);
    NFSe.Servico.ValorCargaTributaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorCargaTributaria', ''), 0);
    NFSe.Servico.PercentualCargaTributaria := StringToFloatDef(AINIRec.ReadString(sSecao, 'PercentualCargaTributaria', ''), 0);
    NFSe.Servico.FonteCargaTributaria := AINIRec.ReadString(sSecao, 'FonteCargaTributaria', '');

    // Provedor SoftPlan
    NFSe.Servico.CFPS := AINIRec.ReadString(sSecao, 'CFPS', '');

    // Provedor Giap Informações sobre o Endereço da Prestação de Serviço
    NFSe.Servico.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.Servico.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.Servico.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    NFSe.Servico.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.Servico.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.Servico.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.Servico.Endereco.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
    NFSe.Servico.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');

    // Provedor ISSBarueri
    NFSe.Servico.LocalPrestacao := StrToLocalPrestacao(Ok, AINIRec.ReadString(sSecao, 'LocalPrestacao', '1'));
    NFSe.Servico.PrestadoEmViasPublicas := AINIRec.ReadBool(sSecao, 'PrestadoEmViasPublicas', True);

    // Provedor Megasoft
    NFSe.Servico.InfAdicional := AINIRec.ReadString(sSecao, 'InfAdicional', '');

    // Provedor SigISSWeb
    NFSe.Servico.xFormaPagamento := AINIRec.ReadString(sSecao, 'xFormaPagamento', '');

    // Provedor ISSSalvador
    NFSe.Servico.cClassTrib := AINIRec.ReadString(sSecao, 'cClassTrib', '');
    NFSe.Servico.INDOP := AINIRec.ReadString(sSecao, 'INDOP', '');

    //Provedor ISSSaoPaulo
    NFSe.Servico.CodigoNCM := AINIRec.ReadString(sSecao, 'CodigoNCM', '');
  end;
end;

procedure TNFSeIniReader.LerINIComercioExterior(AINIRec: TMemIniFile);
var
  SSecao: string;
  Ok: Boolean;
begin
  sSecao := 'ComercioExterior'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.comExt.mdPrestacao := StrTomdPrestacao(Ok, AINIRec.ReadString(sSecao, 'mdPrestacao', '0'));
    NFSe.Servico.comExt.vincPrest := StrTovincPrest(Ok, AINIRec.ReadString(sSecao, 'vincPrest', '0'));
    NFSe.Servico.comExt.tpMoeda := AINIRec.ReadInteger(sSecao, 'tpMoeda', 0);
    NFSe.Servico.comExt.vServMoeda := StringToFloatDef(AINIRec.ReadString(sSecao, 'vServMoeda', '0'), 0);
    NFSe.Servico.comExt.mecAFComexP := StrTomecAFComexP(Ok, AINIRec.ReadString(sSecao, 'mecAFComexP', '00'));
    NFSe.Servico.comExt.mecAFComexT := StrTomecAFComexT(Ok, AINIRec.ReadString(sSecao, 'mecAFComexT', '00'));
    NFSe.Servico.comExt.movTempBens := StrToMovTempBens(Ok, AINIRec.ReadString(sSecao, 'movTempBens', '00'));
    NFSe.Servico.comExt.nDI := AINIRec.ReadString(sSecao, 'nDI', '');
    NFSe.Servico.comExt.nRE := AINIRec.ReadString(sSecao, 'nRE', '');
    NFSe.Servico.comExt.mdic := AINIRec.ReadInteger(sSecao, 'mdic', 0);
  end;
end;

procedure TNFSeIniReader.LerINILocacaoSubLocacao(AINIRec: TMemIniFile);
var
  SSecao: string;
  Ok: Boolean;
begin
  sSecao := 'LocacaoSubLocacao'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Locacao.categ := StrTocateg(Ok, AINIRec.ReadString(sSecao, 'categ', '1'));
    NFSe.Servico.Locacao.objeto := StrToobjeto(Ok, AINIRec.ReadString(sSecao, 'objeto', '1'));
    NFSe.Servico.Locacao.extensao := AINIRec.ReadString(sSecao, 'extensao', '');
    NFSe.Servico.Locacao.nPostes := AINIRec.ReadInteger(sSecao, 'nPostes', 0);
  end;
end;

procedure TNFSeIniReader.LerINIConstrucaoCivil(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'ConstrucaoCivil'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.ConstrucaoCivil.CodigoObra := AINIRec.ReadString(sSecao, 'CodigoObra', '');
    NFSe.ConstrucaoCivil.inscImobFisc := AINIRec.ReadString(sSecao, 'inscImobFisc', '');
    NFSe.ConstrucaoCivil.Cib := AINIRec.ReadInteger(sSecao, 'Cib', 0);
    NFSe.ConstrucaoCivil.Art := AINIRec.ReadString(sSecao, 'Art', '');

    NFSe.ConstrucaoCivil.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.ConstrucaoCivil.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.ConstrucaoCivil.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.ConstrucaoCivil.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    NFSe.ConstrucaoCivil.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.ConstrucaoCivil.Endereco.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', EmptyStr);
    NFSe.ConstrucaoCivil.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    NFSe.ConstrucaoCivil.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');

    NFSe.ConstrucaoCivil.LocalConstrucao := AINIRec.ReadString(sSecao, 'LocalConstrucao', '');
    NFSE.ConstrucaoCivil.ReformaCivil := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'ReformaCivil', EmptyStr));

    // Provedor Simple
    NFSE.ConstrucaoCivil.nCei := AINIRec.ReadString(sSecao, 'nCei', '');

    // Provedor Infisc
    NFSE.ConstrucaoCivil.nProj := AINIRec.ReadString(sSecao, 'nProj', '');

    // Provedor Simple e Infisc
    NFSE.ConstrucaoCivil.nMatri := AINIRec.ReadString(sSecao, 'nMatri', '');

    // Provedor Simple e ISSSaoPaulo
    NFSE.ConstrucaoCivil.nNumeroEncapsulamento := AINIRec.ReadString(sSecao, 'nNumeroEncapsulamento', '');
  end;
end;

procedure TNFSeIniReader.LerINIEvento(AINIRec: TMemIniFile);
var
  SSecao: string;
begin
  sSecao := 'Evento'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Evento.xNome := AINIRec.ReadString(sSecao, 'RazaoSocial', AINIRec.ReadString(sSecao, 'xNome', ''));
    NFSe.Servico.Evento.dtIni := AINIRec.ReadDate(sSecao, 'dtIni', Now);
    NFSe.Servico.Evento.dtFim := AINIRec.ReadDate(sSecao, 'dtFim', Now);
    NFSe.Servico.Evento.idAtvEvt := AINIRec.ReadString(sSecao, 'idAtvEvt', '');

    NFSe.Servico.Evento.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    NFSe.Servico.Evento.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    NFSe.Servico.Evento.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');
    NFSe.Servico.Evento.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    NFSe.Servico.Evento.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    NFSe.Servico.Evento.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    NFSe.Servico.Evento.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');
  end;
end;

procedure TNFSeIniReader.LerINIRodoviaria(AINIRec: TMemIniFile);
var
  SSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Rodoviaria'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.explRod.categVeic := StrTocategVeic(Ok, AINIRec.ReadString(sSecao, 'categVeic', '00'));
    NFSe.Servico.explRod.nEixos := AINIRec.ReadInteger(sSecao, 'nEixos', 0);
    NFSe.Servico.explRod.rodagem := StrTorodagem(Ok, AINIRec.ReadString(sSecao, 'rodagem', '1'));
    NFSe.Servico.explRod.sentido := AINIRec.ReadString(sSecao, 'sentido', '');
    NFSe.Servico.explRod.placa := AINIRec.ReadString(sSecao, 'placa', '');
    NFSe.Servico.explRod.codAcessoPed := AINIRec.ReadString(sSecao, 'codAcessoPed', '');
    NFSe.Servico.explRod.codContrato := AINIRec.ReadString(sSecao, 'codContrato', '');
  end;
end;

procedure TNFSeIniReader.LerINIInformacoesComplementares(
  AINIRec: TMemIniFile);
var
  SSecao: string;
begin
  sSecao := 'InformacoesComplementares'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.infoCompl.idDocTec := AINIRec.ReadString(sSecao, 'idDocTec', '');
    NFSe.Servico.infoCompl.docRef := AINIRec.ReadString(sSecao, 'docRef', '');
    NFSe.Servico.infoCompl.xPed := AINIRec.ReadString(sSecao, 'xPed', '');
    NFSe.Servico.infoCompl.xInfComp := AINIRec.ReadString(sSecao, 'xInfComp', '');
  end;
end;

procedure TNFSeIniReader.LerINIInformacoesComplementaresgItemPed(AINIRec: TMemINIFile);
var
  sSecao: string;
  i: Integer;
begin
  i := 1;
  while True do
  begin
    sSecao := 'gItemPed' + IntToStrZero(i, 2); // Completo
    if not AINIRec.SectionExists(sSecao) then
      break;
    NFSe.Servico.infoCompl.gItemPed.New.xItemPed := AINIRec.ReadString(sSecao, 'xItemPed', '');
    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIValores(AINIRec: TMemIniFile);
var
  SSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Valores'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Valores.ValorRecebido := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorRecebido', ''), 0);
    NFSe.Servico.Valores.ValorServicos := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorServicos', ''), 0);
    NFSe.Servico.Valores.DescontoIncondicionado := StringToFloatDef(AINIRec.ReadString(sSecao, 'DescontoIncondicionado', ''), 0);
    NFSe.Servico.Valores.DescontoCondicionado := StringToFloatDef(AINIRec.ReadString(sSecao, 'DescontoCondicionado', ''), 0);
    NFSe.Servico.Valores.OutrosDescontos := StringToFloatDef(AINIRec.ReadString(sSecao, 'OutrosDescontos', ''), 0);
    NFSe.Servico.Valores.AliquotaDeducoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'AliquotaDeducoes', ''), 0);
    NFSe.Servico.Valores.ValorDeducoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorDeducoes', ''), 0);

    NFSe.Servico.Valores.ValorOutrasRetencoes := StringToFloatDef(AINIRec.ReadString(sSecao, 'ValorOutrasRetencoes', ''), 0);
    NFSe.Servico.Valores.OutrasRetencoes := StringtoFloatDef(AINIRec.ReadString(sSecao, 'OutrasRetencoes', ''), 0);
    NFSe.Servico.Valores.DescricaoOutrasRetencoes := AINIRec.ReadString(sSecao, 'DescricaoOutrasRetencoes', '');
    NFSe.Servico.Valores.ValorLiquidoNfse := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorLiquidoNfse', ''), 0);
    NFSe.Servico.Valores.JustificativaDeducao := AINIRec.ReadString(sSecao, 'JustificativaDeducao', '');
    NFSe.Servico.Valores.IssRetido := FpAOwner.StrToSituacaoTributaria(Ok, AINIRec.ReadString(sSecao, 'ISSRetido', ''));
    NFSe.Servico.Valores.ValorRepasse := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorRepasse', ''), 0);
    NFSe.Servico.Valores.AliquotaSN := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaSN', ''), 0);
    NFSe.Servico.Valores.ValorTotalNotaFiscal := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorTotalNotaFiscal', ''), 0);
    NFSe.Servico.Valores.ValorTotalTributos := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorTotalTributos', ''), 0);
    NFSe.Servico.Valores.ValorTotalRecebido := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorTotalRecebido', ''), 0);

    NFSe.Servico.Valores.IrrfIndenizacao := StringtoFloatDef(AINIRec.ReadString(sSecao, 'IrrfIndenizacao', ''), 0);
    NFSe.Servico.Valores.RetencoesFederais := StringtoFloatDef(AINIRec.ReadString(sSecao, 'RetencoesFederais', ''), 0);

    // Provedor Conam
    NFSe.Servico.Valores.BaseCalculo := StringtoFloatDef(AINIRec.ReadString(sSecao, 'BaseCalculo', ''), 0);
    NFSe.Servico.Valores.Aliquota := StringtoFloatDef(AINIRec.ReadString(sSecao, 'Aliquota', ''), 0);
    NFSe.Servico.Valores.ValorIss := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorIss', ''), 0);
    NFSe.Servico.Valores.ValorIssRetido := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorIssRetido', ''), 0);

    NFSe.Servico.Valores.ValorPis := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorPIS', ''), 0);
    NFSe.Servico.Valores.AliquotaPis := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaPIS', ''), 0);
    NFSe.Servico.Valores.RetidoPis := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoPIS', ''));

    NFSe.Servico.Valores.ValorCofins := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorCOFINS', ''), 0);
    NFSe.Servico.Valores.AliquotaCofins := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaCofins', ''), 0);
    NFSe.Servico.Valores.RetidoCofins := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCOFINS', ''));

    NFSe.Servico.Valores.ValorCsll := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorCSLL', ''), 0);
    NFSe.Servico.Valores.AliquotaCsll := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaCSLL', ''), 0);
    NFSe.Servico.Valores.RetidoCsll := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCSLL', ''));

    NFSe.Servico.Valores.ValorInss := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorINSS', ''), 0);
    NFSe.Servico.Valores.AliquotaInss := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaINSS', ''), 0);
    NFSe.Servico.Valores.RetidoInss := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoINSS', ''));

    NFSe.Servico.Valores.ValorIr := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorIR', ''), 0);
    NFSe.Servico.Valores.AliquotaIr := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaIR', ''), 0);
    NFSe.Servico.Valores.RetidoIr := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoIR', ''));

    NFSe.Servico.Valores.ValorCpp := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorCPP', ''), 0);
    NFSe.Servico.Valores.AliquotaCpp := StringtoFloatDef(AINIRec.ReadString(sSecao, 'AliquotaCPP', ''), 0);
    NFSe.Servico.Valores.RetidoCpp := FpAOwner.StrToSimNao(Ok, AINIRec.ReadString(sSecao, 'RetidoCPP', ''));

    // Provedor Infisc
    NFSe.Servico.Valores.totalAproxTrib := StringtoFloatDef(AINIRec.ReadString(sSecao, 'TotalAproxTrib', ''), 0);

    // Provedor Equiplano (descrição dos impostos)
    NFSe.Servico.Valores.dsImpostos := AINIRec.ReadString(sSecao, 'dsImpostos', '');

    // Provedor ISSSaoPaulo
    NFSe.Servico.Valores.ValorIPI := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorIPI', ''), 0);
    NFSe.Servico.Valores.ValorInicialCobrado := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorInicialCobrado', ''), 0);
    NFSe.Servico.Valores.ValorFinalCobrado := StringtoFloatDef(AINIRec.ReadString(sSecao, 'ValorFinalCobrado', ''), 0);

    if NFSe.Servico.Valores.ValorTotalNotaFiscal = 0 then
      NFSe.Servico.Valores.ValorTotalNotaFiscal := NFSe.Servico.Valores.ValorServicos -
                                     NFSe.Servico.Valores.DescontoCondicionado -
                                     NFSe.Servico.Valores.DescontoIncondicionado;
  end;
end;

procedure TNFSeIniReader.LerINIImpostos(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao, sFim: string;
  Item: TImpostoCollectionItem;
begin
  // Provedor CTAConsult
  i := 1;
  while true do
  begin
    sSecao := 'Impostos' + IntToStrZero(i, 3); // Completo
    sFim := AINIRec.ReadString(sSecao, 'Valor', 'FIM');

    if (Length(sFim) <= 0) or (sFim = 'FIM') then
      break;

    Item := NFSe.Servico.Imposto.New;

    Item.Codigo := AINIRec.ReadInteger(sSecao, 'Codigo', 0);
    Item.Descricao := AINIRec.ReadString(sSecao, 'Descricao', '');
    Item.Aliquota := StringToFloatDef(AINIRec.ReadString(sSecao, 'Aliquota', ''), 0);
    Item.Valor := StringToFloatDef(sFim, 0);

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDocumentosDeducoes(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao: string;
  Ok: Boolean;
  Item: TDocDeducaoCollectionItem;
begin
  i := 1;
  while true do
  begin
    sSecao := 'DocumentosDeducoes' + IntToStrZero(i, 4); // Completo

    if not AINIRec.SectionExists(sSecao) then
      break;

    Item := NFSe.Servico.Valores.DocDeducao.New;

    Item.chNFSe := AINIRec.ReadString(sSecao,'chNFSe', '');
    Item.chNFe := AINIRec.ReadString(sSecao, 'chNFe', '');
    Item.nDocFisc := AINIRec.ReadString(sSecao, 'nDocFisc', '');
    Item.nDoc := AINIRec.ReadString(sSecao, 'nDoc', '');
    Item.tpDedRed := StrTotpDedRed(Ok, AINIRec.ReadString(sSecao, 'tpDedRed', '1'));
    Item.xDescOutDed := AINIRec.ReadString(sSecao, 'xDescOutDed', '');
    Item.dtEmiDoc := AINIRec.ReadDate(sSecao, 'dtEmiDoc', Now);
    Item.vDedutivelRedutivel := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDedutivelRedutivel', ''), 0);
    Item.vDeducaoReducao := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDeducaoReducao', ''), 0);

    Item.NFSeMun.cMunNFSeMun := AINIRec.ReadString(sSecao, 'cMunNFSeMun', '');
    Item.NFSeMun.nNFSeMun := AINIRec.ReadString(sSecao, 'nNFSeMun', '');
    Item.NFSeMun.cVerifNFSeMun := AINIRec.ReadString(sSecao, 'cVerifNFSeMun', '');

    Item.NFNFS.nNFS := AINIRec.ReadString(sSecao, 'nNFS', '');
    Item.NFNFS.modNFS := AINIRec.ReadString(sSecao, 'modNFS', '');
    Item.NFNFS.serieNFS := AINIRec.ReadString(sSecao, 'serieNFS', '');

    LerINIDocumentosDeducoesFornecedor(AINIRec, Item.fornec, i);

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDocumentosDeducoesFornecedor(
  AINIRec: TMemIniFile; fornec: TInfoPessoa; Indice: Integer);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'DocumentosDeducoesFornecedor' + IntToStrZero(Indice, 3); // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    fornec.Identificacao.CpfCnpj := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    fornec.Identificacao.InscricaoMunicipal := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
    fornec.Identificacao.Nif := AINIRec.ReadString(sSecao, 'NIF', '');
    fornec.Identificacao.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', '0'));
    fornec.Identificacao.CAEPF := AINIRec.ReadString(sSecao, 'CAEPF', '');
    fornec.RazaoSocial := AINIRec.ReadString(sSecao, 'RazaoSocial', '');

    fornec.Endereco.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    fornec.Endereco.xMunicipio := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    fornec.Endereco.UF := AINIRec.ReadString(sSecao, 'UF', '');
    fornec.Endereco.Endereco := AINIRec.ReadString(sSecao, 'Logradouro', '');
    fornec.Endereco.Numero := AINIRec.ReadString(sSecao, 'Numero', '');
    fornec.Endereco.Complemento := AINIRec.ReadString(sSecao, 'Complemento', '');
    fornec.Endereco.Bairro := AINIRec.ReadString(sSecao, 'Bairro', '');

    fornec.Contato.Telefone := AINIRec.ReadString(sSecao, 'Telefone', '');
    fornec.Contato.Email := AINIRec.ReadString(sSecao, 'Email', '');
  end;
end;

procedure TNFSeIniReader.LerINIValoresTribMun(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'tribMun'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Valores.tribMun.tribISSQN := StrTotribISSQN(Ok, AINIRec.ReadString(sSecao, 'tribISSQN', '1'));
    NFSe.Servico.Valores.tribMun.cPaisResult := AINIRec.ReadInteger(sSecao, 'cPaisResult', 0);
    NFSe.Servico.Valores.tribMun.nBM := AINIRec.ReadString(sSecao, 'nBM', '');
    NFSe.Servico.Valores.tribMun.vRedBCBM := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRedBCBM', ''), 0);
    NFSe.Servico.Valores.tribMun.pRedBCBM := StringToFloatDef(AINIRec.ReadString(sSecao, 'pRedBCBM', ''), 0);
    NFSe.Servico.Valores.tribMun.tpSusp := StrTotpSusp(Ok, AINIRec.ReadString(sSecao, 'tpSusp', ''));
    NFSe.Servico.Valores.tribMun.nProcesso := AINIRec.ReadString(sSecao, 'nProcesso', '');
    NFSe.Servico.Valores.tribMun.tpImunidade := StrTotpImunidade(Ok, AINIRec.ReadString(sSecao, 'tpImunidade', ''));
    NFSe.Servico.Valores.tribMun.pAliq := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliq', ''), 0);
    NFSe.Servico.Valores.tribMun.tpRetISSQN := StrTotpRetISSQN(Ok, AINIRec.ReadString(sSecao, 'tpRetISSQN', ''));
  end;
end;

procedure TNFSeIniReader.LerINIValoresTribFederal(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'tribFederal'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Valores.tribFed.CST := StrToCST(Ok, AINIRec.ReadString(sSecao, 'CST', ''));
    NFSe.Servico.Valores.tribFed.vBCPisCofins := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCPisCofins', ''), 0);
    NFSe.Servico.Valores.tribFed.pAliqPis := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqPis', ''), 0);
    NFSe.Servico.Valores.tribFed.pAliqCofins := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqCofins' ,''), 0);
    NFSe.Servico.Valores.tribFed.vPis := StringToFloatDef(AINIRec.ReadString(sSecao, 'vPis', ''), 0);
    NFSe.Servico.Valores.tribFed.vCofins := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCofins', ''), 0);
    NFSe.Servico.Valores.tribFed.tpRetPisCofins := StrTotpRetPisCofins(Ok, AINIRec.ReadString(sSecao, 'tpRetPisCofins', ''));
    NFSe.Servico.Valores.tribFed.vRetCP := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRetCP', ''), 0);
    NFSe.Servico.Valores.tribFed.vRetIRRF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRetIRRF', ''), 0);
    NFSe.Servico.Valores.tribFed.vRetCSLL := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRetCSLL', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINIValoresTotalTrib(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'totTrib'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Servico.Valores.totTrib.indTotTrib := StrToindTotTrib(Ok, AINIRec.ReadString(sSecao, 'indTotTrib', '1'));
    NFSe.Servico.Valores.totTrib.pTotTribSN := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTotTribSN', ''), 0);

    NFSe.Servico.Valores.totTrib.vTotTribFed := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotTribFed', ''), 0);
    NFSe.Servico.Valores.totTrib.vTotTribEst := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotTribEst', ''), 0);
    NFSe.Servico.Valores.totTrib.vTotTribMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotTribMun', ''), 0);

    NFSe.Servico.Valores.totTrib.pTotTribFed := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTotTribFed', ''), 0);
    NFSe.Servico.Valores.totTrib.pTotTribEst := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTotTribEst', ''), 0);
    NFSe.Servico.Valores.totTrib.pTotTribMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTotTribMun', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINIOrgaoGerador(AINIRec: TMemIniFile);
var
  sSecao: String;
begin
  sSecao := 'OrgaoGerador'; // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.OrgaoGerador.CodigoMunicipio := AINIRec.ReadString(sSecao, 'CodigoMunicipio', '');
    NFSe.OrgaoGerador.Uf := AINIRec.ReadString(sSecao, 'UF', '');
  end;
end;

procedure TNFSeIniReader.LerINICondicaoPagamento(AINIRec: TMemIniFile);
var
  sSecao: String;
  Ok: Boolean;
begin
  sSecao := 'CondicaoPagamento'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.CondicaoPagamento.QtdParcela := AINIRec.ReadInteger(sSecao, 'QtdParcela', 0);
    // Provedor Publica/IPM/Betha
    NFSe.CondicaoPagamento.Condicao := FpAOwner.StrToCondicaoPag(Ok, AINIRec.ReadString(sSecao, 'Condicao', 'A_VISTA'));

    // Provedor NFEletronica
    NFSe.CondicaoPagamento.DataVencimento := AINIRec.ReadDate(sSecao, 'DataVencimento', Now);
    NFSe.CondicaoPagamento.InstrucaoPagamento := AINIRec.ReadString(sSecao, 'InstrucaoPagamento', '');
    NFSe.CondicaoPagamento.CodigoVencimento := AINIRec.ReadInteger(sSecao, 'CodigoVencimento', 0);
  end;
end;

procedure TNFSeIniReader.LerINIParcelas(AINIRec: TMemIniFile);
var
  sSecao, sFim: String;
  Ok: Boolean;
  i: Integer;
  Item: TParcelasCollectionItem;
begin
  i := 1;
  while true do
  begin
    sSecao := 'Parcelas' + IntToStrZero(i, 2); // Completo
    sFim := AINIRec.ReadString(sSecao, 'Parcela'  ,'FIM');

    if (Length(sFim) <= 0) or (sFim = 'FIM') then
      break;

    Item := NFSe.CondicaoPagamento.Parcelas.New;

    Item.Parcela := sFim;
    Item.DataVencimento := AINIRec.ReadDate(sSecao, 'DataVencimento', Now);
    Item.Valor := StringToFloatDef(AINIRec.ReadString(sSecao, 'Valor', ''), 0);
    Item.Condicao := FpAOwner.StrToCondicaoPag(Ok, AINIRec.ReadString(sSecao, 'Condicao', ''));

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIEmail(AINIRec: TMemIniFile);
var
  i: Integer;
  sSecao, sFim: string;
begin
  i := 1;
  while true do
  begin
    sSecao := 'Email' + IntToStrZero(I + 1, 1);
    sFim := AINIRec.ReadString(sSecao, 'emailCC', 'FIM');

    if (Length(sFim) <= 0) or (sFim = 'FIM') then
      break;

    with NFSe.email.New do
      emailCC := sFim;

    Inc(i);
  end;
end;

procedure TNFSeIniReader.LerINITransportadora(AINIRec: TMemIniFile);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Transportadora';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    NFSe.Transportadora.xNomeTrans := AINIRec.ReadString(sSecao, 'xNomeTrans', '');
    NFSe.Transportadora.xCpfCnpjTrans := AINIRec.ReadString(sSecao, 'xCpfCnpjTrans', '');
    NFSe.Transportadora.xInscEstTrans := AINIRec.ReadString(sSecao, 'xInscEstTrans', '');
    NFSe.Transportadora.xPlacaTrans := AINIRec.ReadString(sSecao, 'xPlacaTrans', '');
    NFSe.Transportadora.xEndTrans := AINIRec.ReadString(sSecao, 'xEndTrans', '');
    NFSe.Transportadora.cMunTrans := AINIRec.ReadInteger(sSecao, 'cMunTrans', 0);
    NFSe.Transportadora.xMunTrans := AINIRec.ReadString(sSecao, 'xMunTrans', '');
    NFSe.Transportadora.xUFTrans := AINIRec.ReadString(sSecao, 'xUFTrans', '');
    NFSe.Transportadora.xPaisTrans := AINIRec.ReadString(sSecao, 'xPaisTrans', '');
    NFSe.Transportadora.vTipoFreteTrans := StrToTipoFrete(Ok, AINIRec.ReadString(sSecao, 'vTipoFreteTrans', ''));
  end;
end;

// Reforma Tributária
procedure TNFSeIniReader.LerINIIBSCBS(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBSDPS);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSDPS';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCBS.finNFSe := StrTofinNFSe(AINIRec.ReadString(sSecao, 'finNFSe', ''));
    IBSCBS.indFinal := StrToindFinal(AINIRec.ReadString(sSecao, 'indFinal', ''));
    IBSCBS.cIndOp := AINIRec.ReadString(sSecao, 'cIndOp', '');
    IBSCBS.tpOper := StrTotpOperGovNFSe(AINIRec.ReadString(sSecao, 'tpOper', ''));
    IBSCBS.tpEnteGov := StrTotpEnteGov(AINIRec.ReadString(sSecao, 'tpEnteGov', ''));
    IBSCBS.indDest := StrToindDest(AINIRec.ReadString(sSecao, 'indDest', ''));

    // Incluido para atender o provedor SigISSWeb
    IBSCBS.OperExterior := StrToTIndicador(AINIRec.ReadString(sSecao, 'OperExterior', '0'));
    IBSCBS.OperUF := AINIRec.ReadString(sSecao, 'OperUF', '');
    IBSCBS.OperxCidade := AINIRec.ReadString(sSecao, 'OperxCidade', '');
    IBSCBS.ConsumoPessoal := StrToTIndicador(AINIRec.ReadString(sSecao, 'ConsumoPessoal', '0'));

    LerINIgRefNFSe(AINIRec, IBSCBS.gRefNFSe);
    LerINIDestinatario(AINIRec, IBSCBS.dest);
    LerINIImovel(AINIRec, IBSCBS.imovel);
    LerINIIBSCBSValores(AINIRec, IBSCBS.valores);
  end;
end;

procedure TNFSeIniReader.LerINIgRefNFSe(AINIRec: TMemIniFile;
  gRefNFSe: TgRefNFSeCollection);
var
  i: Integer;
  sSecao, sFim: string;
begin
  i := 1;
  while true do
  begin
    sSecao := 'gRefNFSe' + IntToStrZero(i, 2);  // Completo
    sFim := AINIRec.ReadString(sSecao,'refNFSe', 'FIM');

    if (Length(sFim) <= 0) or (sFim = 'FIM') then
      break;

    gRefNFSe.New.refNFSe := sFim;

    inc(i);
  end;
end;

procedure TNFSeIniReader.LerINIDestinatario(AINIRec: TMemIniFile; Dest: TDadosdaPessoa);
var
  sSecao: string;
  Ok: Boolean;
begin
  sSecao := 'Destinatario'; // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    Dest.CNPJCPF := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    Dest.Nif := AINIRec.ReadString(sSecao, 'NIF', '');
    Dest.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', '0'));
    Dest.xNome := AINIRec.ReadString(sSecao, 'RazaoSocial', '');

    Dest.ender.xLgr := AINIRec.ReadString(sSecao, 'Logradouro', '');
    Dest.ender.nro := AINIRec.ReadString(sSecao, 'Numero', '');
    Dest.ender.xCpl := AINIRec.ReadString(sSecao, 'Complemento', '');
    Dest.ender.xBairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    Dest.ender.UF := AINIRec.ReadString(sSecao, 'UF', '');

    Dest.ender.endNac.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    Dest.ender.endNac.cMun := AINIRec.ReadInteger(sSecao, 'CodigoMunicipio', 0);
    Dest.ender.endExt.xCidade := AINIRec.ReadString(sSecao, 'xMunicipio', '');
    Dest.ender.endExt.cPais := AINIRec.ReadInteger(sSecao, 'CodigoPais', 0);

    Dest.fone := AINIRec.ReadString(sSecao, 'Telefone', '');
    Dest.email := AINIRec.ReadString(sSecao, 'Email', '');

    // Incluido para atender o provedor SigISSWeb
    Dest.IE := AINIRec.ReadString(sSecao, 'InscricaoEstadual', '');
    Dest.IM := AINIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
    Dest.xPais := AINIRec.ReadString(sSecao, 'xPais', '');

    // Incluido para atender o provedor Publica
    Dest.TipoServico := AINIRec.ReadString(sSecao, 'TipoServico', '');
  end;
end;

procedure TNFSeIniReader.LerINIImovel(AINIRec: TMemIniFile;
  Imovel: TDadosimovel);
var
  sSecao: string;
begin
  sSecao := 'Imovel';  // Completo
  if AINIRec.SectionExists(sSecao) then
  begin
    Imovel.inscImobFisc := AINIRec.ReadString(sSecao, 'inscImobFisc', '');
    Imovel.cCIB := AINIRec.ReadString(sSecao, 'cCIB', '');

    Imovel.ender.xLgr := AINIRec.ReadString(sSecao, 'Logradouro', '');
    Imovel.ender.nro := AINIRec.ReadString(sSecao, 'Numero', '');
    Imovel.ender.xCpl := AINIRec.ReadString(sSecao, 'Complemento', '');
    Imovel.ender.xBairro := AINIRec.ReadString(sSecao, 'Bairro', '');
    Imovel.ender.CEP := AINIRec.ReadString(sSecao, 'CEP', '');

    Imovel.ender.endExt.cEndPost := AINIRec.ReadString(sSecao, 'cEndPost', '');
    Imovel.ender.endExt.xCidade := AINIRec.ReadString(sSecao, 'xCidade', '');
    Imovel.ender.endExt.xEstProvReg := AINIRec.ReadString(sSecao, 'xEstProvReg', '');
  end;
end;

procedure TNFSeIniReader.LerINIIBSCBSValores(AINIRec: TMemIniFile;
  Valores: Tvalorestrib);
begin
  LerINIDocumentos(AINIRec, Valores.gReeRepRes.documentos);
  LerINITributacao(AINIRec, Valores.trib);
end;

procedure TNFSeIniReader.LerINIDocumentos(AINIRec: TMemIniFile;
  Documentos: TdocumentosCollection);
var
  i: Integer;
  sSecao, sFim: string;
  Ok: Boolean;
  Item: TDocumentosCollectionItem;
begin
  i := 1;
  while true do
  begin
    sSecao := 'Documentos' + IntToStrZero(i, 4);  // Completo
    sFim := AINIRec.ReadString(sSecao,'chaveDFe', '') +
            AINIRec.ReadString(sSecao,'nDocFiscal', '') +
            AINIRec.ReadString(sSecao,'nDoc', '') +
            AINIRec.ReadString(sSecao,'xNome', '') +
            AINIRec.ReadString(sSecao, 'RazaoSocial', '');
    if sFim = '' then
      break;

    Item := Documentos.New;

    Item.dFeNacional.tipoChaveDFe := StrTotipoChaveDFe(AINIRec.ReadString(sSecao, 'tipoChaveDFe', ''));
    Item.dFeNacional.xTipoChaveDFe := AINIRec.ReadString(sSecao, 'xTipoChaveDFe', '');
    Item.dFeNacional.chaveDFe := AINIRec.ReadString(sSecao, 'chaveDFe', '');

    Item.docFiscalOutro.cMunDocFiscal := AINIRec.ReadInteger(sSecao, 'cMunDocFiscal', 0);
    Item.docFiscalOutro.nDocFiscal := AINIRec.ReadString(sSecao, 'nDocFiscal', '');
    Item.docFiscalOutro.xDocFiscal := AINIRec.ReadString(sSecao, 'xDocFiscal', '');

    Item.docOutro.nDoc := AINIRec.ReadString(sSecao, 'nDoc', '');
    Item.docOutro.xDoc := AINIRec.ReadString(sSecao, 'xDoc', '');

    Item.fornec.CNPJCPF := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
    Item.fornec.NIF := AINIRec.ReadString(sSecao, 'NIF', '');
    Item.fornec.cNaoNIF := StrToNaoNIF(Ok, AINIRec.ReadString(sSecao, 'cNaoNIF', ''));
    Item.fornec.xNome := AINIRec.ReadString(sSecao, 'RazaoSocial', AINIRec.ReadString(sSecao, 'xNome', ''));

    Item.dtEmiDoc := AINIRec.ReadDate(sSecao, 'dtEmiDoc', 0);
    Item.dtCompDoc := AINIRec.ReadDate(sSecao, 'dtCompDoc', 0);
    Item.tpReeRepRes := StrTotpReeRepRes(AINIRec.ReadString(sSecao, 'tpReeRepRes', ''));
    Item.xTpReeRepRes := AINIRec.ReadString(sSecao, 'xTpReeRepRes', '');
    Item.vlrReeRepRes := StringToFloatDef(AINIRec.ReadString(sSecao, 'vlrReeRepRes', ''), 0);

    inc(i);
  end;
end;

procedure TNFSeIniReader.LerINITributacao(AINIRec: TMemIniFile;
  Tributacao: Ttrib);
begin
  LerINIgIBSCBS(AINIRec, Tributacao.gIBSCBS);
end;

procedure TNFSeIniReader.LerINIgIBSCBS(AINIRec: TMemIniFile;
  gIBSCBS: TgIBSCBS);
var
  sSecao: string;
begin
  sSecao := 'gIBSCBS';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSCBS.CST := StrToCSTIBSCBS(AINIRec.ReadString(sSecao, 'CST', ''));
    gIBSCBS.cClassTrib := AINIRec.ReadString(sSecao, 'cClassTrib', '');
    gIBSCBS.cCredPres := StrTocCredPres(AINIRec.ReadString(sSecao, 'cCredPres', ''));

    LerINIgTribRegular(AINIRec, gIBSCBS.gTribRegular);
    LerINIgDif(AINIRec, gIBSCBS.gDif);
  end;
end;

procedure TNFSeIniReader.LerINIgTribRegular(AINIRec: TMemIniFile;
  gTribRegular: TgTribRegular);
var
  sSecao: string;
begin
  sSecao := 'gTribRegular';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    gTribRegular.CSTReg := StrToCSTIBSCBS(AINIRec.ReadString(sSecao, 'CSTReg', ''));
    gTribRegular.cClassTribReg := AINIRec.ReadString(sSecao, 'cClassTribReg', '');
  end;
end;

procedure TNFSeIniReader.LerINIgDif(AINIRec: TMemIniFile; gDif: TgDif);
var
  sSecao: string;
begin
  sSecao := 'gDif';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    gDif.pDifUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pDifUF', ''), 0);
    gDif.pDifMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pDifMun', ''), 0);
    gDif.pDifCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pDifCBS', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINIIBSCBSNFSe(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBSNfse);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSNFSE';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCBS.cLocalidadeIncid := AINIRec.ReadInteger(sSecao, 'cLocalidadeIncid', 0);
    IBSCBS.xLocalidadeIncid := AINIRec.ReadString(sSecao, 'xLocalidadeIncid', '');
    IBSCBS.pRedutor := StringToFloatDef(AINIRec.ReadString(sSecao, 'pRedutor', ''), 0);

    LerINIIBSCBSValoresNFSe(AINIRec, IBSCBS.valores);
    LerINITotCIBS(AINIRec, IBSCBS.totCIBS);
  end;
end;

procedure TNFSeIniReader.LerINIIBSCBSValoresNFSe(AINIRec: TMemIniFile;
  Valores: TvaloresIBSCBS);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSValoresNFSE';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    Valores.vBC := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBC', ''), 0);
    Valores.vCalcReeRepRes := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCalcReeRepRes', ''), 0);

    Valores.uf.pIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSUF', ''), 0);
    Valores.uf.pRedAliqUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pRedAliqUF', ''), 0);
    Valores.uf.pAliqEfetUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfetUF', ''), 0);

    Valores.mun.pIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSMun', ''), 0);
    Valores.mun.pRedAliqMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pRedAliqMun', ''), 0);
    Valores.mun.pAliqEfetMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfetMun', ''), 0);

    Valores.Fed.pCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCBS', ''), 0);
    Valores.Fed.pRedAliqCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pRedAliqCBS', ''), 0);
    Valores.Fed.pAliqEfetCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfetCBS', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINITotCIBS(AINIRec: TMemIniFile;
  TotCIBS: TTotCIBS);
var
  sSecao: string;
begin
  sSecao := 'TotCIBS';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    TotCIBS.vTotNF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotNF', ''), 0);

    LerINIgTribRegularNFSe(AINIRec, TotCIBS.gTribRegular);
    LerINIgTribCompraGov(AINIRec, TotCIBS.gTribCompraGov);
    LerINITotgIBS(AINIRec, TotCIBS.gIBS);
    LerINITotgCBS(AINIRec, TotCIBS.gCBS);
  end;
end;

procedure TNFSeIniReader.LerINIgTribRegularNFSe(AINIRec: TMemIniFile;
  gTribRegularNFSe: TgTribRegularNFSe);
var
  sSecao: string;
begin
  sSecao := 'gTribRegularNFSe'; // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    gTribRegularNFSe.pAliqEfeRegIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfeRegIBSUF', ''), 0);
    gTribRegularNFSe.vTribRegIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTribRegIBSUF', ''), 0);
    gTribRegularNFSe.pAliqEfeRegIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfeRegIBSMun', ''), 0);
    gTribRegularNFSe.vTribRegIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTribRegIBSMun', ''), 0);
    gTribRegularNFSe.pAliqEfeRegCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqEfeRegCBS', ''), 0);
    gTribRegularNFSe.vTribRegCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTribRegCBS', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINIgTribCompraGov(AINIRec: TMemIniFile;
  gTribCompraGov: TgTribCompraGov);
var
  sSecao: string;
begin
  sSecao := 'gTribCompraGov'; // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    gTribCompraGov.pIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSUF', ''), 0);
    gTribCompraGov.vIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSUF', ''), 0);
    gTribCompraGov.pIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIBSMun', ''), 0);
    gTribCompraGov.vIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMun', ''), 0);
    gTribCompraGov.pCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCBS', ''), 0);
    gTribCompraGov.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBS', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINITotgIBS(AINIRec: TMemIniFile;
  TotgIBS: TgIBS);
var
  sSecao: string;
begin
  sSecao := 'TotgIBS';  // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    TotgIBS.vIBSTot := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSTot', ''), 0);

    TotgIBS.gIBSCredPres.pCredPresIBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCredPresIBS', ''), 0);
    TotgIBS.gIBSCredPres.vCredPresIBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCredPresIBS', ''), 0);

    TotgIBS.gIBSUFTot.vDifUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDifUF', ''), 0);
    TotgIBS.gIBSUFTot.vIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSUF', ''), 0);

    TotgIBS.gIBSMunTot.vDifMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDifMun', ''), 0);
    TotgIBS.gIBSMunTot.vIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMun', ''), 0);
  end;
end;

procedure TNFSeIniReader.LerINITotgCBS(AINIRec: TMemIniFile;
  TotgCBS: TgCBS);
var
  sSecao: string;
begin
  sSecao := 'TotgCBS'; // Completo

  if AINIRec.SectionExists(sSecao) then
  begin
    TotgCBS.vDifCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vDifCBS', ''), 0);
    TotgCBS.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBS', ''), 0);

    TotgCBS.gCBSCredPres.pCredPresCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCredPresCBS', ''), 0);
    TotgCBS.gCBSCredPres.vCredPresCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCredPresCBS', ''), 0);
  end;
end;

end.
