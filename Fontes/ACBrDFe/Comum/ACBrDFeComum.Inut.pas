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

unit ACBrDFeComum.Inut;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  {$IFNDEF USE_ACBr_XMLDOCUMENT}
  pcnSignature,
  {$ENDIF}
  ACBrDFeComum.RetInut,
  ACBrDFe.Conversao,
  ACBrDFeUtil;

type

  { TinutDFe }

  TinutDFe = class(TObject)
  private
    FtpAmb: TACBrTipoAmbiente;
    FcUF: Integer;
    Fano: Integer;
    FCNPJ: string;
    Fmodelo: Integer;
    Fserie: Integer;
    FnNumIni: Integer;
    FnNumFin: Integer;
    FxJust: string;
    FIDInutilizacao: string;
    FVersao: string;
    FRetInutDFe: TRetInutDFe;
    Fsignature: Tsignature;
    FXML: string;

    FpNameSpace: string;
    FptagGrupoMsg: string;
    FptagNumIni: string;
    FptagNumFin: string;
  public
    constructor Create(const ANameSpace, AtagGrupoMsg, AtagNumIni,
      AtagNumFin: string);
    destructor Destroy; override;

    function GerarXML: string;

    function LerXML(const CaminhoArquivo: string): Boolean;
    function LerXMLFromString(const AXML: string): Boolean;
    function ObterNomeArquivo: string;

    property tpAmb: TACBrTipoAmbiente read FtpAmb     write FtpAmb;
    property cUF: Integer            read FcUF        write FcUF;
    property ano: Integer            read Fano        write Fano;
    property CNPJ: string            read FCNPJ       write FCNPJ;
    property modelo: Integer         read Fmodelo     write Fmodelo;
    property serie: Integer          read Fserie      write Fserie;
    property nNumIni: Integer        read FnNumIni    write FnNumIni;
    property nNumFin: Integer        read FnNumFin    write FnNumFin;
    property xJust: string           read FxJust      write FxJust;
    property ID: string              read FIDInutilizacao write FIDInutilizacao;
    property Versao: string          read FVersao     write FVersao;
    property RetInutDFe: TRetInutDFe read FRetInutDFe write FRetInutDFe;
    property signature: Tsignature   read Fsignature  write Fsignature;
    property XML: string             read FXML        write FXML;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrXmlDocument;

{ TinutDFe }

constructor TinutDFe.Create(const ANameSpace, AtagGrupoMsg, AtagNumIni,
  AtagNumFin: string);
begin
//  inherited Create;

  FpNameSpace := ANameSpace;
  FptagGrupoMsg := AtagGrupoMsg;
  FptagNumIni := AtagNumIni;
  FptagNumFin := AtagNumFin;

  FRetInutDFe := TRetInutDFe.Create(FptagGrupoMsg, FptagNumIni, FptagNumFin);
  Fsignature  := Tsignature.Create;
end;

destructor TinutDFe.Destroy;
begin
  FRetInutDFe.Free;
  Fsignature.Free;

  inherited;
end;

function TinutDFe.ObterNomeArquivo: string;
begin
  Result := RemoverLiteralChave(FIDInutilizacao) + '-ped-inu.xml';
end;

function TinutDFe.GerarXML: string;
var
  xCNPJ, ACNPJ: string;
begin
  ACNPJ := OnlyCPFCNPJAlphaNum(FCNPJ);

  if (cUF in [51]) and (Length(ACNPJ) = 11) then
    ACNPJ := '000' + ACNPJ;

  FIDInutilizacao := 'ID' + IntToStrZero(cUF, 2) +  Copy(IntToStrZero(ano, 4), 3, 2) +
                     ACNPJ + IntToStrZero(modelo, 2) + IntToStrZero(serie, 3) +
                     IntToStrZero(nNumIni, 9) + IntToStrZero(nNumFin, 9);

//  if length(FIDInutilizacao) < 43 then
//    Gerador.wAlerta('DP04', 'ID', '', 'ID de inutilização inválido');

//  if not ValidarCodigoUF(FcUF) then
//    Gerador.wAlerta('DP07', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  if ano > 2000 then
    ano := ano - 2000;

  ACNPJ := OnlyCPFCNPJAlphaNum(FCNPJ);

  if cUF in [51] then
  begin
    if Length(ACNPJ) = 11 then
      xCNPJ := '<CPF>' + ACNPJ + '</CPF>'
    else
      xCNPJ := '<CNPJ>' + ACNPJ + '</CNPJ>';
  end
  else
  begin
    xCNPJ := '<CNPJ>' + ACNPJ + '</CNPJ>';

//    if not ValidarCNPJ(FCNPJ) then
//      Gerador.wAlerta('DP09', 'CNPJ', DSC_CNPJ, ERR_MSG_INVALIDO);
  end;

//  if nNFIni > nNFFin then
//    Gerador.wAlerta('DP13', 'nNFFin', DSC_NNFFIN, ERR_MSG_FINAL_MENOR_INICIAL);

  Result := '<inut' + FptagGrupoMsg + ' ' + FpNameSpace + ' versao="' + Fversao + '">' +
              '<infInut Id="' + FIDInutilizacao + '">' +
                '<tpAmb>' + TipoAmbienteToStr(tpAmb) + '</tpAmb>' +
                '<xServ>INUTILIZAR</xServ>' +
                '<cUF>' + IntToStr(cUF) + '</cUF>' +
                '<ano>' + IntToStr(ano) + '</ano>' +
                xCNPJ +
                '<mod>' + IntToStr(modelo) + '</mod>' +
                '<serie>' + IntToStr(serie) + '</serie>' +
                '<' + FptagNumIni + '>' + IntToStr(nNumIni) + '</' + FptagNumIni + '>' +
                '<' + FptagNumFin + '>' + IntToStr(nNumFin) + '</' + FptagNumFin + '>' +
                '<xJust>' + xJust + '</xJust>' +
              '</infInut>' +
            '</inut' + FptagGrupoMsg + '>';

  if signature.URI <> '' then
  begin
    {$IFNDEF USE_ACBr_XMLDOCUMENT}
     signature.GerarXML;
     Result := Result + signature.Gerador.ArquivoFormatoXML;
    {$Else}
     Result := Result + signature.GerarXML;
    {$ENDIF}
  end;
end;

function TinutDFe.LerXML(const CaminhoArquivo: string): Boolean;
var
  ArqInut: TStringList;
begin
  ArqInut := TStringList.Create;
  try
    ArqInut.LoadFromFile(CaminhoArquivo);
    Result := LerXMLFromString(ArqInut.Text);
  finally
    ArqInut.Free;
  end;
end;

function TinutDFe.LerXMLFromString(const AXML: string): Boolean;
var
  Document: TACBrXmlDocument;
  ANode, AuxNode, AuxNode2: TACBrXmlNode;
  RetornoInutDFe: TRetInutDFe;
begin
  RetornoInutDFe := TRetInutDFe.Create(FptagGrupoMsg, FptagNumIni, FptagNumFin);
  try
    Document := TACBrXmlDocument.Create;

    try
      try
        Document.LoadFromXml(AXML);

        ANode := Document.Root;

        if ANode <> nil then
        begin
          XML := AXML;

          if LowerCase(ANode.LocalName) = 'procinut' + LowerCase(FptagGrupoMsg) then
          begin
            versao := ObterConteudoTag(ANode.Attributes.Items['versao']);

            AuxNode := ANode.Childrens.FindAnyNs('inut' + FptagGrupoMsg);
          end
          else
            AuxNode := ANode;

          if AuxNode <> nil then
          begin
            AuxNode2 := AuxNode.Childrens.FindAnyNs('infInut');

            if AuxNode2 <> nil then
            begin
              FIDInutilizacao := ObterConteudoTag(AuxNode2.Attributes.Items['Id']);
              tpAmb := StrToTipoAmbiente(ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('tpAmb'), tcStr));
              cUF := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('cUF'), tcInt);
              ano := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('ano'), tcInt);
              CNPJ := ObterConteudoTagCNPJCPF(AuxNode2);
              modelo := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('mod'), tcInt);
              serie := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('serie'), tcInt);
              nNumIni := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs(FptagNumIni), tcInt);
              nNumFin := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs(FptagNumFin), tcInt);
              xJust := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('xJust'), tcStr);
            end;

            LerSignature(AuxNode.Childrens.Find('Signature'), signature);
          end;
        end;

        // Lendo dados do retorno, se houver
        RetornoInutDFe.XmlRetorno := AXML;

        if RetornoInutDFe.LerXml then
        begin
          if ( FIDInutilizacao = '' ) then
          begin
            FIDInutilizacao := RetornoInutDFe.Id;
            tpAmb           := RetornoInutDFe.tpAmb;
          end;

          with FRetInutDFe do
          begin
            Id       := RetornoInutDFe.Id;
            tpAmb    := RetornoInutDFe.tpAmb;
            verAplic := RetornoInutDFe.verAplic;
            cStat    := RetornoInutDFe.cStat;
            xMotivo  := RetornoInutDFe.xMotivo;
            cUF      := RetornoInutDFe.cUF;
            xJust    := RetornoInutDFe.xJust;

            ano      := RetornoInutDFe.ano;
            CNPJ     := RetornoInutDFe.CNPJ;
            Modelo   := RetornoInutDFe.Modelo;
            Serie    := RetornoInutDFe.Serie;
            nNumIni  := RetornoInutDFe.nNumIni;
            nNumFin  := RetornoInutDFe.nNumFin;
            dhRecbto := RetornoInutDFe.dhRecbto;
            nProt    := RetornoInutDFe.nProt;
          end;

          if FRetInutDFe.xJust = '' then
            FRetInutDFe.xJust := xJust;
        end;

        Result := True;
      except
        Result := False;
      end;
    finally
      FreeAndNil(Document);
    end;
  finally
    RetornoInutDFe.Free;
  end;
end;

end.

