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

unit ACBrNFeABI.DANFEABIClass;

interface

uses
  SysUtils, Classes,
  ACBrBase,
  ACBrDFeReport,
  ACBrNFeABI.Classes,
  ACBrNFeABI.Conversao;

type
  TDadosExtrasNFeABI = (deValorTotal, deRelacaoDFe);
  TConjuntoDadosExtrasNFeABI = Set of TDadosExtrasNFeABI;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFeABIDANFEABIClass = class(TACBrDFeReport)
   private
    procedure SetACBrNFeABI(const Value: TComponent);
    procedure ErroAbstract(const NomeProcedure: String);

  protected
    FACBrNFeABI: TComponent;
    FImprimirHoraSaida: Boolean;
    FImprimirHoraSaida_Hora: String;
    FTipoDANFEABI: TtpImp;
    FProtocoloNFeABI: String;
    FNFeABICancelada: Boolean;
    FNFeABIEncerrado: Boolean;
    FImprimeDadosExtras: TConjuntoDadosExtrasNFeABI;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetSeparadorPathPDF(const aInitialPath: String): String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFEABI(ANFeABI: TNFeABI = nil); virtual;
    procedure ImprimirDANFEABIPDF(ANFeABI: TNFeABI = nil); overload; virtual;
    procedure ImprimirDANFEABIPDF(AStream: TStream; ANFeABI: TNFeABI = nil); overload; virtual;
    procedure ImprimirEVENTO(ANFeABI: TNFeABI = nil); virtual;
    procedure ImprimirEVENTOPDF(ANFeABI: TNFeABI = nil); overload; virtual;
    procedure ImprimirEVENTOPDF(AStream: TStream; ANFeABI: TNFeABI = nil); overload; virtual;
  published
    property ACBrNFeABI: TComponent            read FACBrNFeABI                write SetACBrNFeABI;
    property ImprimeHoraSaida: Boolean      read FImprimirHoraSaida      write FImprimirHoraSaida;
    property ImprimeHoraSaida_Hora: String  read FImprimirHoraSaida_Hora write FImprimirHoraSaida_Hora;
    property TipoDANFEABI: TtpImp   read FTipoDANFEABI               write FTipoDANFEABI;
    property Protocolo: String              read FProtocoloNFeABI           write FProtocoloNFeABI;
    property Cancelada: Boolean             read FNFeABICancelada           write FNFeABICancelada;
    property Encerrado: Boolean             read FNFeABIEncerrado           write FNFeABIEncerrado;

    property ImprimeDadosExtras: TConjuntoDadosExtrasNFeABI read FImprimeDadosExtras write FImprimeDadosExtras;
  end;

implementation

uses
  ACBrNFeABI;

constructor TACBrNFeABIDANFEABIClass.Create(AOwner: TComponent);
begin
  inherited create(AOwner);

  FACBrNFeABI := nil;
  FImprimirHoraSaida := False;
  FImprimirHoraSaida_Hora := '';
  FProtocoloNFeABI := '';
  FNFeABICancelada := False;
  FNFeABIEncerrado := False;
  FImprimeDadosExtras := [deValorTotal, deRelacaoDFe];
end;

destructor TACBrNFeABIDANFEABIClass.Destroy;
begin

  inherited Destroy;
end;

procedure TACBrNFeABIDANFEABIClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FACBrNFeABI <> nil) and (AComponent is TACBrNFeABI) then
     FACBrNFeABI := nil;
end;

procedure TACBrNFeABIDANFEABIClass.SetACBrNFeABI(const Value: TComponent);
var
  OldValue: TACBrNFeABI;
begin
  if Value <> FACBrNFeABI then
  begin
    if Value <> nil then
      if not (Value is TACBrNFeABI) then
        raise Exception.Create('DANFEABI deve ser do tipo TACBrNFeABI');

    if Assigned(FACBrNFeABI) then
      FACBrNFeABI.RemoveFreeNotification(Self);

    OldValue := TACBrNFeABI(FACBrNFeABI); // Usa outra variavel para evitar Loop Infinito
    FACBrNFeABI := Value;                 // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.DANFEABI) then
        OldValue.DANFEABI := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      TACBrNFeABI(Value).DANFEABI := self;
    end;
  end;
end;

procedure TACBrNFeABIDANFEABIClass.ErroAbstract(const NomeProcedure: String);
begin
  raise Exception.Create(NomeProcedure);
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirDANFEABI(ANFeABI: TNFeABI = nil);
begin
  ErroAbstract('ImprimirDANFEABI');
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirDANFEABIPDF(ANFeABI: TNFeABI = nil);
begin
  ErroAbstract('ImprimirDANFEABIPDF');
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirDANFEABIPDF(AStream: TStream; ANFeABI: TNFeABI);
begin
  ErroAbstract('ImprimirDANFEABIPDF');
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirEVENTO(ANFeABI: TNFeABI);
begin
  ErroAbstract('ImprimirEVENTO');
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirEVENTOPDF(ANFeABI: TNFeABI);
begin
  ErroAbstract('ImprimirEVENTOPDF');
end;

procedure TACBrNFeABIDANFEABIClass.ImprimirEVENTOPDF(AStream: TStream; ANFeABI: TNFeABI);
begin
  ErroAbstract('ImprimirEVENTOPDF');
end;

function TACBrNFeABIDANFEABIClass.GetSeparadorPathPDF(const aInitialPath: String): String;
var
  dhEmissao: TDateTime;
  DescricaoModelo: String;
  ANFeABI: TNFeABI;
begin
  Result := aInitialPath;

  if Assigned(ACBrNFeABI) then  // Se tem o componente ACBrNFeABI
  begin
    if TACBrNFeABI(ACBrNFeABI).NotasFiscais.Count > 0 then  // Se tem alguma Declaração carregada
    begin
     ANFeABI := TACBrNFeABI(ACBrNFeABI).NotasFiscais.Items[0].NFeABI;

     if TACBrNFeABI(ACBrNFeABI).Configuracoes.Arquivos.EmissaoPathNFeABI then
       dhEmissao := ANFeABI.Ide.dhEmi
     else
       dhEmissao := Now;

     DescricaoModelo := 'NFeABI';

     Result := TACBrNFeABI(FACBrNFeABI).Configuracoes.Arquivos.GetPath(
                       Result,
                       DescricaoModelo,
                       ANFeABI.Emit.CNPJCPF,
                       '',
                       dhEmissao,
                       DescricaoModelo);
    end;
  end;
end;

end.
