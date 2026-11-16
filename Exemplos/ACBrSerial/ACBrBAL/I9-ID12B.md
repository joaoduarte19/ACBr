# I9 ID-12B

Nos exemplos Delphi, Lazarus, FireMonkey e Android, selecione `balI9ID12B`
na lista de modelos. A lista usa `TACBrBALModelo` e inclui o novo modelo
automaticamente apos recompilar o componente e o exemplo.

## Configuracao do indicador

- P1 = 1: peso em kg.
- P3: velocidade igual a configurada no exemplo (9600, 4800, 2400 ou 1200).
- Comunicacao serial: 8 bits de dados, sem paridade e 1 bit de parada.
- P4 = 1: peso liquido (`wn`); 2: bruto (`ww`); 3: tara (`wt`).
- P5 = 3: modo de comando. O botao de leitura envia `R`, sem CR/LF.
- Para monitoramento continuo, configure P5 = 1 ou 2 e habilite o
  monitoramento no exemplo. P5 = 2 transmite somente quando estavel.

O protocolo nao informa um estado de estabilidade no quadro de peso.
Para receber somente leituras estaveis, use a configuracao do indicador.

## Conferencia da leitura

Respostas recebidas e pesos esperados em kg:

| Resposta (antes de CR/LF) | Peso |
| --- | ---: |
| `wn00146.8kg` | 146,8 |
| `wn00049.5kg` | 49,5 |
| `wn000.005kg` | 0,005 |
| `ww0014.68kg` | 14,68 |
| `wt000.500kg` | 0,5 |
| `wn000146kg` | 146 |
| `wn0001.000lb` | 0,45359237 |

A posicao decimal vem da resposta; nao existe divisor fixo por 1000.
A leitura serial aguarda CR/LF, conforme os registros de comunicacao fornecidos.
O retorno em libras e convertido para kg. Peso negativo retorna -2,
conforme a convencao do ACBrBAL. Quadros invalidos retornam zero.
Os modelos anteriores conservam seus protocolos.

Habilite o log, confira o quadro RX e o valor de UltimoPesoLido. Compare
com o visor da balanca em zero e em diferentes pesos fracionarios.
Confira tambem o modo continuo e o modo de comando no equipamento.

## Testes de regressao

- Delphi: `Testes/Dunit/ACBrSerial/ACBrBALTestCases.dpr`.
- Lazarus: `Testes/FPCUnit/ACBrSerial/ACBrBALTestCases.lpr`.
- Unidade compartilhada: `Testes/FPCUnit/ACBrSerial/ACBrBALI9ID12BTest.pas`.

Use os caminhos de fontes e bibliotecas dos demais projetos de teste
ACBr (ACBrComum, ACBrSerial, synalist, pasta Testes e framework de teste).
No Delphi, o define NOGUI permite executar o runner em console.
Os testes nao precisam de porta serial nem de balanca conectada.
A comunicacao fisica deve ser validada com o equipamento.
