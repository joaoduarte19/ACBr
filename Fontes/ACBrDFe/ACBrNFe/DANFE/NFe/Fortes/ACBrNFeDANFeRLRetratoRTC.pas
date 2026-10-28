{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Daniel Morais                                   }
{                                                                              }
{                                                                              }
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

unit ACBrNFeDANFeRLRetratoRTC;

interface

uses
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  {$IFDEF BORLAND}
   {$IF CompilerVersion > 22}
    Vcl.Imaging.jpeg,
   {$ELSE}
    jpeg,
   {$IFEND}
  {$ENDIF}
  RLReport,
  RLBarcode,
  ACBrNFeDANFeRTC,
  ACBrNFeDANFeRLRTC;

type

  { TfrlDANFeRLRetratoRTC }

  TfrlDANFeRLRetratoRTC = class(TfrlDANFeRLRTC)
    rlbCanhoto: TRLBand;
    rlpCanhotoRecebemos: TRLPanel;
    rllRecebemosDe: TRLLabel;
    rllResumo: TRLLabel;
    rlpCanhotoData: TRLPanel;
    rllTitCanhotoData: TRLLabel;
    rlpCanhotoAssinatura: TRLPanel;
    rllTitCanhotoAssinatura: TRLLabel;
    rlpCanhotoNFe: TRLPanel;
    rllCanhotoNFe: TRLLabel;
    rllCanhotoNumero: TRLLabel;
    rllCanhotoSerie: TRLLabel;
    rlbDivisaoCanhoto: TRLBand;
    rliDivisaoCanhoto: TRLDraw;
    rlbEmitente: TRLBand;
    rlpEmitente: TRLPanel;
    rliLogo: TRLImage;
    rlmEmitente: TRLMemo;
    rlmEndereco: TRLMemo;
    rlpDANFE: TRLPanel;
    rllDANFE: TRLLabel;
    rlmDocumento: TRLMemo;
    rlpTipoNF: TRLPanel;
    rllTipoNF: TRLLabel;
    rllEntradaSaida: TRLLabel;
    rllNumNF: TRLLabel;
    rllSerie: TRLLabel;
    rlsPagina: TRLSystemInfo;
    rlsUltimaPagina: TRLSystemInfo;
    rlpChave: TRLPanel;
    rlbCodigoBarras: TRLBarcode;
    rliChave1: TRLDraw;
    rllTitChave: TRLLabel;
    rllChave: TRLLabel;
    rliChave2: TRLDraw;
    rlmConsulta: TRLMemo;
    rllXmotivo: TRLLabel;
    rlpNatOp: TRLPanel;
    rllTitNatOp: TRLLabel;
    rllNatOp: TRLLabel;
    rlpProtocolo: TRLPanel;
    rllTitProtocolo: TRLLabel;
    rllProtocolo: TRLLabel;
    rlpIE: TRLPanel;
    rllTitIE: TRLLabel;
    rllIE: TRLLabel;
    rlpIEST: TRLPanel;
    rllTitIEST: TRLLabel;
    rllIEST: TRLLabel;
    rlpCNPJ: TRLPanel;
    rllTitCNPJ: TRLLabel;
    rllCNPJ: TRLLabel;
    rlpCRT: TRLPanel;
    rllTitCRT: TRLLabel;
    rllCRT: TRLLabel;
    rlpRegimeApuracao: TRLPanel;
    rllTitRegimeApuracao: TRLLabel;
    rllRegimeApuracao: TRLLabel;
    rlbDestinatario: TRLBand;
    rllSecDestinatario: TRLLabel;
    rlpDestNome: TRLPanel;
    rllTitDestNome: TRLLabel;
    rllDestNome: TRLLabel;
    rlpDestCNPJ: TRLPanel;
    rllTitDestCNPJ: TRLLabel;
    rllDestCNPJ: TRLLabel;
    rlpDestEmissao: TRLPanel;
    rllTitDestEmissao: TRLLabel;
    rllDestEmissao: TRLLabel;
    rlpDestEndereco: TRLPanel;
    rllTitDestEndereco: TRLLabel;
    rllDestEndereco: TRLLabel;
    rlpDestBairro: TRLPanel;
    rllTitDestBairro: TRLLabel;
    rllDestBairro: TRLLabel;
    rlpDestCEP: TRLPanel;
    rllTitDestCEP: TRLLabel;
    rllDestCEP: TRLLabel;
    rlpDestSaida: TRLPanel;
    rllTitDestSaida: TRLLabel;
    rllDestSaida: TRLLabel;
    rlpDestMunicipio: TRLPanel;
    rllTitDestMunicipio: TRLLabel;
    rllDestMunicipio: TRLLabel;
    rlpDestFone: TRLPanel;
    rllTitDestFone: TRLLabel;
    rllDestFone: TRLLabel;
    rlpDestUF: TRLPanel;
    rllTitDestUF: TRLLabel;
    rllDestUF: TRLLabel;
    rlpDestIE: TRLPanel;
    rllTitDestIE: TRLLabel;
    rllDestIE: TRLLabel;
    rlpDestHoraSaida: TRLPanel;
    rllTitDestHoraSaida: TRLLabel;
    rllDestHoraSaida: TRLLabel;
    rlbRetirada: TRLBand;
    rllSecRetirada: TRLLabel;
    rlpRetiradaNome: TRLPanel;
    rllTitRetiradaNome: TRLLabel;
    rllRetiradaNome: TRLLabel;
    rlpRetiradaCNPJ: TRLPanel;
    rllTitRetiradaCNPJ: TRLLabel;
    rllRetiradaCNPJ: TRLLabel;
    rlpRetiradaIE: TRLPanel;
    rllTitRetiradaIE: TRLLabel;
    rllRetiradaIE: TRLLabel;
    rlpRetiradaEndereco: TRLPanel;
    rllTitRetiradaEndereco: TRLLabel;
    rllRetiradaEndereco: TRLLabel;
    rlpRetiradaBairro: TRLPanel;
    rllTitRetiradaBairro: TRLLabel;
    rllRetiradaBairro: TRLLabel;
    rlpRetiradaCEP: TRLPanel;
    rllTitRetiradaCEP: TRLLabel;
    rllRetiradaCEP: TRLLabel;
    rlpRetiradaMunicipio: TRLPanel;
    rllTitRetiradaMunicipio: TRLLabel;
    rllRetiradaMunicipio: TRLLabel;
    rlpRetiradaFone: TRLPanel;
    rllTitRetiradaFone: TRLLabel;
    rllRetiradaFone: TRLLabel;
    rlpRetiradaUF: TRLPanel;
    rllTitRetiradaUF: TRLLabel;
    rllRetiradaUF: TRLLabel;
    rlbEntrega: TRLBand;
    rllSecEntrega: TRLLabel;
    rlpEntregaNome: TRLPanel;
    rllTitEntregaNome: TRLLabel;
    rllEntregaNome: TRLLabel;
    rlpEntregaCNPJ: TRLPanel;
    rllTitEntregaCNPJ: TRLLabel;
    rllEntregaCNPJ: TRLLabel;
    rlpEntregaIE: TRLPanel;
    rllTitEntregaIE: TRLLabel;
    rllEntregaIE: TRLLabel;
    rlpEntregaEndereco: TRLPanel;
    rllTitEntregaEndereco: TRLLabel;
    rllEntregaEndereco: TRLLabel;
    rlpEntregaBairro: TRLPanel;
    rllTitEntregaBairro: TRLLabel;
    rllEntregaBairro: TRLLabel;
    rlpEntregaCEP: TRLPanel;
    rllTitEntregaCEP: TRLLabel;
    rllEntregaCEP: TRLLabel;
    rlpEntregaMunicipio: TRLPanel;
    rllTitEntregaMunicipio: TRLLabel;
    rllEntregaMunicipio: TRLLabel;
    rlpEntregaFone: TRLPanel;
    rllTitEntregaFone: TRLLabel;
    rllEntregaFone: TRLLabel;
    rlpEntregaUF: TRLPanel;
    rllTitEntregaUF: TRLLabel;
    rllEntregaUF: TRLLabel;
    rlbFatura: TRLBand;
    rllSecFatura: TRLLabel;
    rlbTotalNota: TRLBand;
    rllSecTotalNota: TRLLabel;
    rlpTotProdutos: TRLPanel;
    rllTitTotProdutos: TRLLabel;
    rllTotProdutos: TRLLabel;
    rlpTotFrete: TRLPanel;
    rllTitTotFrete: TRLLabel;
    rllTotFrete: TRLLabel;
    rlpTotSeguro: TRLPanel;
    rllTitTotSeguro: TRLLabel;
    rllTotSeguro: TRLLabel;
    rlpTotDesconto: TRLPanel;
    rllTitTotDesconto: TRLLabel;
    rllTotDesconto: TRLLabel;
    rlpTotOutras: TRLPanel;
    rllTitTotOutras: TRLLabel;
    rllTotOutras: TRLLabel;
    rlpTotNota: TRLPanel;
    rllTitTotNota: TRLLabel;
    rllTotNota: TRLLabel;
    rlbTotalICMSIPI: TRLBand;
    rllSecTotalICMSIPI: TRLLabel;
    rlpBaseICMS: TRLPanel;
    rllTitBaseICMS: TRLLabel;
    rllBaseICMS: TRLLabel;
    rlpValorICMS: TRLPanel;
    rllTitValorICMS: TRLLabel;
    rllValorICMS: TRLLabel;
    rlpBaseICMSST: TRLPanel;
    rllTitBaseICMSST: TRLLabel;
    rllBaseICMSST: TRLLabel;
    rlpValorICMSST: TRLPanel;
    rllTitValorICMSST: TRLLabel;
    rllValorICMSST: TRLLabel;
    rlpValorIPI: TRLPanel;
    rllTitValorIPI: TRLLabel;
    rllValorIPI: TRLLabel;
    rlbICMSFCPDifal: TRLBand;
    rlpFCP: TRLPanel;
    rllTitFCP: TRLLabel;
    rllFCP: TRLLabel;
    rlpFCPST: TRLPanel;
    rllTitFCPST: TRLLabel;
    rllFCPST: TRLLabel;
    rlpICMSUFDest: TRLPanel;
    rllTitICMSUFDest: TRLLabel;
    rllICMSUFDest: TRLLabel;
    rlpFCPUFDest: TRLPanel;
    rllTitFCPUFDest: TRLLabel;
    rllFCPUFDest: TRLLabel;
    rlbICMSMonofasico: TRLBand;
    rlpBCICMSMono: TRLPanel;
    rllTitBCICMSMono: TRLLabel;
    rllBCICMSMono: TRLLabel;
    rlpICMSMono: TRLPanel;
    rllTitICMSMono: TRLLabel;
    rllICMSMono: TRLLabel;
    rlpBCICMSMonoReten: TRLPanel;
    rllTitBCICMSMonoReten: TRLLabel;
    rllBCICMSMonoReten: TRLLabel;
    rlpICMSMonoReten: TRLPanel;
    rllTitICMSMonoReten: TRLLabel;
    rllICMSMonoReten: TRLLabel;
    rlbTotalIBSCBSIS: TRLBand;
    rllSecTotalIBSCBSIS: TRLLabel;
    rlpCBS: TRLPanel;
    rllTitCBS: TRLLabel;
    rllCBS: TRLLabel;
    rlpIBSUF: TRLPanel;
    rllTitIBSUF: TRLLabel;
    rllIBSUF: TRLLabel;
    rlpIBSMun: TRLPanel;
    rllTitIBSMun: TRLLabel;
    rllIBSMun: TRLLabel;
    rlpIS: TRLPanel;
    rllTitIS: TRLLabel;
    rllIS: TRLLabel;
    rlbIBSCBSMonofasico: TRLBand;
    rlpIBSMono: TRLPanel;
    rllTitIBSMono: TRLLabel;
    rllIBSMono: TRLLabel;
    rlpCBSMono: TRLPanel;
    rllTitCBSMono: TRLLabel;
    rllCBSMono: TRLLabel;
    rlpIBSMonoReten: TRLPanel;
    rllTitIBSMonoReten: TRLLabel;
    rllIBSMonoReten: TRLLabel;
    rlpCBSMonoReten: TRLPanel;
    rllTitCBSMonoReten: TRLLabel;
    rllCBSMonoReten: TRLLabel;
    rlbISSQN: TRLBand;
    rllSecISSQN: TRLLabel;
    rlpISSQNInscricao: TRLPanel;
    rllTitISSQNInscricao: TRLLabel;
    rllISSQNInscricao: TRLLabel;
    rlpISSQNServicos: TRLPanel;
    rllTitISSQNServicos: TRLLabel;
    rllISSQNServicos: TRLLabel;
    rlpISSQNBase: TRLPanel;
    rllTitISSQNBase: TRLLabel;
    rllISSQNBase: TRLLabel;
    rlpISSQNValor: TRLPanel;
    rllTitISSQNValor: TRLLabel;
    rllISSQNValor: TRLLabel;
    rlbTransportador: TRLBand;
    rllSecTransportador: TRLLabel;
    rlpTransNome: TRLPanel;
    rllTitTransNome: TRLLabel;
    rllTransNome: TRLLabel;
    rlpTransModFrete: TRLPanel;
    rllTitTransModFrete: TRLLabel;
    rllTransModFrete: TRLLabel;
    rlpTransANTT: TRLPanel;
    rllTitTransANTT: TRLLabel;
    rllTransANTT: TRLLabel;
    rlpTransPlaca: TRLPanel;
    rllTitTransPlaca: TRLLabel;
    rllTransPlaca: TRLLabel;
    rlpTransUFPlaca: TRLPanel;
    rllTitTransUFPlaca: TRLLabel;
    rllTransUFPlaca: TRLLabel;
    rlpTransCNPJ: TRLPanel;
    rllTitTransCNPJ: TRLLabel;
    rllTransCNPJ: TRLLabel;
    rlpTransEndereco: TRLPanel;
    rllTitTransEndereco: TRLLabel;
    rllTransEndereco: TRLLabel;
    rlpTransMunicipio: TRLPanel;
    rllTitTransMunicipio: TRLLabel;
    rllTransMunicipio: TRLLabel;
    rlpTransUF: TRLPanel;
    rllTitTransUF: TRLLabel;
    rllTransUF: TRLLabel;
    rlpTransIE: TRLPanel;
    rllTitTransIE: TRLLabel;
    rllTransIE: TRLLabel;
    rlpVolQtde: TRLPanel;
    rllTitVolQtde: TRLLabel;
    rlmVolQtde: TRLMemo;
    rlpVolEspecie: TRLPanel;
    rllTitVolEspecie: TRLLabel;
    rlmVolEspecie: TRLMemo;
    rlpVolMarca: TRLPanel;
    rllTitVolMarca: TRLLabel;
    rlmVolMarca: TRLMemo;
    rlpVolNumeracao: TRLPanel;
    rllTitVolNumeracao: TRLLabel;
    rlmVolNumeracao: TRLMemo;
    rlpVolPesoBruto: TRLPanel;
    rllTitVolPesoBruto: TRLLabel;
    rlmVolPesoBruto: TRLMemo;
    rlpVolPesoLiquido: TRLPanel;
    rllTitVolPesoLiquido: TRLLabel;
    rlmVolPesoLiquido: TRLMemo;
    rlbCanceladaDenegada: TRLBand;
    rllCanceladaDenegada: TRLLabel;
    rlbAvisoContingencia: TRLBand;
    rllAvisoContingencia: TRLLabel;
    rlmContingencia: TRLMemo;
    rlbCabecalhoItens: TRLBand;
    rllSecItens: TRLLabel;
    rlpCabDescricao: TRLPanel;
    rlmCabDescricao: TRLMemo;
    rlpCabCSTCFOP: TRLPanel;
    rlmCabCSTCFOP: TRLMemo;
    rlpCabQuantidade: TRLPanel;
    rlmCabQuantidade: TRLMemo;
    rlpCabValorUnitario: TRLPanel;
    rlmCabValorUnitario: TRLMemo;
    rlpCabValorTotal: TRLPanel;
    rlmCabValorTotal: TRLMemo;
    rlpCabBases: TRLPanel;
    rlmCabBases: TRLMemo;
    rlpCabAliquotas: TRLPanel;
    rlmCabAliquotas: TRLMemo;
    rlpCabValores: TRLPanel;
    rlmCabValores: TRLMemo;
    subItens: TRLSubDetail;
    rlbItem: TRLBand;
    rliItemEsquerda: TRLDraw;
    rliItemDireita: TRLDraw;
    rliItemBase: TRLDraw;
    rliItemColuna1: TRLDraw;
    rliItemColuna2: TRLDraw;
    rliItemColuna3: TRLDraw;
    rliItemColuna4: TRLDraw;
    rliItemColuna5: TRLDraw;
    rliItemColuna6: TRLDraw;
    rliItemColuna7: TRLDraw;
    rlmXProd: TRLMemo;
    rlmInfAdProd: TRLMemo;
    rllClassificacao: TRLLabel;
    rllCST: TRLLabel;
    rllCFOP: TRLLabel;
    rlmQuantidade: TRLMemo;
    rlmValorUnitario: TRLMemo;
    rllValorTotal: TRLLabel;
    rllBaseRotulo0: TRLLabel;
    rllBaseValor0: TRLLabel;
    rllBaseRotulo1: TRLLabel;
    rllBaseValor1: TRLLabel;
    rllBaseRotulo2: TRLLabel;
    rllBaseValor2: TRLLabel;
    rllBaseRotulo3: TRLLabel;
    rllBaseValor3: TRLLabel;
    rllAliqRotulo00: TRLLabel;
    rllAliqValor00: TRLLabel;
    rllAliqRotulo01: TRLLabel;
    rllAliqValor01: TRLLabel;
    rllAliqBarra0: TRLLabel;
    rllAliqRotulo10: TRLLabel;
    rllAliqValor10: TRLLabel;
    rllAliqRotulo11: TRLLabel;
    rllAliqValor11: TRLLabel;
    rllAliqBarra1: TRLLabel;
    rllAliqRotulo20: TRLLabel;
    rllAliqValor20: TRLLabel;
    rllAliqRotulo21: TRLLabel;
    rllAliqValor21: TRLLabel;
    rllAliqBarra2: TRLLabel;
    rllValRotulo00: TRLLabel;
    rllValValor00: TRLLabel;
    rllValRotulo01: TRLLabel;
    rllValValor01: TRLLabel;
    rllValBarra0: TRLLabel;
    rllValRotulo10: TRLLabel;
    rllValValor10: TRLLabel;
    rllValRotulo11: TRLLabel;
    rllValValor11: TRLLabel;
    rllValBarra1: TRLLabel;
    rllValRotulo20: TRLLabel;
    rllValValor20: TRLLabel;
    rllValRotulo21: TRLLabel;
    rllValValor21: TRLLabel;
    rllValBarra2: TRLLabel;
    rlbDadosAdicionais: TRLBand;
    rllSecDadosAdicionais: TRLLabel;
    rlpInfCompl: TRLPanel;
    rllTitInfCompl: TRLLabel;
    rlmDadosAdicionais: TRLMemo;
    rlpFisco: TRLPanel;
    rllTitFisco: TRLLabel;
    rlmDadosFisco: TRLMemo;
    rlpQRCode: TRLPanel;
    rllTitQRCode: TRLLabel;
    rliQRCodeLinha: TRLDraw;
    rliQRCode: TRLImage;
    rlmDadosAdicionaisAuxiliar: TRLMemo;
    rllHomologacao: TRLLabel;
    rlbRodape: TRLBand;
    rllUsuario: TRLLabel;
    rllSistema: TRLLabel;
    rlbContinuacao: TRLBand;
    rllSecContinuacao: TRLLabel;
    rlpContinuacao: TRLPanel;
    rlmContinuacaoDadosAdicionais: TRLMemo;
    procedure RLNFeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLNFeDataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var EOF: Boolean; var RecordAction: TRLRecordAction);
    procedure rlbCanhotoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbEmitenteBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbDadosAdicionaisBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbContinuacaoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure subItensDataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var EOF: Boolean; var RecordAction: TRLRecordAction);
    procedure rlbItemBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    FNumItem: Integer;
    FBaseRotulo: array[0..3] of TRLLabel;
    FBaseValor: array[0..3] of TRLLabel;
    FAliqRotulo: array[0..2, 0..1] of TRLLabel;
    FAliqValor: array[0..2, 0..1] of TRLLabel;
    FValRotulo: array[0..2, 0..1] of TRLLabel;
    FValValor: array[0..2, 0..1] of TRLLabel;
    FLarguraBase: Integer;
    FLarguraAliq: Integer;
    FLarguraVal: Integer;

    procedure InicializarDados;
    procedure MapearTributosItem;
    procedure DefinirCanhoto;
    procedure DefinirCabecalho;
    procedure DefinirEmitente;
    procedure DefinirAvisos;
    procedure DefinirDestinatario;
    procedure DefinirRetirada;
    procedure DefinirEntrega;
    procedure DefinirFatura;
    procedure DefinirTotais;
    procedure DefinirISSQN;
    procedure DefinirTransporte;
    procedure DefinirDadosAdicionais;
    procedure DefinirQRCode;
    procedure DefinirRodape;
    function NumeroNF: String;
    function SerieNF: String;
    function ProtocoloAutorizacao: String;
    function CriarCelula(ABand: TRLBand; ALeft, ATop, AWidth: Integer;
      const ATitulo, AValor: String): TRLPanel;
    procedure DefinirTributo(ARotulo, AValor: TRLLabel; ALargura: Integer;
      const ATributo: TACBrNFeDANFeRTCTributo; AAliquota: Boolean);
  end;

implementation

uses
  Math,
  DateUtils,
  StrUtils,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrValidador,
  ACBrImage,
  ACBrDelphiZXingQRCode,
  ACBrDFeUtil,
  ACBrDFeReportFortes,
  ACBrDFeDANFeReport,
  ACBrDFe.Conversao,
  ACBrNFe,
  ACBrNFe.Classes,
  pcnConversaoNFe;

{$IfNDef FPC}
 {$R *.dfm}
{$Else}
 {$R *.lfm}
{$EndIf}

const
  cAlturaCelula = 24;
  cTopoCelulas = 15;
  cAlturaLinhaVolume = 12;
  cAlturaMinimaItem = 38;

{ TfrlDANFeRLRetratoRTC }

procedure TfrlDANFeRLRetratoRTC.RLNFeBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  InicializarDados;
end;

procedure TfrlDANFeRLRetratoRTC.RLNFeDataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var EOF: Boolean; var RecordAction: TRLRecordAction);
begin
  EOF := (RecNo > 1);
  RecordAction := raUseIt;
end;

procedure TfrlDANFeRLRetratoRTC.rlbCanhotoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  PrintIt := (RLNFe.PageNumber = 1);
end;

procedure TfrlDANFeRLRetratoRTC.rlbEmitenteBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  rlbDadosAdicionais.Visible := (RLNFe.PageNumber = 1);

  if (RLNFe.PageNumber > 1) then
    rllSecItens.Caption := ACBrStr(' CONTINUAÇÃO DOS DADOS DOS PRODUTOS / SERVIÇOS');
end;

procedure TfrlDANFeRLRetratoRTC.rlbDadosAdicionaisBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := (RLNFe.PageNumber = 1);
end;

procedure TfrlDANFeRLRetratoRTC.rlbContinuacaoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if (RLNFe.PageNumber = 1) then
    RLNFe.NewPageNeeded := True;

  rlpContinuacao.Height := rlmContinuacaoDadosAdicionais.Top +
    rlmContinuacaoDadosAdicionais.Height + 2;
  rlbContinuacao.Height := rlpContinuacao.Top + rlpContinuacao.Height + 1;
end;

procedure TfrlDANFeRLRetratoRTC.subItensDataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var EOF: Boolean; var RecordAction: TRLRecordAction);
begin
  FNumItem := RecNo - 1;
  EOF := (RecNo > fpRTC.QuantidadeItens);
  RecordAction := raUseIt;
end;

procedure TfrlDANFeRLRetratoRTC.rlbItemBeforePrint(Sender: TObject; var PrintIt: Boolean);
var
  LDet: TDetCollectionItem;
  LItem: TACBrNFeDANFeRTCItem;
  LInfAd, LUnidade, LQuantidade, LValorUnitario: String;
  LTopo, L, C: Integer;
begin
  LDet := fpNFe.Det.Items[FNumItem];
  LItem := fpRTC.Item(FNumItem);

  rlmXProd.Lines.Text := LDet.Prod.xProd;

  LInfAd := Copy(fpDANFe.ManterXProd(fpNFe, FNumItem), Length(LDet.Prod.xProd) + 1, MaxInt);
  if (fpDANFe.ExibeInforAdicProduto = infSeparadamente) then
    LInfAd := StringReplace(Trim(LDet.infAdProd), fpDANFe.CaractereQuebraDeLinha,
      sLineBreak, [rfReplaceAll]) + LInfAd;

  LInfAd := Trim(LInfAd);
  if (Copy(LInfAd, 1, 2) = '- ') then
    LInfAd := Trim(Copy(LInfAd, 3, MaxInt));

  rlmInfAdProd.Lines.Text := LInfAd;
  rlmInfAdProd.Visible := (LInfAd <> '');
  rlmInfAdProd.Top := rlmXProd.Top + rlmXProd.Height;

  if rlmInfAdProd.Visible then
    LTopo := rlmInfAdProd.Top + rlmInfAdProd.Height
  else
    LTopo := rlmInfAdProd.Top;

  rllClassificacao.Caption := fpRTC.ClassificacaoItem(FNumItem);
  rllClassificacao.Top := Max(LTopo, cAlturaMinimaItem - rllClassificacao.Height - 1);

  rllCST.Caption := 'CST.....' + LItem.CST;
  rllCFOP.Caption := 'CFOP..' + LItem.CFOP;

  case fpDANFe.ImprimeValor of
    iuTributavel:
      begin
        LUnidade := LDet.Prod.uTrib;
        LQuantidade := fpDANFe.FormatarQuantidade(LDet.Prod.qTrib);
        LValorUnitario := fpDANFe.FormatarValorUnitario(LDet.Prod.vUnTrib);
      end;

    iuComercialETributavel:
      if (LDet.Prod.uCom <> LDet.Prod.uTrib) then
      begin
        LUnidade := fpDANFe.ManterUnidades(LDet.Prod.uCom, LDet.Prod.uTrib);
        LQuantidade := fpDANFe.ManterQuantidades(LDet.Prod.qCom, LDet.Prod.qTrib);
        LValorUnitario := fpDANFe.ManterValoresUnitarios(LDet.Prod.vUnCom, LDet.Prod.vUnTrib);
      end
      else
      begin
        LUnidade := LDet.Prod.uCom;
        LQuantidade := fpDANFe.FormatarQuantidade(LDet.Prod.qCom);
        LValorUnitario := fpDANFe.FormatarValorUnitario(LDet.Prod.vUnCom);
      end;
  else
    LUnidade := LDet.Prod.uCom;
    LQuantidade := fpDANFe.FormatarQuantidade(LDet.Prod.qCom);
    LValorUnitario := fpDANFe.FormatarValorUnitario(LDet.Prod.vUnCom);
  end;

  rlmQuantidade.Lines.Text := LQuantidade + sLineBreak + '[' +
    StringReplace(Trim(LUnidade), sLineBreak, ']' + sLineBreak + '[', [rfReplaceAll]) + ']';
  rlmValorUnitario.Lines.Text := LValorUnitario;
  rllValorTotal.Caption := fpRTC.FormatarValor(LDet.Prod.vProd);

  for L := 0 to 3 do
    DefinirTributo(FBaseRotulo[L], FBaseValor[L], FLarguraBase, LItem.Bases[L], False);

  for L := 0 to 2 do
    for C := 0 to 1 do
    begin
      DefinirTributo(FAliqRotulo[L, C], FAliqValor[L, C], FLarguraAliq,
        LItem.Aliquotas[L, C], True);
      DefinirTributo(FValRotulo[L, C], FValValor[L, C], FLarguraVal,
        LItem.Valores[L, C], False);
    end;

  rlbItem.Height := Max(cAlturaMinimaItem,
    Max(rllClassificacao.Top + rllClassificacao.Height + 1,
        rlmQuantidade.Top + rlmQuantidade.Height + 1));
end;

procedure TfrlDANFeRLRetratoRTC.InicializarDados;
begin
  TDFeReportFortes.AjustarMargem(RLNFe, fpDANFe);
  RLNFe.Title := RemoverLiteralChave(fpNFe.infNFe.ID);

  MapearTributosItem;
  DefinirCanhoto;
  DefinirCabecalho;
  DefinirEmitente;
  DefinirAvisos;
  DefinirDestinatario;
  DefinirRetirada;
  DefinirEntrega;
  DefinirFatura;
  DefinirTotais;
  DefinirISSQN;
  DefinirTransporte;
  DefinirDadosAdicionais;
  DefinirQRCode;
  DefinirRodape;
end;

procedure TfrlDANFeRLRetratoRTC.MapearTributosItem;
var
  L, C: Integer;
begin
  for L := 0 to 3 do
  begin
    FBaseRotulo[L] := TRLLabel(FindComponent('rllBaseRotulo' + IntToStr(L)));
    FBaseValor[L] := TRLLabel(FindComponent('rllBaseValor' + IntToStr(L)));
  end;

  for L := 0 to 2 do
    for C := 0 to 1 do
    begin
      FAliqRotulo[L, C] := TRLLabel(FindComponent('rllAliqRotulo' + IntToStr(L) + IntToStr(C)));
      FAliqValor[L, C] := TRLLabel(FindComponent('rllAliqValor' + IntToStr(L) + IntToStr(C)));
      FValRotulo[L, C] := TRLLabel(FindComponent('rllValRotulo' + IntToStr(L) + IntToStr(C)));
      FValValor[L, C] := TRLLabel(FindComponent('rllValValor' + IntToStr(L) + IntToStr(C)));
    end;

  FLarguraBase := FBaseRotulo[0].Width;
  FLarguraAliq := FAliqRotulo[0, 0].Width;
  FLarguraVal := FValRotulo[0, 0].Width;

  for L := 0 to 3 do
    FBaseRotulo[L].AutoSize := True;

  for L := 0 to 2 do
    for C := 0 to 1 do
    begin
      FAliqRotulo[L, C].AutoSize := True;
      FValRotulo[L, C].AutoSize := True;
    end;
end;

function TfrlDANFeRLRetratoRTC.NumeroNF: String;
begin
  if fpDANFe.FormatarNumeroDocumento then
    Result := FormatarNumeroDocumentoFiscal(IntToStr(fpNFe.Ide.nNF))
  else
    Result := IntToStr(fpNFe.Ide.nNF);

  Result := ACBrStr('Nº ') + Result;
end;

function TfrlDANFeRLRetratoRTC.SerieNF: String;
begin
  Result := ACBrStr('SÉRIE ') + PadLeft(IntToStr(fpNFe.Ide.serie), 3, '0');
end;

function TfrlDANFeRLRetratoRTC.ProtocoloAutorizacao: String;
begin
  if NaoEstaVazio(fpDANFe.Protocolo) then
    Result := fpDANFe.Protocolo
  else if NaoEstaVazio(fpNFe.procNFe.nProt) then
    Result := fpNFe.procNFe.nProt + ' - ' + FormatDateTimeBr(fpNFe.procNFe.dhRecbto)
  else
    Result := '';
end;

procedure TfrlDANFeRLRetratoRTC.DefinirCanhoto;
begin
  rllRecebemosDe.Caption := ACBrStr('RECEBEMOS DE ') + fpNFe.Emit.xNome +
    ACBrStr(' OS PRODUTOS/SERVIÇOS CONSTANTES DA NOTA FISCAL ELETRÔNICA INDICADA AO LADO');

  rllResumo.Visible := fpDANFe.ExibeResumoCanhoto;
  if NaoEstaVazio(fpDANFe.TextoResumoCanhoto) then
    rllResumo.Caption := fpDANFe.TextoResumoCanhoto
  else
    rllResumo.Caption := ACBrStr('EMISSÃO: ') + FormatDateBr(fpNFe.Ide.dEmi) +
      '  -  DEST. / REM.: ' + fpNFe.Dest.xNome +
      '  -  VALOR TOTAL: R$ ' + fpRTC.FormatarValor(fpNFe.Total.ICMSTot.vNF);

  rllCanhotoNumero.Caption := NumeroNF;
  rllCanhotoSerie.Caption := SerieNF;

  if (fpDANFe.PosCanhoto = prRodape) then
  begin
    rlbDivisaoCanhoto.BandType := btFooter;
    rlbCanhoto.BandType := btFooter;
    rlbDivisaoCanhoto.Top := rlbRodape.Top + rlbRodape.Height;
    rlbCanhoto.Top := rlbDivisaoCanhoto.Top + rlbDivisaoCanhoto.Height;
  end;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirCabecalho;
begin
  rlbCodigoBarras.Caption := RemoverLiteralChave(fpNFe.infNFe.ID);
  rllChave.Caption := FormatarChaveAcesso(fpNFe.infNFe.ID);

  rllTipoNF.Caption := tpNFToStr(fpNFe.Ide.tpNF);
  rllNumNF.Caption := NumeroNF;
  rllSerie.Caption := SerieNF;
  rllNatOp.Caption := fpNFe.Ide.natOp;

  rllTitProtocolo.Caption := ACBrStr('PROTOCOLO DE AUTORIZAÇÃO DE USO');
  rllProtocolo.Caption := ProtocoloAutorizacao;

  case fpNFe.Ide.tpEmis of
    teContingencia, teFSDA:
      begin
        rllTitProtocolo.Caption := 'DADOS DA NF-E';
        rllProtocolo.Caption := FormatarChaveAcesso(
          TACBrNFe(fpDANFe.ACBrNFe).GerarChaveContingencia(fpNFe));
      end;

    teDPEC:
      if EstaVazio(fpNFe.procNFe.nProt) then
      begin
        rllTitProtocolo.Caption := ACBrStr('NÚMERO DE REGISTRO DO EPEC');
        rllProtocolo.Caption := fpDANFe.Protocolo;
      end;
  end;

  if fpDANFe.Cancelada then
    rllTitProtocolo.Caption := ACBrStr('PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO')
  else
    case fpNFe.procNFe.cStat of
      101, 135, 151, 155:
        rllTitProtocolo.Caption := ACBrStr('PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO');
      110, 205, 301, 302:
        rllTitProtocolo.Caption := ACBrStr('PROTOCOLO DE DENEGAÇÃO DE USO');
    end;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirEmitente;
var
  LEnder: TenderEmit;
begin
  rlmEmitente.Lines.Text := fpDANFe.ManterNomeImpresso(fpNFe.Emit.xNome, fpNFe.Emit.xFant);

  LEnder := fpNFe.Emit.EnderEmit;
  rlmEndereco.Lines.Clear;
  rlmEndereco.Lines.Add(Trim(LEnder.xLgr) + IfThen(LEnder.nro = '0', '', ', ' + LEnder.nro) +
    IfThen(NaoEstaVazio(LEnder.xCpl), ' ' + Trim(LEnder.xCpl), '') + ' - ' + Trim(LEnder.xBairro));
  rlmEndereco.Lines.Add(LEnder.xMun + '/' + LEnder.UF + ' - CEP ' + FormatarCEP(LEnder.CEP));

  if NaoEstaVazio(LEnder.fone) then
    rlmEndereco.Lines.Add('FONE: ' + FormatarFone(LEnder.fone));

  if NaoEstaVazio(fpDANFe.Site) then
    rlmEndereco.Lines.Add(fpDANFe.Site);

  if NaoEstaVazio(fpDANFe.Email) then
    rlmEndereco.Lines.Add(fpDANFe.Email);

  rllIE.Caption := fpNFe.Emit.IE;
  rllIEST.Caption := fpNFe.Emit.IEST;
  rllCNPJ.Caption := FormatarCNPJouCPF(fpNFe.Emit.CNPJCPF);
  rllCRT.Caption := fpRTC.Emitente.CRT;
  rllRegimeApuracao.Caption := fpRTC.Emitente.TipoRegimeApuracao;

  if TDFeReportFortes.CarregarLogo(rliLogo, fpDANFe.Logo) then
  begin
    if fpDANFe.ExpandeLogoMarca then
    begin
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rliLogo.SetBounds(2, 2, rlpEmitente.Width - 4, rlpEmitente.Height - 4);
      TDFeReportFortes.AjustarLogo(rliLogo, fpDANFe.ExpandeLogoMarcaConfig);
    end;
  end
  else
  begin
    rliLogo.Visible := False;
    rlmEmitente.Left := 4;
    rlmEmitente.Width := rlpEmitente.Width - 8;
    rlmEndereco.Left := rlmEmitente.Left;
    rlmEndereco.Width := rlmEmitente.Width;
  end;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirAvisos;
var
  LSituacao: String;
begin
  rllHomologacao.Visible := (fpNFe.Ide.tpAmb = taHomologacao);
  rllHomologacao.Caption := ACBrStr('AMBIENTE DE HOMOLOGAÇÃO - NF-E SEM VALOR FISCAL');
  rllXmotivo.Caption := '';
  LSituacao := '';

  if fpDANFe.Cancelada then
    LSituacao := 'NF-e CANCELADA'
  else
    case fpNFe.procNFe.cStat of
      0:
        if (fpNFe.Ide.tpEmis in [teNormal, teSCAN]) then
        begin
          rllXmotivo.Caption := ACBrStr('NF-E NÃO ENVIADA PARA SEFAZ');
          rllHomologacao.Visible := True;
          rllHomologacao.Caption := ACBrStr('NF-e NÃO PROTOCOLADA NA SEFAZ - SEM VALOR FISCAL');
        end;
      100, 150:
        ;
      101, 135, 151, 155:
        LSituacao := 'NF-e CANCELADA';
      110, 205, 301, 302:
        LSituacao := 'NF-e DENEGADA';
    else
      rllXmotivo.Caption := fpNFe.procNFe.xMotivo;
    end;

  if (LSituacao <> '') then
    rllXmotivo.Caption := LSituacao;

  rllXmotivo.Visible := (rllXmotivo.Caption <> '');
  rlbCanceladaDenegada.Visible := (LSituacao <> '');
  rllCanceladaDenegada.Caption := LSituacao;

  if (fpNFe.Ide.tpEmis = teDPEC) then
  begin
    rlbAvisoContingencia.Visible := EstaVazio(fpNFe.procNFe.nProt);
    rllAvisoContingencia.Caption :=
      ACBrStr('DANFE impresso em contingência - DPEC regularmente recebida pela Receita Federal do Brasil');
  end
  else
  begin
    rlbAvisoContingencia.Visible := (fpNFe.Ide.tpEmis <> teNormal);
    rllAvisoContingencia.Caption :=
      ACBrStr('DANFE em Contingência - Impresso em decorrência de problemas técnicos');
  end;

  rlmContingencia.Lines.Clear;
  if (fpNFe.Ide.dhCont > 0) and NaoEstaVazio(fpNFe.Ide.xJust) then
    rlmContingencia.Lines.Text := ACBrStr('Data / Hora da entrada em contingência: ') +
      FormatDateTimeBr(fpNFe.Ide.dhCont) + ACBrStr(' Motivo contingência: ') + fpNFe.Ide.xJust;

  rlmContingencia.Visible := (rlmContingencia.Lines.Count > 0);
  if rlmContingencia.Visible then
    rlbAvisoContingencia.Height := rlmContingencia.Top + rlmContingencia.Height + 2
  else
    rlbAvisoContingencia.Height := rllAvisoContingencia.Top + rllAvisoContingencia.Height + 1;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirDestinatario;
var
  LEnder: TEnderDest;
begin
  if NaoEstaVazio(fpNFe.Dest.idEstrangeiro) then
    rllDestCNPJ.Caption := fpNFe.Dest.idEstrangeiro
  else
    rllDestCNPJ.Caption := FormatarCNPJouCPF(fpNFe.Dest.CNPJCPF);

  rllDestNome.Caption := fpNFe.Dest.xNome;
  rllDestIE.Caption := fpNFe.Dest.IE;

  LEnder := fpNFe.Dest.EnderDest;
  rllDestEndereco.Caption := LEnder.xLgr + IfThen(LEnder.nro = '0', '', ', ' + LEnder.nro) +
    IfThen(NaoEstaVazio(LEnder.xCpl), ' ' + LEnder.xCpl, '');
  rllDestBairro.Caption := LEnder.xBairro;
  rllDestCEP.Caption := FormatarCEP(LEnder.CEP);
  rllDestMunicipio.Caption := LEnder.xMun;
  rllDestUF.Caption := LEnder.UF;
  rllDestFone.Caption := FormatarFone(LEnder.Fone);

  rllDestEmissao.Caption := FormatDateBr(fpNFe.Ide.dEmi);
  rllDestSaida.Caption := IfThen(fpNFe.Ide.dSaiEnt <> 0, FormatDateBr(fpNFe.Ide.dSaiEnt), '');
  rllDestHoraSaida.Caption := IfThen(TimeOf(fpNFe.Ide.dSaiEnt) = 0, '', TimeToStr(fpNFe.Ide.dSaiEnt));
end;

procedure TfrlDANFeRLRetratoRTC.DefinirRetirada;
var
  LRetirada: TRetirada;
begin
  LRetirada := fpNFe.Retirada;
  rlbRetirada.Visible := NaoEstaVazio(LRetirada.xLgr);

  if not rlbRetirada.Visible then
    Exit;

  rllRetiradaNome.Caption := LRetirada.xNome;
  rllRetiradaCNPJ.Caption := FormatarCNPJouCPF(LRetirada.CNPJCPF);
  rllRetiradaIE.Caption := LRetirada.IE;
  rllRetiradaEndereco.Caption := LRetirada.xLgr + IfThen(LRetirada.nro = '0', '', ', ' + LRetirada.nro) +
    IfThen(EstaVazio(LRetirada.xCpl), '', ' - ' + LRetirada.xCpl);
  rllRetiradaBairro.Caption := LRetirada.xBairro;
  rllRetiradaCEP.Caption := FormatarCEP(LRetirada.CEP);
  rllRetiradaMunicipio.Caption := LRetirada.xMun;
  rllRetiradaFone.Caption := FormatarFone(LRetirada.fone);
  rllRetiradaUF.Caption := LRetirada.UF;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirEntrega;
var
  LEntrega: TEntrega;
begin
  LEntrega := fpNFe.Entrega;
  rlbEntrega.Visible := NaoEstaVazio(LEntrega.xLgr);

  if not rlbEntrega.Visible then
    Exit;

  rllEntregaNome.Caption := LEntrega.xNome;
  rllEntregaCNPJ.Caption := FormatarCNPJouCPF(LEntrega.CNPJCPF);
  rllEntregaIE.Caption := LEntrega.IE;
  rllEntregaEndereco.Caption := LEntrega.xLgr + IfThen(LEntrega.nro = '0', '', ', ' + LEntrega.nro) +
    IfThen(EstaVazio(LEntrega.xCpl), '', ' - ' + LEntrega.xCpl);
  rllEntregaBairro.Caption := LEntrega.xBairro;
  rllEntregaCEP.Caption := FormatarCEP(LEntrega.CEP);
  rllEntregaMunicipio.Caption := LEntrega.xMun;
  rllEntregaFone.Caption := FormatarFone(LEntrega.fone);
  rllEntregaUF.Caption := LEntrega.UF;
end;

function TfrlDANFeRLRetratoRTC.CriarCelula(ABand: TRLBand; ALeft, ATop,
  AWidth: Integer; const ATitulo, AValor: String): TRLPanel;
var
  LTitulo, LValor: TRLLabel;
begin
  Result := TRLPanel.Create(Self);
  Result.Parent := ABand;
  Result.SetBounds(ALeft, ATop, AWidth, cAlturaCelula);
  Result.Borders.Sides := sdAll;

  LTitulo := TRLLabel.Create(Self);
  LTitulo.Parent := Result;
  LTitulo.AutoSize := False;
  LTitulo.SetBounds(2, 1, AWidth - 4, 8);
  LTitulo.ParentFont := False;
  LTitulo.Font.Name := 'Arial';
  LTitulo.Font.Height := -7;
  LTitulo.Font.Color := clGray;
  LTitulo.Caption := ATitulo;

  LValor := TRLLabel.Create(Self);
  LValor.Parent := Result;
  LValor.AutoSize := False;
  LValor.SetBounds(3, 10, AWidth - 6, 13);
  LValor.ParentFont := False;
  LValor.Font.Name := 'Arial';
  LValor.Font.Height := -10;
  LValor.Font.Color := clBlack;
  LValor.Caption := AValor;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirFatura;
const
  cPorLinha = 3;
  cLarguraGrupo = 246;
var
  I, LLeft, LTop: Integer;
  LDup: TDupCollectionItem;
begin
  rlbFatura.Visible := fpRTC.ExibeFatura and fpDANFe.ExibeCampoFatura;

  if not rlbFatura.Visible then
    Exit;

  for I := 0 to (fpNFe.Cobr.Dup.Count - 1) do
  begin
    LDup := fpNFe.Cobr.Dup.Items[I];
    LLeft := (I mod cPorLinha) * cLarguraGrupo;
    LTop := cTopoCelulas + (I div cPorLinha) * (cAlturaCelula - 1);

    CriarCelula(rlbFatura, LLeft, LTop, 98, 'FATURA/DUPLICATA', LDup.nDup);
    CriarCelula(rlbFatura, LLeft + 97, LTop, 70, 'VENCIMENTO', FormatDateBr(LDup.dVenc));
    CriarCelula(rlbFatura, LLeft + 166, LTop, 81, 'VALOR', fpRTC.FormatarValor(LDup.vDup));
  end;

  rlbFatura.Height := cTopoCelulas +
    ((fpNFe.Cobr.Dup.Count + cPorLinha - 1) div cPorLinha) * (cAlturaCelula - 1) + 1;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirTotais;
var
  LNota: TACBrNFeDANFeRTCTotalNota;
  LICMS: TACBrNFeDANFeRTCTotalICMSIPI;
  LIBSCBS: TACBrNFeDANFeRTCTotalIBSCBSIS;
begin
  LNota := fpRTC.TotalNota;
  rllTotProdutos.Caption := fpRTC.FormatarValor(LNota.vProd);
  rllTotFrete.Caption := fpRTC.FormatarValor(LNota.vFrete);
  rllTotSeguro.Caption := fpRTC.FormatarValor(LNota.vSeg);
  rllTotDesconto.Caption := fpRTC.FormatarValor(LNota.vDesc);
  rllTotOutras.Caption := fpRTC.FormatarValor(LNota.vOutro);
  rllTotNota.Caption := fpRTC.FormatarValor(LNota.vNF);

  LICMS := fpRTC.TotalICMSIPI;
  rllBaseICMS.Caption := fpRTC.FormatarValor(LICMS.vBC);
  rllValorICMS.Caption := fpRTC.FormatarValor(LICMS.vICMS);
  rllBaseICMSST.Caption := fpRTC.FormatarValor(LICMS.vBCST);
  rllValorICMSST.Caption := fpRTC.FormatarValor(LICMS.vST);
  rllValorIPI.Caption := fpRTC.FormatarValor(LICMS.vIPI);

  rlbICMSFCPDifal.Visible := LICMS.ExibeFCPDifal;
  rllFCP.Caption := fpRTC.FormatarValor(LICMS.vFCP);
  rllFCPST.Caption := fpRTC.FormatarValor(LICMS.vFCPST);
  rllICMSUFDest.Caption := fpRTC.FormatarValor(LICMS.vICMSUFDest);
  rllFCPUFDest.Caption := fpRTC.FormatarValor(LICMS.vFCPUFDest);

  rlbICMSMonofasico.Visible := LICMS.ExibeMonofasico;
  rllBCICMSMono.Caption := fpRTC.FormatarValor(LICMS.qBCMono);
  rllICMSMono.Caption := fpRTC.FormatarValor(LICMS.vICMSMono);
  rllBCICMSMonoReten.Caption := fpRTC.FormatarValor(LICMS.qBCMonoReten);
  rllICMSMonoReten.Caption := fpRTC.FormatarValor(LICMS.vICMSMonoReten);

  LIBSCBS := fpRTC.TotalIBSCBSIS;
  rllCBS.Caption := fpRTC.FormatarValor(LIBSCBS.vCBS);
  rllIBSUF.Caption := fpRTC.FormatarValor(LIBSCBS.vIBSUF);
  rllIBSMun.Caption := fpRTC.FormatarValor(LIBSCBS.vIBSMun);
  rllIS.Caption := fpRTC.FormatarValor(LIBSCBS.vIS);

  rlbIBSCBSMonofasico.Visible := LIBSCBS.ExibeMonofasico;
  rllIBSMono.Caption := fpRTC.FormatarValor(LIBSCBS.vIBSMono);
  rllCBSMono.Caption := fpRTC.FormatarValor(LIBSCBS.vCBSMono);
  rllIBSMonoReten.Caption := fpRTC.FormatarValor(LIBSCBS.vIBSMonoReten);
  rllCBSMonoReten.Caption := fpRTC.FormatarValor(LIBSCBS.vCBSMonoReten);
end;

procedure TfrlDANFeRLRetratoRTC.DefinirISSQN;
var
  LISSQN: TACBrNFeDANFeRTCISSQN;
begin
  LISSQN := fpRTC.ISSQN;
  rlbISSQN.Visible := LISSQN.Exibe;

  rllISSQNInscricao.Caption := LISSQN.IM;
  rllISSQNServicos.Caption := fpRTC.FormatarValor(LISSQN.vServ);
  rllISSQNBase.Caption := fpRTC.FormatarValor(LISSQN.vBC);
  rllISSQNValor.Caption := fpRTC.FormatarValor(LISSQN.vISS);
end;

procedure TfrlDANFeRLRetratoRTC.DefinirTransporte;
var
  I, LLinhas: Integer;
  LOk: Boolean;
  LVol: TVolCollectionItem;
  LPaineis: array[0..5] of TRLPanel;
  LMemos: array[0..5] of TRLMemo;
begin
  rlbTransportador.Visible := fpRTC.ExibeTransporte;

  if not rlbTransportador.Visible then
    Exit;

  rllTransModFrete.Caption := modFreteToDesStr(fpNFe.Transp.modFrete,
    DblToVersaoDF(LOk, fpNFe.infNFe.Versao));
  rllTransNome.Caption := fpNFe.Transp.Transporta.xNome;
  rllTransCNPJ.Caption := FormatarCNPJouCPF(fpNFe.Transp.Transporta.CNPJCPF);
  rllTransIE.Caption := fpNFe.Transp.Transporta.IE;
  rllTransEndereco.Caption := fpNFe.Transp.Transporta.xEnder;
  rllTransMunicipio.Caption := fpNFe.Transp.Transporta.xMun;
  rllTransUF.Caption := fpNFe.Transp.Transporta.UF;
  rllTransANTT.Caption := fpNFe.Transp.veicTransp.RNTC;
  rllTransPlaca.Caption := fpNFe.Transp.veicTransp.placa;
  rllTransUFPlaca.Caption := fpNFe.Transp.veicTransp.UF;

  LPaineis[0] := rlpVolQtde;
  LPaineis[1] := rlpVolEspecie;
  LPaineis[2] := rlpVolMarca;
  LPaineis[3] := rlpVolNumeracao;
  LPaineis[4] := rlpVolPesoBruto;
  LPaineis[5] := rlpVolPesoLiquido;

  LMemos[0] := rlmVolQtde;
  LMemos[1] := rlmVolEspecie;
  LMemos[2] := rlmVolMarca;
  LMemos[3] := rlmVolNumeracao;
  LMemos[4] := rlmVolPesoBruto;
  LMemos[5] := rlmVolPesoLiquido;

  for I := 0 to 5 do
    LMemos[I].Lines.Clear;

  for I := 0 to (fpNFe.Transp.Vol.Count - 1) do
  begin
    LVol := fpNFe.Transp.Vol.Items[I];
    rlmVolQtde.Lines.Add(IfThen(LVol.qVol > 0, IntToStr(LVol.qVol), ''));
    rlmVolEspecie.Lines.Add(LVol.esp);
    rlmVolMarca.Lines.Add(LVol.marca);
    rlmVolNumeracao.Lines.Add(LVol.nVol);
    rlmVolPesoBruto.Lines.Add(IfThen(LVol.pesoB > 0, FormatFloatBr(LVol.pesoB, FloatMask(3)), ''));
    rlmVolPesoLiquido.Lines.Add(IfThen(LVol.pesoL > 0, FormatFloatBr(LVol.pesoL, FloatMask(3)), ''));
  end;

  LLinhas := Max(1, fpNFe.Transp.Vol.Count);
  for I := 0 to 5 do
  begin
    LMemos[I].Height := LLinhas * cAlturaLinhaVolume;
    LPaineis[I].Height := LMemos[I].Top + LMemos[I].Height + 1;
  end;

  rlbTransportador.Height := rlpVolQtde.Top + rlpVolQtde.Height + 1;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirDadosAdicionais;
var
  LTextoOriginal, LTexto: String;
  LPosUltimoEspaco: Integer;
begin
  rlmDadosAdicionaisAuxiliar.Width := rlmDadosAdicionais.Width;
  rlmDadosAdicionaisAuxiliar.Lines.Text := fpDANFe.ManterInformacoesDadosAdicionais(fpNFe);
  rlmContinuacaoDadosAdicionais.Lines.Clear;

  if (rlmDadosAdicionaisAuxiliar.Height > rlmDadosAdicionais.Height) then
  begin
    LTextoOriginal := rlmDadosAdicionaisAuxiliar.Lines.Text;
    LTexto := LTextoOriginal;
    repeat
      LPosUltimoEspaco := LastDelimiter(' ' + sLineBreak, LTexto);
      if (LPosUltimoEspaco <= 1) then
        Break;

      LTexto := LeftStr(LTextoOriginal, LPosUltimoEspaco - 1);
      rlmDadosAdicionaisAuxiliar.Lines.Text := LTexto;
    until not (rlmDadosAdicionaisAuxiliar.Height > rlmDadosAdicionais.Height);

    if (LPosUltimoEspaco > 1) then
      rlmContinuacaoDadosAdicionais.Lines.Text :=
        Trim(RightStr(LTextoOriginal, Length(LTextoOriginal) - LPosUltimoEspaco));
  end;

  rlmDadosAdicionais.Lines.Text := rlmDadosAdicionaisAuxiliar.Lines.Text;
  rlbContinuacao.Visible := (Trim(rlmContinuacaoDadosAdicionais.Lines.Text) <> '');

  rlmDadosFisco.Lines.Text := fpNFe.procNFe.xMsg;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirQRCode;
begin
  rlpQRCode.Visible := fpRTC.ExibeQRCode;

  if rlpQRCode.Visible then
    PintarQRCode(fpRTC.QRCode, rliQRCode.Picture.Bitmap, qrUTF8NoBOM)
  else
  begin
    rlpFisco.Width := rlpQRCode.Left + rlpQRCode.Width - rlpFisco.Left;
    rlmDadosFisco.Width := rlpFisco.Width - 6;
    rllTitFisco.Width := rlpFisco.Width - 4;
    rllSecDadosAdicionais.Width := rlpQRCode.Left + rlpQRCode.Width;
  end;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirRodape;
begin
  rllSistema.Visible := NaoEstaVazio(fpDANFe.Sistema);
  rllSistema.Caption := fpDANFe.Sistema;

  rllUsuario.Visible := NaoEstaVazio(fpDANFe.Usuario);
  rllUsuario.Caption := ACBrStr('DATA / HORA DA IMPRESSÃO: ') + FormatDateTimeBr(Now) +
    ' - ' + fpDANFe.Usuario;
end;

procedure TfrlDANFeRLRetratoRTC.DefinirTributo(ARotulo, AValor: TRLLabel;
  ALargura: Integer; const ATributo: TACBrNFeDANFeRTCTributo; AAliquota: Boolean);
const
  cAmostra = 10;
var
  LLarguraRotulo, LLarguraPonto, LPontos: Integer;
begin
  if AAliquota then
    AValor.Caption := TACBrNFeDANFeRTC.FormatarAliquota(ATributo.Valor)
  else
    AValor.Caption := TACBrNFeDANFeRTC.FormatarValor(ATributo.Valor);

  ARotulo.Caption := ATributo.Rotulo;
  LLarguraRotulo := ARotulo.Width;
  ARotulo.Caption := ATributo.Rotulo + StringOfChar('.', cAmostra);
  LLarguraPonto := (ARotulo.Width - LLarguraRotulo) div cAmostra;

  LPontos := 0;
  if (LLarguraPonto > 0) then
    LPontos := Max(0, (ALargura - LLarguraRotulo - AValor.Width - 2) div LLarguraPonto);

  ARotulo.Caption := ATributo.Rotulo + StringOfChar('.', LPontos);
  AValor.Left := ARotulo.Left + ALargura - AValor.Width;
end;

end.
