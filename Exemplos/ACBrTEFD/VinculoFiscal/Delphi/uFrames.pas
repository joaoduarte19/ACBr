unit uFrames;

interface

uses
  Classes,
  SysUtils,
  Controls,
  Forms;

type
  TFrameClass = class of TFrame;

function AbrirFrame(
  AContainer: TWinControl;
  AFrameClass: TFrameClass
): TFrame;

procedure FecharFrame(
  var AFrame: TFrame
);

implementation

function AbrirFrame(
  AContainer: TWinControl;
  AFrameClass: TFrameClass
): TFrame;
begin
  Result := AFrameClass.Create(AContainer);
  Result.Parent := AContainer;
  Result.Align := alClient;
end;

procedure FecharFrame(
  var AFrame: TFrame
);
begin
  if Assigned(AFrame) then
    FreeAndNil(AFrame);
end;

end.
