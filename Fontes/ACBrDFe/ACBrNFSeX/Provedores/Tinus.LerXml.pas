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

unit Tinus.LerXml;

interface

uses
  SysUtils, Classes, StrUtils, IniFiles,
  PadraoNacional.LerXml,
  ACBrNFSeXLerXml_ABRASFv1,
  ACBrNFSeXLerXml_ABRASFv2;

type
  { TNFSeR_Tinus }

  TNFSeR_Tinus = class(TNFSeR_ABRASFv1)
  protected

  public

  end;

  { TNFSeR_Tinus203 }

  {
    O provedor esta retornando o XML segundo o Padrão Nacional em vez ABRASF.
  }
  TNFSeR_Tinus203 = class(TNFSeR_PadraoNacional)
  protected

    procedure LerIniRps(AINIRec: TMemIniFile);
    procedure LerIniNfse(AINIRec: TMemIniFile);
  public
    function LerIni: Boolean; override;

  end;

implementation

uses
  ACBrUtil.FilesIO,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     Tinus
//==============================================================================

{ TNFSeR_Tinus203 }

function TNFSeR_Tinus203.LerIni: Boolean;
var
  INIRec: TMemIniFile;
begin
  INIRec := TMemIniFile.Create('');

  // Usar o FpAOwner em vez de  FProvider

  try
    LerIniArquivoOuString(Arquivo, INIRec);

    FpTipoXML := INIRec.ReadString('IdentificacaoNFSe', 'TipoXML', '');

    if FpTipoXML = 'NFSE' then
      LerIniNfse(INIRec)
    else
      LerIniRps(INIRec);

  finally
    INIRec.Free;
  end;

  Result := True;
end;

procedure TNFSeR_Tinus203.LerIniNfse(AINIRec: TMemIniFile);
begin
  NFSe.tpXML := txmlNFSe;

  LerINIIdentificacaoNFSe(AINIRec);
  LerINIDadosEmitente(AINIRec);
  LerINIValoresNFSe(AINIRec);
  // Informações sobre o DPS
  LerINIIdentificacaoRps(AINIRec);
  LerININFSeSubstituicao(AINIRec);
  LerINIDadosPrestador(AINIRec);
  LerINIDadosTomador(AINIRec);
  LerINIDadosIntermediario(AINIRec);
  LerINIDadosServico(AINIRec);
  LerINIComercioExterior(AINIRec);
  LerINILocacaoSubLocacao(AINIRec);
  LerINIConstrucaoCivil(AINIRec);
  LerINIEvento(AINIRec);
  LerINIRodoviaria(AINIRec);
  LerINIInformacoesComplementares(AINIRec);
  LerINIValores(AINIRec);
  LerINIDocumentosDeducoes(AINIRec);
  LerINIValoresTribMun(AINIRec);
  LerINIValoresTribFederal(AINIRec);
  LerINIValoresTotalTrib(AINIRec);

  // Reforma Tributária
  LerINIIBSCBS(AINIRec, NFSe.IBSCBS);

  LerINIIBSCBSNFSe(AINIRec, NFSe.infNFSe.IBSCBS);

  with NFSe.Servico.Valores do
  begin
    if (BaseCalculo = 0) and (ValorLiquidoNfse = 0) and (ValorTotalNotaFiscal = 0) then
    begin
      BaseCalculo := ValorServicos - ValorDeducoes - DescontoIncondicionado;

      case tribFed.tpRetPisCofins of
        trpiscofinscsllNaoRetido:
          RetencoesFederais := ValorInss + ValorIr;

        trpiscofinscsllRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorPis + ValorCofins + ValorCsll;

        trpiscofinsRetidocsllNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorPis + ValorCofins;

        trPisRetidoCofinsCsllNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorPis;

        trCofinsRetidoPisCsllNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorCofins;

        trCofinsCsllRetidoPisNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorCofins + ValorCsll;

        trCsllRetidoPisCofinsNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorCsll;

        trPisCsllRetidoCofinsNaoRetido:
          RetencoesFederais := ValorInss + ValorIr + ValorPis + ValorCsll;
      else
        RetencoesFederais := ValorInss + ValorIr + ValorPis + ValorCofins + ValorCsll;
      end;

      ValorLiquidoNfse := ValorServicos - RetencoesFederais - OutrasRetencoes -
                 ValorIssRetido - DescontoIncondicionado - DescontoCondicionado;
    end;

    RetencoesFederais := RetencoesFederais - ValorIssRetido;

    if ValorTotalNotaFiscal = 0 then
      ValorTotalNotaFiscal := ValorServicos - DescontoCondicionado -
                              DescontoIncondicionado;
  end;
end;

procedure TNFSeR_Tinus203.LerIniRps(AINIRec: TMemIniFile);
begin
  NFSe.tpXML := txmlRPS;

  LerINIIdentificacaoNFSe(AINIRec);
  LerINIIdentificacaoRps(AINIRec);
  LerININFSeSubstituicao(AINIRec);
  LerINIDadosPrestador(AINIRec);
  LerINIDadosTomador(AINIRec);
  LerINIDadosIntermediario(AINIRec);
  LerINIDadosServico(AINIRec);
  LerINIComercioExterior(AINIRec);
  LerINILocacaoSubLocacao(AINIRec);
  LerINIConstrucaoCivil(AINIRec);
  LerINIEvento(AINIRec);
  LerINIRodoviaria(AINIRec);
  LerINIInformacoesComplementares(AINIRec);
  LerINIInformacoesComplementaresgItemPed(AINIRec);
  LerINIValores(AINIRec);
  LerINIValoresNFSe(AINIRec);
  LerINIDocumentosDeducoes(AINIRec);
  LerINIValoresTribMun(AINIRec);
  LerINIValoresTribFederal(AINIRec);
  LerINIValoresTotalTrib(AINIRec);

  // Reforma Tributária
  LerINIIBSCBS(AINIRec, NFSe.IBSCBS);

  LerINIIBSCBSNFSe(AINIRec, NFSe.infNFSe.IBSCBS);
end;

end.
