{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  Victor Hugo Gonzales - Panda                   }
{                               Leandro do Couto                               }
{                               Fernando Henrique                              }
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

unit ACBrBoletoRet_Sicredi_APIECOMM;

interface

uses
  Classes,
  SysUtils,
  ACBrBoleto,
  ACBrBoletoWS,
  ACBrBoletoRetorno,
  ACBrJSON,
  DateUtils,
  pcnConversao,
  ACBrUtil.DateTime,
  ACBrBoletoWS.Rest;

type

{ TRetornoEnvio_Sicredi_APIECOMM }

 TRetornoEnvio_Sicredi_APIECOMM = class(TRetornoEnvioREST)
 private
   function DateSicrediToDateTime(Const AValue : String) : TDateTime;
 public
   constructor Create(ABoletoWS: TACBrBoleto); override;
   destructor  Destroy; Override;
   function LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean; override;
   function LerListaRetorno: Boolean; override;
   function RetornoEnvio(const AIndex: Integer): Boolean; override;

 end;

implementation

uses
  ACBrBoletoConversao;

resourcestring
  C_LIQUIDADO = 'LIQUIDADO';
  C_BAIXADO_POS_SOLICITACAO = 'BAIXADO POR SOLICITACAO';

{ TRetornoEnvio }

constructor TRetornoEnvio_Sicredi_APIECOMM.Create(ABoletoWS: TACBrBoleto);
begin
  inherited Create(ABoletoWS);

end;

function TRetornoEnvio_Sicredi_APIECOMM.DateSicrediToDateTime(
  const AValue: String): TDateTime;
begin
  Result :=EncodeDataHora(StringReplace(AValue,'-','/',[rfReplaceAll]));
end;

destructor TRetornoEnvio_Sicredi_APIECOMM.Destroy;
begin
  inherited Destroy;
end;

function TRetornoEnvio_Sicredi_APIECOMM.LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean;
var
  LJsonObject: TACBrJsonObject;
  LJsonItem: TACBrJsonObject;
  LRejeicao: TACBrBoletoRejeicao;
  LJsonBoletos: TACBrJsonArray;
  LTipoOperacao: TOperacao;
  JsonStr: string;
  Ini, Fim: Integer;
begin
  Result := True;
  LTipoOperacao := ACBrBoleto.Configuracoes.WebService.Operacao;
  ARetornoWS.HTTPResultCode := HTTPResultCode;
  ARetornoWS.JSONEnvio      := EnvWs;
  ARetornoWS.Header.Operacao := LTipoOperacao;
  if RetWS <> '' then
  begin
    JsonStr := RetWS;

    if Pos('[', JsonStr) > 0 then
      JsonStr := Copy(JsonStr, Pos('[', JsonStr), MaxInt);

    if (Length(JsonStr) > 0) and (JsonStr[1] = '[') then
    begin
      Ini := Pos('{', JsonStr);
      Fim := LastDelimiter('}', JsonStr);

      if (Ini > 0) and (Fim > Ini) then
        JsonStr := Copy(JsonStr, Ini, Fim - Ini + 1);
    end;

    LJsonObject := TACBrJSONObject.Parse(JsonStr);
    try
      try
        ARetornoWS.JSON := LJsonObject.ToJSON;

        case HttpResultCode of
          400, 404:
          begin
            if LJsonObject.ValueExists('codigo') then
            begin
              LRejeicao := ARetornoWS.CriarRejeicaoLista;
              LRejeicao.Codigo   := LJsonObject.AsString['codigo'];
              LRejeicao.Versao   := LJsonObject.AsString['parametro'];
              LRejeicao.Mensagem := LJsonObject.AsString['mensagem'];
            end;
          end;
        end;

        if (ARetornoWS.ListaRejeicao.Count = 0) then
        begin
          if (LTipoOperacao = tpInclui) then
          begin
            ARetornoWS.DadosRet.IDBoleto.CodBarras :=
              LJsonObject.AsString['codigoBarra'];
            ARetornoWS.DadosRet.IDBoleto.LinhaDig :=
              LJsonObject.AsString['linhaDigitavel'];
            ARetornoWS.DadosRet.IDBoleto.NossoNum :=
              LJsonObject.AsString['nossoNumero'];

            ARetornoWS.DadosRet.TituloRet.CodBarras :=
              ARetornoWS.DadosRet.IDBoleto.CodBarras;
            ARetornoWS.DadosRet.TituloRet.LinhaDig :=
              ARetornoWS.DadosRet.IDBoleto.LinhaDig;
            ARetornoWS.DadosRet.TituloRet.NossoNumero :=
              ARetornoWS.DadosRet.IDBoleto.NossoNum;
          end
          else if (LTipoOperacao in [tpConsultaDetalhe, tpConsulta]) then
          begin
            JsonStr := LJsonObject.ToJSON;

            if (Length(JsonStr) > 0) and (JsonStr[1] <> '[') then
              JsonStr := '[' + JsonStr + ']';

            LJsonBoletos := TACBrJSONArray.Parse(JsonStr);
            try
              if (Assigned(LJsonBoletos)) and (LJsonBoletos.Count > 0) then
              begin
                LJsonItem := LJsonBoletos.ItemAsJSONObject[0];

                ARetornoWS.DadosRet.IDBoleto.CodBarras := '';
                ARetornoWS.DadosRet.IDBoleto.LinhaDig := '';
                ARetornoWS.DadosRet.IDBoleto.NossoNum :=
                  LJsonItem.AsString['nossoNumero'];

                ARetornoWS.indicadorContinuidade := False;

                ARetornoWS.DadosRet.TituloRet.CodBarras :=
                  ARetornoWS.DadosRet.IDBoleto.CodBarras;
                ARetornoWS.DadosRet.TituloRet.LinhaDig :=
                  ARetornoWS.DadosRet.IDBoleto.LinhaDig;

                ARetornoWS.DadosRet.TituloRet.NossoNumero :=
                  ARetornoWS.DadosRet.IDBoleto.NossoNum;
                ARetornoWS.DadosRet.TituloRet.Vencimento :=
                  DateSicrediToDateTime(LJsonItem.AsString['dataVencimento']);
                ARetornoWS.DadosRet.TituloRet.ValorDocumento :=
                  LJsonItem.AsFloat['valor'];
                ARetornoWS.DadosRet.TituloRet.ValorAtual :=
                  LJsonItem.AsFloat['valor'];
                ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca :=
                  LJsonItem.AsString['situacao'];
                ARetornoWS.DadosRet.TituloRet.SeuNumero :=
                  LJsonItem.AsString['seuNumero'];

                if (LJsonItem.AsString['situacao'] = C_LIQUIDADO) or
                   (LJsonItem.AsString['situacao'] = C_BAIXADO_POS_SOLICITACAO) then
                begin
                  ARetornoWS.DadosRet.TituloRet.ValorPago :=
                    LJsonItem.AsFloat['valorLiquidado'];
                  ARetornoWS.DadosRet.TituloRet.DataCredito :=
                    DateSicrediToDateTime(
                      LJsonItem.AsString['dataliquidacao']);
                end;
              end;
            finally
              if Assigned(LJsonBoletos) then
                FreeAndNil(LJsonBoletos);
            end;
          end;
        end;
      except
        Result := False;
      end;
    finally
      if Assigned(LJsonObject) then
        FreeAndNil(LJsonObject);
    end;
  end;
end;

function TRetornoEnvio_Sicredi_APIECOMM.LerListaRetorno: Boolean;
var
  ListaRetorno: TACBrBoletoRetornoWS;
  LJSonObject: TACBrJSONObject;
  LRejeicao: TACBrBoletoRejeicao;
  LJsonArrayBoletos: TACBrJSONArray;
  I: Integer;
begin
  Result := True;
  ListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;
  ListaRetorno.HTTPResultCode := HTTPResultCode;
  ListaRetorno.JSONEnvio      := EnvWs;
  if RetWS <> '' then
  begin
    LJSonObject := TACBrJSONObject.Parse(RetWS);
    try
      try
        ListaRetorno.JSON:= RetWS;
        case HTTPResultCode of
          400, 404 : begin
            if( LJSonObject.AsString['codigo'] <> '' ) then
            begin
              LRejeicao            := ListaRetorno.CriarRejeicaoLista;
              LRejeicao.Codigo     := LJSonObject.AsString['codigo'];
              LRejeicao.Versao     := LJSonObject.AsString['parametro'];
              LRejeicao.Mensagem   := LJSonObject.AsString['mensagem'];
            end;
          end;
        end;

        //retorna quando tiver sucesso
        if (ListaRetorno.ListaRejeicao.Count = 0) then
        begin
          LJsonArrayBoletos := TACBrJSONArray.Parse( LJSonObject.ToJSON );
          try
            for I := 0 to Pred(LJsonArrayBoletos.Count) do
            begin
              if I > 0 then
                ListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;

              LJSonObject  := LJsonArrayBoletos.ItemAsJSONObject[I];

              ListaRetorno.DadosRet.IDBoleto.CodBarras       := '';
              ListaRetorno.DadosRet.IDBoleto.LinhaDig        := '';
              ListaRetorno.DadosRet.IDBoleto.NossoNum        := LJSonObject.AsString['nossoNumero'];
              ListaRetorno.indicadorContinuidade             := false;
              ListaRetorno.DadosRet.TituloRet.CodBarras      := ListaRetorno.DadosRet.IDBoleto.CodBarras;
              ListaRetorno.DadosRet.TituloRet.LinhaDig       := ListaRetorno.DadosRet.IDBoleto.LinhaDig;


              ListaRetorno.DadosRet.TituloRet.NossoNumero                := ListaRetorno.DadosRet.IDBoleto.NossoNum;
              ListaRetorno.DadosRet.TituloRet.Vencimento                 := DateSicrediToDateTime(LJSonObject.AsString['dataVencimento']);
              ListaRetorno.DadosRet.TituloRet.ValorDocumento             := LJSonObject.AsFloat['valor'];
              ListaRetorno.DadosRet.TituloRet.ValorAtual                 := LJSonObject.AsFloat['valor'];

              ListaRetorno.DadosRet.TituloRet.DataRegistro               := DateSicrediToDateTime(LJSonObject.AsString['dataemissao']);
              ListaRetorno.DadosRet.TituloRet.EstadoTituloCobranca       := LJSonObject.AsString['situacao'];
              ListaRetorno.DadosRet.TituloRet.SeuNumero                  := LJSonObject.AsString['seuNumero'];

              if( LJSonObject.AsString['situacao'] = C_LIQUIDADO ) or
                 ( LJSonObject.AsString['situacao'] = C_BAIXADO_POS_SOLICITACAO ) then
              begin
                 ListaRetorno.DadosRet.TituloRet.ValorPago                  := LJSonObject.AsFloat['valorLiquidado'];
                 ListaRetorno.DadosRet.TituloRet.DataCredito                := DateSicrediToDateTime(LJSonObject.AsString['dataliquidacao']);
              end;

            end;
          finally
            LJsonArrayBoletos.Free;
          end;
        end;
      except
        Result := False;
      end;
    finally
      LJSonObject.Free;
    end;

  end;
end;

function TRetornoEnvio_Sicredi_APIECOMM.RetornoEnvio(const AIndex: Integer): Boolean;
begin
  Result := inherited RetornoEnvio(AIndex);
end;

end.

