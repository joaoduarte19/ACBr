{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeUtil;

interface

uses
  Classes, Forms, TypInfo, strutils,
  ACBrEAD,
  pcnConversao, pcnNFe;

var
  fsHashQRCode : TACBrEAD;

type
  NotaUtil = class
  private
  protected

  public
    class function ChaveAcesso(AUF:Integer; ADataEmissao:TDateTime; ACNPJ:String; ASerie:Integer;
                               ANumero,ACodigo: Integer; AModelo:Integer=55): String;
    class function IdentificaTipoSchema(Const AXML: AnsiString; var I: Integer): integer;
    class function GerarChaveContingencia(FNFe:TNFe): String;
    class function FormatarChaveContigencia(AValue: String): String;
    class function GetURLConsultaNFCe(const AUF : Integer; AAmbiente : TpcnTipoAmbiente) : String;
    class function GetURLQRCode(const AUF : Integer;  AAmbiente : TpcnTipoAmbiente;
                                AchNFe, AcDest: String;
                                AdhEmi: TDateTime;
                                AvNF, AvICMS: Currency;
                                AdigVal, AidToken, AToken: String) : String;
    class function CstatProcessado(AValue: Integer): Boolean;                                
  end;

implementation

uses
  sysutils, ACBrUtil, ACBrDFeUtil, ACBrConsts, ACBrNFe, pcnAuxiliar;

{ NotaUtil }

class function NotaUtil.ChaveAcesso(AUF: Integer; ADataEmissao: TDateTime;
  ACNPJ: String; ASerie, ANumero, ACodigo: Integer; AModelo: Integer): String;
var
  vUF, vDataEmissao, vSerie, vNumero,
  vCodigo, vModelo: String;
begin
  vUF          := DFeUtil.Poem_Zeros(AUF, 2);
  vDataEmissao := FormatDateTime('YYMM', ADataEmissao);
  vModelo      := DFeUtil.Poem_Zeros(AModelo, 2);
  vSerie       := DFeUtil.Poem_Zeros(ASerie, 3);
  vNumero      := DFeUtil.Poem_Zeros(ANumero, 9);
  vCodigo      := DFeUtil.Poem_Zeros(ACodigo, 9);

  Result := vUF+vDataEmissao+ACNPJ+vModelo+vSerie+vNumero+vCodigo;
  Result := Result+DFeUtil.Modulo11(Result);
end;

////class function NotaUtil.ExtraiCNPJChaveAcesso(AChaveNFE: String): String;
////begin
////  AChaveNFE := OnlyNumber(AChaveNFE);
////  if ValidarChave('NFe'+AChaveNFe) then
////     Result := copy(AChaveNFE,7,14)
////  else
////     Result := '';
////end;

////class function NotaUtil.ExtraiModeloChaveAcesso(AChaveNFE: String): String;
////begin
////  AChaveNFE := OnlyNumber(AChaveNFE);
////  if ValidarChave('NFe'+AChaveNFe) then
////     Result := copy(AChaveNFE,21,2)
////  else
////     Result := '';
////end;

////class function NotaUtil.StringToDateTime(const AString: string): TDateTime;
////begin
////  if (AString = '0') or (AString = '') then
////     Result := 0
////  else
////     Result := StrToDateTime(AString);
////end;

////class function NotaUtil.FormatarChaveAcesso(AValue: String): String;
////begin
////  AValue := DFeUtil.LimpaNumero(AValue);
////
////  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
////            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
////            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
////            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
////            copy(AValue,33,4) + ' ' + copy(AValue,37,4) + ' ' +
////            copy(AValue,41,4) ;
////end;

class function NotaUtil.GetURL(const AUF, AAmbiente, FormaEmissao : Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
//  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

case FormaEmissao of
  1,2,4,5,9 : begin
       case ALayOut of
         LayNfeEnvDPEC      : Result := ifThen(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx',          'https://hom.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx');
         LayNfeConsultaDPEC : Result := ifThen(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx',          'https://hom.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx');
         LayNFeEventoAN     : Result := ifThen(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',          'https://hom.nfe.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx ');
         LayNfeConsNFeDest  : Result := ifThen(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/NFeConsultaDest/NFeConsultaDest.asmx',        'https://hom.nfe.fazenda.gov.br/NFeConsultaDest/NFeConsultaDest.asmx');
         LayNfeDownloadNFe  : Result := ifThen(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/NfeDownloadNF/NfeDownloadNF.asmx',            'https://hom.nfe.fazenda.gov.br/NfeDownloadNF/NfeDownloadNF.asmx');
         LayDistDFeInt      : Result := ifThen(AAmbiente=1, 'https://www1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx', 'https://hom.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx');
       end;

       // Alguns Estados Brasiseiros deixaram de autorizar as NF-e no SEFAZ Virtual do Ambiente Nacional
       // e passaram a utilizar o SEFAZ Virtual do Rio Grande do Sul, são eles:
       // Inicio     - Estado
       // ----------   -------------------
       // 03/09/2009 - Rondônia
       // 04/10/2009 - Distrito Federal
       // 06/05/2013 - Rio Grande do Norte
       // 04/02/2014 - Espirito Santo

       case AUF of
         12: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AC
         27: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AL
         16: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //AP
         13: Result := NotaUtil.GetURLAM(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //AM
         29: Result := NotaUtil.GetURLBA(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //BA
         23: Result := NotaUtil.GetURLCE(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //CE
         53: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //DF

//         32: Result := NotaUtil.GetURLSVAN(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //ES
//         32: Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //ES
         32: Result := NotaUtil.GetURLES(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //ES

         52: Result := NotaUtil.GetURLGO(AAmbiente, ALayOut, AModeloDF, AVersaoDF);   //GO

//         21: Result := NotaUtil.GetURLSVAN(AAmbiente, ALayOut, AModeloDF, AVersaoDF); //MA
         21: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //MA
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //MA
             end;
         51: Result := NotaUtil.GetURLMT(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MT
         50: Result := NotaUtil.GetURLMS(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MS
         31: Result := NotaUtil.GetURLMG(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //MG
//         15: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PA
         15: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //PA
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PA
             end;
         25: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PB
         41: Result := NotaUtil.GetURLPR(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //PR
         26: Result := NotaUtil.GetURLPE(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //PE
         22: begin
               if AModeloDF = moNFCe then
                 Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF)  //PI
               else
                 Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //PI
             end;
         33: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RJ
         24: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RN
         43: Result := NotaUtil.GetURLRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //RS
         11: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RO
         14: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //RR
         42: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //SC
         35: Result := NotaUtil.GetURLSP(AAmbiente,ALayOut, AModeloDF, AVersaoDF);   //SP
         28: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //SE
         17: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut, AModeloDF, AVersaoDF); //TO
       end;
      end;
  3 : begin
       case ALayOut of
         LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.nfe.fazenda.gov.br/SCAN/NfeRecepcao2/NfeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx',     'https://hom.nfe.fazenda.gov.br/SCAN/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeCancelamento2/NfeCancelamento2.asmx',   'https://hom.nfe.fazenda.gov.br/SCAN/NfeCancelamento2/NfeCancelamento2.asmx');
         LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx',   'https://hom.nfe.fazenda.gov.br/SCAN/NfeInutilizacao2/NfeInutilizacao2.asmx');
         LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx',           'https://hom.nfe.fazenda.gov.br/SCAN/NfeConsulta2/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NFeStatusServico2/NFeStatusServico2.asmx', 'https://hom.nfe.fazenda.gov.br/SCAN/NfeStatusServico2/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.nfe.fazenda.gov.br/SCAN/RecepcaoEvento/RecepcaoEvento.asmx');

         LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.nfe.fazenda.gov.br/SCAN/NfeAutorizacao/NfeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hom.nfe.fazenda.gov.br/SCAN/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
       end;
      end;
  6 : begin
       // SVC-AN SEFAZ VIRTUAL DE CONTINGENCIA - AMBIENTE NACIONAL
       // Utilizado pelas UF: AC, AL, AP, MG, PB, RJ, RS, RO, RR, SC, SE, SP, TO, DF
       case ALayOut of
         LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.svc.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx',     'https://hom.svc.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := ifThen(AAmbiente=1, '', '');
         LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx',   'https://hom.svc.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx');
         LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx',           'https://hom.svc.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx', 'https://hom.svc.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.svc.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx');

         LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.svc.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://www.svc.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hom.svc.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
       end;
      end;
  7 : begin
       // SVC-RS SEFAZ VIRTUAL DE CONTINGENCIA - RIO GRANDE DO SUL
       // Utilizado pelas UF: AM, BA, CE, ES, GO, MA, MT, MS, PA, PE, PI, PR, RN
       case ALayOut of
         LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
         LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',      'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
         LayNfeCancelamento   : Result := ifThen(AAmbiente=1, '', '');
         LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
         LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
         LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
         LayNFeCCe,
         LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

         LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
         LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
       end;
      end;
  end;
  if Result = '' then
     raise EACBrNFeException.Create('URL não disponível para o estado solicitado.');
end;

//AC,AL,AP,MA,PA,PB,PI,RJ,RN,RR,SC,SE,TO - Estados sem WebServices próprios
//Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul): AC, AL, AM, AP, MS, PB, RJ, RR, SC, SE e TO.
//Estados Emissores pela Sefaz Virtual AN (Ambiente Nacional): ES, MA, PA, PI, PR e RN.

class function NotaUtil.GetURLSVRS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',                    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',              'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',                    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',          'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://svp-ws.sefazvirtual.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro2.asmx', 'https://webservice.set.rn.gov.br/projetonfehomolog/set_nfe/servicos/CadConsultaCadastroWS.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',               'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',               'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx',         'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');

      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',    'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLSVAN(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx',           'https://hom.sefazvirtual.fazenda.gov.br/NfeRecepcao2/NfeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeRetRecepcao2/NFeRetRecepcao2.asmx',     'https://hom.sefazvirtual.fazenda.gov.br/NfeRetRecepcao2/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeCancelamento2/NFeCancelamento2.asmx',   'https://hom.sefazvirtual.fazenda.gov.br/NfeCancelamento2/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeInutilizacao2/NFeInutilizacao2.asmx',   'https://hom.sefazvirtual.fazenda.gov.br/NfeInutilizacao2/NfeInutilizacao2.asmx');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/nfeconsulta2/nfeconsulta2.asmx',           'https://hom.sefazvirtual.fazenda.gov.br/NfeConsulta2/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeStatusServico2/NFeStatusServico2.asmx', 'https://hom.sefazvirtual.fazenda.gov.br/NfeStatusServico2/NfeStatusServico2.asmx');
//      LayNfeCadastro       : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx',       'https://hom.sefazvirtual.fazenda.gov.br/RecepcaoEvento/RecepcaoEvento.asmx');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hom.sefazvirtual.fazenda.gov.br/NfeAutorizacao/NfeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://hom.sefazvirtual.fazenda.gov.br/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLAM(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRecepcao2',         'https://homnfe.sefaz.am.gov.br/services2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRetRecepcao2',      'https://homnfe.sefaz.am.gov.br/services2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeCancelamento2',     'https://homnfe.sefaz.am.gov.br/services2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeInutilizacao2',     'https://homnfe.sefaz.am.gov.br/services2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeConsulta2',         'https://homnfe.sefaz.am.gov.br/services2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeStatusServico2',    'https://homnfe.sefaz.am.gov.br/services2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/cadconsultacadastro2', 'https://homnfe.sefaz.am.gov.br/services2/services/cadconsultacadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/RecepcaoEvento',       'https://homnfe.sefaz.am.gov.br/services2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeAutorizacao',       'https://homnfe.sefaz.am.gov.br/services2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao',    'https://homnfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    (*
    case ALayOut of
      LayNfeRecepcao      : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2',      'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2');
      LayNfeRetRecepcao   : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2',   'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2');
      LayNfeInutilizacao  : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2',  'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2');
      LayNfeConsulta      : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2',      'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2');
      LayNfeStatusServico : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2', 'https://homnfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2');
      LayNFeCCe,
      LayNFeEvento        : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento',    'https://homnfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento');
    end;
    *)

    // Novos endereços disponibilizados para a NFC-e

    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRecepcao2',      'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeRecepcao2');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeRetRecepcao2',   'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeRetRecepcao2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeInutilizacao2',  'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeConsulta2',      'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/NfeStatusServico2', 'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/NfeStatusServico2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.am.gov.br/nfce-services/services/RecepcaoEvento',    'https://homnfce.sefaz.am.gov.br/nfce-services-nac/services/RecepcaoEvento');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLBA(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeRecepcao2.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeRecepcao2.asmx');
        LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeRetRecepcao2.asmx',      'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeRetRecepcao2.asmx');
        LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeCancelamento2.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeCancelamento2.asmx');
        LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeInutilizacao2.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeInutilizacao2.asmx');
        LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeConsulta2.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeConsulta2.asmx');
        LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/NfeStatusServico2.asmx',    'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/NfeStatusServico2.asmx');
        LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/sre/RecepcaoEvento.asmx',         'https://hnfe.sefaz.ba.gov.br/webservices/sre/RecepcaoEvento.asmx');
      end;
     end
     else begin
      case ALayOut of
        LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeInutilizacao/NfeInutilizacao.asmx',     'https://hnfe.sefaz.ba.gov.br/webservices/NfeInutilizacao/NfeInutilizacao.asmx');
        // Alterado por Italo em 07/07/2014
        LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeConsulta/NfeConsulta.asmx',             'https://hnfe.sefaz.ba.gov.br/webservices/NfeConsulta/NfeConsulta.asmx');
        LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx',          'https://hnfe.sefaz.ba.gov.br/webservices/nfenw/CadConsultaCadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/sre/recepcaoevento.asmx',                  'https://hnfe.sefaz.ba.gov.br/webservices/sre/recepcaoevento.asmx');

        LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeStatusServico/NfeStatusServico.asmx',   'https://hnfe.sefaz.ba.gov.br/webservices/NfeStatusServico/NfeStatusServico.asmx');
        LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeAutorizacao/NfeAutorizacao.asmx',       'https://hnfe.sefaz.ba.gov.br/webservices/NfeAutorizacao/NfeAutorizacao.asmx');
        LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/NfeRetAutorizacao/NfeRetAutorizacao.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/NfeRetAutorizacao/NfeRetAutorizacao.asmx');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLCE(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then 
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRecepcao2',         'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRetRecepcao2',      'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeCancelamento2',     'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeInutilizacao2',     'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeConsulta2',         'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeStatusServico2',    'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/CadConsultaCadastro2', 'https://nfeh.sefaz.ce.gov.br/nfe2/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/RecepcaoEvento',       'https://nfeh.sefaz.ce.gov.br/nfe2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeAutorizacao',       'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe2/services/NfeRetAutorizacao',    'https://nfeh.sefaz.ce.gov.br/nfe2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLES(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
 if AModeloDF = moNFe then
  begin
    case ALayOut of
      LayNfeCadastro : Result := ifThen(AAmbiente=1, 'https://app.sefaz.es.gov.br/ConsultaCadastroService/CadConsultaCadastro2.asmx','https://app.sefaz.es.gov.br/ConsultaCadastroService/CadConsultaCadastro2.asmx');
      else             Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF);
    end;
  end
 else
  begin
   Result := NotaUtil.GetURLSVRS(AAmbiente, ALayOut, AModeloDF, AVersaoDF);
  end;
end;

class function NotaUtil.GetURLGO(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRecepcao2?wsdl',         'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRecepcao2?wsdl');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRetRecepcao2?wsdl',      'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRetRecepcao2?wsdl');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeCancelamento2?wsdl',     'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeCancelamento2?wsdl');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeInutilizacao2?wsdl',     'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeInutilizacao2?wsdl');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeConsulta2?wsdl',         'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeConsulta2?wsdl');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeStatusServico2?wsdl',    'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeStatusServico2?wsdl');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/CadConsultaCadastro2?wsdl', 'https://homolog.sefaz.go.gov.br/nfe/services/v2/CadConsultaCadastro2?wsdl');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/RecepcaoEvento?wsdl',       'https://homolog.sefaz.go.gov.br/nfe/services/v2/RecepcaoEvento?wsdl');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeAutorizacao?wsdl',       'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeAutorizacao?wsdl');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/v2/NfeRetAutorizacao?wsdl',    'https://homolog.sefaz.go.gov.br/nfe/services/v2/NfeRetAutorizacao?wsdl');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMT(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRecepcao2',         'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRetRecepcao2',      'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeCancelamento2',     'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeInutilizacao2',     'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeConsulta2',         'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeStatusServico2',    'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeStatusServico2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/CadConsultaCadastro2', 'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/RecepcaoEvento',       'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeAutorizacao',       'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/v2/services/NfeRetAutorizacao',    'https://homologacao.sefaz.mt.gov.br/nfews/v2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeAutorizacao?wsdl',    'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeAutorizacao?wsdl');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeRetAutorizacao?wsdl', 'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeRetAutorizacao?wsdl');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeInutilizacao2?wsdl',  'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeInutilizacao2?wsdl');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeConsulta2?wsdl',      'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeConsulta2?wsdl');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/NfeStatusServico2?wsdl', 'https://homologacao.sefaz.mt.gov.br/nfcews/services/NfeStatusServico2?wsdl');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfce.sefaz.mt.gov.br/nfcews/services/RecepcaoEvento?wsdl',    'https://homologacao.sefaz.mt.gov.br/nfcews/services/RecepcaoEvento?wsdl');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRecepcao2',         'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRetRecepcao2',      'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeCancelamento2',     'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeInutilizacao2',     'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeConsulta2',         'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeStatusServico2',    'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeStatusServico2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/CadConsultaCadastro2', 'https://homologacao.nfe.ms.gov.br/homologacao/services2/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/RecepcaoEvento',       'https://homologacao.nfe.ms.gov.br/homologacao/services2/RecepcaoEvento');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeAutorizacao',       'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.ms.gov.br/producao/services2/NfeRetAutorizacao',    'https://homologacao.nfe.ms.gov.br/homologacao/services2/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLMG(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRecepcao2',         'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRetRecepcao2',      'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeCancelamento2',     'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeInutilizacao2',     'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeConsulta2',         'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeStatus2',           'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeStatus2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/cadconsultacadastro2', 'https://hnfe.fazenda.mg.gov.br/nfe2/services/cadconsultacadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/RecepcaoEvento',       'https://hnfe.fazenda.mg.gov.br/nfe2/services/RecepcaoEvento');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeAutorizacao',       'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeAutorizacao');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe2/services/NfeRetAutorizacao',    'https://hnfe.fazenda.mg.gov.br/nfe2/services/NfeRetAutorizacao');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLPR(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao      : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeRecepcao2',             'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeRecepcao2');
        LayNfeRetRecepcao   : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeRetRecepcao2',          'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeRetRecepcao2');
        LayNfeCancelamento  : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeCancelamento2',         'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeCancelamento2');
        LayNfeInutilizacao  : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeInutilizacao2',         'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeInutilizacao2');
        LayNfeConsulta      : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeConsulta2',             'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeConsulta2');
        LayNfeStatusServico : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/NFeStatusServico2',        'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/NFeStatusServico2');
        LayNfeCadastro      : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe/CadConsultaCadastro2',     'https://homologacao.nfe2.fazenda.pr.gov.br/nfe/CadConsultaCadastro2');
        LayNFeCCe,
        LayNFeEvento        : Result := ifThen(AAmbiente=1, 'https://nfe2.fazenda.pr.gov.br/nfe-evento/NFeRecepcaoEvento', 'https://homologacao.nfe2.fazenda.pr.gov.br/nfe-evento/NFeRecepcaoEvento');
      end;
     end
     else begin
      case ALayOut of
        LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeAutorizacao3',      'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeAutorizacao3');
        LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeRetAutorizacao3',   'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeRetAutorizacao3');
        LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeInutilizacao3',     'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeInutilizacao3');
        LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeConsulta3',         'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeConsulta3');
        LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeStatusServico3',    'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeStatusServico3');
        LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/CadConsultaCadastro2', 'https://homologacao.nfe.fazenda.pr.gov.br/nfe/CadConsultaCadastro2');
        LayNFeCCe,
        LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/nfe/NFeRecepcaoEvento',    'https://homologacao.nfe.fazenda.pr.gov.br/nfe/NFeRecepcaoEvento');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeAutorizacao3',    'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeAutorizacao3');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeRetAutorizacao3', 'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeRetAutorizacao3');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeInutilizacao3',   'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeInutilizacao3');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeConsulta3',       'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeConsulta3');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeStatusServico3',  'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeStatusServico3');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfce.fazenda.pr.gov.br/nfce/NFeRecepcaoEvento',  'https://homologacao.nfce.fazenda.pr.gov.br/nfce/NFeRecepcaoEvento');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLPE(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao2',           'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao2');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao2',        'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao2');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento2',       'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento2');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao2',       'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao2');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeConsulta2',           'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeConsulta2');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico2',      'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico2');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro2',   'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro2');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/RecepcaoEvento?wsdl',    'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/RecepcaoEvento?wsdl');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeAutorizacao?wsdl',    'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeAutorizacao?wsdl');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRetAutorizacao?wsdl', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRetAutorizacao?wsdl');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLRS(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    case ALayOut of
      LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx',                 'https://homologacao.nfe.sefaz.rs.gov.br/ws/Nferecepcao/NFeRecepcao2.asmx');
      LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx',           'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetRecepcao/NfeRetRecepcao2.asmx');
      LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx',         'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeCancelamento/NfeCancelamento2.asmx');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',         'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',                 'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://sef.sefaz.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro2.asmx', 'https://sef.sefaz.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx',      'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NfeRetAutorizacao.asmx');

      // Incluido por Italo em 14/11/2014
      LayNfeConsNFeDest  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeConsultaDest/nfeConsultaDest.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeConsultaDest/nfeConsultaDest.asmx');
      LayNfeDownloadNFe  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeDownloadNF/nfeDownloadNF.asmx',                'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeDownloadNF/nfeDownloadNF.asmx');
    end;
   end
  else
   begin
    case ALayOut of
      LayNfeRecepcao,
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx');
      LayNfeRetRecepcao,
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx',    'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx',            'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx',  'https://homologacao.nfe.sefaz.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx',       'https://homologacao.nfe.sefaz.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;
end;

class function NotaUtil.GetURLSP(AAmbiente: Integer;
  ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
begin
  if AModeloDF = moNFe then
   begin
    if AVersaoDF = ve200 then
     begin
      case ALayOut of
        LayNfeRecepcao       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferecepcao2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeRecepcao2.asmx');
        LayNfeRetRecepcao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferetrecepcao2.asmx',      'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeRetRecepcao2.asmx');
        LayNfeCancelamento   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfecancelamento2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeCancelamento2.asmx');
        LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeinutilizacao2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeInutilizacao2.asmx');
        LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeconsulta2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeConsulta2.asmx');
        LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfestatusservico2.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/NfeStatusServico2.asmx');
        LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/cadconsultacadastro2.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeWEB/services/cadconsultacadastro2.asmx');
        LayNFeCCe,
        LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/eventosWEB/services/RecepcaoEvento.asmx',   'https://homologacao.nfe.fazenda.sp.gov.br/eventosWEB/services/RecepcaoEvento.asmx');
      end;
     end
     else begin
      case ALayOut of
        LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeinutilizacao2.asmx',     'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeinutilizacao2.asmx');
        LayNfeConsulta       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeconsulta2.asmx',         'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeconsulta2.asmx');
        LayNfeStatusServico  : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfestatusservico2.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfestatusservico2.asmx');
        LayNfeCadastro       : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/cadconsultacadastro2.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/ws/cadconsultacadastro2.asmx');
        LayNFeCCe,                                                                                                                   
        LayNFeEvento         : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/recepcaoevento.asmx',       'https://homologacao.nfe.fazenda.sp.gov.br/ws/recepcaoevento.asmx');
        LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nfeautorizacao.asmx',       'https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeautorizacao.asmx');
        LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/ws/nferetautorizacao.asmx',    'https://homologacao.nfe.fazenda.sp.gov.br/ws/nferetautorizacao.asmx');
      end;
     end;
   end
  else
   begin
    case ALayOut of
      LayNfeAutorizacao    : Result := ifThen(AAmbiente=1, '', '');
      LayNfeRetAutorizacao : Result := ifThen(AAmbiente=1, '', '');
      LayNfeInutilizacao   : Result := ifThen(AAmbiente=1, '', '');
      LayNfeConsulta       : Result := ifThen(AAmbiente=1, '', '');
      LayNfeStatusServico  : Result := ifThen(AAmbiente=1, '', '');
      LayNFeCCe,
      LayNFeEvento         : Result := ifThen(AAmbiente=1, '', '');

      LayAdministrarCSCNFCe: Result := ifThen(AAmbiente=1, '', '');
    end;
   end;

end;


class function NotaUtil.IdentificaTipoSchema(const AXML: AnsiString; var I: integer): integer;
var
 lTipoEvento: String;
begin
  I := pos('<infNFe',AXML) ;
  Result := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',AXML) ;
     if I > 0 then
        Result := 2
     else
      begin
        I := pos('<infInut',AXML) ;
        if I > 0 then
           Result := 3
        else
         begin
          I := Pos('<infEvento', AXML);
          if I > 0 then
          begin
            lTipoEvento := Trim(RetornarConteudoEntre(AXML,'<tpEvento>','</tpEvento>'));
            if lTipoEvento = '110111' then
              Result := 6 // Cancelamento
            else if lTipoEvento = '210200' then
              Result := 7 //Manif. Destinatario: Confirmação da Operação
            else if lTipoEvento = '210210' then
              Result := 8 //Manif. Destinatario: Ciência da Operação Realizada
            else if lTipoEvento = '210220' then
              Result := 9 //Manif. Destinatario: Desconhecimento da Operação
            else if lTipoEvento = '210240' then
              Result := 10 // Manif. Destinatario: Operação não Realizada
            else if lTipoEvento = '110140' then
              Result := 11 // EPEC
            else
              Result := 5; //Carta de Correção Eletrônica
          end
          else
            Result := 4; //DPEC
         end;
     end;
   end;
end;


class function NotaUtil.GerarChaveContingencia(FNFe:TNFe): string;
   function GerarDigito_Contigencia(var Digito: integer; chave: string): boolean;
   var
     i, j: integer;
   const
     PESO = '43298765432987654329876543298765432';
   begin
     // Manual Integracao Contribuinte v2.02a - Página: 70 //
     chave := DFeUtil.LimpaNumero(chave);
     j := 0;
     Digito := 0;
     result := True;
     try
       for i := 1 to 35 do
         j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
       Digito := 11 - (j mod 11);
       if (j mod 11) < 2 then
         Digito := 0;
     except
       result := False;
     end;
     if length(chave) <> 35 then
       result := False;
   end;
var
   wchave: string;
   wicms_s, wicms_p: string;
   wd,wm,wa: word;
   Digito: integer;
begin
   //ajustado de acordo com nota tecnica 2009.003

   //UF
   if FNFe.Dest.EnderDest.UF='EX' then
      wchave:='99' //exterior
   else
   begin
      if FNFe.Ide.tpNF=tnSaida then
         wchave:=copy(inttostr(FNFe.Dest.EnderDest.cMun),1,2) //saida
      else
         wchave:=copy(inttostr(FNFe.Emit.EnderEmit.cMun),1,2); //entrada
   end;

   //TIPO DE EMISSAO
   if FNFe.Ide.tpEmis=teContingencia then
      wchave:=wchave+'2'
   else if FNFe.Ide.tpEmis=teFSDA then
      wchave:=wchave+'5'
   else if FNFe.Ide.tpEmis=teSVCAN then
      wchave:=wchave+'6'
   else if FNFe.Ide.tpEmis=teSVCRS then
      wchave:=wchave+'7'
   else
      wchave:=wchave+'0'; //este valor caracteriza ERRO, valor tem q ser  2, 5, 6 ou 7

   //CNPJ OU CPF
   if (FNFe.Dest.EnderDest.UF='EX') then
      wchave:=wchave+DFeUtil.Poem_Zeros('0',14)
   else
      wchave:=wchave+DFeUtil.Poem_Zeros(FNFe.Dest.CNPJCPF,14);

   //VALOR DA NF
   wchave:=wchave+DFeUtil.Poem_Zeros(DFeUtil.LimpaNumero(Floattostrf(FNFe.Total.ICMSTot.vNF,ffFixed,18,2)),14);

   //DESTAQUE ICMS PROPRIO E ST
   wicms_p:='2';
   wicms_s:='2';
   if (DFeUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vICMS)) then
      wicms_p:='1';
   if (DFeUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vST)) then
      wicms_s:='1';
   wchave:=wchave+wicms_p+wicms_s;

   //DIA DA EMISSAO
   decodedate(FNFe.Ide.dEmi,wa,wm,wd);
   wchave:=wchave+DFeUtil.Poem_Zeros(inttostr(wd),2);

   //DIGITO VERIFICADOR
   GerarDigito_Contigencia(Digito,wchave);
   wchave:=wchave+inttostr(digito);

   //RETORNA A CHAVE DE CONTINGENCIA
   result:=wchave;
end;

class function NotaUtil.FormatarChaveContigencia(AValue: String): String;
begin
  AValue := DFeUtil.LimpaNumero(AValue);
  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) ;
end;

class function NotaUtil.GetURLConsultaNFCe(const AUF : Integer; AAmbiente : TpcnTipoAmbiente) : String;
begin
  // As URLs abaixo são impressas no DANFE NFC-e e servem para que o
  // consumidor possa realizar a consulta mediante a digitação da chave de acesso.
  case AUF of
   12: Result := ifThen(AAmbiente = taProducao, 'http://www.sefaznet.ac.gov.br/nfce/', 'http://hml.sefaznet.ac.gov.br/nfce/'); //AC
   27: Result := ifThen(AAmbiente = taProducao, '', ''); //AL
   16: Result := ifThen(AAmbiente = taProducao, '', ''); //AP
   13: Result := ifThen(AAmbiente = taProducao, 'http://sistemas.sefaz.am.gov.br/nfceweb/formConsulta.do', 'http://homnfce.sefaz.am.gov.br/nfceweb/formConsulta.do'); //AM
   29: Result := ifThen(AAmbiente = taProducao, '', ''); //BA
   23: Result := ifThen(AAmbiente = taProducao, '', ''); //CE
   53: Result := ifThen(AAmbiente = taProducao, '', ''); //DF
   32: Result := ifThen(AAmbiente = taProducao, '', ''); //ES
   52: Result := ifThen(AAmbiente = taProducao, '', ''); //GO
   21: Result := ifThen(AAmbiente = taProducao, 'http://www.nfce.sefaz.ma.gov.br/portal/consultaNFe.do', 'http://www.hom.nfce.sefaz.ma.gov.br/portal/consultaNFe.do'); // MA
   51: Result := ifThen(AAmbiente = taProducao, 'http://www.sefaz.mt.gov.br/nfce/consultanfce',          'http://homologacao.sefaz.mt.gov.br/nfce/consultanfce');      // MT
   50: Result := ifThen(AAmbiente = taProducao, '', ''); //MS
   31: Result := ifThen(AAmbiente = taProducao, '', ''); //MG
   15: Result := ifThen(AAmbiente = taProducao, '', ''); //PA
   25: Result := ifThen(AAmbiente = taProducao, '', ''); //PB
   41: Result := ifThen(AAmbiente = taProducao, 'http://www.fazenda.pr.gov.br/', 'http://www.fazenda.pr.gov.br/'); //PR
   26: Result := ifThen(AAmbiente = taProducao, '', ''); //PE
   22: Result := ifThen(AAmbiente = taProducao, '', ''); //PI
   33: Result := ifThen(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx',               'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx');              // RJ
   24: Result := ifThen(AAmbiente = taProducao, 'http://nfce.set.rn.gov.br/portalDFE/NFCe/ConsultaNFCe.aspx', ''); // RN
   43: Result := ifThen(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-NFC.aspx',               'https://www.sefaz.rs.gov.br/NFE/NFE-NFC.aspx');              // RS
   11: Result := ifThen(AAmbiente = taProducao, 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp',  'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp'); // RO
   14: Result := ifThen(AAmbiente = taProducao, '', ''); //RR
   42: Result := ifThen(AAmbiente = taProducao, '', ''); //SC
   35: Result := ifThen(AAmbiente = taProducao, '', ''); //SP
   28: Result := ifThen(AAmbiente = taProducao, '', ''); //SE
   17: Result := ifThen(AAmbiente = taProducao, '', ''); //TO
  end;
end;

class function NotaUtil.GetURLQRCode(const AUF : Integer; AAmbiente : TpcnTipoAmbiente;
                                     AchNFe, AcDest: String;
                                     AdhEmi: TDateTime;
                                     AvNF, AvICMS: Currency;
                                     AdigVal, AidToken, AToken: String): String;
var
 sdhEmi_HEX, sdigVal_HEX, sNF, sICMS,
 cIdToken, cTokenHom, cTokenPro, sToken,
 sEntrada, cHashQRCode, urlUF: String;
begin
  // As URLs abaixo são utilizadas para compor a URL do QR-Code que é gerado
  // e impresso no DANFE NFC-e e serve para que o consumidor possa través de
  // um leitor de QR-Code ter acesso ao DANFE completo da NFC-e
  case AUF of
   12: urlUF := ifThen(AAmbiente = taProducao, 'http://www.sefaznet.ac.gov.br/nfe', 'http://hml.sefaznet.ac.gov.br/nfce'); // AC
   27: urlUF := ifThen(AAmbiente = taProducao, '', ''); // AL
   16: urlUF := ifThen(AAmbiente = taProducao, '', ''); // AP
   13: urlUF := ifThen(AAmbiente = taProducao, 'http://sistemas.sefaz.am.gov.br/nfceweb/consultarNFCe.jsp', 'http://homnfce.sefaz.am.gov.br/nfceweb/consultarNFCe.jsp'); // AM
   29: urlUF := ifThen(AAmbiente = taProducao, '', ''); // BA
   23: urlUF := ifThen(AAmbiente = taProducao, '', ''); // CE
   53: urlUF := ifThen(AAmbiente = taProducao, '', ''); // DF
   32: urlUF := ifThen(AAmbiente = taProducao, '', ''); // ES
   52: urlUF := ifThen(AAmbiente = taProducao, '', ''); // GO
   21: urlUF := ifThen(AAmbiente = taProducao, 'http://www.nfce.sefaz.ma.gov.br/portal/consultarNFCe.jsp', 'http://www.hom.nfce.sefaz.ma.gov.br/portal/consultarNFCe.jsp'); // MA
   51: urlUF := ifThen(AAmbiente = taProducao, 'http://www.sefaz.mt.gov.br/nfce/consultanfce',             'http://homologacao.sefaz.mt.gov.br/nfce/consultanfce');         // MT
   50: urlUF := ifThen(AAmbiente = taProducao, '', ''); // MS
   31: urlUF := ifThen(AAmbiente = taProducao, '', ''); // MG
   15: urlUF := ifThen(AAmbiente = taProducao, '', ''); // PA
   25: urlUF := ifThen(AAmbiente = taProducao, '', ''); // PB
   41: urlUF := ifThen(AAmbiente = taProducao, 'www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaNFCe', 'www.dfeportal.fazenda.pr.gov.br/dfe-portal/rest/servico/consultaNFCe'); // PR
   26: urlUF := ifThen(AAmbiente = taProducao, '', ''); // PE
   22: urlUF := ifThen(AAmbiente = taProducao, '', ''); // PI
//   33: urlUF := ifThen(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx',              'https://www.sefaz.rs.gov.br/NFE/NFE-COM.aspx');              // RJ
   33: urlUF := ifThen(AAmbiente = taProducao, 'http://www4.fazenda.rj.gov.br/consultaNFCe/QRCode',         'http://www4.fazenda.rj.gov.br/consultaNFCe/QRCode');         // RJ
   24: urlUF := ifThen(AAmbiente = taProducao, 'http://nfce.set.rn.gov.br/consultarNFCe.aspx',              'http://nfce.set.rn.gov.br/consultarNFCe.aspx');              // RN
   43: urlUF := ifThen(AAmbiente = taProducao, 'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx',            'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx');            // RS
   11: urlUF := ifThen(AAmbiente = taProducao, 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp', 'http://www.nfce.sefin.ro.gov.br/consultanfce/consulta.jsp'); // RO
   14: urlUF := ifThen(AAmbiente = taProducao, '', ''); // RR
   42: urlUF := ifThen(AAmbiente = taProducao, '', ''); // SC
   35: urlUF := ifThen(AAmbiente = taProducao, '', 'https://homologacao.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx'); // SP
   28: urlUF := ifThen(AAmbiente = taProducao, 'http://www.nfe.se.gov.br/portal/consultarNFCe.jsp', 'http://www.hom.nfe.se.gov.br/portal/consultarNFCe.jsp'); // SE
   17: urlUF := ifThen(AAmbiente = taProducao, '', ''); // TO
  end;

  AchNFe := OnlyNumber(AchNFe);

  // Passo 1
  // Alterado por Italo em 22/12/2014
  if AUF = 41 then
   sdhEmi_HEX  := LowerCase(AsciiToHex(DateTimeTodh(AdhEmi) + GetUTC(CodigoParaUF(AUF), AdhEmi)))
  else
   sdhEmi_HEX  := AsciiToHex(DateTimeTodh(AdhEmi) + GetUTC(CodigoParaUF(AUF), AdhEmi));


  // Passo 2
  // Alterado por Italo em 22/12/2014
  if AUF = 41 then
   sdigVal_HEX := LowerCase(AsciiToHex(AdigVal))
  else
   sdigVal_HEX := AsciiToHex(AdigVal);

  // Passo 3 e 4
  cIdToken  := AidToken;
  if DFeUtil.EstaVazio(AToken) then
     cTokenHom := Copy(AchNFe, 7, 8) + '20' + Copy(AchNFe, 3, 2) + Copy(cIdToken, 3, 4)
  else
     cTokenHom := AToken;
        
  cTokenPro := AToken;

  // Alterado por Italo em 05/06/2014
  // Essa alteração foi feita, pois algumas UF estão gerando o Token também para o Ambiente de Homologação
  // Neste caso o mesmo deve ser informado na propriedade Token caso contario deve-se atribuir a
  // essa propriedade uma String vazia
  if (AAmbiente = taHomologacao) then
   begin
     if (AToken = '') then
        cTokenHom := Copy(AchNFe, 7, 8) + '20' + Copy(AchNFe, 3, 2) + Copy(cIdToken, 3, 4)
     else
        cTokenHom := AToken;
   end
  else
     cTokenPro := AToken;

  sToken    := ifThen(AAmbiente = taProducao, cIdToken + cTokenPro, cIdToken + cTokenHom);

  sNF       := StringReplace(FormatFloat('0.00', AvNF), ',', '.', [rfReplaceAll]);
  sICMS     := StringReplace(FormatFloat('0.00', AvICMS), ',', '.', [rfReplaceAll]);

  sEntrada  := 'chNFe=' + AchNFe + '&nVersao=100&tpAmb=' + TpAmbToStr(AAmbiente) +
               IfThen(AcDest = '', '', '&cDest='+AcDest) +
               '&dhEmi=' + sdhEmi_HEX + '&vNF=' + sNF + '&vICMS=' + sICMS +
               '&digVal=' + sdigVal_HEX + '&cIdToken=';

  // Passo 5 calcular o SHA-1 da string sEntrada
  if fsHashQRCode = nil then
    fsHashQRCode := TACBrEAD.Create(nil);
  try
    cHashQRCode := fsHashQRCode.CalcularHash(sEntrada + sToken, dgstSHA1);
  except
    raise Exception.Create('Erro ao calcular Hash do QR-Code');
  end;

  // Passo 6
  Result := urlUF + '?' + sEntrada + cIdToken+ '&cHashQRCode=' + cHashQRCode;
end;

class function NotaUtil.CstatProcessado(AValue: Integer): Boolean;
begin
  case AValue of
     100: Result := True;
     110: Result := True;
     150: Result := True;
     301: Result := True;
     302: Result := True;          
  else
     Result := False;
  end;
end;

initialization

finalization
  if fsHashQRCode <> nil then
     fsHashQRCode.Free;

end.

(*
 TODO: Verificar onde fica

function GetVersaoNFe(AModeloDF: TpcnModeloDF; AVersaoDF: TpcnVersaoDF; ALayOut: TLayOut): string;



function GetVersaoNFe(AModeloDF: TpcnModeloDF; AVersaoDF: TpcnVersaoDF; ALayOut: TLayOut): string;
begin
  result := '';

  case AModeloDF of
    moNFe:
      begin
        case AVersaoDF of
          ve200:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '2.00';
                LayNfeRecepcao:       result := '2.00';
                LayNfeRetRecepcao:    result := '2.00';
                LayNfeConsulta:       result := '2.01';
                LayNfeCancelamento:   result := '2.00';
                LayNfeInutilizacao:   result := '2.00';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '2.00';
                LayNfeRetAutorizacao: result := '2.00';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe:result := '0.00';
              end;
            end;

          ve310:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.10';
                LayNfeRecepcao:       result := '3.10';
                LayNfeRetRecepcao:    result := '3.10';
                LayNfeConsulta:       result := '3.10';
                LayNfeCancelamento:   result := '3.10';
                LayNfeInutilizacao:   result := '3.10';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.10';
                LayNfeRetAutorizacao: result := '3.10';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe: result := '0.00';
              end;
            end;
        end;
      end;

    moNFCe:
      begin
        case AVersaoDF of
          ve300:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.00';
                LayNfeRecepcao:       result := '3.00';
                LayNfeRetRecepcao:    result := '3.00';
                LayNfeConsulta:       result := '3.00';
                LayNfeCancelamento:   result := '3.00';
                LayNfeInutilizacao:   result := '3.00';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.00';
                LayNfeRetAutorizacao: result := '3.00';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe: result := '1.00';
              end;
            end;

          ve310:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.10';
                LayNfeRecepcao:       result := '3.10';
                LayNfeRetRecepcao:    result := '3.10';
                LayNfeConsulta:       result := '3.10';
                LayNfeCancelamento:   result := '3.10';
                LayNfeInutilizacao:   result := '3.10';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.10';
                LayNfeRetAutorizacao: result := '3.10';
                LayDistDFeInt:        result := '1.00';

                LayAdministrarCSCNFCe: result := '1.00';
              end;
            end;
        end;
      end;
  end;
end;


class function GetURLSVRS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLSVAN(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLAM(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLBA(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLCE(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLES(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNfe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLGO(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLMT(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLMS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLMG(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLPR(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLPE(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLRS(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;
class function GetURLSP(AAmbiente: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;


class function GetURL(Const AUF, AAmbiente, FormaEmissao: Integer; ALayOut: TLayOut; AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): WideString;








  class function Valida(Const AXML: AnsiString; var AMsg: AnsiString; const APathSchemas: string = '';
                        AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
  class function ValidaAssinatura(const AXML: AnsiString;  var AMsg: AnsiString): Boolean;




  class function NotaUtil.Valida(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = '';
  AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaLibXML(AXML,AMsg,APathSchemas, AModeloDF, AVersaoDF);
{$ELSE}
  Result := ValidaMSXML(AXML,AMsg,APathSchemas, AModeloDF, AVersaoDF);
{$ENDIF}
end;

class function NotaUtil.ValidaAssinatura(const AXML: AnsiString;
  var AMsg: AnsiString): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaAssinaturaLibXML(PAnsiChar(AXML),AMsg);
{$ELSE}
  Result := ValidaAssinaturaMSXML(AXML,AMsg);
{$ENDIF}
end;



  {$IFDEF ACBrNFeOpenSSL}
function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''; AModeloDF: TpcnModeloDF = moNFe;
  AVersaoDF: TpcnVersaoDF = ve200): Boolean;
var
 doc, schema_doc : xmlDocPtr;
 parser_ctxt : xmlSchemaParserCtxtPtr;
 schema : xmlSchemaPtr;
 valid_ctxt : xmlSchemaValidCtxtPtr;
 schemError : xmlErrorPtr;
 schema_filename : AnsiString;

 Tipo,I: Integer;
begin
  Tipo := NotaUtil.IdentificaTipoSchema(AXML,I) ;

 if not DirectoryExists(ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+'Schemas',PathWithDelim(APathSchemas))) then
    raise EACBrNFeException.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+'Schemas',PathWithDelim(APathSchemas)));

  if AModeloDF = moNFe then
   begin
    case Tipo of
      1: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
      2: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
      3: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
      4: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
      5: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
      6: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      7..10: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                                 'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                 GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      11: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
      else schema_filename := '';
    end;
   end
  else
   begin
    case Tipo of
      1: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
      2: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
      3: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
      4: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
      5: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
      6: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      7..10: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                                 'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                 GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
      11: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(DFeUtil.PathAplication))+
                                             'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                             GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
      else schema_filename := '';
    end;
   end;

  if not FilesExists(schema_filename) then
    raise EACBrNFeException.Create('Arquivo '+schema_filename+' não encontrado');

 //doc         := nil;
 //schema_doc  := nil;
 //parser_ctxt := nil;
 //schema      := nil;
 //valid_ctxt  := nil;

 doc := xmlParseDoc(PAnsiChar(UTF8Encode(Axml)));
 if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

  schema_doc := xmlReadFile(Pansichar(AnsiString(ACBrStr(schema_filename))), nil, XML_DETECT_IDS);

//  the schema cannot be loaded or is not well-formed
 if (schema_doc = nil) then
  begin
    AMsg := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt  := xmlSchemaNewDocParserCtxt(schema_doc);
// unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
     begin
        xmlFreeDoc(schema_doc);
        AMsg := 'Erro: unable to create a parser context for the schema';
        Result := False;
        exit;
     end;

   schema := xmlSchemaParse(parser_ctxt);
// the schema itself is not valid
    if (schema = nil) then
     begin
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: the schema itself is not valid';
        Result := False;
        exit;
     end;

    valid_ctxt := xmlSchemaNewValidCtxt(schema);
//   unable to create a validation context for the schema */
    if (valid_ctxt = nil) then
     begin
        xmlSchemaFree(schema);
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: unable to create a validation context for the schema';
        Result := False;
        exit;
     end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
     begin
       schemError := xmlGetLastError();
       AMsg := IntToStr(schemError^.code)+' - '+schemError^.message;
       Result := False;
       exit;
     end;

    xmlSchemaFreeValidCtxt(valid_ctxt);
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    Result := True;
end;

function ValidaAssinaturaLibXML(const Axml: PAnsiChar; out Msg: AnsiString): Boolean;
{var
  doc : xmlDocPtr;
  node : xmlNodePtr;
  dsigCtx : xmlSecDSigCtxPtr;
  mngr : xmlSecKeysMngrPtr;

  Publico : String;
  Cert: TMemoryStream;
  Cert2: TStringStream;}
begin
  Result := False;
{  Publico := copy(Axml,pos('<X509Certificate>',Axml)+17,pos('</X509Certificate>',Axml)-(pos('<X509Certificate>',Axml)+17));

  Cert := TMemoryStream.Create;
  Cert2 := TStringStream.Create(Publico);
  Cert.LoadFromStream(Cert2);
       xmlSecCryptoAppKeyCertLoadMemory
  if (xmlSecCryptoAppKeysMngrCertLoadMemory(mngr,
                                        Cert.Memory,
                                        Cert.Size,
                                        xmlSecKeyDataFormatUnknown,
                                        1) < 0) then
    raise Exception.Create('Error: failed to load certificate');
  xmlSecOpenSSLAppKeyCertLoadMemory

  doc := xmlParseDoc(Axml);
  if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
    raise Exception.Create('Error: unable to parse');

  node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
  if (node = nil) then
    raise Exception.Create('Error: start node not found');

  dsigCtx := xmlSecDSigCtxCreate(nil);
  if (dsigCtx = nil) then
    raise Exception.Create('Error :failed to create signature context');



  dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Cert.Memory, Cert.Size, xmlSecKeyDataFormatPem, '', nil, nil);
  if (dsigCtx^.signKey = nil) then
    raise Exception.Create('Error: failed to load public pem key from "' + Axml + '"');}

  { Verify signature }
 { if (xmlSecDSigCtxVerify(dsigCtx, node) < 0) then
      raise Exception.Create('Error: signature verify');

  if dsigCtx.status = xmlSecDSigStatusSucceeded then
    Result := True
  else
    Result := False;

  xmlSecDSigCtxDestroy(dsigCtx);
  xmlFreeDoc(doc);}
end;
{$ELSE}
function ValidaMSXML(XML: AnsiString; out Msg: AnsiString; const APathSchemas: string = '';
                     AModeloDF: TpcnModeloDF = moNFe; AVersaoDF: TpcnVersaoDF = ve200): Boolean;
var
  DOMDocument: IXMLDOMDocument2;
  ParseError: IXMLDOMParseError;
  Schema: XMLSchemaCache;
  Tipo,I: Integer;
  schema_filename: String;
begin
  CoInitialize(nil);
  try
    Tipo := NotaUtil.IdentificaTipoSchema(XML,I) ;

    DOMDocument := CoDOMDocument50.Create;
    DOMDocument.async := False;
    DOMDocument.resolveExternals := False;
    DOMDocument.validateOnParse := True;
    DOMDocument.loadXML(XML);

    Schema := CoXMLSchemaCache50.Create;

    if not DirectoryExists(ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas))) then
       raise EACBrNFeException.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas)));

    if AModeloDF = moNFe then
     begin
      case Tipo of
        1: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
        2: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
        3: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
        4: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
        5: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
        6: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        7..10: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                                   'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                   GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        11: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
        else schema_filename := '';
      end;
     end
    else
     begin
      case Tipo of
        1: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'nfe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeRecepcao) + '.xsd';
        2: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCancelamento) + '.xsd';
        3: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeInutilizacao) + '.xsd';
        4: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEnvDPEC) + '.xsd';
        5: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envCCe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeCCe) + '.xsd';
        6: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEventoCancNFe_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        7..10: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                                   'Schemas\',PathWithDelim(APathSchemas))+'envConfRecebto_v' +
                                                   GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEvento) + '.xsd';
        11: schema_filename := ifThen(DFeUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+
                                               'Schemas\',PathWithDelim(APathSchemas))+'envEPEC_v' +
                                               GetVersaoNFe(AModeloDF, AVersaoDF, LayNfeEventoAN) + '.xsd';
        else schema_filename := '';
      end;
     end;

    if not FilesExists(schema_filename) then
       raise EACBrNFeException.Create('Arquivo '+schema_filename+' não encontrado');

    Schema.add( 'http://www.portalfiscal.inf.br/nfe', schema_filename );

    DOMDocument.schemas := Schema;
    ParseError := DOMDocument.validate;
    Result := (ParseError.errorCode = 0);
    Msg   := ParseError.reason;

    DOMDocument := nil;
    ParseError := nil;
    Schema := nil;
  finally
    CoUninitialize;
  end;
end;

function ValidaAssinaturaMSXML(XML: AnsiString; out Msg: AnsiString): Boolean;
var
  xmldoc  : IXMLDOMDocument3;
  xmldsig : IXMLDigitalSignature;

  pKeyInfo : IXMLDOMNode;
  pKey, pKeyOut : IXMLDSigKey;

begin
  xmldoc := CoDOMDocument50.Create;
  xmldsig := CoMXDigitalSignature50.Create;

  xmldoc.async              := False;
  xmldoc.validateOnParse    := False;
  xmldoc.preserveWhiteSpace := True;

   if (not xmldoc.loadXML(XML) ) then
      raise EACBrNFeException.Create('Não foi possível carregar o arquivo: '+XML);
  try
    xmldoc.setProperty('SelectionNamespaces', DSIGNS);
    xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

   if (xmldsig.signature = nil ) then
      raise EACBrNFeException.Create('Não foi possível carregar ou ler a assinatura: '+XML);

    pKeyInfo := xmldoc.selectSingleNode('.//ds:KeyInfo/ds:X509Data');

    pKey := xmldsig.createKeyFromNode(pKeyInfo);

    try
      pKeyOut := xmldsig.verify(pKey);
    except
       on E: Exception do
          Msg := 'Erro ao verificar assinatura do arquivo: '+ E.Message;
    end;
  finally
    Result := (pKeyOut <> nil );

    pKeyOut := nil;
    pKey := nil;
    pKeyInfo := nil;
    xmldsig := nil;
    xmldoc := nil;
  end;
end;
{$ENDIF}






class function NotaUtil.PreparaCasasDecimais(AValue: Integer): String;
var
   i: integer;
begin
   Result:='0';
   if AValue > 0 then
      Result:=Result+'.';
   for I := 0 to AValue-1 do
      Result:=Result+'0';
end;




class function NotaUtil.UFtoCUF(UF : String): Integer;
var
  Codigo, i: Integer;
begin
  Codigo := -1 ;
  for i:= 0 to High(NFeUF) do
  begin
    if NFeUF[I] = UF then
      Codigo := NFeUFCodigo[I];
  end;

  if Codigo < 0 then
     Result := -1
  else
     Result := Codigo;
end;


*)
