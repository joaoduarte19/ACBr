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

unit HM2.Provider;

interface

uses
  SysUtils, Classes,
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrJSON,
  ACBrNFSeXConversao,
  ACBrNFSeXClass,
  ACBrNFSeXGravarXml, ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse;

type
  TACBrNFSeXWebserviceHM2203 = class(TACBrNFSeXWebserviceRest)
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderHM2203 = class (TACBrNFSeProviderABRASFv2)
  private
    FMethod: string;
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ValidarSchema(Response: TNFSeWebserviceResponse; aMetodo: TMetodo); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'Erros'); virtual;

    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure PrepararConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;
    procedure TratarRetornoCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;
    {
    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;
    }
    property Method: string read FMethod write FMethod;
  end;

implementation

uses
  synacode,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXNotasFiscais,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  HM2.GravarXml, HM2.LerXml;

{ TACBrNFSeProviderHM2203 }

procedure TACBrNFSeProviderHM2203.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    ModoEnvio := meLoteAssincrono;
    FormatoArqRetorno := tfaJson;
    FormatoArqRetornoSoap := tfaJson;

    ServicosDisponibilizados.EnviarLoteAssincrono := True;
    ServicosDisponibilizados.ConsultarRps := True;
    ServicosDisponibilizados.CancelarNfse := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.03';
    VersaoAtrib := '2.03';
    AtribVerLote := 'versao';
  end;

  SetXmlNameSpace('http://www.abrasf.org.br/nfse.xsd');
  {
  with ConfigMsgDados do
  begin
    // Usado para gerar ou não o grupo <Prestador>
    GerarPrestadorLoteRps := False;

    // Usado na tag raiz dos XML de envio do Lote, Consultas, etc.
    Prefixo := '';

    UsarNumLoteConsLote := False;

    DadosCabecalho := GetCabecalho('');
  end;
  }
  with ConfigAssinar do
  begin
    Rps := True;
//    LoteRps           := True;
  end;

  SetNomeXSD('nfse.xsd');

  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderHM2203.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_HM2203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderHM2203.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_HM2203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderHM2203.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL{, AMimeType}: string;
begin
  URL := GetWebServiceURL(AMetodo) + '?sys=TRB';
//  AMimeType := 'application/xml';
  Method := 'POST';

  if URL <> '' then
    Result := TACBrNFSeXWebserviceHM2203.Create(FAOwner, AMetodo, URL, Method{,
      AMimeType})
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderHM2203.ValidarSchema(
  Response: TNFSeWebserviceResponse; aMetodo: TMetodo);
begin
  if aMetodo = tmRecepcionar then
  begin
    inherited ValidarSchema(Response, aMetodo);

    Response.ArquivoEnvio := Format('{"xml": "%s"}', [Response.ArquivoEnvio]);
  end;
end;

procedure TACBrNFSeProviderHM2203.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  JSonLista: TACBrJSONArray;
  JSon: TACBrJSONObject;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo, Descricao: string;
  begin
    Codigo := JSonItem.AsString['código'];
    Descricao := JSonItem.AsString['descrição'];

    if (Codigo <> '') or (Descricao <> '') then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := Descricao;
      AItem.Correcao := JSonItem.AsString['complemento'];
    end
    else
    begin
      Codigo := JSonItem.AsString['código'];

      if Codigo <> '' then
      begin
        AItem := Collection.New;
        AItem.Codigo := Codigo;
        AItem.Descricao := JSonItem.AsString['descrição'];
        AItem.Correcao := JSonItem.AsString['complemento'];
      end;
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
  begin
    for i := 0 to jsLista.Count-1 do
    begin
      JSon := jsLista.ItemAsJSONObject[i];

      AdicionaCollectionItem(JSon, Collection);
    end;
  end;

  procedure VerificaSeObjetoOuArray(aNome: string; Collection: TNFSeEventoCollection);
  begin
    // Verifica se no retorno contem um objeto ou array
    if LJson.IsJSONArray(aNome) then
    begin
      JSonLista := LJson.AsJSONArray[aNome];

      if JSonLista.Count > 0 then
        LerListaErrosAlertas(JSonLista, Collection);
    end
    else
    begin
      JSon := LJson.AsJSONObject[aNome];

      if JSon <> nil then
        AdicionaCollectionItem(JSon, Collection);
    end;
  end;
begin
  // Verifica se no retorno contem a lista de Erros
  VerificaSeObjetoOuArray(AListTag, Response.Erros);
  // Verifica se no retorno contem a lista de erros
  VerificaSeObjetoOuArray('erros', Response.Erros);
  // Verifica se no retorno contem a lista de erro
  VerificaSeObjetoOuArray('erro', Response.Erros);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('Alertas', Response.Alertas);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('alertas', Response.Alertas);
end;

procedure TACBrNFSeProviderHM2203.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
//  DocumentXml: TACBrXmlDocument;
//  ANode: TACBrXmlNode;
//  NumNFSe, NumDps, CodVerif: string;
//  DataAut: TDateTime;
//  ANota: TNotaFiscal;

  procedure LerNFSe(NFSeXml: string);
  begin
    if NFSeXml = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit
    end;

//    DocumentXml := TACBrXmlDocument.Create;

    try
      try
      {
        DocumentXml.LoadFromXml(NFSeXml);

        ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

        CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
        NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
        DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        ANode := ANode.Childrens.FindAnyNs('DPS');
        ANode := ANode.Childrens.FindAnyNs('infDPS');
        NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

        Response.NumeroNota := NumNFSe;
        Response.Data := DataAut;
        Response.XmlRetorno := NFSeXml;

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

        ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);
        SalvarXmlNfse(ANota);
        }
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
//      FreeAndNil(DocumentXml);
    end;
  end;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['idDPS'];

      if Response.idNota = '' then
        Response.idNota := Document.AsString['idDps'];

      Response.Link := Document.AsString['chaveAcesso'];
      NFSeXml := Document.AsString['nfseXmlGZipB64'];

      if NFSeXml <> '' then
      begin
//        NFSeXml := DeCompress(DecodeBase64(NFSeXml));

//        NFSeXml := TrocaEscapeporConchete(NFSeXml);

        LerNFSe(NFSeXml);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderHM2203.PrepararConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.NumeroRps) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod102;
    AErro.Descricao := ACBrStr(Desc102);
    Exit;
  end;

  Response.ArquivoEnvio := Format('{"numeroRPS": "%s"}', [Response.NumeroRps]);
end;

procedure TACBrNFSeProviderHM2203.TratarRetornoConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
//  DocumentXml: TACBrXmlDocument;
//  ANode: TACBrXmlNode;
//  NumNFSe, NumDps, CodVerif: string;
//  DataAut: TDateTime;
//  ANota: TNotaFiscal;

  procedure LerNFSe(NFSeXml: string);
  begin
    if NFSeXml = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit
    end;

//    DocumentXml := TACBrXmlDocument.Create;

    try
      try
      {
        DocumentXml.LoadFromXml(NFSeXml);

        ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

        CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
        NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
        DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        ANode := ANode.Childrens.FindAnyNs('DPS');
        ANode := ANode.Childrens.FindAnyNs('infDPS');
        NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

        Response.NumeroNota := NumNFSe;
        Response.Data := DataAut;
        Response.XmlRetorno := NFSeXml;

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

        ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);
        SalvarXmlNfse(ANota);
        }
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
//      FreeAndNil(DocumentXml);
    end;
  end;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['idDPS'];

      if Response.idNota = '' then
        Response.idNota := Document.AsString['idDps'];

      Response.Link := Document.AsString['chaveAcesso'];
      NFSeXml := Document.AsString['nfseXmlGZipB64'];

      if NFSeXml <> '' then
      begin
//        NFSeXml := DeCompress(DecodeBase64(NFSeXml));

//        NFSeXml := TrocaEscapeporConchete(NFSeXml);

        LerNFSe(NFSeXml);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderHM2203.PrepararConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.InfConsultaNFSe.CodServ) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod123;
    AErro.Descricao := ACBrStr(Desc123);
    Exit;
  end;

  Response.ArquivoEnvio := Format('{"itemlistaservico": "%s", "datainicial": "%s", "datafinal": "%s"}',
    [Response.InfConsultaNFSe.CodServ,
     FormatDateBr(Response.InfConsultaNFSe.DataInicial, 'YYYY-MM-DD'),
     FormatDateBr(Response.InfConsultaNFSe.DataFinal, 'YYYY-MM-DD')]);
end;

procedure TACBrNFSeProviderHM2203.TratarRetornoConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
//  DocumentXml: TACBrXmlDocument;
//  ANode: TACBrXmlNode;
//  NumNFSe, NumDps, CodVerif: string;
//  DataAut: TDateTime;
//  ANota: TNotaFiscal;

  procedure LerNFSe(NFSeXml: string);
  begin
    if NFSeXml = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit
    end;

//    DocumentXml := TACBrXmlDocument.Create;

    try
      try
      {
        DocumentXml.LoadFromXml(NFSeXml);

        ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

        CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
        NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
        DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        ANode := ANode.Childrens.FindAnyNs('DPS');
        ANode := ANode.Childrens.FindAnyNs('infDPS');
        NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

        Response.NumeroNota := NumNFSe;
        Response.Data := DataAut;
        Response.XmlRetorno := NFSeXml;

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

        ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);
        SalvarXmlNfse(ANota);
        }
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
//      FreeAndNil(DocumentXml);
    end;
  end;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['idDPS'];

      if Response.idNota = '' then
        Response.idNota := Document.AsString['idDps'];

      Response.Link := Document.AsString['chaveAcesso'];
      NFSeXml := Document.AsString['nfseXmlGZipB64'];

      if NFSeXml <> '' then
      begin
//        NFSeXml := DeCompress(DecodeBase64(NFSeXml));

//        NFSeXml := TrocaEscapeporConchete(NFSeXml);

        LerNFSe(NFSeXml);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderHM2203.PrepararConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.InfConsultaNFSe.CodServ) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod123;
    AErro.Descricao := ACBrStr(Desc123);
    Exit;
  end;

  Response.ArquivoEnvio := Format('{"itemlistaservico": "%s", "datainicial": "%s", "datafinal": "%s"}',
    [Response.InfConsultaNFSe.CodServ,
     FormatDateBr(Response.InfConsultaNFSe.DataInicial, 'YYYY-MM-DD'),
     FormatDateBr(Response.InfConsultaNFSe.DataFinal, 'YYYY-MM-DD')]);
end;

procedure TACBrNFSeProviderHM2203.TratarRetornoConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
//  DocumentXml: TACBrXmlDocument;
//  ANode: TACBrXmlNode;
//  NumNFSe, NumDps, CodVerif: string;
//  DataAut: TDateTime;
//  ANota: TNotaFiscal;

  procedure LerNFSe(NFSeXml: string);
  begin
    if NFSeXml = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit
    end;

//    DocumentXml := TACBrXmlDocument.Create;

    try
      try
      {
        DocumentXml.LoadFromXml(NFSeXml);

        ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

        CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
        NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
        DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        ANode := ANode.Childrens.FindAnyNs('DPS');
        ANode := ANode.Childrens.FindAnyNs('infDPS');
        NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

        Response.NumeroNota := NumNFSe;
        Response.Data := DataAut;
        Response.XmlRetorno := NFSeXml;

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

        ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);
        SalvarXmlNfse(ANota);
        }
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
//      FreeAndNil(DocumentXml);
    end;
  end;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['idDPS'];

      if Response.idNota = '' then
        Response.idNota := Document.AsString['idDps'];

      Response.Link := Document.AsString['chaveAcesso'];
      NFSeXml := Document.AsString['nfseXmlGZipB64'];

      if NFSeXml <> '' then
      begin
//        NFSeXml := DeCompress(DecodeBase64(NFSeXml));

//        NFSeXml := TrocaEscapeporConchete(NFSeXml);

        LerNFSe(NFSeXml);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderHM2203.PrepararCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  if EstaVazio(Response.InfCancelamento.NumeroNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod108;
    AErro.Descricao := ACBrStr(Desc108);
    Exit;
  end;

  if EstaVazio(Response.InfCancelamento.MotCancelamento) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod110;
    AErro.Descricao := ACBrStr(Desc110);
    Exit;
  end;

  if EstaVazio(Response.InfCancelamento.CodCancelamento) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod109;
    AErro.Descricao := ACBrStr(Desc109);
    Exit;
  end;

  Response.ArquivoEnvio := Format('{"numeronotacancelamento": "%s", "motivocancelamento": "%s", "descricaocancelamento": "%s"}',
    [Response.InfCancelamento.NumeroNFSe,
     Response.InfCancelamento.MotCancelamento,
     Response.InfCancelamento.CodCancelamento]);
end;

procedure TACBrNFSeProviderHM2203.TratarRetornoCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
//  DocumentXml: TACBrXmlDocument;
//  ANode: TACBrXmlNode;
//  NumNFSe, NumDps, CodVerif: string;
//  DataAut: TDateTime;
//  ANota: TNotaFiscal;

  procedure LerNFSe(NFSeXml: string);
  begin
    if NFSeXml = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit
    end;

//    DocumentXml := TACBrXmlDocument.Create;

    try
      try
      {
        DocumentXml.LoadFromXml(NFSeXml);

        ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

        CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
        NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
        DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        ANode := ANode.Childrens.FindAnyNs('DPS');
        ANode := ANode.Childrens.FindAnyNs('infDPS');
        NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

        Response.NumeroNota := NumNFSe;
        Response.Data := DataAut;
        Response.XmlRetorno := NFSeXml;

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

        ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);
        SalvarXmlNfse(ANota);
        }
      except
        on E:Exception do
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod999;
          AErro.Descricao := ACBrStr(Desc999 + E.Message);
        end;
      end;
    finally
//      FreeAndNil(DocumentXml);
    end;
  end;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);

  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);

      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];
      Response.idNota := Document.AsString['idDPS'];

      if Response.idNota = '' then
        Response.idNota := Document.AsString['idDps'];

      Response.Link := Document.AsString['chaveAcesso'];
      NFSeXml := Document.AsString['nfseXmlGZipB64'];

      if NFSeXml <> '' then
      begin
//        NFSeXml := DeCompress(DecodeBase64(NFSeXml));

//        NFSeXml := TrocaEscapeporConchete(NFSeXml);

        LerNFSe(NFSeXml);
      end;
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

{ TACBrNFSeXWebserviceHM2203 }

procedure TACBrNFSeXWebserviceHM2203.SetHeaders(aHeaderReq: THTTPHeader);
var
  Auth: string;
begin
  if TACBrNFSeX(FPDFeOwner).Provider.ConfigGeral.UseAuthorizationHeader then
  begin
    with TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente do
      Auth := 'Basic ' + string(EncodeBase64(AnsiString(WSUser + ':' +
        AnsiString(WSSenha))));

//    aHeaderReq.AddHeader('Content-Type', 'application/x-www-form-urlencoded');
    aHeaderReq.AddHeader('Authorization', Auth);
  end;
end;

function TACBrNFSeXWebserviceHM2203.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceHM2203.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceHM2203.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceHM2203.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceHM2203.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := AMSG;

  Result := Executar('', Request, [], []);
end;

function TACBrNFSeXWebserviceHM2203.TratarXmlRetornado(
  const aXML: string): string;
var
  lJSON, lErroJSON: TACBrJSONObject;
  lJSONArray: TACBrJSONArray;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ConverteANSItoUTF8(Result);

  if not StringIsPDF(Result) then
  begin
    Result := UTF8Decode(Result);

    if not StringIsJSON(Result) then
    begin
      lJSON := TACBrJSONObject.Create;
      try
        lJSONArray := TACBrJSONArray.Create;
        try
          lErroJSON := TACBrJSONObject.Create;
          try
            lJSON.AddPair('tipoAmbiente', EmptyStr);
            lJSON.AddPair('versaoAplicativo', EmptyStr);
            lJSON.AddPair('dataHoraProcessamento', EmptyStr);
            lJSON.AddPair('idDps', EmptyStr);
            lJSON.AddPair('chaveAcesso', EmptyStr);
            lJSON.AddPair('nfseXmlGZipB64', EmptyStr);

            lErroJSON.AddPair('mensagem', EmptyStr);
            lErroJSON.AddPair('codigo', 'E9999');
            lErroJSON.AddPair('descricao', Result);
            lErroJSON.AddPair('complemento', EmptyStr);

            lJSONArray.AddElementJSON(lErroJSON);
            lJSON.AddPair('erros', lJSONArray, False);

            Result := lJSON.ToJSON;
          finally
            //lErroJSON.Free;
          end;
        finally
          //lJSONArray.Free;
        end;
      finally
        lJSON.Free;
      end;
    end
  end;
end;

end.
