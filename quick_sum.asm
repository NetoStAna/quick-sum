SECTION .bss
    ; Inicializar vetorC na memória
    vetorC  RESD    1

SECTION .text
GLOBAL _quickSum
_quickSum:
    ; Salvar Pilha de Execução
    push EBP
    mov  EBP, ESP

    mov EDI, [EBP + 8]  ; Salvar vetorA   em EDI
    mov ESI, [EBP + 12] ; Salvar vetorB   em ESI
    mov ECX, [EBP + 16] ; Salvar qtd_iter em ECX

    .loopSum:
        movq  MM0, QWORD[EDI + ECX * 8 - 8]     ; Carrega duas posições de vetorA em MM0
        paddb MM0, QWORD[ESI + ECX * 8 - 8]     ; Adiciona duas posições de vetorB com duas de vetorA e carrega em MM0
        movq  QWORD[vetorC + ECX * 8 - 8], MM0  ; Salva as posições adicionadas nas posições correspondentes de vetorC

        loop .loopSum   ; while (ECX--);

    mov EAX, vetorC ; Retorna o endereço de vetorC

    ; Restaurar Pilha de Execução
    mov ESP, EBP
    pop EBP
    ret 12
