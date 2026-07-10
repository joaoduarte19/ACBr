{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Victor H Gonzales - Pandaaa                     }
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
unit ACBrConsultaCNPJ.WS.BrasilAPI;

interface
uses
  ACBrConsultaCNPJ.WS,
  SysUtils;

type
  EACBrConsultaCNPJWSException = class ( Exception );

  { TACBrConsultaCNPJWS }
  TACBrConsultaCNPJWSBrasilAPI = class(TACBrConsultaCNPJWS)
    public
      function Executar:boolean; override;
  end;
const
  C_URL = 'https://brasilapi.com.br/api/cnpj/v1/';

implementation

uses
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrJSON;

{ TACBrConsultaCNPJWS }

function TACBrConsultaCNPJWSBrasilAPI.Executar: boolean;
var
  LJSon: TACBrJSONArray;
  LJsonObject : TACBrJSONObject;
  LJsonArray: TACBrJSONArray;
  LRetorno : String;
  I, Z, LResultCode : Integer;
begin
  Result := False;

  inherited Executar;

  LResultCode := SendHttp('GET',C_URL +  OnlyAlphaNum(FCNPJ), LRetorno);

  LJSon := TACBrJSONArray.Parse('[' + UTF8ToNativeString(LRetorno) + ']');

  try
    for I := 0 to Pred(LJSon.Count) do
    begin

      LJsonObject := LJSon.ItemAsJSONObject[I];

      if LResultCode = 200 then
      begin
        FResposta.RazaoSocial          := LJsonObject.AsString['razao_social'];
        FResposta.CNPJ                 := LJsonObject.AsString['cnpj'];
        FResposta.Fantasia             := LJsonObject.AsString['nome_fantasia'];
        FResposta.Abertura             := StringToDateTimeDef(LJsonObject.AsString['data_inicio_atividade'],0,'yyyy/mm/dd');
        FResposta.Porte                := LJsonObject.AsString['porte'];

        FResposta.CNAE1                := IntToStr(LJsonObject.AsInteger['cnae_fiscal']) + ' ' + LJsonObject.AsString['cnae_fiscal_descricao'];

        LJsonArray := LJsonObject.AsJSONArray['cnaes_secundarios'];

        for Z := 0 to Pred(LJsonArray.Count) do
          FResposta.CNAE2.Add(IntToStr(LJsonArray.ItemAsJSONObject[Z].AsInteger['codigo']) + ' ' + LJsonArray.ItemAsJSONObject[Z].AsString['descricao']);

        LJsonArray := LJsonObject.AsJSONArray['qsa'];
        SetLength(FResposta.QSA,LJsonArray.Count);
        for Z := 0 to Pred(LJsonArray.Count) do
        begin
          FResposta.QSA[Z].Codigo                    := LJsonArray.ItemAsJSONObject[Z].AsString['identificador_de_socio'];
          FResposta.QSA[Z].Nome                      := LJsonArray.ItemAsJSONObject[Z].AsString['nome_socio'];
          FResposta.QSA[Z].Qualificacao              := LJsonArray.ItemAsJSONObject[Z].AsString['qualificacao_socio'];
          FResposta.QSA[Z].CodigoRepresentante       := LJsonArray.ItemAsJSONObject[Z].AsString['codigo_qualificacao_representante_legal'];
          FResposta.QSA[Z].Representante             := LJsonArray.ItemAsJSONObject[Z].AsString['nome_representante_legal'];
          FResposta.QSA[Z].QualificacaoRepresentante := LJsonArray.ItemAsJSONObject[Z].AsString['qualificacao_representante_legal'];
        end;

        FResposta.EmpresaTipo          := LJsonObject.AsString['descricao_identificador_matriz_filial'];
        FResposta.Endereco             := Trim(LJsonObject.AsString['descricao_tipo_de_logradouro'] + ' ' + LJsonObject.AsString['logradouro']);
        FResposta.Numero               := LJsonObject.AsString['numero'];
        FResposta.Complemento          := LJsonObject.AsString['complemento'];
        FResposta.CEP                  := FormatFloat('00000000', LJsonObject.AsInteger['cep']);
        FResposta.Bairro               := LJsonObject.AsString['bairro'];
        FResposta.Cidade               := LJsonObject.AsString['municipio'];
        FResposta.CodigoIBGE           := IntToStr(LJsonObject.AsInteger['codigo_municipio_ibge']);
        FResposta.UF                   := LJsonObject.AsString['uf'];
        FResposta.Situacao             := LJsonObject.AsString['descricao_situacao_cadastral'];
        FResposta.SituacaoEspecial     := LJsonObject.AsString['situacao_especial'];
        FResposta.DataSituacao         := StringToDateTimeDef(LJsonObject.AsString['data_situacao_cadastral'],0,'yyyy/mm/dd');
        FResposta.DataSituacaoEspecial := StringToDateTimeDef(LJsonObject.AsString['data_situacao_especial'],0,'yyyy/mm/dd');
        FResposta.NaturezaJuridica     := IntToStr(LJsonObject.AsInteger['codigo_natureza_juridica']);
        FResposta.EndEletronico        := LJsonObject.AsString['email'];
        FResposta.Telefone             := LJsonObject.AsString['ddd_telefone_1'];
        FResposta.EFR                  := '';
        FResposta.CapitalSocial        := LJsonObject.AsFloat['capital_social'];

        FResposta.Simples              := LJsonObject.AsBoolean['opcao_pelo_simples'];
        FResposta.DataOpcaoSimples     := StringToDateTimeDef(LJsonObject.AsString['data_opcao_pelo_simples'],0,'yyyy/mm/dd');
        FResposta.DataExclusaoSimples  := StringToDateTimeDef(LJsonObject.AsString['data_exclusao_do_simples'],0,'yyyy/mm/dd');
        FResposta.Mei                  := LJsonObject.AsBoolean['opcao_pelo_mei'];
        FResposta.DataOpcaoMei         := StringToDateTimeDef(LJsonObject.AsString['data_opcao_pelo_mei'],0,'yyyy/mm/dd');
        FResposta.DataExclusaoMei      := StringToDateTimeDef(LJsonObject.AsString['data_exclusao_do_mei'],0,'yyyy/mm/dd');

        FResposta.MotivoSituacaoCad    := LJsonObject.AsString['descricao_motivo_situacao_cadastral'];

        Result := True;
      end else
      begin
        if (Trim(LJsonObject.AsString['message']) <> '') then
          raise EACBrConsultaCNPJWSException.Create('Erro:'+IntToStr(LResultCode) + ' - ' +LJsonObject.AsString['message']);
      end;
    end;
    if (LResultCode > 299) then
      raise EACBrConsultaCNPJWSException.Create('Erro:'+IntToStr(LResultCode) + ' - ' +ResultString);
  finally
    LJSon.Free;
  end;
end;

end.
