{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Victor H Gonzales - Pandaaa                     }
{                              André Luis - Minf Informática                   }
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
unit ACBrConsultaCNPJ.WS.CNPJWS;

interface
uses
  ACBrConsultaCNPJ.WS,
  SysUtils;

type
  EACBrConsultaCNPJWSException = class ( Exception );

  { TACBrConsultaCNPJWS }
  TACBrConsultaCNPJWSCNPJWS = class(TACBrConsultaCNPJWS)
    public
      function Executar:boolean; override;
  end;
const
  C_URL_PUBLICA   = 'https://publica.cnpj.ws/cnpj/';
  C_URL_COMERCIAL = 'https://comercial.cnpj.ws/cnpj/';

implementation

uses
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrJSON;

{ TACBrConsultaCNPJWS }

function TACBrConsultaCNPJWSCNPJWS.Executar: boolean;
var
  LJson, LJsonObject : TACBrJSONObject;
  LJsonArray: TACBrJSONArray;
  LRetorno : String;
  I, LCodigoRetorno : Integer;
  LURL : String;
  LValor: String;
begin
  Result := False;

  inherited Executar;

  ClearHeaderParams;
  if FUsuario <> '' then
  begin
    AddHeaderParam('x_api_token', FUsuario);
    LURL := C_URL_COMERCIAL;
  end else
    LURL := C_URL_PUBLICA;

  LCodigoRetorno := SendHttp('GET', LURL +  OnlyAlphaNum(FCNPJ), LRetorno);

  LJson := TACBrJSONObject.Parse( UTF8ToNativeString(LRetorno) );
  try
    if (LJson.AsString['status'] = '') and (LCodigoRetorno < 299) then
    begin
      FResposta.RazaoSocial       := LJson.AsString['razao_social'];
      FResposta.Porte             := LJson.AsJSONObject['porte'].AsString['descricao'];
      FResposta.NaturezaJuridica  := LJson.AsJSONObject['natureza_juridica'].AsString['descricao'];

      LJsonObject := LJson.AsJSONObject['estabelecimento'];
      FResposta.CNPJ           := LJsonObject.AsString['cnpj'];
      FResposta.Fantasia       := LJsonObject.AsString['nome_fantasia'];
      FResposta.Abertura       := StringToDateTimeDef(LJsonObject.AsString['data_inicio_atividade'],0,'yyyy/mm/dd');

      FResposta.Endereco       := LJsonObject.AsString['logradouro'];
      LValor := Trim(LJsonObject.AsString['tipo_logradouro']);
      if LValor <> '' then
      begin
        if AnsiUpperCase(Copy(FResposta.Endereco, 1, Length(LValor))) <> AnsiUpperCase(LValor) then
          FResposta.Endereco := LValor + ' ' + FResposta.Endereco;
      end;

      FResposta.Numero         := LJsonObject.AsString['numero'];
      FResposta.Complemento    := LJsonObject.AsString['complemento'];
      FResposta.CEP            := OnlyNumber( LJsonObject.AsString['cep']);
      FResposta.Bairro         := LJsonObject.AsString['bairro'];
      FResposta.UF             := LJsonObject.AsString['uf'];
      FResposta.EndEletronico  := LJsonObject.AsString['email'];
      FResposta.Telefone       := LJsonObject.AsString['ddd1'] + LJsonObject.AsString['telefone1'];
      FResposta.Situacao       := LJsonObject.AsString['situacao_cadastral'];
      FResposta.DataSituacao   := StringToDateTimeDef(LJsonObject.AsString['data_situacao_cadastral'],0,'yyyy/mm/dd');
      FResposta.EmpresaTipo    := LJsonObject.AsString['tipo'];
      FResposta.SituacaoEspecial     := LJsonObject.AsString['situacao_especial'];
      FResposta.DataSituacaoEspecial := StringToDateTimeDef(LJsonObject.AsString['data_situacao_especial'],0,'yyyy/mm/dd');
      FResposta.Cidade               := LJsonObject.AsJSONObject['cidade'].AsString['nome'];
      FResposta.UF                   := LJsonObject.AsJSONObject['estado'].AsString['sigla'];
      FResposta.CodigoIBGE     := LJsonObject.AsJSONObject['cidade'].AsString['ibge_id'];

      FResposta.EFR                  := '';
      FResposta.CapitalSocial        := StrToFloatDef(StringReplace(LJson.AsString['capital_social'],'.',',',[rfReplaceAll]),0);

      FResposta.Simples              := LJson.AsJSONObject['simples'].AsString['simples'] = 'Sim';
      FResposta.DataOpcaoSimples     := StringToDateTimeDef(LJson.AsJSONObject['simples'].AsString['data_opcao_simples'],0,'yyyy/mm/dd');
      FResposta.DataExclusaoSimples  := StringToDateTimeDef(LJson.AsJSONObject['simples'].AsString['data_exclusao_simples'],0,'yyyy/mm/dd');
      FResposta.Mei                  := LJson.AsJSONObject['simples'].AsString['mei']= 'Sim';
      FResposta.DataOpcaoMei         := StringToDateTimeDef(LJson.AsJSONObject['simples'].AsString['data_opcao_mei'],0,'yyyy/mm/dd');
      FResposta.DataExclusaoMei      := StringToDateTimeDef(LJson.AsJSONObject['simples'].AsString['data_exclusao_mei'],0,'yyyy/mm/dd');

      FResposta.CNAE1 := LJsonObject.AsJSONObject['atividade_principal'].AsString['id'] + ' ' +
                         LJsonObject.AsJSONObject['atividade_principal'].AsString['descricao'];

      LJsonArray := LJsonObject.AsJSONArray['atividades_secundarias'];
      for I := 0 to Pred(LJsonArray.Count) do
        FResposta.CNAE2.Add(LJsonArray.ItemAsJSONObject[I].AsString['id'] + ' ' +
                            LJsonArray.ItemAsJSONObject[I].AsString['descricao']);

      LJsonArray := LJsonObject.AsJSONArray['inscricoes_estaduais'];
      for I := 0 to Pred(LJsonArray.Count) do
         if (LJsonArray.ItemAsJSONObject[I].AsBoolean['ativo']) and
            (LJsonArray.ItemAsJSONObject[I].AsJSONObject['estado'].AsString['sigla'] = LJsonObject.AsJSONObject['estado'].AsString['sigla']) then
            FResposta.InscricaoEstadual := LJsonArray.ItemAsJSONObject[I].AsString['inscricao_estadual'];

      LJsonObject := LJson.AsJSONObject['motivo_situacao_cadastral'];
      if LJson.IsJSONObject('motivo_situacao_cadastral' ) then
         FResposta.MotivoSituacaoCad := LJsonObject.AsString['id'] + ' ' + LJsonObject.AsString['descricao'];

      LJsonArray := LJson.AsJSONArray['socios'];
      SetLength(FResposta.QSA,LJsonArray.Count);
      for I := 0 to Pred(LJsonArray.Count) do
      begin
        FResposta.QSA[I].Codigo                    := TACBrJSONObject(LJsonArray.ItemAsJSONObject[I].AsJSONObject['qualificacao_socio']).AsString['id'];
        FResposta.QSA[I].Nome                      := LJsonArray.ItemAsJSONObject[I].AsString['nome'];
        FResposta.QSA[I].Qualificacao              := TACBrJSONObject(LJsonArray.ItemAsJSONObject[I].AsJSONObject['qualificacao_socio']).AsString['descricao'];
        FResposta.QSA[I].Representante             := LJsonArray.ItemAsJSONObject[I].AsString['nome_representante'];
        FResposta.QSA[I].CodigoRepresentante       := TACBrJSONObject(LJsonArray.ItemAsJSONObject[I].AsJSONObject['qualificacao_representante']).AsString['id'];
        FResposta.QSA[I].QualificacaoRepresentante := TACBrJSONObject(LJsonArray.ItemAsJSONObject[I].AsJSONObject['qualificacao_representante']).AsString['descricao'];
      end;

      Result := true;
    end else
    begin
      if (Trim(LJSon.AsString['titulo']) <> '') or (LCodigoRetorno > 299) then
        raise EACBrConsultaCNPJWSException.Create('Erro: '+LJSon.AsString['status'] + ' - ' +LJSon.AsString['detalhes'] + 'Código:' + IntToStr(LCodigoRetorno) + ' - '+ ResultString);
    end;
  finally
    LJSon.Free;
  end;
end;

end.
