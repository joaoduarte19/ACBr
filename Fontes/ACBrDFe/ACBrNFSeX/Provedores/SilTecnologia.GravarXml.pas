{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
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

unit SilTecnologia.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXGravarXml_ABRASFv1,
  ACBrNFSeXGravarXml_ABRASFv2,
  PadraoNacional.GravarXml;

type
  { TNFSeW_SilTecnologia }

  TNFSeW_SilTecnologia = class(TNFSeW_ABRASFv1)
  protected

  end;

  { TNFSeW_SilTecnologia203 }

  TNFSeW_SilTecnologia203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

  end;

  { TNFSeW_SilTecnologiaAPIPropria }

  TNFSeW_SilTecnologiaAPIPropria = class(TNFSeW_PadraoNacional)
  private
    FNrOcorrcPaisTomador: Integer;
  protected
    procedure Configuracao; override;
    function GerarXMLEnderecoNacionalTomador: TACBrXmlNode; override;
  public
    function GerarXml: Boolean; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     SilTecnologia
//==============================================================================

{ TNFSeW_SilTecnologia203 }

procedure TNFSeW_SilTecnologia203.Configuracao;
begin
  inherited Configuracao;

  FormatoAliq := tcDe2;

  NrOcorrInformacoesComplemetares := 0;
  NrOcorrAliquota := 1;
  NrOcorrCodigoPaisServico := -1;
  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
end;

{ TNFSeW_SilTecnologiaAPIPropria }

procedure TNFSeW_SilTecnologiaAPIPropria.Configuracao;
begin
  inherited Configuracao;

  GerarIBSCBSNFSe := True;

  NrOcorrtpAmb := -1;
  NrOcorrnNFSe := -1;

  FNrOcorrcPaisTomador := -1;

  if FpAOwner.ConfigGeral.Params.ParamTemValor('GerarTag', 'cPais') then
    FNrOcorrcPaisTomador := 1;
end;

function TNFSeW_SilTecnologiaAPIPropria.GerarXml: Boolean;
var
  NFSeNode: TACBrXmlNode;
begin
  Configuracao;
  LerParamsTabIni(True);

  ListaDeAlertas.Clear;

  FDocument.Clear();

  NFSeNode := GerarXMLNFSe;
  FDocument.Root := NFSeNode;

  Result := True;
end;

function TNFSeW_SilTecnologiaAPIPropria.GerarXMLEnderecoNacionalTomador: TACBrXmlNode;
begin
  Result := CreateElement('endNac');

  Result.AppendChild(AddNode(tcStr, '#1', 'cPais', 2, 2, FNrOcorrcPaisTomador,
                 CodIBGEPaisToSiglaISO2(NFSe.Tomador.Endereco.CodigoPais), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cMun', 7, 7, 1,
                                    NFSe.Tomador.Endereco.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CEP', 8, 8, 1,
                                                NFSe.Tomador.Endereco.CEP, ''));
end;

end.
