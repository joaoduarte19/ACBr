
ACBrLibConsultaCNPJ Android
---
Biblioteca para uso de componente ACBrLibConsultaCNPJ em Android

Permite a utilização da ACBrConsultaCNPJ em projetos Android, facilitando a integração de funcionalidades relacionadas à consulta de CNPJs.

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
8. [Recomendaçoes de segurança para armazenamento de certificados e chaves](#8-recomendacoes-seguranca)
9. [Exemplo de uso](#9-exemplo-de-uso)
10. [Debug](#10-debug)
11. [Referências](#11-referencias)
	1. [Configurações gerais](#111-configuracoes-gerais)

<a id="1-requisitos-minimos"></a>
# 1. Requisitos Mínimos

+	Android 24 ( Android 7.0 Nougat) ou superior
+	Android Android Gradle Plugin 8.6.0 ou superior


<a id="2-alinhamento-16kb"></a>
# 2. Alinhamento de páginas de memória de 16 KB

Este aar foi compilado com alinhamento de páginas de memória de 16 KB, o que é necessário para garantir a compatibilidade com o Android 15.

Para mais informações sobre essa mudança e suas implicações, consulte o tópico no fórum do Projeto ACBr:
https://www.projetoacbr.com.br/forum/topic/86443-projeto-acbr-e-compatibiliza%C3%A7%C3%A3o-do-android-15/

<a id="3-importar-aar"></a>
# 3. Importar AAR

<a id="31-importar-build-gradle"></a>
## 3.1 Importar no build.gradle

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs

2. Abra seu arquivo build.gradle de app e adicione
```build.gradle
implementation( files('./libs/ACBrLibConsultaCNPJ-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3. Sincronize o gradle

<a id="32-importar-build-gradle-kts"></a>
## 3.2 Importar no build.gradle.kts

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

3. Sincronize o gradle

No Android Studio, acesse:

File -> Sync project with Gradle Files (Control + shift + O)


<a id="4-configuracoes-da-biblioteca"></a>
# 4. Configurações da Biblioteca

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca20.html


<a id="5-permissoes-necessarias"></a>
# 5. Permissões Necessárias

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
	<uses-permission android:name="android.permission.INTERNET" />
</manifest>
```

<a id="6-fluxo-de-uso"></a>
# 6. Fluxo de uso da ACBrLibConsultaCNPJ
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="7-informacoes-adicionais"></a>
# 7. Informações adicionais

<a id="71-classe-da-biblioteca"></a>
## 7.1 Classe da biblioteca

#### Classe principal da biblioteca ACBrLibConsultaCNPJ ####
Importar a classe: [ACBrLibConsultaCNPJ](ACBrLibConsultaCNPJ/src/main/java/br/com/acbr/lib/consultacnpj/ACBrLibConsultaCNPJ.java)

```java
import br.com.acbr.lib.consultacnpj.ACBrLibConsultaCNPJ;
```

<a id="72-recomendacoes-por-biblioteca"></a>
## 7.2 Recomendações por biblioteca


## Índice desta seção
1. [Configuração essencial](#721-configuracao-essencial)
2. [Exemplo prático](#722-exemplo-pratico)
3. [Observações](#723-observacoes)

<a id="721-configuracao-essencial"></a>
## 7.2.1 Configuração essencial
Na ACBrLibConsultaCNPJ, o ponto principal é selecionar o WebService/provedor usado na consulta.

<a id="722-exemplo-pratico"></a>
## 7.2.2 Exemplo prático
```java
acbrlibconsultacnpj.configGravarValor( "ConsultaCNPJ", "WebService", "1" );
```

<a id="723-observacoes"></a>
## 7.2.3 Observações
Conforme o provedor selecionado, também pode ser necessário informar:
- Usuario
- Senha

Se houver autenticação no serviço escolhido, essas credenciais devem ser configuradas antes da chamada consultar(...).


<a id="8-recomendacoes-seguranca"></a>
# 8. Recomendações de segurança para armazenamento de certificados e chaves

Certificados digitais, chaves de API e outras credenciais sensíveis nunca devem ser armazenados em texto puro no código-fonte. Para garantir a segurança dessas informações, utilize mecanismos de armazenamento seguro fornecidos pelo Android, como Android Keystore ou EncryptedSharedPreferences.

Consulte a documentação oficial do Android sobre armazenamento seguro: https://developer.android.com/training/data-storage?hl=pt-br

Recomenda-se usar `getFilesDir()` para armazenar arquivos de configuração, certificados e outros dados sensíveis, garantindo que eles fiquem protegidos no armazenamento interno do aplicativo. Evite usar `getExternalFilesDir()` para esses fins, pois o armazenamento externo pode ser acessado por outros aplicativos e usuários.

<a id="9-exemplo-de-uso"></a>
# 9. Exemplo de uso

Exemplo de código para utilização da biblioteca ACBrLibConsultaCNPJ:

**Obs:** Este é um exemplo didático, alguns trechos de código foram omitidos ou simplificados para focar na estrutura de uso da biblioteca.
Ajuste conforme as necessidades do seu projeto e as melhores práticas de desenvolvimento Android.

```java
import br.com.acbr.lib.consultacnpj.ACBrLibConsultaCNPJ;
import java.io.File;

public class MainActivity extends AppCompatActivity {

	private ACBrLibConsultaCNPJ acbrlibconsultacnpj;
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


<a id="10-debug"></a>
# 10. Debug

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibConsultaCNPJ`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


<a id="11-referencias"></a>
# 11. Referências

<a id="111-configuracoes-gerais"></a>
## 11.1 Configurações gerais

- Documentação geral da ACBrLib: https://acbr.sourceforge.io/ACBrLib/Geral.html


