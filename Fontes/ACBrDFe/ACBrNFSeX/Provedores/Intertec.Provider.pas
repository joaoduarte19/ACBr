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

unit Intertec.Provider;

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
  Giap.Provider;

type
  TACBrNFSeXWebserviceIntertec = class(TACBrNFSeXWebserviceGiap)
  protected

  public

  end;

  TACBrNFSeProviderIntertec = class (TACBrNFSeProviderGiap)
  protected
    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = '';
                                     const AMessageTag: string = 'Erro'); override;
  public

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrDFeException,
  Intertec.GravarXml,
  Intertec.LerXml;

{ TACBrNFSeProviderIntertec }

function TACBrNFSeProviderIntertec.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Intertec.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderIntertec.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Intertec.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderIntertec.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceIntertec.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderIntertec.ProcessarMensagemErros(RootNode: TACBrXmlNode;
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

end.
