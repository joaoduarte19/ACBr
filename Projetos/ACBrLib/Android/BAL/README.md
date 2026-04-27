
ACBrLibBAL Android
---
Biblioteca para uso de componente ACBrLibBAL em Android

Permite a utilização da ACBrBAL em projetos Android, facilitando a integração de funcionalidades relacionadas ao controle de balanças.

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
implementation( files('./libs/ACBrLibBAL-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3. Sincronize o gradle

<a id="32-importar-build-gradle-kts"></a>
## 3.2 Importar no build.gradle.kts

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs
2. Em ./app/build.gradle.kts adicione as seguintes linhas:
```build.gradle.kts
	implementation(files("./libs/ACBrLibBAL-release.aar"))
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

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca3.html


<a id="5-permissoes-necessarias"></a>
# 5. Permissões Necessárias

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<!-- Nenhuma permissao adicional necessaria para esta biblioteca -->
		</manifest>
```

<a id="6-fluxo-de-uso"></a>
# 6. Fluxo de uso da ACBrLibBAL
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="7-informacoes-adicionais"></a>
# 7. Informações adicionais

<a id="71-classe-da-biblioteca"></a>
## 7.1 Classe da biblioteca

#### Classe principal da biblioteca ACBrLibBAL ####
Importar a classe: [ACBrLibBAL](ACBrLibBAL/src/main/java/br/com/acbr/lib/bal/ACBrLibBAL.java)

```java
import br.com.acbr.lib.bal.ACBrLibBAL;
```

<a id="72-recomendacoes-por-biblioteca"></a>
## 7.2 Recomendações por biblioteca


## Índice desta seção
1. [Configuração essencial](#721-configuracao-essencial)
2. [Exemplo prático](#722-exemplo-pratico)
3. [Observações](#723-observacoes)

<a id="721-configuracao-essencial"></a>
## 7.2.1 Configuração essencial
Na ACBrLibBAL, a sessão BAL define porta e modelo, mas os parâmetros mais sensíveis ficam em BAL_Device.

Campos mais relevantes em BAL_Device:
- Baud: velocidade da porta serial
- Data: quantidade de bits de dados
- Parity: paridade da comunicação
- Stop: bits de parada
- HandShake: controle de fluxo serial
- TimeOut: tempo máximo de espera na comunicação

<a id="722-exemplo-pratico"></a>
## 7.2.2 Exemplo prático
```java
acbrlibbal.configGravarValor( "BAL", "Modelo", "1" );
acbrlibbal.configGravarValor( "BAL", "Porta", "/dev/ttyUSER0" );
acbrlibbal.configGravarValor( "BAL_Device", "Baud", "9600" );
acbrlibbal.configGravarValor( "BAL_Device", "Data", "8" );
acbrlibbal.configGravarValor( "BAL_Device", "Parity", "0" );
acbrlibbal.configGravarValor( "BAL_Device", "Stop", "0" );
acbrlibbal.configGravarValor( "BAL_Device", "HandShake", "0" );
acbrlibbal.configGravarValor( "BAL_Device", "TimeOut", "3" );
```

<a id="723-observacoes"></a>
## 7.2.3 Observações
Esses valores devem ser ajustados conforme o protocolo da balança e o equipamento Android utilizado.


<a id="8-exemplo-de-uso"></a>
# 8. Utilizando a biblioteca ACBrLibBAL

Exemplo de código para utilização da biblioteca ACBrLibBAL:

```java
import br.com.acbr.lib.bal.ACBrLibBAL;
import java.io.File;

public class MainActivity extends AppCompatActivity {

	private ACBrLibBAL acbrlibbal;
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
		acbrlibbal = new ACBrLibBAL(eArquivoConfig, chaveCrypt);

		aplicarConfiguracoes();


		// finalizar lib em onDestroy
		@Override
		protected void onDestroy() {
			super.onDestroy();
			try {
				acbrlibbal.finalizar();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// Método para aplicar as configurações mínimas da ACBrLibBAL:
		private void aplicarConfiguracoes() {
			try {
				acbrlibbal.inicializar();
				
				acbrlibbal.configGravarValor( "BAL", "Modelo", "1" );

				//A porta pode ser diferente dependendo do dispositivo e da balanca, ajuste conforme necessario. Exemplo: /dev/ttyS0, /dev/ttyUSB0, /dev/ttyUSER0, etc.
				//Entre em contato com o fabricante do equipamento (Android) para obter informações sobre a porta correta.
				acbrlibbal.configGravarValor( "BAL", "Porta", "/dev/ttyUSER0" );
				// Configurações seriais comuns (ajuste conforme o manual da balança).
				acbrlibbal.configGravarValor( "BAL_Device", "BaudRate", "9600" );
				acbrlibbal.configGravarValor( "BAL_Device", "Data", "8" );
				acbrlibbal.configGravarValor( "BAL_Device", "Parity", "0" );
				acbrlibbal.configGravarValor( "BAL_Device", "Stop", "1" );
				acbrlibbal.configGravarValor( "BAL_Device", "HandShake", "0" );
				acbrlibbal.configGravar();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}

				//Exemplo de código para leitura de peso utilizando a ACBrLibBAL.
		private void onClick(View view) {
			
			try {
				
				double peso = acbrlibbal.lePeso(1000);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}



}
```


<a id="9-debug"></a>
# 9. Debug

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibBAL`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


