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

unit ACBrNFAgDANFAgClass;

interface

uses
  SysUtils, Classes, ACBrBase,
  ACBrNFAg.Classes, pcnConversao, ACBrDFeReport;

type

  { TACBrNFAgDANFAgClass }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrNFAgDANFAgClass = class( TACBrDFeReport )
  private
    procedure SetACBrNFAg(const Value: TComponent);
    procedure ErroAbstract(const NomeProcedure: String);

  protected
   function GetSeparadorPathPDF(const aInitialPath: String): String; override;

  protected
    FACBrNFAg: TComponent;
    FTipoDANFAg: TpcnTipoImpressao;
    FProtocolo: String;
    FCancelada: Boolean;
    FViaConsumidor: Boolean;
    FImprimeNomeFantasia: Boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFAg(NFAg: TNFAg = nil); virtual;
    procedure ImprimirDANFAgCancelado(NFAg: TNFAg = nil); virtual;
    procedure ImprimirDANFAgResumido(NFAg: TNFAg = nil); virtual;
    procedure ImprimirDANFAgPDF(NFAg: TNFAg = nil); virtual;
    procedure ImprimirDANFAgResumidoPDF(NFAg: TNFAg = nil); virtual;
    procedure ImprimirEVENTO(NFAg: TNFAg = nil); virtual;
    procedure ImprimirEVENTOPDF(NFAg: TNFAg = nil); virtual;

    function CaractereQuebraDeLinha: String;

  published
    property ACBrNFAg: TComponent          read FACBrNFAg            write SetACBrNFAg;
    property TipoDANFAg: TpcnTipoImpressao read FTipoDANFAg          write FTipoDANFAg;
    property Protocolo: String             read FProtocolo           write FProtocolo;
    property Cancelada: Boolean            read FCancelada           write FCancelada;
    property ViaConsumidor: Boolean        read FViaConsumidor       write FViaConsumidor;
    property ImprimeNomeFantasia: Boolean  read FImprimeNomeFantasia write FImprimeNomeFantasia;
  end;

implementation

uses
  ACBrNFAg;

{ TACBrNFAgDANFAgClass }

constructor TACBrNFAgDANFAgClass.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  FACBrNFAg    := nil;

  FProtocolo    := '';
  FCancelada := False;
  FViaConsumidor := True;
  FImprimeNomeFantasia := False;
end;

destructor TACBrNFAgDANFAgClass.Destroy;
begin

  inherited Destroy;
end;

procedure TACBrNFAgDANFAgClass.ImprimirDANFAg(NFAg : TNFAg = nil);
begin
  ErroAbstract('ImprimirDANFAg');
end;

procedure TACBrNFAgDANFAgClass.ImprimirDANFAgCancelado(NFAg: TNFAg);
begin
  ErroAbstract('ImprimirDANFAgCancelado');
end;

procedure TACBrNFAgDANFAgClass.ImprimirDANFAgResumido(NFAg : TNFAg = nil);
begin
  ErroAbstract('ImprimirDANFAgResumido');
end;

procedure TACBrNFAgDANFAgClass.ImprimirDANFAgPDF(NFAg : TNFAg = nil);
begin
  ErroAbstract('ImprimirDANFAgPDF');
end;

procedure TACBrNFAgDANFAgClass.ImprimirDANFAgResumidoPDF(NFAg: TNFAg);
begin
  ErroAbstract('ImprimirDANFAgResumidoPDF');
end;

procedure TACBrNFAgDANFAgClass.ImprimirEVENTO(NFAg: TNFAg);
begin
  ErroAbstract('ImprimirEVENTO');
end;

procedure TACBrNFAgDANFAgClass.ImprimirEVENTOPDF(NFAg: TNFAg);
begin
  ErroAbstract('ImprimirEVENTOPDF');
end;

procedure TACBrNFAgDANFAgClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FACBrNFAg <> nil) and (AComponent is TACBrNFAg) then
    FACBrNFAg := nil;
end;

procedure TACBrNFAgDANFAgClass.SetACBrNFAg(const Value: TComponent);
  Var OldValue : TACBrNFAg;
begin
  if Value <> FACBrNFAg then
  begin
    if Value <> nil then
      if not (Value is TACBrNFAg) then
        raise EACBrNFAgException.Create('ACBrDANFAg.NFAg deve ser do tipo TACBrNFAg');

    if Assigned(FACBrNFAg) then
      FACBrNFAg.RemoveFreeNotification(Self);

    OldValue := TACBrNFAg(FACBrNFAg);   // Usa outra variavel para evitar Loop Infinito
    FACBrNFAg := Value;                 // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.DANFAg) then
        OldValue.DANFAg := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      TACBrNFAg(Value).DANFAg := self;
    end;
  end;
end;

procedure TACBrNFAgDANFAgClass.ErroAbstract(const NomeProcedure: String);
begin
  raise EACBrNFAgException.Create(NomeProcedure + ' não implementado em: ' + ClassName);
end;

function TACBrNFAgDANFAgClass.GetSeparadorPathPDF(const aInitialPath: String): String;
var
  dhEmissao: TDateTime;
  DescricaoModelo: String;
  ANFAg: TNFAg;
begin
  Result := aInitialPath;
  
  if Assigned(ACBrNFAg) then  // Se tem o componente ACBrNFAg
  begin
    if TACBrNFAg(ACBrNFAg).NotasFiscais.Count > 0 then  // Se tem alguma Nota carregada
    begin
      ANFAg := TACBrNFAg(ACBrNFAg).NotasFiscais.Items[0].NFAg;
      if TACBrNFAg(ACBrNFAg).Configuracoes.Arquivos.EmissaoPathNFAg then
        dhEmissao := ANFAg.Ide.dhEmi
      else
        dhEmissao := Now;

      DescricaoModelo := 'NFAg';

      Result := TACBrNFAg(FACBrNFAg).Configuracoes.Arquivos.GetPath(
                         Result,
                         DescricaoModelo,
                         ANFAg.Emit.CNPJ,
                         ANFAg.Emit.IE,
                         dhEmissao,
                         DescricaoModelo);
    end;
  end;
end;

function TACBrNFAgDANFAgClass.CaractereQuebraDeLinha: String;
begin
  Result := '|';
  if Assigned(FACBrNFAg) and (FACBrNFAg is TACBrNFAg) then
    Result := TACBrNFAg(FACBrNFAg).Configuracoes.WebServices.QuebradeLinha;
end;

end.
