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

    # strings do menu
    txtDataAtual:       .asciz  "\n--> Data atual: %d"
    txtFuncionalidades: .asciz  "\n\nSelecione uma das funcionalidades abaixo: \n"
    txtFunc0:           .asciz  "[0] - Insercao de produto\n"
    txtFunc1:           .asciz  "[1] - Remocao de produto\n"
    txtFunc2:           .asciz  "[2] - Atualizacao de produto\n"
    txtFunc3:           .asciz  "[3] - Consulta de produto por nome\n"
    txtFunc4:           .asciz  "[4] - Consulta financeira\n"
    txtFunc5:           .asciz  "[5] - Gravacao de registros\n"
    txtFunc6:           .asciz  "[6] - Carregamento de registros\n"
    txtFunc7:           .asciz  "[7] - Relatorio de registros\n"

    txtOpcRemocao:      .asciz  "\nDeseja remover por das opcoes abaixo? \n"
    txtRemNome:         .asciz  "[0] - Nome\n"
    txtRemValidade:     .asciz  "[1] - Data de validade\n"

    txtOpcFinanceira:   .asciz  "\nDeseja consultar qual das opcoes abaixo?\n"
    txtFinCompra:       .asciz  "[0] - Total de compra\n"
    txtFinVenda:        .asciz  "[1] - Total de venda\n"
    txtFinLucro:        .asciz  "[2] - Lucro total\n"
    txtFinPerda:        .asciz  "[3] - Capital perdido\n"

    txtOpcRelatorio:    .asciz  "\nDeseja a ordenaco por qual das opcoes abaixo?\n"
    txtRelNome:         .asciz  "[0] - Nome\n"
    txtRelValidade:     .asciz  "[1] - Data de validade\n"
    txtRelEstoque:      .asciz  "[2] - Quantidade de estoque\n"

    txtOpcInvalida:     .asciz  "\n****** Opcao invalida! ******\n\n"

    # strings da função que recebe o ano 
    txtDigiteData:      .asciz  "\nDigite a data atual no formato yyyymmdd (Ex.: 20250612): "
    txtMostraData:      .asciz  "Data atual: %d\n"
    txtConfirmaData:    .asciz  "\nConfirma a data [%d]? (s/n) "
    respostaChar:       .byte   's'

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

    .lcomm  lixo,           4

.section .text
.globl main

main:
    pushl   $limpaTerminal      # limpando o terminal para a execução do programa
    call    system          

    call    mostra_banner

    call    recebe_ano

    call    menu

    jmp     fim

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

recebe_ano:
    pushl   $txtDigiteData
    call    printf
    
    pushl   $data_atual
    pushl   $formatoINT
    call    scanf

    pushl   data_atual
    pushl   $txtDataAtual
    call    printf

    pushl   $lixo               # ignorando o \n que resta no buffer
    call    getchar

    pushl   data_atual
    pushl   $txtConfirmaData
    call    printf

    pushl   $respostaChar
    pushl   $formatoCHAR
    call    scanf

    addl    $40, %esp           # desempilhando 10 pushs

    movb    $115, %al           # 115 é o valor de s em ascii
    cmpb    respostaChar, %al   # compara o caractere lido com o valor 115
    jne     recebe_ano          # se a resposta não for 's', deve-se perguntar novamente ao usuário

    RET

menu:
    pushl   data_atual
    pushl   $txtMostraData
    call    printf

    pushl   $txtFuncionalidades
    call    printf
    pushl   $txtFunc0
    call    printf
    pushl   $txtFunc1
    call    printf
    pushl   $txtFunc2
    call    printf
    pushl   $txtFunc3
    call    printf
    pushl   $txtFunc4
    call    printf
    pushl   $txtFunc5
    call    printf
    pushl   $txtFunc6
    call    printf
    pushl   $txtFunc7
    call    printf

    pushl   $op_menu
    pushl   $formatoINT
    call    scanf

    addl    $52, %esp       # desempilhando 13 pushl's

    _if_insercao:
        movl    $0, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_remocao         # se os valores forem diferentes, passa para a verificação da remoção
        # senão, chama a função de inserção do produto
        RET

    _if_remocao:
        movl    $1, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_atualizacao     # se os valores forem diferentes, passa para a verificação da atualização
        # continua com a remocao
        pushl   $txtOpcRemocao      # apresentando as opções de remoção
        call    printf
        pushl   $txtRemNome
        call    printf
        pushl   $txtRemValidade
        call    printf

        pushl   $op_menu
        pushl   $formatoINT
        call    scanf

        addl    $20, %esp           # desempilhando 5 pushl's

        _if_remocao_nome:
            movl    $0, %eax
            cmpl    op_menu, %eax
            jne     _if_remocao_validade    # verifica se a remoção por nome foi escolhida
            # chama função de remoção pelo nome
            RET
        
        _if_remocao_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax
            jne     _if_op_invalida    # se a opção escolhida é inválida
            # chama função de remoção por data de validade
            RET
    
    _if_atualizacao:
        movl    $2, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta_nome   # se os valores forem diferentes, passa para a verificação se vai consultar produto por nome
        # chama função de atualização do protudo
        RET

    _if_consulta_nome:
        movl    $3, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta        # se os valores forem diferentes, passa para a escolha da consulta
        # chama função de consultar produto pelo nome
        RET
    
    _if_consulta:
        movl    $4, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_gravacao_reg    # se os valores forem diferentes, passa para a gravação dos registros no disco
        # conntinua com a escolha da consulta

        pushl   $txtOpcFinanceira   # mostrando as opções de consulta financeira oferecidas pelo sistema
        call    printf
        pushl   $txtFinCompra
        call    printf
        pushl   $txtFinVenda
        call    printf
        pushl   $txtFinLucro
        call    printf
        pushl   $txtFinPerda
        call    printf

        pushl   $op_menu            # pegando do usuário a opção escolhida 
        pushl   $formatoINT
        call    scanf

        addl    $28, %esp           # desempilhando 7 pushl's
        
        _if_fin_compra:
            movl    $0, %eax
            cmpl    op_menu, %eax
            jne     _if_fin_venda   # se os valores forem diferentes, passa para a verificação se o usuário escolheu o total de venda
            # chama a função de consulta do total de compras
            RET
        
        _if_fin_venda:
            movl    $1, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_lucro   # se os valores forem diferentes, passa para a verificação se o usuário escolheu o total de lucro
            #  chama a função de consulta do total de vendas
            RET
        
        _if_fin_lucro:
            movl    $2, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_perdido   # se os valores forem diferentes, passa para a verificação se o usuário escolheu  o capital perdido
            # chama a função da consulta de lucro total
            RET
        
        _if_fin_perdido:
            movl    $3, %eax
            cmpl    op_menu, %eax            
            jne     _if_op_invalida   # se o valor digitado pelo usuário não corresponder a nenhuma consulta financeira
            # chama a função de consulta de capital perdido
            RET
    
    _if_gravacao_reg:
        movl    $5, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_carrega_reg     # se os valores forem diferentes, passa para o carregamento dos registro vindos do disco
        # chama função para gravar os registros no disco
        RET

    _if_carrega_reg:
        movl    $6, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_relatorio       # se os valores forem diferentes, passa para a escolha do relatório
        # chama função para carregar os registros do disco
        RET
    
    _if_relatorio:
        movl    $7, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_op_invalida     # se os valores forem diferentes, passa para a mensagem de opção inválida
        # continua com a escolha do relatório

        pushl   $txtOpcRelatorio    # mostrando as opções de ordenação de relatório
        call    printf
        pushl   $txtRelNome
        call    printf
        pushl   $txtRelValidade
        call    printf
        pushl   $txtRelEstoque
        call    printf

        pushl   $op_menu            # pegando do usuário a opção de ordenação do relatório
        pushl   $formatoINT
        call    scanf

        addl    $24, %esp           # desempilhando 6 pushl's

        _if_rel_nome:
            movl    $0, %eax
            cmpl    op_menu, %eax       
            jne     _if_rel_validade        # se os valores forem diferentes, passa para verificação se o usuário optou pela ordenação por data de validade
            # chama a função para mostrar o relatório ordenado pelos nomes
            RET
        
        _if_rel_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax       
            jne     _if_rel_estoque         # se os valores forem diferentes, passa para verificação se o usuário optou pela ordenação pela quantidade de estoque
            # chama a função para mostrar o relatório ordenado pelas datas de validade
            RET
        
        _if_rel_estoque:
            movl    $2, %eax
            cmpl    op_menu, %eax       
            jne     _if_op_invalida         # se os valores forem diferentes, nenhuma opção válida foi escolhida
            # chama a função para mostrar o relatório ordenado pela quantidade de estoque

    _if_op_invalida:
        pushl   $txtOpcInvalida
        call    printf
        addl    $4, %esp
        jmp     menu

fim:
    pushl   $0
    call    exit