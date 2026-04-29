# 🧪 Programa Exemplo ACBrLibPIXCD Flutter (Android)

Este projeto demonstra a integração de um aplicativo Flutter com a biblioteca nativa **ACBrLibPIXCD**. Desenvolvida a partir do componente PIXCD do Projeto ACBr, esta biblioteca possibilita a comunicação com PSPs e endpoints do Pix (ex.: criação/consulta/revisão/cancelamento de cobranças e consulta de Pix). O programa exemplo serve como um guia prático para desenvolvedores que desejam implementar a integração com a ACBrLibPIXCD em aplicações Flutter.

📌 **Observação importante (QRCode):** a **ACBrLibPIXCD não gera a imagem do QRCode**. Em geral, a biblioteca retorna o campo **pixCopiaECola** (payload/texto) com os dados necessários, e a **Software House** (seu app) é responsável por gerar/mostrar o QRCode a partir desse conteúdo.

## 🎯 Visão Geral do Projeto Exemplo

Este **Programa Exemplo** foi desenvolvido exclusivamente para fins de **demonstração e estudo**. Ele serve como uma base de referência para desenvolvedores entenderem a integração com a ACBrLibPIXCD no ambiente Flutter.

⚠️ **Importante:** O código presente neste projeto **NÃO DEVE** ser utilizado diretamente em aplicações reais ou ambientes de produção sem uma revisão completa, refatoração e implementação de práticas de segurança e tratamento de erros adequadas ao seu caso de uso específico.

No demo, você encontrará:

- A **estrutura essencial** de um projeto Flutter para comunicação com funcionalidades nativas.
- Seções de **configurações da biblioteca** (sessões do INI) e telas para executar comandos/endereçar endpoints.
- A implementação do padrão **Singleton** para o plugin da ACBrLibPIXCD, garantindo que apenas uma instância da lib seja utilizada em todo o aplicativo.

## 🚀 Instalação e Execução

Para colocar o programa exemplo em funcionamento, siga os passos abaixo:

1. **Obtenha os Arquivos Necessários da ACBrLibPIXCD:**
   - Acesse a seção de downloads do fórum oficial do Projeto ACBr:\
     [https://www.projetoacbr.com.br/forum/files/](https://www.projetoacbr.com.br/forum/files/)
   - Selecione **ACBrLibPIXCD** e, na seção de downloads, escolha a opção para **Android**.
   - Após o download, descompacte o arquivo.
   - Dentro da pasta descompactada, você encontrará a subpasta ``Android`` (contendo o ``.aar``).

2. **Configuração da ACBrLibPIXCD no Projeto Flutter:**

    - **Arquivo ``.aar``:** Pegue o arquivo ``ACBrLibPIXCD-release.aar`` (localizado em ``Android`` na pasta que você descompactou) e copie-o para a pasta ``android/app/libs`` do demo. Se a pasta ``libs`` não existir dentro de ``android/app``, crie-a.

Após concluir esta configuração (arquivo ``.aar``), você estará pronto para explorar e utilizar todas as funcionalidades do programa exemplo!

## 🧾 Exemplo de INI de Cobrança Imediata

Observações:

- Substitua os valores do exemplo pelos dados reais da sua cobrança.
- O devedor pode ser identificado por CPF ou CNPJ (utilize apenas um dos campos).

```ini
[CobSolicitada]
chave=<chavePIX de quem do recebedor>
solicitacaoPagador=Pagamento de conta
expiracao=3600
valorOriginal=100,00
modalidadeAlteracao=False
devedorCPF=12345678900
devedorCNPJ=12345678000190
devedorNome=João Silva


[infoAdicionais001]
nome=Observação
valor=Pagamento solicitado no dia 15/12/2023


[infoAdicionais002]
nome=Referência
valor=123456
```

## 📂 Estrutura do Projeto

A organização do código foi pensada para clareza e manutenção, dividindo as responsabilidades em diretórios lógicos:

### ``lib``

- ``plugin/``: Abriga o arquivo ``acbrpixcd_plugin.dart``. Este é o coração da comunicação com o mundo nativo, servindo como a "ponte" via **Method Channel** para as funções expostas pela ACBrLibPIXCD. Para a documentação mais atualizada, consulte diretamente em:\
[https://acbr.sourceforge.io/ACBrLib/SobreaACBrLibPIXCD.html](https://acbr.sourceforge.io/ACBrLib/SobreaACBrLibPIXCD.html)
\
Para informações específicas do AAR/Android (requisitos, permissões, recomendações e exemplos), consulte também:\
[https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Android/PIXCD/README.md](https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Android/PIXCD/README.md)
- ``ui/``: Onde estão organizadas as telas (screens) e os widgets da interface. Veja a estrutura detalhada abaixo.
- ``utils/``: Contém arquivos utilitários diversos do projeto. Nela você encontrará o arquivo ``acbrlib_pixcd_helper.dart``, que implementa a classe **Singleton** para garantir que apenas uma instância do plugin ACBrLibPIXCD seja utilizada em todo o aplicativo. Esta abordagem também centraliza utilitários como o seletor de arquivos (file picker) usado para selecionar e copiar certificados/chaves para a área privada do app.

#### ``ui/`` (Estrutura Detalhada da Interface do Usuário)

O diretório ``ui/`` é subdividido para organizar as diferentes partes da interface:

- ``pages/``:
    - ``qrcode_estatico_page.dart``: Tela para geração de QR Code estático.
    - ``endpoints/``: Telas dos endpoints Pix (ex.: **Pix**, **Cob**, **CobV**) organizadas por operação.
    - ``config/``: Telas de configurações, incluindo a sessão **PIXCD** e sessões de PSPs.
- ``widgets/``:
    - Componentes reutilizáveis de UI (ex.: drawer com tabs e caixa de resposta).

### ``android``

- ``android/app/libs/``: Local onde deve ser colocado o ``ACBrLibPIXCD-release.aar`` para o projeto compilar e executar.
- ``android/app/src/main/java/.../ACBrPixCDAarPlugin.java``: Implementação do plugin Android que integra a ACBrLibPIXCD ao Flutter através do **MethodChannel**.

Todo o código deste projeto exemplo está **bem documentado** para facilitar a compreensão. Caso surjam dúvidas, sinta-se à vontade para criar um tópico no [fórum oficial do Projeto ACBr](https://www.projetoacbr.com.br/forum/) ou entrar em contato através do [Discord](https://www.projetoacbr.com.br/discord).

## 📝 Resumo e Considerações Finais

Este projeto é um programa exemplo crucial para entender a integração Flutter com a **ACBrLibPIXCD**. Lembre-se:

- **Não é para Produção:** O código é uma base de estudo e não deve ser usado em produção.
- **Configuração Essencial:** Certifique-se de configurar corretamente o arquivo ``.aar`` no app para ativar as funcionalidades da lib.
- **Comunicação Nativa:** A integração com a ACBrLib é feita via **Method Channel**, uma ponte vital entre o Dart e o código nativo (Java/Kotlin).
- **Documentação:** O projeto e o plugin são estruturados para facilitar o entendimento e servir de referência na integração com a ACBrLibPIXCD.

---
**Suporte:** Se tiver qualquer dúvida, sinta-se à vontade para abrir um tópico no [fórum oficial do Projeto ACBr](https://www.projetoacbr.com.br/forum/) ou entrar em contato através do [Discord](https://www.projetoacbr.com.br/discord).
