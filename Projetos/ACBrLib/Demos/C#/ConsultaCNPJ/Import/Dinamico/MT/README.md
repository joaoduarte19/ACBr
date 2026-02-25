
ACBrConsultaCNPJ
---

A classe `ACBrConsultaCNPJ` oferece uma interface orientada a objetos para consumir os serviços da ACBrLibConsultaCNPJ em .NET, facilitando o uso, configuração e consulta de CNPJ. Ela gerencia o ciclo de vida do handle nativo, expõe métodos de consulta, leitura/gravação de configuração e trata erros da biblioteca nativa.

Exemplo de uso:

```csharp
var cnpj = new ACBrConsultaCNPJ("acbrlib.ini", "");
string resultado = "";
try {
    resultado = cnpj.Consultar("12345678000195");
}
catch(Exception ex){
    Console.WriteLine(ex.Message);
}
finally {
    Console.WriteLine(resultado);
    cnpj.Dispose();
}
```

 O tipo `integer` é o mais usado para valores inteiros em funções da ACBrLib, e é mapeado para `int` em C/C#.
# ACBrConsultaCNPJHandle

Este projeto contém:

- **ACBrConsultaCNPJHandle**: Mapeamento C# da interface MultiThread (MT) cdecl da biblioteca nativa ACBrLibConsultaCNPJ, permitindo integração direta e segura com a DLL Pascal.
- **ACBrConsultaCNPJ**: Classe de alto nível que implementa a interface `IACBrLibConsultaCNPJ`, fornecendo métodos para consultar informações cadastrais de empresas a partir do CNPJ, gerenciar configuração, inicialização e finalização da biblioteca, além de encapsular toda a lógica de interoperabilidade.


## Objetivo

Facilitar a interoperabilidade entre aplicações .NET e a ACBrLibConsultaCNPJ, expondo as funções nativas via delegates e respeitando a convenção de chamada cdecl.


## Interoperabilidade e Mapeamento

## Tipos Primitivos em Pascal
Para mais detalhes sobre tipos em Pascal, consulte a documentação oficial: [Free Pascal Reference - Types](https://www.freepascal.org/docs-html/ref/refch3.html)

ACBrLib utiliza tipos primitivos compatíveis com C, inclusive [strings](https://acbr.sourceforge.io/ACBrLib/ComotrabalharcomStrings.html)
Inclusive esse é o mais fácil, entender como C mapea os métodos permite que outras linguagens acessem a lib.
Os tipos primitivos básicos em Pascal são:

- `integer`: Tipo inteiro, geralmente 32 bits (pode variar conforme compilador e plataforma). Equivalente a `int` em C/C#.
- `byte`: Valor inteiro de 0 a 255 (8 bits).
- `word`: Valor inteiro de 0 a 65535 (16 bits).
- `longint`: Inteiro de 32 bits, equivalente a `integer` em muitas plataformas.
- `cardinal`: Inteiro sem sinal de 32 bits.
- `boolean`: Tipo lógico, valores `True` ou `False`.
- `char`: Caractere (8 bits).
- `string`: Sequência de caracteres.
- `double`: Ponto flutuante de precisão dupla (64 bits).
- `single`: Ponto flutuante de precisão simples (32 bits).

## Fonte Original
- [ACBrLibConsultaCNPJMT.pas (Pascal)](https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/ConsultaCNPJ/ACBrLibConsultaCNPJMT.pas)
- [Documentação ACBrLib MultiThread](https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html)

## Interoperabilidade: Tabela de Mapeamento de Tipos 

Para mais detalhes sobre o uso de <code>ref</code> em C#, consulte a documentação oficial: [C# ref - Microsoft Docs](https://learn.microsoft.com/pt-br/dotnet/csharp/language-reference/keywords/ref)

| Pascal                                            | C/C++               | C\#              |
|---------------------------------------------------|---------------------|------------------|
| PLibHandle = ^LibHandle; LibHandle = Pointer      | void\*              | IntPtr           |
| PAnsiChar                                         | char\*              | StringBuilder    |
| var integer                                       | int\*               | ref int          |
| var PLibHandle                                    | void\*\*            | ref IntPtr       |
| integer                                           | int                 | int              |
| byte                                              | unsigned char       | byte             |
| word                                              | unsigned short      | ushort           |
| longint                                           | int                 | int              |
| cardinal                                          | unsigned int        | uint             |
| boolean                                           | bool                | bool             |
| char                                              | char                | char             |
| string                                            | char\*              | string           |
| double                                            | double              | double           |
| single                                            | float               | float            |
| var Pointer                                       | void\*\*            | ref IntPtr       |

- Em Pascal, `var` indica passagem por referência, equivalente a `ref` em C\# .
- Todos os métodos nativos usam a convenção de chamada `cdecl`.


O código em Pascal é mapeado:

```pascal
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig, eChaveCrypt: PAnsiChar): integer; cdecl;
```

É traduzido em C:

```c
extern int CNPJ_Incializar(void ** libHandle, const char * eArqConfig, const char *eChaveCrypt);
extern int CNPJ_Finalizar(void * libHandle);
```


C++:

```c++
extern "C" {
    int CNPJ_Incializar(void ** libHandle, const char * eArqConfig, const char *eChaveCrypt);
    int CNPJ_Finalizar(void * libHandle);
}

``` 

### Guia prático de mapeamento em CSharp ###

O código Pascal:

```delphi
function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig: PAnsiChar; eChaveCrypt: PAnsiChar): integer; cdecl;
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
