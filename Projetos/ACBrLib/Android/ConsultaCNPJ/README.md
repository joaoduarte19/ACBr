
ACBrLibConsultaCNPJ Android
---
Biblioteca para uso de componente ACBrLibConsultaCNPJ em Android

Permite a utilização da ACBrConsultaCNPJ em projetos Android, facilitando a integração de funcionalidades relacionadas à consulta de CNPJs.

## Getting Started ##

## Índice ##
1. [Requisitos Mínimos](#1-requisitos-minimos)
2. [Alinhamento de páginas de memória de 16 KB](#2-alinhamento-16kb)
3. [Importar no build.gradle](#3-importar-build-gradle)
4. [Importar no build.gradle.kts](#4-importar-build-gradle-kts)
5. [Configurações da Biblioteca](#5-configuracoes-da-biblioteca)
6. [Permissões Necessárias](#6-permissoes-necessarias)
7. [Fluxo de uso](#7-fluxo-de-uso)
8. [Exemplo de uso](#8-exemplo-de-uso)


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
implementation( files('./libs/ACBrLibConsultaCNPJ-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3.Sincronize o gradle

<a id="4-importar-build-gradle-kts"></a>
### 4. Import no build.gradle.kts ###

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs
2. Em ./app/build.gradle.kts adicione as seguintes linhas:
```build.gradle.kts
	implementation(files("./libs/ACBrLibConsultaCNPJ-release.aar"))
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
Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca20.html


<a id="6-permissoes-necessarias"></a>
### 6. Permissões Necessárias ###

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<uses-permission android:name="android.permission.INTERNET" />
		</manifest>
```

<a id="7-fluxo-de-uso"></a>
### 7. Fluxo de uso da ACBrLibConsultaCNPJ ###
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')


<a id="8-exemplo-de-uso"></a>
### 8. Utilizando a biblioteca ACBrLibConsultaCNPJ ###
Exemplo de código para utilização da biblioteca ACBrLibConsultaCNPJ:
```java
import br.com.acbr.lib.consultacnpj.ACBrLibConsultaCNPJ;

public class MainActivity extends AppCompatActivity {

	private ACBrLibConsultaCNPJ acbrlibconsultacnpj;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// Inicialize a biblioteca
		String eArquivoConfig = getFilesDir().getAbsolutePath() + "/ACBrLib.ini";
		String chaveCrypt = "";
		acbrlibconsultacnpj = new ACBrLibConsultaCNPJ(eArquivoConfig, chaveCrypt);

		aplicarConfiguracoes();


		// finalizar lib em onDestroy
		@Override
		protected void onDestroy() {
			super.onDestroy();
			try {
				acbrlibconsultacnpj.finalizar();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// Método para aplicar as configurações mínimas da ACBrLibConsultaCNPJ:
		private void aplicarConfiguracoes() {
			try {
				acbrlibconsultacnpj.inicializar();
				
				acbrlibconsultacnpj.configGravarValor( "ConsultaCNPJ", "WebService", "1" );
				acbrlibconsultacnpj.configGravar();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}

				//Exemplo de código para consulta de CNPJ utilizando a ACBrLibConsultaCNPJ.
		private void onClick(View view) {
			
			try {
				
				String respostaCNPJ = acbrlibconsultacnpj.consultar("12345678000195");
			}catch (Exception e) {
				e.printStackTrace();
			}
		}



}
```




