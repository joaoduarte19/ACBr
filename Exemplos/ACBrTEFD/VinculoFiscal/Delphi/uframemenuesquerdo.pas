unit uframemenuesquerdo;

interface

uses
  Classes, SysUtils, Forms, Controls, Buttons, StdCtrls, IniFiles, uFrames;

type

  { TframeMenuEsquerdo }

  TframeMenuEsquerdo = class(TFrame)
    btnSAIR: TSpeedButton;
    btnPDV: TSpeedButton;
    btnCfgNFCe: TSpeedButton;
    btnConfTEF: TSpeedButton;
    btnCfgPIX: TSpeedButton;
    cbUsarTEF: TCheckBox;
    cbUsarPIXCD: TCheckBox;
    procedure btnCfgNFCeClick(Sender: TObject);
    procedure btnSAIRClick(Sender: TObject);
    procedure cbUsarTEFClick(Sender: TObject);
    procedure cbUsarPIXCDClick(Sender: TObject);
  private
     FFrame: TFrame;
     function ArqINI: String;
     procedure GravarHabilitado(const ASecao: String; AValor: Boolean);
  public
     procedure CarregarOpcoes;
  end;

implementation

{$R *.dfm}

{ TframeMenuEsquerdo }

procedure TframeMenuEsquerdo.btnSAIRClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TframeMenuEsquerdo.btnCfgNFCeClick(Sender: TObject);
begin
  // quero abrir  o frame do formprinciapal
end;

function TframeMenuEsquerdo.ArqINI: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

// Mesmas chaves lidas por TEFHabilitado (uTEFUtils) e PIXHabilitado (uPIXUtils)
procedure TframeMenuEsquerdo.CarregarOpcoes;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(ArqINI);
  try
    cbUsarTEF.Checked := INI.ReadBool('TEF', 'Habilitado', True);
    cbUsarPIXCD.Checked := INI.ReadBool('PIX', 'Habilitado', False);
  finally
    INI.Free;
  end;
end;

procedure TframeMenuEsquerdo.GravarHabilitado(const ASecao: String; AValor: Boolean);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(ArqINI);
  try
    INI.WriteBool(ASecao, 'Habilitado', AValor);
  finally
    INI.Free;
  end;
end;

procedure TframeMenuEsquerdo.cbUsarTEFClick(Sender: TObject);
begin
  GravarHabilitado('TEF', cbUsarTEF.Checked);
end;

procedure TframeMenuEsquerdo.cbUsarPIXCDClick(Sender: TObject);
begin
  GravarHabilitado('PIX', cbUsarPIXCD.Checked);
end;

end.

