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

unit ACBrNFGasDANFGasClass;

interface

uses
  SysUtils, Classes,
  ACBrBase,
  ACBrNFGas.Classes,
  ACBrDFe.Conversao,
  ACBrDFeReport;

type

  { TACBrNFGasDANFGasClass }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFGasDANFGasClass = class( TACBrDFeReport )
  private
    procedure SetACBrNFGas(const Value: TComponent);
    procedure ErroAbstract(const NomeProcedure: String);

  protected
   function GetSeparadorPathPDF(const aInitialPath: String): String; override;

  protected
    FACBrNFGas: TComponent;
    FTipoDANFGas: TACBrTipoImpressao;
    FProtocolo: String;
    FCancelada: Boolean;
    FViaConsumidor: Boolean;
    FImprimeNomeFantasia: Boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFGas(NFGas: TNFGas = nil); virtual;
    procedure ImprimirDANFGasCancelado(NFGas: TNFGas = nil); virtual;
    procedure ImprimirDANFGasResumido(NFGas: TNFGas = nil); virtual;
    procedure ImprimirDANFGasPDF(NFGas: TNFGas = nil); virtual;
    procedure ImprimirDANFGasResumidoPDF(NFGas: TNFGas = nil); virtual;
    procedure ImprimirEVENTO(NFGas: TNFGas = nil); virtual;
    procedure ImprimirEVENTOPDF(NFGas: TNFGas = nil); virtual;

    function CaractereQuebraDeLinha: String;

  published
    property ACBrNFGas: TComponent          read FACBrNFGas            write SetACBrNFGas;
    property TipoDANFGas: TACBrTipoImpressao read FTipoDANFGas          write FTipoDANFGas;
    property Protocolo: String             read FProtocolo           write FProtocolo;
    property Cancelada: Boolean            read FCancelada           write FCancelada;
    property ViaConsumidor: Boolean        read FViaConsumidor       write FViaConsumidor;
    property ImprimeNomeFantasia: Boolean  read FImprimeNomeFantasia write FImprimeNomeFantasia;
  end;

implementation

uses
  ACBrNFGas;

{ TACBrNFGasDANFGasClass }

constructor TACBrNFGasDANFGasClass.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  FACBrNFGas    := nil;

  FProtocolo    := '';
  FCancelada := False;
  FViaConsumidor := True;
  FImprimeNomeFantasia := False;
end;

destructor TACBrNFGasDANFGasClass.Destroy;
begin

  inherited Destroy;
end;

procedure TACBrNFGasDANFGasClass.ImprimirDANFGas(NFGas : TNFGas = nil);
begin
  ErroAbstract('ImprimirDANFGas');
end;

procedure TACBrNFGasDANFGasClass.ImprimirDANFGasCancelado(NFGas: TNFGas);
begin
  ErroAbstract('ImprimirDANFGasCancelado');
end;

procedure TACBrNFGasDANFGasClass.ImprimirDANFGasResumido(NFGas : TNFGas = nil);
begin
  ErroAbstract('ImprimirDANFGasResumido');
end;

procedure TACBrNFGasDANFGasClass.ImprimirDANFGasPDF(NFGas : TNFGas = nil);
begin
  ErroAbstract('ImprimirDANFGasPDF');
end;

procedure TACBrNFGasDANFGasClass.ImprimirDANFGasResumidoPDF(NFGas: TNFGas);
begin
  ErroAbstract('ImprimirDANFGasResumidoPDF');
end;

procedure TACBrNFGasDANFGasClass.ImprimirEVENTO(NFGas: TNFGas);
begin
  ErroAbstract('ImprimirEVENTO');
end;

procedure TACBrNFGasDANFGasClass.ImprimirEVENTOPDF(NFGas: TNFGas);
begin
  ErroAbstract('ImprimirEVENTOPDF');
end;

procedure TACBrNFGasDANFGasClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FACBrNFGas <> nil) and (AComponent is TACBrNFGas) then
    FACBrNFGas := nil;
end;

procedure TACBrNFGasDANFGasClass.SetACBrNFGas(const Value: TComponent);
  Var OldValue : TACBrNFGas;
begin
  if Value <> FACBrNFGas then
  begin
    if Value <> nil then
      if not (Value is TACBrNFGas) then
        raise EACBrNFGasException.Create('ACBrDANFGas.NFGas deve ser do tipo TACBrNFGas');

    if Assigned(FACBrNFGas) then
      FACBrNFGas.RemoveFreeNotification(Self);

    OldValue := TACBrNFGas(FACBrNFGas);   // Usa outra variavel para evitar Loop Infinito
    FACBrNFGas := Value;                 // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.DANFGas) then
        OldValue.DANFGas := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      TACBrNFGas(Value).DANFGas := self;
    end;
  end;
end;

procedure TACBrNFGasDANFGasClass.ErroAbstract(const NomeProcedure: String);
begin
  raise EACBrNFGasException.Create(NomeProcedure + ' não implementado em: ' + ClassName);
end;

function TACBrNFGasDANFGasClass.GetSeparadorPathPDF(const aInitialPath: String): String;
var
  dhEmissao: TDateTime;
  DescricaoModelo: String;
  ANFGas: TNFGas;
begin
  Result := aInitialPath;
  
  if Assigned(ACBrNFGas) then  // Se tem o componente ACBrNFGas
  begin
    if TACBrNFGas(ACBrNFGas).NotasFiscais.Count > 0 then  // Se tem alguma Nota carregada
    begin
      ANFGas := TACBrNFGas(ACBrNFGas).NotasFiscais.Items[0].NFGas;
      if TACBrNFGas(ACBrNFGas).Configuracoes.Arquivos.EmissaoPathNFGas then
        dhEmissao := ANFGas.Ide.dhEmi
      else
        dhEmissao := Now;

      DescricaoModelo := 'NFGas';

      Result := TACBrNFGas(FACBrNFGas).Configuracoes.Arquivos.GetPath(
                         Result,
                         DescricaoModelo,
                         ANFGas.Emit.CNPJ,
                         ANFGas.Emit.IE,
                         dhEmissao,
                         DescricaoModelo);
    end;
  end;
end;

function TACBrNFGasDANFGasClass.CaractereQuebraDeLinha: String;
begin
  Result := '|';
  if Assigned(FACBrNFGas) and (FACBrNFGas is TACBrNFGas) then
    Result := TACBrNFGas(FACBrNFGas).Configuracoes.WebServices.QuebradeLinha;
end;

end.
