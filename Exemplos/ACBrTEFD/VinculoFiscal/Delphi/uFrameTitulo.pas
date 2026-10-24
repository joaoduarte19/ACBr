unit uFrameTitulo;

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls;

type

  { TFrameTitulo }

  TFrameTitulo = class(TFrame)
      lblTitulo: TLabel;
      lblACBr: TLabel;
    Shape1: TShape;
  private

  public
       procedure ConfigurarTitulo(
      const ATitulo, ASubTitulo: string
    );
  end;

implementation

{$R *.dfm}

{ TFrameTitulo }

procedure TFrameTitulo.ConfigurarTitulo(const ATitulo, ASubTitulo: string);
begin

end;

end.

