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

unit ACBrNFeABI.Classes;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.RTC.Classes,
  ACBrDFe.Conversao,
  ACBrDFeComum.Proc,
  ACBrNFeABI.Conversao;

type

  TinfNFeABI = class(TObject)
  private
    FId: string;
    FVersao: Double;

  public
    property Id: string read FId write FId;
    property versao: Double read FVersao write FVersao;
  end;

  TgModNat = class(TObject)
  private
    FmodOper: Integer;
    FnatOper: Integer;
    FdetOper: Integer;
  public
    property modOper: Integer read FmodOper write FmodOper;
    property natOper: Integer read FnatOper write FnatOper;
    property detOper: Integer read FdetOper write FdetOper;
  end;

  TgCont = class(TObject)
  private
    FdhCont: TDateTime;
    FxJust: string;
  public
    property dhCont: TDateTime read FdhCont write FdhCont;
    property xJust: string read FxJust write FxJust;
  end;

  TIde = class(TObject)
  private
    FcUF: Integer;
    FcNF: Integer;
    Fmodelo: Integer;
    Fserie: Integer;
    FnNF: Integer;
    FdhEmi: TDateTime;
    FtpNF: TtpNF;
    FtpImp: TtpImp;
    FgModNat: TgModNat;
    FtpEmis: TACBrTipoEmissao;
    FnSiteAutoriz: TSiteAutorizador;
    FcDV: Integer;
    FtpAmb: TACBrTipoAmbiente;
    FfinNFe: TfinNFe;
    FprocEmi: TACBrProcessoEmissao;
    FverProc: string;
    FgCont: TgCont;
  public
    constructor Create;
    destructor Destroy; override;

    property cUF: Integer read FcUF write FcUF;
    property cNF: Integer read FcNF write FcNF;
    property modelo: Integer read Fmodelo write Fmodelo;
    property serie: Integer read Fserie write Fserie;
    property nNF: Integer read FnNF write FnNF;
    property dhEmi: TDateTime read FdhEmi write FdhEmi;
    property tpNF: TtpNF read FtpNF write FtpNF;
    property tpImp: TtpImp read FtpImp write FtpImp;
    property gModNat: TgModNat read FgModNat write FgModNat;
    property tpEmis: TACBrTipoEmissao read FtpEmis write FtpEmis;
    property nSiteAutoriz: TSiteAutorizador read FnSiteAutoriz write FnSiteAutoriz;
    property cDV: Integer read FcDV write FcDV;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property finNFe: TfinNFe read FfinNFe write FfinNFe;
    property procEmi: TACBrProcessoEmissao read FprocEmi write FprocEmi;
    property verProc: string read FverProc write FverProc;
    property gCont: TgCont read FgCont write FgCont;
  end;

  TNFrefCollectionItem = class(TObject)
  private
    FrefNFeABI: string;
  public
    property refNFeABI: string read FrefNFeABI write FrefNFeABI;
  end;

  TNFrefCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TNFrefCollectionItem;
    procedure SetItem(Index: Integer; Value: TNFrefCollectionItem);
  public
    function Add: TNFrefCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TNFrefCollectionItem;
    property Items[Index: Integer]: TNFrefCollectionItem read GetItem write SetItem; default;
  end;

  Tendereco = class(TObject)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: Integer;
    FxMun: string;
    FUF: string;
    FCEP: string;
    FcPais: Integer;
    FxPais: string;
    Ffone: string;
    Femail: string;
  public
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: Integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;
    property cPais: Integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
    property fone: string read Ffone write Ffone;
    property email: string read Femail write Femail;
  end;

  Temit = class(TObject)
  private
    FCNPJCPF: string;
    FxNome: string;
    FxFant: string;
    FenderEmit: Tendereco;
    FtpEmit: TtpEmit;
  public
    constructor Create;
    destructor Destroy; override;

    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property xFant: string read FxFant write FxFant;
    property enderEmit: Tendereco read FenderEmit write FenderEmit;
    property tpEmit: TtpEmit read FtpEmit write FtpEmit;
  end;

  TtransmitCollectionItem = class(TObject)
  private
    FindDeclarante: TIndicadorEx;
    FCNPJCPF: string;
    FxNome: string;
    FenderTransmit: Tendereco;
    FpTransIndiv: Double;
    FindContrib: TindContrib;
  public
    constructor Create;
    destructor Destroy; override;

    property indDeclarante: TIndicadorEx read FindDeclarante write FindDeclarante default tieNenhum;
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property enderTransmit: Tendereco read FenderTransmit write FenderTransmit;
    property pTransIndiv: Double read FpTransIndiv write FpTransIndiv;
    property indContrib: TindContrib read FindContrib write FindContrib;
  end;

  TtransmitCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TtransmitCollectionItem;
    procedure SetItem(Index: Integer; Value: TtransmitCollectionItem);
  public
    function Add: TtransmitCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TtransmitCollectionItem;
    property Items[Index: Integer]: TtransmitCollectionItem read GetItem write SetItem; default;
  end;

  TadquirenteCollectionItem = class(TObject)
  private
    FindDeclarante: TIndicadorEx;
    FCNPJCPF: string;
    FxNome: string;
    FenderAdquirente: Tendereco;
    FpAquisicao: Double;
    FindContrib: TindContrib;
  public
    constructor Create;
    destructor Destroy; override;

    property indDeclarante: TIndicadorEx read FindDeclarante write FindDeclarante default tieNenhum;
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property enderAdquirente: Tendereco read FenderAdquirente write FenderAdquirente;
    property pAquisicao: Double read FpAquisicao write FpAquisicao;
    property indContrib: TindContrib read FindContrib write FindContrib;
  end;

  TadquirenteCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TadquirenteCollectionItem;
    procedure SetItem(Index: Integer; Value: TadquirenteCollectionItem);
  public
    function Add: TadquirenteCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TadquirenteCollectionItem;
    property Items[Index: Integer]: TadquirenteCollectionItem read GetItem write SetItem; default;
  end;

  { Tcadastro }

  Tcadastro = class(TObject)
  private
    FcCIB: string;
    FindIPTU: TIndicador;
    FnIptu: string;
    FindIncra: TIndicador;
    FnIncra: string;
  public
    property cCIB: string read FcCIB write FcCIB;
    property indIPTU: TIndicador read FindIPTU write FindIPTU;
    property nIptu: string read FnIptu write FnIptu;
    property indIncra: TIndicador read FindIncra write FindIncra;
    property nIncra: string read FnIncra write FnIncra;
  end;

  { Timovel }

  Timovel = class(TObject)
  private
    Ftipo: Ttipo;
    Fcadastro: Tcadastro;
    FespImovel: string;
    FxOutrosEspecies: string;
    Fenquadramento: string;
    FenderImovel: Tendereco;
    FobsLocalImovel: string;
    FareaTotal: Double;
    FuareaTotal: TuareaTotal;
    FcartorioRegistro: string;
    FmatricTransc: string;
  public
    constructor Create;
    destructor Destroy; override;

    property tipo: Ttipo read Ftipo write Ftipo;
    property cadastro: Tcadastro read Fcadastro write Fcadastro;
    property espImovel: string read FespImovel write FespImovel;
    property xOutrosEspecies: string read FxOutrosEspecies write FxOutrosEspecies;
    property enquadramento: string read Fenquadramento write Fenquadramento;
    property enderImovel: Tendereco read FenderImovel write FenderImovel;
    property obsLocalImovel: string read FobsLocalImovel write FobsLocalImovel;
    property areaTotal: Double read FareaTotal write FareaTotal;
    property uareaTotal: TuareaTotal read FuareaTotal write FuareaTotal;
    property cartorioRegistro: string read FcartorioRegistro write FcartorioRegistro;
    property matricTransc: string read FmatricTransc write FmatricTransc;
  end;

  TautXMLCollectionItem = class(TObject)
  private
    FCNPJCPF: string;
  public
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
  end;

  TautXMLCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TautXMLCollectionItem;
    procedure SetItem(Index: Integer; Value: TautXMLCollectionItem);
  public
    function Add: TautXMLCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TautXMLCollectionItem;
    property Items[Index: Integer]: TautXMLCollectionItem read GetItem write SetItem; default;
  end;

  TimovelTornaCollectionItem = class(TObject)
  private
    Fimovel: Timovel;
  public
    constructor Create;
    destructor Destroy; override;

    property imovel: Timovel read Fimovel write Fimovel;
  end;

  TimovelTornaCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TimovelTornaCollectionItem;
    procedure SetItem(Index: Integer; Value: TimovelTornaCollectionItem);
  public
    function Add: TimovelTornaCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TimovelTornaCollectionItem;
    property Items[Index: Integer]: TimovelTornaCollectionItem read GetItem write SetItem; default;
  end;

  { TgTorna }

  TgTorna = class(TObject)
  private
    FvTorna: Double;
    FimovelTorna: TimovelTornaCollection;

    procedure SetimovelTorna(const Value: TimovelTornaCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property vTorna: Double read FvTorna write FvTorna;
    property imovelTorna: TimovelTornaCollection read FimovelTorna write SetimovelTorna;
  end;

  { TgIncorpLote }

  TgIncorpLote = class(TObject)
  private
    FindIncorpLote: TIndicador;
    FCNPJempImob: string;
    FcCIBObra: string;
  public
    property indIncorpLote: TIndicador read FindIncorpLote write FindIncorpLote;
    property CNPJempImob: string read FCNPJempImob write FCNPJempImob;
    property cCIBObra: string read FcCIBObra write FcCIBObra;
  end;

  { TgRedAjusteImovel }

  TgRedAjusteImovel = class(TObject)
  private
    FvInicial: Double;
    FvITBI: Double;
    FvLaudemio: Double;
    FvContrap: Double;
    FvRedAjusteImovel: Double;
  public
    property vInicial: Double read FvInicial write FvInicial;
    property vITBI: Double read FvITBI write FvITBI;
    property vLaudemio: Double read FvLaudemio write FvLaudemio;
    property vContrap: Double read FvContrap write FvContrap;
    property vRedAjusteImovel: Double read FvRedAjusteImovel write FvRedAjusteImovel;
  end;

  { Tinstrumento }

  Tinstrumento = class(TObject)
  private
    FtpInstrumento: Integer;
    FxOutrosInst: string;
    FdtInstrumento: TDateTime;
  public
    property tpInstrumento: Integer read FtpInstrumento write FtpInstrumento;
    property xOutrosInst: string read FxOutrosInst write FxOutrosInst;
    property dtInstrumento: TDateTime read FdtInstrumento write FdtInstrumento;
  end;

  TgIntermedCorretCollectionItem = class(TObject)
  private
    FCNPJCPF: string;
    FxNome: string;
    FvCorretagem: Double;
  public
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property vCorretagem: Double read FvCorretagem write FvCorretagem;
  end;

  TgIntermedCorretCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgIntermedCorretCollectionItem;
    procedure SetItem(Index: Integer; Value: TgIntermedCorretCollectionItem);
  public
    function Add: TgIntermedCorretCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TgIntermedCorretCollectionItem;
    property Items[Index: Integer]: TgIntermedCorretCollectionItem read GetItem write SetItem; default;
  end;

  { TinfOper }

  TinfOper = class(TObject)
  private
    FpTransImovel: Double;
    FvTotalOperacao: Double;
    FindTorna: TIndicador;
    FgTorna: TgTorna;
    FgIncorpLote: TgIncorpLote;
    FgRedAjusteImovel: TgRedAjusteImovel;
    FindRedSocial: TIndicador;
    FvRedSocial: Double;
    Finstrumento: Tinstrumento;
    FindIntermedCorret: TIndicador;
    FgIntermedCorret: TgIntermedCorretCollection;

    procedure SetgIntermedCorret(const Value: TgIntermedCorretCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property pTransImovel: Double read FpTransImovel write FpTransImovel;
    property vTotalOperacao: Double read FvTotalOperacao write FvTotalOperacao;
    property indTorna: TIndicador read FindTorna write FindTorna;
    property gTorna: TgTorna read FgTorna write FgTorna;
    property gIncorpLote: TgIncorpLote read FgIncorpLote write FgIncorpLote;
    property gRedAjusteImovel: TgRedAjusteImovel read FgRedAjusteImovel write FgRedAjusteImovel;
    property indRedSocial: TIndicador read FindRedSocial write FindRedSocial;
    property vRedSocial: Double read FvRedSocial write FvRedSocial;
    property instrumento: Tinstrumento read Finstrumento write Finstrumento;
    property indIntermedCorret: TIndicador read FindIntermedCorret write FindIntermedCorret;
    property gIntermedCorret: TgIntermedCorretCollection read FgIntermedCorret write SetgIntermedCorret;
  end;

  { TgInfTrib }

  TgInfTrib = class(TObject)
  private
    FgCompraGov: TgCompraGovReduzido;
    FIBSCBS: TIBSCBS;
  public
    constructor Create;
    destructor Destroy; override;

    property gCompraGov: TgCompraGovReduzido read FgCompraGov write FgCompraGov;
    property IBSCBS: TIBSCBS read FIBSCBS write FIBSCBS;
  end;

  TdetPagImovelCollectionItem = class(TObject)
  private
    FtPag: Integer;
    FxPag: string;
    FvPag: Double;
  public
    property tPag: Integer read FtPag write FtPag;
    property xPag: string read FxPag write FxPag;
    property vPag: Double read FvPag write FvPag;
  end;

  TdetPagImovelCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetPagImovelCollectionItem;
    procedure SetItem(Index: Integer; Value: TdetPagImovelCollectionItem);
  public
    function Add: TdetPagImovelCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TdetPagImovelCollectionItem;
    property Items[Index: Integer]: TdetPagImovelCollectionItem read GetItem write SetItem; default;
  end;

  TdetPagIncorpLoteCollectionItem = class(TObject)
  private
    FtParcela: string;
    FnParcela: Integer;
    FxParcela: string;
  public
    property tParcela: string read FtParcela write FtParcela;
    property nParcela: Integer read FnParcela write FnParcela;
    property xParcela: string read FxParcela write FxParcela;
  end;

  TdetPagIncorpLoteCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetPagIncorpLoteCollectionItem;
    procedure SetItem(Index: Integer; Value: TdetPagIncorpLoteCollectionItem);
  public
    function Add: TdetPagIncorpLoteCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TdetPagIncorpLoteCollectionItem;
    property Items[Index: Integer]: TdetPagIncorpLoteCollectionItem read GetItem write SetItem; default;
  end;

  { Tpag }

  Tpag = class(TObject)
  private
    FdetPagImovel: TdetPagImovelCollection;
    FdetPagIncorpLote: TdetPagIncorpLoteCollection;

    procedure SetdetPagImovel(const Value: TdetPagImovelCollection);
    procedure SetdetPagIncorpLote(const Value: TdetPagIncorpLoteCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property detPagImovel: TdetPagImovelCollection read FdetPagImovel write SetdetPagImovel;
    property detPagIncorpLote: TdetPagIncorpLoteCollection read FdetPagIncorpLote write SetdetPagIncorpLote;
  end;

  Ttotal = class(TObject)
  private
    FvTotalOperacao: Double;
    FvOperacIndiv: Double;
    FvRedAjusteIndiv: Double;
    FvRedSocialIndiv: Double;
    FvBC: Double;
    FvIBSUF: Double;
    FvIBSMun: Double;
    FvCBS: Double;
    FvNF: Double;
  public
    property vTotalOperacao: Double read FvTotalOperacao write FvTotalOperacao;
    property vOperacIndiv: Double read FvOperacIndiv write FvOperacIndiv;
    property vRedAjusteIndiv: Double read FvRedAjusteIndiv write FvRedAjusteIndiv;
    property vRedSocialIndiv: Double read FvRedSocialIndiv write FvRedSocialIndiv;
    property vBC: Double read FvBC write FvBC;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property vCBS: Double read FvCBS write FvCBS;
    property vNF: Double read FvNF write FvNF;
  end;

  TobservacoesCollectionItem = class(TObject)
  private
    FxCampo: string;
    FxTexto: string;
  public
    property xCampo: string read FxCampo write FxCampo;
    property xTexto: string read FxTexto write FxTexto;
  end;

  TobsContCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TobservacoesCollectionItem;
    procedure SetItem(Index: Integer; Value: TobservacoesCollectionItem);
  public
    function Add: TobservacoesCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TobservacoesCollectionItem;
    property Items[Index: Integer]: TobservacoesCollectionItem read GetItem write SetItem; default;
  end;

  TobsFiscoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TobservacoesCollectionItem;
    procedure SetItem(Index: Integer; Value: TobservacoesCollectionItem);
  public
    function Add: TobservacoesCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TobservacoesCollectionItem;
    property Items[Index: Integer]: TobservacoesCollectionItem read GetItem write SetItem; default;
  end;

  TinfAdic = class(TObject)
  private
    FinfAdFisco: string;
    FinfCpl: string;
    FobsCont: TobsContCollection;
    FobsFisco: TobsFiscoCollection;

    procedure SetobsCont(const Value: TobsContCollection);
    procedure SetobsFisco(const Value: TobsFiscoCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property infAdFisco: string read FinfAdFisco write FinfAdFisco;
    property infCpl: string read FinfCpl write FinfCpl;
    property obsCont: TobsContCollection read FobsCont write SetobsCont;
    property obsFisco: TobsFiscoCollection read FobsFisco write SetobsFisco;
  end;

  { TinfRespTec }

  TinfRespTec = class(TObject)
  private
    FCNPJ: string;
    FxContato: string;
    Femail: string;
    Ffone: string;
    FidCSRT: Integer;
    FhashCSRT: string;
  public
    property CNPJ: string     read FCNPJ     write FCNPJ;
    property xContato: string read FxContato write FxContato;
    property email: string    read Femail    write Femail;
    property fone: string     read Ffone     write Ffone;
    property idCSRT: Integer  read FidCSRT   write FidCSRT;
    property hashCSRT: string read FhashCSRT write FhashCSRT;
  end;

  TinfNFeSupl = class(TObject)
  private
    FqrCode: string;
    FurlChave: string;
  public
    property qrCode: string read FqrCode write FqrCode;
    property urlChave: string read FurlChave write FurlChave;
  end;

  TNFeABI = class(TObject)
  private
    FinfNFeABI: TinfNFeABI;
    FIde: TIde;
    FNFref: TNFrefCollection;
    Femit: Temit;
    Ftransmit: TtransmitCollection;
    Fadquirente: TadquirenteCollection;
    Fimovel: Timovel;
    FautXML: TautXMLCollection;
    FinfOper: TinfOper;
    FgInfTrib: TgInfTrib;
    Fpag: Tpag;
    Ftotal: Ttotal;
    FinfAdic: TinfAdic;
    FinfRespTec: TinfRespTec;
    FinfNFeSupl: TinfNFeSupl;
    FProcNFeABI: TProcDFe;
    FSignature: TSignature;

    procedure Settransmit(const Value: TtransmitCollection);
    procedure Setadquirente(const Value: TadquirenteCollection);
    procedure SetautXML(const Value: TautXMLCollection);
    procedure SetNFref(const Value: TNFrefCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property infNFeABI: TinfNFeABI  read FinfNFeABI write FinfNFeABI;
    property Ide: TIde read FIde write FIde;
    property NFref: TNFrefCollection read FNFref write SetNFref;

    property emit: Temit read Femit write Femit;
    property transmit: TtransmitCollection read Ftransmit write Settransmit;
    property adquirente: TadquirenteCollection read Fadquirente write Setadquirente;
    property imovel: Timovel read Fimovel write Fimovel;
    property autXML: TautXMLCollection read FautXML write SetautXML;
    property infOper: TinfOper read FinfOper write FinfOper;
    property gInfTrib: TgInfTrib read FgInfTrib write FgInfTrib;
    property pag: Tpag read Fpag write Fpag;
    property total: Ttotal read Ftotal write Ftotal;
    property infAdic: TinfAdic read FinfAdic write FinfAdic;
    property infRespTec: TinfRespTec read FinfRespTec write FinfRespTec;
    property infNFeSupl: TinfNFeSupl read FinfNFeSupl write FinfNFeSupl;
    property procNFeABI: TProcDFe read FProcNFeABI write FProcNFeABI;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

implementation

uses
  ACBrUtil.Base;

{ TNFeABI }

constructor TNFeABI.Create;
begin
  inherited Create;

  FinfNFeABI := TInfNFeABI.Create;
  Fide := Tide.Create;
  FNFref := TNFrefCollection.Create;
  Femit := Temit.Create;
  Ftransmit := TtransmitCollection.Create;
  Fadquirente := TadquirenteCollection.Create;
  Fimovel := Timovel.Create;
  FautXML := TautXMLCollection.Create;
  FinfOper := TinfOper.Create;
  FgInfTrib := TgInfTrib.Create;
  Fpag := Tpag.Create;
  Ftotal := Ttotal.Create;
  FinfAdic := TinfAdic.Create;
  FinfRespTec := TinfRespTec.Create;
  FinfNFeSupl := TinfNFeSupl.Create;
  FProcNFeABI := TProcDFe.Create('', '', '', '');
  Fsignature := Tsignature.create;
end;

destructor TNFeABI.Destroy;
begin
  FinfNFeABI.Free;
  Fide.Free;
  FNFref.Free;
  Femit.Free;
  Ftransmit.Free;
  Fadquirente.Free;
  Fimovel.Free;
  FautXML.Free;
  FinfOper.Free;
  FgInfTrib.Free;
  Fpag.Free;
  Ftotal.Free;
  FinfAdic.Free;
  FinfRespTec.Free;
  FinfNFeSupl.Free;
  FProcNFeABI.Free;
  Fsignature.Free;

  inherited;
end;
procedure TNFeABI.Setadquirente(const Value: TadquirenteCollection);
begin
  Fadquirente := Value;
end;

procedure TNFeABI.SetautXML(const Value: TautXMLCollection);
begin
  FautXML := Value;
end;

procedure TNFeABI.SetNFref(const Value: TNFrefCollection);
begin
  FNFref := Value;
end;

procedure TNFeABI.Settransmit(const Value: TtransmitCollection);
begin
  Ftransmit := Value;
end;

{ TIde }

constructor TIde.Create;
begin
  inherited Create;

  FgModNat := TgModNat.Create;
  FgCont := TgCont.Create;
end;

destructor TIde.Destroy;
begin
  FgModNat.Free;
  FgCont.Free;

  inherited;
end;

{ Temit }

constructor Temit.Create;
begin
  inherited Create;

  FenderEmit := Tendereco.Create;
end;

destructor Temit.Destroy;
begin
  FenderEmit.Free;

  inherited;
end;

{ TtransmitCollection }

function TtransmitCollection.Add: TtransmitCollectionItem;
begin
  Result := Self.New;
end;

function TtransmitCollection.GetItem(Index: Integer): TtransmitCollectionItem;
begin
  Result := TtransmitCollectionItem(inherited Items[Index]);
end;

procedure TtransmitCollection.SetItem(Index: Integer; Value: TtransmitCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TtransmitCollection.New: TtransmitCollectionItem;
begin
  Result := TtransmitCollectionItem.Create;
  Self.Add(Result);
end;

{ TtransmitCollectionItem }

constructor TtransmitCollectionItem.Create;
begin
  inherited Create;

  FenderTransmit := Tendereco.Create;
end;

destructor TtransmitCollectionItem.Destroy;
begin
  FenderTransmit.Free;

  inherited;
end;

{ TadiquirenteCollection }

function TadquirenteCollection.Add: TadquirenteCollectionItem;
begin
  Result := Self.New;
end;

function TadquirenteCollection.GetItem(Index: Integer): TadquirenteCollectionItem;
begin
  Result := TadquirenteCollectionItem(inherited Items[Index]);
end;

procedure TadquirenteCollection.SetItem(Index: Integer; Value: TadquirenteCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TadquirenteCollection.New: TadquirenteCollectionItem;
begin
  Result := TadquirenteCollectionItem.Create;
  Self.Add(Result);
end;

{ TadquirenteCollectionItem }

constructor TadquirenteCollectionItem.Create;
begin
  inherited Create;

  FenderAdquirente := Tendereco.Create;
end;

destructor TadquirenteCollectionItem.Destroy;
begin
  FenderAdquirente.Free;

  inherited;
end;

{ Timovel }

constructor Timovel.Create;
begin
  inherited Create;

  Fcadastro := Tcadastro.Create;
  FenderImovel := Tendereco.Create;
end;

destructor Timovel.Destroy;
begin
  Fcadastro.Free;
  FenderImovel.Free;

  inherited;
end;

{ TautXMLCollection }

function TautXMLCollection.Add: TautXMLCollectionItem;
begin
  Result := Self.New;
end;

function TautXMLCollection.GetItem(Index: Integer): TautXMLCollectionItem;
begin
  Result := TautXMLCollectionItem(inherited Items[Index]);
end;

procedure TautXMLCollection.SetItem(Index: Integer;
  Value: TautXMLCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TautXMLCollection.New: TautXMLCollectionItem;
begin
  Result := TautXMLCollectionItem.Create;
  Self.Add(Result);
end;

{ TinfOper }

constructor TinfOper.Create;
begin
  inherited Create;

  FgTorna := TgTorna.Create;
  FgIncorpLote := TgIncorpLote.Create;
  FgRedAjusteImovel := TgRedAjusteImovel.Create;
  Finstrumento := Tinstrumento.Create;
  FgIntermedCorret := TgIntermedCorretCollection.Create;
end;

destructor TinfOper.Destroy;
begin
  FgTorna.Free;
  FgIncorpLote.Free;
  FgRedAjusteImovel.Free;
  Finstrumento.Free;
  FgIntermedCorret.Free;

  inherited;
end;

procedure TinfOper.SetgIntermedCorret(const Value: TgIntermedCorretCollection);
begin
  FgIntermedCorret := Value;
end;

{ TgTorna }

constructor TgTorna.Create;
begin
  inherited Create;

  FimovelTorna := TimovelTornaCollection.Create;
end;

destructor TgTorna.Destroy;
begin
  FimovelTorna.Free;

  inherited;
end;

procedure TgTorna.SetimovelTorna(const Value: TimovelTornaCollection);
begin
  FimovelTorna := Value;
end;

{ TimovelTornaCollection }

function TimovelTornaCollection.Add: TimovelTornaCollectionItem;
begin
  Result := Self.New;
end;

function TimovelTornaCollection.GetItem(
  Index: Integer): TimovelTornaCollectionItem;
begin
  Result := TimovelTornaCollectionItem(inherited Items[Index]);
end;

function TimovelTornaCollection.New: TimovelTornaCollectionItem;
begin
  Result := TimovelTornaCollectionItem.Create;
  Self.Add(Result);
end;

procedure TimovelTornaCollection.SetItem(Index: Integer;
  Value: TimovelTornaCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TimovelTornaCollectionItem }

constructor TimovelTornaCollectionItem.Create;
begin
  inherited Create;

  Fimovel := Timovel.Create;
end;

destructor TimovelTornaCollectionItem.Destroy;
begin
  Fimovel.Free;

  inherited;
end;

{ TgIntermedCorretCollection }

function TgIntermedCorretCollection.Add: TgIntermedCorretCollectionItem;
begin
  Result := Self.New;
end;

function TgIntermedCorretCollection.GetItem(
  Index: Integer): TgIntermedCorretCollectionItem;
begin
  Result := TgIntermedCorretCollectionItem(inherited Items[Index]);
end;

function TgIntermedCorretCollection.New: TgIntermedCorretCollectionItem;
begin
  Result := TgIntermedCorretCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgIntermedCorretCollection.SetItem(Index: Integer;
  Value: TgIntermedCorretCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgInfTrib }

constructor TgInfTrib.Create;
begin
  inherited Create;

  FgCompraGov := TgCompraGovReduzido.Create;
  FIBSCBS := TIBSCBS.Create;
end;

destructor TgInfTrib.Destroy;
begin
  FgCompraGov.Free;
  FIBSCBS.Free;

  inherited;
end;

{ Tpag }

constructor Tpag.Create;
begin
  inherited Create;

  FdetPagImovel := TdetPagImovelCollection.Create;
  FdetPagIncorpLote := TdetPagIncorpLoteCollection.Create;
end;

destructor Tpag.Destroy;
begin
  FdetPagImovel.Free;
  FdetPagIncorpLote.Free;

  inherited;
end;

procedure Tpag.SetdetPagImovel(const Value: TdetPagImovelCollection);
begin
  FdetPagImovel := Value;
end;

procedure Tpag.SetdetPagIncorpLote(const Value: TdetPagIncorpLoteCollection);
begin
  FdetPagIncorpLote := Value;
end;

{ TdetPagImovelCollection }

function TdetPagImovelCollection.Add: TdetPagImovelCollectionItem;
begin
  Result := Self.New;
end;

function TdetPagImovelCollection.GetItem(
  Index: Integer): TdetPagImovelCollectionItem;
begin
  Result := TdetPagImovelCollectionItem(inherited Items[Index]);
end;

function TdetPagImovelCollection.New: TdetPagImovelCollectionItem;
begin
  Result := TdetPagImovelCollectionItem.Create;
  Self.Add(Result);
end;

procedure TdetPagImovelCollection.SetItem(Index: Integer;
  Value: TdetPagImovelCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TdetPagIncorpLoteCollection }

function TdetPagIncorpLoteCollection.Add: TdetPagIncorpLoteCollectionItem;
begin
  Result := Self.New;
end;

function TdetPagIncorpLoteCollection.GetItem(
  Index: Integer): TdetPagIncorpLoteCollectionItem;
begin
  Result := TdetPagIncorpLoteCollectionItem(inherited Items[Index]);
end;

function TdetPagIncorpLoteCollection.New: TdetPagIncorpLoteCollectionItem;
begin
  Result := TdetPagIncorpLoteCollectionItem.Create;
  Self.Add(Result);
end;

procedure TdetPagIncorpLoteCollection.SetItem(Index: Integer;
  Value: TdetPagIncorpLoteCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TinfAdic }

constructor TinfAdic.Create;
begin
  inherited Create;

  FobsCont := TobsContCollection.Create;
  FobsFisco := TobsFiscoCollection.Create;
end;

destructor TinfAdic.Destroy;
begin
  FobsCont.Free;
  FobsFisco.Free;

  inherited;
end;

procedure TinfAdic.SetobsCont(const Value: TobsContCollection);
begin
  FobsCont := Value;
end;

procedure TinfAdic.SetobsFisco(const Value: TobsFiscoCollection);
begin
  FobsFisco := Value;
end;

{ TobsContCollection }

function TobsContCollection.Add: TobservacoesCollectionItem;
begin
  Result := Self.New;
end;

function TobsContCollection.GetItem(Index: Integer): TobservacoesCollectionItem;
begin
  Result := TobservacoesCollectionItem(inherited Items[Index]);
end;

function TobsContCollection.New: TobservacoesCollectionItem;
begin
  Result := TobservacoesCollectionItem.Create;
  Self.Add(Result);
end;

procedure TobsContCollection.SetItem(Index: Integer;
  Value: TobservacoesCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TobsFiscoCollection }

function TobsFiscoCollection.Add: TobservacoesCollectionItem;
begin
  Result := Self.New;
end;

function TobsFiscoCollection.GetItem(
  Index: Integer): TobservacoesCollectionItem;
begin
  Result := TobservacoesCollectionItem(inherited Items[Index]);
end;

function TobsFiscoCollection.New: TobservacoesCollectionItem;
begin
  Result := TobservacoesCollectionItem.Create;
  Self.Add(Result);
end;

procedure TobsFiscoCollection.SetItem(Index: Integer;
  Value: TobservacoesCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TNFrefCollection }

function TNFrefCollection.Add: TNFrefCollectionItem;
begin
  Result := Self.New;
end;

function TNFrefCollection.GetItem(Index: Integer): TNFrefCollectionItem;
begin
  Result := TNFrefCollectionItem(inherited Items[Index]);
end;

function TNFrefCollection.New: TNFrefCollectionItem;
begin
  Result := TNFrefCollectionItem.Create;
  Self.Add(Result);
end;

procedure TNFrefCollection.SetItem(Index: Integer; Value: TNFrefCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.

