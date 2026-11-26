{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Fábio Tellini                                   }
{                                                                              }
{                                                                              }
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

{******************************************************************************
|* Historico
|*
|* 29/09/2026: Fábio Tellini
|*  - Primeira Versao ACBrShoppingPrecos
|* 24/10/2026: Projeto ACBr
|*  - Integracao ao trunk: pacotes, Lazarus, encoding, datas e nomes da API
|*
|* Documentacao da API: https://apidoc.shoppingdeprecos.com.br/introducao
******************************************************************************}

{$I ACBr.inc}
unit ACBrShoppingPrecosConfiguracoes;

interface

uses Classes, SysUtils;

type
  TSDPPlataformaID = type Integer;
  TSDPFormatoEtiqueta = (sdpfPDF, sdpfZPL);
  TSDPPlataformaInfo = record
    Codigo: Integer;
    Nome: string;
    EtiquetaMercadoLivre: Boolean;
  end;

  TSDPCadastroPlataformas = class(TPersistent)
  private
    function GetCount: Integer;
    function GetItem(Index: Integer): TSDPPlataformaInfo;
  public
    function Indice(Codigo: Integer): Integer;
    function Nome(Codigo: Integer): string;
    function UsaEtiquetaMercadoLivre(Codigo: Integer): Boolean;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TSDPPlataformaInfo read GetItem; default;
  end;

  TSDPConfiguracoes = class(TPersistent)
  private
    FUsuario, FSenha, FToken, FIntegracaoID: string;
    FPlataformas: TSDPCadastroPlataformas;
    FPlataforma: TSDPPlataformaID;
    procedure SetPlataforma(Value: TSDPPlataformaID);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    { Tabela estatica de referencia (editor de propriedade e demo). A lista
      atualizada vem da API em TACBrShoppingPrecos.ListarPlataformas. }
    property CadastroPlataformas: TSDPCadastroPlataformas read FPlataformas;
  published
    property Plataforma: TSDPPlataformaID read FPlataforma write SetPlataforma default 0;
    property Usuario: string read FUsuario write FUsuario;
    property Senha: string read FSenha write FSenha stored False;
    property Token: string read FToken write FToken stored False;
    property IntegracaoID: string read FIntegracaoID write FIntegracaoID;
  end;


function FormatoEtiquetaToStr(const AValue: TSDPFormatoEtiqueta): string;
function StrToFormatoEtiqueta(const AValue: string): TSDPFormatoEtiqueta;

implementation

uses
  ACBrUtil.Strings;

const
  { Unica tabela de plataformas. Codigos identicos aos da API; nunca usar o indice como ID. }
  SDPPlataformas: array[0..135] of TSDPPlataformaInfo = (
    (Codigo: 1; Nome: 'Mercado Livre'; EtiquetaMercadoLivre: True),
    (Codigo: 2; Nome: 'Skyhub / Americanas'; EtiquetaMercadoLivre: False),
    (Codigo: 3; Nome: 'EZ Commerce'; EtiquetaMercadoLivre: False),
    (Codigo: 4; Nome: 'Amazon'; EtiquetaMercadoLivre: False),
    (Codigo: 5; Nome: 'Fastshop'; EtiquetaMercadoLivre: False),
    (Codigo: 6; Nome: 'VTEX Ecommerce'; EtiquetaMercadoLivre: False),
    (Codigo: 7; Nome: 'Gold Sites'; EtiquetaMercadoLivre: False),
    (Codigo: 8; Nome: 'Casas Bahia Marketplace'; EtiquetaMercadoLivre: False),
    (Codigo: 9; Nome: 'Netshoes'; EtiquetaMercadoLivre: False),
    (Codigo: 10; Nome: 'Magazine Luiza'; EtiquetaMercadoLivre: False),
    (Codigo: 11; Nome: 'Walmart'; EtiquetaMercadoLivre: False),
    (Codigo: 12; Nome: 'Dafiti'; EtiquetaMercadoLivre: False),
    (Codigo: 13; Nome: 'XTech'; EtiquetaMercadoLivre: False),
    (Codigo: 14; Nome: 'Telecontrol'; EtiquetaMercadoLivre: False),
    (Codigo: 15; Nome: 'FBITS'; EtiquetaMercadoLivre: False),
    (Codigo: 16; Nome: 'Woocommerce'; EtiquetaMercadoLivre: False),
    (Codigo: 17; Nome: 'NuvemShop'; EtiquetaMercadoLivre: False),
    (Codigo: 18; Nome: 'Carrefour'; EtiquetaMercadoLivre: False),
    (Codigo: 19; Nome: 'Magento 1.9'; EtiquetaMercadoLivre: False),
    (Codigo: 20; Nome: 'Biz Commerce'; EtiquetaMercadoLivre: False),
    (Codigo: 21; Nome: 'Rakuten'; EtiquetaMercadoLivre: False),
    (Codigo: 22; Nome: 'Simplo7'; EtiquetaMercadoLivre: False),
    (Codigo: 23; Nome: 'Idealeware'; EtiquetaMercadoLivre: False),
    (Codigo: 24; Nome: 'Leroy Merlin'; EtiquetaMercadoLivre: False),
    (Codigo: 25; Nome: 'Madeira Madeira'; EtiquetaMercadoLivre: False),
    (Codigo: 26; Nome: 'Madeira Madeira - B2B'; EtiquetaMercadoLivre: False),
    (Codigo: 27; Nome: 'C&C'; EtiquetaMercadoLivre: False),
    (Codigo: 28; Nome: 'Loja Integrada'; EtiquetaMercadoLivre: False),
    (Codigo: 29; Nome: 'Inovarti'; EtiquetaMercadoLivre: False),
    (Codigo: 30; Nome: 'Convertize'; EtiquetaMercadoLivre: False),
    (Codigo: 31; Nome: 'Cissa Maganize'; EtiquetaMercadoLivre: False),
    (Codigo: 32; Nome: 'Olist'; EtiquetaMercadoLivre: False),
    (Codigo: 33; Nome: 'Full Ecommerce'; EtiquetaMercadoLivre: False),
    (Codigo: 34; Nome: 'Tray'; EtiquetaMercadoLivre: False),
    (Codigo: 35; Nome: 'Irroba'; EtiquetaMercadoLivre: False),
    (Codigo: 36; Nome: 'Thule'; EtiquetaMercadoLivre: False),
    (Codigo: 37; Nome: 'Centauro'; EtiquetaMercadoLivre: False),
    (Codigo: 38; Nome: 'Webcontinental'; EtiquetaMercadoLivre: False),
    (Codigo: 39; Nome: 'Monetizze'; EtiquetaMercadoLivre: False),
    (Codigo: 40; Nome: 'Bagy'; EtiquetaMercadoLivre: False),
    (Codigo: 41; Nome: 'Shopee'; EtiquetaMercadoLivre: False),
    (Codigo: 42; Nome: 'Netsuite'; EtiquetaMercadoLivre: False),
    (Codigo: 43; Nome: 'FullHub'; EtiquetaMercadoLivre: False),
    (Codigo: 44; Nome: 'WapStore'; EtiquetaMercadoLivre: False),
    (Codigo: 45; Nome: 'Estoque Sysemp'; EtiquetaMercadoLivre: False),
    (Codigo: 46; Nome: 'Camicado 2Via MKANY'; EtiquetaMercadoLivre: False),
    (Codigo: 47; Nome: 'BizMob'; EtiquetaMercadoLivre: False),
    (Codigo: 48; Nome: 'E-millennium'; EtiquetaMercadoLivre: False),
    (Codigo: 49; Nome: 'Kabum'; EtiquetaMercadoLivre: False),
    (Codigo: 50; Nome: 'Ri Happy'; EtiquetaMercadoLivre: False),
    (Codigo: 51; Nome: 'OpenCart'; EtiquetaMercadoLivre: False),
    (Codigo: 52; Nome: 'Shopify'; EtiquetaMercadoLivre: False),
    (Codigo: 53; Nome: 'Marketplace VTEX'; EtiquetaMercadoLivre: False),
    (Codigo: 54; Nome: 'Connect Parts'; EtiquetaMercadoLivre: False),
    (Codigo: 55; Nome: 'Alternativa ERP'; EtiquetaMercadoLivre: False),
    (Codigo: 56; Nome: 'HomeB2B'; EtiquetaMercadoLivre: False),
    (Codigo: 57; Nome: 'Bling'; EtiquetaMercadoLivre: False),
    (Codigo: 58; Nome: 'RicardoEletro'; EtiquetaMercadoLivre: False),
    (Codigo: 59; Nome: 'KPL'; EtiquetaMercadoLivre: False),
    (Codigo: 60; Nome: 'Alternativa'; EtiquetaMercadoLivre: False),
    (Codigo: 61; Nome: 'Shoppub'; EtiquetaMercadoLivre: False),
    (Codigo: 62; Nome: 'Sankhya'; EtiquetaMercadoLivre: False),
    (Codigo: 63; Nome: 'Tiny'; EtiquetaMercadoLivre: False),
    (Codigo: 64; Nome: 'Novo Mundo'; EtiquetaMercadoLivre: False),
    (Codigo: 65; Nome: 'Magento 2.4.2'; EtiquetaMercadoLivre: False),
    (Codigo: 66; Nome: 'Sportbay Marketplace'; EtiquetaMercadoLivre: False),
    (Codigo: 67; Nome: 'iSET'; EtiquetaMercadoLivre: False),
    (Codigo: 68; Nome: 'BL Autoparts'; EtiquetaMercadoLivre: False),
    (Codigo: 69; Nome: 'LiveEcommerce'; EtiquetaMercadoLivre: False),
    (Codigo: 71; Nome: 'AliExpress'; EtiquetaMercadoLivre: False),
    (Codigo: 72; Nome: 'GPA'; EtiquetaMercadoLivre: False),
    (Codigo: 73; Nome: 'Jet'; EtiquetaMercadoLivre: False),
    (Codigo: 74; Nome: 'SDP - Pedidos Teste'; EtiquetaMercadoLivre: False),
    (Codigo: 75; Nome: 'Du Jour'; EtiquetaMercadoLivre: False),
    (Codigo: 76; Nome: 'Brecinho'; EtiquetaMercadoLivre: False),
    (Codigo: 78; Nome: 'Riachuelo'; EtiquetaMercadoLivre: False),
    (Codigo: 79; Nome: 'Magento 2.3.5'; EtiquetaMercadoLivre: False),
    (Codigo: 80; Nome: 'Onstores'; EtiquetaMercadoLivre: False),
    (Codigo: 81; Nome: 'RD Marketplace'; EtiquetaMercadoLivre: False),
    (Codigo: 82; Nome: 'Iguatemi 365'; EtiquetaMercadoLivre: False),
    (Codigo: 83; Nome: 'Renner'; EtiquetaMercadoLivre: False),
    (Codigo: 84; Nome: 'Neogrid'; EtiquetaMercadoLivre: False),
    (Codigo: 85; Nome: 'Linx Commerce'; EtiquetaMercadoLivre: False),
    (Codigo: 86; Nome: 'Camicado via SDP'; EtiquetaMercadoLivre: False),
    (Codigo: 87; Nome: 'Conecta Lá'; EtiquetaMercadoLivre: False),
    (Codigo: 88; Nome: 'Omnik'; EtiquetaMercadoLivre: False),
    (Codigo: 89; Nome: 'Loja filha Omnik'; EtiquetaMercadoLivre: False),
    (Codigo: 90; Nome: 'Persys - Totem'; EtiquetaMercadoLivre: False),
    (Codigo: 91; Nome: 'Connect Parts 2'; EtiquetaMercadoLivre: False),
    (Codigo: 92; Nome: 'Compre sua Peça'; EtiquetaMercadoLivre: False),
    (Codigo: 93; Nome: 'Decathlon via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 94; Nome: 'Mesbla'; EtiquetaMercadoLivre: False),
    (Codigo: 95; Nome: 'Ortobom'; EtiquetaMercadoLivre: False),
    (Codigo: 96; Nome: 'Coopera via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 97; Nome: 'Conecta Lá MKTP'; EtiquetaMercadoLivre: False),
    (Codigo: 98; Nome: 'Casa&Video via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 99; Nome: 'Loja Do Mecânico'; EtiquetaMercadoLivre: False),
    (Codigo: 100; Nome: 'RD via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 101; Nome: 'Pangeia'; EtiquetaMercadoLivre: False),
    (Codigo: 102; Nome: 'Panorama Móveis'; EtiquetaMercadoLivre: False),
    (Codigo: 103; Nome: 'Oi Marketplace'; EtiquetaMercadoLivre: False),
    (Codigo: 104; Nome: 'Polishop via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 105; Nome: 'Band Shop'; EtiquetaMercadoLivre: False),
    (Codigo: 106; Nome: 'Shophub via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 107; Nome: 'Liah MarketPlace'; EtiquetaMercadoLivre: False),
    (Codigo: 108; Nome: 'My Village'; EtiquetaMercadoLivre: False),
    (Codigo: 109; Nome: 'WWBR'; EtiquetaMercadoLivre: False),
    (Codigo: 110; Nome: 'Rappi'; EtiquetaMercadoLivre: False),
    (Codigo: 111; Nome: 'Shein'; EtiquetaMercadoLivre: False),
    (Codigo: 112; Nome: '4pShop'; EtiquetaMercadoLivre: False),
    (Codigo: 113; Nome: 'Pit Stop via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 114; Nome: 'Mobly'; EtiquetaMercadoLivre: False),
    (Codigo: 115; Nome: 'Inventa'; EtiquetaMercadoLivre: False),
    (Codigo: 116; Nome: 'Allever'; EtiquetaMercadoLivre: False),
    (Codigo: 118; Nome: '2RS Store'; EtiquetaMercadoLivre: False),
    (Codigo: 119; Nome: 'Soul MKT'; EtiquetaMercadoLivre: False),
    (Codigo: 120; Nome: 'C10'; EtiquetaMercadoLivre: False),
    (Codigo: 121; Nome: 'Fast via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 122; Nome: 'Privalia via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 123; Nome: 'Magazord'; EtiquetaMercadoLivre: False),
    (Codigo: 125; Nome: 'Panorama Musical'; EtiquetaMercadoLivre: False),
    (Codigo: 126; Nome: 'Fast Commerce'; EtiquetaMercadoLivre: False),
    (Codigo: 127; Nome: 'Vinklo'; EtiquetaMercadoLivre: False),
    (Codigo: 128; Nome: 'Ri Happy Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 129; Nome: 'Dropshipping'; EtiquetaMercadoLivre: False),
    (Codigo: 131; Nome: 'Amazon Vendor'; EtiquetaMercadoLivre: False),
    (Codigo: 133; Nome: 'Martins Distribuidora'; EtiquetaMercadoLivre: False),
    (Codigo: 135; Nome: 'TikTok'; EtiquetaMercadoLivre: False),
    (Codigo: 136; Nome: 'Bradesco Shop'; EtiquetaMercadoLivre: False),
    (Codigo: 137; Nome: 'Temu'; EtiquetaMercadoLivre: False),
    (Codigo: 138; Nome: 'Brand E-commerce'; EtiquetaMercadoLivre: False),
    (Codigo: 139; Nome: 'Mais Correios via Conecta-lá'; EtiquetaMercadoLivre: False),
    (Codigo: 140; Nome: 'Editora Fundamento'; EtiquetaMercadoLivre: False),
    (Codigo: 141; Nome: 'Zema via Conecta Lá'; EtiquetaMercadoLivre: False),
    (Codigo: 142; Nome: 'BizWay'; EtiquetaMercadoLivre: False),
    (Codigo: 143; Nome: 'B4X'; EtiquetaMercadoLivre: False)
  );

function FormatoEtiquetaToStr(const AValue: TSDPFormatoEtiqueta): string;
begin
  case AValue of
    sdpfZPL: Result := 'ZPL';
  else
    Result := 'PDF';
  end;
end;

function StrToFormatoEtiqueta(const AValue: string): TSDPFormatoEtiqueta;
begin
  if UpperCase(Trim(AValue)) = 'ZPL' then
    Result := sdpfZPL
  else
    Result := sdpfPDF;
end;

{ TSDPCadastroPlataformas }

function TSDPCadastroPlataformas.GetCount: Integer;
begin
  Result := Length(SDPPlataformas);
end;

function TSDPCadastroPlataformas.GetItem(Index: Integer): TSDPPlataformaInfo;
begin
  if (Index < 0) or (Index >= Count) then
    raise EListError.Create('Indice de plataforma invalido');
  Result := SDPPlataformas[Index];
  { A tabela esta no encoding do fonte (CP1252); no FPC a string nativa e UTF-8 }
  Result.Nome := ACBrStr(Result.Nome);
end;

function TSDPCadastroPlataformas.Indice(Codigo: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(SDPPlataformas) to High(SDPPlataformas) do

    if SDPPlataformas[I].Codigo = Codigo then
    begin
      Result := I;
      Exit;
    end;
end;

function TSDPCadastroPlataformas.Nome(Codigo: Integer): string;
var
  I: Integer;
begin
  I := Indice(Codigo);
  Result := '';

  if I >= 0 then
    Result := ACBrStr(SDPPlataformas[I].Nome);
end;

function TSDPCadastroPlataformas.UsaEtiquetaMercadoLivre(Codigo: Integer): Boolean;
var
  I: Integer;
begin
  I := Indice(Codigo);
  Result := False;

  if I >= 0 then
    Result := SDPPlataformas[I].EtiquetaMercadoLivre;
end;

{ TSDPConfiguracoes }

constructor TSDPConfiguracoes.Create;
begin
  inherited Create;
  FPlataformas := TSDPCadastroPlataformas.Create;
end;

destructor TSDPConfiguracoes.Destroy;
begin
  FPlataformas.Free;
  inherited Destroy;
end;

procedure TSDPConfiguracoes.SetPlataforma(Value: TSDPPlataformaID);
begin
  { Aceita qualquer codigo: plataformas novas da API nao dependem desta tabela
    e um codigo retirado dela nao impede a leitura do DFM. A validacao ocorre
    antes de chamar a API (TACBrShoppingPrecos.ValidarPlataforma). }
  FPlataforma := Value;
end;

procedure TSDPConfiguracoes.Assign(Source: TPersistent);
begin
  if Source is TSDPConfiguracoes then
  begin
    Plataforma := TSDPConfiguracoes(Source).Plataforma;
    FUsuario := TSDPConfiguracoes(Source).Usuario;
    FSenha := TSDPConfiguracoes(Source).Senha;
    FToken := TSDPConfiguracoes(Source).Token;
    FIntegracaoID := TSDPConfiguracoes(Source).IntegracaoID;
  end
  else
    inherited Assign(Source);
end;

end.
