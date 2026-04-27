
ACBrLibBAL Android
---
Biblioteca para uso de componente ACBrLibBAL em Android

Permite a utilização do componente ACBrLibBAL em projetos Android, facilitando a integração de funcionalidades relacionadas ao controle de balanças.

## Getting Started ##


### Requisitos Mínimos ###
+	Android 24 ( Android 7.0 Nougat) ou superior
+	Android Android Gradle Plugin 8.6.0 ou superior


### Alinhamento de páginas de memória de 16 KB ###

Este aar foi compilado com alinhamento de páginas de memória de 16 KB, o que é necessário para garantir a compatibilidade com o Android 15. Para mais informações sobre essa mudança e suas implicações, consulte o tópico no fórum do Projeto ACBr:
https://www.projetoacbr.com.br/forum/topic/86443-projeto-acbr-e-compatibiliza%C3%A7%C3%A3o-do-android-15/


### Importar no build.gradle ###

Em seu projeto de aplicativo Android

1. Crie a pasta ./app/libs

2. Abra seu arquivo build.gradle de app e adicione
```build.gradle
implementation( files('./libs/ACBrLibBAL-release.aar'))
implementation "net.java.dev.jna:jna:5.18.1@aar"
```

3.Sincronize o gradle

### Import no build.gradle.kts ###

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

Sincronize o gradle

File -> Sync project with Gradle Files (Control + shift + O)
