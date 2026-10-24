unit uframerodapeSalvar;

interface

uses
  Classes, SysUtils, Forms, Controls, Buttons, StdCtrls;

type

  { TframeRodape }

  TframeRodape = class(TFrame)
    btnSalvar: TSpeedButton;
    lblTexto: TLabel;
  private

  public
    procedure ConfigurarTExto(const ATexto: string);
  end;

implementation

{$R *.dfm}

{ TframeRodape }

procedure TframeRodape.ConfigurarTExto(const ATexto: string);
begin
  lblTexto.Caption := ATexto;
end;

end.
