
ACBrLibNFe Android
---
Biblioteca para uso de componente ACBrLibNFe em Android

Permite a utilização da ACBrNFe em projetos Android, facilitando a integração de funcionalidades relacionadas à emissão e gerenciamento de Notas Fiscais Eletrônicas (NFe).

# Getting Started #

## Índice ##
1. [Requisitos Mínimos](#1-requisitos-minimos)
2. [Alinhamento de páginas de memória de 16 KB](#2-alinhamento-16kb)
3. [Importar AAR](#3-importar-aar)
	1. [Importar no build.gradle](#31-importar-build-gradle)
	2. [Importar no build.gradle.kts](#32-importar-build-gradle-kts)
4. [Configurações da Biblioteca](#4-configuracoes-da-biblioteca)
5. [Permissões Necessárias](#5-permissoes-necessarias)
6. [Fluxo de uso](#6-fluxo-de-uso)
7. [Informações adicionais](#7-informacoes-adicionais)
	1. [Classe da biblioteca](#71-classe-da-biblioteca)
	2. [Recomendações por biblioteca](#72-recomendacoes-por-biblioteca)
8. [Exemplo de uso](#8-exemplo-de-uso)
9. [Debug](#9-debug)
10. [Referências](#10-referencias)
	1. [Configurações gerais](#101-configuracoes-gerais)

<a id="1-requisitos-minimos"></a>
# 1. Requisitos Mínimos

+	Android 24 ( Android 7.0 Nougat) ou superior
+	Android Android Gradle Plugin 8.6.0 ou superior


<a id="2-alinhamento-16kb"></a>
# 2. Alinhamento de páginas de memória de 16 KB

Este aar foi compilado com alinhamento de páginas de memória de 16 KB, o que é necessário para garantir a compatibilidade com o Android 15. Para mais informações sobre essa mudança e suas implicações, consulte o tópico no fórum do Projeto ACBr:
https://www.projetoacbr.com.br/forum/topic/86443-projeto-acbr-e-compatibiliza%C3%A7%C3%A3o-do-android-15/


<a id="3-importar-aar"></a>
# 3. Importar AAR

<a id="31-importar-build-gradle"></a>
## 3.1 Importar no build.gradle

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs

2. Abra seu arquivo build.gradle de app e adicione
```build.gradle
implementation( files('./libs/ACBrLibNFe-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3. Sincronize o gradle

<a id="32-importar-build-gradle-kts"></a>
## 3.2 Importar no build.gradle.kts

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs
2. Em ./app/build.gradle.kts adicione as seguintes linhas:
```build.gradle.kts
	implementation(files("./libs/ACBrLibNFe-release.aar"))
	implementation ("net.java.dev.jna:jna:5.18.1@aar")
```
Em settings.gradle.kts dentro de repositories adicione as seguintes linhas:

```build.gradle.kts
flatDir {
  dirs("libs")
}
```

3. Sincronize o gradle

No Android Studio, acesse:

File -> Sync project with Gradle Files (Control + shift + O)


<a id="4-configuracoes-da-biblioteca"></a>
# 4. Configurações da Biblioteca

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca16.html


<a id="5-permissoes-necessarias"></a>
# 5. Permissões Necessárias

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<uses-permission android:name="android.permission.INTERNET" />
		</manifest>
```

<a id="6-fluxo-de-uso"></a>
# 6. Fluxo de uso da ACBrLibNFe
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="7-informacoes-adicionais"></a>
# 7. Informações adicionais

<a id="71-classe-da-biblioteca"></a>
## 7.1 Classe da biblioteca

#### Classe principal da biblioteca ACBrLibNFe ####
Importar a classe: [ACBrLibNFe](ACBrLibNFe/src/main/java/br/com/acbr/lib/nfe/ACBrLibNFe.java)

```java
import br.com.acbr.lib.nfe.ACBrLibNFe;
```

<a id="72-recomendacoes-por-biblioteca"></a>
## 7.2 Recomendações por biblioteca


## Índice desta seção
1. [Pré-requisitos](#721-pre-requisitos)
2. [Exemplo de configuração NFCe](#722-exemplo-nfce)
3. [Fluxo de emissão](#723-fluxo-emissao)
4. [Valores de TipoDANFE](#724-tipo-danfe)

<a id="721-pre-requisitos"></a>
## 7.2.1 Pré-requisitos
Os comentários do exemplo deixam estes pontos como essenciais antes da emissão:
- Certificado, SSL e ambiente de WebService devem ser configurados previamente.
- Para emitir NFCe, os dados básicos continuam os mesmos da NFe, mudando o modelo e alguns grupos/campos que deixam de ser obrigatórios.
- Para NFCe, ajuste o modelo do documento para NFCe e o TipoDANFE para 4 (tiNFCe).
- Se for gerar PDF da DANFE, defina também o PathPDF na seção DANFe.
- Fluxo de emissão NFe/NFCe: https://acbr.sourceforge.io/ACBrLib/ComoemitirumaNFeouNFCe.html
- Documentação da seção DFe: https://acbr.sourceforge.io/ACBrLib/DFe.html

> **Armazenamento seguro:** o caminho e a senha do certificado A1 (ArquivoPFX e Senha) nunca devem ser armazenados em texto puro no código-fonte.
> Utilize Android Keystore, EncryptedSharedPreferences ou outro mecanismo seguro para guardar e recuperar essas informações em tempo de execução.
> Consulte: https://developer.android.com/training/data-storage?hl=pt-br

<a id="722-exemplo-nfce"></a>
## 7.2.2 Exemplo de configuração NFCe
```java
acbrlibnfe.configGravarValor( "NFe", "Ambiente", "1" );
acbrlibnfe.configGravarValor( "NFe", "PathSchemas", appDir.getAbsolutePath() + "/Schemas/NFe" );
acbrlibnfe.configGravarValor( "NFe", "PathSalvar", appDir.getAbsolutePath() + "/Notas" );
acbrlibnfe.configGravarValor( "NFe", "ModeloDF", "1" ); // NFCe
acbrlibnfe.configGravarValor( "DANFe", "PathPDF", appDir.getAbsolutePath() + "/DANFe" );
acbrlibnfe.configGravarValor( "DANFe", "TipoDANFE", "4" ); // tiNFCe
```

No XML/INI carregado da nota, o modelo também precisa estar ajustado para NFCe.
Se estiver emitindo NFe comum, mantenha o TipoDANFE compatível com o layout desejado, por exemplo 0 (sem geração), 1 (retrato) ou 2 (paisagem).

<a id="723-fluxo-emissao"></a>
## 7.2.3 Fluxo de emissão
Fluxo essencial comentado na documentação de emissão:
1. Carregar a nota com carregarXML(...) ou carregarINI(...).
2. Assinar o documento com assinar().
3. Validar o XML com validar().
4. Opcionalmente obter ou gravar o XML antes do envio.
5. Enviar a nota para a SEFAZ.
6. Opcionalmente imprimir a DANFE ou gerar PDF.
7. Opcionalmente enviar a nota por e-mail.

No exemplo usado como base, as configurações essenciais antes desse fluxo são:
- Certificado A1 configurado em DFe (ArquivoPFX e Senha).
- Bibliotecas SSL/XML configuradas em DFe (SSLCryptLib, SSLHttpLib e SSLXmlSignLib).
- Ambiente e paths principais configurados em NFe (Ambiente, PathSchemas e PathSalvar).
- ModeloDF configurado em NFe (0 = NFe, 1 = NFCe).
- Geração de DANFe configurada com PathPDF e TipoDANFE quando necessário.
- Para NFCe, use ModeloDF = 1 e TipoDANFE = 4.

<a id="724-tipo-danfe"></a>
## 7.2.4 Valores de TipoDANFE
Resumo dos valores de TipoDANFE usados no exemplo:
- 0 = tiSemGeracao
- 1 = tiRetrato
- 2 = tiPaisagem
- 3 = tiSimplificado
- 4 = tiNFCe
- 5 = tiMsgEletronica


<a id="8-exemplo-de-uso"></a>
# 8. Utilizando a biblioteca ACBrLibNFe

Exemplo de código para utilização da biblioteca ACBrLibNFe:

```java
import br.com.acbr.lib.nfe.ACBrLibNFe;
import java.io.File;

public class MainActivity extends AppCompatActivity {

	private ACBrLibNFe acbrlibnfe;
	private File appDir;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// dica: defina um appDir, como diretório base para arquivos de configuração, certificados, schemas, etc. Ajuste conforme a estrutura do seu app.
		// em desenvolvimento, appDir pode ser getFilesDir() ou getExternalFilesDir(null). 
		// Em produção, use sempre getFilesDir() para garantir acesso seguro e privado.


		appDir = getFilesDir();
		if (!appDir.exists()) {
			appDir.mkdirs();
		}

		// Inicialize a biblioteca
		String eArquivoConfig = appDir.getAbsolutePath() + "/ACBrLib.ini";
		String chaveCrypt = "";
		acbrlibnfe = new ACBrLibNFe(eArquivoConfig, chaveCrypt);

		aplicarConfiguracoes();


		// finalizar lib em onDestroy
		@Override
		protected void onDestroy() {
			super.onDestroy();
			try {
				acbrlibnfe.finalizar();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// Método para aplicar as configurações mínimas da ACBrLibNFe:
		private void aplicarConfiguracoes() {
			try {
				acbrlibnfe.inicializar();
				
				acbrlibnfe.configGravarValor( "Principal", "LogNivel", "4" );
				acbrlibnfe.configGravarValor( "DFe", "SSLCryptLib", "1" );
				acbrlibnfe.configGravarValor( "DFe", "SSLHttpLib", "3" );
				acbrlibnfe.configGravarValor( "DFe", "SSLXmlSignLib", "4" );
				// Certificado A1 (.pfx) e senha devem vir de armazenamento seguro.
				acbrlibnfe.configGravarValor( "DFe", "ArquivoPFX", appDir.getAbsolutePath() + "/certificado.pfx" );
				acbrlibnfe.configGravarValor( "DFe", "Senha", "SuaSenhaAqui" );
				acbrlibnfe.configGravarValor( "NFe", "PathSchemas", appDir.getAbsolutePath() + "/Schemas/NFe" );
				acbrlibnfe.configGravarValor( "NFe", "PathSalvar", appDir.getAbsolutePath() + "/Notas" );
				// ModeloDF: 0 = NFe, 1 = NFCe.
				acbrlibnfe.configGravarValor( "NFe", "ModeloDF", "1" );
				// Ambiente: 1 = homologacao (demo), ajuste para producao quando necessario.
				acbrlibnfe.configGravarValor( "NFe", "Ambiente", "1" );

				//Seçao DANFe
				acbrlibnfe.configGravarValor( "DANFe", "PathPDF", appDir.getAbsolutePath() + "/DANFe" );
				//0 = tiSemGeracao
				//1 = tiRetrato
				//2 = tiPaisagem
				//3 = tiSimplificado
				//4 = tiNFCe
				//5 = tiMsgEletronica

				acbrlibnfe.configGravarValor( "DANFe", "TipoDANFE","0");
				acbrlibnfe.configGravar();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}

				//Exemplo de código para verificar o status do serviço da SEFAZ utilizando a ACBrLibNFe.
		private void onClick(View view) {
			
			try {
				
				String statusSEFAZ = acbrlibnfe.StatusServico();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}



}
```


<a id="9-debug"></a>
# 9. Debug

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibNFe`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


<a id="10-referencias"></a>
# 10. Referências

<a id="101-configuracoes-gerais"></a>
## 10.1 Configurações gerais

- Documentação geral da ACBrLib: https://acbr.sourceforge.io/ACBrLib/Geral.html


