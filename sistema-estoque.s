/*
    TRABALHO DE IMPLEMENTAÇÃO 1: programa de controle de estoque de supermercado
    DISCIPLINA: Programação para Interfaceamento de Hardware e Software
    PROFESSOR: Ronaldo Augusto de Lara Gonçalves
    ALUNOS: Murilo Luis Calvo Neves         - RA 129037
            Leandro Eugênio Farias Berton   - RA 129268
            Jõao Vitor Pereira de Bortoli   - RA 125910
*/

.section .data
    banner1:        .asciz  "\n   _____ _     _                             _        ______     _                         \n";
    banner2:        .asciz  "  / ____(_)   | |                           | |      |  ____|   | |                        \n";
    banner3:        .asciz  " | (___  _ ___| |_ ___ _ __ ___   __ _    __| | ___  | |__   ___| |_ ___   __ _ _   _  ___ \n";
    banner4:        .asciz  "  \\___ \\| / __| __/ _ \\ '_ ` _ \\ / _` |  / _` |/ _ \\ |  __| / __| __/ _ \\ / _` | | | |/ _ \\ \n";
    banner5:        .asciz  "  ____) | \\__ \\ ||  __/ | | | | | (_| | | (_| |  __/ | |____\\__ \\ || (_) | (_| | |_| |  __/\n";
    banner6:        .asciz  " |_____/|_|___/\\__\\___|_| |_| |_|\\__,_|  \\__,_|\\___| |______|___/\\__\\___/ \\__, |\\__,_|\\___|\n";
    banner7:        .asciz  "                                                                             | |           \n";
    banner8:        .asciz  "                                                                             |_|           \n";

    formatoSTR:     .asciz  "%s"
    formatoINT:     .asciz  "%d"
    formatoFLOAT:   .asciz  "%f"
    formatoCHAR:    .asciz  "%c"

.section .text
.globl main

main:
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
    
fim:
    pushl   $0
    call    exit