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

unit ACBrNFeABI.XmlWriter;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrNFeABI.Classes,
  ACBrNFeABI.Conversao,
  ACBrDFe.RTC.XmlWriter;

type

  TNFeABIXmlWriterOptions = class(TACBrXmlWriterOptions)
  private
    FAjustarTagNro: boolean;
    FGerarTagIPIparaNaoTributado: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TACBrTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;

  public
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property GerarTagIPIparaNaoTributado: boolean read FGerarTagIPIparaNaoTributado write FGerarTagIPIparaNaoTributado;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TACBrTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;

  end;

  TNFeABIXmlWriter = class(TDFeRTCXmlWriter)
  private
    FNFeABI: TNFeABI;

    FPChave: string;
    FVersaoDF: TVersaoNFeABI;
    FModeloDF: Integer;
    FtpAmb: TACBrTipoAmbiente;
    FtpEmis: TACBrTipoEmissao;

    function Gerar_InfNFeABI: TACBrXmlNode;
    function Gerar_Ide(Ide: TIde): TACBrXmlNode;
    function Gerar_gModNat(gModNat: TgModNat): TACBrXmlNode;
    function Gerar_gCont(gCont: TgCont): TACBrXmlNode;

    function Gerar_NFref(NFref: TNFrefCollection): TACBrXmlNodeArray;

    function Gerar_Emit(Emit: Temit): TACBrXmlNode;
    function Gerar_Endereco(const Tag: string; Endereco: TEndereco): TACBrXmlNode;

    function Gerar_transmit(transmit: tTransmitCollection): TACBrXmlNodeArray;
    function Gerar_adquirente(adquirente: tadquirenteCollection): TACBrXmlNodeArray;

    function Gerar_Imovel(Imovel: Timovel): TACBrXmlNode;
    function Gerar_Cadastro(Cadastro: TCadastro): TACBrXmlNode;

    function Gerar_autXML(autXML: TautXMLCollection): TACBrXmlNodeArray;

    function Gerar_infOper(infOper: TinfOper): TACBrXmlNode;
    function Gerar_gTorna(gTorna: TgTorna): TACBrXmlNode;
    function Gerar_imovelTorna(imovelTorna: timovelTornaCollection): TACBrXmlNodeArray;
    function Gerar_gIncorpLote(gIncorpLote: TgIncorpLote): TACBrXmlNode;
    function Gerar_gRedAjusteImovel(gRedAjusteImovel: TgRedAjusteImovel): TACBrXmlNode;
    function Gerar_instrumento(instrumento: Tinstrumento): TACBrXmlNode;
    function Gerar_gIntermedCorret(gIntermedCorret: tgIntermedCorretCollection): TACBrXmlNodeArray;

    function Gerar_ginfTrib(ginfTrib: TginfTrib): TACBrXmlNode;

    function Gerar_pag(pag: Tpag): TACBrXmlNode;
    function Gerar_detPagImovel(detPagImovel: tdetPagImovelCollection): TACBrXmlNodeArray;
    function Gerar_detPagIncorpLote(detPagIncorpLote: tdetPagIncorpLoteCollection): TACBrXmlNodeArray;

    function Gerar_Total(total: Ttotal): TACBrXmlNode;
    function Gerar_tribTot(total: Ttotal): TACBrXmlNode;

    function Gerar_InfAdic(infAdic: TinfAdic): TACBrXmlNode;
    function Gerar_ObsCont(ObsCont: tObsContCollection): TACBrXmlNodeArray;
    function Gerar_ObsFisco(ObsFisco: tObsFiscoCollection): TACBrXmlNodeArray;

    function Gerar_infRespTec(infRespTec: TinfRespTec): TACBrXmlNode;

    function Gerar_ProtNFeABI: TACBrXmlNode;

    function GetOpcoes: TNFeABIXmlWriterOptions;
    procedure SetOpcoes(AValue: TNFeABIXmlWriterOptions);

    procedure AjustarMunicipioUF(out xUF: string; out xMun: string;
      out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);

    function GerarChaveAcesso(AUF: Integer; ADataEmissao: TDateTime;
      const ACNPJ:String; ASerie, ANumero, AtpEmi, AnSiteAut,
      ACodigo: Integer; AModelo: Integer = 77): String;
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;

  public
    constructor Create(AOwner: TNFeABI); reintroduce;
    destructor Destroy; override;

    function GerarXml: boolean; override;
    function ObterNomeArquivo: string; overload;

    property Opcoes: TNFeABIXmlWriterOptions read GetOpcoes write SetOpcoes;
    property NFeABI: TNFeABI read FNFeABI write FNFeABI;

    property VersaoDF: TVersaoNFeABI read FVersaoDF write FVersaoDF;
    property ModeloDF: Integer read FModeloDF write FModeloDF;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property tpEmis: TACBrTipoEmissao read FtpEmis write FtpEmis;
  end;

implementation

uses
  StrUtils,
  Math,
  ACBrValidador,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrDFeUtil,
  ACBrDFeConsts,
  ACBrNFeABI,
  ACBrNFeABI.Consts;

{ TNFeABIXmlWriter }

constructor TNFeABIXmlWriter.Create(AOwner: TNFeABI);
begin
  inherited Create;

  Opcoes.AjustarTagNro := False;
  Opcoes.GerarTagIPIparaNaoTributado := True;
  Opcoes.NormatizarMunicipios := False;
  Opcoes.PathArquivoMunicipios := '';
  Opcoes.GerarTagAssinatura := taSomenteSeAssinada;
  Opcoes.ValidarInscricoes := False;
  Opcoes.ValidarListaServicos := False;

  FNFeABI := AOwner;
end;

function TNFeABIXmlWriter.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TNFeABIXmlWriterOptions.Create();
end;

destructor TNFeABIXmlWriter.Destroy;
begin
  inherited Destroy;
end;

function TNFeABIXmlWriter.GetOpcoes: TNFeABIXmlWriterOptions;
begin
  Result := TNFeABIXmlWriterOptions(FOpcoes);
end;

function TNFeABIXmlWriter.ObterNomeArquivo: string;
begin
  Result := FPChave + '-NFeABI.xml';
end;

procedure TNFeABIXmlWriter.SetOpcoes(AValue: TNFeABIXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

procedure TNFeABIXmlWriter.AjustarMunicipioUF(out xUF: string; out xMun: string;
  out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);
var
  PaisBrasil: boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;

  cMun := IfThen(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IfThen(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF  := IfThen(PaisBrasil, vxUF, UF_EXTERIOR);

  if Opcoes.NormatizarMunicipios then
    if ((EstaZerado(cMun)) and (xMun <> XMUN_EXTERIOR)) then
      cMun := ObterCodigoMunicipio(xMun, xUF, Opcoes.FPathArquivoMunicipios)
    else if ( ( EstaVazio(xMun)) and (cMun <> CMUN_EXTERIOR) ) then
      xMun := ObterNomeMunicipio(cMun, xUF, Opcoes.FPathArquivoMunicipios);
end;

function TNFeABIXmlWriter.GerarChaveAcesso(AUF: Integer; ADataEmissao: TDateTime;
  const ACNPJ: String; ASerie, ANumero, AtpEmi, AnSiteAut, ACodigo,
  AModelo: Integer): String;
var
  vUF, vDataEmissao, vSerie, vNumero, vCodigo, vModelo, vCNPJ, vtpEmi,
  vnSiteAut: String;
begin
  // Se o usuario informar 0 ou -1; o código numerico sera gerado de maneira aleatória //
  if ACodigo = -1 then
    ACodigo := 0;

  if ACodigo = 0 then
    ACodigo := GerarCodigoDFe(ANumero);

  // Se o usuario informar um código inferior ou igual a -2 a chave será gerada
  // com o código igual a zero, mas poderá não ser autorizada pela SEFAZ.
  if ACodigo <= -2 then
    ACodigo := 0;

  vUF          := Poem_Zeros(AUF, 2);
  vDataEmissao := FormatDateTime('YYMM', ADataEmissao);
  vCNPJ        := PadLeft(OnlyCPFCNPJAlphaNum(ACNPJ), 14, '0');
  vModelo      := Poem_Zeros(AModelo, 2);
  vSerie       := Poem_Zeros(ASerie, 3);
  vNumero      := Poem_Zeros(ANumero, 9);
  vtpEmi       := Poem_Zeros(AtpEmi, 1);
  vnSiteAut    := Poem_Zeros(AnSiteAut, 1);
  vCodigo      := Poem_Zeros(ACodigo, 7);

  Result := vUF + vDataEmissao + vCNPJ + vModelo + vSerie + vNumero + vtpEmi +
            vnSiteAut + vCodigo;
  Result := Result + Modulo11(Result);
end;

function TNFeABIXmlWriter.Gerar_InfNFeABI: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: integer;
begin
  Result := FDocument.CreateElement('infNFeABI');

  Result.SetAttribute('Id', 'NFeABI' + FPChave);
  Result.SetAttribute('versao', FloatToString(NFeABI.infNFeABI.Versao, '.', '#0.00'));

  Result.AppendChild(Gerar_Ide(NFeABI.Ide));

  nodeArray := Gerar_NFref(NFeABI.NFref);

  for i := 0 to NFeABI.NFref.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(Gerar_Emit(NFeABI.emit));

  nodeArray := Gerar_transmit(NFeABI.transmit);

  for i := 0 to NFeABI.transmit.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  nodeArray := Gerar_adquirente(NFeABI.adquirente);

  for i := 0 to NFeABI.adquirente.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(Gerar_Imovel(NFeABI.imovel));

  nodeArray := Gerar_autXML(NFeABI.autXML);

  for i := 0 to NFeABI.autXML.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(Gerar_infOper(NFeABI.infOper));
  Result.AppendChild(Gerar_ginfTrib(NFeABI.gInfTrib));

  if (NFeABI.pag.detPagImovel.Count > 0) or
     (NFeABI.pag.detPagIncorpLote.Count > 0) then
    Result.AppendChild(Gerar_pag(NFeABI.pag));

  Result.AppendChild(Gerar_Total(NFeABI.total));
  Result.AppendChild(Gerar_InfAdic(NFeABI.infAdic));
  Result.AppendChild(Gerar_infRespTec(NFeABI.infRespTec));
end;

function TNFeABIXmlWriter.Gerar_Ide(Ide: TIde): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ide');

  Result.AppendChild(AddNode(tcInt, 'B02', 'cUF', 2, 2, 1, Ide.cUF, DSC_CUF));

  if not ValidarCodigoUF(Ide.cUF) then
    wAlerta('B02', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcInt, 'B03', 'cNF', 6, 6, 1, Ide.cNF, DSC_CDF));

  Result.AppendChild(AddNode(tcInt, 'B04', 'mod', 2, 2, 1, Ide.modelo, DSC_MOD));

  Result.AppendChild(AddNode(tcInt, 'B05', 'serie', 1, 3, 1,
                                                         Ide.serie, DSC_SERIE));

  Result.AppendChild(AddNode(tcInt, 'B06', 'nNF', 1, 9, 1, Ide.nNF, DSC_NDF));

  Result.AppendChild(AddNode(tcStr, 'B07', 'dhEmi', 25, 25, 1,
    DateTimeTodh(Ide.dhEmi) + GetUTC(CodigoUFparaUF(Ide.cUF), Ide.dhEmi), DSC_DEMI));

  Result.AppendChild(AddNode(tcStr, 'B11', 'tpNF', 1, 1, 1,
                                                tpNFToStr(Ide.tpNF), DSC_TPNF));

  Result.AppendChild(AddNode(tcStr, 'B21', 'tpImp', 1, 1, 1,
                                             tpImpToStr(Ide.tpImp), DSC_TPIMP));

  Result.AppendChild(Gerar_gModNat(Ide.gModNat));

  Result.AppendChild(AddNode(tcStr, 'B08', 'tpEmis', 1, 1, 1,
                                     TipoEmissaoToStr(Ide.tpEmis), DSC_TPEMIS));

  Result.AppendChild(AddNode(tcStr, 'B10', 'nSiteAutoriz', 1, 1, 1,
                     SiteAutorizadorToStr(ide.nSiteAutoriz), DSC_NSITEAUTORIZ));

  Result.AppendChild(AddNode(tcInt, 'B11', 'cDV', 1, 1, 1, Ide.cDV, DSC_CDV));

  Result.AppendChild(AddNode(tcStr, 'B12', 'tpAmb', 1, 1, 1,
                                      TipoAmbienteToStr(Ide.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNode(tcStr, 'B13', 'finNFe', 1, 1, 1,
                                          finNFeToStr(Ide.finNFe), DSC_FINNFE));

  Result.AppendChild(AddNode(tcStr, 'B14', 'procEmi', 1, 1, 1,
                                       procEmiToStr(Ide.procEmi), DSC_PROCEMI));

  Result.AppendChild(AddNode(tcStr, 'B13', 'verProc', 1, 20, 1,
                                                     Ide.verProc, DSC_VERPROC));

  if Ide.gCont.dhCont > 0 then
    Result.AppendChild(Gerar_gCont(Ide.gCont));
end;

function TNFeABIXmlWriter.Gerar_gModNat(gModNat: TgModNat): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gModNat');

  Result.AppendChild(AddNode(tcInt, 'B02', 'modOper', 2, 2, 1,
                                                 gModNat.modOper, DSC_MODOPER));

  Result.AppendChild(AddNode(tcInt, 'B02', 'natOper', 2, 2, 1,
                                                 gModNat.natOper, DSC_NATOPER));

  Result.AppendChild(AddNode(tcInt, 'B02', 'detOper', 2, 2, 0,
                                                 gModNat.detOper, DSC_DETOPER));
end;

function TNFeABIXmlWriter.Gerar_gCont(gCont: TgCont): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCont');

  Result.AppendChild(AddNode(tcStr, 'B28', 'dhCont', 25, 25, 1,
               DateTimeWithTimeZone(gCont.dhCont, NFeABI.ide.cUF), DSC_DHCONT));

  Result.AppendChild(AddNode(tcStr, 'B29', 'xJust', 01, 256, 1,
                                                   gCont.xJust, DSC_XJUSTCONT));
end;

function TNFeABIXmlWriter.Gerar_NFref(NFref: TNFrefCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, NFref.Count);

  for i := 0 to NFref.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('NFref');

    Result[i].AppendChild(AddNode(tcStr, 'C03', 'refNFeABI', 2, 60, 1,
                                                NFref[i].refNFeABI, DSC_CHAVE));
  end;

  if NFref.Count > 500 then
    wAlerta('F01', 'NFref', '', ERR_MSG_MAIOR_MAXIMO + '500');
end;

function TNFeABIXmlWriter.Gerar_Emit(emit: Temit): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('emit');

  Result.AppendChild(AddNodeCNPJCPF('C02', 'C02a', Emit.CNPJCPF));

  Result.AppendChild(AddNode(tcStr, 'C03', 'xNome', 2, 60, 1,
                                                        Emit.xNome, DSC_XNOME));

  Result.AppendChild(AddNode(tcStr, 'C03', 'xFant', 1, 60, 0,
                                                        Emit.xFant, DSC_XFANT));

  Result.AppendChild(Gerar_Endereco('enderEmit', emit.enderEmit));

  Result.AppendChild(AddNode(tcStr, 'C03', 'tpEmit', 1, 2, 1,
                                         tpEmitToStr(Emit.tpEmit), DSC_TPEMIT));
end;

function TNFeABIXmlWriter.Gerar_Endereco(const Tag: string;
  Endereco: TEndereco): TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, Endereco.UF,
    Endereco.xMun, Endereco.cMun);

  Result := FDocument.CreateElement(Tag);

  Result.AppendChild(AddNode(tcStr, 'C05', 'xLgr', 2, 60, 1,
                                                     Endereco.xLgr, DSC_XLGR));

  Result.AppendChild(AddNode(tcStr, 'C06', 'nro', 1, 60, 1,
          ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, Endereco.nro), DSC_NRO));

  Result.AppendChild(AddNode(tcStr, 'C07', 'xCpl', 1, 60, 0,
                                                     Endereco.xCpl, DSC_XCPL));

  Result.AppendChild(AddNode(tcStr, 'C08', 'xBairro', 2, 60, 1,
                                               Endereco.xBairro, DSC_XBAIRRO));

  Result.AppendChild(AddNode(tcInt, 'C09', 'cMun', 7, 7, 1, cMun, DSC_CMUN));

  if not ValidarMunicipio(cMun) then
    wAlerta('C09', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, 'C10', 'xMun', 2, 60, 1, xMun, DSC_XMUN));

  Result.AppendChild(AddNode(tcStr, 'C11', 'UF', 2, 2, 1, xUF, DSC_UF));

  if not ValidarUF(xUF) then
    wAlerta('C11', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, 'C12', 'CEP', 8, 8, 1,
                                                       Endereco.CEP, DSC_CEP));

  Result.AppendChild(AddNode(tcInt, 'C13', 'cPais', 4, 4, 1,
                                                     CODIGO_BRASIL, DSC_CPAIS));

  if Endereco.xPais = '' then
    Endereco.xPais := 'BRASIL';

  Result.AppendChild(AddNode(tcStr, 'C14', 'xPais', 1, 60, 1,
                                                   Endereco.xPais, DSC_XPAIS));

  Result.AppendChild(AddNode(tcStr, 'C15', 'fone', 6, 14, 0,
                                         OnlyNumber(Endereco.fone), DSC_FONE));
end;

function TNFeABIXmlWriter.Gerar_transmit(
  transmit: tTransmitCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, transmit.Count);

  for i := 0 to transmit.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('transmit');
    Result[i].SetAttribute('nTransmit', IntToStr(i + 1));

    if transmit[i].indDeclarante = tieSim then
      Result[i].AppendChild(AddNode(tcStr, 'I17c', 'indDeclarante', 1, 1, 1,
              TIndicadorExToStr(transmit[i].indDeclarante), DSC_INDDECLARANTE));

    Result[i].AppendChild(AddNodeCNPJCPF('F02', 'F03', transmit[i].CNPJCPF));

    Result[i].AppendChild(AddNode(tcStr, 'C03', 'xNome', 2, 60, 1,
                                                 transmit[i].xNome, DSC_XNOME));

    if transmit[i].enderTransmit.xLgr <> '' then
      Result[i].AppendChild(Gerar_Endereco('enderTransmit', transmit[i].enderTransmit));

    Result[i].AppendChild(AddNode(tcDe4, 'C03', 'pTransIndiv', 1, 7, 0,
                                     transmit[i].pTransIndiv, DSC_PTRANSINDIV));

    Result[i].AppendChild(AddNode(tcStr, 'I17c', 'indContrib', 1, 1, 0,
                      indContribToStr(transmit[i].indContrib), DSC_INDCONTRIB));
  end;

  if transmit.Count > 99 then
    wAlerta('F01', 'transmit', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFeABIXmlWriter.Gerar_adquirente(
  adquirente: tadquirenteCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, adquirente.Count);

  for i := 0 to adquirente.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('adquirente');
    Result[i].SetAttribute('nAdquir', IntToStr(i + 1));

    if adquirente[i].indDeclarante = tieSim then
      Result[i].AppendChild(AddNode(tcStr, 'I17c', 'indDeclarante', 1, 1, 1,
            TIndicadorExToStr(adquirente[i].indDeclarante), DSC_INDDECLARANTE));

    Result[i].AppendChild(AddNodeCNPJCPF('F02', 'F03', adquirente[i].CNPJCPF));

    Result[i].AppendChild(AddNode(tcStr, 'C03', 'xNome', 2, 60, 1,
                                               adquirente[i].xNome, DSC_XNOME));

    Result[i].AppendChild(Gerar_Endereco('enderAdquirente',
                                                adquirente[i].enderAdquirente));

    Result[i].AppendChild(AddNode(tcDe4, 'C03', 'pAquisicao', 1, 7, 0,
                                     adquirente[i].pAquisicao, DSC_PAQUISICAO));

    Result[i].AppendChild(AddNode(tcStr, 'I17c', 'indContrib', 1, 1, 0,
                    indContribToStr(adquirente[i].indContrib), DSC_INDCONTRIB));
  end;

  if adquirente.Count > 99 then
    wAlerta('F01', 'adquirente', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFeABIXmlWriter.Gerar_Imovel(Imovel: Timovel): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('imovel');

  Result.AppendChild(AddNode(tcStr, 'I17c', 'tipo', 1, 1, 1,
                                       TipoToStr(Imovel.tipo), DSC_TIPOIMOVEL));

  Result.AppendChild(Gerar_Cadastro(Imovel.cadastro));

  Result.AppendChild(AddNode(tcStr, 'D02', 'espImovel', 2, 2, 1,
                                              Imovel.espImovel, DSC_ESPIMOVEL));

  Result.AppendChild(AddNode(tcStr, 'D03', 'xOutrosEspecies', 1, 60, 0,
                                  Imovel.xOutrosEspecies, DSC_XOUTROSESPECIES));

  Result.AppendChild(AddNode(tcStr, 'D02', 'enquadramento', 2, 2, 1,
                                      Imovel.enquadramento, DSC_ENQUADRAMENTO));

  Result.AppendChild(Gerar_Endereco('enderImovel', Imovel.enderImovel));

  Result.AppendChild(AddNode(tcStr, 'D03', 'obsLocalImovel', 2, 200, 0,
                                    Imovel.obsLocalImovel, DSC_OBSLOCALIMOVEL));

  Result.AppendChild(AddNode(tcDe2, 'D03', 'areaTotal', 1, 15, 0,
                                              Imovel.areaTotal, DSC_AREATOTAL));

  if Imovel.areaTotal > 0 then
    Result.AppendChild(AddNode(tcStr, 'G25', 'uAreaTotal', 2, 3, 1,
                           uareaTotalToStr(Imovel.uAreaTotal), DSC_UAREATOTAL));

  Result.AppendChild(AddNode(tcStr, 'D03', 'cartorioRegistro', 2, 60, 0,
                                Imovel.cartorioRegistro, DSC_CARTORIOREGISTRO));

  Result.AppendChild(AddNode(tcStr, 'D03', 'matricTransc', 2, 60, 0,
                                        Imovel.matricTransc, DSC_MATRICTRANSC));
end;

function TNFeABIXmlWriter.Gerar_Cadastro(Cadastro: TCadastro): TACBrXmlNode;
begin
  Result := nil;

  if (Cadastro.cCIB <> '') or (Cadastro.indIPTU = tiSim) or
     (Cadastro.nIptu <> '') or (Cadastro.indIncra = tiSim) or
     (Cadastro.nIncra <> '') then
  begin
    Result := FDocument.CreateElement('cadastro');

    Result.AppendChild(AddNode(tcStr, 'D09', 'cCIB', 2, 60, 0,
                                                      Cadastro.cCIB, DSC_CCIB));

    if Cadastro.indIPTU = tiSim then
      Result.AppendChild(AddNode(tcStr, 'I17c', 'indIPTU', 1, 1, 1,
                               TIndicadorToStr(Cadastro.indIPTU), DSC_INDIPTU));

    Result.AppendChild(AddNode(tcStr, 'D09', 'nIptu', 2, 60, 0,
                                                    Cadastro.nIptu, DSC_NIPTU));

    if Cadastro.indIncra = tiSim then
      Result.AppendChild(AddNode(tcStr, 'I17c', 'indIncra', 1, 1, 1,
                             TIndicadorToStr(Cadastro.indIncra), DSC_INDINCRA));

    Result.AppendChild(AddNode(tcStr, 'D09', 'nIncra', 2, 60, 0,
                                                  Cadastro.nIncra, DSC_NINCRA));
  end;
end;

function TNFeABIXmlWriter.Gerar_autXML(autXML: TautXMLCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, autXML.Count);

  for i := 0 to autXML.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('autXML');
    Result[i].AppendChild(AddNodeCNPJCPF('F02', 'F03', autXML[i].CNPJCPF));
  end;

  if autXML.Count > 10 then
    wAlerta('F01', 'autXML', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFeABIXmlWriter.Gerar_infOper(infOper: TinfOper): TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := FDocument.CreateElement('infOper');

  Result.AppendChild(AddNode(tcDe4, 'W16', 'pTransImovel', 1, 15, 0,
                                       infOper.pTransImovel, DSC_PTRANSIMOVEL));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vTotalOperacao', 1, 15, 1,
                                   infOper.vTotalOperacao, DSC_VTOTALOPERACAO));

  if infOper.indTorna = tiSim then
    Result.AppendChild(AddNode(tcStr, 'I17c', 'indTorna', 1, 1, 1,
                              TIndicadorToStr(infOper.indTorna), DSC_INDTORNA));

  if infOper.gTorna.vTorna > 0 then
    Result.AppendChild(Gerar_gTorna(infOper.gTorna));

  Result.AppendChild(Gerar_gIncorpLote(infOper.gIncorpLote));

  if infOper.gRedAjusteImovel.vRedAjusteImovel > 0 then
    Result.AppendChild(Gerar_gRedAjusteImovel(infOper.gRedAjusteImovel));

  if infOper.indRedSocial = tiSim then
    Result.AppendChild(AddNode(tcStr, 'I17c', 'indRedSocial', 1, 1, 1,
                      TIndicadorToStr(infOper.indRedSocial), DSC_INDREDSOCIAL));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vRedSocial', 1, 15, 1,
                                           infOper.vRedSocial, DSC_VREDSOCIAL));

  Result.AppendChild(Gerar_instrumento(infOper.instrumento));

  if infOper.indIntermedCorret = tiSim then
    Result.AppendChild(AddNode(tcStr, 'I17c', 'indIntermedCorret', 1, 1, 1,
            TIndicadorToStr(infOper.indIntermedCorret), DSC_INDINTERMEDCORRET));

  nodeArray := Gerar_gIntermedCorret(infOper.gIntermedCorret);

  for i := 0 to infOper.gIntermedCorret.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
end;

function TNFeABIXmlWriter.Gerar_gTorna(gTorna: TgTorna): TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := FDocument.CreateElement('gTorna');

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vTorna', 1, 15, 1,
                                                    gTorna.vTorna, DSC_VTORNA));

  nodeArray := Gerar_imovelTorna(gTorna.imovelTorna);

  for i := 0 to gTorna.imovelTorna.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
end;

function TNFeABIXmlWriter.Gerar_imovelTorna(
  imovelTorna: timovelTornaCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, imovelTorna.Count);

  for i := 0 to imovelTorna.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('imovelTorna');

    Result[i].AppendChild(AddNode(tcStr, 'I17c', 'tipo', 1, 1, 1,
                        TipoToStr(imovelTorna[i].Imovel.tipo), DSC_TIPOIMOVEL));

    Result[i].AppendChild(Gerar_Cadastro(imovelTorna[i].Imovel.cadastro));

    Result[i].AppendChild(AddNode(tcStr, 'D02', 'espImovel', 2, 2, 1,
                               imovelTorna[i].Imovel.espImovel, DSC_ESPIMOVEL));

    Result[i].AppendChild(AddNode(tcStr, 'D03', 'xOutrosEspecies', 1, 60, 0,
                   imovelTorna[i].Imovel.xOutrosEspecies, DSC_XOUTROSESPECIES));

    Result[i].AppendChild(AddNode(tcStr, 'D02', 'enquadramento', 2, 2, 1,
                       imovelTorna[i].Imovel.enquadramento, DSC_ENQUADRAMENTO));

    Result[i].AppendChild(Gerar_Endereco('enderImovel',
                                            imovelTorna[i].Imovel.enderImovel));

    Result[i].AppendChild(AddNode(tcStr, 'D03', 'obsLocalImovel', 2, 200, 0,
                     imovelTorna[i].Imovel.obsLocalImovel, DSC_OBSLOCALIMOVEL));

    Result[i].AppendChild(AddNode(tcDe2, 'D03', 'areaTotal', 1, 15, 0,
                               imovelTorna[i].Imovel.areaTotal, DSC_AREATOTAL));

    if imovelTorna[i].Imovel.areaTotal > 0 then
    Result[i].AppendChild(AddNode(tcStr, 'G25', 'uAreaTotal', 2, 3, 1,
            uareaTotalToStr(imovelTorna[i].Imovel.uAreaTotal), DSC_UAREATOTAL));

    Result[i].AppendChild(AddNode(tcStr, 'D03', 'cartorioRegistro', 2, 60, 0,
                 imovelTorna[i].Imovel.cartorioRegistro, DSC_CARTORIOREGISTRO));

    Result[i].AppendChild(AddNode(tcStr, 'D03', 'matricTransc', 2, 60, 0,
                          imovelTorna[i].Imovel.matricTransc, DSC_MATRICTRANSC));
  end;

  if imovelTorna.Count > 30 then
    wAlerta('F01', 'imovelTorna', '', ERR_MSG_MAIOR_MAXIMO + '30');
end;

function TNFeABIXmlWriter.Gerar_gIncorpLote(
  gIncorpLote: TgIncorpLote): TACBrXmlNode;
begin
  Result := nil;

  if (gIncorpLote.indIncorpLote = tiSim) or
     (gIncorpLote.CNPJempImob <> '') or (gIncorpLote.cCIBObra <> '') then
  begin
    Result := FDocument.CreateElement('gIncorpLote');

    if gIncorpLote.indIncorpLote = tiSim then
      Result.AppendChild(AddNode(tcStr, 'I17c', 'indIncorpLote', 1, 1, 1,
                TIndicadorToStr(gIncorpLote.indIncorpLote), DSC_INDINCORPLOTE));

    Result.AppendChild(AddNode(tcStr, 'D09', 'CNPJempImob', 14, 14, 0,
                                     gIncorpLote.CNPJempImob, DSC_CNPJEMPIMOB));

    Result.AppendChild(AddNode(tcStr, 'D09', 'cCIBObra', 2, 60, 0,
                                           gIncorpLote.cCIBObra, DSC_CCIBOBRA));
  end;
end;

function TNFeABIXmlWriter.Gerar_gRedAjusteImovel(
  gRedAjusteImovel: TgRedAjusteImovel): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gRedAjusteImovel');

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vInicial', 1, 15, 0,
                                      gRedAjusteImovel.vInicial, DSC_VINICIAL));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vITBI', 1, 15, 0,
                                            gRedAjusteImovel.vITBI, DSC_VITBI));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vLaudemio', 1, 15, 0,
                                    gRedAjusteImovel.vLaudemio, DSC_VLAUDEMIO));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vContrap', 1, 15, 0,
                                      gRedAjusteImovel.vContrap, DSC_VCONTRAP));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vRedAjusteImovel', 1, 15, 1,
                      gRedAjusteImovel.vRedAjusteImovel, DSC_VREDAJUSTEIMOVEL));
end;

function TNFeABIXmlWriter.Gerar_instrumento(
  instrumento: Tinstrumento): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('instrumento');

  Result.AppendChild(AddNode(tcInt, 'W16', 'tpInstrumento', 2, 2, 1,
                                 instrumento.tpInstrumento, DSC_TPINSTRUMENTO));

  Result.AppendChild(AddNode(tcStr, 'W16', 'xOutrosInst', 1, 60, 0,
                                     instrumento.xOutrosInst, DSC_XOUTROSINST));

  Result.AppendChild(AddNode(tcDat, 'W16', 'dtInstrumento', 10, 10, 1,
                                 instrumento.dtInstrumento, DSC_DTINSTRUMENTO));
end;

function TNFeABIXmlWriter.Gerar_gIntermedCorret(
  gIntermedCorret: tgIntermedCorretCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, gIntermedCorret.Count);

  for i := 0 to gIntermedCorret.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gIntermedCorret');
    Result[i].SetAttribute('nCorretagem', IntToStr(i + 1));

    Result[i].AppendChild(AddNodeCNPJCPF('F02', 'F03', gIntermedCorret[i].CNPJCPF));

    Result[i].AppendChild(AddNode(tcStr, 'W16', 'xNome', 2, 60, 1,
                                          gIntermedCorret[i].xNome, DSC_XNOME));

    Result[i].AppendChild(AddNode(tcDe2, 'W16', 'vCorretagem', 1, 15, 1,
                              gIntermedCorret[i].vCorretagem, DSC_VCORRETAGEM));
  end;

  if gIntermedCorret.Count > 99 then
    wAlerta('F01', 'gIntermedCorret', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFeABIXmlWriter.Gerar_ginfTrib(ginfTrib: TginfTrib): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gInfTrib');

  Result.AppendChild(Gerar_gCompraGovReduzido(ginfTrib.gCompraGov));

  Result.AppendChild(Gerar_IBSCBS(ginfTrib.IBSCBS));
end;

function TNFeABIXmlWriter.Gerar_pag(pag: Tpag): TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := FDocument.CreateElement('pag');

  nodeArray := Gerar_detPagImovel(pag.detPagImovel);

  for i := 0 to pag.detPagImovel.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  nodeArray := Gerar_detPagIncorpLote(pag.detPagIncorpLote);

  for i := 0 to pag.detPagIncorpLote.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
end;

function TNFeABIXmlWriter.Gerar_detPagImovel(
  detPagImovel: tdetPagImovelCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, detPagImovel.Count);

  for i := 0 to detPagImovel.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('detPagImovel');
    Result[i].SetAttribute('nDetPag', IntToStr(i + 1));

    Result[i].AppendChild(AddNode(tcInt, 'W16', 'tPag', 2, 2, 1,
                                               detPagImovel[i].tPag, DSC_TPAG));

    Result[i].AppendChild(AddNode(tcStr, 'W16', 'xPag', 6, 120, 0,
                                               detPagImovel[i].xPag, DSC_XPAG));

    Result[i].AppendChild(AddNode(tcDe2, 'W16', 'vPag', 1, 15, 1,
                                               detPagImovel[i].vPag, DSC_VPAG));
  end;

  if detPagImovel.Count > 99 then
    wAlerta('F01', 'detPagImovel', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFeABIXmlWriter.Gerar_detPagIncorpLote(
  detPagIncorpLote: tdetPagIncorpLoteCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, detPagIncorpLote.Count);

  for i := 0 to detPagIncorpLote.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('detPagIncorpLote');
    Result[i].SetAttribute('nDetPag', IntToStr(i + 1));

    Result[i].AppendChild(AddNode(tcStr, 'W16', 'tParcela', 1, 16, 1,
                                   detPagIncorpLote[i].tParcela, DSC_TPARCELA));

    Result[i].AppendChild(AddNode(tcInt, 'W16', 'nParcela', 1, 3, 1,
                                   detPagIncorpLote[i].nParcela, DSC_NPARCELA));

    Result[i].AppendChild(AddNode(tcStr, 'W16', 'xParcela', 6, 400, 0,
                                   detPagIncorpLote[i].xParcela, DSC_XPARCELA));
  end;

  if detPagIncorpLote.Count > 99 then
    wAlerta('F01', 'detPagIncorpLote', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFeABIXmlWriter.Gerar_Total(total: Ttotal): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('total');

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vTotalOperacao', 1, 15, 1,
                                     Total.vTotalOperacao, DSC_VTOTALOPERACAO));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vOperacIndiv', 1, 15, 1,
                                         Total.vOperacIndiv, DSC_VOPERACINDIV));

  Result.AppendChild(Gerar_tribTot(Total));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vNF', 1, 15, 1,
                                                        Total.vNF, DSC_VNFABI));
end;

function TNFeABIXmlWriter.Gerar_tribTot(total: Ttotal): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('tribTot');

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vRedAjusteIndiv', 1, 15, 1,
                                   Total.vRedAjusteIndiv, DSC_VREDAJUSTEINDIV));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vRedSocialIndiv', 1, 15, 1,
                                   Total.vRedSocialIndiv, DSC_VREDSOCIALINDIV));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vBC', 1, 15, 1,
                                                           Total.vBC, DSC_VBC));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vIBSUF', 1, 15, 1,
                                                     Total.vIBSUF, DSC_VIBSUF));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vIBSMun', 1, 15, 1,
                                                   Total.vIBSMun, DSC_VIBSMUN));

  Result.AppendChild(AddNode(tcDe2, 'W16', 'vCBS', 1, 15, 1,
                                                         Total.vCBS, DSC_VCBS));
end;

function TNFeABIXmlWriter.Gerar_InfAdic(infAdic: TinfAdic): TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := nil;

  if (trim(InfAdic.infAdFisco) <> '') or (trim(InfAdic.infCpl) <> '') or
     (InfAdic.obsCont.Count > 0) or (InfAdic.obsFisco.Count > 0) then
  begin
    Result := FDocument.CreateElement('infAdic');

    Result.AppendChild(AddNode(tcStr, 'Z02', 'infAdFisco', 01, 5000, 0,
                                       InfAdic.infAdFisco, DSC_INFADFISCO));

    Result.AppendChild(AddNode(tcStr, 'Z03', 'infCpl', 01, 5000, 0,
                                               InfAdic.infCpl, DSC_INFCPL));

    nodeArray := Gerar_ObsCont(infAdic.obsCont);

    for i := 0 to infAdic.obsCont.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;

    nodeArray := Gerar_ObsFisco(infAdic.obsFisco);

    for i := 0 to infAdic.obsFisco.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFeABIXmlWriter.Gerar_ObsCont(
  ObsCont: tObsContCollection): TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, ObsCont.Count);

  for i := 0 to ObsCont.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('obsCont');

    Result[i].SetAttribute('xCampo', ObsCont[i].xCampo);

    Result[i].AppendChild(AddNode(tcStr, 'Z09', 'xTexto', 01, 60, 1,
                                    ObsCont[i].xTexto, DSC_XTEXTO));
  end;

  if ObsCont.Count > 10 then
    wAlerta('Z07', 'obsECT', DSC_OBSCONT, ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFeABIXmlWriter.Gerar_ObsFisco(
  ObsFisco: tObsFiscoCollection): TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, ObsFisco.Count);

  for i := 0 to ObsFisco.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('obsFisco');

    Result[i].SetAttribute('xCampo', ObsFisco[i].xCampo);

    Result[i].AppendChild(AddNode(tcStr, 'Z09', 'xTexto', 01, 60, 1,
                                    ObsFisco[i].xTexto, DSC_XTEXTO));
  end;

  if ObsFisco.Count > 10 then
    wAlerta('Z07', 'ObsFisco', DSC_OBSCONT, ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFeABIXmlWriter.Gerar_infRespTec(
  infRespTec: TinfRespTec): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infRespTec');

  Result.AppendChild(AddNodeCNPJ('#82', infRespTec.CNPJ, CODIGO_BRASIL, True));

  Result.AppendChild(AddNode(tcStr, '#083', 'xContato', 02, 60, 1,
                                            infRespTec.xContato, DSC_XCONTATO));

  Result.AppendChild(AddNode(tcStr, '#084', 'email', 06, 60, 1,
                                                  infRespTec.email, DSC_EMAIL));

  Result.AppendChild(AddNode(tcStr, '#085', 'fone', 07, 12, 1,
                                                    infRespTec.fone, DSC_FONE));
end;

function TNFeABIXmlWriter.Gerar_ProtNFeABI: TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('protNFeABI');

  Result.SetAttribute('versao', FloatToString(NFeABI.infNFeABI.Versao, '.', '#0.00'));

  xmlNode := Result.AddChild('infProt');

  xmlNode.AddChild('tpAmb').Content := TipoAmbienteToStr(NFeABI.procNFeABI.tpAmb);

  xmlNode.AddChild('verAplic').Content := NFeABI.procNFeABI.verAplic;

  xmlNode.AddChild('chNFeABI').Content := NFeABI.procNFeABI.chDFe;

  xmlNode.AddChild('dhRecbto').Content :=
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', NFeABI.procNFeABI.dhRecbto) +
    GetUTC(CodigoUFparaUF(NFeABI.Ide.cUF), NFeABI.procNFeABI.dhRecbto);

  xmlNode.AddChild('nProt').Content := NFeABI.procNFeABI.nProt;

  xmlNode.AddChild('digVal').Content := NFeABI.procNFeABI.digVal;

  xmlNode.AddChild('cStat').Content := IntToStr(NFeABI.procNFeABI.cStat);

  xmlNode.AddChild('xMotivo').Content := NFeABI.procNFeABI.xMotivo;
end;

function TNFeABIXmlWriter.GerarXml: boolean;
var
  Gerar: boolean;
  NFeABINode, xmlNode: TACBrXmlNode;
begin
  Result := False;

  ModelosDFe := mdfNFeABI;
  tpNFDebito := ACBrDFe.Conversao.tdNenhum;

  ListaDeAlertas.Clear;

  {
    Os campos abaixo tem que ser os mesmos da configuração
  }
  NFeABI.Ide.modelo := ModeloDF;
  NFeABI.infNFeABI.Versao := VersaoNFeABIToDbl(VersaoDF);
  NFeABI.Ide.tpAmb := tpAmb;
  NFeABI.Ide.modelo := 77;

  FpChave := GerarChaveAcesso(NFeABI.ide.cUF, NFeABI.ide.dhEmi, NFeABI.emit.CNPJCPF,
      NFeABI.ide.serie, NFeABI.ide.nNF, StrToInt(TipoEmissaoToStr(NFeABI.ide.tpEmis)),
      StrToInt(SiteAutorizadorToStr(NFeABI.Ide.nSiteAutoriz)),
      NFeABI.ide.cNF, NFeABI.Ide.modelo);

  NFeABI.infNFeABI.ID := 'NFeABI' + FpChave;
  NFeABI.ide.cDV := ExtrairDigitoChaveAcesso(NFeABI.infNFeABI.ID);

  FDocument.Clear();
  NFeABINode := FDocument.CreateElement('NFeABI', ACBRNFeABI_NAMESPACE);

  if NFeABI.procNFeABI.nProt <> '' then
  begin
    xmlNode := FDocument.CreateElement('NFeABIProc', ACBRNFeABI_NAMESPACE);
    xmlNode.SetAttribute('versao', FloatToString(NFeABI.infNFeABI.Versao, '.', '#0.00'));
    xmlNode.AppendChild(NFeABINode);
    FDocument.Root := xmlNode;
  end
  else
    FDocument.Root := NFeABINode;

  xmlNode := Gerar_InfNFeABI;
  NFeABINode.AppendChild(xmlNode);

  if NFeABI.infNFeSupl.qrCode <> '' then
  begin
    xmlNode := NFeABINode.AddChild('infNFeSupl');
    xmlNode.AppendChild(AddNode(tcStr, 'ZX02', 'qrCode', 100, 600, 1,
                       '<![CDATA[' + NFeABI.infNFeSupl.qrCode + ']]>', '', False));

    xmlNode.AppendChild(AddNode(tcStr, 'ZX03', 'urlChave', 21,85, 1,
                                           NFeABI.infNFeSupl.urlChave, '', False));
  end;

  Gerar := (Opcoes.GerarTagAssinatura = taSempre) or
    (
      (Opcoes.GerarTagAssinatura = taSomenteSeAssinada) and
        (NFeABI.signature.DigestValue <> '') and
        (NFeABI.signature.SignatureValue <> '') and
        (NFeABI.signature.X509Certificate <> '')
    ) or
    (
      (Opcoes.GerarTagAssinatura = taSomenteParaNaoAssinada) and
        (NFeABI.signature.DigestValue = '') and
        (NFeABI.signature.SignatureValue = '') and
        (NFeABI.signature.X509Certificate = '')
    );

  if Gerar then
  begin
    FNFeABI.signature.URI := '#NFeABI' + FPChave;
    xmlNode := GerarSignature(FNFeABI.signature);
    NFeABINode.AppendChild(xmlNode);
  end;

  if NFeABI.procNFeABI.nProt <> '' then
  begin
    xmlNode := Gerar_ProtNFeABI;
    FDocument.Root.AppendChild(xmlNode);
  end;
end;

end.
