
ACBrLibComum Android
---

ACBrLibComum é modulo que fornce funcionalidades básicas para as ACBrLibAndroid servindo de base para os demais AAR

## Getting Started ##


### Requisitos Mínimos ###
+	Android 24 ( Android 7.0 Nougat) ou superior
+	Android Android Gradle Plugin 8.6.0 ou superior


### Classes e pacotes Principais ###

+ [br.com.acbr.lib.comum](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/):
	+ [ACBrLibBase](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/ACBrLibBase.java) classe base das ACBrLib
	+ [ACBrBuffer](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/ACBrLibBuffer.java) Classe que abstrai a implementação de buffers nativos.

	+ [br.acbr.lib.comum.dfe](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/dfe/) Enumerados comuns de DFe
	+ [br.acbr.lib.comum.ini](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/ini/) Classes de leitura e escrita de Ini
	+ [br.acbr.lib.comum.helper](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/helper) Classes auxiliares
		+	[AssetsCopyHelper](ACBrLibComum/src/main/java/br/com/acbr/lib/comum/helper/AssetsCopyHelper.java) Classe auxiliar para copiar os assets para o App, muito usada para copiar os Schemas
