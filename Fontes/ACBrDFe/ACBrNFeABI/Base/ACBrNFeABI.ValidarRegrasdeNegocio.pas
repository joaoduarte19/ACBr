{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit ACBrNFeABI.ValidarRegrasdeNegocio;

interface

uses
  Classes, SysUtils,
  ACBrNFeABI.Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFeABI.Conversao;

type
  { TNFeABIValidarRegras }

  TNFeABIValidarRegras = class
  private
    FpLog: string;

    FNFeABI: TNFeABI;
    FVersaoDF: TVersaoNFeABI;
    FAmbiente: TACBrTipoAmbiente;
    FtpEmis: Integer;
    FCodigoUF: Integer;
    FUF: string;
    FErros: string;

    function ValidarConcatChave: Boolean;

    procedure ValidarRegra226;
    procedure ValidarRegra227;
    procedure ValidarRegra247;
    procedure ValidarRegra252;

    procedure ValidacoesGerais;
    procedure ValidacoesDoEmitente;
    procedure ValidacoesDoDestinatario;
    procedure ValidacoesDosItens;
    procedure ValidacoesDosTributos;
    procedure ValidacoesDeComprasGovernamentais;
    procedure ValidacoesDosTotais;
    procedure ValidacoesDaFatura;
    procedure ValidacoesDaAgencia;
    procedure ValidacoesDosAutorizadosAoXML;
    procedure ValidacoesDoQRCode;
    procedure ValidacoesDoResponsavelTecnico;
    procedure ValidacoesAdicionais;

    procedure GravaLog(const AString: string);
    procedure AdicionaErro(const Erro: string);

  public
    constructor Create(AOwner: TNFeABI); reintroduce;

    function Validar(Agora: TDateTime): Boolean;

    property NFeABI: TNFeABI read FNFeABI write FNFeABI;
    property VersaoDF: TVersaoNFeABI read FVersaoDF write FVersaoDF;
    property Ambiente: TACBrTipoAmbiente read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
    property CodigoUF: Integer read FCodigoUF write FCodigoUF;
    property UF: string read FUF write FUF;
    property Erros: string read FErros write FErros;
  end;

implementation

uses
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.Strings;

{ TNFeABIValidarRegras }

constructor TNFeABIValidarRegras.Create(AOwner: TNFeABI);
begin
  inherited Create;

  FNFeABI := AOwner;
end;

procedure TNFeABIValidarRegras.GravaLog(const AString: string);
begin
  FpLog := FpLog + FormatDateTime('hh:nn:ss:zzz', Now) + ' - ' + AString + sLineBreak;
end;

procedure TNFeABIValidarRegras.AdicionaErro(const Erro: string);
begin
  FErros := FErros + Erro + sLineBreak;
end;

procedure TNFeABIValidarRegras.ValidacoesGerais;
begin
  // Implementar a validação de todas as regras
  ValidarRegra226;
  ValidarRegra227;
  ValidarRegra247;
  ValidarRegra252;
//  ValidarRegra253;
//  ValidarRegra415;
//  ValidarRegra416;
//  ValidarRegra417;
//  ValidarRegra418;
//  ValidarRegra419;
//  ValidarRegra421;
end;

procedure TNFeABIValidarRegras.ValidacoesDoEmitente;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDoDestinatario;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDosItens;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDosTributos;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDeComprasGovernamentais;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDosTotais;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDaFatura;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDaAgencia;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDosAutorizadosAoXML;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDoQRCode;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesDoResponsavelTecnico;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFeABIValidarRegras.ValidacoesAdicionais;
begin
  // Implementar a validação de todas as regras
end;

function TNFeABIValidarRegras.Validar(Agora: TDateTime): Boolean;
begin
  GravaLog('Inicio da Validação');

  FErros := '';

  ValidacoesGerais;
  ValidacoesDoEmitente;
  ValidacoesDoDestinatario;
  ValidacoesDosItens;
  ValidacoesDosTributos;
  ValidacoesDeComprasGovernamentais;
  ValidacoesDosTotais;
  ValidacoesDaFatura;
  ValidacoesDaAgencia;
  ValidacoesDosAutorizadosAoXML;
  ValidacoesDoQRCode;
  ValidacoesDoResponsavelTecnico;
  ValidacoesAdicionais;

  Result := EstaVazio(FErros);

  if not Result then
  begin
    FErros := ACBrStr('Erro(s) nas Regras de negócios do Manifesto: ' +
                     IntToStr(NFeABI.Ide.nNF) + sLineBreak + FErros);
  end;

  GravaLog('Fim da Validação. Tempo: ' +
           FormatDateTime('hh:nn:ss:zzz', Now - Agora) + sLineBreak +
           'Erros:' + FErros);
end;

function TNFeABIValidarRegras.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: word;
  chaveNFeABI : String;
begin
  DecodeDate(NFeABI.ide.dhEmi, wAno, wMes, wDia);

  chaveNFeABI := RemoverLiteralChave(NFeABI.infNFeABI.ID);

  Result := not
    ((Copy(chaveNFeABI, 1, 2) <> IntToStrZero(NFeABI.Ide.cUF, 2)) or
    (Copy(chaveNFeABI, 3, 2)  <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(chaveNFeABI, 5, 2)  <> FormatFloat('00', wMes)) or
    (Copy(chaveNFeABI, 7, 14) <> PadLeft(OnlyCPFCNPJAlphaNum(NFeABI.Emit.CNPJCPF), 14, '0')) or
    (Copy(chaveNFeABI, 21, 2) <> IntToStrZero(NFeABI.Ide.modelo, 2)) or
    (Copy(chaveNFeABI, 23, 3) <> IntToStrZero(NFeABI.Ide.serie, 3)) or
    (Copy(chaveNFeABI, 26, 9) <> IntToStrZero(NFeABI.Ide.nNF, 9)) or
    (Copy(chaveNFeABI, 35, 1) <> TipoEmissaoToStr(NFeABI.Ide.tpEmis)) or
    (Copy(chaveNFeABI, 36, 1) <> SiteAutorizadorToStr(NFeABI.Ide.nSiteAutoriz)) or
    (Copy(chaveNFeABI, 37, 7) <> IntToStrZero(NFeABI.Ide.cNF, 7)));
end;

procedure TNFeABIValidarRegras.ValidarRegra226;
begin
  GravaLog('Validar 226-UF');
  if copy(IntToStr(NFeABI.Emit.EnderEmit.cMun), 1, 2) <> IntToStr(CodigoUF) then
    AdicionaErro('226-Rejeição: Código da UF do Emitente diverge da UF autorizadora');
end;

procedure TNFeABIValidarRegras.ValidarRegra227;
begin
  GravaLog('Validar: 227-Chave de acesso');
  if not ValidarConcatChave then
    AdicionaErro('227-Rejeição: Chave de Acesso do Campo Id difere da concatenação dos campos correspondentes');
end;

procedure TNFeABIValidarRegras.ValidarRegra247;
begin
  GravaLog('Validar 247-UF');
  if NFeABI.Emit.EnderEmit.UF <> UF then
    AdicionaErro('247-Rejeição: Sigla da UF do Emitente difere da UF do Web Service');
end;

procedure TNFeABIValidarRegras.ValidarRegra252;
begin
  GravaLog('Validar: 252-Ambiente');
  if (NFeABI.Ide.tpAmb <> Ambiente) then
    AdicionaErro('252-Rejeição: Tipo do ambiente do MDF-e difere do ambiente do Web Service');
end;

end.
