
ACBrLibNFe Android
---
Biblioteca para uso de componente ACBrLibNFe em Android

Permite a utilização da ACBrNFe em projetos Android, facilitando a integração de funcionalidades relacionadas à emissão e gerenciamento de Notas Fiscais Eletrônicas (NFe).

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
implementation( files('./libs/ACBrLibNFe-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3.Sincronize o gradle

<a id="4-importar-build-gradle-kts"></a>
### 4. Import no build.gradle.kts ###

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

Sincronize o gradle

File -> Sync project with Gradle Files (Control + shift + O)


<a id="5-configuracoes-da-biblioteca"></a>
### 5. Configurações da Biblioteca ### 

Link para documentação de configurações da biblioteca: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca16.html


<a id="6-permissoes-necessarias"></a>
### 6. Permissões Necessárias ###

```xml
<?xml version="1.0" encoding="utf-8"?>
		<manifest xmlns:android="http://schemas.android.com/apk/res/android">
			<uses-permission android:name="android.permission.INTERNET" />
		</manifest>
```

<a id="7-fluxo-de-uso"></a>
### 7. Fluxo de uso da ACBrLibNFe ###
1. Inicialização da biblioteca
2. Aplicação das configurações necessárias
3. Utilização das funcionalidades da biblioteca
4. Finalização da biblioteca (recomendada para liberação de recursos) (considere o ciclo de vida da sua aplicação para escolher o melhor momento para finalizar, ex: onDestroy de uma Activity ou Fragment')

<a id="8-informacoes-adicionais"></a>
### 8. Informações adicionais ###

#### Classe principal da biblioteca ACBrLibNFe ####
[ACBrLibNFe](ACBrLibNFe/src/main/java/br/com/acbr/lib/nfe/ACBrLibNFe.java)

### Informações adicionais sobre emissão de NFe/NFCe ###

Os comentários do exemplo deixam estes pontos como essenciais antes da emissão:
- Certificado, SSL e ambiente de WebService devem ser configurados previamente.
- Para emitir NFCe, os dados básicos continuam os mesmos da NFe, mudando o modelo e alguns grupos/campos que deixam de ser obrigatórios.
- Para NFCe, ajuste o modelo do documento para NFCe e o TipoDANFE para 4 (tiNFCe).
- Se for gerar PDF da DANFE, defina também o PathPDF na seção DANFe.

Exemplo prático de configuração para emissão de NFCe:
```java
acbrlibnfe.configGravarValor( "NFe", "Ambiente", "1" );
acbrlibnfe.configGravarValor( "NFe", "PathSchemas", getFilesDir().getAbsolutePath() + "/Schemas/NFe" );
acbrlibnfe.configGravarValor( "NFe", "PathSalvar", getFilesDir().getAbsolutePath() + "/Notas" );
acbrlibnfe.configGravarValor( "NFe", "ModeloDF", "1" ); // NFCe
acbrlibnfe.configGravarValor( "DANFe", "PathPDF", getFilesDir().getAbsolutePath() + "/DANFe" );
acbrlibnfe.configGravarValor( "DANFe", "TipoDANFE", "4" ); // tiNFCe
```

No XML/INI carregado da nota, o modelo também precisa estar ajustado para NFCe.
Se estiver emitindo NFe comum, mantenha o TipoDANFE compatível com o layout desejado, por exemplo 0 (sem geração), 1 (retrato) ou 2 (paisagem).

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

Resumo dos valores de TipoDANFE usados no exemplo:
- 0 = tiSemGeracao
- 1 = tiRetrato
- 2 = tiPaisagem
- 3 = tiSimplificado
- 4 = tiNFCe
- 5 = tiMsgEletronica


<a id="9-exemplo-de-uso"></a>
### 9. Utilizando a biblioteca ACBrLibNFe ###
Exemplo de código para utilização da biblioteca ACBrLibNFe:
```java
import br.com.acbr.lib.nfe.ACBrLibNFe;

public class MainActivity extends AppCompatActivity {

	private ACBrLibNFe acbrlibnfe;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// Inicialize a biblioteca
		String eArquivoConfig = getFilesDir().getAbsolutePath() + "/ACBrLib.ini";
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
				
				// Fluxo de emissao NFe/NFCe: https://acbr.sourceforge.io/ACBrLib/ComoemitirumaNFeouNFCe.html
				acbrlibnfe.configGravarValor( "Principal", "LogNivel", "4" );
				acbrlibnfe.configGravarValor( "DFe", "SSLCryptLib", "1" );
				acbrlibnfe.configGravarValor( "DFe", "SSLHttpLib", "3" );
				acbrlibnfe.configGravarValor( "DFe", "SSLXmlSignLib", "4" );
				// Certificado A1 (.pfx) e senha devem vir de armazenamento seguro.
				acbrlibnfe.configGravarValor( "DFe", "ArquivoPFX", getFilesDir().getAbsolutePath() + "/certificado.pfx" );
				acbrlibnfe.configGravarValor( "DFe", "Senha", "SuaSenhaAqui" );
				acbrlibnfe.configGravarValor( "NFe", "PathSchemas", getFilesDir().getAbsolutePath() + "/Schemas/NFe" );
				acbrlibnfe.configGravarValor( "NFe", "PathSalvar", getFilesDir().getAbsolutePath() + "/Notas" );
				// ModeloDF: 0 = NFe, 1 = NFCe.
				acbrlibnfe.configGravarValor( "NFe", "ModeloDF", "1" );
				// Ambiente: 1 = homologacao (demo), ajuste para producao quando necessario.
				acbrlibnfe.configGravarValor( "NFe", "Ambiente", "1" );

				//Seçao DANFe
				acbrlibnfe.configGravarValor( "DANFe", "PathPDF", getFilesDir().getAbsolutePath() + "/DANFe" );
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


<a id="10-Debug"></a>
### 10. Debug ###

Logs da biblioteca são mostrados no logcat, basta  procurar pela tag `ACBrLibNFe`. Para facilitar a identificação, é recomendado configurar o LogNivel para 4 (Debug) durante o desenvolvimento, e ajustar para um nível mais restritivo (ex: 2 - Erro) em produção.


