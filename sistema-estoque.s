/*
    TRABALHO DE IMPLEMENTAÇÃO 1: programa de controle de estoque de supermercado
    DISCIPLINA: Programação para Interfaceamento de Hardware e Software
    PROFESSOR: Ronaldo Augusto de Lara Gonçalves
    ALUNOS: Murilo Luis Calvo Neves         - RA 129037
            Leandro Eugênio Farias Berton   - RA 129268
            Jõao Vitor Pereira de Bortoli   - RA 125910
*/

.section .data
    # strings do banner de apresentação do sistema
    banner1:        .asciz  "\n   _____ _     _                             _        ______     _                         \n";
    banner2:        .asciz  "  / ____(_)   | |                           | |      |  ____|   | |                        \n";
    banner3:        .asciz  " | (___  _ ___| |_ ___ _ __ ___   __ _    __| | ___  | |__   ___| |_ ___   __ _ _   _  ___ \n";
    banner4:        .asciz  "  \\___ \\| / __| __/ _ \\ '_ ` _ \\ / _` |  / _` |/ _ \\ |  __| / __| __/ _ \\ / _` | | | |/ _ \\ \n";
    banner5:        .asciz  "  ____) | \\__ \\ ||  __/ | | | | | (_| | | (_| |  __/ | |____\\__ \\ || (_) | (_| | |_| |  __/\n";
    banner6:        .asciz  " |_____/|_|___/\\__\\___|_| |_| |_|\\__,_|  \\__,_|\\___| |______|___/\\__\\___/ \\__, |\\__,_|\\___|\n";
    banner7:        .asciz  "                                                                             | |           \n";
    banner8:        .asciz  "                                                                             |_|           \n";

    # strings de formatação
    formatoSTR:     .asciz  "%s"
    formatoINT:     .asciz  "%d"
    formatoFLOAT:   .asciz  "%f"
    formatoCHAR:    .asciz  "%c"
    limpaTerminal:  .asciz  "clear"

    # variáveis de trabalho
    data_atual:             .int    0
    tamanho_lista:          .int    0
    lote_produto:           .int    0
    tipo_produto:           .int    0
    data_validade:          .int    0
    quantidade_estoque:     .int    0
    op_menu:                .int    0
    resultado_comparacao:   .int    0
    valor_compra:           .float  0.0
    valor_venda:            .float  0.0

.section .bss
    .lcomm  nome_produto,   16  # 16 caracteres
    .lcomm  fornecedor,     16
    .lcomm  nome_aux,       16
    .lcomm  ponteiro_prox,  4
    .lcomm  no,             4
    .lcomm  no_anterior,    4
    .lcomm  novo_no,        4
    .lcomm  inicio_lista,   4
    .lcomm  arquivo_ptr,    4

.section .text
.globl main

main:
    pushl   $limpaTerminal      # limpando o terminal para a execução do programa
    call    system          

    call mostra_banner

    jmp fim

mostra_banner:
    pushl   $banner1
    call    printf
    pushl   $banner2
    call    printf
    pushl   $banner3
    call    printf
    pushl   $banner4
    call    printf
    pushl   $banner5
    call    printf
    pushl   $banner6
    call    printf
    pushl   $banner7
    call    printf
    pushl   $banner8
    call    printf

    addl    $32, %esp           # desempilhando os endereços das 8 strings do banner
    RET
    
fim:
    pushl   $0
    call    exit