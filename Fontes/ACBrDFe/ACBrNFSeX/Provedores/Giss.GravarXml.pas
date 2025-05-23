{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatu� - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit Giss.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_Giss204 }

  TNFSeW_Giss204 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarCodigoPaisServico: TACBrXmlNode; override;
    function GerarCodigoPaisTomador: TACBrXmlNode; override;
    function GerarCodigoPaisTomadorExterior: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrNFSeXConsts,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Giss
//==============================================================================

{ TNFSeW_Giss204 }

procedure TNFSeW_Giss204.Configuracao;
begin
  inherited Configuracao;

  NrOcorrCodigoPaisServico := 0;
  NrOcorrCodigoPaisTomador := -1;

  NrOcorrAliquota := 1;

  TagTomador := 'TomadorServico';
end;

function TNFSeW_Giss204.GerarCodigoPaisServico: TACBrXmlNode;
begin
  Result := AddNode(tcInt, '#35', 'CodigoPais', 4, 4, NrOcorrCodigoPaisServico,
                       CodIBGEPaisToCodISO(NFSe.Servico.CodigoPais), DSC_CPAIS);
end;

function TNFSeW_Giss204.GerarCodigoPaisTomador: TACBrXmlNode;
begin
  Result := AddNode(tcInt, '#44', 'CodigoPais', 4, 4, NrOcorrCodigoPaisTomador,
              CodIBGEPaisToCodISO(NFSe.Tomador.Endereco.CodigoPais), DSC_CPAIS);
end;

function TNFSeW_Giss204.GerarCodigoPaisTomadorExterior: TACBrXmlNode;
begin
  Result := AddNode(tcInt, '#38', 'CodigoPais', 4, 4, 0,
              CodIBGEPaisToCodISO(NFSe.Tomador.Endereco.CodigoPais), DSC_CPAIS);
end;

end.
