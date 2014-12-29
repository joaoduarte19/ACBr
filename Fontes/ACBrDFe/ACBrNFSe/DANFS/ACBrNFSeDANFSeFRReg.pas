{$I ACBr.inc}

unit ACBrNFSeDANFSeFRReg;

interface

uses
  SysUtils, Classes, ACBrNFSeDANFSeFR,
  {$IFDEF VisualCLX} QDialogs {$ELSE} Dialogs{$ENDIF},
  {$IFDEF FPC}
     LResources, LazarusPackageIntf, PropEdits, componenteditors
  {$ELSE}
    {$IFNDEF COMPILER6_UP}
       DsgnIntf
    {$ELSE}
       DesignIntf,
       DesignEditors
    {$ENDIF}
  {$ENDIF} ;

type
  { Editor de Proriedades de Componente para chamar OpenDialog dos Relatorios }
  TACBrNFSeDANFSeFRFileNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  procedure Register;

implementation

{$IFNDEF FPC}
   {$R ACBrNFSe.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrNFSeDANFSeFR]);
  
  RegisterPropertyEditor(TypeInfo(String), TACBrNFSeDANFSeFR, 'FastFile',
     TACBrNFSeDANFSeFRFileNameProperty);
end;

{ TACBrNFSeDANFSeFRFileNameProperty }

procedure TACBrNFSeDANFSeFRFileNameProperty.Edit;
var Dlg : TOpenDialog;
begin
  Dlg := TOpenDialog.Create(nil);
  try
     Dlg.FileName   := GetValue;
     Dlg.InitialDir := ExtractFilePath(GetValue);
     Dlg.Filter     := 'Arquivos do FastReport|*.fr3|Todos os arquivos|*.*';

     if Dlg.Execute then
        SetValue(Dlg.FileName);
  finally
     Dlg.Free;
  end;
end;

function TACBrNFSeDANFSeFRFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

end.
