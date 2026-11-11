{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias César Vieira                                                         }
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

unit ACBrBaaSReg;

interface

uses
  Classes,
  {$IFDEF FPC}
    LResources, PropEdits
  {$ELSE}
    DesignIntf, DesignEditors
  {$ENDIF};

type

  { TACBrExtratoAPIVersaoProperty }

  TACBrExtratoAPIVersaoProperty = class({$IFDEF FPC}TEnumPropertyEditor{$ELSE}TEnumProperty{$ENDIF})
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TACBrExtratoAPIBancoConsultaProperty }

  TACBrExtratoAPIBancoConsultaProperty = class({$IFDEF FPC}TEnumPropertyEditor{$ELSE}TEnumProperty{$ENDIF})
  public
    procedure SetValue(const NewValue: {$IFDEF FPC}AnsiString{$ELSE}String{$ENDIF}); override;
  end;

procedure Register;

implementation

uses
  TypInfo, {$IFDEF FPC}Forms,{$ELSE}ExtCtrls,{$ENDIF}
  ACBrExtratoAPI, ACBrPagamentosAPI, ACBrPagamentosAPIBB, ACBrExtratoAPIBB;

{$IFNDEF FPC}
   {$R ACBrBaaS.dcr}
{$ENDIF}

type

  { TACBrExtratoAPIReconstrutorOI }

  TACBrExtratoAPIReconstrutorOI = class
  {$IFDEF FPC}
  public
    procedure Reconstruir(Data: PtrInt);
  {$ELSE}
  private
    fTimer: TTimer;
    fDesigner: IDesigner;
    procedure Reconstruir(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agendar(const aDesigner: IDesigner);
  {$ENDIF}
  end;

{$IFNDEF FPC}
var
  ReconstrutorOI: TACBrExtratoAPIReconstrutorOI;
{$ENDIF}

{ TACBrExtratoAPIVersaoProperty }

procedure TACBrExtratoAPIVersaoProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  wBanco: TACBrExtratoAPIBancoClass;
begin
  wBanco := TACBrExtratoAPIBancoClass(GetComponent(0));
  for i := Ord(Low(TACBrExtratoAPIVersao)) to Ord(High(TACBrExtratoAPIVersao)) do
    if wBanco.APIVersaoPermitida(TACBrExtratoAPIVersao(i)) then
      Proc(GetEnumName(TypeInfo(TACBrExtratoAPIVersao), i));
end;

{ TACBrExtratoAPIBancoConsultaProperty }

procedure TACBrExtratoAPIBancoConsultaProperty.SetValue(
  const NewValue: {$IFDEF FPC}AnsiString{$ELSE}String{$ENDIF});
{$IFDEF FPC}
var
  wReconstrutor: TACBrExtratoAPIReconstrutorOI;
{$ENDIF}
begin
  inherited SetValue(NewValue);

  // O Object Inspector não pode ser reconstruído enquanto aplica o valor; a reconstrução fica para depois
  {$IFDEF FPC}
  wReconstrutor := TACBrExtratoAPIReconstrutorOI.Create;
  Application.QueueAsyncCall(@wReconstrutor.Reconstruir, 0);
  {$ELSE}
  if (ReconstrutorOI = nil) then
    ReconstrutorOI := TACBrExtratoAPIReconstrutorOI.Create;
  ReconstrutorOI.Agendar(Designer);
  {$ENDIF}
end;

{ TACBrExtratoAPIReconstrutorOI }

{$IFDEF FPC}
procedure TACBrExtratoAPIReconstrutorOI.Reconstruir(Data: PtrInt);
var
  wSelecao: TPersistentSelectionList;
begin
  try
    if (GlobalDesignHook = nil) then
      Exit;

    wSelecao := TPersistentSelectionList.Create;
    try
      GlobalDesignHook.GetSelection(wSelecao);
      wSelecao.ForceUpdate := True;
      GlobalDesignHook.SetSelection(wSelecao);
    finally
      wSelecao.Free;
    end;
  finally
    Free;
  end;
end;
{$ELSE}
constructor TACBrExtratoAPIReconstrutorOI.Create;
begin
  inherited Create;
  fTimer := TTimer.Create(nil);
  fTimer.Enabled := False;
  fTimer.Interval := 1;
  fTimer.OnTimer := Reconstruir;
end;

destructor TACBrExtratoAPIReconstrutorOI.Destroy;
begin
  fTimer.Free;
  fDesigner := nil;
  inherited Destroy;
end;

procedure TACBrExtratoAPIReconstrutorOI.Agendar(const aDesigner: IDesigner);
begin
  fDesigner := aDesigner;
  fTimer.Enabled := True;
end;

procedure TACBrExtratoAPIReconstrutorOI.Reconstruir(Sender: TObject);
var
  wDesigner: IDesigner;
  wSelecao: IDesignerSelections;
begin
  fTimer.Enabled := False;
  wDesigner := fDesigner;
  fDesigner := nil;
  if (wDesigner = nil) then
    Exit;

  wSelecao := CreateSelectionList;
  wDesigner.GetSelections(wSelecao);
  wDesigner.SelectComponent(wDesigner.Root);
  wDesigner.SetSelections(wSelecao);
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBrBaaS', [TACBrExtratoAPI, TACBrPagamentosAPI,
    TACBrPagamentosAPIBB]);

  RegisterPropertyEditor(TypeInfo(TACBrExtratoAPIVersao), TACBrExtratoAPIBancoClass,
    'APIVersao', TACBrExtratoAPIVersaoProperty);
  RegisterPropertyEditor(TypeInfo(TACBrExtratoAPIBancoConsulta), TACBrExtratoAPI,
    'BancoConsulta', TACBrExtratoAPIBancoConsultaProperty);
end;

{$IFDEF FPC}
{$IFNDEF FRAMEWORK}
initialization
   {$i ACBrBaaS.lrs}
{$ENDIF}
{$ELSE}
initialization

finalization
  ReconstrutorOI.Free;
{$ENDIF}

end.
