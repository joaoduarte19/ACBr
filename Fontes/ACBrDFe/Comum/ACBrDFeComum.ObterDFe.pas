{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrDFeComum.ObterDFe;

interface

uses
  SysUtils, Classes,
  ACBrDFe.Conversao;

type

  { TObterDFe }

  TObterDFe = class
  private
    FTipo: TACBrObterTipo;
    FtpAmb: TACBrTipoAmbiente;
    FDataHoraInicial: TDateTime;
    FDataHoraFinal: TDateTime;
    FChave: string;

    FpVersao: string;
    FpNameSpace: string;
    FptagListaChaves: string;
    FptagDownloadXml: string;
    FptagChave: string;
  public
    constructor Create(const AVersao, ANameSpace, AtagListaChaves,
      AtagDownloadXml, AtagChave: string);

    function GerarXML: string;

    property Tipo: TACBrObterTipo      read FTipo           write FTipo;
    property tpAmb: TACBrTipoAmbiente  read FtpAmb          write FtpAmb;
    property DataHoraInicial: TDateTime read FDataHoraInicial write FDataHoraInicial;
    property DataHoraFinal: TDateTime   read FDataHoraFinal   write FDataHoraFinal;
    property Chave: string              read FChave           write FChave;
  end;

implementation

uses
  ACBrDFeException,
  ACBrUtil.Strings;

{ TObterDFe }

constructor TObterDFe.Create(const AVersao, ANameSpace, AtagListaChaves,
  AtagDownloadXml, AtagChave: string);
begin
  inherited Create;

  FpVersao := AVersao;
  FpNameSpace := ANameSpace;
  FptagListaChaves := AtagListaChaves;
  FptagDownloadXml := AtagDownloadXml;
  FptagChave := AtagChave;

  FTipo := aotNenhum;
  FtpAmb := taHomologacao;
  FDataHoraInicial := 0;
  FDataHoraFinal := 0;
  FChave := '';
end;

function TObterDFe.GerarXML: string;

  function FormatarDataHora(AValue: TDateTime): string;
  begin
    Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn', AValue);
  end;

var
  xChave, xCorpo: string;
begin
  case FTipo of
    aotListaChaves:
      begin
        if FDataHoraInicial <= 0 then
          raise EACBrDFeException.Create(ACBrStr(
            'Obter DFe: informe a Data/Hora inicial para obter a lista de chaves'));

        if (FDataHoraFinal > 0) and (FDataHoraFinal < FDataHoraInicial) then
          raise EACBrDFeException.Create(ACBrStr(
            'Obter DFe: a Data/Hora final nao pode ser anterior a Data/Hora inicial'));

        xCorpo := '<tpAmb>' + TipoAmbienteToStr(FtpAmb) + '</tpAmb>' +
                  '<dataHoraInicial>' + FormatarDataHora(FDataHoraInicial) +
                  '</dataHoraInicial>';

        if FDataHoraFinal > 0 then
          xCorpo := xCorpo + '<dataHoraFinal>' +
                    FormatarDataHora(FDataHoraFinal) + '</dataHoraFinal>';

        Result := '<' + FptagListaChaves + ' ' + FpNameSpace +
                    ' versao="' + FpVersao + '">' +
                    xCorpo +
                  '</' + FptagListaChaves + '>';
      end;

    aotDownloadXml:
      begin
        xChave := Trim(FChave);
        if Length(xChave) <> 44 then
          raise EACBrDFeException.Create(ACBrStr(
            'Obter DFe: a chave de acesso deve ter 44 posicoes'));

        xCorpo := '<tpAmb>' + TipoAmbienteToStr(FtpAmb) + '</tpAmb>' +
                  '<' + FptagChave + '>' + xChave + '</' + FptagChave + '>';

        Result := '<' + FptagDownloadXml + ' ' + FpNameSpace +
                    ' versao="' + FpVersao + '">' +
                    xCorpo +
                  '</' + FptagDownloadXml + '>';
      end;
  else
    raise EACBrDFeException.Create(ACBrStr(
      'Obter DFe: informe o tipo da consulta (aotListaChaves ou aotDownloadXml)'));
  end;
end;

end.
