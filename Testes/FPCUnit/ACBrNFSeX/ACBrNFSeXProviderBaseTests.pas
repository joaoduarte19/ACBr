unit ACBrNFSeXProviderBaseTests;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, ACBrTests.Util,
  ACBrNFSeX, ACBrNFSeXConversao;

type

  { TURLsEhParamsTest }

  TURLsEhParamsTest = class(TTestCase)
  private
    FACBrNFSeX: TACBrNFSeX;
    FMsgComum: String;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ConfiguraCandeiasDoJamariRO_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraAriquemesRO_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraItaunaMG_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraJuazeiroDoNorteCE_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraHorizonteCE_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraSaoPauloSPv100_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraSaoPauloSPv200_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraAvanhandavaSP_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraTatuiSP_APIPropriaEhURLsDefinidasCorretamente;
    procedure ConfiguraLindolfoCollor_APIPropriaEhURLsDefinidasCorretamente;
  end;


implementation

{ TURLsEhPAramsTest }

procedure TURLsEhPAramsTest.SetUp;
begin
  inherited SetUp;
  FACBrNFSeX := TACBrNFSeX.Create(nil);
end;

procedure TURLsEhPAramsTest.TearDown;
begin
  FACBrNFSeX.Free;
  inherited TearDown;
end;

procedure TURLsEhParamsTest.ConfiguraAriquemesRO_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 1100023;
  FMsgComum := 'Ariquemes/RO|IBGE:1100023|Fiorilli|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://adn.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/IssWeb-ejb/IssWebWS/IssWebWS',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('https://nfse.ariquemes.ro.gov.br/issweb/formGerarNF.jsf?nroNota=%NumeroNFSe%&codVerificacao=%CodVerif%&cnpj=%Cnpj%&hash=%ChaveAcesso%',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/issweb/formGerarNF.jsf?nroNota=%NumeroNFSe%&codVerificacao=%CodVerif%&cnpj=%Cnpj%&hash=%ChaveAcesso%',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraAvanhandavaSP_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3504404;
  FMsgComum := 'Avanhandava/SP|IBGE:3504404|Fiorilli|';
  Check(FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://adn.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('http://45.71.14.83:5661/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/IssWeb-ejb/IssWebWSNacional/IssWebWSNacionalPortType',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('http://fi1.fiorilli.com.br:5663/issweb/formGerarNF.jsf?nroNota=%NumeroNFSe%&codVerificacao=%CodVerif%&cnpj=%Cnpj%&hash=%ChaveAcesso%',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraCandeiasDoJamariRO_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 1100809;
  FMsgComum := 'Candeias do Jamari/RO|IBGE:1100809|Betha|';
  Check(FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://adn.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://nota-eletronica.betha.cloud:443/dps/ws',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraHorizonteCE_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 2305233;
  FMsgComum := 'Horizonte/CE|IBGE:2305233|SpeedGov|';
  Check(FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://adn.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://tributario.speedgov.com.br/horizonte/api/v1/nfse',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraItaunaMG_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3133808;
  FMsgComum := 'Itauna/MG|IBGE:3133808|ISSNet|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://nfse.issnetonline.com.br/abrasf204/itauna/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://www.issnetonline.com.br/homologaabrasf/webservicenfse204/nfse.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraJuazeiroDoNorteCE_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 2307304;
  FMsgComum := 'Juazeiro do Norte/CE|IBGE:2307304|SpeedGov|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('http://www.speedgov.com.br/wsjun/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('http://speedgov.com.br/wsmod/Nfes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraLindolfoCollor_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 4311627;
  FMsgComum := 'Lindolfo Collor/RS|IBGE:4311627|Tecnos|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9097/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9097/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9095/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9095/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9096/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9096/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9094/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9094/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9093/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9093/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9098/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9098/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9091/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9091/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('http://lindolfocollor.nfse-tecnos.com.br:9086/',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('http://homologalcollor.nfse-tecnos.com.br:9086/',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('*',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraSaoPauloSPv100_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3550308;
  FACBrNFSeX.Configuracoes.Geral.Versao := ve100;
  FMsgComum := 'Sao Paulo/SP|IBGE:3550308|ISSSaoPaulo|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/nfe.aspx?ccm=%InscMunic%&nf=%NumeroNFSe%&cod=%CodVerif%',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('https://nfe.prefeitura.sp.gov.br/nfe.aspx?ccm=%InscMunic%&nf=%NumeroNFSe%&cod=%CodVerif%',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

procedure TURLsEhParamsTest.ConfiguraSaoPauloSPv200_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3550308;
  FACBrNFSeX.Configuracoes.Geral.Versao := ve200;
  FMsgComum := 'Sao Paulo/SP|IBGE:3550308|ISSSaoPaulo|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
//As URLS da v2.00 s?o definidas em tempo de execução diretamente no código, N?O PEGA DO ACBrNFSeXServicos.ini
end;

procedure TURLsEhParamsTest.ConfiguraTatuiSP_APIPropriaEhURLsDefinidasCorretamente;
begin
  FACBrNFSeX.Configuracoes.Geral.CodigoMunicipio := 3554003;
  FMsgComum := 'Tatui/SP|IBGE:3554003|PadraoNacional|';
  Check(not FACBrNFSeX.Configuracoes.Geral.APIPropria, FMsgComum + 'APIPropria difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.Recepcionar,
               FMsgComum + 'Producao.Recepcionar difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.Recepcionar,
               FMsgComum + 'Homologacao.Recepcionar difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLote,
               FMsgComum + 'Producao.ConsultarLote difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLote,
               FMsgComum + 'Homologacao.ConsultarLote difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeRps,
               FMsgComum + 'Producao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeRps,
               FMsgComum + 'Homologacao.ConsultarNFSeRPS difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSituacao,
               FMsgComum + 'Producao.ConsultarSituacao difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSituacao,
               FMsgComum + 'Homologacao.ConsultarSituacao difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSe,
               FMsgComum + 'Producao.ConsultarNFSe difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSe,
               FMsgComum + 'Homologacao.ConsultarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorChave,
               FMsgComum + 'Producao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorChave,
               FMsgComum + 'Homologacao.ConsultarNFSePorChave difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSePorFaixa,
               FMsgComum + 'Producao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSePorFaixa,
               FMsgComum + 'Homologacao.ConsultarNFSePorFaixa difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Producao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoPrestado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoPrestado difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Producao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarNFSeServicoTomado,
               FMsgComum + 'Homologacao.ConsultarNFSeServicoTomado difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarLinkNFSe,
               FMsgComum + 'Producao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarLinkNFSe,
               FMsgComum + 'Homologacao.ConsultarLinkNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.CancelarNFSe,
               FMsgComum + 'Producao.CancelarNFSe difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.CancelarNFSe,
               FMsgComum + 'Homologacao.CancelarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarNFSe,
               FMsgComum + 'Producao.GerarNFSe difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarNFSe,
               FMsgComum + 'Homologacao.GerarNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.RecepcionarSincrono,
               FMsgComum + 'Producao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.RecepcionarSincrono,
               FMsgComum + 'Homologacao.RecepcionarSincrono difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.SubstituirNFSe,
               FMsgComum + 'Producao.SubstituirNFSe difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.SubstituirNFSe,
               FMsgComum + 'Homologacao.SubstituirNFSe difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.AbrirSessao,
               FMsgComum + 'Producao.AbrirSessao difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.AbrirSessao,
               FMsgComum + 'Homologacao.AbrirSessao difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.FecharSessao,
               FMsgComum + 'Producao.FecharSessao difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.FecharSessao,
               FMsgComum + 'Homologacao.FecharSessao difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.TesteEnvio,
               FMsgComum + 'Producao.TesteEnvio difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.TesteEnvio,
               FMsgComum + 'Homologacao.TesteEnvio difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.GerarToken,
               FMsgComum + 'Producao.GerarToken difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.GerarToken,
               FMsgComum + 'Homologacao.GerarToken difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.EnviarEvento,
               FMsgComum + 'Producao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.EnviarEvento,
               FMsgComum + 'Homologacao.EnviarEvento difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarEvento,
               FMsgComum + 'Producao.ConsultarEvento difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarEvento,
               FMsgComum + 'Homologacao.ConsultarEvento difere do esperado');
  CheckEquals('https://adn.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarDFe,
               FMsgComum + 'Producao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br/contribuintes',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarDFe,
               FMsgComum + 'Homologacao.ConsultarDFe difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarParam,
               FMsgComum + 'Producao.ConsultarParam difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarParam,
               FMsgComum + 'Homologacao.ConsultarParam difere do esperado');
  CheckEquals('https://sefin.nfse.gov.br/sefinnacional',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ConsultarSeqRps,
               FMsgComum + 'Producao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://sefin.producaorestrita.nfse.gov.br/SefinNacional',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ConsultarSeqRps,
               FMsgComum + 'Homologacao.ConsultarSeqRps difere do esperado');
  CheckEquals('https://adn.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.ObterDANFSE,
               FMsgComum + 'Producao.ObterDANFSE difere do esperado');
  CheckEquals('https://adn.producaorestrita.nfse.gov.br',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.ObterDANFSE,
               FMsgComum + 'Homologacao.ObterDANFSE difere do esperado');
  CheckEquals('https://www.nfse.gov.br/ConsultaPublica/?tpc=1&chave=%CodVerif%',
               FACBrNFSeX.Provider.ConfigWebServices.Producao.LinkURL,
               FMsgComum + 'Producao.LinkURL difere do esperado');
  CheckEquals('https://www.producaorestrita.nfse.gov.br/ConsultaPublica/?tpc=1&chave=%CodVerif%',
               FACBrNFSeX.Provider.ConfigWebServices.Homologacao.LinkURL,
               FMsgComum + 'Homologacao.LinkURL difere do esperado');
end;

initialization
  _RegisterTest('ACBrNFSeXProviderBase.URLsEhParams', TURLsEhParamsTest);

end.

