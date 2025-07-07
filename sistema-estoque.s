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
    txtSairMenu:        .asciz  "[8] - Sair\n"

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

    # strings da função gravar_no_disco
    nomeArquivo:        .asciz  "dados.dat"
    modoEscritaArq:     .asciz  "wb"
    modoLeituraArq:     .asciz  "rb"

    # strings da função remocao_produto_validade
    txtRemocaoValidade: .asciz  "\nRemovendo produtos fora de validade ...\n"
    txtItemRemovido:    .asciz  "\nItem:\t[%s] \tREMOVIDO"
    txtComparacaoData:  .asciz  "\nData validade: %d\tData atual: %d\n"

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
    .lcomm  indice_atual_lista, 4

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
    pushl   $txtSairMenu
    call    printf

    pushl   $op_menu
    pushl   $formatoINT
    call    scanf

    addl    $56, %esp       # desempilhando 14 pushl's

    _if_insercao:
        movl    $0, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_remocao         # se os valores forem diferentes, passa para a verificação da remoção
        # senão, chama a função de inserção do produto
        jmp     menu

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
            jmp     menu
        
        _if_remocao_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax
            jne     _if_op_invalida    # se a opção escolhida é inválida
            # chama função de remoção por data de validade
            jmp     menu
    
    _if_atualizacao:
        movl    $2, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta_nome   # se os valores forem diferentes, passa para a verificação se vai consultar produto por nome
        # chama função de atualização do protudo
        jmp     menu

    _if_consulta_nome:
        movl    $3, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta        # se os valores forem diferentes, passa para a escolha da consulta
        # chama função de consultar produto pelo nome
        jmp     menu
    
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
            jmp     menu
        
        _if_fin_venda:
            movl    $1, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_lucro   # se os valores forem diferentes, passa para a verificação se o usuário escolheu o total de lucro
            #  chama a função de consulta do total de vendas
            jmp     menu
        
        _if_fin_lucro:
            movl    $2, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_perdido   # se os valores forem diferentes, passa para a verificação se o usuário escolheu  o capital perdido
            # chama a função da consulta de lucro total
            jmp     menu
        
        _if_fin_perdido:
            movl    $3, %eax
            cmpl    op_menu, %eax            
            jne     _if_op_invalida   # se o valor digitado pelo usuário não corresponder a nenhuma consulta financeira
            # chama a função de consulta de capital perdido
            jmp     menu
    
    _if_gravacao_reg:
        movl    $5, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_carrega_reg     # se os valores forem diferentes, passa para o carregamento dos registro vindos do disco
        # chama função para gravar os registros no disco
        jmp     menu

    _if_carrega_reg:
        movl    $6, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_relatorio       # se os valores forem diferentes, passa para a escolha do relatório
        # chama função para carregar os registros do disco
        jmp     menu
    
    _if_relatorio:
        movl    $7, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_sair            # se os valores forem diferentes, passa para verificação se o usuário deseja sair do menu
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
            jmp     menu
        
        _if_rel_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax       
            jne     _if_rel_estoque         # se os valores forem diferentes, passa para verificação se o usuário optou pela ordenação pela quantidade de estoque
            # chama a função para mostrar o relatório ordenado pelas datas de validade
            jmp     menu
        
        _if_rel_estoque:
            movl    $2, %eax
            cmpl    op_menu, %eax       
            jne     _if_op_invalida         # se os valores forem diferentes, nenhuma opção válida foi escolhida
            # chama a função para mostrar o relatório ordenado pela quantidade de estoque

    _if_sair:
        movl    $8, %eax
        cmpl    op_menu, %eax
        jne     _if_op_invalida     # se os valores forem diferentes, passa para a mensagem de opção inválida
        RET                         # retornando para a função main

    _if_op_invalida:
        pushl   $txtOpcInvalida
        call    printf
        addl    $4, %esp
        jmp     menu

gravar_no_disco:
    # abrindo o arquivo com a função fopen
    pushl   $modoEscritaArq    # empilhando "wb"
    pushl   $nomeArquivo        # empilhando "dados.dat"
    call    fopen

    movl    %eax, arquivo_ptr   # salvando o ponteiro FILE* em arquivo_ptr

    # escrevendo o tamanho da lista no início do arquivo
    pushl   %eax                # empilhando o ponteiro FILE*
    pushl   $1                  # empilhando o numero de blocos a serem escritos
    pushl   $4                  # empilhando o tamanho de um inteiro (4 bytes)
    pushl   $tamanho_lista      # empilhando o endereço do tamanho da lista
    call    fwrite

    addl    $24, %esp           # desempilhando os 6 pushl's

    movl    inicio_lista, %eax
    movl    %eax, indice_atual_lista         

    movl    $0, %ecx            # inicializando o controle do loop
    _loop_gravar_no_disco:
        cmpl    %ecx, tamanho_lista         # tamanho_lista - ecx
        je      _fim_gravar_no_disco 

        movl    $0, %eax
        cmpl    indice_atual_lista, %eax    # verificando se não é NULL
        je      _fim_gravar_no_disco

        pushl   %ecx                        # apenas salvando ecx
        pushl   arquivo_ptr                 # empilhando o ponteiro FILE*
        pushl   $1                          # empilhando o numero de blocos a serem escritos
        pushl   $56                         # empilhando o tamanho de um registro sem o último campo do ponteiro prox (56 bytes)
        pushl   indice_atual_lista          # empilhando o endereço do começo do registro a ser escrito
        call    fwrite

        # atualizando o índice atual com o próximo elemento
        movl    indice_atual_lista, %eax    # endereço do registro atual
        addl    $56, %eax                   # offset para a posição do endereço do próximo registro
        movl    (%eax), indice_atual_lista  # move o conteúdo da posição do endereço do próximo registro (ou seja, o endereço do próximo registro) para indice_atual_lista
        
        addl    $16, %esp                   # desempilhando os pushl's de argumentos do fwrite
        popl    %ecx
        incl    %ecx
        jmp     _loop_gravar_no_disco

    _fim_gravar_no_disco:
        pushl   arquivo_ptr
        call    fclose
        addl    $4, %esp
        RET
    
ler_do_disco:
    #   Para não criar mais variáveis, tentei reutilizar o que já estava declarado:
    #   reg_atual_ptr -> no | deslocamento -> %eax | prox -> ponteiro_prox

    # abrindo o arquivo com a função fopen
    pushl   $modoLeituraArq    # empilhando "wb"
    pushl   $nomeArquivo        # empilhando "dados.dat"
    call    fopen

    movl    %eax, arquivo_ptr   # salvando o ponteiro FILE* em arquivo_ptr

    # lendo o tamanho da lista presente no arquivo
    pushl   %eax                # empilhando o ponteiro FILE*
    pushl   $1                  # empilhando o numero de blocos a serem escritos
    pushl   $4                  # empilhando o tamanho de um inteiro (4 bytes)
    pushl   $tamanho_lista      # empilhando o endereço do tamanho da lista
    call    fread

    addl    $24, %esp           # desempilhando os 6 pushl's da leitura inicial
    cmpl    $0, tamanho_lista   # verificando se a lista está vazia
    je      _fim_ler_do_disco

    pushl   $60                 # tamanho em bytes de um registro
    call    malloc
    movl    %eax, no            # salvando o ponteiro pro espaço alocado para o registro em no
    movl    %eax, inicio_lista  # salvando também o início da lista
    
    # lendo o primeiro registro presente no arquivo
    pushl   arquivo_ptr         # empilhando o ponteiro FILE*
    pushl   $1                  # empilhando o numero de blocos a serem escritos
    pushl   $56                 # empilhando o tamanho de um registro sem o campo do ponteiro próximo (56 bytes)
    pushl   $no                 # empilhando o endereço do nó que alocamos
    call    fread

    addl    $20, %esp           # desempilhando os últimos 5 pushl's

    movl    $1, %ecx
    _loop_ler_do_disco:
        cmpl    tamanho_lista, %ecx
        je      _fim_ler_do_disco

        pushl   %ecx                # apenas salvando o ecx

        pushl   $60                 # tamanho em bytes de um registro
        call    malloc
        movl    %eax, ponteiro_prox 

        pushl   arquivo_ptr         # empilhando o ponteiro FILE*
        pushl   $1                  # empilhando o numero de blocos a serem escritos
        pushl   $56                 # empilhando o tamanho de um registro sem o campo do ponteiro próximo (56 bytes)
        pushl   $ponteiro_prox      # empilhando o endereço do nó que alocamos
        call    fread

        addl    $20, %esp           # desempilhando os últimos 5 pushl's
        popl    %ecx                # recuperando o ecx
        incl    %ecx                # incrementando o contador
        
        # ligando os nós
        movl    no, %eax
        addl    $56, %eax
        movl    ponteiro_prox, (%eax)
        movl    ponteiro_prox, %ebx
        movl    %ebx, no

    _fim_ler_do_disco:
        # terminando a lista
        movl    no, %eax
        addl    $56, %eax
        movl    $0, (%eax)          # aterrando o último ponteiro para o próximo elemento

        pushl   arquivo_ptr
        call    fclose
        addl    $4, %esp

        RET

remocao_produto_validade:
    pushl   $txtRemocaoValidade
    call    printf
    addl    $4, %esp                # desempilhando a string inicial

    movl    $0, %eax
    movl    %eax, no_anterior       # no_anterior = NULL
    movl    inicio_lista, %eax
    movl    %eax, no                # nó atual aponta pro começo da lista

    _while_remocao_validade:
        movl    no, %eax
        cmpl    $0, %eax                # verifica se o no atual não é NULL
        je      _fim_remocao_validade

        # call carregar_dados_no          # carrega os dados do no atual para as variáveis de trabalho
        movl    data_validade, %eax
        cmpl    data_atual, %eax        # data_validade - data_atual
        jge     _if_sem_remocao

        movl    no_anterior, %eax
        cmpl    $0, %eax                # verificando se o nó anterior não é NULL
        jg      _remocao_nao_primeiro   # se o nó anterior for NULL, o no atual é o primeiro da lista, continua
        
        movl    ponteiro_prox, %eax
        movl    %eax, inicio_lista      # atualizando o início da lista com o segundo elemento
        jmp     _finaliza_remocao

        _remocao_nao_primeiro:
            movl    no, %eax
            addl    $56, %eax           # offset do ponteiro para o próximo registro
            movl    no_anterior, %ebx   
            addl    $56, %ebx           # offset de destino
            movl    (%eax), %ebx        # move-se o ponteiro para o próximo registro para o campo próx do registro anterior

        _finaliza_remocao:
            pushl   $nome_produto
            pushl   $txtItemRemovido
            call    printf

            pushl   data_atual
            pushl   data_validade
            pushl   $txtComparacaoData
            call    printf

            pushl   no                      # liberando a memória alocada para o nó
            call    fornecedor

            addl    $24, %esp               # desempilhando os últimos 6 pushl's
            
            movl    tamanho_lista, %eax 
            decl    %eax
            movl    %eax, tamanho_lista     # atualizando o tamanho da lista com o decremento

            jmp     _avanca_no_remocao

        _if_sem_remocao:
            movl    no, %eax
            movl    %eax, no_anterior       # atualizando apenas o nó anterior

        _avanca_no_remocao:
            movl    ponteiro_prox, %eax     # avançando na lista
            movl    %eax, no

            jmp     _while_remocao_validade

    _fim_remocao_validade:
        # espaço para eventualmente adicionar mais alguma informação
        RET    

fim:
    pushl   $0
    call    exit