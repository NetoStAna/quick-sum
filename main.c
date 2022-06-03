#include <stdio.h>

// Protótipo da função desenvolvida em .asm
int * _quickSum(int *vetorA, int *vetorB, int qtd_iter);
/*
    Dados dois vetores de inteiro com mesmo tamanho,
    retorna um vetor de inteiro contendo a soma dos
    elementos correspondentes
*/

int main()
{
    int vetorA[5] = {0, 2, 4, 6, 8};
    int vetorB[5] = {1, 3, 5, 7, 9};

    int qtd_elementos = sizeof(vetorA) / sizeof(int); // Quantidade de elementos dos vetores
    int qtd_iter = (qtd_elementos + 1) / 2; // Quantidade de iterações de soma (2 por vez)

    int *vetorC = _quickSum(vetorA, vetorB, qtd_iter);

    printf("Soma dos elementos dos vetores A e B:\n");
    printf("{ ");
    for (int i = 0; i < qtd_elementos; i++)
    {
        printf("%d, ", vetorC[i]);
    }
    printf("}\n");

    return 0;
}
