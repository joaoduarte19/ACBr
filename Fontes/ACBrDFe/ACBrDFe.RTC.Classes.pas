{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFe.RTC.Classes;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao;

type

  { TgPagAntecipadoCollectionItem }

  TgPagAntecipadoCollectionItem = class(TObject)
  private
    FrefNFe: string;
  public
    procedure Assign(Source: TgPagAntecipadoCollectionItem);

    property refNFe: string read FrefNFe write FrefNFe;
  end;

  { TgPagAntecipadoCollection }

  TgPagAntecipadoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgPagAntecipadoCollectionItem;
    procedure SetItem(Index: Integer; Value: TgPagAntecipadoCollectionItem);
  public
    procedure Assign(Source: TgPagAntecipadoCollection); reintroduce;
    function Add: TgPagAntecipadoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TgPagAntecipadoCollectionItem;
    property Items[Index: Integer]: TgPagAntecipadoCollectionItem read GetItem write SetItem; default;
  end;

  { TrefDFeCollectionItem }

  TrefDFeCollectionItem = class(TObject)
  private
    FrefDFeAnt: string;
  public
    procedure Assign(Source: TrefDFeCollectionItem);

    property refDFeAnt: string read FrefDFeAnt write FrefDFeAnt;
  end;

  { TrefDFeCollection }

  TrefDFeCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TrefDFeCollectionItem;
    procedure SetItem(Index: Integer; Value: TrefDFeCollectionItem);
  public
    function New: TrefDFeCollectionItem;
    property Items[Index: Integer]: TrefDFeCollectionItem read GetItem write SetItem; default;
  end;

  { TDFeReferenciado }

  TDFeReferenciado = class(TObject)
  private
    FchaveAcesso: string;
    FnItem: Integer;
  public
    procedure Assign(Source: TDFeReferenciado);
    property chaveAcesso: string read FchaveAcesso write FchaveAcesso;
    property nItem: Integer read FnItem write FnItem;
  end;

  { TgCompraGovReduzido }
  {Usado por: BPe, CTe, NF3e, NFAg, NFCom, NFGas}

  TgCompraGovReduzido = class(TObject)
  private
    FtpEnteGov: TtpEnteGov;
    FpRedutor: Double;
    FtpOperGov: TtpOperGov;
    FrefDFe: TrefDFeCollection;

    procedure SetrefDFe(const Value: TrefDFeCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCompraGovReduzido);

    property tpEnteGov: TtpEnteGov read FtpEnteGov write FtpEnteGov;
    property pRedutor: Double read FpRedutor write FpRedutor;
    property tpOperGov: TtpOperGov read FtpOperGov write FtpOperGov;
    property refDFe: TrefDFeCollection read FrefDFe write SetrefDFe;
  end;

  { TgCompraGov }
  {Usado por: NFe}

  TgCompraGov = class(TObject)
  private
    FtpEnteGov: TtpEnteGov;
    FpRedutor: Double;
    FtpOperGov: TtpOperGov;
  public
    procedure Assign(Source: TgCompraGov);

    property tpEnteGov: TtpEnteGov read FtpEnteGov write FtpEnteGov;
    property pRedutor: Double read FpRedutor write FpRedutor;
    property tpOperGov: TtpOperGov read FtpOperGov write FtpOperGov;
  end;

  { TgALCZFMCBS }

  TgALCZFMCBS = class(TObject)
  private
    FnProcSuframa: String;
    FpAliqEfetRegCBS: Double;
    FtpALCZFMCBS: TtpALCZFMCBS;
    FvTribRegCBS: Double;
  public
    property tpALCZFMCBS: TtpALCZFMCBS read FtpALCZFMCBS write FtpALCZFMCBS;
    property nProcSuframa: String read FnProcSuframa write FnProcSuframa;
    property pAliqEfetRegCBS: Double read FpAliqEfetRegCBS write FpAliqEfetRegCBS;
    property vTribRegCBS: Double read FvTribRegCBS write FvTribRegCBS;
  end;

  { TgDif }

  TgDif = class(TObject)
  private
    FpDif: Double;
    FvDif: Double;
  public
    property pDif: Double read FpDif write FpDif;
    property vDif: Double read FvDif write FvDif;
  end;

  { TgDevTrib }

  TgDevTrib = class(TObject)
  private
    FvDevTrib: Double;
    FpDevTrib: Double;
  public
    property pDevTrib: Double read FpDevTrib write FpDevTrib;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
  end;

  { TgRed }

  TgRed = class(TObject)
  private
    FpRedAliq: Double;
    FpAliqEfet: Double;
  public
    property pRedAliq: Double read FpRedAliq write FpRedAliq;
    property pAliqEfet: Double read FpAliqEfet write FpAliqEfet;
  end;

  { TgIBSUFValores }

  TgIBSUFValores = class(TObject)
  private
    FpIBS: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvIBS: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property pIBS: Double read FpIBS write FpIBS;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vIBS: Double read FvIBS write FvIBS;
  end;

  { TgIBSMunValores }

  TgIBSMunValores = class(TObject)
  private
    FpIBS: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvIBS: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property pIBS: Double read FpIBS write FpIBS;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vIBS: Double read FvIBS write FvIBS;
  end;

  { TgCBSValores }

  TgCBSValores = class(TObject)
  private
    FpCBS: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvCBS: Double;
    FgALCZFMCBS: TgALCZFMCBS;
  public
    constructor Create;
    destructor Destroy; override;

    property pCBS: Double read FpCBS write FpCBS;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vCBS: Double read FvCBS write FvCBS;
    property gALCZFMCBS: TgALCZFMCBS read FgALCZFMCBS write FgALCZFMCBS;
  end;

  { TgTribRegular }

  TgTribRegular = class(TObject)
  private
    FCSTReg: TCSTIBSCBS;
    FcClassTribReg: string;
    FpAliqEfetRegIBSUF: Double;
    FvTribRegIBSUF: Double;
    FpAliqEfetRegIBSMun: Double;
    FvTribRegIBSMun: Double;
    FpAliqEfetRegCBS: Double;
    FvTribRegCBS: Double;
  public
    property CSTReg: TCSTIBSCBS read FCSTReg write FCSTReg;
    property cClassTribReg: string read FcClassTribReg write FcClassTribReg;
    property pAliqEfetRegIBSUF: Double read FpAliqEfetRegIBSUF write FpAliqEfetRegIBSUF;
    property vTribRegIBSUF: Double read FvTribRegIBSUF write FvTribRegIBSUF;
    property pAliqEfetRegIBSMun: Double read FpAliqEfetRegIBSMun write FpAliqEfetRegIBSMun;
    property vTribRegIBSMun: Double read FvTribRegIBSMun write FvTribRegIBSMun;
    property pAliqEfetRegCBS: Double read FpAliqEfetRegCBS write FpAliqEfetRegCBS;
    property vTribRegCBS: Double read FvTribRegCBS write FvTribRegCBS;
  end;

  { TgTribCompraGov }

  TgTribCompraGov = class(TObject)
  private
    FpAliqIBSUF: Double;
    FvTribIBSUF: Double;
    FpAliqIBSMun: Double;
    FvTribIBSMun: Double;
    FpAliqCBS: Double;
    FvTribCBS: Double;
  public
    property pAliqIBSUF: Double read FpAliqIBSUF write FpAliqIBSUF;
    property vTribIBSUF: Double read FvTribIBSUF write FvTribIBSUF;
    property pAliqIBSMun: Double read FpAliqIBSMun write FpAliqIBSMun;
    property vTribIBSMun: Double read FvTribIBSMun write FvTribIBSMun;
    property pAliqCBS: Double read FpAliqCBS write FpAliqCBS;
    property vTribCBS: Double read FvTribCBS write FvTribCBS;
  end;

  { TgIBSCBS }

  TgIBSCBS = class(TObject)
  private
    FvBC: Double;
    FvIBS: Double;
    FgIBSUF: TgIBSUFValores;
    FgIBSMun: TgIBSMunValores;
    FgCBS: TgCBSValores;
    FgTribRegular: TgTribRegular;
    FgTribCompraGov: TgTribCompraGov;
  public
    constructor Create;
    destructor Destroy; override;

    property vBC: Double read FvBC write FvBC;
    property vIBS: Double read FvIBS write FvIBS;
    property gIBSUF: TgIBSUFValores read FgIBSUF write FgIBSUF;
    property gIBSMun: TgIBSMunValores read FgIBSMun write FgIBSMun;
    property gCBS: TgCBSValores read FgCBS write FgCBS;
    property gTribRegular: TgTribRegular read FgTribRegular write FgTribRegular;
    property gTribCompraGov: TgTribCompraGov read FgTribCompraGov write FgTribCompraGov;
  end;

  { TgMonoPadrao }

  TgMonoPadrao = class(TObject)
  private
    FqBCMono: Double;
    FadRemIBS: Double;
    FadRemCBS: Double;
    FvIBSMono: Double;
    FvCBSMono: Double;
  public
    procedure Assign(Source: TgMonoPadrao);

    property qBCMono: Double read FqBCMono write FqBCMono;
    property adRemIBS: Double read FadRemIBS write FadRemIBS;
    property adRemCBS: Double read FadRemCBS write FadRemCBS;
    property vIBSMono: Double read FvIBSMono write FvIBSMono;
    property vCBSMono: Double read FvCBSMono write FvCBSMono;
  end;

  { TgMonoReten }

  TgMonoReten = class(TObject)
  private
    FqBCMonoReten: Double;
    FadRemIBSReten: Double;
    FvIBSMonoReten: Double;
    FadRemCBSReten: Double;
    FvCBSMonoReten: Double;
  public
    procedure Assign(Source: TgMonoReten);

    property qBCMonoReten: Double read FqBCMonoReten write FqBCMonoReten;
    property adRemIBSReten: Double read FadRemIBSReten write FadRemIBSReten;
    property vIBSMonoReten: Double read FvIBSMonoReten write FvIBSMonoReten;
    property adRemCBSReten: Double read FadRemCBSReten write FadRemCBSReten;
    property vCBSMonoReten: Double read FvCBSMonoReten write FvCBSMonoReten;
  end;

  { TgMonoRet }

  TgMonoRet = class(TObject)
  private
    FqBCMonoRet: Double;
    FadRemIBSRet: Double;
    FvIBSMonoRet: Double;
    FadRemCBSRet: Double;
    FvCBSMonoRet: Double;
  public
    procedure Assign(Source: TgMonoRet);

    property qBCMonoRet: Double read FqBCMonoRet write FqBCMonoRet;
    property adRemIBSRet: Double read FadRemIBSRet write FadRemIBSRet;
    property vIBSMonoRet: Double read FvIBSMonoRet write FvIBSMonoRet;
    property adRemCBSRet: Double read FadRemCBSRet write FadRemCBSRet;
    property vCBSMonoRet: Double read FvCBSMonoRet write FvCBSMonoRet;
  end;

  { TgMonoDif }

  TgMonoDif = class(TObject)
  private
    FpDifIBS: Double;
    FvIBSMonoDif: Double;
    FpDifCBS: Double;
    FvCBSMonoDif: Double;
  public
    procedure Assign(Source: TgMonoDif);

    property pDifIBS: Double read FpDifIBS write FpDifIBS;
    property vIBSMonoDif: Double read FvIBSMonoDif write FvIBSMonoDif;
    property pDifCBS: Double read FpDifCBS write FpDifCBS;
    property vCBSMonoDif: Double read FvCBSMonoDif write FvCBSMonoDif;
  end;

  { TgIBSCBSMono }

  TgIBSCBSMono = class(TObject)
  private
    FgMonoPadrao: TgMonoPadrao;
    FgMonoReten: TgMonoReten;
    FgMonoRet: TgMonoRet;
    FgMonoDif: TgMonoDif;

    FvTotIBSMonoItem: Double;
    FvTotCBSMonoItem: Double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgIBSCBSMono);

    property gMonoPadrao: TgMonoPadrao read FgMonoPadrao write FgMonoPadrao;
    property gMonoReten: TgMonoReten read FgMonoReten write FgMonoReten;
    property gMonoRet: TgMonoRet read FgMonoRet write FgMonoRet;
    property gMonoDif: TgMonoDif read FgMonoDif write FgMonoDif;

    property vTotIBSMonoItem: Double read FvTotIBSMonoItem write FvTotIBSMonoItem;
    property vTotCBSMonoItem: Double read FvTotCBSMonoItem write FvTotCBSMonoItem;
  end;

  { TgTransfCred }

  TgTransfCred = class(TObject)
  private
    FvCBS: Double;
    FvIBS: Double;
  public
    procedure Assign(Source: TgTransfCred);

    property vIBS: Double read FvIBS write FvIBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TgAjusteCompet }

  TgAjusteCompet = class(TObject)
  private
    FcompetApur: TDateTime;
    FvCBS: Double;
    FvIBS: Double;
  public
    procedure Assign(Source: TgAjusteCompet);

    property competApur: TDateTime read FcompetApur write FcompetApur;
    property vIBS: Double read FvIBS write FvIBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TgEstornoCred }

  TgEstornoCred = class(TObject)
  private
    FvIBSEstCred: Double;
    FvCBSEstCred: Double;
  public
    property vIBSEstCred: Double read FvIBSEstCred write FvIBSEstCred;
    property vCBSEstCred: Double read FvCBSEstCred write FvCBSEstCred;
  end;

  { TgIBSCBSCredPres }

  TgIBSCBSCredPres = class(TObject)
  private
    FpCredPres: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    procedure Assign(Source: TgIBSCBSCredPres);

    property pCredPres: Double read FpCredPres write FpCredPres;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgCredPresOper }

  TgCredPresOper = class(TObject)
  private
    FvBCCredPres: Double;
    FcCredPres: TcCredPres;
    FgIBSCredPres: TgIBSCBSCredPres;
    FgCBSCredPres: TgIBSCBSCredPres;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCredPresOper);

    property vBCCredPres: Double read FvBCCredPres write FvBCCredPres;
    property cCredPres: TcCredPres read FcCredPres write FcCredPres;
    property gIBSCredPres: TgIBSCBSCredPres read FgIBSCredPres write FgIBSCredPres;
    property gCBSCredPres: TgIBSCBSCredPres read FgCBSCredPres write FgCBSCredPres;
  end;

  { TCredPresIBSZFM }

  TCredPresIBSZFM = class(TObject)
  private
    FcompetApur: TDateTime;
    FtpCredPresIBSZFM: TTpCredPresIBSZFM;
    FvCredPresIBSZFM: Double;
  public
    procedure Assign(Source: TCredPresIBSZFM);

    property competApur: TDateTime read FcompetApur write FcompetApur;
    property tpCredPresIBSZFM: TTpCredPresIBSZFM read FtpCredPresIBSZFM write FtpCredPresIBSZFM;
    property vCredPresIBSZFM: Double read FvCredPresIBSZFM write FvCredPresIBSZFM;
  end;

  { TIBSCBS }

  TIBSCBS = class(TObject)
  private
    FCST: TCSTIBSCBS;
    FcClassTrib: string;
    FindDoacao: TIndicadorEx;
    FgIBSCBS: TgIBSCBS;
    FgIBSCBSMono: TgIBSCBSMono;
    FgTransfCred: TgTransfCred;
    FgAjusteCompet: TgAjusteCompet;
    FgEstornoCred: TgEstornoCred;
    FgCredPresOper: TgCredPresOper;
    FgCredPresIBSZFM: TCredPresIBSZFM;
  public
    constructor Create;
    destructor Destroy; override;

    property CST: TCSTIBSCBS read FCST write FCST;
    property cClassTrib: string read FcClassTrib write FcClassTrib;
    property indDoacao: TIndicadorEx read FindDoacao write FindDoacao;

    property gIBSCBS: TgIBSCBS read FgIBSCBS write FgIBSCBS;
    property gIBSCBSMono: TgIBSCBSMono read FgIBSCBSMono write FgIBSCBSMono;
    property gTransfCred: TgTransfCred read FgTransfCred write FgTransfCred;
    property gAjusteCompet: TgAjusteCompet read FgAjusteCompet write FgAjusteCompet;
    property gEstornoCred: TgEstornoCred read FgEstornoCred write FgEstornoCred;
    property gCredPresOper: TgCredPresOper read FgCredPresOper write FgCredPresOper;
    property gCredPresIBSZFM: TCredPresIBSZFM read FgCredPresIBSZFM write FgCredPresIBSZFM;
  end;

  { TgIS }

  TgIS = class(TObject)
  private
    //Usar string até a publicação de uma tabela de CSTs oficial para o IS
    //FCSTIS: TCSTIS;
    FCSTIS: string;
    FcClassTribIS: string;
    FvBCIS: Double;
    FpIS: Double;
    FpISEspec: Double;
    FuTrib: string;
    FqTrib: Double;
    FvIS: Double;
  public
    procedure Assign(Source: TgIS);
    //Usar string até a publicação de uma tabela de CSTs oficial para o IS
    //property CSTIS: TCSTIS read FCSTIS write FCSTIS;
    property CSTIS: string read FCSTIS write FCSTIS;
    property cClassTribIS: string read FcClassTribIS write FcClassTribIS;
    property vBCIS: Double read FvBCIS write FvBCIS;
    property pIS: Double read FpIS write FpIS;
    property pISEspec: Double read FpISEspec write FpISEspec;
    property uTrib: string read FuTrib write FuTrib;
    property qTrib: Double read FqTrib write FqTrib;
    property vIS: Double read FvIS write FvIS;
  end;

  { TISTot }

  TISTot = class(TObject)
  private
    FvIS: Double;
  public
    procedure Assign(Source: TISTot);

    property vIS: Double read FvIS write FvIS;
  end;

  { TgIBSUFTot }

  TgIBSUFTot = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvIBSUF: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
  end;

  { TgIBSMunTot }

  TgIBSMunTot = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvIBSMun: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
  end;

  { TgIBS }

  TgIBS = class(TObject)
  private
    FgIBSUFTot: TgIBSUFTot;
    FgIBSMunTot: TgIBSMunTot;
    FvIBS: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property gIBSUFTot: TgIBSUFTot read FgIBSUFTot write FgIBSUFTot;
    property gIBSMunTot: TgIBSMunTot read FgIBSMunTot write FgIBSMunTot;
    property vIBS: Double read FvIBS write FvIBS;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgCBS }

  TgCBS = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvCBS: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vCBS: Double read FvCBS write FvCBS;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgMono }

  TgMono = class(TObject)
  private
    FvIBSMono: Double;
    FvCBSMono: Double;
    FvIBSMonoReten: Double;
    FvCBSMonoReten: Double;
    FvIBSMonoRet: Double;
    FvCBSMonoRet: Double;
  public
    procedure Assign(Source: TgMono);
    property vIBSMono: Double read FvIBSMono write FvIBSMono;
    property vCBSMono: Double read FvCBSMono write FvCBSMono;
    property vIBSMonoReten: Double read FvIBSMonoReten write FvIBSMonoReten;
    property vCBSMonoReten: Double read FvCBSMonoReten write FvCBSMonoReten;
    property vIBSMonoRet: Double read FvIBSMonoRet write FvIBSMonoRet;
    property vCBSMonoRet: Double read FvCBSMonoRet write FvCBSMonoRet;
  end;

  { TIBSCBSTot }

  TIBSCBSTot = class(TObject)
  private
    FvBCIBSCBS: Double;
    FgIBS: TgIBS;
    FgCBS: TgCBS;
    FgEstornoCred: TgEstornoCred;
    FgMono: TgMono;
  public
    constructor Create;
    destructor Destroy; override;

    property vBCIBSCBS: Double read FvBCIBSCBS write FvBCIBSCBS;
    property gIBS: TgIBS read FgIBS write FgIBS;
    property gCBS: TgCBS read FgCBS write FgCBS;
    property gMono: TgMono read FgMono write FgMono;
    property gEstornoCred: TgEstornoCred read FgEstornoCred write FgEstornoCred;
  end;

  { TpgtoCollectionItem }

  TpgtoCollectionItem = class(TObject)
  private
    FtpMeioPgto: string;
    FCNPJReceb: string;
    FCNPJBasePSP: string;
    FnPag: Integer;
    FidTransacao: string;
  public
    procedure Assign(Source: TpgtoCollectionItem);

    property tpMeioPgto: string read FtpMeioPgto write FtpMeioPgto;
    property CNPJReceb: string read FCNPJReceb write FCNPJReceb;
    property CNPJBasePSP: string read FCNPJBasePSP write FCNPJBasePSP;
    property nPag: Integer read FnPag write FnPag;
    property idTransacao: string read FidTransacao write FidTransacao;
  end;

  TpgtoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TpgtoCollectionItem;
    procedure SetItem(Index: Integer; Value: TpgtoCollectionItem);
  public
    function Add: TpgtoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TpgtoCollectionItem;
    property Items[Index: Integer]: TpgtoCollectionItem read GetItem write SetItem; default;
  end;

  { TpgtoVinc }

  TpgtoVinc = class(TObject)
  private
    Fpgto: TpgtoCollection;

    procedure Setpgto(const Value: TpgtoCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TpgtoVinc);

    property pgto: TpgtoCollection read Fpgto write Setpgto;
  end;

implementation

{ TgPagAntecipadoCollectionItem }

procedure TgPagAntecipadoCollectionItem.Assign(
  Source: TgPagAntecipadoCollectionItem);
begin
  refNFe := Source.refNFe;
end;

{ TgPagAntecipadoCollection }

function TgPagAntecipadoCollection.Add: TgPagAntecipadoCollectionItem;
begin
  Result := Self.New;
end;

procedure TgPagAntecipadoCollection.Assign(Source: TgPagAntecipadoCollection);
var
  I: Integer;
begin
  Self.Clear;
  for I := 0 to Source.Count - 1 do
    Self.New.Assign(Source.Items[I]);
end;

function TgPagAntecipadoCollection.GetItem(
  Index: Integer): TgPagAntecipadoCollectionItem;
begin
  Result := TgPagAntecipadoCollectionItem(inherited Items[Index]);
end;

function TgPagAntecipadoCollection.New: TgPagAntecipadoCollectionItem;
begin
  Result := TgPagAntecipadoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgPagAntecipadoCollection.SetItem(Index: Integer;
  Value: TgPagAntecipadoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgCompraGovReduzido }

procedure TgCompraGovReduzido.Assign(Source: TgCompraGovReduzido);
begin
  tpEnteGov := Source.tpEnteGov;
  pRedutor := Source.pRedutor;
  tpOperGov := Source.tpOperGov;
  refDFe.Assign(Source.refDFe);
end;

constructor TgCompraGovReduzido.Create;
begin
  inherited Create;

  FrefDFe := TrefDFeCollection.Create;
end;

destructor TgCompraGovReduzido.Destroy;
begin
  FrefDFe.Free;

  inherited;
end;

procedure TgCompraGovReduzido.SetrefDFe(const Value: TrefDFeCollection);
begin
  FrefDFe := Value;
end;

{ TrefDFeCollection }

function TrefDFeCollection.GetItem(Index: Integer): TrefDFeCollectionItem;
begin
  Result := TrefDFeCollectionItem(inherited Items[Index]);
end;

function TrefDFeCollection.New: TrefDFeCollectionItem;
begin
  Result := TrefDFeCollectionItem.Create;
  Self.Add(Result);
end;

procedure TrefDFeCollection.SetItem(Index: Integer;
  Value: TrefDFeCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TrefDFeCollectionItem }

procedure TrefDFeCollectionItem.Assign(Source: TrefDFeCollectionItem);
begin
  refDFeAnt := Source.refDFeAnt;
end;

{ TIBSCBS }

constructor TIBSCBS.Create;
begin
  inherited Create;

  FgIBSCBS := TgIBSCBS.Create;
  FgEstornoCred := TgEstornoCred.Create;
  FgCredPresOper := TgCredPresOper.Create;
  FgCredPresIBSZFM := TCredPresIBSZFM.Create;
end;

destructor TIBSCBS.Destroy;
begin
  FgIBSCBS.Free;
  FgEstornoCred.Free;
  FgCredPresOper.Free;
  FgCredPresIBSZFM.Free;

  inherited Destroy;
end;

{ TgIBSCBS }

constructor TgIBSCBS.Create;
begin
  inherited Create;

  FgIBSUF := TgIBSUFValores.Create;
  FgIBSMun := TgIBSMunValores.Create;
  FgCBS := TgCBSValores.Create;
  FgTribRegular := TgTribRegular.Create;
  FgTribCompraGov := TgTribCompraGov.Create;
end;

destructor TgIBSCBS.Destroy;
begin
  FgIBSUF.Free;
  FgIBSMun.Free;
  FgCBS.Free;
  FgTribRegular.Free;
  FgTribCompraGov.Free;

  inherited Destroy;
end;

{ TgIBSUFValores }

constructor TgIBSUFValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
end;

destructor TgIBSUFValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;

  inherited Destroy;
end;

{ TgIBSMunValores }

constructor TgIBSMunValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
end;

destructor TgIBSMunValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;

  inherited Destroy;
end;

{ TgCBSValores }

constructor TgCBSValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
  FgALCZFMCBS := TgALCZFMCBS.Create;
end;

destructor TgCBSValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;
  FgALCZFMCBS.Free;

  inherited Destroy;
end;

{ TIBSCBSTot }

constructor TIBSCBSTot.Create;
begin
  inherited Create;

  FgIBS := TgIBS.Create;
  FgCBS := TgCBS.Create;
  FgMono := TgMono.Create;
  FgEstornoCred := TgEstornoCred.Create;
end;

destructor TIBSCBSTot.Destroy;
begin
  FgIBS.Free;
  FgCBS.Free;
  FgMono.Free;
  FgEstornoCred.Free;

  inherited Destroy;
end;

{ TgIBS }

constructor TgIBS.Create;
begin
  inherited Create;

  FgIBSUFTot := TgIBSUFTot.Create;
  FgIBSMunTot := TgIBSMunTot.Create;
end;

destructor TgIBS.Destroy;
begin
  FgIBSUFTot.Free;
  FgIBSMunTot.Free;

  inherited Destroy;
end;

{ TpgtoVinc }

procedure TpgtoVinc.Assign(Source: TpgtoVinc);
begin
  pgto.Assign(Source.pgto);
end;

constructor TpgtoVinc.Create;
begin
  inherited Create;

  Fpgto := TpgtoCollection.Create;
end;

destructor TpgtoVinc.Destroy;
begin
  Fpgto.Free;

  inherited;
end;

procedure TpgtoVinc.Setpgto(const Value: TpgtoCollection);
begin
  Fpgto := Value;
end;

{ TpgtoCollection }

function TpgtoCollection.Add: TpgtoCollectionItem;
begin
  Result := Self.New;
end;

function TpgtoCollection.GetItem(Index: Integer): TpgtoCollectionItem;
begin
  Result := TpgtoCollectionItem(inherited Items[Index]);
end;

function TpgtoCollection.New: TpgtoCollectionItem;
begin
  Result := TpgtoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TpgtoCollection.SetItem(Index: Integer; Value: TpgtoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TpgtoCollectionItem }

procedure TpgtoCollectionItem.Assign(Source: TpgtoCollectionItem);
begin
  tpMeioPgto := Source.tpMeioPgto;
  CNPJReceb := Source.CNPJReceb;
  CNPJBasePSP := Source.CNPJBasePSP;
  nPag := Source.nPag;
  idTransacao := Source.idTransacao;
end;

{ TgCompraGov }

procedure TgCompraGov.Assign(Source: TgCompraGov);
begin
  tpEnteGov := Source.tpEnteGov;
  pRedutor := Source.pRedutor;
  tpOperGov := Source.tpOperGov;
end;

{ TgIS }

procedure TgIS.Assign(Source: TgIS);
begin
  CSTIS := Source.CSTIS;
  cClassTribIS := Source.cClassTribIS;
  vBCIS := Source.vBCIS;
  pIS := Source.pIS;
  pISEspec := Source.pISEspec;
  uTrib := Source.uTrib;
  qTrib := Source.qTrib;
  vIS := Source.vIS;
end;

{ TgMonoPadrao }

procedure TgMonoPadrao.Assign(Source: TgMonoPadrao);
begin
  qBCMono := Source.qBCMono;
  adRemIBS := Source.adRemIBS;
  adRemCBS := Source.adRemCBS;
  vIBSMono := Source.vIBSMono;
  vCBSMono := Source.vCBSMono;
end;

{ TgMonoReten }

procedure TgMonoReten.Assign(Source: TgMonoReten);
begin
  qBCMonoReten := Source.qBCMonoReten;
  adRemIBSReten := Source.adRemIBSReten;
  vIBSMonoReten := Source.vIBSMonoReten;
  adRemCBSReten := Source.adRemCBSReten;
  vCBSMonoReten := Source.vCBSMonoReten;
end;

{ TgMonoRet }

procedure TgMonoRet.Assign(Source: TgMonoRet);
begin
  qBCMonoRet := Source.qBCMonoRet;
  adRemIBSRet := Source.adRemIBSRet;
  vIBSMonoRet := Source.vIBSMonoRet;
  adRemCBSRet := Source.adRemCBSRet;
  vCBSMonoRet := Source.vCBSMonoRet;
end;

{ TgMonoDif }

procedure TgMonoDif.Assign(Source: TgMonoDif);
begin
  pDifIBS := Source.pDifIBS;
  vIBSMonoDif := Source.vIBSMonoDif;
  pDifCBS := Source.pDifCBS;
  vCBSMonoDif := Source.vCBSMonoDif;
end;

{ TgIBSCBSMono }

procedure TgIBSCBSMono.Assign(Source: TgIBSCBSMono);
begin
  gMonoPadrao.Assign(Source.gMonoPadrao);
  gMonoReten.Assign(Source.gMonoReten);
  gMonoRet.Assign(Source.gMonoRet);
  gMonoDif.Assign(Source.gMonoDif);

  vTotIBSMonoItem := Source.vTotIBSMonoItem;
  vTotCBSMonoItem := Source.vTotCBSMonoItem;
end;

constructor TgIBSCBSMono.Create;
begin
  inherited Create;

  FgMonoPadrao := TgMonoPadrao.Create;
  FgMonoReten := TgMonoReten.Create;
  FgMonoRet := TgMonoRet.Create;
  FgMonoDif := TgMonoDif.Create;
end;

destructor TgIBSCBSMono.Destroy;
begin
  FgMonoPadrao.Free;
  FgMonoReten.Free;
  FgMonoRet.Free;
  FgMonoDif.Free;

  inherited;
end;

{ TgTransfCred }

procedure TgTransfCred.Assign(Source: TgTransfCred);
begin
  vIBS := Source.vIBS;
  vCBS := Source.vCBS;
end;

{ TgAjusteCompet }

procedure TgAjusteCompet.Assign(Source: TgAjusteCompet);
begin
  FcompetApur := Source.competApur;
  FvCBS := Source.vCBS;
  FvIBS := Source.vIBS;
end;

{ TgIBSCBSCredPres }

procedure TgIBSCBSCredPres.Assign(Source: TgIBSCBSCredPres);
begin
  FpCredPres := Source.pCredPres;
  FvCredPres := Source.vCredPres;
  FvCredPresCondSus := Source.vCredPresCondSus;
end;

{ TgCredPresOper }

procedure TgCredPresOper.Assign(Source: TgCredPresOper);
begin
  FvBCCredPres := Source.vBCCredPres;
  FcCredPres := Source.cCredPres;
  gIBSCredPres.Assign(Source.gIBSCredPres);
  gCBSCredPres.Assign(Source.gCBSCredPres);
end;

constructor TgCredPresOper.Create;
begin
  inherited Create;

  FgIBSCredPres := TgIBSCBSCredPres.Create;
  FgCBSCredPres := TgIBSCBSCredPres.Create;
end;

destructor TgCredPresOper.Destroy;
begin
  FgIBSCredPres.Free;
  FgCBSCredPres.Free;

  inherited;
end;

{ TISTot }

procedure TISTot.Assign(Source: TISTot);
begin
  vIS := Source.vIS;
end;

{ TgMono }

procedure TgMono.Assign(Source: TgMono);
begin
  FvIBSMono := Source.vIBSMono;
  FvCBSMono := Source.vCBSMono;
  FvIBSMonoReten := Source.vIBSMonoReten;
  FvCBSMonoReten := Source.vCBSMonoReten;
  FvIBSMonoRet := Source.vIBSMonoRet;
  FvCBSMonoRet := Source.vCBSMonoRet;
end;

{ TCredPresIBSZFM }

procedure TCredPresIBSZFM.Assign(Source: TCredPresIBSZFM);
begin
  FcompetApur := Source.competApur;
  FtpCredPresIBSZFM := Source.tpCredPresIBSZFM;
  FvCredPresIBSZFM := Source.vCredPresIBSZFM;
end;

{ TDFeReferenciado }

procedure TDFeReferenciado.Assign(Source: TDFeReferenciado);
begin
  FchaveAcesso := Source.chaveAcesso;
  FnItem := Source.nItem;
end;

end.
