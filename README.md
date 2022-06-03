# Quick Sum

Repositório contendo pequeno projeto em c + assembly para realização de somas rápidas em vetores de inteiros.



## main.c

O código em c utiliza de uma função externa, desenvolvida no arquivo quick_sum.asm, que realiza a soma de dois vetores de inteiro com mesmo tamanho e retorna um terceiro vetor de inteiro contendo a soma dos elementos correspondentes.

```c
int * _quickSum(int *vetorA, int *vetorB, int qtd_iter);
```

Em seguida, os vetores são inicializados e são extraídas a quantidade de elementos dos vetores, assim como, a quantidade de iterações necessárias para realizar as somas (2 por vez).

```c
int vetorA[5] = {0, 2, 4, 6, 8};
int vetorB[5] = {1, 3, 5, 7, 9};

int qtd_elementos = sizeof(vetorA) / sizeof(int);
int qtd_iter = (qtd_elementos - 1) / 2;
```

Por fim, um terceiro vetor é inicializado, recebendo o resultado da chamada da função _quickSum e seus elementos são impressos no console.

```c
int *vetorC = _quickSum(vetorA, vetorB, qtd_iter);

printf("Soma dos elementos dos vetores A e B:\n");
printf("{ ");
for (int i = 0; i < qtd_elementos; i++)
{
    printf("%d, ", vetorC[i]);
}
printf("}\n");
```



## quick_sum.asm

O código asm inicializa a variável vetorC na memória e resguarda a pilha de execução.

```assembly
SECTION .bss
	vetorC	RESD	1

SECTION .text
GLOBAL _quickSum
_quickSum:
	push EBP
	mov  EBP, ESP
```

Em seguida os parâmetros são salvos nos registradores EDI, ESI e ECX, respectivamente, esse último servirá de contador para o loop das somas.

```assembly
mov EDI, [EBP + 8]
mov ESI, [EBP + 12]
mov ECX, [EBP + 16]
```

É iniciado então o loop responsável por fazer a soma dos elementos, a cada iteração duas posições do `vetorA` são carregadas em `MM0`, duas posições do `vetorB` são adicionadas às posições carregadas em `MM0` e por fim o resultado é salvo nas posições correspondentes do `vetorC`.

```assembly
.loopSum:
	movq  MM0, QWORD[EDI + ECX * 8 - 8]
	paddb MM0, QWORD[ESI + ECX * 8 - 8]
	movq  QWORD[vetorC + ECX * 8 - 8], MM0
	
	loop .loopSum
```

Por fim, o endereço do `vetorC` é retornado através de `EAX` e a pilha de execução é restaurada.

```assembly
mov EAX, vetorC

mov ESP, EBP
pop	EBP
ret	12
```



## Compilação e Execução

Para compilar e executar o código é necessário ter `nasm` e `gcc` instalados, em seguida é preciso executar os seguintes comandos no terminal:

``` bash
$ make
$ ./quick_sum
```



## Referência

O código apresentado nesse repositório parte de estudos iniciados no curso de [Coprocessamento em Computadores x86](https://www.youtube.com/playlist?list=PLSe9457zOLtzx1RGkmNg6czotRmD2jkZ0) do monitor Pedro Botelho no canal [Pedro Botelho](https://www.youtube.com/c/PedroBotelho15) no YouTube.
