{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                              MXM Sistemas                                    }
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

unit ACBrNFeABIReg;

interface

uses
  SysUtils, Classes, ACBrNFeABI,
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

procedure Register;

implementation

uses
  ACBrReg, ACBrDFeConfiguracoes, ACBrNFeABIConfiguracoes, ACBrDFeRegUtil;

{$IFNDEF FPC}
   {$R ACBrNFeABI.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBrNFeABI', [TACBrNFeABI]);

  RegisterPropertyEditor(TypeInfo(TCertificadosConf), TConfiguracoes, 'Certificados',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(TConfiguracoes), TACBrNFeABI, 'Configuracoes',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes, 'WebServices',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TWebServicesConf, 'UF',
     TACBrUFProperty);

  RegisterPropertyEditor(TypeInfo(TGeralConfNFeABI), TConfiguracoes, 'Geral',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TGeralConfNFeABI, 'PathSalvar',
     TACBrDirProperty);

  RegisterPropertyEditor(TypeInfo(TArquivosConfNFeABI), TConfiguracoes, 'Arquivos',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConfNFeABI, 'PathNFeABI',
     TACBrDirProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConfNFeABI, 'PathEvento',
     TACBrDirProperty);

  RegisterPropertyEditor(TypeInfo(TRespTecConf), TConfiguracoes, 'RespTec',
     TClassProperty);
end;

{$IFDEF FPC}
initialization
   {$I ACBrNFeABI.lrs}
{$ENDIF}

end.
