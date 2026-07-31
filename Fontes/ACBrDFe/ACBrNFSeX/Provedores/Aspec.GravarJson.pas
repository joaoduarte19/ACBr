{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Willian Delan de Oliveira                       }
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

unit Aspec.GravarJson;

interface

uses
  SysUtils,
  Classes,
  Variants,
  StrUtils,
  IniFiles,
  ACBrJSON,
  ACBrNFSeXGravarXml,
  ACBrNFSeXConversao,
  ACBrSocket;

type
  { TNFSeW_Aspec }

  TNFSeW_Aspec = class(TNFSeWClass)
  private
    FIdNBS: Integer;
    FIdIndOp: Integer;
  protected
    procedure Configuracao; override;

    function GerarPaisLocalPrestacaoServico: TACBrJSONObject;
    function GerarLocalPrestacaoServico: TACBrJSONObject;
    function GerarServicos: TACBrJSONObject;
    function GerarNBS: TACBrJSONObject;
    function GerarSitTribPisCofins: TACBrJSONObject;
    function GerarTipoRetencao: TACBrJSONObject;
    function GerarDadosNota: String;
    function GerarIndOp: TACBrJSONObject;
    function GerarClassTrib: TACBrJSONObject;

    function MontarURLBase: string;
    function NormalizarCodigo(const ACodigo: string): string;
    function ObterIdPorCodigo(const AURL, ACampoCodigo, ACampoId, ACodigoBusca: string): Integer;
    function ObterIdSubitemServico(const AIdItem: Integer; const ACodigoSubitem: string): Integer;
    function ObterIdNBS: Integer;
    function ObterIdIndOp: Integer;
    function ObterIdClassTrib: Integer;

    // Gerar o arquivo INI
    procedure GerarINIIdentificacaoNFSe(AINIRec: TMemIniFile);
    procedure GerarINIIdentificacaoPrestador(AINIRec: TMemIniFile);
    procedure GerarINIDadosTomador(AINIRec: TMemIniFile);
    procedure GerarINIIdentificacaoRps(AINIRec: TMemIniFile);
    procedure GerarINIDadosServico(AINIRec: TMemIniFile);
    procedure GerarINIDadosValores(AINIRec: TMemIniFile);
    procedure GerarINIDadosPrestador(AINIRec: TMemIniFile);
    procedure GerarINIInformacoesCancelamento(AINIRec: TMemIniFile);

    procedure GerarIniRps(AINIRec: TMemIniFile);
    procedure GerarIniNfse(AINIRec: TMemIniFile);
  public
    function GerarXml: Boolean; override;

    function GerarIni: string; override;
  end;

implementation

uses
  ACBrUtil.Strings,
  ACBrConsts;

{ TNFSeW_Aspec }

procedure TNFSeW_Aspec.Configuracao;
begin
  inherited Configuracao;

end;

function TNFSeW_Aspec.GerarXml: Boolean;
begin
  Configuracao;

  Opcoes.QuebraLinha := FpAOwner.ConfigGeral.QuebradeLinha;

  ListaDeAlertas.Clear;

  FDocument.Clear();

  FConteudoTxt.Clear;

  {$IFDEF FPC}
  FConteudoTxt.LineBreak := CRLF;
  {$ELSE}
    {$IFDEF DELPHI2006_UP}
    FConteudoTxt.LineBreak := CRLF;
    {$ENDIF}
  {$ENDIF}

  FConteudoTxt.Text := '[' + GerarDadosNota + ']';
  Result := True;
end;

function TNFSeW_Aspec.MontarURLBase: string;
begin
   Result := FpAOwner.ConfigWebServices.Producao.GerarNFSe;
   if Result = '' then
      raise Exception.Create('URL base do webservice Aspec não configurada.');
   if AnsiEndsText('/emitir', Result) then
      Result := Copy(Result, 1, Length(Result) - Length('/emitir'));
end;

function TNFSeW_Aspec.NormalizarCodigo(const ACodigo: string): string;
begin
  Result := StringReplace(Trim(ACodigo), '.', '', [rfReplaceAll]);
end;

function TNFSeW_Aspec.ObterIdPorCodigo(const AURL, ACampoCodigo, ACampoId, ACodigoBusca: string): Integer;
var
  AHttp: TACBrHTTP;
  AResposta, ACodBusca, ACodAtual: string;
  AArray: TACBrJSONArray;
  AObj: TACBrJSONObject;
  i, AQtdEncontrados: Integer;
begin
  Result := 0;
  AQtdEncontrados := 0;

  if Trim(ACodigoBusca) = '' then
    raise Exception.Create('Codigo nao informado para consulta.');

  ACodBusca := NormalizarCodigo(ACodigoBusca);

  AHttp := TACBrHTTP.Create(nil);
  try
    AHttp.HTTPGet(AURL);
    AResposta := AHttp.HTTPResponse;
  finally
    AHttp.Free;
  end;

  if Trim(AResposta) = '' then
    raise Exception.CreateFmt('Resposta vazia ao consultar. URL=%s', [AURL]);

  AArray := TACBrJSONArray.Parse(AResposta);
  try
    for i := 0 to AArray.Count - 1 do
    begin
      AObj := AArray.ItemAsJSONObject[i];
      ACodAtual := NormalizarCodigo(AObj.AsString[ACampoCodigo]);

      if ACodAtual = ACodBusca then
      begin
        if AQtdEncontrados = 0 then
          Result := AObj.AsInteger[ACampoId];
        Inc(AQtdEncontrados);
      end;
    end;
  finally
    AArray.Free;
  end;

  if Result = 0 then
    raise Exception.CreateFmt('Codigo nao encontrado na consulta. Codigo=%s, URL=%s',
      [ACodigoBusca, AURL]);
end;

function TNFSeW_Aspec.ObterIdSubitemServico(const AIdItem: Integer; const ACodigoSubitem: string): Integer;
begin
  if AIdItem <= 0 then
    raise Exception.Create('ID do item de servico nao informado.');

  Result := ObterIdPorCodigo(
    MontarURLBase + '/consultarSubitensServico?ise=' + IntToStr(AIdItem),
    'cnt', 'id', ACodigoSubitem);
end;

function TNFSeW_Aspec.ObterIdNBS: Integer;
var
  AURL: string;
begin
  if FIdNBS = 0 then
  begin
    AURL := MontarURLBase + '/consultarNBS';
    FIdNBS := ObterIdPorCodigo(AURL, 'codigo', 'id', NFSe.Servico.CodigoNBS);
  end;

  Result := FIdNBS;
end;

function TNFSeW_Aspec.ObterIdIndOp: Integer;
begin
  if FIdIndOp = 0 then
    FIdIndOp := ObterIdPorCodigo(
      MontarURLBase + '/consultarINDOP?nbsId=' + IntToStr(ObterIdNBS),
      'codigo', 'id', NFSe.IBSCBS.cIndOp);

  Result := FIdIndOp;
end;

function TNFSeW_Aspec.ObterIdClassTrib: Integer;
begin
  Result := ObterIdPorCodigo(
    MontarURLBase + '/consultarClassTrib?nbsId=' + IntToStr(ObterIdNBS) +
    '&indopId=' + IntToStr(ObterIdIndOp),
    'codigo', 'id', NFSe.IBSCBS.valores.trib.gIBSCBS.cClassTrib);
end;

function TNFSeW_Aspec.GerarClassTrib: TACBrJSONObject;
begin
   Result := TACBrJSONObject.Create
            .AddPair('id', ObterIdClassTrib);
end;

function TNFSeW_Aspec.GerarDadosNota: String;
var
  AJSon: TACBrJSONObject;
begin
  FIdNBS := 0;
  FIdIndOp := 0;

  AJSon := TACBrJsonObject.Create;
  try
    AJSon

      .AddPair(IfThen(Length(OnlyNumber(NFSe.Prestador.IdentificacaoPrestador.Cnpj)) = 11, 'cpfPessoaPrestador', 'cnpjPessoaPrestador'), NFSe.Prestador.IdentificacaoPrestador.Cnpj)

      .AddPair(IfThen(Length(OnlyNumber(NFSe.Tomador.IdentificacaoTomador.CpfCnpj)) = 11, 'cpfPessoaTomador', 'cnpjPessoaTomador'), NFSe.Tomador.IdentificacaoTomador.CpfCnpj);
      if NFSe.Tomador.IdentificacaoTomador.Tipo = tpPF then
         AJSon.AddPair('nomePessoaTomador', Trim(NFSe.Tomador.RazaoSocial))
      else
         AJSon.AddPair('razaoSocialPessoaTomador', Trim(NFSe.Tomador.RazaoSocial))
              .AddPair('nomeFantasiaTomador', Trim(NFSe.Tomador.NomeFantasia));
      AJSon.AddPair('cepEnderecoTomador', Trim(NFSe.Tomador.Endereco.CEP))
         .AddPair('ufTomador', Trim(NFSe.Tomador.Endereco.UF))
         .AddPair('municipioTomadorIbge', Trim(NFSe.Tomador.Endereco.CodigoMunicipio))
         .AddPair('bairroEnderecoTomador', Trim(NFSe.Tomador.Endereco.Bairro))
         .AddPair('logradouroEnderecoTomador', Trim(NFSe.Tomador.Endereco.Endereco))
         .AddPair('tipoLogradouroEnderecoTomador', 'AVENIDA')
         .AddPair('numeroEnderecoTomador', NFSe.Tomador.Endereco.Numero)
         .AddPair('complementoEnderecoTomador', Trim(NFSe.Tomador.Endereco.Complemento))
         .AddPair('inscricaoEstadualTomador', NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual)
         .AddPair('inscricaoMunicipalTomador', NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal)
         .AddPair('dddFixoTomador', Copy(NFSe.Tomador.Contato.Telefone, 1, 3))
         .AddPair('telefoneFixoTomador', Copy(NFSe.Tomador.Contato.Telefone,3,11))
         .AddPair('emailTomador', Trim(NFSe.Tomador.Contato.Email));
         if NFSe.NaturezaOperacao = no1 then
            AJson.AddPair('naturezaOperacao', 'TRIBUTAVEL')
         else if NFSe.NaturezaOperacao = no4 then
            AJson.AddPair('naturezaOperacao', 'IMUNIDADE')
         else
            AJson.AddPair('naturezaOperacao', 'NAO_INCIDENCIA');
      AJson.AddPair('paisLocalPrestacaoServico', GerarPaisLocalPrestacaoServico)
         .AddPair('localPrestacaoServico', GerarLocalPrestacaoServico)
         .AddPair('servico', GerarServicos)
         .AddPair('nbs', GerarNBS)
         .AddPair('indop', GerarIndOp)
         .AddPair('classTrib', GerarClassTrib)
         .AddPair('aliquota', NFSe.Servico.Valores.Aliquota)
         .AddPair('issRetidoPeloTomador', IfThen(NFSe.Servico.Valores.IssRetido = stRetencao, 'RETIDO_TOMADOR', 'NAO_RETIDO'))
         .AddPair('discriminacaoServico', NFSe.Servico.Discriminacao)
         .AddPair('valorTotal', NFSe.Servico.Valores.ValorServicos)
         .AddPair('valorDeducoes', NFSe.Servico.Valores.ValorDeducoes)
         .AddPair('descontoCondicionado', NFSe.Servico.Valores.DescontoCondicionado)
         .AddPair('descontoIncondicionado', NFSe.Servico.Valores.DescontoIncondicionado)
         .AddPair('valorBaseCalculo', NFSe.Servico.Valores.BaseCalculo);
      if (NFSe.Servico.Valores.ValorPis > 0) then
         AJson.AddPair('pisPasep', NFSe.Servico.Valores.ValorPis);
      if (NFSe.Servico.Valores.ValorCofins > 0) then
         AJson.AddPair('cofins', NFSe.Servico.Valores.ValorCofins);
      if (NFSe.Servico.Valores.ValorCsll > 0) then
         AJson.AddPair('csll', NFSe.Servico.Valores.ValorCsll);
      if (NFSe.Servico.Valores.ValorPis > 0) or (NFSe.Servico.Valores.ValorCofins > 0) or (NFSe.Servico.Valores.ValorCsll > 0) then
         AJson.AddPair('situacaoTributariaPisCofins', GerarSitTribPisCofins)
              .AddPair('tipoRetencao', GerarTipoRetencao);
      AJson.AddPair('inss', NFSe.Servico.Valores.ValorInss)
         .AddPair('irrf', NFSe.Servico.Valores.ValorIr)
         .AddPair('rpsDataEmissaoStr', FormatDateTime('dd/mm/yyyy', NFSe.DataEmissaoRps))
         .AddPair('rpsSerie', NFSe.IdentificacaoRps.Serie)
         .AddPair('rpsNumero', StrToInt(NFSe.IdentificacaoRps.Numero))
         .AddPair('tokenRPS', NFSe.ChaveAcesso);
    Result := AJSon.ToJSON;
  finally
    AJSon.Free;
  end;
end;

function TNFSeW_Aspec.GerarPaisLocalPrestacaoServico: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create
              .AddPair('codigoBacen', NFSe.Tomador.Endereco.CodigoPais);
end;

function TNFSeW_Aspec.GerarLocalPrestacaoServico: TACBrJSONObject;
begin
  if nfse.LogradouLocalPrestacaoServico = llpPrestador then
     Result := TACBrJSONObject.Create
                 .AddPair('codIBGE', StrToInt(NFSe.Prestador.Endereco.CodigoMunicipio))
  else
   Result := TACBrJSONObject.Create
                 .AddPair('codIBGE', StrToInt(NFSe.Tomador.Endereco.CodigoMunicipio))
end;

function TNFSeW_Aspec.GerarNBS: TACBrJSONObject;
begin
   Result := TACBrJSONObject.Create
              .AddPair('id', ObterIdNBS);
end;

function TNFSeW_Aspec.GerarServicos: TACBrJSONObject;
var
   IdSubitem :    Integer;
begin
  IdSubitem := ObterIdSubitemServico(StrToIntDef(Copy(NFSe.Servico.ItemListaServico, 0, 2), 0),
                                         NFSe.Servico.ItemListaServico);
  Result := TACBrJSONObject.Create
              .AddPair('id', IdSubitem);
end;

function TNFSeW_Aspec.GerarSitTribPisCofins: TACBrJSONObject;
begin
   Result := TACBrJSONObject.Create
             .AddPair('id', CSTToStr(NFSe.Servico.Valores.tribFed.CST));
end;

function TNFSeW_Aspec.GerarTipoRetencao: TACBrJSONObject;
begin
   Result := TACBrJSONObject.Create
             .AddPair('id', tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins));
end;

function TNFSeW_Aspec.GerarIndOp: TACBrJSONObject;
begin
   Result := TACBrJSONObject.Create
            .AddPair('id', ObterIdIndOp);
end;

function TNFSeW_Aspec.GerarIni: string;
var
  INIRec: TMemIniFile;
  IniNFSe: TStringList;
begin
  Result:= '';

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
    finally
      IniNFSe.Free;
    end;
  end;
end;

procedure TNFSeW_Aspec.GerarIniNfse(AINIRec: TMemIniFile);
begin
  GerarINIIdentificacaoNFSe(AINIRec);
  GerarINIInformacoesCancelamento(AINIRec);
  GerarINIDadosPrestador(AINIRec);
  GerarINIDadosTomador(AINIRec);
  GerarINIIdentificacaoRps(AINIRec);
  GerarINIDadosServico(AINIRec);
  GerarINIDadosValores(AINIRec);
end;

procedure TNFSeW_Aspec.GerarIniRps(AINIRec: TMemIniFile);
begin
  GerarINIIdentificacaoNFSe(AINIRec);
  GerarINIIdentificacaoPrestador(AINIRec);
  GerarINIDadosTomador(AINIRec);
  GerarINIIdentificacaoRps(AINIRec);
  GerarINIDadosServico(AINIRec);
  GerarINIDadosValores(AINIRec);
end;

procedure TNFSeW_Aspec.GerarINIIdentificacaoNFSe(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao:= 'IdentificacaoNFSe';

  if NFSe.tpXML = txmlRPS then
    AINIRec.WriteString(sSecao, 'TipoXML', 'RPS')
  else
  begin
    AINIRec.WriteString(sSecao, 'TipoXML', 'NFSE');

    AINIRec.WriteString(sSecao, 'Numero', NFSe.Numero);
    AINIRec.WriteString(sSecao, 'CodigoVerificacao', NFSe.CodigoVerificacao);
    AINIRec.WriteString(sSecao, 'Link', NFSe.Link);
    AINIRec.WriteFloat(sSecao, 'ValorCredito', NFSe.ValorCredito);
    AINIRec.WriteString(sSecao, 'StatusNFSe', StatusNFSeToStr(NFSe.SituacaoNfse));
  end;
end;

procedure TNFSeW_Aspec.GerarINIIdentificacaoPrestador(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'Prestador';

  AINIRec.WriteString(sSecao, 'CNPJ', NFSe.Prestador.IdentificacaoPrestador.CpfCnpj);
end;

procedure TNFSeW_Aspec.GerarINIDadosTomador(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'Tomador';

  AINIRec.WriteString(sSecao, 'CNPJCPF', NFSe.Tomador.IdentificacaoTomador.CpfCnpj);
  AINIRec.WriteString(sSecao, 'InscricaoMunicipal', NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal);
  AINIRec.WriteString(sSecao, 'InscricaoEstadual', NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual);

  AINIRec.WriteString(sSecao, 'RazaoSocial', NFSe.Tomador.RazaoSocial);
  AINIRec.WriteString(sSecao, 'NomeFantasia', NFSe.Tomador.NomeFantasia);

  AINIRec.WriteString(sSecao, 'CodigoMunicipio', NFSe.Tomador.Endereco.CodigoMunicipio);
  AINIRec.WriteString(sSecao, 'Bairro', NFSe.Tomador.Endereco.Bairro);
  AINIRec.WriteString(sSecao, 'Logradouro', NFSe.Tomador.Endereco.Endereco);
  AINIRec.WriteString(sSecao, 'Numero', NFSe.Tomador.Endereco.Numero);
  AINIRec.WriteString(sSecao, 'Complemento', NFSe.Tomador.Endereco.Complemento);
  AINIRec.WriteInteger(sSecao, 'CodigoPais', NFSe.Tomador.Endereco.CodigoPais);

  AINIRec.WriteString(sSecao, 'Telefone', NFSe.Tomador.Contato.Telefone);
  AINIRec.WriteString(sSecao, 'Email', NFSe.Tomador.Contato.Email);
end;

procedure TNFSeW_Aspec.GerarINIIdentificacaoRps(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'IdentificacaoRps';

  AINIRec.WriteString(sSecao, 'Numero', NFSe.IdentificacaoRps.Numero);
  AINIRec.WriteString(sSecao, 'Serie', NFSe.IdentificacaoRps.Serie);
  AINIRec.WriteString(sSecao, 'DataEmissaoRps', DateTimeToStr(NFSe.DataEmissaoRps));

   if NFSe.tpXML = txmlNFSe then
  begin
    AINIRec.WriteString(sSecao, 'NaturezaOperacao', NaturezaOperacaoToStr(NFSe.NaturezaOperacao));
    AINIRec.WriteString(sSecao, 'SeriePrestacao', NFSe.SeriePrestacao);
    AINIRec.WriteString(sSecao, 'OutrasInformacoes', StringReplace(NFSe.OutrasInformacoes, sLineBreak, FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]));

    if NFSe.Competencia > 0 then
      AINIRec.WriteDate(sSecao, 'Competencia', NFSe.Competencia)
    else
      AIniRec.WriteDate(sSecao, 'Competencia', Now);
  end;
end;

procedure TNFSeW_Aspec.GerarINIDadosServico(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'Servico';

  AINIRec.WriteString(sSecao, 'ItemListaServico', NFSe.Servico.ItemListaServico);
  AINIRec.WriteString(sSecao, 'xItemListaServico', NFSe.Servico.xItemListaServico);
  AINIRec.WriteString(sSecao, 'Discriminacao',
    ChangeLineBreak(NFSe.Servico.Discriminacao, FpAOwner.ConfigGeral.QuebradeLinha));
  AINIRec.WriteString(sSecao, 'CodigoTributacaoMunicipio', NFSe.Servico.CodigoTributacaoMunicipio);
  AINIRec.WriteString(sSecao, 'CodigoCnae', NFSe.Servico.CodigoCnae);

  if NFSe.tpXML = txmlNFSe then
  begin
    AINIRec.WriteString(sSecao, 'CodigoMunicipio', NFSe.Servico.CodigoMunicipio);
  end;
end;

procedure TNFSeW_Aspec.GerarINIDadosValores(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'Valores';

  AINIRec.WriteFloat(sSecao, 'Aliquota', NFSe.Servico.Valores.Aliquota);
  AINIRec.WriteString(sSecao, 'ISSRetido', FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.ISSRetido));
  AINIRec.WriteFloat(sSecao, 'ValorServicos', NFSe.Servico.Valores.ValorServicos);
  AINIRec.WriteFloat(sSecao, 'ValorDeducoes', NFSe.Servico.Valores.ValorDeducoes);
  AINIRec.WriteFloat(sSecao, 'DescontoCondicionado', NFSe.Servico.Valores.DescontoCondicionado);
  AINIRec.WriteFloat(sSecao, 'DescontoIncondicionado', NFSe.Servico.Valores.DescontoIncondicionado);
  AINIRec.WriteFloat(sSecao, 'BaseCalculo', NFSe.Servico.Valores.BaseCalculo);
  AINIRec.WriteFloat(sSecao, 'ValorCofins', NFSe.Servico.Valores.ValorCofins);
  AINIRec.WriteFloat(sSecao, 'ValorCsll', NFSe.Servico.Valores.ValorCsll);
  AINIRec.WriteFloat(sSecao, 'ValorInss', NFSe.Servico.Valores.ValorInss);
  AINIRec.WriteFloat(sSecao, 'ValorIr', NFSe.Servico.Valores.ValorIr);
  AINIRec.WriteFloat(sSecao, 'ValorPis', NFSe.Servico.Valores.ValorPis);

  if NFSe.tpXML = txmlNFSe then
  begin
    AINIRec.WriteFloat(sSecao, 'OutrasRetencoes', NFSe.Servico.Valores.OutrasRetencoes);
    AINIRec.WriteFloat(sSecao, 'ValorIss', NFSe.Servico.Valores.ValorIss);
    AINIRec.WriteFloat(sSecao, 'ValorTotalTributos', NFSe.Servico.Valores.ValorTotalTributos);
  end;
end;

procedure TNFSeW_Aspec.GerarINIDadosPrestador(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao:= 'DadosPrestador';

  AINIRec.WriteString(sSecao, 'RazaoSocial', NFSe.Prestador.RazaoSocial);
  AINIRec.WriteString(sSecao, 'NomeFantasia', NFSe.Prestador.NomeFantasia);
  AINIRec.WriteString(sSecao, 'CNPJ', NFSe.Prestador.IdentificacaoPrestador.CpfCnpj);
  AINIRec.WriteString(sSecao, 'InscricaoMunicipal', NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal);

  AINIRec.WriteString(sSecao, 'Logradouro', NFSe.Prestador.Endereco.Endereco);
  AINIRec.WriteString(sSecao, 'Numero', NFSe.Prestador.Endereco.Numero);
  AINIRec.WriteString(sSecao, 'Complemento', NFSe.Prestador.Endereco.Complemento);
  AINIRec.WriteString(sSecao, 'Bairro', NFSe.Prestador.Endereco.Bairro);
  AINIRec.WriteString(sSecao, 'CodigoMunicipio', NFSe.Prestador.Endereco.CodigoMunicipio);
  AINIRec.WriteString(sSecao, 'xMunicipio', NFSe.Prestador.Endereco.xMunicipio);
  AINIRec.WriteString(sSecao, 'UF',  NFSe.Prestador.Endereco.UF);
  AINIRec.WriteString(sSecao, 'CEP', NFSe.Prestador.Endereco.CEP);

  AINIRec.WriteString(sSecao, 'Telefone', NFSe.Prestador.Contato.Telefone);
  AINIRec.WriteString(sSecao, 'Email', NFSe.Prestador.Contato.Email);
end;

procedure TNFSeW_Aspec.GerarINIInformacoesCancelamento(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := 'NFSeCancelamento';
  if NFSe.MotivoCancelamento <> '' then
  begin
    AINIRec.WriteString(sSecao, 'MotivoCancelamento', NFSe.MotivoCancelamento);
  end;
end;

end.
