# ACBrConsultaCNPJ
---
Pacote [ACBrLib.ConsultaCNPJMT](https://www.nuget.org/packages/ACBrLib.ConsultaCNPJMT)
A classe `ACBrConsultaCNPJ` oferece uma interface orientada a objetos para consumir os serviços da ACBrLibConsultaCNPJ em .NET, facilitando o uso, configuração e consulta de CNPJ. Ela gerencia o ciclo de vida do handle nativo, expõe métodos de consulta, leitura/gravação de configuração e trata erros da biblioteca nativa.

# ACBrConsultaCNPJ

## Introdução
Este projeto fornece bindings em C# para a biblioteca nativa ACBrLibConsultaCNPJ, permitindo consultas de CNPJ em aplicações .NET de forma segura e eficiente.

## Instalação
Adicione o pacote ao seu arquivo `.csproj`:

```xml
<PackageReference Include="ACBrLib.ConsultaCNPJMT" Version="1.0.7" />
```

## Estrutura do Projeto
- **ACBrConsultaCNPJ**: Classe de alto nível que implementa a interface `IACBrLibConsultaCNPJ`. Fornece métodos para consultar informações cadastrais de empresas, gerenciar configurações, inicializar/finalizar a biblioteca e encapsular a lógica de interoperabilidade.
- **ACBrConsultaCNPJHandle**: Mapeamento C# da interface MultiThread (MT) cdecl da biblioteca nativa, permitindo integração direta e segura.

## Exemplo de Uso
```csharp
var cnpj = new ACBrConsultaCNPJ("acbrlib.ini", "");
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

O tipo `integer` é o mais utilizado para valores inteiros nas funções da ACBrLib, sendo mapeado para `int` em C/C#.

## Tipos Primitivos em Pascal
Para mais detalhes, consulte: [Free Pascal Reference - Types](https://www.freepascal.org/docs-html/ref/refch3.html)

A ACBrLib utiliza tipos primitivos compatíveis com C, incluindo [strings](https://acbr.sourceforge.io/ACBrLib/ComotrabalharcomStrings.html). Entender como o C mapeia os métodos facilita o acesso à biblioteca por outras linguagens.


## Mapeamento de Tipos: Pascal, C/C++ e C#

Para detalhes sobre o uso de `ref` em C#, veja: [C# ref - Microsoft Docs](https://learn.microsoft.com/pt-br/dotnet/csharp/language-reference/keywords/method-parameters#ref-parameter-modifier)

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

## Exemplos de Interoperabilidade

### Pascal
```pascal
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig, eChaveCrypt: PAnsiChar): integer; cdecl;
function CNPJ_Finalizar(libHandle: PLibHandle); cdecl;
```

### C
```c
extern int CNPJ_Inicializar(void **libHandle, const char *eArqConfig, const char *eChaveCrypt);
extern int CNPJ_Finalizar(void *libHandle);
```

### C++
```cpp
extern "C" {
    int CNPJ_Inicializar(void **libHandle, const char *eArqConfig, const char *eChaveCrypt);
    int CNPJ_Finalizar(void *libHandle);
}
```

### C#
```csharp
[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Inicializar(ref IntPtr libHandle, string eArqConfig, string eChaveCrypt);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate void CNPJ_F();
```

Cada parâmetro e tipo é convertido conforme a tabela acima. Consulte o código-fonte para detalhes de cada método e mapeamento.

## Referências
- [ACBrLibConsultaCNPJMT.pas (Pascal)](https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/ConsultaCNPJ/ACBrLibConsultaCNPJMT.pas)
- [Documentação ACBrLib MultiThread](https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html)
- [Var em Freepascal](https://wiki.freepascal.org/Var)
Para mais detalhes sobre o uso de `ref` em C#, consulte a documentação oficial: [C# ref - Microsoft Docs](https://learn.microsoft.com/pt-br/dotnet/csharp/language-reference/keywords/method-parameters#ref-parameter-modifier)

| Pascal                                            | C/C++               | `C#`                |
|---------------------------------------------------|---------------------|---------------------|
| PLibHandle = ^LibHandle; LibHandle = Pointer      | `void *`               | IntPtr           |
| PAnsiChar                                         | `char *`               | StringBuilder    |
| var integer                                       | `int *`                | ref int          |
| var double                                        | `double *`             | ref double       |
| var PLibHandle                                    | `void **`              | ref IntPtr       |
| integer                                           | int                    | int              |
| byte                                              | unsigned char          | byte             |
| word                                              | unsigned short         | ushort           |
| longint                                           | int                    | int              |
| cardinal                                          | unsigned int           | uint             |
| boolean                                           | bool                   | bool             |
| char                                              | char                   | char             |
| string                                            | `char *`               | string           |
| double                                            | double                 | double           |
| single                                            | float                  | float            |
| var Pointer                                       | `void **`              | ref IntPtr       |

- Em Pascal, `var` (declaração de parâmetros de um `function` ou `procedure`) indica passagem por referência, equivalente a `ref` em `C#` .
- Todos os métodos nativos usam a convenção de chamada `cdecl`.

### Guia prático de mapeamento em C/C++ ###
Em C, var integer, pode ser representado como ponteiro do tipo int `int *`,

E `var pointer`, podemos usar `void *`.

O código em Pascal é mapeado:

```Pascal
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig, eChaveCrypt: PAnsiChar): integer; cdecl;
function CNPJ_Finalizar(libHandle: PlibHandle);cdecl; 
function CNPJ_Nome(libHandle: PlibHandle; const esRetorno : PAnsichar; var esTamanho : integer);
```

É traduzido em C:


```C
extern int CNPJ_Incializar(void ** libHandle, const char * eArqConfig, const char *eChaveCrypt);
extern int CNPJ_Finalizar(void * libHandle);
extern int CNPJ_Nome(void * libHandle, const char * esRetorno, int * esTamanho);
```

C++:

```CPP
extern "C" {
    int CNPJ_Incializar(void ** libHandle, const char * eArqConfig, const char *eChaveCrypt);
    int CNPJ_Finalizar(void * libHandle);
    int CNPJ_Nome(void * libHandle, const char * esRetorno, int * esTamanho);
}
```

### Guia prático de mapeamento em CSharp

O código Pascal:

```Pascal
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig: PAnsiChar, eChaveCrypt: PAnsiChar): integer; cdecl;
function CNPJ_Nome(libHandle: PLibHandle; buffer: PAnsiChar; var bufferSize: integer): integer; cdecl;
procedure CNPJ_F(); cdecl;
```

É mapeado em C\# da seguinte maneira:

```csharp
[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Inicializar(ref IntPtr libHandle, string eArqConfig, string eChaveCrypt);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int CNPJ_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate void CNPJ_F();
```

Cada parâmetro e tipo é convertido conforme a tabela de interoperabilidade apresentada acima.

- Consulte o código-fonte para detalhes de cada método e mapeamento.


### Referencias ###

- [ACBrLibConsultaCNPJMT.pas (Pascal)](https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/ConsultaCNPJ/ACBrLibConsultaCNPJMT.pas)
- [Documentação ACBrLib MultiThread](https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html)
- [Var em Freepascal ](https://wiki.freepascal.org/Var)
