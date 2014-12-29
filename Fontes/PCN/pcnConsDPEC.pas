////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org                                       //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcnConsDPEC;

interface

uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador, ACBrUtil;

type

  TConsDPEC = class(TPersistent)
  private
    FGerador: TGerador;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FchNFe: String;
    FnRegDPEC: String;
    FVersao: String;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: Boolean;
    function ObterNomeArquivo: String;
  published
    property Gerador: TGerador       read FGerador  write FGerador;
    property tpAmb: TpcnTipoAmbiente read FtpAmb    write FtpAmb;
    property verAplic: String        read FverAplic write FverAplic;
    property chNFe: String           read FchNFe    write FchNFe;
    property nRegDPEC: String        read FnRegDPEC write FnRegDPEC;
    property Versao: String          read FVersao   write FVersao;
  end;

implementation

{ TConsDPEC }

constructor TConsDPEC.Create;
begin
  FGerador := TGerador.Create;
end;

destructor TConsDPEC.Destroy;
begin
  FGerador.Free;
  inherited;
end;

function TConsDPEC.ObterNomeArquivo: String;
begin
  Result := OnlyNumber(FchNFe) + '-ped-sit.xml';
end;

function TConsDPEC.GerarXML: Boolean;
begin
  Result := False;

  Gerador.ArquivoFormatoXML := '';

  Gerador.wGrupo(ENCODING_UTF8, '', False);
  Gerador.wGrupo('consDPEC versao="'+  Versao + '" ' + NAME_SPACE );
  Gerador.wCampo(tcStr, 'BP03', 'tpAmb', 001, 001, 1, tpAmbToStr(FtpAmb), DSC_TPAMB);
  Gerador.wCampo(tcStr, 'BP04', 'verAplic', 001, 020, 1, FverAplic, DSC_VERAPLIC);
  if trim(FchNFe) <> '' then
    Gerador.wCampo(tcEsp, 'BP05', 'chNFe', 044, 044, 1, FchNFe, DSC_CHNFe);
  if trim(FnRegDPEC) <> '' then
    Gerador.wCampo(tcEsp, 'BP06', 'nRegDPEC', 015, 015, 1, FnRegDPEC, DSC_nRegDPEC);
  Gerador.wGrupo('/consDPEC');
  if (trim(FchNFe) <> '') and (trim(FnRegDPEC) <> '') then
    Gerador.wAlerta('BP05/BP06', 'chNFe/nRegDPEC', DSC_CHNFe + '/' + DSC_nRegDPEC, ERR_MSG_SOMENTE_UM);

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.

