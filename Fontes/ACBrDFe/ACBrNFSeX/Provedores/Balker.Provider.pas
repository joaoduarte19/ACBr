{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
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

unit Balker.Provider;

interface

uses
  SysUtils, Classes, Variants,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  Giap.Provider,
  Balker.GravarXml,
  Balker.LerXml;

type
  TACBrNFSeXWebserviceBalker = class(TACBrNFSeXWebserviceGiap)
  protected

  public

  end;

  TACBrNFSeProviderBalker = class (TACBrNFSeProviderGiap)
  protected
    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = '';
                                     const AMessageTag: string = 'Erro'); override;
  public
    function SituacaoTributariaToStr(const t: TnfseSituacaoTributaria): string; override;
    function StrToSituacaoTributaria(out ok: boolean; const s: string): TnfseSituacaoTributaria; override;
    function SituacaoTributariaDescricao(const t: TnfseSituacaoTributaria): string; override;

    function SimNaoToStr(const t: TnfseSimNao): string; override;
    function StrToSimNao(out ok: boolean; const s: string): TnfseSimNao; override;
    function SimNaoDescricao(const t: TnfseSimNao): string; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrDFeException,
  Intertec.GravarXml,
  Intertec.LerXml;

{ TACBrNFSeProviderBalker }

function TACBrNFSeProviderBalker.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Balker.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderBalker.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Balker.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderBalker.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceBalker.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderBalker.ProcessarMensagemErros(RootNode: TACBrXmlNode;
  Response: TNFSeWebserviceResponse; const AListTag, AMessageTag: string);
var
  ANode: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  StatusEmissao: Integer;
begin
  inherited ProcessarMensagemErros(RootNode, Response, AListTag, AMessageTag);

  ANode := RootNode.Document.Root.Childrens.FindAnyNs('notaFiscal');

  if not Assigned(ANode) then
    ANode := RootNode.Document.Root;

  if not Assigned(ANode) then
    Exit;

  StatusEmissao := ObterConteudoTag(ANode.Childrens.FindAnyNs('statusEmissao'), tcInt);

  if StatusEmissao = 401 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := IntToStr(StatusEmissao);
    AErro.Descricao := ObterConteudoTag(ANode.Childrens.FindAnyNs('messages'), tcStr);
    AErro.Correcao := '';
  end;
end;

function TACBrNFSeProviderBalker.SimNaoDescricao(const t: TnfseSimNao): string;
begin
  if t = snSim then
    Result := 'Sim'
  else
    Result := 'Não';
end;

function TACBrNFSeProviderBalker.SimNaoToStr(const t: TnfseSimNao): string;
begin
  Result := EnumeradoToStr(t, ['S', 'N'], [snSim, snNao]);
end;

function TACBrNFSeProviderBalker.SituacaoTributariaDescricao(const t: TnfseSituacaoTributaria): string;
begin
  case t of
    stNormal:   Result := 'N - Não' ;
    stRetencao: Result := 'S - Sim' ;
  else
    Result := '';
  end;
end;

function TACBrNFSeProviderBalker.SituacaoTributariaToStr(const t: TnfseSituacaoTributaria): string;
begin
  Result := EnumeradoToStr(t, ['N', 'S'], [stNormal, stRetencao]);
end;

function TACBrNFSeProviderBalker.StrToSimNao(out ok: boolean; const s: string): TnfseSimNao;
begin
  Result := StrToEnumerado(ok, s, ['S', 'N'], [snSim, snNao]);
end;

function TACBrNFSeProviderBalker.StrToSituacaoTributaria(out ok: boolean; const s: string): TnfseSituacaoTributaria;
begin
  Result := StrToEnumerado(ok, s, ['N', 'S'], [stNormal, stRetencao]);
end;

end.
