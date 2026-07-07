unit ACBrNFSeXIniTests;

{$I ACBr.inc}

interface

uses
  Classes,
  SysUtils,
  IniFiles,
  ACBrTests.Util,
  ACBrUtil.Math,
  ACBrUtil.FilesIO,
  ACBrNFSeX,
  ACBrNFSeXConversao,
  ACBrNFSeXClass;

const
  ARQ_INI = '..\..\..\..\Recursos\NFSe\ModeloNFSeCompleto.ini';
  ARQ_INI_ANTIGO = '..\..\..\..\Recursos\NFSe\NFSe.ini';
  ARQ_INI_DOISSERVICOS = '..\..\..\..\Recursos\NFSe\NFSe_Dois_Servicos.ini';
  ARQ_XML = '..\..\..\..\Recursos\NFSe\NFSe_PadraoNacional_SemAssinaturas.xml';

type

  { ACBrNFSeXINITestCases }

  ACBrNFSeXINITestCases = class(TTestCase)
  private
    FACBrNFSeX: TACBrNFSeX;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure LerArquivoINIVazio_GeraArquivoINISemelhante;
    procedure LerArquivoINIPreenchido_GeraArquivoINISemelhante;
    procedure LerArquivoINIComSecaoServicoValores_GeraSecaoItensComInformacoesCorrespondentes;
    procedure LerArquivoINIComSecaoServicoValores_ItemServicoSomenteComUmaOcorrencia;
    procedure LerArquivoINIComSecaoServico_AlimentaItemServicoComValoresCorrespondentes;
    procedure LerArquivoINIComMaisDeUmItem_ConsolidaValoresCorretamente;
    procedure LerArquivoINIEhLerArquivoXMLMesmaNota_AlimentouAsMesmasInformacoes;
    procedure AlimentaInformacoesQueGeramLista_ArquivoINIGeradoSomenteCom1Item;
  end;

implementation

{ ACBrNFSeXINITestCases }

procedure ACBrNFSeXINITestCases.SetUp;
begin
  inherited SetUp;
  FACBrNFSeX := TACBrNFSeX.Create(nil);
  FACBrNFSeX.Configuracoes.Geral.Salvar := False;
  FACBrNFSeX.Configuracoes.Arquivos.Salvar := False;
  FACBrNFSeX.Configuracoes.WebServices.Salvar := False;
  FACBrNFSeX.Configuracoes.WebServices.QuebradeLinha := '\n';
end;

procedure ACBrNFSeXINITestCases.TearDown;
begin
  FACBrNFSeX.Free;
  inherited TearDown;
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIVazio_GeraArquivoINISemelhante;
var
  lArqINIVazioOriginal, lArqINIVazioNovo: String;
  lSaveStr: TStringList;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3503208; //Araraquara
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.New;
  lArqINIVazioOriginal := FACBrNFSeX.NotasFiscais.GerarIni;

  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromIni(lArqINIVazioOriginal);
  lArqINIVazioNovo := FACBrNFSeX.NotasFiscais.GerarIni;

  lSaveStr := TStringList.Create;
  try
    lSaveStr.Clear;
    lSaveStr.Text := lArqINIVazioOriginal;
    lSaveStr.SaveToFile(ApplicationPath + '\LerArquivoINIVazio_ArqOriginal.ini');
    lSaveStr.Clear;
    lSaveStr.Text := lArqINIVazioNovo;
    lSaveStr.SaveToFile(ApplicationPath + '\LerArquivoINIVazio_ArqNovo.ini');
  finally
    lSaveStr.Free;
  end;

  CheckEquals(lArqINIVazioOriginal, lArqINIVazioNovo, 'Arquivo INI vazio gerado com informações diferentes do original!');
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIPreenchido_GeraArquivoINISemelhante;
var
  lArqININovo: String;
  lArqINIOriginal, lSaveStr: TStringList;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3503208; //Araraquara
  lArqINIOriginal := TStringList.Create;
  try
    lArqINIOriginal.LoadFromFile(ARQ_INI);
    FACBrNFSeX.NotasFiscais.Clear;
    FACBrNFSeX.NotasFiscais.LoadFromIni(ARQ_INI);
    lArqININovo := FACBrNFSeX.NotasFiscais.GerarIni;

    lSaveStr := TStringList.Create;
    try
      lSaveStr.Clear;
      lSaveStr.Text := lArqINIOriginal.Text;
      lSaveStr.SaveToFile(ApplicationPath + '\LerArquivoINIPreenchido_ArqOriginal.ini');
      lSaveStr.Clear;
      lSaveStr.Text := lArqININovo;
      lSaveStr.SaveToFile(ApplicationPath + '\LerArquivoINIPreenchido_ArqNovo.ini');
    finally
      lSaveStr.Free;
    end;
    CheckEquals(lArqINIOriginal.Text, lArqININovo, 'Arquivo INI preenchido gerado com informações diferentes do original!');
  finally
    lArqINIOriginal.Free;
  end;
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIComSecaoServicoValores_GeraSecaoItensComInformacoesCorrespondentes;
const
  DEF_SERVICO = '-1';
  DEF_ITENS = '-2';
var
  lINIItens, lINIServico: TMemIniFile;
  lSecaoItens, lSecaoServico: String;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3303807; //PArati
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromINI(ARQ_INI_ANTIGO);

  lINIServico := TMemINIFile.Create('');
  try
    LerIniArquivoOuString(ARQ_INI_ANTIGO, lINIServico);
    lINIItens := TMemINIFile.Create('');
    try
      LerIniArquivoOuString(FACBrNFSeX.NotasFiscais.GerarIni, lINIItens);

      lSecaoItens := 'Itens001';
      lSecaoServico := 'Servico';
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'cClassTrib', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'cClassTrib', DEF_ITENS),
                  'Chave cClassTrib gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CFPS', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CFPS', DEF_ITENS),
                  'Chave CFPS gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoCnae', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoCnae', DEF_ITENS),
                  'Chave CodigoCnae gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoInterContr', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoInterContr', DEF_ITENS),
                  'Chave CodigoInterContr gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoMunicipio', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodMunPrestacao', DEF_ITENS),
                  'Chave CodigoMunicipio gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoNBS', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoNBS', DEF_ITENS),
                  'Chave CodigoNBS gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoNCM', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoNCM', DEF_ITENS),
                  'Chave CodigoNCM gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoPais', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoPais', DEF_ITENS),
                  'Chave CodigoPais gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoServicoNacional', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoServicoNacional', DEF_ITENS),
                  'Chave CodigoServicoNacional gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'CodigoTributacaoMunicipio', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'CodigoTributacaoMunicipio', DEF_ITENS),
                  'Chave CodigoTributacaoMunicipio gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'ExigibilidadeISS', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'ExigibilidadeISS', DEF_ITENS),
                  'Chave ExigibilidadeISS gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'FonteCargaTributaria', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'FonteCargaTributaria', DEF_ITENS),
                  'Chave FonteCargaTributaria gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'IdentifNaoExigibilidade', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'IdentifNaoExigibilidade', DEF_ITENS),
                  'Chave IdentifNaoExigibilidade gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'INDOP', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'INDOP', DEF_ITENS),
                  'Chave INDOP gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'InfAdicional', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'InfAdicional', DEF_ITENS),
                  'Chave InfAdicional gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'ItemListaServico', DEF_SERVICO),
                        lINIItens.ReadString(lSecaoItens, 'ItemListaServico', DEF_ITENS),
                        'Chave ItemListaServico gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'LocalPrestacao', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'LocalPrestacao', DEF_ITENS),
                  'Chave LocalPrestacao gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'MunicipioIncidencia', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'MunicipioIncidencia', DEF_ITENS),
                  'Chave MunicipioIncidencia gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'NumeroProcesso', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'NumeroProcesso', DEF_ITENS),
                  'Chave NumeroProcesso gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'Operacao', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'Operacao', DEF_ITENS),
                  'Chave Operacao gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'PercentualCargaTributaria', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'PercentualCargaTributaria', DEF_ITENS),
                  'Chave PercentualCargaTributaria gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'PrestadoEmViasPublicas', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'PrestadoEmViasPublicas', DEF_ITENS),
                  'Chave PrestadoEmViasPublicas gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'ResponsavelRetencao', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'ResponsavelRetencao', DEF_ITENS),
                  'Chave ResponsavelRetencao gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'TipoLancamento', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'TipoLancamento', DEF_ITENS),
                  'Chave TipoLancamento gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'Tributacao', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'Tributacao', DEF_ITENS),
                  'Chave Tributacao gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'ValorCargaTributaria', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'ValorCargaTributaria', DEF_ITENS),
                  'Chave ValorCargaTributaria gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'xCodigoTributacaoMunicipio', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'xCodigoTributacaoMunicipio', DEF_ITENS),
                  'Chave xCodigoTributacaoMunicipio gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'xFormaPagamento', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'xFormaPagamento', DEF_ITENS),
                  'Chave xFormaPagamento gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'xItemListaServico', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'xItemListaServico', DEF_ITENS),
                  'Chave xItemListaServico gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'xMunicipioIncidencia', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'xMunicipioIncidencia', DEF_ITENS),
                  'Chave xMunicipioIncidencia gerada em Itens001 diverge de valor lido em Servico');
      CheckEquals(lINIServico.ReadString(lSecaoServico, 'xNBS', DEF_SERVICO),
                  lINIItens.ReadString(lSecaoItens, 'xNBS', DEF_ITENS),
                  'Chave xNBS gerada em Itens001 diverge de valor lido em Servico');

    finally
      lINIItens.Free;
    end;
  finally
    lINIServico.Free;
  end;
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIComSecaoServico_AlimentaItemServicoComValoresCorrespondentes;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3303807; //Parati
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromIni(ARQ_INI_ANTIGO);

  CheckEquals('PLANO PRESENCIAL DE 02/07/2023 A 01/08/2023',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Descricao,
              'Descricao no ItemServico diverge do esperado');
  CheckEquals('3303807',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodMunPrestacao,
              'CodMunPrestacao no ItemServico diverge do esperado');
  CheckEquals('Teste 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCNAE,
              'xCNAE no ItemServico diverge do esperado');
  CheckEquals('01.05',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ItemListaServico,
              'ItemListaServico no ItemServico diverge do esperado');
  CheckEquals('6202300',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoCnae,
              'CodigoCnae no ItemServico diverge do esperado');
  CheckEquals('14.02',
                FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoMunicipio,
                'CodigoTributacaoMunicipio no ItemServico diverge do esperado');
  CheckEquals('Teste Municipio 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCodigoTributacaoMunicipio,
              'xCodigoTributacaoMunicipio no ItemServico diverge do esperado');
  CheckEquals(3303807,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoMunicipio,
              'CodigoMunicipio no ItemServico diverge do esperado');
  CheckEquals(1058,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoPais,
              'CodigoPais no ItemServico diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.ExigibilidadeISSToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ExigibilidadeISS),
              'ExigibilidadeISS no ItemServico diverge do esperado');
  CheckEquals('Teste 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IdentifNaoExigibilidade,
              'IdentifNaoExigibilidade no ItemServico diverge do esperado');
  CheckEquals(3303807,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].MunicipioIncidencia,
              'MunicipioIncidencia no ItemServico diverge do esperado');
  CheckEquals('1234',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].NumeroProcesso,
              'NumeroProcesso no ItemServico diverge do esperado');
  CheckEquals('Teste 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xItemListaServico,
              'xItemListaServico no ItemServico diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.ResponsavelRetencaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ResponsavelRetencao),
              'ResponsavelRetencao no ItemServico diverge do esperado');
  CheckEquals('Parati',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xMunicipioIncidencia,
              'xMunicipioIncidencia no ItemServico diverge do esperado');
  CheckEquals(10,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCargaTributaria,
              'ValorCargaTributaria no ItemServico diverge do esperado');
  CheckEquals(10,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PercentualCargaTributaria,
              'PercentualCargaTributaria no ItemServico diverge do esperado');
  CheckEquals('Teste 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].FonteCargaTributaria,
              'FonteCargaTributaria no ItemServico diverge do esperadoo');
  CheckEquals('1234',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNCM,
              'CodigoNCM no ItemServico diverge do esperado');
  CheckEquals(False,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PrestadoEmViasPublicas,
              'PrestadoEmViasPublicas no ItemServico diverge do esperado');
  CheckEquals('2',
              LocalPrestacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].LocalPrestacao),
              'LocalPrestacao no ItemServico diverge do esperado');
  CheckEquals('T',
              TipoLancamentoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TipoLancamento),
              'TipoLancamento no ItemServico diverge do esperado');
  CheckEquals('123456789',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNBS,
              'CodigoNBS no ItemServico diverge do esperado');
  CheckEquals('1234',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoInterContr,
              'CodigoInterContr no ItemServico diverge do esperado');
  CheckEquals('Teste 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CFPS,
              'CFPS no ItemServico diverge do esperado');
  CheckEquals('InfAdicional Servico 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].InfAdicional,
              'Valor de InfAdicional no ItemServico divergiu do esperado');
  CheckEquals('xFormaPagamento 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xFormaPagamento,
              'Valor de xFormaPagamento no ItemServico divergiu do esperado');
  CheckEquals('000001',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].cClassTrib,
              'Valor de cClassTrib no ItemServico divergiu do esperado');
  CheckEquals('1234',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].INDOP,
              'Valor de INDOP no ItemServico divergiu do esperado');
  CheckEquals('01.05.00',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoServicoNacional,
              'Valor de CodigoServicoNacional no ItemServico divergiu do esperado');
  CheckEquals(EmptyStr,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoNacional,
              'CodigoTributacaoNacionl no ItemServico diverge do esperado');
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIComSecaoServicoValores_ItemServicoSomenteComUmaOcorrencia;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3303807; //Parati
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromIni(ARQ_INI_ANTIGO);

  Check(FACBrNFSeX.NotasFiscais.Count = 1, 'Count da NotasFiscais maior do que o esperado!');
  Check(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico.Count = 1, 'Count do ItemServico diferente do esperado!');
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIComMaisDeUmItem_ConsolidaValoresCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3554003; //Conselheiro Pena-MG
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromIni(ARQ_INI_DOISSERVICOS);

  //Valores somados/totalizados
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.QtdeDiaria,
              'Valor Consolidado em QtdeDiaria diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTaxaTurismo,
              'Valor Consolidado em ValorTaxaTurismo diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorDeducoes,
              'Valor Consolidado em ValorDeducoes diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRecebido,
              'Valor Consolidado em ValorRecebido diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorServicos,
              'Valor Consolidado em ValorServicos diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoCondicionado,
              'Valor Consolidado em DescontoCondicionado diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoIncondicionado,
              'Valor Consolidado em DescontoIncondicionado diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.BaseCalculo,
              'Valor Consolidado em BaseCalculo diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorPis,
              'Valor Consolidado em ValorPis diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCofins,
              'Valor Consolidado em ValorCofins diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInss,
              'Valor Consolidado em ValorInss diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIr,
              'Valor Consolidado em ValorIr diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCsll,
              'Valor Consolidado em ValorCsll diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIss,
              'Valor Consolidado em ValorIss diverge do esperado');
  CheckEquals(2,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIssRetido,
              'Valor Consolidado em ValorIssRetido diverge do esperado');
  //Valores que pegam do primeiro item.
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCsll),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoPIS),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCOFINS),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoINSS),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoIR),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCPP),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  CheckEquals('1',
              FACBrNFSeX.Provider.SituacaoTributariaToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ISSRetido),
              'Valor Consolidado em RetidoCsll diverge do esperado');
  //Valores que priorizam Servico sob Item
  CheckEquals('Teste 01' + ';' + 'Teste 02',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Discriminacao,
              'Valor Consolidado em Discriminacao diverge do esperado');
  CheckEquals('xNBS 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.infNFSe.xNBS,
              'Valor Consolidado em xNBS diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.PercentualCargaTributaria,
              'Valor Consolidado em PercentualCargaTributaria diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.ValorCargaTributaria,
              'Valor Consolidado em ValorCargaTributaria diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.Aliquota,
              'Valor Consolidado em Aliquota diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaDeducoes,
              'Valor Consolidado em AliquotaDeducoes diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaPis,
              'Valor Consolidado em AliquotaPis diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCofins,
              'Valor Consolidado em AliquotaCofins diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaInss,
              'Valor Consolidado em AliquotaInss diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaIr,
              'Valor Consolidado em AliquotaIr diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCsll,
              'Valor Consolidado em AliquotaCsll diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalRecebido,
              'Valor Consolidado em ValorTotalRecebido diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrasRetencoes,
              'Valor Consolidado em OutrasRetencoes diverge do esperado');
  CheckEquals('DescricaoOutrasRetencoes 01',
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescricaoOutrasRetencoes,
              'Valor Consolidado em DescricaoOutrasRetencoes diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrosDescontos,
              'Valor Consolidado em OutrasRetencoes diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRepasse,
              'Valor Consolidado em ValorRepasse diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaSN,
              'Valor Consolidado em AliquotaSN diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorLiquidoNfse,
              'Valor Consolidado em ValorLiquidoNfse diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.IrrfIndenizacao,
              'Valor Consolidado em IrrfIndenizacao diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetencoesFederais,
              'Valor Consolidado em RetencoesFederais diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIPI,
              'Valor Consolidado em ValorIPI diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInicialCobrado,
              'Valor Consolidado em ValorInicialCobrado diverge do esperado');
  CheckEquals(1,
              FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorFinalCobrado,
              'Valor Consolidado em ValorFinalCobrado diverge do esperado');
end;

procedure ACBrNFSeXINITestCases.LerArquivoINIEhLerArquivoXMLMesmaNota_AlimentouAsMesmasInformacoes;
var
  lACBrNFSeX: TACBrNFSeX;
  lINI: String;
  lTemp: TStringList;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3554003; //Tatui
  FACBrNFSeX.NotasFiscais.Clear;
  FACBrNFSeX.NotasFiscais.LoadFromFile(ARQ_XML);
  lINI := FACBrNFSeX.NotasFiscais.GerarIni;
  lACBrNFSeX := TACBrNFSeX.Create(nil);
  try
    lACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3554003; //Tatui
    lACBrNFSeX.NotasFiscais.Clear;
    lACBrNFSeX.NotasFiscais.LoadFromIni(lINI);

    lTemp := TStringList.Create;
    try
      lTemp.Text := lINI;
      lTemp.SaveToFile(ApplicationPath + '\LerArquivoINIEhLerArquivoXMLMesmaNota.INI');
    finally
      lTemp.Free;
    end;

    //Servico
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemListaServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemListaServico,
                'ItemListaServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoCnae,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoCnae,
                'CodigoCnae diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoTributacaoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoTributacaoMunicipio,
                'CodigoTributacaoMunicipio diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xCodigoTributacaoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xCodigoTributacaoMunicipio,
                'xCodigoTributacaoMunicipio diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Discriminacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Discriminacao,
                'Discriminacao diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoMunicipio,
                'CodigoMunicipio diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.MunicipioPrestacaoServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.MunicipioPrestacaoServico,
                'MunicipioPrestacaoServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoPais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoPais,
                'CodigoPais diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xPais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xPais,
                'xPais diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.IdentifNaoExigibilidade,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.IdentifNaoExigibilidade,
                'IdentifNaoExigibilidade diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.MunicipioIncidencia,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.MunicipioIncidencia,
                'MunicipioIncidencia diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.NumeroProcesso,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.NumeroProcesso,
                'NumeroProcesso diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xItemListaServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xItemListaServico,
                'xItemListaServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xMunicipioIncidencia,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xMunicipioIncidencia,
                'xMunicipioIncidencia diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.UFPrestacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.UFPrestacao,
                'UFPrestacao diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ValorCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ValorCargaTributaria,
                'ValorCargaTributaria diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.PercentualCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.PercentualCargaTributaria,
                'PercentualCargaTributaria diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.FonteCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.FonteCargaTributaria,
                'FonteCargaTributaria diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ValorTotalRecebido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ValorTotalRecebido,
                'ValorTotalRecebido diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoNCM,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoNCM,
                'CodigoNCM diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.PrestadoEmViasPublicas,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.PrestadoEmViasPublicas,
                'PrestadoEmViasPublicas diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoNBS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoNBS,
                'CodigoNBS diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoInterContr,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoInterContr,
                'CodigoInterContr diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CFPS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CFPS,
                'CFPS diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.InfAdicional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.InfAdicional,
                'InfAdicional diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xFormaPagamento,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xFormaPagamento,
                'xFormaPagamento diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.cClassTrib,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.cClassTrib,
                'cClassTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.INDOP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.INDOP,
                'INDOP diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoServicoNacional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoServicoNacional,
                'CodigoServicoNacional diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoMunicipioLocalPrestacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoMunicipioLocalPrestacao,
                'CodigoMunicipioLocalPrestacao diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.xPed,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.xPed,
                'xPed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.nItemPed,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.nItemPed,
                'nItemPed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoAnexoCnae,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoAnexoCnae,
                'CodigoAnexoCnae diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoTributacaoNacional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.CodigoTributacaoNacional,
                'CodigoTributacaoNacional diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.ExigibilidadeISSToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ExigibilidadeISS),
                lACBrNFSeX.Provider.ExigibilidadeISSToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ExigibilidadeISS),
                'ExigibilidadeISS diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.ResponsavelRetencaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ResponsavelRetencao),
                lACBrNFSeX.Provider.ResponsavelRetencaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ResponsavelRetencao),
                'ResponsavelRetencao diverge do esperado');
    CheckEquals(OperacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Operacao),
                OperacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Operacao),
                'Operacao diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.TributacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Tributacao),
                lACBrNFSeX.Provider.TributacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Tributacao),
                'Tributacao diverge do esperado');
    CheckEquals(LocalPrestacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.LocalPrestacao),
                LocalPrestacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.LocalPrestacao),
                'LocalPrestacao diverge do esperado');
    CheckEquals(TipoLancamentoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.TipoLancamento),
                TipoLancamentoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.TipoLancamento),
                'TipoLancamento diverge do esperado');

    //ItemServico
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Descricao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Descricao,
                'Descricao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodMunPrestacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodMunPrestacao,
                'CodMunPrestacao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCNAE,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCNAE,
                'xCNAE no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ItemListaServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ItemListaServico,
                'ItemListaServico no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoCnae,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoCnae,
                'CodigoCnae no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoMunicipio,
                'CodigoTributacaoMunicipio no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCodigoTributacaoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xCodigoTributacaoMunicipio,
                'xCodigoTributacaoMunicipio no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoMunicipio,
                'CodigoMunicipio no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoPais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoPais,
                'CodigoPais no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.ExigibilidadeISSToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ExigibilidadeISS),
                FACBrNFSeX.Provider.ExigibilidadeISSToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ExigibilidadeISS),
                'ExigibilidadeISS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IdentifNaoExigibilidade,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IdentifNaoExigibilidade,
                'IdentifNaoExigibilidade no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].MunicipioIncidencia,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].MunicipioIncidencia,
                'MunicipioIncidencia no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].NumeroProcesso,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].NumeroProcesso,
                'NumeroProcesso no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xItemListaServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xItemListaServico,
                'xItemListaServico no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.ResponsavelRetencaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ResponsavelRetencao),
                FACBrNFSeX.Provider.ResponsavelRetencaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ResponsavelRetencao),
                'ResponsavelRetencao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xMunicipioIncidencia,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xMunicipioIncidencia,
                'xMunicipioIncidencia no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCargaTributaria,
                'ValorCargaTributaria no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PercentualCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PercentualCargaTributaria,
                'PercentualCargaTributaria no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].FonteCargaTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].FonteCargaTributaria,
                'FonteCargaTributaria no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNCM,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNCM,
                'CodigoNCM no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PrestadoEmViasPublicas,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].PrestadoEmViasPublicas,
                'PrestadoEmViasPublicas no ItemServico diverge do esperado');
    CheckEquals(LocalPrestacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].LocalPrestacao),
                LocalPrestacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].LocalPrestacao),
                'LocalPrestacao no ItemServico diverge do esperado');
    CheckEquals(TipoLancamentoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TipoLancamento),
                TipoLancamentoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TipoLancamento),
                'TipoLancamento no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNBS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoNBS,
                'CodigoNBS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoInterContr,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoInterContr,
                'CodigoInterContr no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CFPS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CFPS,
                'CFPS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].InfAdicional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].InfAdicional,
                'Valor de InfAdicional no ItemServico divergiu do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xFormaPagamento,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xFormaPagamento,
                'Valor de xFormaPagamento no ItemServico divergiu do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].cClassTrib,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].cClassTrib,
                'Valor de cClassTrib no ItemServico divergiu do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].INDOP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].INDOP,
                'Valor de INDOP no ItemServico divergiu do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoServicoNacional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoServicoNacional,
                'Valor de CodigoServicoNacional no ItemServico divergiu do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoNacional,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodigoTributacaoNacional,
                'CodigoTributacaoNacional no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodServ,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodServ,
                'CodServ no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodLCServ,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodLCServ,
                'CodLCServ no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Unidade,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Unidade,
                'Unidade no ItemServico diverge do esperado');
    CheckEquals(UnidadeToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TipoUnidade),
                UnidadeToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TipoUnidade),
                'TipoUnidade no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Quantidade,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Quantidade,
                'Quantidade no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorUnitario,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorUnitario,
                'ValorUnitario no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTotal,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTotal,
                'ValorTotal no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].BaseCalculo,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].BaseCalculo,
                'BaseCalculo no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqDeducoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqDeducoes,
                'AliqDeducoes no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorDeducoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorDeducoes,
                'ValorDeducoes no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xJustDeducao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xJustDeducao,
                'xJustDeducao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescontoCondicionado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescontoCondicionado,
                'DescontoCondicionado no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescontoIncondicionado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescontoIncondicionado,
                'DescontoIncondicionado no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].QtdeDiaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].QtdeDiaria,
                'QtdeDiaria no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTaxaTurismo,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTaxaTurismo,
                'ValorTaxaTurismo no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqReducao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqReducao,
                'AliqReducao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorReducao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorReducao,
                'ValorReducao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Aliquota,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Aliquota,
                'Aliquota no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISS,
                'ValorISS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISSRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISSRetido,
                'ValorISSRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorPisRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorPisRetido,
                'ValorPisRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCofinsRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCofinsRetido,
                'ValorCofinsRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorInssRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorInssRetido,
                'ValorInssRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIrRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIrRetido,
                'ValorIrRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCsllRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCsllRetido,
                'ValorCsllRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCppRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCppRetido,
                'ValorCppRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqISSST,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqISSST,
                'AliqISSST no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISSST,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorISSST,
                'ValorISSST no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCSLL,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCSLL,
                'ValorBCCSLL no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCSLL,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCSLL,
                'AliqRetCSLL no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCSLL),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCSLL),
                'RetidoCSLL no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCSLL,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCSLL,
                'ValorCSLL no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCPIS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCPIS,
                'ValorBCPIS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetPIS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetPIS,
                'AliqRetPIS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoPIS),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoPIS),
                'RetidoPIS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorPIS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorPIS,
                'ValorPIS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCOFINS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCOFINS,
                'ValorBCCOFINS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCOFINS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCOFINS,
                'AliqRetCOFINS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCOFINS),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCOFINS),
                'RetidoCOFINS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCOFINS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCOFINS,
                'ValorCOFINS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCINSS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCINSS,
                'ValorBCINSS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetINSS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetINSS,
                'AliqRetINSS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoINSS),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoINSS),
                'RetidoINSS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorINSS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorINSS,
                'ValorINSS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCRetIRRF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCRetIRRF,
                'ValorBCRetIRRF no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetIRRF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetIRRF,
                'AliqRetIRRF no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoIRRF),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoIRRF),
                'RetidoIRRF no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIRRF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIRRF,
                'ValorIRRF no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCPP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorBCCPP,
                'ValorBCCPP no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCPP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqRetCPP,
                'AliqRetCPP no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCPP),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetidoCPP),
                'RetidoCPP no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCPP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorCPP,
                'ValorCPP no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Tributavel),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Tributavel),
                'Tributavel no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SimNaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TribMunPrestador),
                lACBrNFSeX.Provider.SimNaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].TribMunPrestador),
                'TribMunPrestador no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].SituacaoTributaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].SituacaoTributaria,
                'SituacaoTributaria no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodCNO,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].CodCNO,
                'CodCNO no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTributavel,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorTributavel,
                'ValorTributavel no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqIBS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqIBS,
                'AliqIBS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqCBS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliqCBS,
                'AliqCBS no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].totalAproxTribServ,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].totalAproxTribServ,
                'totalAproxTribServ no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xNBS,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].xNBS,
                'xNBS no ItemServico diverge do esperado');
    CheckEquals(OperacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Operacao),
                OperacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Operacao),
                'Operacao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.TributacaoToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Tributacao),
                lACBrNFSeX.Provider.TributacaoToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Tributacao),
                'Tributacao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.Provider.SituacaoTributariaToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IssRetido),
                lACBrNFSeX.Provider.SituacaoTributariaToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IssRetido),
                'IssRetido no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].OutrasRetencoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].OutrasRetencoes,
                'OutrasRetencoes no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescricaoOutrasRetencoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DescricaoOutrasRetencoes,
                'DescricaoOutrasRetencoes no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].OutrosDescontos,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].OutrosDescontos,
                'OutrosDescontos no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorRepasse,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorRepasse,
                'ValorRepasse no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliquotaSN,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].AliquotaSN,
                'AliquotaSN no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorLiquidoNfse,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorLiquidoNfse,
                'ValorLiquidoNfse no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IrrfIndenizacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].IrrfIndenizacao,
                'IrrfIndenizacao no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetencoesFederais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].RetencoesFederais,
                'RetencoesFederais no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIPI,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorIPI,
                'ValorIPI no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorInicialCobrado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorInicialCobrado,
                'ValorInicialCobrado no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorFinalCobrado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorFinalCobrado,
                'ValorFinalCobrado no ItemServico diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorRecebido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].ValorRecebido,
                'ValorRecebido no ItemServico diverge do esperado');

    //ItemServico.DadosProfissionalParceiro
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.IdentificacaoParceiro.CpfCnpj,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.IdentificacaoParceiro.CpfCnpj,
                'CpfCnpj na IdentificacaoParceiro diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.IdentificacaoParceiro.InscricaoMunicipal,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.IdentificacaoParceiro.InscricaoMunicipal,
                'InscricaoMunicipal na IdentificacaoParceiro diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.RazaoSocial,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.RazaoSocial,
                'RazaoSocial em DadosProfissionalParceiro diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.PercentualProfissionalParceiro,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].DadosProfissionalParceiro.PercentualProfissionalParceiro,
                'PercentualProfissionalParceiro em DadosProfissionalParceiro diverge do esperado');

    //ItemServico.Endereco
    CheckEquals(FACBrNFSeX.Provider.SimNaoOpcToStr(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.EnderecoInformado),
                lACBrNFSeX.Provider.SimNaoOpcToStr(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.EnderecoInformado),
                'EnderecoInformado em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.TipoLogradouro,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.TipoLogradouro,
                'TipoLogradouro em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Endereco,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Endereco,
                'Endereco em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Numero,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Numero,
                'Numero em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Complemento,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Complemento,
                'Complemento em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.TipoBairro,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.TipoBairro,
                'TipoBairro em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Bairro,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.Bairro,
                'Bairro em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CodigoMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CodigoMunicipio,
                'CodigoMunicipio em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.UF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.UF,
                'UF em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CEP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CEP,
                'CEP em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.xMunicipio,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.xMunicipio,
                'xMunicipio em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CodigoPais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.CodigoPais,
                'CodigoPais em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.xPais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.xPais,
                'xPais em ItemServico.Endereco diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.PontoReferencia,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.ItemServico[0].Endereco.PontoReferencia,
                'PontoReferencia em ItemServico.Endereco diverge do esperado');

    //Valores
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorServicos,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorServicos,
                'ValorServicos em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorDeducoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorDeducoes,
                'ValorDeducoes em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorPis,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorPis,
                'ValorPis em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCofins,
                'ValorCofins em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInss,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInss,
                'ValorInss em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIr,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIr,
                'ValorIr em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCsll,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCsll,
                'ValorCsll em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCpp,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorCpp,
                'ValorCpp em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.IssRetido),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.IssRetido),
                'IssRetido em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIss,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIss,
                'ValorIss em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrasRetencoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrasRetencoes,
                'OutrasRetencoes em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.BaseCalculo,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.BaseCalculo,
                'BaseCalculo em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.Aliquota,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.Aliquota,
                'Aliquota em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaSN,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaSN,
                'AliquotaSN em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaPis,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaPis,
                'AliquotaPis em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCofins,
                'AliquotaCofins em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaInss,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaInss,
                'AliquotaInss em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaIr,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaIr,
                'AliquotaIr em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCsll,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCsll,
                'AliquotaCsll em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCpp,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaCpp,
                'AliquotaCpp em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrosDescontos,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.OutrosDescontos,
                'OutrosDescontos em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorLiquidoNfse,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorLiquidoNfse,
                'ValorLiquidoNfse em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIssRetido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIssRetido,
                'ValorIssRetido em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoCondicionado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoCondicionado,
                'DescontoCondicionado em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoIncondicionado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescontoIncondicionado,
                'DescontoIncondicionado em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.JustificativaDeducao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.JustificativaDeducao,
                'JustificativaDeducao em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.dsImpostos,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.dsImpostos,
                'dsImpostos em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.valorOutrasRetencoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.valorOutrasRetencoes,
                'valorOutrasRetencoes em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescricaoOutrasRetencoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.DescricaoOutrasRetencoes,
                'DescricaoOutrasRetencoes em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRepasse,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRepasse,
                'ValorRepasse em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorDespesasNaoTributaveis,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorDespesasNaoTributaveis,
                'ValorDespesasNaoTributaveis em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalRecebido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalRecebido,
                'ValorTotalRecebido em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalTributos,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalTributos,
                'ValorTotalTributos em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.IrrfIndenizacao,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.IrrfIndenizacao,
                'IrrfIndenizacao em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoPis),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoPis),
                'RetidoPis em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCofins),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCofins),
                'RetidoCofins em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoInss),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoInss),
                'RetidoInss em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoIr),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoIr),
                'RetidoIr em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCsll),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCsll),
                'RetidoCsll em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCpp),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetidoCpp),
                'RetidoCpp em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.QtdeDiaria,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.QtdeDiaria,
                'QtdeDiaria em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTaxaTurismo,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTaxaTurismo,
                'ValorTaxaTurismo em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRecebido,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorRecebido,
                'ValorRecebido em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaDeducoes,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.AliquotaDeducoes,
                'AliquotaDeducoes em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.TipoDeducao),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.TipoDeducao),
                'TipoDeducao em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetencoesFederais,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.RetencoesFederais,
                'RetencoesFederais em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalNotaFiscal,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorTotalNotaFiscal,
                'ValorTotalNotaFiscal em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totalAproxTrib,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totalAproxTrib,
                'totalAproxTrib em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorMulta,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorMulta,
                'ValorMulta em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorJuros,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorJuros,
                'ValorJuros em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIPI,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorIPI,
                'ValorIPI em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInicialCobrado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorInicialCobrado,
                'ValorInicialCobrado em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorFinalCobrado,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.ValorFinalCobrado,
                'ValorFinalCobrado em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.UnidadeServico,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.UnidadeServico,
                'UnidadeServico em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.CSTPis),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.CSTPis),
                'CSTPis em Valores diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tpRetPisCofins),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tpRetPisCofins),
                'tpRetPisCofins em Valores diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.BaseCalculoPisCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.BaseCalculoPisCofins,
                'BaseCalculoPisCofins em Valores diverge do esperado');

    //Valores.tribMun
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tribISSQN),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tribISSQN),
                'tribISSQN em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.cPaisResult,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.cPaisResult,
                'cPaisResult em Valores.tribMun diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpBM),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpBM),
                'tpBM em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.nBM,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.nBM,
                'nBM em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.vRedBCBM,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.vRedBCBM,
                'vRedBCBM em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.pRedBCBM,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.pRedBCBM,
                'pRedBCBM em Valores.tribMun diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpSusp),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpSusp),
                'tpSusp em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.nProcesso,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.nProcesso,
                'nProcesso em Valores.tribMun diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpImunidade),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpImunidade),
                'tpImunidade em Valores.tribMun diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.pAliq,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.pAliq,
                'pAliq em Valores.tribMun diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpRetISSQN),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribMun.tpRetISSQN),
                'tpRetISSQN em Valores.tribMun diverge do esperado');

    //Valores.tribFed
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.CST),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.CST),
                'CST em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPisCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPisCofins,
                'vBCPisCofins em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.pAliqPis,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.pAliqPis,
                'pAliqPis em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.pAliqCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.pAliqCofins,
                'pAliqCofins em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vPis,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vPis,
                'vPis em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vCofins,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vCofins,
                'vCofins em Valores.tribFed diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.tpRetPisCofins),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.tpRetPisCofins),
                'tpRetPisCofins em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetCP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetCP,
                'vRetCP em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetIRRF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetIRRF,
                'vRetIRRF em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetCSLL,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vRetCSLL,
                'vRetCSLL em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPCP,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPCP,
                'vBCPCP em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPIRRF,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCPIRRF,
                'vBCPIRRF em Valores.tribFed diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCCSLL,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.tribFed.vBCCSLL,
                'vBCCSLL em Valores.tribFed diverge do esperado');
    //Valores.totTrib
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribFed,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribFed,
                'vTotTribFed em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribEst,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribEst,
                'vTotTribEst em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribMun,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.vTotTribMun,
                'vTotTribMun em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribFed,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribFed,
                'pTotTribFed em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribEst,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribEst,
                'pTotTribEst em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribMun,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribMun,
                'pTotTribMun em Valores.totTrib diverge do esperado');
    CheckEquals(Ord(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.indTotTrib),
                Ord(lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.indTotTrib),
                'indTotTrib em Valores.totTrib diverge do esperado');
    CheckEquals(FACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribSN,
                lACBrNFSeX.NotasFiscais[0].NFSe.Servico.Valores.totTrib.pTotTribSN,
                'pTotTribSN em Valores.totTrib diverge do esperado');

  finally
    lACBrNFSeX.Free;
  end;
end;

procedure ACBrNFSeXINITestCases.AlimentaInformacoesQueGeramLista_ArquivoINIGeradoSomenteCom1Item;
var
  lNFSe: TNFSe;
  lMemINI: TMemIniFile;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3554003; //Araraquara
  FACBrNFSeX.NotasFiscais.Clear;
  lNFSe := FACBrNFSeX.NotasFiscais.New.NFSe;

  lNFSe.Servico.Discriminacao := 'Teste';
  lNFSe.Servico.CodigoMunicipio := '1234567';
  lNFSe.Servico.xCNAE := 'Teste';
  lNFSe.Servico.ItemListaServico := '01.01';
  lNFSe.Servico.CodigoCnae := '123456';
  lNFSe.Servico.CodigoTributacaoMunicipio := '1234';
  lNFSe.Servico.xCodigoTributacaoMunicipio := 'Teste';
  lNFSe.Servico.CodigoMunicipio := '1234567';
  lNFSe.Servico.CodigoPais := 1058;
  lNFSe.Servico.ExigibilidadeISS := exiNaoIncidencia;
  lNFSe.Servico.IdentifNaoExigibilidade := 'Teste';
  lNFSe.Servico.MunicipioIncidencia := 1234567;
  lNFSe.Servico.NumeroProcesso := '123';
  lNFSe.Servico.xItemListaServico := 'Teste';
  lNFSe.Servico.ResponsavelRetencao := rtTomador;
  lNFSe.Servico.xMunicipioIncidencia := 'Teste';
  lNFSe.Servico.ValorCargaTributaria := 1;
  lNFSe.Servico.PercentualCargaTributaria := 1;
  lNFSe.Servico.FonteCargaTributaria := 'Teste';
  lNFSe.Servico.CodigoNCM := '123456';
  lNFSe.Servico.PrestadoEmViasPublicas := False;
  lNFSe.Servico.LocalPrestacao := lpMunicipio;
  lNFSe.Servico.TipoLancamento := tlDevidoNoMunicPrestador;
  lNFSe.Servico.CodigoNBS := '987654321';
  lNFSe.Servico.CodigoInterContr := '258456';
  lNFSe.Servico.CFPS := '45379';
  lNFSe.Servico.InfAdicional := 'Teste';
  lNFSe.Servico.xFormaPagamento := 'Teste';
  lNFSe.Servico.cClassTrib := '0000001';
  lNFSe.Servico.INDOP := '4862';
  lNFSe.Servico.CodigoServicoNacional := '010101';
  lNFSe.Servico.CodigoTributacaoNacional := '001';

  lMemINI := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(FACBrNFSeX.NotasFiscais.GerarIni, lMemINI);

    Check(lMemINI.SectionExists('Itens001'), 'Seção "Itens001" não foi criada!');
    Check(not (lMemINI.SectionExists('Itens002')), 'Seção "Itens002" não deveria existir!');
  finally
    lMemINI.Free;
  end;
end;

initialization

  _RegisterTest('ACBrNFSeXINITests', ACBrNFSeXINITestCases);

end.

