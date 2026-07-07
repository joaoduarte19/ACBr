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

unit ACBrNFAg.ValidarRegrasdeNegocio;

interface

uses
  Classes, SysUtils,
  ACBrNFAg.Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAg.Conversao;

type
  { TNFAgValidarRegras }

  TNFAgValidarRegras = class
  private
    FpLog: string;

    FNFAg: TNFAg;
    FVersaoDF: TVersaoNFAg;
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
    constructor Create(AOwner: TNFAg); reintroduce;

    function Validar(Agora: TDateTime): Boolean;

    property NFAg: TNFAg read FNFAg write FNFAg;
    property VersaoDF: TVersaoNFAg read FVersaoDF write FVersaoDF;
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

{ TNFAgValidarRegras }

constructor TNFAgValidarRegras.Create(AOwner: TNFAg);
begin
  inherited Create;

  FNFAg := AOwner;
end;

procedure TNFAgValidarRegras.GravaLog(const AString: string);
begin
  FpLog := FpLog + FormatDateTime('hh:nn:ss:zzz', Now) + ' - ' + AString + sLineBreak;
end;

procedure TNFAgValidarRegras.AdicionaErro(const Erro: string);
begin
  FErros := FErros + Erro + sLineBreak;
end;

procedure TNFAgValidarRegras.ValidacoesGerais;
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

procedure TNFAgValidarRegras.ValidacoesDoEmitente;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDoDestinatario;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDosItens;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDosTributos;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDeComprasGovernamentais;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDosTotais;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDaFatura;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDaAgencia;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDosAutorizadosAoXML;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDoQRCode;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesDoResponsavelTecnico;
begin
  // Implementar a validação de todas as regras
end;

procedure TNFAgValidarRegras.ValidacoesAdicionais;
begin
  // Implementar a validação de todas as regras
end;

function TNFAgValidarRegras.Validar(Agora: TDateTime): Boolean;
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
                     IntToStr(NFAg.Ide.nNF) + sLineBreak + FErros);
  end;

  GravaLog('Fim da Validação. Tempo: ' +
           FormatDateTime('hh:nn:ss:zzz', Now - Agora) + sLineBreak +
           'Erros:' + FErros);
end;

function TNFAgValidarRegras.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: word;
  chaveNFAg : String;
begin
  DecodeDate(NFAg.ide.dhEmi, wAno, wMes, wDia);

  chaveNFAg := RemoverLiteralChave(NFAg.infNFAg.ID);

  Result := not
    ((Copy(chaveNFAg, 1, 2) <> IntToStrZero(NFAg.Ide.cUF, 2)) or
    (Copy(chaveNFAg, 3, 2)  <> Copy(FormatFloat('0000', wAno), 3, 2)) or
    (Copy(chaveNFAg, 5, 2)  <> FormatFloat('00', wMes)) or
    (Copy(chaveNFAg, 7, 14) <> PadLeft(OnlyCPFCNPJAlphaNum(NFAg.Emit.CNPJ), 14, '0')) or
    (Copy(chaveNFAg, 21, 2) <> IntToStrZero(NFAg.Ide.modelo, 2)) or
    (Copy(chaveNFAg, 23, 3) <> IntToStrZero(NFAg.Ide.serie, 3)) or
    (Copy(chaveNFAg, 26, 9) <> IntToStrZero(NFAg.Ide.nNF, 9)) or
    (Copy(chaveNFAg, 35, 1) <> TipoEmissaoToStr(NFAg.Ide.tpEmis)) or
    (Copy(chaveNFAg, 36, 1) <> SiteAutorizadorToStr(NFAg.Ide.nSiteAutoriz)) or
    (Copy(chaveNFAg, 37, 7) <> IntToStrZero(NFAg.Ide.cNF, 7)));
end;

procedure TNFAgValidarRegras.ValidarRegra226;
begin
  GravaLog('Validar 226-UF');
  if copy(IntToStr(NFAg.Emit.EnderEmit.cMun), 1, 2) <> IntToStr(CodigoUF) then
    AdicionaErro('226-Rejeição: Código da UF do Emitente diverge da UF autorizadora');
end;

procedure TNFAgValidarRegras.ValidarRegra227;
begin
  GravaLog('Validar: 227-Chave de acesso');
  if not ValidarConcatChave then
    AdicionaErro('227-Rejeição: Chave de Acesso do Campo Id difere da concatenação dos campos correspondentes');
end;

procedure TNFAgValidarRegras.ValidarRegra247;
begin
  GravaLog('Validar 247-UF');
  if NFAg.Emit.EnderEmit.UF <> UF then
    AdicionaErro('247-Rejeição: Sigla da UF do Emitente difere da UF do Web Service');
end;

procedure TNFAgValidarRegras.ValidarRegra252;
begin
  GravaLog('Validar: 252-Ambiente');
  if (NFAg.Ide.tpAmb <> Ambiente) then
    AdicionaErro('252-Rejeição: Tipo do ambiente do MDF-e difere do ambiente do Web Service');
end;

end.
