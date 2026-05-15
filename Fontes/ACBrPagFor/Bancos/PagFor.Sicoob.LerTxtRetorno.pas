{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
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

unit PagFor.Sicoob.LerTxtRetorno;

interface

uses
  SysUtils, Classes,
  ACBrPagForClass, ACBrPagForConversao,
  CNAB240.LerTxtRetorno;

type
 { TArquivoR_Sicoob }

  TArquivoR_Sicoob = class(TArquivoR_CNAB240)
  protected
    {
    procedure LerRegistro0; override;

    procedure LerRegistro1(I: Integer); override;

    procedure LerRegistro5(I: Integer); override;

    procedure LerRegistro9(I: Integer); override;

    procedure LerSegmentoA(I: Integer); override;

    procedure LerSegmentoB(mSegmentoBList: TSegmentoBList; I: Integer); override;

    procedure LerSegmentoC(mSegmentoCList: TSegmentoCList; I: Integer); override;

    procedure LerSegmentoE(mSegmentoEList: TSegmentoEList; I: Integer); override;

    procedure LerSegmentoF(mSegmentoFList: TSegmentoFList; I: Integer); override;

    procedure LerSegmentoG(I: Integer); override;

    procedure LerSegmentoH(mSegmentoHList: TSegmentoHList; I: Integer); override;

    procedure LerSegmentoJ(I: Integer; var LeuRegistroJ: boolean); override;

    procedure LerSegmentoJ52(mSegmentoJ52List: TSegmentoJ52List; I: Integer); override;

    procedure LerSegmentoJ99(mSegmentoJ99List: TSegmentoJ99List; I: Integer); override;

    procedure LerSegmentoN(mSegmentoN: TSegmentoN); override;

    procedure LerSegmentoN1(I: Integer); override;

    procedure LerSegmentoN2(I: Integer); override;

    procedure LerSegmentoN3(I: Integer); override;

    procedure LerSegmentoN4(I: Integer); override;

    procedure LerSegmentoN567(I: Integer); override;

    procedure LerSegmentoN8(I: Integer); override;

    procedure LerSegmentoN9(I: Integer); override;

    procedure LerSegmentoO(I: Integer); override;

    procedure LerSegmentoW(mSegmentoWList: TSegmentoWList; I: Integer); override;

    procedure LerSegmentoZ(mSegmentoZList: TSegmentoZList; I: Integer); override;
    }

    function GetOcorrencia(aOcorrencia: TOcorrencia): string; override;
  end;

implementation

{ TArquivoR_Sicoob }

function TArquivoR_Sicoob.GetOcorrencia(aOcorrencia: TOcorrencia): string;
begin
  case aOcorrencia of
    toBF: Result := 'Transação Rejeitada';
    toBS: Result := 'Transações que estão em análise de segurança';
    toPB: Result := 'Transação Pendente de Assinatura';
  else
    Result := inherited GetOcorrencia(aOcorrencia);
  end;
end;

end.

