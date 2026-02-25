


# ACBrConsultaCNPJ


[![C#](https://img.shields.io/badge/C%23-8.0%2B-239120?logo=c-sharp&logoColor=white)](https://learn.microsoft.com/dotnet/csharp/)
[![NuGet](https://img.shields.io/nuget/v/ACBrLib.Core.svg?logo=nuget)](https://www.nuget.org/packages/ACBrLib.Core)
[![Target Frameworks](https://img.shields.io/badge/frameworks-net8%20%7C%20net452%20%7C%20netstandard2.0-512BD4)](#)
[![Docs](https://img.shields.io/badge/docs-README-informational)](#)


Bindings C# para a biblioteca nativa ACBrLibConsultaCNPJ, permitindo consultas de CNPJ em aplicações .NET de forma segura e eficiente.
Pacote NuGet: [ACBrLib.ConsultaCNPJMT](https://www.nuget.org/packages/ACBrLib.ConsultaCNPJMT)


## Índice

1. [Introdução](#1-introdução)
2. [Instalação](#2-instalação)
3. [Estrutura do Projeto](#3-estrutura-do-projeto)
4. [Exemplo de Uso](#4-exemplo-de-uso)
5. [Guia de Mapeamento da ACBrLib em C, C++ e C#](#5-guia-de-mapeamento-da-acbrlib-em-c-c-e-c)
    1. [Tipos Primitivos em Pascal](#51-tipos-primitivos-em-pascal)
    2. [Mapeamento de Tipos: Pascal, C/C++ e C#](#52-mapeamento-de-tipos-pascal-cc-e-c)
    3. [Exemplos de Interoperabilidade](#53-exemplos-de-interoperabilidade)
        1. [Pascal](#531-pascal)
        2. [C](#532-c)
        3. [C++](#533-c)
        4. [C#](#534-c)
6. [Referências](#6-referências)

## 1. Introdução
Este projeto fornece interoperabilidade entre .NET e ACBrLibConsultaCNPJ, facilitando integração, configuração e consulta de CNPJ.


## 2. Instalação

### Package reference 
Adicione ao seu `.csproj`:

```xml
<ItemGroup>
    <PackageReference Include="ACBrLib.ConsultaCNPJMT" Version="[1.0.8,(" />
</ItemGroup>
```

### .NET CLI

dotnet add package ACBrLib.ConsultaCNPJMT

## 3. Estrutura do Projeto
- **ACBrConsultaCNPJ**: Classe de alto nível que implementa a interface `IACBrLibConsultaCNPJ`. Fornece métodos para consultar informações cadastrais, gerenciar configurações, inicializar/finalizar a biblioteca e encapsular a interoperabilidade.
- **ACBrConsultaCNPJHandle**: Mapeamento C# da interface MultiThread (MT) cdecl da biblioteca nativa, permitindo integração direta e segura.


## 4. Exemplo de Uso
```csharp
using ACBrLib.Core;
using ACBrLib.ConsultaCNPJ;

// ACBrConsultaCNPJ implementa a interface IACBrLibConsultaCNPJ
IACBrLibConsultaCNPJ cnpj = new ACBrConsultaCNPJ("acbrlib.ini", "");
string resultado = "";
try {
    resultado = cnpj.Consultar("12345678000195");
}
catch(Exception ex) {
    Console.WriteLine(ex.Message);
}
finally {
    Console.WriteLine(resultado);
    cnpj.Dispose();
}
```


O tipo `integer` é o mais utilizado para valores inteiros nas funções da ACBrLib, mapeado para `int` em C/C#.

## 5. Guia de Mapeamento da ACBrLib em C, C++ e C#

Este guia tem por objetivo trazer informações relevantes sobre o mapeamento de métodos da ACBrLib. Muitas vezes não há exemplos prontos em outras linguagens, por isso este guia foi criado: para mostrar como mapear a ACBrLib em qualquer linguagem que tenha interoperabilidade com C/C++.

### 5.1 Tipos Primitivos em Pascal

Consulte: [Free Pascal Reference - Types](https://www.freepascal.org/docs-html/ref/refch3.html)

A ACBrLib utiliza tipos compatíveis com C, incluindo [strings](https://acbr.sourceforge.io/ACBrLib/ComotrabalharcomStrings.html). Entender o mapeamento facilita o uso em outras linguagens.




### 5.2 Mapeamento de Tipos: Pascal, C/C++ e C#

Veja: [C# ref - Microsoft Docs](https://learn.microsoft.com/pt-br/dotnet/csharp/language-reference/keywords/method-parameters#ref-parameter-modifier)

| Pascal                                        | C/C++         | C#             |
|-----------------------------------------------|---------------|----------------|
| PLibHandle = ^LibHandle; LibHandle = Pointer  | void*         | IntPtr         |
| PAnsiChar                                     | char*         | StringBuilder  |
| var integer                                   | int*          | ref int        |
| var double                                    | double*       | ref double     |
| var PLibHandle                                | void**        | ref IntPtr     |
| integer                                       | int           | int            |
| byte                                          | unsigned char | byte           |
| word                                          | unsigned short| ushort         |
| longint                                       | int           | int            |
| cardinal                                      | unsigned int  | uint           |
| boolean                                       | bool          | bool           |
| char                                          | char          | char           |
| string                                        | char*         | string         |
| double                                        | double        | double         |
| single                                        | float         | float          |
| var Pointer                                   | void**        | ref IntPtr     |



Em Pascal, `var` indica passagem por referência, equivalente a `ref` em C#. Todos os métodos nativos usam a convenção de chamada `cdecl`.




### 5.3 Exemplos de Interoperabilidade

#### 5.3.1 Pascal
Procedures são mapeadas como funções `void` em linguagens baseadas em C.
```pascal
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig, eChaveCrypt: PAnsiChar): integer; cdecl;
function CNPJ_Finalizar(libHandle: PLibHandle); cdecl;
procedure CNPJ_F(); cdecl; // Exemplo didático
```




#### 5.3.2 C
```c
extern int CNPJ_Inicializar(void **libHandle, const char *eArqConfig, const char *eChaveCrypt);
extern int CNPJ_Finalizar(void *libHandle);
extern int CNPJ_Nome(void *libHandle, const char *esRetorno, int *esTamanho);
extern void CNPJ_F();
```




#### 5.3.3 C++
```cpp
extern "C" {
    int  CNPJ_Inicializar(void **libHandle, const char *eArqConfig, const char *eChaveCrypt);
    int  CNPJ_Finalizar(void *libHandle);
    int  CNPJ_Nome(void *libHandle, const char *esRetorno, int *esTamanho);
    void CNPJ_F();
}
```




#### 5.3.4 C#
```csharp
[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Inicializar(ref IntPtr libHandle, string eArqConfig, string eChaveCrypt);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Finalizar(IntPtr handle);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Nome(IntPtr handle, StringBuilder esRetorno, ref int esTamanho);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate void CNPJ_F();
```




Cada parâmetro e tipo é convertido conforme a tabela acima. Consulte o código-fonte para detalhes de cada método e mapeamento.


## 6. Referências
- [ACBrLibConsultaCNPJMT.pas (Pascal)](https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/ConsultaCNPJ/ACBrLibConsultaCNPJMT.pas)
- [Documentação ACBrLib MultiThread](https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html)
- [Var em Freepascal](https://wiki.freepascal.org/Var)
- [C# ref - Microsoft Docs](https://learn.microsoft.com/pt-br/dotnet/csharp/language-reference/keywords/method-parameters#ref-parameter-modifier)
