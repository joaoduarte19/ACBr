{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
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

unit ACBrGTINReg;

interface

uses
  SysUtils, Classes, ACBrGTIN,
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
  ACBrReg, ACBrDFeConfiguracoes, ACBrGTINConfiguracoes, ACBrDFeRegUtil,
  ACBrMail;

{$IFNDEF FPC}
   {$R ACBrGTIN.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBrGTIN', [TACBrGTIN]);

  RegisterPropertyEditor(TypeInfo(TConfiguracoes),   TACBrGTIN,         'Configuracoes', TClassProperty);

  RegisterPropertyEditor(TypeInfo(TArquivosConfGTIN),TConfiguracoes,    'Arquivos',      TClassProperty);
  RegisterPropertyEditor(TypeInfo(TCertificadosConf),TConfiguracoes,    'Certificados',  TClassProperty);
  RegisterPropertyEditor(TypeInfo(TGeralConfGTIN),   TConfiguracoes,    'Geral',         TClassProperty);
  RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes,    'WebServices',   TClassProperty);

  RegisterPropertyEditor(TypeInfo(String),           TWebServicesConf,  'UF',            TACBrUFProperty);
  RegisterPropertyEditor(TypeInfo(String),           TGeralConfGTIN,    'PathSalvar',    TACBrDirProperty);
  RegisterPropertyEditor(TypeInfo(String),           TArquivosConfGTIN, 'PathGTIN',      TACBrDirProperty);

  {$IFDEF FPC}

    RegisterPropertyEditor(TypeInfo(boolean),  TGeralConfGTIN,   'RetirarAcentos',            THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),  TGeralConfGTIN,   'RetirarEspacos',            THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(string),   TGeralConfGTIN,   'QuebradeLinha',             THiddenPropertyEditor);

    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorAno',            THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorCNPJ',           THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorDia',            THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorIE',             THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorMes',            THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),   TArquivosConfGTIN,   'SepararPorModelo',         THiddenPropertyEditor);

    RegisterPropertyEditor(TypeInfo(string),   TDownloadConf,    'PathDownload',              THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(boolean),  TDownloadConf,    'SepararPorNome',            THiddenPropertyEditor);

    RegisterPropertyEditor(TypeInfo(boolean),  TWebServicesConf, 'AjustaAguardaConsultaRet',  THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(Cardinal), TWebServicesConf, 'AguardarConsultaRet',       THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(Cardinal), TWebServicesConf, 'IntervaloTentativas',       THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(integer),  TWebServicesConf, 'Tentativas',                THiddenPropertyEditor);

    RegisterPropertyEditor(TypeInfo(TRespTecConf),     TConfiguracoesGTIN, 'RespTec',         THiddenPropertyEditor);
    RegisterPropertyEditor(TypeInfo(TACBrMail),        TACBrGTIN,          'MAIL',            THiddenPropertyEditor);
  {$ELSE}
    UnlistPublishedProperty(TGeralConfGTIN,   'RetirarAcentos');
    UnlistPublishedProperty(TGeralConfGTIN,   'RetirarEspacos');
    UnlistPublishedProperty(TGeralConfGTIN,   'QuebradeLinha');

    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorAno');
    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorCNPJ');
    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorDia');
    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorIE');
    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorMes');
    UnlistPublishedProperty(TArquivosConfGTIN,   'SepararPorModelo');

    UnlistPublishedProperty(TDownloadConf,     'PathDownload');
    UnlistPublishedProperty(TDownloadConf,     'SepararPorNome');

    UnlistPublishedProperty(TWebServicesConf,  'AjustaAguardaConsultaRet');
    UnlistPublishedProperty(TWebServicesConf,  'AguardarConsultaRet');
    UnlistPublishedProperty(TWebServicesConf,  'IntervaloTentativas');
    UnlistPublishedProperty(TWebServicesConf,  'Tentativas');

    UnlistPublishedProperty(TConfiguracoesGTIN,'RespTec');

    UnlistPublishedProperty(TACBrGTIN,         'MAIL');
  {$ENDIF}


end;

{$IFDEF FPC}
initialization
   {$I ACBrGTIN.lrs}
{$ENDIF}

end.
