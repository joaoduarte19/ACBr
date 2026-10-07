{*******************************************************************************}
{ Projeto: ACBrMonitor                                                          }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para  }
{ criar uma interface de comunicação com equipamentos de automacao comercial.   }
{                                                                               }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida                }
{                                                                               }
{ Colaboradores nesse arquivo: Renato Rubinho                                   }
{                                                                               }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr       }
{                                                                               }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la  }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela   }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério)  }
{ qualquer versão posterior.                                                    }
{                                                                               }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU       }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)               }
{                                                                               }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,   }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.           }
{ Você também pode obter uma copia da licença em:                               }
{ http://www.opensource.org/licenses/gpl-license.php                            }
{                                                                               }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br }
{        Rua Cel.Aureliano de Camargo, 963 - Tatuí - SP - 18270-170             }
{                                                                               }
{*******************************************************************************}
{$I ACBr.inc}

unit DoACBrCIOTUnit;

interface

uses
  Classes, SysUtils, DateUtils,
  ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.Strings,
  ACBrLibResposta, ACBrLibCIOTRespostas,
  ACBrCIOT, ACBrCIOTContratos,
  ACBrMonitorConfig, ACBrLibConfig,
  ACBrMonitorConsts, ACBrDFeUtil,
  DoACBrUnit, CmdUnit;

type

{ TACBrObjetoCIOT }

TACBrObjetoCIOT = class(TACBrObjetoDFe)
private
  fACBrCIOT: TACBrCIOT;
public
  constructor Create(AConfig: TMonitorConfig; ACBrCIOT: TACBrCIOT); reintroduce;
  procedure Executar(ACmd: TACBrCmd); override;

  procedure TratarRetorno;

  property ACBrCIOT: TACBrCIOT read fACBrCIOT;
end;

{ TMetodoEnviarCIOT }
TMetodoEnviarCIOT = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoSetTokenCIOT }
TMetodoSetTokenCIOT = class(TACBrMetodo)
public
  procedure Executar; override;
end;

implementation

uses
  ACBrMonitor1;

{ TACBrObjetoCIOT }

constructor TACBrObjetoCIOT.Create(AConfig: TMonitorConfig; ACBrCIOT: TACBrCIOT);
begin
  inherited Create(AConfig);

  fACBrCIOT := ACBrCIOT;

  ListaDeMetodos.Add(CMetodoEnviar);
  ListaDeMetodos.Add(CMetodoSetToken);
end;

procedure TACBrObjetoCIOT.Executar(ACmd: TACBrCmd);
var
  AMetodoClass: TACBrMetodoClass;
  CmdNum: Integer;
  Ametodo: TACBrMetodo;
  AACBrUnit: TACBrObjetoACBr;
begin
  inherited Executar(ACmd);

  CmdNum := ListaDeMetodos.IndexOf(LowerCase(ACmd.Metodo));
  AMetodoClass := Nil;

  case CmdNum of
    0  : AMetodoClass := TMetodoEnviarCIOT;
    1  : AMetodoClass := TMetodoSetTokenCIOT;
  else
    begin
      AACBrUnit := TACBrObjetoACBr.Create(nil); //Instancia DoACBrUnit para validar método para todos os objetos
      try
        AACBrUnit.Executar(ACmd);
      finally
        AACBrUnit.Free;
      end;
    end;
  end;

  if Assigned(AMetodoClass) then
  begin
    Ametodo := AMetodoClass.Create(ACmd, Self);
    try
      Ametodo.Executar;
    finally
      Ametodo.Free;
    end;
  end;
end;

procedure TACBrObjetoCIOT.TratarRetorno;
var
  RespEnvio: TEnvioResposta;
begin
  RespEnvio := TEnvioResposta.Create(TpResp, codUTF8);
  try
    RespEnvio.Processar(fACBrCIOT);

    if RespEnvio.Token <> '' then
    begin
      FrmACBrMonitor.edtTokenCIOT.Text := RespEnvio.Token;

      with MonitorConfig.DFe.CIOT do
        Token := RespEnvio.Token;

      MonitorConfig.SalvarArquivo;
    end;

    fpCmd.Resposta := fpCmd.Resposta + sLineBreak;
    fpCmd.Resposta := fpCmd.Resposta + RespEnvio.Gerar;
  finally
    RespEnvio.Free;
  end;
end;

{ TMetodoEnviarCIOT }

{ Params: 0 - PathOrINI - Uma String com um Path completo arquivo INI do CIOT
                          ou Uma String com conteúdo INI do CIOT
}
procedure TMetodoEnviarCIOT.Executar;
var
  I: integer;
  LPathOrINI: String;
  LObjetoCIOT: TACBrObjetoCIOT;
  LCIOT: TACBrCIOT;
begin
  LPathOrINI := fpCmd.Params(0);

  if EstaVazio(LPathOrINI) then
    raise Exception.Create('Parâmetro "PathOrINI" não informado');

  LObjetoCIOT := TACBrObjetoCIOT(fpObjetoDono);
  LCIOT := LObjetoCIOT.ACBrCIOT;

  LCIOT.Contratos.Clear;

  if not LCIOT.Contratos.LoadFromIni(LPathOrINI) then
    raise Exception.Create('Não foi possível carregar o CIOT a partir do INI informado');

  if LCIOT.Contratos.Count <= 0 then
    raise Exception.Create('Nenhum registro carregado a partir do INI informado');

  if FrmACBrMonitor.edtTokenCIOT.Text <> '' then
  begin
    for I:=0 to LCIOT.Contratos.Count - 1 do
      LCIOT.Contratos.Items[I].CIOT.Integradora.Token := FrmACBrMonitor.edtTokenCIOT.Text;
  end;

  try
    LCIOT.Enviar;
  except
    on E: Exception do
    begin
      if (Pos('DadosPFX, ArquivoPFX, URLPFX ou NumeroSerie', E.Message) > 0) and
         (not LCIOT.SSL.UseCertificateHTTP) then
        raise Exception.Create('Preencha o CNPJ do emitente nas configurações do CIOT')
      else
        raise;
    end;
  end;

  LObjetoCIOT.TratarRetorno;
end;

{ TMetodoSetTokenCIOT }

{ Params: 0 - Token }
procedure TMetodoSetTokenCIOT.Executar;
var
  AToken: String;
begin
  AToken := fpCmd.Params(0);

  with TACBrObjetoCIOT(fpObjetoDono) do
  begin
    FrmACBrMonitor.edtTokenCIOT.Text := AToken;

    with MonitorConfig.DFe.CIOT do
      Token := AToken;

    MonitorConfig.SalvarArquivo;
  end;
end;

end.

