unit Form.NFSe;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,

  ACBrBase,
  ACBrDFe,
  ACBrNFSeX,
  ACBrSocket,
  ACBrIBGE,
  ACBrDFeReport,
  ACBrNFSeXDANFSeClass,
  ACBrNFSeXDANFSeFPDFClass;

type
  TFNFSe = class(TForm)
    G: TGroupBox;
    ckVariosItens: TCheckBox;
    rgTipoImpressao: TRadioGroup;
    Button1: TButton;
    rgStatus: TRadioGroup;
    gbLogomarca: TGroupBox;
    ckLogomarcaPrefeitura: TCheckBox;
    ckHomologacao: TCheckBox;
    ACBrNFSeX1: TACBrNFSeX;
    ckLogomarcaPrestador: TCheckBox;
    ckQRCode: TCheckBox;
    rbProvedor: TRadioGroup;
    ACBrIBGE1: TACBrIBGE;
    ckOutrasInformacoes: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraProvedorECarregaXMLExemplo;

    function RoundTo5(Valor: Double; Casas: Integer): Double;
  public
    { Public declarations }
  end;

var
  FNFSe             : TFNFSe;

implementation

uses
  IOUtils,
  Math,

  ACBr_fpdf,
  ACBr_fpdf_ext,
  ACBr_fpdf_report,

  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrDFeUtil,
  pcnConversao;

const
  cCuritiba         = 4106902;

{$R *.dfm}

procedure TFNFSe.Button1Click(Sender: TObject);
var
  NomeCidade        : string;
  I, C              : integer;
  NFSe              : TNFSe;

  danfse1           : TACBrNFSeXDANFSeFPDF;
begin
  ConfiguraProvedorECarregaXMLExemplo;

  if ACBrIBGE1.BuscarPorCodigo(ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio) >
    0 then
    NomeCidade := ACBrIBGE1.Cidades[0].Municipio
  else
    NomeCidade := '';

  NFSe := ACBrNFSeX1.NotasFiscais[0].NFSe;

  if ckVariosItens.Checked then
    for I := 1 to 30 do
    begin
      var Item := NFSe.Servico.ItemServico.New;

      Item.Descricao := 'Serviço';
      for C := 1 to I do
        Item.Descricao := Item.Descricao + ' serviço';

      Item.Descricao := Format('%0:d - %1:s %0:d', [I, Item.Descricao]);
      Item.Quantidade := I;
      Item.ValorUnitario := I;
      Item.ValorTotal := Item.Quantidade * Item.ValorUnitario;
    end;

  if ckOutrasInformacoes.Checked then
    NFSe.OutrasInformacoes :=
      '- Esta NFS-e foi emitida com respaldo na Lei n° 14.097/2005;' +
      '- Documento emitido por ME ou EPP optante pelo Simples Nacional;' +
      '- Esta NFS-e substitui o RPS N° 4222 Série 1, emitido em 26/07/2023;';

  //  if construcao then
  //    NFSe.ConstrucaoCivil.CodigoObra := '1234';
  //    NFSe.ConstrucaoCivil.Art := 'ART987';

  danfse1 := TACBrNFSeXDANFSeFPDF.Create(ACBrNFSeX1);
  try
  danfse1.TipoDANFSE :=tpPadraoNacional;
    ACBrNFSeX1.DANFSE := danfse1;

    //Report.QRCode      := ckQRCode.Checked;
//    if Report.QRCode and (UmaNFSe.Link <> '') then
//        UmaNFSe.Link := 'http://www.issdigitalthe.com.br/nfse/notaFiscal.php?id_nota_fiscal=MTA2ODk2MjQy&confirma=Tg==&temPrestador=Tg==';

    //if ckLogomarcaPrefeitura.Checked then
      danfse1.LogoNFSe := '..\..\logo_nfse.png';
    //else
      //danfse1.Logo := '';

//    if ckLogomarcaPrestador.Checked then
      danfse1.Logo := '..\..\logo_prest.png' ;
//    else
//      danfse1.Prestador.Logo := '';

    danfse1.Prefeitura := 'PREFEITURA DO MUNICIPIO DE ' + UpperCase(NomeCidade);

    //    danfse1.OutrasInformacaoesImp := 'PREFEITURA DO MUNICIPIO DE CERQUILHO SECRETARIA MUNICIPAL DE FINANÇAS 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789'+
    //                          'NOTA FISCAL ELETRÔNICA DE SERVIÇOS - NFe 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789';

    ACBrNFSeX1.NotasFiscais.ImprimirPDF;


  finally
    danfse1.Free;
  end;
end;

procedure TFNFSe.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

function TFNFSe.RoundTo5(Valor: Double; Casas: Integer): Double;
var
  xValor, xDecimais : string;
  p, nCasas         : Integer;
  nValor            : Double;
  OldRM             : TFPURoundingMode;
begin
  nValor := Valor;
  xValor := Trim(FloatToStr(Valor));
  p := pos(',', xValor);

  if Casas < 0 then
    nCasas := -Casas
  else
    nCasas := Casas;

  if p > 0 then
  begin
    xDecimais := Copy(xValor, p + 1, Length(xValor));

    OldRM := GetRoundMode;
    try
      if Length(xDecimais) > nCasas then
      begin
        if xDecimais[nCasas + 1] >= '5' then
          SetRoundMode(rmUP)
        else
          SetRoundMode(rmNearest);
      end;

      nValor := RoundTo(Valor, Casas);

    finally
      SetRoundMode(OldRM);
    end;
  end;

  Result := nValor;
end;

procedure TFNFSe.ConfiguraProvedorECarregaXMLExemplo;
var
  Xml               : string;
begin
  case rbProvedor.ItemIndex of
    0:                                  // ISS Curitiba
      begin
        Xml := TFile.ReadAllText('..\..\nfse-isscuritiba.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 4106902;
      end;

    1:                                  // ISSDSF
      begin
        Xml := TFile.ReadAllText('..\..\nfse-issdsf.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 2211001;
      end;

    2:                                  // ISS São Paulo
      begin
        Xml := TFile.ReadAllText('..\..\nfse-isssp.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 3550308;
      end;

    3:                                  // Betha
      begin
        Xml := TFile.ReadAllText('..\..\nfse-betha.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 4215455;
      end;

    4:                                  // Ginfes
      begin
        Xml := TFile.ReadAllText('..\..\nfse-ginfes.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 3547809;
      end;

    5:                                  // Tiplan
      begin
        Xml := TFile.ReadAllText('..\..\nfse-tiplan.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsProvedor;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 3304524;
      end;
    6:                                  //
      begin
        Xml := TFile.ReadAllText('C:\Users\juliomar\Downloads\43100091240912562000126000000000002026026837768156-nfse.xml');
        ACBrNFSeX1.Configuracoes.Geral.LayoutNFSe := lnfsPadraoNacionalv101;
        ACBrNFSeX1.Configuracoes.Geral.CodigoMunicipio := 4310009;
      end;
  else
    raise Exception.Create('Provedor não reconhecido');
  end;

  ACBrNFSeX1.NotasFiscais.Clear;
  ACBrNFSeX1.NotasFiscais.LoadFromString(Xml);
end;

end.

