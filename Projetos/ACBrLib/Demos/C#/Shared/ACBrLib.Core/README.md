# ACBrLib.Core

[![C#](https://img.shields.io/badge/C%23-8.0%2B-239120?logo=c-sharp&logoColor=white)](https://learn.microsoft.com/dotnet/csharp/)
[![NuGet](https://img.shields.io/nuget/v/ACBrLib.Core.svg?logo=nuget)](https://www.nuget.org/packages/ACBrLib.Core)
[![Target Frameworks](https://img.shields.io/badge/frameworks-net8%20%7C%20net452%20%7C%20netstandard2.0-512BD4)](#)
[![Docs](https://img.shields.io/badge/docs-README-informational)](#)

Biblioteca base em C# para integração com as bibliotecas ACBrLib, fornecendo classes, enums e contratos para configuração, manipulação e uso das funcionalidades ACBr em aplicações .NET.

## Escopo

Este pacote concentra os tipos compartilhados da ACBrLib.Core:

- contratos base das bibliotecas;
- classes de configuração comuns;
- enums reutilizados entre módulos;
- exceções base.

## Getting Started

Instale o pacote `ACBrLib.Core` via NuGet no projeto consumidor.

### .NET CLI

```bash
dotnet add package ACBrLib.Core
```

### PackageReference no `.csproj`

```xml
<ItemGroup>
  <PackageReference Include="ACBrLib.Core" Version="[1.2.41,)" />
</ItemGroup>
```

> `Version="[1.2.41,)"` permite restaurar a versão 1.2.41 ou superior.

Após a instalação, referencie os tipos base conforme a necessidade do pacote consumidor (por exemplo, [IACBrLibBase](IACBrLibBase.cs), [ACBrLibConfig](Config/ACBrLibConfig.cs) e [ACBrLibConfigBase](Config/ACBrLibConfigBase.cs)).

### Principais Classes e Interfaces

- **[ACBrLibBase](ACBrLibBase.cs)**  
  Classe abstrata base para bibliotecas ACBrLib em C#.
- **[IACBrLibBase](IACBrLibBase.cs)**  
  Interface base com as operações comuns entre bibliotecas.
- **[ACBrLibHandleBase](ACBrLibHandleBase.cs)**  
  Classe base para integração com bibliotecas nativas (carregamento e execução de métodos nativos).
- **[ACBrLibConfigBase](Config/ACBrLibConfigBase.cs)**  
  Classe base para sessões de configuração.
- **[ACBrLibConfig](Config/ACBrLibConfig.cs)**  
  Classe indicada para centralizar configurações comuns a todas as bibliotecas ACBrLib.
- **[ACBrLibDFeConfig](Config/ACBrLibDFeConfig.cs)**  
  Classe base de configuração comum para bibliotecas de documentos fiscais eletrônicos (DFe).
- **[DFeConfig](Config/DFeConfig.cs)**  
  Sessão de configuração comum a todos os DFes.
- **[ACBrLibException](ACBrLibException.cs) / [ACBrLibTimeoutException](ACBrLibException.cs)**  
  Exceções base para erros e timeout.

### Principais Enums

- **[ACBrSessao](ACBrSessao.cs)**  
  Enumera as sessões de configuração.
- **[TipoResposta](TipoResposta.cs)**  
  Define o formato de resposta (INI, XML, JSON).
- **[CodResposta](CodResposta.cs)**  
  Define a codificação da resposta (UTF8, ANSI).
- **[NivelLog](NivelLog.cs)**  
  Define o nível de detalhamento do log.
- **[ACBrPessoa](Boleto/ACBrPessoa.cs)**  
  Enumera os tipos de pessoa.

## Outras Funcionalidades Disponíveis

Além dos tipos principais, este pacote também fornece utilitários compartilhados para leitura/escrita de INI e mapeamento de propriedades:

- **[ACBrIniFile](Ini/ACBrIniFile.cs)**  
  Manipulação de arquivo INI e coleção de seções.
- **[ACBrIniSection](Ini/ACBrIniSection.cs)**  
  Representa uma seção INI com leitura e escrita de chaves.
- **[IniUtil](Ini/IniUtil.cs)**  
  Métodos de apoio para serializar e desserializar objetos para/de INI.
- **[IniValueWrapper](Ini/IniValueWrapper.cs)**  
  Conversão de tipos para valores de INI e vice-versa.
- **[IniKeyAttribute](Ini/IniKeyAttribute.cs)**  
  Permite mapear nome de chave INI diferente do nome da propriedade.
- **[IniIgnoreAttribute](Ini/IniIgnoreAttribute.cs)**  
  Ignora propriedades durante a leitura/escrita de INI.
- **[EnumValueAttribute](Ini/EnumValueAttribute.cs)**  
  Define representação textual personalizada para valores de enum em INI.

## Nota

A refatoração das classes C# está em andamento. Este documento descreve apenas conceitos e tipos gerais já disponíveis no projeto, sem exemplos de uso específicos.

## Recomendações de Herança e Interfaces

- Prefira programar contra interfaces: interfaces específicas dos pacotes consumidores devem herdar de [IACBrLibBase](IACBrLibBase.cs).
- Classes de configuração devem receber no tipo genérico uma interface que implemente [IACBrLibBase](IACBrLibBase.cs) (padrão: `where TLib : IACBrLibBase`).
- Use [ACBrLibConfig](Config/ACBrLibConfig.cs) para centralizar configurações comuns entre bibliotecas.
- Em bibliotecas de DFe, utilize [ACBrLibDFeConfig](Config/ACBrLibDFeConfig.cs) para reaproveitar configurações compartilhadas.
- Use [ACBrLibConfigBase](Config/ACBrLibConfigBase.cs) para criar sessões de configuração específicas.
- Evite criar dependência nova sobre classes marcadas para descontinuação.

## Documentação

- [Wiki ACBrLib](https://acbr.sourceforge.io/ACBrLib/BemVindo.html)
- [Notícia oficial da refatoração](https://www.projetoacbr.com.br/forum/topic/90474-projeto-acbr-est%C3%A1-refatorando-as-classes-c/)
- Consulte os comentários XML nas classes para detalhes de cada método e propriedade.

---
