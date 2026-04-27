
ACBrLibPIXCD Android
---
Biblioteca para uso de componente ACBrLibPIXCD em Android

Permite a utilização da ACBrPIXCD em projetos Android, facilitando a integração de funcionalidades relacionadas ao sistema de pagamentos instantâneos PIX.

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
implementation( files('./libs/ACBrLibPIXCD-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3. Sincronize o gradle

<a id="32-importar-build-gradle-kts"></a>
## 3.2 Importar no build.gradle.kts

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs
2. Em ./app/build.gradle.kts adicione as seguintes linhas:
```build.gradle.kts
	implementation(files("./libs/ACBrLibPIXCD-release.aar"))
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

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html


<a id="5-permissoes-necessarias"></a>
# 5. Permissões Necessárias

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<uses-permission android:name="android.permission.INTERNET" />
		</manifest>
```

<a id="6-fluxo-de-uso"></a>
# 6. Fluxo de uso da ACBrLibPIXCD
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="7-informacoes-adicionais"></a>
# 7. Informações adicionais

<a id="71-classe-da-biblioteca"></a>
## 7.1 Classe da biblioteca

#### Classe principal da biblioteca ACBrLibPIXCD ####
Importar a classe: [ACBrLibPIXCD](ACBrLibPIXCD/src/main/java/br/com/acbr/lib/pixcd/ACBrLibPIXCD.java)

```java
import br.com.acbr.lib.pixcd.ACBrLibPIXCD;
```

<a id="72-recomendacoes-por-biblioteca"></a>
## 7.2 Recomendações por biblioteca


## Índice desta seção
1. [Pré-requisitos](#721-pre-requisitos)
2. [Exemplo de configuração mínima](#722-exemplo-configuracao)
3. [Fluxo de cobrança imediata](#723-fluxo-cobranca)
4. [Observações de PSP](#724-observacoes-psp)

<a id="721-pre-requisitos"></a>
## 7.2.1 Pré-requisitos
Com base nas seções de configurações gerais, configuração da biblioteca PIXCD e exemplo de INI, o conjunto essencial do exemplo é:
- Sessão Principal: LogNivel e, quando necessário, LogPath.
- Sessão PIXCD: PSP, NomeRecebedor, CidadeRecebedor e UFRecebedor.
- Sessão do PSP escolhido: credenciais e chaves específicas do provedor.

<a id="722-exemplo-configuracao"></a>
## 7.2.2 Exemplo de configuração mínima
```java
acbrlibpixcd.configGravarValor( "Principal", "LogNivel", "4" );
acbrlibpixcd.configGravarValor( "PIXCD", "PSP", "2" ); // Banco do Brasil
acbrlibpixcd.configGravarValor( "PIXCD", "NomeRecebedor", "Recebedor Exemplo" );
acbrlibpixcd.configGravarValor( "PIXCD", "CidadeRecebedor", "SAO PAULO" );
acbrlibpixcd.configGravarValor( "PIXCD", "UFRecebedor", "SP" );
acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ClientID", "SeuClientID" );
acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ClientSecret", "SeuClientSecret" );
acbrlibpixcd.configGravarValor( "BANCOBRASIL", "DeveloperApplicationKey", "SuaAppKey" );
acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ChavePIX", "sua-chave-pix" );
acbrlibpixcd.configGravarValor( "BANCOBRASIL", "BBAPIVersao", "1" );
```

No exemplo adotado aqui, o PSP é o Banco do Brasil, então as chaves essenciais são:
- ClientID
- ClientSecret
- DeveloperApplicationKey
- ChavePIX
- BBAPIVersao

A documentação da ACBrLibPIXCD também mostra outras chaves úteis na sessão PIXCD, como Ambiente, Timeout, TipoChave, ProxyHost, ProxyPort, ProxyUser e ProxyPass.

<a id="723-fluxo-cobranca"></a>
## 7.2.3 Fluxo de cobrança imediata
```java
String txId = "TXID12345678901234567890123";
String caminhoCobranca = appDir.getAbsolutePath() + "/cobranca_imediata.ini";
String respostaCobranca = acbrlibpixcd.CriarCobrancaImediata(caminhoCobranca, txId);
String statusCobranca = acbrlibpixcd.ConsultarCobrancaImediata(txId, 0);
```

Para o fluxo de cobrança imediata usado no exemplo, o arquivo INI informado em CriarCobrancaImediata(...) deve conter os dados da cobrança no formato esperado pelo endpoint /Cob.
A partir da documentação de exemplo de INI, os cenários mais comuns são: criar cobrança imediata, revisar cobrança imediata, criar cobrança com vencimento e solicitar devolução PIX.

<a id="724-observacoes-psp"></a>
## 7.2.4 Observações de PSP
Se trocar o PSP, mantenha a sessão PIXCD com os dados do recebedor e substitua apenas a sessão específica do provedor pelas credenciais exigidas por ele.

> **Armazenamento seguro:** credenciais do PSP (ClientID, ClientSecret, ChavePIX, DeveloperApplicationKey e equivalentes de outros provedores) nunca devem ser armazenadas em texto puro no código-fonte ou em arquivos não protegidos.
> Utilize Android Keystore, EncryptedSharedPreferences ou variáveis injetadas em tempo de execução (ex.: via servidor seguro ou secrets manager).
> Consulte: https://developer.android.com/training/data-storage?hl=pt-br


<a id="8-exemplo-de-uso"></a>
# 8. Utilizando a biblioteca ACBrLibPIXCD

Exemplo de código para utilização da biblioteca ACBrLibPIXCD:

```java
import br.com.acbr.lib.pixcd.ACBrLibPIXCD;
import java.io.File;

public class MainActivity extends AppCompatActivity {

	private ACBrLibPIXCD acbrlibpixcd;
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
		acbrlibpixcd = new ACBrLibPIXCD(eArquivoConfig, chaveCrypt);

		aplicarConfiguracoes();


		// finalizar lib em onDestroy
		@Override
		protected void onDestroy() {
			super.onDestroy();
			try {
				acbrlibpixcd.finalizar();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// Método para aplicar as configurações mínimas da ACBrLibPIXCD:
		private void aplicarConfiguracoes() {
			try {
				acbrlibpixcd.inicializar();
				
				//PIXCD: no demo o PSP usado e Banco do Brasil (valor 2).
				//Configuracoes gerais ACBrLib: https://acbr.sourceforge.io/ACBrLib/Geral.html
				//Configuracoes ACBrLibPIXCD: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
				//Exemplo de INI PIXCD: https://acbr.sourceforge.io/ACBrLib/ExemplodeINI7.html

				acbrlibpixcd.configGravarValor( "Principal", "LogNivel", "4" );
				acbrlibpixcd.configGravarValor( "PIXCD", "PSP", "2" );
				acbrlibpixcd.configGravarValor( "PIXCD", "NomeRecebedor", "Recebedor Exemplo" );
				acbrlibpixcd.configGravarValor( "PIXCD", "CidadeRecebedor", "SAO PAULO" );
				acbrlibpixcd.configGravarValor( "PIXCD", "UFRecebedor", "SP" );

				//Credenciais do PSP: use variaveis seguras (env/secret), nunca hardcode.
				//Para Banco do Brasil, as credenciais sao ClientID, ClientSecret, DeveloperApplicationKey e ChavePIX.
				//Para os demais PSP consulte https://www.projetoacbr.com.br/forum/topic/68320-acbrpixcd-como-solicitar-credenciais-e-configurar-psps-no-componente/.
				acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ClientID", "SeuClientID" );
				acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ClientSecret", "SeuClientSecret" );
				acbrlibpixcd.configGravarValor( "BANCOBRASIL", "DeveloperApplicationKey", "SuaAppKey" );
				acbrlibpixcd.configGravarValor( "BANCOBRASIL", "ChavePIX", "sua-chave-pix" );

				// BBAPIVersao: 1 = API v2 do Banco do Brasil.

				acbrlibpixcd.configGravarValor( "BANCOBRASIL", "BBAPIVersao", "1" );
				acbrlibpixcd.configGravar();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}

				//Exemplo de código para criar e consultar uma cobrança imediata utilizando a ACBrLibPIXCD.
		private void onClick(View view) {
			
			try {
				
				String txId = "TXID12345678901234567890123";
				String caminhoCobranca = appDir.getAbsolutePath() + "/cobranca_imediata.ini";
				String respostaCobranca = acbrlibpixcd.CriarCobrancaImediata(caminhoCobranca, txId);
				String statusCobranca = acbrlibpixcd.ConsultarCobrancaImediata(txId, 0);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}



}
```


<a id="9-debug"></a>
# 9. Debug

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibPIXCD`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


