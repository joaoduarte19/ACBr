{******************************************************************************}
{ Projeto: Componente ACBrGNRE                                                 }
{  Biblioteca multiplataforma de componentes Delphi/Lazarus para emissão da    }
{  Guia Nacional de Recolhimento de Tributos Estaduais                         }
{  http://www.gnre.pe.gov.br/                                                  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2013 Claudemir Vitor Pereira                }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                       Juliomar Marchetti                     }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 09/12/2013 - Claudemir Vitor Pereira
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}
{$I ACBr.inc}

unit ACBrGNREReg;

interface

uses
 SysUtils, Classes,
{$IFDEF VisualCLX}
 QDialogs,
{$ELSE}
 Dialogs, FileCtrl,
{$ENDIF}
{$IFDEF FPC}
  LResources, LazarusPackageIntf, PropEdits, componenteditors,
{$ELSE}
  {$IFNDEF COMPILER6_UP}
    DsgnIntf,
  {$ELSE}
    DesignIntf, DesignEditors,
  {$ENDIF}
{$ENDIF}
 ACBrGNRE2,  pgnreConversao;

type

 { Editor de Proriedades de Componente para mostrar o AboutACBr }
 TACBrAboutDialogProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

 { Editor de Proriedades de Componente para chamar OpenDialog }
 TACBrGNREDirProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses
 ACBrGNREConfiguracoes;

{$IFNDEF FPC}
   {$R ACBrGNRE.dcr}
{$ENDIF}

procedure Register;
begin
 RegisterComponents('ACBr', [TACBrGNRE]);

 RegisterPropertyEditor(TypeInfo(TACBrGNREAboutInfo), nil, 'AboutACBrGNRE',
     TACBrAboutDialogProperty);

 RegisterPropertyEditor(TypeInfo(TCertificadosConf), TConfiguracoes, 'Certificados',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TConfiguracoes), TACBrGNRE, 'Configuracoes',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes, 'WebServices',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TGeralConf), TConfiguracoes, 'Geral',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TGeralConf, 'PathSalvar',
     TACBrGNREDirProperty);

 RegisterPropertyEditor(TypeInfo(TArquivosConf), TConfiguracoes, 'Arquivos',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathGNRE',
     TACBrGNREDirProperty);
end;

{ TACBrAboutDialogProperty }

procedure TACBrAboutDialogProperty.Edit;
begin
 ACBrAboutDialog;
end;

function TACBrAboutDialogProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog, paReadOnly];
end;

function TACBrAboutDialogProperty.GetValue: string;
begin
 Result := 'Versão: ' + ACBrGNRE_VERSAO;
end;

{ TACBrGNREDirProperty }

procedure TACBrGNREDirProperty.Edit;
var
{$IFNDEF VisualCLX} Dir: String; {$ELSE} Dir: WideString; {$ENDIF}
begin
{$IFNDEF VisualCLX}
  Dir := GetValue;
  if SelectDirectory(Dir,[],0)
   then SetValue( Dir );
{$ELSE}
  Dir := '';
  if SelectDirectory('Selecione o Diretório','',Dir)
   then SetValue( Dir );
{$ENDIF}
end;

function TACBrGNREDirProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog];
end;

initialization

{$IFDEF FPC}
   {$i ACBrGNRE.lrs}
{$ENDIF}

end.
