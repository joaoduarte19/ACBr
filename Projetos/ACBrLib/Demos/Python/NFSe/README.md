# ACBrLibNFSe - Demo Python

Exemplo de integração com a **ACBrLibNFSe** (biblioteca nativa do projeto [ACBr](https://www.acbr.com.br/)) a partir de Python, utilizando `ctypes` para carregar a lib compartilhada e emitir/consultar NFS-e.

O binding em [acbrlib_nfse.py](acbrlib_nfse.py) expõe a classe `ACBrNFSeMT`, um wrapper Python amigável sobre as funções nativas da lib (`NFSE_Inicializar`, `NFSE_ConfigGravarValor`, `NFSE_Emitir`, etc). O script [teste_nfse.py](teste_nfse.py) mostra um exemplo mínimo de uso: carrega as configurações, inicializa a lib e imprime nome/versão.

## Requisitos

- Python 3.12+
- Linux ou Windows (o script detecta o SO e carrega `libacbrnfse64.so` ou `ACBrNFSe64.dll` automaticamente)
- Biblioteca nativa da ACBrLibNFSe (`libacbrnfse64.so` no Linux ou `ACBrNFSe64.dll` no Windows) na raiz do projeto
- Um certificado digital A1 (`.pfx`) válido para assinatura/comunicação com o webservice da prefeitura, codificado em **base64** (veja a seção [Configuração do arquivo `.env`](#configuração-do-arquivo-env))

## Criando o ambiente virtual (venv)

```bash
# Criar o venv
python3 -m venv .venv

# Ativar o venv
source .venv/bin/activate        # Linux/macOS
.venv\Scripts\activate           # Windows

# Instalar as dependências
pip install python-dotenv
```

Para desativar o ambiente virtual, use `deactivate`.

## Configuração do arquivo `.env`

Crie um arquivo `.env` na raiz do projeto (ele é carregado automaticamente pelo `python-dotenv` em `teste_nfse.py`) com as seguintes variáveis:

```env
# Conteúdo do certificado digital (.pfx) codificado em base64, gravado na chave DFe.DadosPFX
PFX_DATA=MIIKXQIBAzCCCh...

# Senha do certificado digital (.pfx) usado na seção [DFe]
PFX_PASSWORD=sua_senha_do_certificado

# Credenciais do webservice do provedor de NFS-e (seção Emitente.WSUser / Emitente.WSSenha)
EMITENTE_USER=seu_usuario
EMITENTE_PASSWORD=sua_senha
```

`PFX_DATA` não é o caminho do arquivo `.pfx`, e sim o **conteúdo binário do certificado codificado em base64**, em uma única linha. A lib grava esse valor diretamente na chave `DFe.DadosPFX` (em vez de `DFe.ArquivoPFX`, que esperaria um caminho de arquivo), permitindo carregar o certificado sem depender de um arquivo físico acessível no disco.

Gere o valor a partir do seu `cert.pfx` com:

```bash
# Linux/macOS — imprime em uma única linha
base64 -w0 cert.pfx

# Windows (PowerShell)
[Convert]::ToBase64String([IO.File]::ReadAllBytes("cert.pfx"))
```

Copie a saída para `PFX_DATA` no `.env`.

> **Atenção:** o `.env` contém dados sensíveis (o certificado digital em base64, sua senha e as credenciais do webservice). Nunca versione esse arquivo — ele já deve estar listado no `.gitignore`.

## Estrutura de diretórios esperada

O script monta os caminhos usados pela lib com base na pasta `data/`, relativa ao diretório do projeto:

```
data/
├── config/
│   ├── acbrlib.ini           # Arquivo de configuração gerado/usado pela lib
│   └── ACBrNFSeXServicos.ini # Configuração de serviços por provedor
├── NFSe/                     # Schemas XSD dos provedores de NFS-e (organizados por provedor/versão)
├── notas/
│   ├── rps/                  # RPS gerados
│   └── nfse/                 # NFS-e emitidas
└── log/                      # Logs da lib
```

> O certificado digital (`.pfx`) **não** é lido de um arquivo em `data/cert/` — ele é fornecido em base64 via `PFX_DATA` no `.env` (chave `DFe.DadosPFX`), conforme descrito acima. Mantenha o arquivo `.pfx` original apenas localmente, fora do repositório, para gerar o base64 quando precisar renová-lo.

Ajuste as constantes no início de [teste_nfse.py](teste_nfse.py) conforme necessário:

| Variável | Descrição |
|---|---|
| `codigoMunicipio` | Código IBGE do município do prestador |
| `ambienteDeEmissao` | `0` = Produção, `1` = Homologação |
| `layoutNFSe` | Layout/provedor de NFS-e a ser utilizado |
| `pathSchemas` | Caminho da pasta de schemas (`data/NFSe`) |

## Executando

```bash
python teste_nfse.py
```

O script realiza os seguintes passos:

1. Carrega as variáveis de ambiente do `.env`
2. Localiza e carrega a biblioteca nativa (`libacbrnfse64.so`/`ACBrNFSe64.dll`)
3. Inicializa a instância da `ACBrNFSeMT`
4. Aplica as configurações das seções `[NFSe]` e `[DFe]` (município, ambiente, paths, certificado em base64, credenciais)
5. Grava a configuração no `acbrlib.ini`
6. Imprime o nome e a versão da lib carregada
7. Finaliza a instância, liberando os recursos

## Sobre a classe `ACBrNFSeMT`

Principais métodos disponíveis em [acbrlib_nfse.py](acbrlib_nfse.py):

| Método | Descrição |
|---|---|
| `inicializar()` | Inicializa a lib, carregando o `arquivoINI` informado no construtor |
| `finalizar()` | Libera o handle da lib |
| `configGravarValor(secao, chave, valor)` | Grava um valor de configuração em memória |
| `configGravar(arquivoINI=None)` | Persiste as configurações no arquivo INI |
| `configExportar()` | Exporta a configuração atual como string INI |
| `nome()` / `versao()` | Retornam nome e versão da lib carregada |
| `emitir(aLote, modoEnvio, bImprimir=False)` | Emite um lote de RPS/NFS-e a partir do XML informado |
| `ultimoRetorno()` | Retorna a última mensagem de retorno/erro da lib |

Todos os métodos convertem automaticamente buffers `ctypes` em `str`, redimensionando o buffer quando a resposta da lib excede o tamanho padrão (1024 bytes), e lançam `Exception` quando o código de retorno da lib é diferente de `0`.

## Referências

- [Site do projeto ACBr](https://www.acbr.com.br/)
- [Repositório ACBr no GitHub](https://github.com/ACBr/ACBr)
