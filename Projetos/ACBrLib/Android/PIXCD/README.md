
ACBrLibPIXCD Android
---
Biblioteca para uso de componente ACBrLibPIXCD em Android

Permite a utilização da ACBrPIXCD em projetos Android, facilitando a integração de funcionalidades relacionadas ao sistema de pagamentos instantâneos PIX.

# Getting Started #

## Índice ##
1. [Requisitos Mínimos](#1-requisitos-minimos)
2. [Alinhamento de páginas de memória de 16 KB](#2-alinhamento-16kb)
3. [Importar no build.gradle](#3-importar-build-gradle)
4. [Importar no build.gradle.kts](#4-importar-build-gradle-kts)
5. [Configurações da Biblioteca](#5-configuracoes-da-biblioteca)
6. [Permissões Necessárias](#6-permissoes-necessarias)
7. [Fluxo de uso](#7-fluxo-de-uso)
8. [Informações adicionais](#8-informacoes-adicionais)
9. [Exemplo de uso](#9-exemplo-de-uso)
10. [Debug](#10-debug)


<a id="1-requisitos-minimos"></a>
### 1. Requisitos Mínimos ###

+	Android 24 ( Android 7.0 Nougat) ou superior
+	Android Android Gradle Plugin 8.6.0 ou superior


<a id="2-alinhamento-16kb"></a>
### 2. Alinhamento de páginas de memória de 16 KB ###

Este aar foi compilado com alinhamento de páginas de memória de 16 KB, o que é necessário para garantir a compatibilidade com o Android 15. Para mais informações sobre essa mudança e suas implicações, consulte o tópico no fórum do Projeto ACBr:
https://www.projetoacbr.com.br/forum/topic/86443-projeto-acbr-e-compatibiliza%C3%A7%C3%A3o-do-android-15/


<a id="3-importar-build-gradle"></a>
### 3. Importar no build.gradle ###

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs

2. Abra seu arquivo build.gradle de app e adicione
```build.gradle
implementation( files('./libs/ACBrLibPIXCD-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3.Sincronize o gradle

<a id="4-importar-build-gradle-kts"></a>
### 4. Import no build.gradle.kts ###

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

Sincronize o gradle

File -> Sync project with Gradle Files (Control + shift + O)


<a id="5-configuracoes-da-biblioteca"></a>
### 5. Configurações da Biblioteca ### 

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html


<a id="6-permissoes-necessarias"></a>
### 6. Permissões Necessárias ###

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<uses-permission android:name="android.permission.INTERNET" />
		</manifest>
```

<a id="7-fluxo-de-uso"></a>
### 7. Fluxo de uso da ACBrLibPIXCD ###
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="8-informacoes-adicionais"></a>
### 8. Informações adicionais ###

#### Classe principal da biblioteca ACBrLibPIXCD ####
[ACBrLibPIXCD](ACBrLibPIXCD/src/main/java/br/com/acbr/lib/pixcd/ACBrLibPIXCD.java)

### Informações adicionais sobre configuração do PIXCD ###

Com base nas seções de configurações gerais, configuração da biblioteca PIXCD e exemplo de INI, o conjunto essencial do exemplo é:
- Sessão Principal: LogNivel e, quando necessário, LogPath.
- Sessão PIXCD: PSP, NomeRecebedor, CidadeRecebedor e UFRecebedor.
- Sessão do PSP escolhido: credenciais e chaves específicas do provedor.

Exemplo prático de configuração mínima para PIXCD com Banco do Brasil:
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

Exemplo prático do fluxo básico de cobrança imediata:
```java
String txId = "TXID12345678901234567890123";
String caminhoCobranca = getFilesDir().getAbsolutePath() + "/cobranca_imediata.ini";
String respostaCobranca = acbrlibpixcd.CriarCobrancaImediata(caminhoCobranca, txId);
String statusCobranca = acbrlibpixcd.ConsultarCobrancaImediata(txId, 0);
```

Para o fluxo de cobrança imediata usado no exemplo, o arquivo INI informado em CriarCobrancaImediata(...) deve conter os dados da cobrança no formato esperado pelo endpoint /Cob.
A partir da documentação de exemplo de INI, os cenários mais comuns são: criar cobrança imediata, revisar cobrança imediata, criar cobrança com vencimento e solicitar devolução PIX.

Se trocar o PSP, mantenha a sessão PIXCD com os dados do recebedor e substitua apenas a sessão específica do provedor pelas credenciais exigidas por ele.


<a id="9-exemplo-de-uso"></a>
### 9. Utilizando a biblioteca ACBrLibPIXCD ###
Exemplo de código para utilização da biblioteca ACBrLibPIXCD:
```java
import br.com.acbr.lib.pixcd.ACBrLibPIXCD;

public class MainActivity extends AppCompatActivity {

	private ACBrLibPIXCD acbrlibpixcd;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// Inicialize a biblioteca
		String eArquivoConfig = getFilesDir().getAbsolutePath() + "/ACBrLib.ini";
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
				String caminhoCobranca = getFilesDir().getAbsolutePath() + "/cobranca_imediata.ini";
				String respostaCobranca = acbrlibpixcd.CriarCobrancaImediata(caminhoCobranca, txId);
				String statusCobranca = acbrlibpixcd.ConsultarCobrancaImediata(txId, 0);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}



}
```


<a id="10-Debug"></a>
### 10. Debug ###

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibPIXCD`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


