{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
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

unit ACBrNFe.ValidarRegrasdeNegocio;

interface

uses
  Classes, SysUtils,
  ACBrNFe.Classes,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  pcnConversao,
  pcnConversaoNFe;
//  ACBrNFe.Conversao;

type
  { TNFeValidarRegras }

  TNFeValidarRegras = class
  private
    FpLog: string;
    FpAgora: TDateTime;

    FNFe: TNFe;
    FVersaoDF: TpcnVersaoDF;
    FAmbiente: TpcnTipoAmbiente;
    FtpEmis: Integer;
    FCodigoUF: Integer;
    FUF: string;
    FErros: string;

    procedure ValidarRegra226;
    procedure ValidarRegra228;
    procedure ValidarRegra321;
    procedure ValidarRegra512;
    procedure ValidarRegra701;
    procedure ValidarRegra703;
    procedure ValidarRegra789;
    procedure ValidarRegra794;
    procedure ValidarRegra897;

    procedure RegrasValidasParaAmbosModelos;
    procedure RegrasValidasSomenteParaNFe;
    procedure RegrasValidasSomenteParaNFCe;

    procedure GravaLog(const AString: string);
    procedure AdicionaErro(const Erro: string);

  public
    constructor Create(AOwner: TNFe); reintroduce;

    function Validar(Agora: TDateTime): Boolean;

    property NFe: TNFe read FNFe write FNFe;
    property VersaoDF: TpcnVersaoDF read FVersaoDF write FVersaoDF;
    property Ambiente: TpcnTipoAmbiente read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
    property CodigoUF: Integer read FCodigoUF write FCodigoUF;
    property UF: string read FUF write FUF;
    property Erros: string read FErros write FErros;
  end;

implementation

uses
  DateUtils,
  StrUtils,
  ACBrDFeUtil,
  ACBrUtil.Math,
  ACBrUtil.Base,
  ACBrUtil.Strings;

const
  TOLERANCIA_COMPARACAO_01 = 0.01;
  TOLERANCIA_COMPARACAO_001 = 0.001;


{ TNFeValidarRegras }

constructor TNFeValidarRegras.Create(AOwner: TNFe);
begin
  inherited Create;

  FNFe := AOwner;
end;

procedure TNFeValidarRegras.GravaLog(const AString: string);
begin
  FpLog := FpLog + FormatDateTime('hh:nn:ss:zzz', Now) + ' - ' + AString + sLineBreak;
end;

procedure TNFeValidarRegras.RegrasValidasParaAmbosModelos;
begin
  ValidarRegra226;
  ValidarRegra228;
  ValidarRegra512;
  ValidarRegra701;
  ValidarRegra703;
  ValidarRegra897;
end;

procedure TNFeValidarRegras.RegrasValidasSomenteParaNFe;
var
  fsvDup: Currency;
  UltVencto: TDateTime;
  I: Integer;
begin
  ValidarRegra321;

    GravaLog('Validar: 504-Saida > 30');
    if ((NFe.Ide.dSaiEnt - FpAgora) > 30) then  //B10-20  - Facultativo
      AdicionaErro('504-Rejeição: Data de Entrada/Saída posterior ao permitido');

    GravaLog('Validar: 505-Saida < 30');
    if (NFe.Ide.dSaiEnt <> 0) and ((FpAgora - NFe.Ide.dSaiEnt) > 30) then  //B10-30  - Facultativo
      AdicionaErro('505-Rejeição: Data de Entrada/Saída anterior ao permitido');

    GravaLog('Validar: 506-Saida < Emissao');
    if (NFe.Ide.dSaiEnt <> 0) and (NFe.Ide.dSaiEnt < NFe.Ide.dEmi) then
      //B10-40  - Facultativo
      AdicionaErro('506-Rejeição: Data de Saída menor que a Data de Emissão');

    GravaLog('Validar: 710-Formato DANFE');
    if (NFe.Ide.tpImp in [tiNFCe, tiMsgEletronica]) then  //B21-20
      AdicionaErro('710-Rejeição: NF-e com formato de DANFE inválido');

    GravaLog('Validar: 711-NFe off-line');
    if (NFe.Ide.tpEmis = teOffLine) then  //B22-10
      AdicionaErro('711-Rejeição: NF-e com contingência off-line');

    GravaLog('Validar: 254-NFe complementar sem referenciada');
    if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 0) then  //B25-30
      AdicionaErro('254-Rejeição: NF-e complementar não possui NF referenciada');

    GravaLog('Validar: 255-NFe complementar e muitas referenciada');
    if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count > 1) then  //B25-40
      AdicionaErro('255-Rejeição: NF-e complementar possui mais de uma NF referenciada');

    GravaLog('Validar: 269-CNPJ Emitente NFe complementar');
    if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 1) and
      (((NaoEstaVazio(NFe.Ide.NFref.Items[0].RefNF.CNPJ)) and
      (not SameText(NFe.Ide.NFref.Items[0].RefNF.CNPJ, NFe.Emit.CNPJCPF))) or
      ((NaoEstaVazio(NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF)) and
      (not SameText(NFe.Ide.NFref.Items[0].RefNFP.CNPJCPF, NFe.Emit.CNPJCPF)))) then
      //B25-50
      AdicionaErro(
        '269-Rejeição: CNPJ Emitente da NF Complementar difere do CNPJ da NF Referenciada');

    GravaLog('Validar: 678-UF NFe referenciada e complementar');
    if (NFe.Ide.finNFe = fnComplementar) and (NFe.Ide.NFref.Count = 1) and
      //Testa pelo número para saber se TAG foi preenchida
      (((NFe.Ide.NFref.Items[0].RefNF.nNF > 0) and
      (NFe.Ide.NFref.Items[0].RefNF.cUF <> UFparaCodigoUF(
      NFe.Emit.EnderEmit.UF))) or ((NFe.Ide.NFref.Items[0].RefNFP.nNF > 0) and
      (NFe.Ide.NFref.Items[0].RefNFP.cUF <> UFparaCodigoUF(
      NFe.Emit.EnderEmit.UF))))
    then  //B25-60 - Facultativo
      AdicionaErro('678-Rejeição: NF referenciada com UF diferente da NF-e complementar');

  ValidarRegra794;

//      GravaLog('Validar: 719-NFe sem ident. destinatário');
//      if (NFe.Dest.CNPJCPF = '') and
//         (NFe.Dest.idEstrangeiro = '') then
//        AdicionaErro('719-Rejeição: NF-e sem a identificação do destinatário');

    GravaLog('Validar: 237-CPF destinatário ');
    if (Trim(OnlyCPFCNPJAlphaNum(NFe.Dest.CNPJCPF)) <> EmptyStr) and
      (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.Dest.CNPJCPF))) <= 11) and
      not ValidarCPF(NFe.Dest.CNPJCPF) then
      AdicionaErro('237-Rejeição: CPF do destinatário inválido');

//      GravaLog('Validar: 720-idEstrangeiro');
//      if (nfe.Ide.idDest = doExterior) and
//         (EstaVazio(Trim(NFe.Dest.idEstrangeiro))) then
//        AdicionaErro('720-Rejeição: Na operação com Exterior deve ser informada tag idEstrangeiro');

    GravaLog('Validar: 721-Op.Interstadual sem CPF/CNPJ');
    if (nfe.Ide.idDest = doInterestadual) and
       (EstaVazio(Trim(NFe.Dest.CNPJCPF))) then
      AdicionaErro('721-Rejeição: Operação interestadual deve informar CNPJ ou CPF');

    GravaLog('Validar: 723-Op.interna com idEstrangeiro');
    if (nfe.Ide.idDest = doInterna) and
       (NaoEstaVazio(Trim(NFe.Dest.idEstrangeiro))) and
       (NFe.Ide.indFinal <> cfConsumidorFinal)then
      AdicionaErro('723-Rejeição: Operação interna com idEstrangeiro informado deve ser para consumidor final');

    GravaLog('Validar: 724-Nome destinatário');
    if EstaVazio(Trim(NFe.Dest.xNome)) then
      AdicionaErro('724-Rejeição: NF-e sem o nome do destinatário');

    GravaLog('Validar: 726-Sem Endereço destinatário');
    if EstaVazio(Trim(NFe.Dest.EnderDest.xLgr)) then
      AdicionaErro('726-Rejeição: NF-e sem a informação de endereço do destinatário');

    GravaLog('Validar: 509-EX e município');
    if (not SameText(NFe.Dest.EnderDest.UF, 'EX')) and
       not ValidarMunicipio(NFe.Dest.EnderDest.cMun) then
      AdicionaErro('509-Rejeição: Informado código de município diferente de "9999999" para operação com o exterior');

    GravaLog('Validar: 727-Op exterior e UF');
    if (nfe.Ide.idDest = doExterior) and
      (not SameText(NFe.Dest.EnderDest.UF, 'EX')) then
      AdicionaErro('727-Rejeição: Operação com Exterior e UF diferente de EX');

    GravaLog('Validar: 771-Op.Interstadual e UF EX');
    if (nfe.Ide.idDest = doInterestadual) and
       (SameText(NFe.Dest.EnderDest.UF, 'EX')) then
      AdicionaErro('771-Rejeição: Operação Interestadual e UF de destino com EX');

    GravaLog('Validar: 773-Op.Interna e UF diferente');
    if (nfe.Ide.idDest = doInterna) and
       (not SameText(NFe.Dest.EnderDest.UF, NFe.Emit.EnderEmit.UF)) and
       (NFe.Ide.indPres <> pcPresencial) then
      AdicionaErro('773-Rejeição: Operação Interna e UF de destino difere da UF do emitente - não presencial');

    GravaLog('Validar: 790-Op.Exterior e Destinatário ICMS');
    if (NFe.Ide.idDest = doExterior) and
       (NFe.Dest.indIEDest <> inNaoContribuinte) then
      AdicionaErro('790-Rejeição: Operação com Exterior para destinatário Contribuinte de ICMS');

    if NFe.infNFe.Versao < 4 then
    begin
      GravaLog('Validar: 768-NFe < 4.0 com formas de pagamento');
      if (NFe.pag.Count > 0) then
        AdicionaErro('768-Rejeição: NF-e não deve possuir o grupo de Formas de Pagamento');
    end
    else
    begin
      GravaLog('Validar: 769-NFe >= 4.0 sem formas pagamento');
      if (NFe.pag.Count <= 0) then
        AdicionaErro('769-Rejeição: NF-e deve possuir o grupo de Formas de Pagamento');
    end;

    if NFe.infNFe.Versao >= 4 then
    begin
      GravaLog('Validar: 864-Operação presencial, fora do estabelecimento e não informada campos refNFe');
      if (NFe.Ide.indPres = pcPresencialForaEstabelecimento) and
         (NFe.Ide.NFref.Count <= 0) then
        AdicionaErro('864-Rejeição: NF-e com indicativo de Operação presencial, fora do estabelecimento e não informada NF referenciada');

      GravaLog('Validar: 868-Se operação interestadual(idDest=2), não informar os Grupos Veiculo Transporte (id:X18; veicTransp) e Grupo Reboque (id: X22)');
      if (NFe.Ide.idDest = doInterestadual) and
         (((NaoEstaVazio(trim(NFe.Transp.veicTransp.placa))) or
          (NaoEstaVazio(trim(NFe.Transp.veicTransp.UF))) or
          (NaoEstaVazio(trim(NFe.Transp.veicTransp.RNTC)))) or
          (nfe.Transp.Reboque.Count > 0)) then
        AdicionaErro('868-Rejeição: Grupos Veiculo Transporte e Reboque não devem ser informados');

      if NFe.Ide.finNFe in [fnNormal, fnComplementar] then
      begin
        GravaLog('Validar: 895-Valor do Desconto (vDesc, id:Y05) maior que o Valor Original da Fatura (vOrig, id:Y04)');
        if (ComparaValor(nfe.Cobr.Fat.vDesc, nfe.Cobr.Fat.vOrig, TOLERANCIA_COMPARACAO_001) > 0) then
          AdicionaErro('895-Rejeição: Valor do Desconto da Fatura maior que Valor Original da Fatura');

        GravaLog('Validar: 902-Valor Líquido da Fatura (vLiq, id:Y06) difere do Valor Original da Fatura (vOrig; id:Y04) – Valor do Desconto (vDesc, id:Y05)');
        if (ComparaValor(nfe.Cobr.Fat.vLiq, (nfe.Cobr.Fat.vOrig - nfe.Cobr.Fat.vDesc), TOLERANCIA_COMPARACAO_001) <> 0) then
          AdicionaErro('902-Rejeição: Valor Liquido da Fatura difere do Valor Original menos o Valor do Desconto');

//          GravaLog('Validar: 897-Valor Líquido da Fatura/Valor Original da Fatura maior que o Valor Total da Nota Fiscal');
//          if (((nfe.Cobr.Fat.vLiq > 0) and (nfe.Cobr.Fat.vLiq > nfe.Total.ICMSTot.vNF)) or
//              ((nfe.Cobr.Fat.vOrig > nfe.Total.ICMSTot.vNF)))then
//            AdicionaErro('897-Rejeição: Valor da Fatura maior que Valor Total da NF-e');

        fsvDup := 0;
        UltVencto := DateOf(NFe.Ide.dEmi);
        for I:=0 to nfe.Cobr.Dup.Count-1 do
        begin
          fsvDup := fsvDup + nfe.Cobr.Dup.Items[I].vDup;

          GravaLog('Validar: 857-Se informado o Grupo Parcelas de cobrança (tag:dup, Id:Y07), Número da parcela (nDup, id:Y08) não informado ou inválido.');
          if EstaVazio(nfe.Cobr.Dup.Items[I].nDup) then
            AdicionaErro('857-Rejeição: Número da parcela inválido ou não informado');

          //898 - Verificar DATA de autorização

          GravaLog('Validar: 894-Se informado o grupo de Parcelas de cobrança (tag:dup, Id:Y07) e Data de vencimento (dVenc, id:Y09) não informada ou menor que a Data de Emissão (id:B09)');
          if (nfe.Cobr.Dup.Items[I].dVenc < DateOf(NFe.Ide.dEmi)) then
            AdicionaErro('894-Rejeição: Data de vencimento da parcela não informada ou menor que Data de Emissão');

          GravaLog('Validar: 867-Se informado o grupo de Parcelas de cobrança (tag:dup, Id:Y07) e Data de vencimento (dVenc, id:Y09) não informada ou menor que a Data de vencimento da parcela anterior (dVenc, id:Y09)');
          if (nfe.Cobr.Dup.Items[I].dVenc < UltVencto) then
            AdicionaErro('867-Rejeição: Data de vencimento da parcela não informada ou menor que a Data de vencimento da parcela anterior');

          UltVencto := nfe.Cobr.Dup.Items[I].dVenc;
        end;

        GravaLog('Validar: 851-Se informado o grupo de Parcelas de cobrança (tag:dup, Id:Y07) e a soma do valor das parcelas (vDup, id: Y10) difere do Valor Líquido da Fatura (vLiq, id:Y06).');
        //porque se não tiver parcela não tem valor para ser verificado
        if (nfe.Cobr.Dup.Count > 0) and (((ComparaValor(nfe.Cobr.Fat.vLiq, 0, TOLERANCIA_COMPARACAO_001) > 0) and (ComparaValor(fsvDup, nfe.Cobr.Fat.vLiq, TOLERANCIA_COMPARACAO_001) < 0)) or
           (ComparaValor(fsvDup, (nfe.Cobr.Fat.vOrig-nfe.Cobr.Fat.vDesc), TOLERANCIA_COMPARACAO_001) < 0)) then
          AdicionaErro('851-Rejeição: Soma do valor das parcelas difere do Valor Líquido da Fatura');
      end;
    end;
end;

procedure TNFeValidarRegras.RegrasValidasSomenteParaNFCe;
begin
  ValidarRegra789;

    GravaLog('Validar: 704-NFCe Data atrasada');
    if (NFe.Ide.dEmi < IncMinute(FpAgora,-10)) and
      (NFe.Ide.tpEmis in [teNormal, teSCAN, teSVCAN, teSVCRS]) then
      //B09-40
      AdicionaErro('704-Rejeição: NFC-e com Data-Hora de emissão atrasada');

    GravaLog('Validar: 705-NFCe Data de entrada/saida');
    if (NFe.Ide.dSaiEnt <> 0) then  //B10-10
      AdicionaErro('705-Rejeição: NFC-e com data de entrada/saída');

    GravaLog('Validar: 706-NFCe operação entrada');
    if (NFe.Ide.tpNF = tnEntrada) then  //B11-10
      AdicionaErro('706-Rejeição: NFC-e para operação de entrada');

    GravaLog('Validar: 707-NFCe operação interestadual');
    if (NFe.Ide.idDest <> doInterna) then  //B11-10
      AdicionaErro('707-NFC-e para operação interestadual ou com o exterior');

    GravaLog('Validar: 709-NFCe formato DANFE');
    if (not (NFe.Ide.tpImp in [tiNFCe, tiMsgEletronica])) then
      //B21-10
      AdicionaErro('709-Rejeição: NFC-e com formato de DANFE inválido');

    GravaLog('Validar: 782-NFCe e SCAN');
    if (NFe.Ide.tpEmis = teSCAN) then //B22-50
      AdicionaErro('782-Rejeição: NFC-e não é autorizada pelo SCAN');

    GravaLog('Validar: 783-NFCe e SVC');
    if (NFe.Ide.tpEmis in [teSVCAN, teSVCRS]) then  //B22-70
      AdicionaErro('783-Rejeição: NFC-e não é autorizada pela SVC');

    GravaLog('Validar: 715-NFCe finalidade');
    if (NFe.Ide.finNFe <> fnNormal) then  //B25-20
      AdicionaErro('715-Rejeição: Rejeição: NFC-e com finalidade inválida');

    GravaLog('Validar: 716-NFCe operação');
    if (NFe.Ide.indFinal = cfNao) then //B25a-10
      AdicionaErro('716-Rejeição: NFC-e em operação não destinada a consumidor final');

    GravaLog('Validar: 717-NFCe entrega');
    if (not (NFe.Ide.indPres in [pcPresencial, pcEntregaDomicilio])) then
      //B25b-20
      AdicionaErro('717-Rejeição: NFC-e em operação não presencial');

    GravaLog('Validar: 785-NFCe entrega e UF');
    if (NFe.Ide.indPres = pcEntregaDomicilio) and
      (AnsiIndexStr(NFe.Emit.EnderEmit.UF, ['XX']) <> -1) then
      //B25b-30  Qual estado não permite entrega a domicílio?
      AdicionaErro('785-Rejeição: NFC-e com entrega a domicílio não permitida pela UF');

    GravaLog('Validar: 708-NFCe referenciada');
    if (NFe.Ide.NFref.Count > 0) then
      AdicionaErro('708-Rejeição: NFC-e não pode referenciar documento fiscal');

    GravaLog('Validar: 718-NFCe e IE de ST');
    if NaoEstaVazio(Trim(NFe.Emit.IEST)) then
      AdicionaErro('718-Rejeição: NFC-e não deve informar IE de Substituto Tributário');

    GravaLog('Validar: 787-NFCe entrega e Identificação');
    if (NFe.Ide.indPres = pcEntregaDomicilio) and
      EstaVazio(Trim(nfe.Entrega.xLgr)) and
      EstaVazio(Trim(nfe.Dest.EnderDest.xLgr)) then
      AdicionaErro('787-Rejeição: NFC-e de entrega a domicílio sem a identificação do destinatário');

    GravaLog('Validar: 729-NFCe IE destinatário');
    if NaoEstaVazio(Trim(NFe.Dest.IE)) then
      AdicionaErro('729-Rejeição: NFC-e com informação da IE do destinatário');

    GravaLog('Validar: 730-NFCe e SUFRAMA');
    if NaoEstaVazio(Trim(NFe.Dest.ISUF)) then
      AdicionaErro('730-Rejeição: NFC-e com Inscrição Suframa');

    GravaLog('Validar: 753-NFCe e Frete');
    if (NFe.Transp.modFrete <> mfSemFrete) and
       (NFe.Ide.indPres <> pcEntregaDomicilio)then
      AdicionaErro('753-Rejeição: NFC-e com Frete');

    GravaLog('Validar: 754-NFCe e dados Transporte');
    if (NFe.Ide.indPres <> pcEntregaDomicilio) and
       ((NaoEstaVazio(trim(NFe.Transp.Transporta.CNPJCPF))) or
       (NaoEstaVazio(trim(NFe.Transp.Transporta.xNome))) or
       (NaoEstaVazio(trim(NFe.Transp.Transporta.IE))) or
       (NaoEstaVazio(trim(NFe.Transp.Transporta.xEnder))) or
       (NaoEstaVazio(trim(NFe.Transp.Transporta.xMun))) or
       (NaoEstaVazio(trim(NFe.Transp.Transporta.UF)))) then
      AdicionaErro('754-Rejeição: NFC-e com dados do Transportador');

    GravaLog('Validar: 786-NFCe entrega domicilio e dados Transporte');
    if (NFe.Ide.indPres = pcEntregaDomicilio) and
       ((EstaVazio(trim(NFe.Transp.Transporta.CNPJCPF))) or
       (EstaVazio(trim(NFe.Transp.Transporta.xNome)))) then
      AdicionaErro('786-Rejeição: NFC-e de entrega a domicílio sem dados do Transportador');

    GravaLog('Validar: 755-NFCe retenção ICMS Transporte');
    if (ComparaValor(NFe.Transp.retTransp.vServ, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (ComparaValor(NFe.Transp.retTransp.vBCRet, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (ComparaValor(NFe.Transp.retTransp.pICMSRet, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (ComparaValor(NFe.Transp.retTransp.vICMSRet, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (NaoEstaVazio(Trim(NFe.Transp.retTransp.CFOP))) or
       (ComparaValor(NFe.Transp.retTransp.cMunFG, 0, TOLERANCIA_COMPARACAO_001) > 0) then
      AdicionaErro('755-Rejeição: NFC-e com dados de Retenção do ICMS no Transporte');

    GravaLog('Validar: 756-NFCe dados veiculo Transporte');
    if (NaoEstaVazio(Trim(NFe.Transp.veicTransp.placa))) or
       (NaoEstaVazio(Trim(NFe.Transp.veicTransp.UF))) or
       (NaoEstaVazio(Trim(NFe.Transp.veicTransp.RNTC))) then
      AdicionaErro('756-Rejeição: NFC-e com dados do veículo de Transporte');

    GravaLog('Validar: 757-NFCe dados reboque Transporte');
    if NFe.Transp.Reboque.Count > 0 then
      AdicionaErro('757-Rejeição: NFC-e com dados de Reboque do veículo de Transporte');

    GravaLog('Validar: 758-NFCe dados vagão Transporte');
    if NaoEstaVazio(Trim(NFe.Transp.vagao)) then
      AdicionaErro('758-Rejeição: NFC-e com dados do Vagão de Transporte');

    GravaLog('Validar: 759-NFCe dados Balsa Transporte');
    if NaoEstaVazio(Trim(NFe.Transp.balsa)) then
      AdicionaErro('759-Rejeição: NFC-e com dados da Balsa de Transporte');

    GravaLog('Validar: 760-NFCe entrega dados cobrança');
    if (NaoEstaVazio(Trim(nfe.Cobr.Fat.nFat))) or
       (ComparaValor(NFe.Cobr.Fat.vOrig, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (ComparaValor(NFe.Cobr.Fat.vDesc, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (ComparaValor(NFe.Cobr.Fat.vLiq, 0, TOLERANCIA_COMPARACAO_001) > 0) or
       (NFe.Cobr.Dup.Count > 0) then
      AdicionaErro('760-Rejeição: NFC-e com dados de cobrança (Fatura, Duplicata)');

    GravaLog('Validar: 769-NFCe formas pagamento');
    if NFe.pag.Count <= 0 then
      AdicionaErro('769-Rejeição: NFC-e deve possuir o grupo de Formas de Pagamento');

    GravaLog('Validar: 762-NFCe dados de compra');
    if Trim(NFe.compra.xNEmp) + Trim(NFe.compra.xPed) + Trim(NFe.compra.xCont) <> '' then
      AdicionaErro('762-Rejeição: NFC-e com dados de compras (Empenho, Pedido, Contrato)');

    GravaLog('Validar: 763-NFCe dados cana');
    if NaoEstaVazio(Trim(NFe.cana.safra)) or NaoEstaVazio(Trim(NFe.cana.ref)) or
       (NFe.cana.fordia.Count > 0) or (NFe.cana.deduc.Count > 0) then
      AdicionaErro('763-Rejeição: NFC-e com dados de aquisição de Cana');

end;

procedure TNFeValidarRegras.AdicionaErro(const Erro: string);
begin
  FErros := FErros + Erro + sLineBreak;
end;

function TNFeValidarRegras.Validar(Agora: TDateTime): Boolean;
const
  SEM_GTIN = 'SEM GTIN';
var
  I, J, CodUF: Integer;
  Inicio: TDateTime;
  fsvTotTrib, fsvBC, fsvICMS, fsvICMSDeson, fsvBCST, fsvST, fsvProd, fsvFrete,
  fsvSeg, fsvDesc, fsvII, fsvIPI, fsvPIS, fsvCOFINS, fsvOutro, fsvServ, fsvNF,
  fsvTotPag, fsvPISST, fsvCOFINSST, fsvFCP, fsvFCPST, fsvFCPSTRet, fsvIPIDevol,
  fsvPISServico, fsvCOFINSServico, fsvICMSMonoReten: Currency;
  FaturamentoDireto, NFImportacao, UFCons, bServico : Boolean;
begin
  FpAgora := Agora;
  GravaLog('Inicio da Validação');

  FErros := '';

  RegrasValidasParaAmbosModelos;

  // Regras exclusivas da NF-e
  if NFe.Ide.modelo = 55 then
    RegrasValidasSomenteParaNFe;

  // Regras exclusivas da NFC-e
  if NFe.Ide.modelo = 65 then
    RegrasValidasSomenteParaNFCe;

  GravaLog('Validar: 253-Digito Chave');
  if not ValidarChave(NFe.infNFe.ID) then
    AdicionaErro('253-Rejeição: Digito Verificador da chave de acesso composta inválida');

  GravaLog('Validar: 270-Digito Municipio Fato Gerador');
  if not ValidarMunicipio(NFe.Ide.cMunFG) then //B12-10
    AdicionaErro('270-Rejeição: Código Município do Fato Gerador: dígito inválido');

  GravaLog('Validar: 271-Municipio Fato Gerador diferente');
  if (UFparaCodigoUF(NFe.Emit.EnderEmit.UF) <> StrToIntDef(
    copy(IntToStr(NFe.Ide.cMunFG), 1, 2), 0)) then//GB12.1
    AdicionaErro('271-Rejeição: Código Município do Fato Gerador: difere da UF do emitente');

  GravaLog('Validar: 570-Tipo de Emissão SCAN/SVC');
  if ((NFe.Ide.tpEmis in [teSCAN, teSVCAN, teSVCRS]) and (tpEmis = 1)) then  //B22-30
    AdicionaErro(
      '570-Rejeição: Tipo de Emissão 3, 6 ou 7 só é válido nas contingências SCAN/SVC');
{
  Não existe mais essa regra de validação
  GravaLog('Validar: 571-Tipo de Emissão SCAN');
  if ((NFe.Ide.tpEmis <> teSCAN) and (tpEmis = 6))
  then  //B22-40
    AdicionaErro('571-Rejeição: Tipo de Emissão informado diferente de 3 para contingência SCAN');
}
  GravaLog('Validar: 713-Tipo de Emissão SCAN/SVCRS');
  if ((tpEmis in [6, 7]) and
    (not (NFe.Ide.tpEmis in [teSVCAN, teSVCRS]))) then  //B22-60
    AdicionaErro('713-Rejeição: Tipo de Emissão diferente de 6 ou 7 para contingência da SVC acessada');

  //B23-10
  GravaLog('Validar: 252-Ambiente');
  if (NFe.Ide.tpAmb <> Ambiente) then
    //B24-10
    AdicionaErro('252-Rejeição: Ambiente informado diverge do Ambiente de recebimento '
      + '(Tipo do ambiente da NF-e difere do ambiente do Web Service)');

  GravaLog('Validar: 370-Tipo de Emissão');
  if (NFe.Ide.procEmi in [peAvulsaFisco, peAvulsaContribuinte]) and
    (NFe.Ide.tpEmis <> teNormal) then //B26-30
    AdicionaErro('370-Rejeição: Nota Fiscal Avulsa com tipo de emissão inválido');

  GravaLog('Validar: 556-Justificativa Entrada');
  if (NFe.Ide.tpEmis = teNormal) and ((NFe.Ide.xJust > '') or
    (NFe.Ide.dhCont <> 0)) then
    //B28-10
    AdicionaErro(
      '556-Justificativa de entrada em contingência não deve ser informada para tipo de emissão normal');

  GravaLog('Validar: 557-Justificativa Entrada');
  if (NFe.Ide.tpEmis in [teContingencia, teFSDA, teOffLine]) and
    (EstaVazio(NFe.Ide.xJust)) then //B28-20
    AdicionaErro('557-A Justificativa de entrada em contingência deve ser informada');

  GravaLog('Validar: 558-Data de Entrada');
  if (CompareDate(NFe.Ide.dhCont, Agora) > 0) then //B28-30
    AdicionaErro('558-Rejeição: Data de entrada em contingência posterior a data de recebimento');

  GravaLog('Validar: 569-Data Entrada contingência');
  if (NFe.Ide.dhCont > 0) and ((Agora - NFe.Ide.dhCont) > 30) then //B28-40
    AdicionaErro('569-Rejeição: Data de entrada em contingência muito atrasada');

  GravaLog('Validar: 207-CNPJ emitente');
  // adicionado CNPJ por conta do produtor rural
  if not ValidarCNPJouCPF(NFe.Emit.CNPJCPF) then
    AdicionaErro('207-Rejeição: CNPJ do emitente inválido');

  GravaLog('Validar: 272-Código Município');
  if not ValidarMunicipio(NFe.Emit.EnderEmit.cMun) then
    AdicionaErro('272-Rejeição: Código Município do Emitente: dígito inválido');

  GravaLog('Validar: 273-Código Município difere da UF');
  if (UFparaCodigoUF(NFe.Emit.EnderEmit.UF) <> StrToIntDef(
    copy(IntToStr(NFe.Emit.EnderEmit.cMun), 1, 2), 0)) then
    AdicionaErro('273-Rejeição: Código Município do Emitente: difere da UF do emitente');

  GravaLog('Validar: 229-IE não informada');
  if EstaVazio(NFe.Emit.IE) then
    AdicionaErro('229-Rejeição: IE do emitente não informada');

  GravaLog('Validar: 209-IE inválida');
  if not ValidarIE(NFe.Emit.IE,NFe.Emit.EnderEmit.UF) then
    AdicionaErro('209-Rejeição: IE do emitente inválida ');

  GravaLog('Validar: 208-CNPJ destinatário');
  if (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.Dest.CNPJCPF))) >= 14) and
    not ValidarCNPJ(NFe.Dest.CNPJCPF) then
    AdicionaErro('208-Rejeição: CNPJ do destinatário inválido');

  GravaLog('Validar: 513-EX');
  if SameText(NFe.Retirada.UF, 'EX') and
      (NFe.Retirada.cMun <> 9999999) then
    AdicionaErro('513-Rejeição: Código Município do Local de Retirada deve ser 9999999 para UF retirada = "EX"');

  GravaLog('Validar: 276-Cod Município Retirada inválido');
  if (not SameText(NFe.Retirada.UF, 'EX')) and
     NaoEstaVazio(NFe.Retirada.xMun) and
     not ValidarMunicipio(NFe.Retirada.cMun) then
    AdicionaErro('276-Rejeição: Código Município do Local de Retirada: dígito inválido');

  GravaLog('Validar: 277-Cod Município Retirada diferente UF');
  if NaoEstaVazio(NFe.Retirada.UF) and (NFe.Retirada.cMun > 0) then
  begin
    if SameText(NFe.Retirada.UF, 'EX') then
      CodUF := 99
    else
      CodUF := UFparaCodigoUF(NFe.Retirada.UF);

    if (CodUF <> StrToIntDef(Copy(IntToStr(NFe.Retirada.cMun), 1, 2), 0)) then
      AdicionaErro('277-Rejeição: Código Município do Local de Retirada: difere da UF do Local de Retirada');
  end;

  GravaLog('Validar: 515-Cod Município Entrega EX');
  if (NFe.Entrega.UF = 'EX') and
     (NFe.Entrega.cMun <> 9999999) then
    AdicionaErro('515-Rejeição: Código Município do Local de Entrega deve ser 9999999 para UF entrega = "EX"');

  GravaLog('Validar: 278-Cod Município Entrega inválido');
  if (not SameText(NFe.Entrega.UF, 'EX')) and
     NaoEstaVazio(NFe.Entrega.xMun) and
     not ValidarMunicipio(NFe.Entrega.cMun) then
    AdicionaErro('278-Rejeição: Código Município do Local de Entrega: dígito inválido');

  GravaLog('Validar: 279-Cod Município Entrega diferente UF');
  if NaoEstaVazio(NFe.Entrega.UF) and (NFe.Entrega.cMun > 0) then
  begin
    if SameText(NFe.Entrega.UF, 'EX') then
      CodUF := 99
    else
      CodUF := UFparaCodigoUF(NFe.Entrega.UF);

    if (CodUF <> StrToIntDef(Copy(IntToStr(NFe.Entrega.cMun), 1, 2), 0)) then
      AdicionaErro('279-Rejeição: Código Município do Local de Entrega: difere da UF do Local de Entrega');
  end;

  GravaLog('Validar: 542-CNPJ Transportador');
  if NaoEstaVazio(Trim(NFe.Transp.Transporta.CNPJCPF)) and
     (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.Transp.Transporta.CNPJCPF))) >= 14) and
     not ValidarCNPJ(NFe.Transp.Transporta.CNPJCPF) then
    AdicionaErro('542-Rejeição: CNPJ do Transportador inválido');

  GravaLog('Validar: 543-CPF Transportador');
  if NaoEstaVazio(Trim(NFe.Transp.Transporta.CNPJCPF)) and
     (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.Transp.Transporta.CNPJCPF))) <= 11) and
     not ValidarCPF(NFe.Transp.Transporta.CNPJCPF) then
    AdicionaErro('543-Rejeição: CPF do Transportador inválido');

  GravaLog('Validar: 559-UF do Transportador');
  if NaoEstaVazio(Trim(NFe.Transp.Transporta.IE)) and
     EstaVazio(Trim(NFe.Transp.Transporta.UF)) then
    AdicionaErro('559-Rejeição: UF do Transportador não informada');

  GravaLog('Validar: 544-IE do Transportador');
  if NaoEstaVazio(Trim(NFe.Transp.Transporta.IE)) and
     not ValidarIE(NFe.Transp.Transporta.IE,NFe.Transp.Transporta.UF) then
    AdicionaErro('544-Rejeição: IE do Transportador inválida');

  for I:=0 to NFe.autXML.Count-1 do
  begin
    GravaLog('Validar: 325-'+IntToStr(I)+'-CPF download');
    if (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.autXML[I].CNPJCPF))) <= 11) and
      not ValidarCPF(NFe.autXML[I].CNPJCPF) then
      AdicionaErro('325-Rejeição: CPF autorizado para download inválido');

    GravaLog('Validar: 323-'+IntToStr(I)+'-CNPJ download');
    if (Length(Trim(OnlyCPFCNPJAlphaNum(NFe.autXML[I].CNPJCPF))) > 11) and
      not ValidarCNPJ(NFe.autXML[I].CNPJCPF) then
      AdicionaErro('323-Rejeição: CNPJ autorizado para download inválido');
  end;

  fsvTotTrib := 0;
  fsvBC      := 0;
  fsvICMS    := 0;
  fsvICMSDeson    := 0;
  fsvBCST    := 0;
  fsvST      := 0;
  fsvProd    := 0;
  fsvFrete   := 0;
  fsvSeg     := 0;
  fsvDesc    := 0;
  fsvII      := 0;
  fsvIPI     := 0;
  fsvPIS     := 0;
  fsvCOFINS  := 0;
  fsvOutro   := 0;
  fsvServ    := 0;
  fsvFCP     := 0;
  fsvFCPST   := 0;
  fsvFCPSTRet:= 0;
  fsvIPIDevol:= 0;
  fsvPISServico := 0;
  fsvCOFINSServico := 0;
  fsvPISST     := 0;
  fsvCOFINSST  := 0;
  fsvICMSMonoReten := 0;

  FaturamentoDireto := False;
  NFImportacao := False;
  UFCons := False;

  for I:=0 to NFe.Det.Count-1 do
  begin
    with NFe.Det[I] do
    begin
      bServico := SameText(Trim(Prod.NCM), '00') or NaoEstaVazio(Trim(Imposto.ISSQN.cListServ));
      if (not bServico) then
      begin
        // validar NCM completo somente quando não for serviço
        GravaLog('Validar: 777-NCM info [nItem: '+IntToStr(Prod.nItem)+']');
        if Length(Trim(Prod.NCM)) < 8 then
          AdicionaErro('777-Rejeição: Obrigatória a informação do NCM completo [nItem: '+IntToStr(Prod.nItem)+']');
      end;

      if (NFe.Ide.modelo = 65) then
      begin
        GravaLog('Validar: 383-NFCe Item com CSOSN indevido [nItem: '+IntToStr(Prod.nItem)+']');
        if Imposto.ICMS.CSOSN in [csosn101, csosn201, csosn202, csosn203]  then
          AdicionaErro('383-Rejeição: NFC-e Item com CSOSN indevido [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 766-NFCe Item com CST indevido [nItem: '+IntToStr(Prod.nItem)+']');
        if Imposto.ICMS.CST in [cst10, cst30, cst50, cst51, cst70]  then
          AdicionaErro('766-Rejeição: NFC-e Item com CST indevido [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 725-NFCe CFOP invalido [nItem: '+IntToStr(Prod.nItem)+']');
        if (pos(OnlyNumber(Prod.CFOP), 'XXXX,5101,5102,5103,5104,5115,5405,5656,5667,5933,5949') <= 0)  then
          AdicionaErro('725-Rejeição: NFC-e com CFOP inválido [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 774-NFCe indicador Total [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.IndTot = itNaoSomaTotalNFe) then
          AdicionaErro('774-Rejeição: NFC-e com indicador de item não participante do total [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 736-NFCe Grupo veiculos novos [nItem: '+IntToStr(Prod.nItem)+']');
        if (NaoEstaVazio(Prod.veicProd.chassi)) then
          AdicionaErro('736-Rejeição: NFC-e com grupo de Veículos novos [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 738-NFCe grupo Armamentos [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.arma.Count > 0) then
          AdicionaErro('738-Rejeição: NFC-e com grupo de Armamentos [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 348-NFCe grupo RECOPI [nItem: '+IntToStr(Prod.nItem)+']');
        if (NaoEstaVazio(Prod.nRECOPI)) then
          AdicionaErro('348-Rejeição: NFC-e com grupo RECOPI [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 740-NFCe CST 51 [nItem: '+IntToStr(Prod.nItem)+']');
        if (Imposto.ICMS.CST = cst51) then
          AdicionaErro('740-Rejeição: NFC-e com CST 51-Diferimento [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 741-NFCe partilha ICMS [nItem: '+IntToStr(Prod.nItem)+']');
        if (Imposto.ICMS.CST in [cstPart10,cstPart90]) then
          AdicionaErro('741-Rejeição: NFC-e com Partilha de ICMS entre UF [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 742-NFCe grupo IPI [nItem: '+IntToStr(Prod.nItem)+']');
        if ((NaoEstaVazio(Imposto.IPI.cEnq)) or
            (ComparaValor(Imposto.IPI.vBC, 0, TOLERANCIA_COMPARACAO_001) <> 0) or
            (ComparaValor(Imposto.IPI.qUnid, 0, TOLERANCIA_COMPARACAO_001) <> 0) or
            (ComparaValor(Imposto.IPI.vUnid, 0, TOLERANCIA_COMPARACAO_001) <> 0) or
            (ComparaValor(Imposto.IPI.pIPI, 0, TOLERANCIA_COMPARACAO_001) <> 0) or
            (ComparaValor(Imposto.IPI.vIPI, 0, TOLERANCIA_COMPARACAO_001) <> 0)) then
          AdicionaErro('742-Rejeição: NFC-e com grupo do IPI [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 743-NFCe grupo II [nItem: '+IntToStr(Prod.nItem)+']');
        if (ComparaValor(Imposto.II.vBc, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.II.vDespAdu, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.II.vII, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.II.vIOF, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (SameText(Copy(Prod.CFOP,1,1), '3')) then
          AdicionaErro('743-Rejeição: NFC-e com grupo do II [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 746-NFCe grupo PIS-ST [nItem: '+IntToStr(Prod.nItem)+']');
        if (ComparaValor(Imposto.PISST.vBc, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.PISST.pPis, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.PISST.qBCProd, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.PISST.vAliqProd, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.PISST.vPIS, 0, TOLERANCIA_COMPARACAO_001) > 0) then
         AdicionaErro('746-Rejeição: NFC-e com grupo do PIS-ST [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 749-NFCe grupo COFINS-ST [nItem: '+IntToStr(Prod.nItem)+']');
        if (ComparaValor(Imposto.COFINSST.vBC, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.COFINSST.pCOFINS, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.COFINSST.qBCProd, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.COFINSST.vAliqProd, 0, TOLERANCIA_COMPARACAO_001) > 0) or
           (ComparaValor(Imposto.COFINSST.vCOFINS, 0, TOLERANCIA_COMPARACAO_001) > 0) then
          AdicionaErro('749-Rejeição: NFC-e com grupo da COFINS-ST [nItem: '+IntToStr(Prod.nItem)+']');
      end
      else if(NFe.Ide.modelo = 55) then
      begin
        if (NFe.infNFe.Versao >= 4) then
        begin
{           GravaLog('Validar: 508-CST incompatível na operação com Não Contribuinte [nItem: '+IntToStr(Prod.nItem)+']');
          if (NFe.Emit.CRT <> crtSimplesNacional) and
             (NFe.Dest.indIEDest = inNaoContribuinte) and
             (NFe.Ide.tpNF <> tnEntrada) and
             (pos(OnlyNumber(Prod.CFOP), 'XXXX,5915,5916,6915,6916,5912,5913') <= 0) and
             (EstaVazio(Prod.veicProd.chassi) or (NaoEstaVazio(Prod.veicProd.chassi) and not (Prod.veicProd.tpOP in [toFaturamentoDireto, toVendaDireta]))) and
             (not (Imposto.ICMS.CST in [cst00, cst20, cst40, cst41, cst60])) then
            AdicionaErro('508-Rejeição: CST incompatível na operação com Não Contribuinte [nItem: '+IntToStr(Prod.nItem)+']');

          GravaLog('Validar: 529-CST incompatível na operação com Contribuinte Isento de Inscrição Estadual [nItem: '+IntToStr(Prod.nItem)+']');
          if (NFe.Dest.indIEDest = inIsento) and
             ((Imposto.ICMS.CST = cst51) or
             ((Imposto.ICMS.CST = cst50) and (pos(OnlyNumber(Prod.CFOP), 'XXXX,5915,5916,6915,6916,5912,5913') <= 0))) then
           AdicionaErro('529-Rejeição: CST incompatível na operação com Contribuinte Isento de Inscrição Estadual [nItem: '+IntToStr(Prod.nItem)+']');

          GravaLog('Validar: 600-CSOSN incompatível na operação com Não Contribuinte [nItem: '+IntToStr(Prod.nItem)+']');
          if (NFe.Emit.CRT = crtSimplesNacional) and
             (NFe.Dest.indIEDest = inNaoContribuinte) and
             (NFe.Ide.tpNF <> tnEntrada) and
             (pos(OnlyNumber(Prod.CFOP), 'XXXX,5915,5916,6915,6916,5912,5913') <= 0) and
             (EstaVazio(Prod.veicProd.chassi) or (NaoEstaVazio(Prod.veicProd.chassi) and not (Prod.veicProd.tpOP in [toFaturamentoDireto, toVendaDireta]))) and
             (not (Imposto.ICMS.CSOSN in [csosn102, csosn103, csosn300, csosn400, csosn500])) then
            AdicionaErro('600-Rejeição: CSOSN incompatível na operação com Não Contribuinte [nItem: '+IntToStr(Prod.nItem)+']');

          GravaLog('Validar: 806-Operação com ICMS-ST sem informação do CEST [nItem: '+IntToStr(Prod.nItem)+']');
          if (not Imposto.ICMS.CST in [cstPart10,cstPart90]) and
             EstaVazio(Prod.CEST) and
             (((NFe.Emit.CRT = crtSimplesNacional) and (Imposto.ICMS.CSOSN in [csosn201, csosn202, csosn203, csosn500, csosn900])) or
              ((NFe.Emit.CRT <> crtSimplesNacional) and (Imposto.ICMS.CST in [cst10, cst30, cst60, cst70, cst90]))) then
            AdicionaErro('806-Rejeição: Operação com ICMS-ST sem informação do CEST [nItem: '+IntToStr(Prod.nItem)+']');           }

{            GravaLog('Validar: 856-Obrigatória a informação do campo vPart (id: LA03d) para produto "210203001 – GLP" (tag:cProdANP) [nItem: '+IntToStr(Prod.nItem)+']');
          if (Prod.comb.cProdANP = 210203001) and (Prod.comb.vPart <= 0) then
            AdicionaErro('856-Rejeição: Campo valor de partida não preenchido para produto GLP [nItem: '+IntToStr(Prod.nItem)+']'); }

{            GravaLog('Validar: 858-Grupo ICMS60 (id:N08) informado indevidamente nas operações com os produtos combustíveis sujeitos a repasse interestadual [nItem: '+IntToStr(Prod.nItem)+']');
          if (Prod.comb.cProdANP = '210203001') and (Imposto.ICMS.CST = cst60 and Imposto.ICMS.vICMSSTDest <= 0) then
            AdicionaErro('858-Rejeição: Grupo de Tributação informado indevidamente [nItem: '+IntToStr(Prod.nItem)+']');    }//VERIFICAR


        end;
      end;

      {
      GravaLog('Validar: 629-Produto do valor unitário e quantidade comercializada [nItem: ' + IntToStr(Prod.nItem) + ']');
      if (NFe.ide.finNFe = fnNormal) and (ComparaValor(Prod.vProd, Prod.vUnCom * Prod.qCom, 0.01) <> 0) then
        AdicionaErro('629-Rejeição: Valor do Produto difere do produto Valor Unitário de Comercialização e Quantidade Comercial [nItem: ' + IntToStr(Prod.nItem) + ']');

      GravaLog('Validar: 630-Produto do valor unitário e quantidade tributável [nItem: ' + IntToStr(Prod.nItem) + ']');
      if (NFe.ide.finNFe = fnNormal) and (ComparaValor(Prod.vProd, Prod.vUnTrib * Prod.qTrib, 0.01) <> 0) then
        AdicionaErro('630-Rejeição: Valor do Produto difere do produto Valor Unitário de Tributação e Quantidade Tributável [nItem: ' + IntToStr(Prod.nItem) + ']');
      }
      GravaLog('Validar: 528-ICMS BC e Aliq [nItem: '+IntToStr(Prod.nItem)+']');
      if (Imposto.ICMS.CST in [cst00,cst10,cst20,cst70]) and
         (NFe.Ide.finNFe = fnNormal) and
       (ComparaValor(Imposto.ICMS.vICMS, Imposto.ICMS.vBC * (Imposto.ICMS.pICMS/100), TOLERANCIA_COMPARACAO_01) <> 0) then
        AdicionaErro('528-Rejeição: Valor do ICMS difere do produto BC e Alíquota [nItem: '+IntToStr(Prod.nItem)+']');

      GravaLog('Validar: 625-Insc.SUFRAMA [nItem: '+IntToStr(Prod.nItem)+']');
      if (Imposto.ICMS.motDesICMS = mdiSuframa) and
         (EstaVazio(NFe.Dest.ISUF))then
        AdicionaErro('625-Rejeição: Inscrição SUFRAMA deve ser informada na venda com isenção para ZFM [nItem: '+IntToStr(Prod.nItem)+']');

      GravaLog('Validar: 530-ISSQN e IM [nItem: '+IntToStr(Prod.nItem)+']');
      if EstaVazio(NFe.Emit.IM) and
        ((ComparaValor(Imposto.ISSQN.vBC, 0, TOLERANCIA_COMPARACAO_001) > 0) or
         (ComparaValor(Imposto.ISSQN.vAliq, 0, TOLERANCIA_COMPARACAO_001) > 0) or
         (ComparaValor(Imposto.ISSQN.vISSQN, 0, TOLERANCIA_COMPARACAO_001) > 0) or
         (ComparaValor(Imposto.ISSQN.cMunFG, 0, TOLERANCIA_COMPARACAO_001) > 0) or
         (NaoEstaVazio(Imposto.ISSQN.cListServ))) then
        AdicionaErro('530-Rejeição: Operação com tributação de ISSQN sem informar a Inscrição Municipal [nItem: '+IntToStr(Prod.nItem)+']');

      GravaLog('Validar: 287-Cod.Município FG [nItem: '+IntToStr(Prod.nItem)+']');
      if (Imposto.ISSQN.cMunFG > 0) and
         not ValidarMunicipio(Imposto.ISSQN.cMunFG) then
        AdicionaErro('287-Rejeição: Código Município do FG - ISSQN: dígito inválido [nItem: '+IntToStr(Prod.nItem)+']');

      if (NFe.infNFe.Versao >= 4) then
      begin
        if (EstaVazio(Trim(Prod.cEAN))) then
        begin
          //somente aplicavel em produção a partir de 01/12/2018
          //GravaLog('Validar: 883-GTIN (cEAN) sem informação [nItem:' + IntToStr(I) + ']');
          //AdicionaErro('883-Rejeição: GTIN (cEAN) sem informação [nItem:' + IntToStr(I) + ']');
        end
        else
        begin
          if (not SameText(Prod.cEAN, SEM_GTIN)) then
          begin
            GravaLog('Validar: 611-GTIN (cEAN) inválido [nItem: '+IntToStr(Prod.nItem)+']');
            if not ValidarGTIN(Prod.cEAN) then
              AdicionaErro('611-Rejeição: GTIN (cEAN) inválido [nItem: '+IntToStr(Prod.nItem)+']');

            GravaLog('Validar: 882-GTIN (cEAN) com prefixo inválido [nItem: '+IntToStr(Prod.nItem)+']');
            if not ValidarPrefixoGTIN(Prod.cEAN) then
              AdicionaErro('882-Rejeição: GTIN (cEAN) com prefixo inválido [nItem: '+IntToStr(Prod.nItem)+']');

            GravaLog('Validar: 885-GTIN informado, mas não informado o GTIN da unidade tributável [nItem: '+IntToStr(Prod.nItem)+']');
            if EstaVazio(Trim(Prod.cEANTrib)) or (SameText(Trim(Prod.cEANTrib), SEM_GTIN)) then
              AdicionaErro('885-Rejeição: GTIN informado, mas não informado o GTIN da unidade tributável [nItem: '+IntToStr(Prod.nItem)+']');
          end;
        end;

        if (EstaVazio(Trim(Prod.cEANTrib))) then
        begin
          //somente aplicavel em produção a partir de 01/12/2018
          //GravaLog('Validar: 888-GTIN da unidade tributável (cEANTrib) sem informação [nItem:' + IntToStr(I) + ']');
          //AdicionaErro('888-Rejeição: GTIN da unidade tributável (cEANTrib) sem informação [nItem: '+IntToStr(Prod.nItem)+']');
        end
        else
        begin
          if (not SameText(Prod.cEANTrib, SEM_GTIN)) then
          begin
            GravaLog('Validar: 612-GTIN da unidade tributável (cEANTrib) inválido [nItem: '+IntToStr(Prod.nItem)+']');
            if not ValidarGTIN(Prod.cEANTrib) then
              AdicionaErro('612-Rejeição: GTIN da unidade tributável (cEANTrib) inválido [nItem: '+IntToStr(Prod.nItem)+']');

            GravaLog('Validar: 884-GTIN da unidade tributável (cEANTrib) com prefixo inválido [nItem: '+IntToStr(Prod.nItem)+']');
            if not ValidarPrefixoGTIN(Prod.cEANTrib) then
              AdicionaErro('884-Rejeição: GTIN da unidade tributável (cEANTrib) com prefixo inválido [nItem: '+IntToStr(Prod.nItem)+']');

            GravaLog('Validar: 886-GTIN da unidade tributável informado, mas não informado o GTIN [nItem: '+IntToStr(Prod.nItem)+']');
            if EstaVazio(Trim(Prod.cEAN)) or (SameText(Trim(Prod.cEAN), SEM_GTIN)) then
              AdicionaErro('886-Rejeição: GTIN da unidade tributável informado, mas não informado o GTIN [nItem: '+IntToStr(Prod.nItem)+']');
          end;
        end;

        GravaLog('Validação: 889-Obrigatória a informação do GTIN para o produto [nItem: '+IntToStr(Prod.nItem)+']');
        if (EstaVazio(Trim(Prod.cEAN))) then
          AdicionaErro('889-Rejeição: Obrigatória a informação do GTIN para o produto [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 879-Se informado indEscala=N- não relevante (id: I05d), deve ser informado CNPJ do Fabricante da Mercadoria (id: I05e) [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.indEscala = ieNaoRelevante) and
           EstaVazio(Prod.CNPJFab) then
          AdicionaErro('879-Rejeição: Informado item Produzido em Escala NÃO Relevante e não informado CNPJ do Fabricante [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 489-Se informado CNPJFab (id: I05e) - CNPJ inválido (DV, zeros) [nItem: '+IntToStr(Prod.nItem)+']');
        if NaoEstaVazio(Prod.CNPJFab) and (not ValidarCNPJ(Prod.CNPJFab)) then
          AdicionaErro('489-Rejeição: CNPJFab informado inválido (DV ou zeros) [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 854-Informado campo cProdANP (id: LA02) = 210203001 (GLP) e campo uTrib (id: I13) <> “kg” (ignorar a diferenciação entre maiúsculas e minúsculas) [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.comb.cProdANP = 210203001) and (not SameText(Prod.uTrib, 'KG')) then
          AdicionaErro('854-Rejeição: Unidade Tributável (tag:uTrib) incompatível com produto informado [nItem: '+IntToStr(Prod.nItem)+']');

        if not UFCons then
          UFCons := NaoEstaVazio(Prod.comb.UFcons) and (not SameText(Prod.comb.UFcons, NFe.emit.EnderEmit.UF));

        for J:=0 to Prod.rastro.Count-1 do
        begin
          GravaLog('Validar: 877-Data de Fabricação dFab (id:I83) maior que a data de processamento [nItem: '+IntToStr(Prod.nItem)+']');
          if (Prod.rastro.Items[J].dFab > NFe.Ide.dEmi) then
            AdicionaErro('877-Rejeição: Data de fabricação maior que a data de processamento [nItem: '+IntToStr(Prod.nItem)+']');

          GravaLog('Validar: 870-Informada data de validade dVal(id: I84) menor que Data de Fabricação dFab (id: I83) [nItem: '+IntToStr(Prod.nItem)+']');
          if (Prod.rastro.Items[J].dVal < Prod.rastro.Items[J].dFab) then
            AdicionaErro('870-Rejeição: Data de validade incompatível com data de fabricação [nItem: '+IntToStr(Prod.nItem)+']');
        end;

        for J:=0 to Prod.med.Count-1 do
        begin
          GravaLog('Validar: 873-Se informado Grupo de Medicamentos (tag:med) obrigatório preenchimento do grupo rastro (id: I80) [nItem: '+IntToStr(Prod.nItem)+']');
          if NaoEstaVazio(Prod.med[J].cProdANVISA)
             and (Prod.rastro.Count<=0)
             and (not (NFe.Ide.finNFe in [fnDevolucao,fnAjuste,fnComplementar])) // exceção 1
             and (not (NFe.Ide.indPres in [pcInternet, pcTeleatendimento]))      // exceção 2
             and (AnsiIndexStr(Prod.CFOP,['5922','6922','5118','6118',               // exceção 3 CFOP's excluidos da validação
                                      '5119','6119','5120','6120'  ]) = -1)
             and (NFe.Ide.tpNF = tnSaida)                                        // exceção 4
          then
            AdicionaErro('873-Rejeição: Operação com medicamentos e não informado os campos de rastreabilidade [nItem: '+IntToStr(Prod.nItem)+']');
        end;

        GravaLog('Validar: 461-Informado percentual do GLP (id: LA03a) ou percentual de Gás Natural Nacional (id: LA03b) ou percentual de Gás Natural Importado (id: LA03c) para produto diferente de "210203001 – GLP" (tag:cProdANP) [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.comb.cProdANP <> 210203001) and ((Prod.comb.pGLP > 0) or (Prod.comb.pGNn > 0) or (Prod.comb.pGNi > 0)) then
          AdicionaErro('461-Rejeição: Informado campos de percentual de GLP e/ou GLGNn e/ou GLGNi para produto diferente de GLP [nItem: '+IntToStr(Prod.nItem)+']');

        GravaLog('Validar: 855-Informado percentual do GLP (id: LA03a) ou percentual de Gás Natural Nacional (id: LA03b) ou percentual de Gás Natural Importado (id: LA03c) para produto diferente de "210203001 – GLP" (tag:cProdANP) [nItem: '+IntToStr(Prod.nItem)+']');
        if (Prod.comb.cProdANP = 210203001) and ((Prod.comb.pGLP + Prod.comb.pGNn + Prod.comb.pGNi) <> 100) then
          AdicionaErro('855-Rejeição: Somatório percentuais de GLP derivado do petróleo, GLGNn e GLGNi diferente de 100 [nItem: '+IntToStr(Prod.nItem)+']');
      end;

      // Valores somados independentemente de IndTot
      fsvTotTrib  := fsvTotTrib + Imposto.vTotTrib;
      fsvFrete    := fsvFrete + Prod.vFrete;
      fsvSeg      := fsvSeg + Prod.vSeg;
      fsvOutro    := fsvOutro + Prod.vOutro;
      fsvDesc     := fsvDesc + Prod.vDesc;
      fsvII       := fsvII + Imposto.II.vII;
      fsvIPI      := fsvIPI + Imposto.IPI.vIPI;
      fsvIPIDevol := fsvIPIDevol + vIPIDevol;
      fsvICMSDeson := fsvICMSDeson + Imposto.ICMS.vICMSDeson;

      if bServico then
      begin
        fsvPISServico    := fsvPISServico + Imposto.PIS.vPIS;
        fsvCOFINSServico := fsvCOFINSServico + Imposto.COFINS.vCOFINS;
      end
      else
      begin
        fsvPIS     := fsvPIS + Imposto.PIS.vPIS;
        fsvCOFINS  := fsvCOFINS + Imposto.COFINS.vCOFINS;
      end;

      // Valores somados se IndTot = itSomaTotalNFe
      if Prod.IndTot = itSomaTotalNFe then
      begin
        fsvBC        := fsvBC + Imposto.ICMS.vBC;
        fsvICMS      := fsvICMS + Imposto.ICMS.vICMS;
        fsvBCST      := fsvBCST + Imposto.ICMS.vBCST;
        fsvST        := fsvST + Imposto.ICMS.vICMSST;
        fsvFCP       := fsvFCP + Imposto.ICMS.vFCP;
        fsvFCPST     := fsvFCPST + Imposto.ICMS.vFCPST;
        fsvFCPSTRet  := fsvFCPSTRet + Imposto.ICMS.vFCPSTRet;
        fsvICMSMonoReten := fsvICMSMonoReten + Imposto.ICMS.vICMSMonoReten;

        // Verificar se compõe PIS ST e COFINS ST
        if (Imposto.PISST.indSomaPISST = ispPISSTCompoe) then
          fsvPISST := fsvPISST + Imposto.PISST.vPIS;
        if (Imposto.COFINSST.indSomaCOFINSST = iscCOFINSSTCompoe) then
          fsvCOFINSST := fsvCOFINSST + Imposto.COFINSST.vCOFINS;

        // Quando for serviço o produto não soma no total de produtos, quando for nota de ajuste também irá somar
        if (not bServico) or (NFe.Ide.finNFe = fnAjuste) then
          fsvProd := fsvProd + Prod.vProd;
      end;

      if Prod.veicProd.tpOP = toFaturamentoDireto then
        FaturamentoDireto := True;

      if SameText(Copy(Prod.CFOP, 1, 1), '3') then
        NFImportacao := True;
    end;
  end;

  // O campo abaixo é pego diretamento do total. Não foi implementada validação 605 para os itens.
  fsvServ := NFe.Total.ISSQNtot.vServ;

  if not UFCons then
  begin
    GravaLog('Validar: 772-Op.Interestadual e UF igual');
    if (nfe.Ide.idDest = doInterestadual) and
       SameText(NFe.Dest.EnderDest.UF, NFe.Emit.EnderEmit.UF) and
       (not SameText(NFe.Dest.CNPJCPF, NFe.Emit.CNPJCPF)) and
       SameText(NFe.Entrega.UF, NFe.Emit.EnderEmit.UF) then
      AdicionaErro('772-Rejeição: Operação Interestadual e UF de destino igual à UF do emitente');
  end;

  if FaturamentoDireto then
    fsvNF := (fsvProd + fsvFrete + fsvSeg + fsvOutro + fsvII + fsvIPI +
              fsvServ + fsvPISST + fsvCOFINSST) - (fsvDesc + fsvICMSDeson)
  else
    fsvNF := (fsvProd + fsvST + fsvFrete + fsvSeg + fsvOutro + fsvII + fsvIPI +
              fsvServ + fsvFCPST + fsvICMSMonoReten + fsvIPIDevol + fsvPISST +
              fsvCOFINSST) - (fsvDesc + fsvICMSDeson);

  GravaLog('Validar: 531-Total BC ICMS');
  if (ComparaValor(NFe.Total.ICMSTot.vBC, fsvBC, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('531-Rejeição: Total da BC ICMS difere do somatório dos itens');

  GravaLog('Validar: 532-Total ICMS');
  if (ComparaValor(NFe.Total.ICMSTot.vICMS, fsvICMS, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('532-Rejeição: Total do ICMS difere do somatório dos itens');

  GravaLog('Validar: 795-Total ICMS desonerado');
  if (ComparaValor(NFe.Total.ICMSTot.vICMSDeson, fsvICMSDeson, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('795-Rejeição: Total do ICMS desonerado difere do somatório dos itens');

  GravaLog('Validar: 533-Total BC ICMS-ST');
  if (ComparaValor(NFe.Total.ICMSTot.vBCST, fsvBCST, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('533-Rejeição: Total da BC ICMS-ST difere do somatório dos itens');

  GravaLog('Validar: 534-Total ICMS-ST');
  if (ComparaValor(NFe.Total.ICMSTot.vST, fsvST, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('534-Rejeição: Total do ICMS-ST difere do somatório dos itens');

  GravaLog('Validar: 564-Total Produto/Serviço');
  if (ComparaValor(NFe.Total.ICMSTot.vProd, fsvProd, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('564-Rejeição: Total do Produto / Serviço difere do somatório dos itens');

  GravaLog('Validar: 535-Total Frete');
  if (ComparaValor(NFe.Total.ICMSTot.vFrete, fsvFrete, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('535-Rejeição: Total do Frete difere do somatório dos itens');

  GravaLog('Validar: 536-Total Seguro');
  if (ComparaValor(NFe.Total.ICMSTot.vSeg, fsvSeg, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('536-Rejeição: Total do Seguro difere do somatório dos itens');

  GravaLog('Validar: 537-Total Desconto');
  if (ComparaValor(NFe.Total.ICMSTot.vDesc, fsvDesc, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('537-Rejeição: Total do Desconto difere do somatório dos itens');

GravaLog('Validar: 601-Total II');
  if (ComparaValor(NFe.Total.ICMSTot.vII, fsvII, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('601-Rejeição: Total do II difere do somatório dos itens');

  GravaLog('Validar: 538-Total IPI');
  if (ComparaValor(NFe.Total.ICMSTot.vIPI, fsvIPI, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('538-Rejeição: Total do IPI difere do somatório dos itens');

  GravaLog('Validar: 602-Total PIS');
  if (ComparaValor(NFe.Total.ICMSTot.vPIS, fsvPIS, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('602-Rejeição: Total do PIS difere do somatório dos itens sujeitos ao ICMS');

  GravaLog('Validar: 603-Total COFINS');
  if (ComparaValor(NFe.Total.ICMSTot.vCOFINS, fsvCOFINS, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('603-Rejeição: Total da COFINS difere do somatório dos itens sujeitos ao ICMS');

  GravaLog('Validar: 604-Total vOutro');
  if (ComparaValor(NFe.Total.ICMSTot.vOutro, fsvOutro, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('604-Rejeição: Total do vOutro difere do somatório dos itens');

  GravaLog('Validar: 608-Total PIS ISSQN');
  if (ComparaValor(NFe.Total.ISSQNtot.vPIS, fsvPISServico, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('608-Rejeição: Total do PIS difere do somatório dos itens sujeitos ao ISSQN');

  GravaLog('Validar: 609-Total COFINS ISSQN');
  if (ComparaValor(NFe.Total.ISSQNtot.vCOFINS, fsvCOFINSServico, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('609-Rejeição: Total da COFINS difere do somatório dos itens sujeitos ao ISSQN');

  GravaLog('Validar: 861-Total do FCP');
  if (ComparaValor(NFe.Total.ICMSTot.vFCP, fsvFCP, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('861-Rejeição: Total do FCP difere do somatório dos itens');

  if (NFe.Ide.modelo = 55) then  //Regras válidas apenas para NF-e - 55
  begin
    GravaLog('Validar: 862-Total do FCP ST');
    if (ComparaValor(NFe.Total.ICMSTot.vFCPST, fsvFCPST, TOLERANCIA_COMPARACAO_001) <> 0) then
      AdicionaErro('862-Rejeição: Total do FCP ST difere do somatório dos itens');

    GravaLog('Validar: 859-Total do FCP ST retido anteriormente');
    if (ComparaValor(NFe.Total.ICMSTot.vFCPSTRet, fsvFCPSTRet, TOLERANCIA_COMPARACAO_001) <> 0) then
      AdicionaErro('859-Rejeição: Total do FCP retido anteriormente por Substituição Tributária difere do somatório dos itens');

    GravaLog('Validar: 863-Total do IPI devolvido');
    if (ComparaValor(NFe.Total.ICMSTot.vIPIDevol, fsvIPIDevol, TOLERANCIA_COMPARACAO_001) <> 0) then
      AdicionaErro('863-Rejeição: Total do IPI devolvido difere do somatório dos itens');
  end;

  GravaLog('Validar: 610-Total NF');
  if not NFImportacao and
     (ComparaValor(NFe.Total.ICMSTot.vNF, fsvNF, TOLERANCIA_COMPARACAO_001) <> 0) then
  begin
    if (ComparaValor(NFe.Total.ICMSTot.vNF, fsvNF, 0.009) <> 0) and (ComparaValor(NFe.Total.ICMSTot.vNF, fsvNF + fsvICMSDeson, 0.009) <> 0) then
      AdicionaErro('610-Rejeição: Total da NF difere do somatório dos Valores compõe o valor Total da NF.');
  end;

  GravaLog('Validar: 685-Total Tributos');
  if (ComparaValor(NFe.Total.ICMSTot.vTotTrib, fsvTotTrib, TOLERANCIA_COMPARACAO_001) <> 0) then
    AdicionaErro('685-Rejeição: Total do Valor Aproximado dos Tributos difere do somatório dos itens');

  if (NFe.Ide.modelo = 65) and (NFe.infNFe.Versao < 4) then
  begin
    GravaLog('Validar: 767-NFCe soma pagamentos');
    fsvTotPag := 0;
    for I := 0 to NFe.pag.Count-1 do
    begin
      fsvTotPag :=  fsvTotPag + NFe.pag[I].vPag;
    end;

    if (ComparaValor(NFe.Total.ICMSTot.vNF, fsvTotPag, TOLERANCIA_COMPARACAO_001) <> 0) then
      AdicionaErro('767-Rejeição: NFC-e com somatório dos pagamentos diferente do total da Nota Fiscal');
  end
  else if (NFe.infNFe.Versao >= 4) then
  begin
    case NFe.Ide.finNFe of
      fnNormal, fnComplementar:
      begin
        fsvTotPag := 0;
        for I := 0 to NFe.pag.Count-1 do
        begin
          fsvTotPag :=  fsvTotPag + NFe.pag[I].vPag;
        end;

        {
          ** Validação removida na NT 2016.002 v1.10
        GravaLog('Validar: 767-Soma dos pagamentos');
        if (fsvTotPag < NFe.Total.ICMSTot.vNF) then
          AdicionaErro('767-Rejeição: Somatório dos pagamentos diferente do total da Nota Fiscal');
        }

        if (NFe.Ide.modelo = 65) then
        begin
          GravaLog('Validar: 899-NFCe sem pagamento');
          for I := 0 to NFe.pag.Count - 1 do
          begin
            if (NFe.pag[I].tPag = fpSemPagamento) then
            begin
              AdicionaErro('899-Rejeição: Informado incorretamente o campo meio de pagamento');
              Break;
            end;
          end;

          GravaLog('Validar: 865-Total dos pagamentos NFCe');
          if (ComparaValor(fsvTotPag, NFe.Total.ICMSTot.vNF, TOLERANCIA_COMPARACAO_001) < 0) then
            AdicionaErro('865-Rejeição: Total dos pagamentos menor que o total da nota');
        end;

        GravaLog('Validar: 866-Ausência de troco');
        if (ComparaValor(NFe.pag.vTroco, 0, TOLERANCIA_COMPARACAO_001) = 0) and (ComparaValor(fsvTotPag, NFe.Total.ICMSTot.vNF, TOLERANCIA_COMPARACAO_001) > 0) then
          AdicionaErro('866-Rejeição: Ausência de troco quando o valor dos pagamentos informados for maior que o total da nota');

        GravaLog('Validar: 869-Valor do troco');
        if (ComparaValor(NFe.pag.vTroco, 0, TOLERANCIA_COMPARACAO_001) > 0) and (ComparaValor(NFe.Total.ICMSTot.vNF, (fsvTotPag - NFe.pag.vTroco), TOLERANCIA_COMPARACAO_001) <> 0) then
          AdicionaErro('869-Rejeição: Valor do troco incorreto');

      end;

      fnDevolucao:
      begin
        GravaLog('Validar: 871-Informações de Pagamento');
        for I := 0 to NFe.pag.Count-1 do
        begin
          if (NFe.pag[I].tPag <> fpSemPagamento) then
            AdicionaErro('871-Rejeição: O campo Meio de Pagamento deve ser preenchido com a opção Sem Pagamento');
        end;
      end;
    end;
  end;

  Result := EstaVazio(FErros);

  if not Result then
  begin
    FErros := ACBrStr('Erro(s) nas Regras de negócios da NF-e: ' +
                     IntToStr(NFe.Ide.nNF) + sLineBreak + FErros);
  end;

  GravaLog('Fim da Validação. Tempo: ' +
           FormatDateTime('hh:nn:ss:zzz', Now - Agora) + sLineBreak +
           'Erros:' + FErros);
end;

procedure TNFeValidarRegras.ValidarRegra226;
begin
  GravaLog('Validar 226-UF');
  if not SameText(copy(IntToStr(NFe.Emit.EnderEmit.cMun), 1, 2), IntToStr(CodigoUF)) then
    AdicionaErro('226-Rejeição: Código da UF do Emitente diverge da UF autorizadora');
end;

procedure TNFeValidarRegras.ValidarRegra228;
begin
  GravaLog('Validar: 228-Data Emissão');
  if ((FpAgora - NFe.Ide.dEmi) > 30) then  //B09-20
    AdicionaErro('228-Rejeição: Data de Emissão muito atrasada');

  //GB09.02 - Data de Emissão posterior à 31/03/2011
  //GB09.03 - Data de Recepção posterior à 31/03/2011 e tpAmb (B24) = 2
end;

procedure TNFeValidarRegras.ValidarRegra321;
var
  i: Integer;
  DFeRef: Boolean;
begin
  DFeRef := False;
  i := 0;
  repeat
    DFeRef := NaoEstaVazio(NFe.Det[i].DFeReferenciado.chaveAcesso);
    Inc(i);
  until (i = NFe.Det.Count) or DFeRef;

  if not DFeRef then
  begin
    GravaLog('Validar: 321-NFe devolução sem referenciada');
    if (NFe.Ide.finNFe = fnDevolucao) and (NFe.Ide.NFref.Count = 0) then
      //B25-70
      AdicionaErro('321-Rejeição: NF-e devolução não possui NF referenciada');
  end;
end;

procedure TNFeValidarRegras.ValidarRegra512;
begin
  GravaLog('Validar 512-Chave de acesso');
{
  if not ValidarConcatChave then  //A03-10
    AdicionaErro(
      '502-Rejeição: Erro na Chave de Acesso - Campo Id não corresponde à concatenação dos campos correspondentes');
}
end;

procedure TNFeValidarRegras.ValidarRegra701;
begin
  GravaLog('Validar: 701-versão');
  if NFe.infNFe.Versao < 3.10 then
    AdicionaErro('701-Rejeição: Versão inválida');
end;

procedure TNFeValidarRegras.ValidarRegra703;
begin
  GravaLog('Validar: 703-Data hora');
  if (NFe.Ide.dEmi > IncMinute(FpAgora, 5)) then  //B09-10
    AdicionaErro('703-Rejeição: Data-Hora de Emissão posterior ao horário de recebimento');
end;

procedure TNFeValidarRegras.ValidarRegra789;
begin
  GravaLog('Validar: 789-NFCe e destinatário');
  if (NFe.Dest.indIEDest <> inNaoContribuinte) then
    AdicionaErro('789-Rejeição: NFC-e para destinatário contribuinte de ICMS');
end;

procedure TNFeValidarRegras.ValidarRegra794;
begin
  GravaLog('Validar: 794-NFe e domicício NFCe');
  if (NFe.Ide.indPres = pcEntregaDomicilio) and (NFe.Ide.tpImp <> tiSimplificadoTipo2) then //B25b-10
    AdicionaErro('794-Rejeição: NF-e com indicativo de NFC-e com entrega a domicílio');
end;

procedure TNFeValidarRegras.ValidarRegra897;
begin
  GravaLog('Validar: 897-Código do documento: ' + IntToStr(NFe.Ide.nNF));
  if not ValidarCodigoDFe(NFe.Ide.cNF, NFe.Ide.nNF) then
    AdicionaErro('897-Rejeição: Código numérico em formato inválido ');
end;

end.
