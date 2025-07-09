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
    txtMostraData:      .asciz  "\nData atual: %d\n"
    txtConfirmaData:    .asciz  "\nConfirma a data [%d]? (s/n) "
    respostaChar:       .byte   's'

    # strings da função gravar_no_disco
    nomeArquivo:        .asciz  "dados.dat"
    modoEscritaArq:     .asciz  "wb"
    modoLeituraArq:     .asciz  "rb"
    txtGravacaoOK:      .asciz  "\n---> A gravacao no disco foi efetuada com sucesso!\n---> Numero de registros gravados: %d\n\n"
    txtLeituraOK:       .asciz  "\n---> A leitura do disco foi efetuada com sucesso!\n---> Numero de registros lidos: %d\n\n"

    # strings da função remocao_produto_validade
    txtRemocaoValidade: .asciz  "\nRemovendo produtos fora de validade ...\n"
    txtItemRemovido:    .asciz  "\nItem:\t[%s] \tREMOVIDO"
    txtComparacaoData:  .asciz  "\nData validade: %d\tData atual: %d\n"

    # strings da função pegar_dados_produto_input
    txtPedeNomeProduto: .asciz  "\nInsira:\nNome do produto:\n>> "
    txtPedeLoteProduto: .asciz  "\nLote:\n>> "
    txtPedeTipoProduto: .asciz  "\nTipo:\n0: Higiene\n1: Limpeza\n2: Perecíveis\n3: Não-Perecíveis\n4: Bebidas\n5: Padaria\n6: Açougue\n7: Congelados\n8: Utilidades\n9: Eletrodom.\n10: Petshop\n11: Infantis\n12: Hortifruti\n13: Papelaria\n14: Doces\n15: Outros\n>> "
    txtPedeValiProduto: .asciz  "\nData validade (YYYYMMDD):\n>> "
    txtPedeFornProduto: .asciz  "\nFornecedor:\n>> "
    txtPedeQtdProduto:  .asciz  "\nQuantidade no estoque:\n>> "
    txtPedeVComProduto: .asciz  "\nValor compra:\n>> "
    txtPedeVVenProduto: .asciz  "\nValor venda:\n>> "

    # strings da função insercao_produto
    txtNomeDuplicado:   .asciz  "\nNome duplicado! Produto não pode ser inserido"
    txtInsercaoSucesso: .asciz  "\nProduto inserido com sucesso!"

    # strings da função de consulta
    txtProdutoNaoEncon: .asciz  "\nProduto não encontrado"

    # strings da função de print_no
    txtPrintNulo:       .asciz  "\nNó nulo"
    txtPrintNo:         .asciz  "\nProduto:\t\t%s \nLote:\t\t\t%d \nData de validade:\t%d \nFornecedor:\t\t%s \nQuantidade no estoque:\t%d\nValor de compra:\t%d \nValor de venda:\t\t%d \nTipo:\t\t\t"
    txtPrintHigiene:    .asciz  "Higiene\n"  
    txtPrintLimpeza:    .asciz  "Limpeza\n"  
    txtPrintPereciveis: .asciz  "Perecíveis\n"  
    txtPrintNaoPereciv: .asciz  "Não-Perecíveis\n"  
    txtPrintBebidas:    .asciz  "Bebidas\n"  
    txtPrintPadaria:    .asciz  "Padaria\n"    
    txtPrintAcougue:    .asciz  "Açougue\n"    
    txtPrintCongelados: .asciz  "Congelados\n"    
    txtPrintUtilidades: .asciz  "Utilidades\n"    
    txtPrintEletrodom:  .asciz  "Eletrodom\n"    
    txtPrintPetshop:    .asciz  "Petshop\n"    
    txtPrintInfantis:   .asciz  "Infantis\n"    
    txtPrintHortifruti: .asciz  "Hortifruti\n"    
    txtPrintPapelaria:  .asciz  "Papelaria\n"    
    txtPrintDoces:      .asciz  "Doces\n"
    txtPrintOutros:     .asciz  "Outros\n"

    # strings da função de atualizacao_produto
    txtAtualizNomeProd: .asciz "\nInsira o nome do produto a ser alterado:\n>> "
    txtAtualizNovoEsto: .asciz "\nInsira o estoque novo:\n>> "
    txtAtualizNovoVVen: .asciz "\nInsira o valor de venda:\n>> "
    txtAtualizSucesso:  .asciz "\nProduto alterado com sucesso!"

    # strings da função de remocao_produto_nome
    txtRemocaoSucesso:  .asciz "\nProduto removido com sucesso!"
    txtRemocaoPedeNome: .asciz "\nInsira o nome do produto a ser removido:\n >> "


    # strings do relatorio ordenado por nome
    txtBannerOrdNome:   .asciz  "\n----------------------------\nProdutos ordenados por nome\n----------------------------"

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
    valor_compra:           .int    0
    valor_venda:            .int    0

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

    .lcomm  nome_novo_produto, 16

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
        call pegar_dados_produto_input
        call insercao_produto
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
            call remocao_produto_nome
            jmp     menu
        
        _if_remocao_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax
            jne     _if_op_invalida    # se a opção escolhida é inválida
            # chama função de remoção por data de validade
            call    remocao_produto_validade
            jmp     menu
    
    _if_atualizacao:
        movl    $2, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta_nome   # se os valores forem diferentes, passa para a verificação se vai consultar produto por nome
        # chama função de atualização do protudo
        call atualizacao_produto
        jmp     menu

    _if_consulta_nome:
        movl    $3, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_consulta        # se os valores forem diferentes, passa para a escolha da consulta
        # chama função de consultar produto pelo nome
        call consulta
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
        call    gravar_no_disco
        jmp     menu

    _if_carrega_reg:
        movl    $6, %eax
        cmpl    op_menu, %eax       # eax - op_menu
        jne     _if_relatorio       # se os valores forem diferentes, passa para a escolha do relatório
        # chama função para carregar os registros do disco
        call    ler_do_disco
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
            call    relatorio_ordenado_nome
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
        movl    (%eax), %ebx
        movl    %ebx, indice_atual_lista  # move o conteúdo da posição do endereço do próximo registro (ou seja, o endereço do próximo registro) para indice_atual_lista
        
        addl    $16, %esp                   # desempilhando os pushl's de argumentos do fwrite
        popl    %ecx
        incl    %ecx
        jmp     _loop_gravar_no_disco

    _fim_gravar_no_disco:
        pushl   arquivo_ptr
        call    fclose

        pushl   tamanho_lista
        pushl   $txtGravacaoOK
        call    printf

        addl    $12, %esp
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
    pushl   no                 # empilhando o endereço do nó que alocamos
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
        pushl   ponteiro_prox       # empilhando o endereço do nó que alocamos
        call    fread

        addl    $20, %esp           # desempilhando os últimos 5 pushl's
        popl    %ecx                # recuperando o ecx
        incl    %ecx                # incrementando o contador
        
        # ligando os nós
        movl    no, %eax
        addl    $56, %eax
        movl    ponteiro_prox, %edx
        movl    %edx, (%eax)
        movl    ponteiro_prox, %ebx
        movl    %ebx, no

    _fim_ler_do_disco:
        # terminando a lista
        movl    no, %eax
        addl    $56, %eax
        movl    $0, %ebx
        movl    %ebx, (%eax)          # aterrando o último ponteiro para o próximo elemento

        pushl   arquivo_ptr
        call    fclose

        pushl   tamanho_lista
        pushl   $txtLeituraOK
        call    printf
        addl    $12, %esp

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

        call carregar_dados_no          # carrega os dados do no atual para as variáveis de trabalho
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
            movl    (%eax), %ecx
            movl    %ecx, (%ebx)        # move-se o ponteiro para o próximo registro para o campo próx do registro anterior

        _finaliza_remocao:
            pushl   $nome_produto
            pushl   $txtItemRemovido
            call    printf

            pushl   data_atual
            pushl   data_validade
            pushl   $txtComparacaoData
            call    printf

            pushl   no                      # liberando a memória alocada para o nó
            call    _fim_remocao_validade

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

carregar_dados_no:
    pushl   $16
    pushl   no
    pushl   $nome_produto
    call    memcpy                  # copiando o nome do produto para a variável de trabalho nome_produto
    addl    $12, %esp

    movl    no, %eax
    addl    $16, %eax
    movl    (%eax), %ebx
    movl    %ebx, lote_produto      # copiando da memória o inteiro que representa o lote do produto

    addl    $4, %eax                # avançando no registro
    movl    (%eax), %ebx
    movl    %ebx, tipo_produto

    addl    $4, %eax
    movl    (%eax), %ebx
    movl    %ebx, data_validade

    addl    $4, %eax
    pushl   $16
    pushl   %eax
    pushl   $fornecedor
    call    memcpy                  # copiando a string do nome do fornecedor (usamos memcpy por se tratar de 16 bytes)

    addl    $12, %esp               # desempilhando os últimos pushl's

    movl    no, %eax
    addl    $44, %eax                   # offset da quantidade de estoque
    movl    (%eax), %ebx
    movl    %ebx, quantidade_estoque  

    addl    $4, %eax
    movl    (%eax), %ebx
    movl    %ebx, valor_compra

    addl    $4, %eax
    movl    (%eax), %ebx
    movl    %ebx, valor_venda

    addl    $4, %eax
    movl    (%eax), %ebx
    movl    %ebx, ponteiro_prox

    RET

pegar_dados_produto_input:
    # receber nome produto
    pushl $txtPedeNomeProduto
    call printf
    addl $4, %esp

    pushl $nome_produto
    pushl $formatoSTR
    call scanf
    addl $8, %esp

    # receber lote produto
    pushl $txtPedeLoteProduto
    call printf
    addl $4, %esp

    pushl $lote_produto
    pushl $formatoINT
    call scanf
    addl $8, %esp

    # receber tipo produto
    pushl $txtPedeTipoProduto
    call printf
    addl $4, %esp

    pushl $tipo_produto
    pushl $formatoINT
    call scanf
    addl $8, %esp

    # receber validade produto
    pushl $txtPedeValiProduto
    call printf
    addl $4, %esp

    pushl $data_validade
    pushl $formatoINT
    call scanf
    addl $8, %esp

    # receber fornecedor produto
    pushl $txtPedeFornProduto
    call printf
    addl $4, %esp

    pushl $fornecedor
    pushl $formatoSTR
    call scanf
    addl $8, %esp
    
    # receber quantidade produto
    pushl $txtPedeQtdProduto
    call printf
    addl $4, %esp

    pushl $quantidade_estoque
    pushl $formatoINT
    call scanf
    addl $8, %esp
    
    # receber valor de compra produto
    pushl $txtPedeVComProduto
    call printf
    addl $4, %esp

    pushl $valor_compra
    pushl $formatoINT
    call scanf
    addl $8, %esp

    # receber valor de venda produto
    pushl $txtPedeVVenProduto
    call printf
    addl $4, %esp

    pushl $valor_venda
    pushl $formatoINT
    call scanf
    addl $8, %esp

encontrar_produto_nome:
    movl $0, %eax
    movl %eax, no_anterior    # no_anterior = 0 (null)

    movl inicio_lista, %eax
    movl %eax, no             # no = inicio_lista

    _encontrar_produto_nome_inicio_laco:
        movl no, %eax
        cmpl $0, %eax
        je _encontrar_produto_nome_fim_laco

        call carregar_dados_no

        pushl $nome_aux
        pushl $nome_produto
        call strcmp
        addl $8, %esp       # %eax = strcmp(nome_produto, nome_aux)

        cmpl $0, %eax       # se resultado comparação == 0, saia do laço
        je _encontrar_produto_nome_fim_laco

        movl no, %eax
        movl %eax, no_anterior

        pushl $4
        movl $56, %eax
        addl no, %eax
        pushl %eax
        pushl $no
        call memcpy        # memcpy(&no, no + 56, 4)
        addl $12, %esp
        
        jmp _encontrar_produto_nome_inicio_laco

    _encontrar_produto_nome_fim_laco:
        RET

insercao_produto:
    pushl $60
    call malloc   # alocando novo nó
    movl %eax, novo_no   # novo_no = malloc(60 bytes)
    addl $4, %esp

    movl novo_no, %ebx   # ebx = novo_no + 0

    # copiando informações para o novo nó ...

    # memcpy(novo_no + 0, nome_produto, 16)
    pushl $16
    pushl $nome_produto
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $16, %ebx   # ebx = novo_no + 16

    # memcpy(novo_no + 16, &lote_produto, 4)
    pushl $4
    pushl $lote_produto
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ebx   # ebx = novo_no + 20
    
    # memcpy(novo_no + 20, &tipo_produto, 4)
    pushl $4
    pushl $tipo_produto
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ecx  # ebx = novo_no + 24

    # memcpy(novo_no + 24, &data_validade, 4)
    pushl $4
    pushl $data_validade
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ecx  # ebx = novo_no + 28

    # memcpy(novo_no + 28, fornecedor, 16)
    pushl $16
    pushl $fornecedor
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $16, %ebx  # ebx = novo_no + 44

    # memcpy(novo_no + 44, &quantidade_estoque, 4)
    pushl $4
    pushl $quantidade_estoque
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ebx  # ebx = novo_no + 48

    # memcpy(novo_no + 48, &valor_compra, 4)
    pushl $4
    pushl $valor_compra
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ebx  # ebx = novo_no + 52

    # memcpy(novo_no + 52, &valor_venda, 4)
    pushl $4
    pushl $valor_venda
    pushl %ebx
    call memcpy
    addl $12, %esp

    addl $4, %ebx  # ebx = novo_no + 56

    # memset(novo_no + 56, 0, 4)
    pushl $4
    pushl $0
    pushl %ebx
    call memset
    addl $12, %esp
    
    # strcpy(nome_novo_produto, nome_produto)
    pushl $nome_produto
    pushl $nome_novo_produto
    call strcpy
    addl $8, %esp

    # Iniciando busca pelo local de inserção na lista

    movl $0, %eax
    movl %eax, no_anterior # no anterior = 0

    movl inicio_lista, %eax
    movl %eax, no # no = inicio lista

    _insercao_produto_inicio_laco:
        movl no, %eax
        cmpl $0, %eax
        je _insercao_produto_fim_laco  # while (no != 0)

        call carregar_dados_no

        pushl nome_novo_produto
        pushl nome_produto
        call strcmp
        addl $8, %esp   # eax = strcmp(nome_produto, nome_novo_produto)

        movl %eax, resultado_comparacao

        cmpl $0, %eax
        je _insercao_produto_nome_duplicado
        jmp _insercao_produto_nome_nao_duplicado
        _insercao_produto_nome_duplicado:
            pushl $txtNomeDuplicado
            call printf
            pushl novo_no
            call free
            addl $8, %esp
            RET
        _insercao_produto_nome_nao_duplicado:
        movl resultado_comparacao, %eax
        cmpl $0, %eax
        jg _insercao_produto_achou_lugar
        jmp _insercao_produto_continua_laco

        _insercao_produto_achou_lugar:
            movl no_anterior, %eax
            cmpl $0, %eax
            je _insercao_produto_no_anterior_zero
            jne _insercao_produto_no_anterior_nao_zero

            _insercao_produto_no_anterior_zero:
                pushl $4
                pushl $inicio_lista
                movl %eax, novo_no
                addl $56, %eax
                pushl %eax
                call memcpy
                addl $12, %esp # memcpy(novo_no + 56, &inicio_lista, 4)

                movl novo_no, %eax
                movl %eax, inicio_lista # inicio_lista = novo_no

                jmp _insercao_produto_continuar_interno

            _insercao_produto_no_anterior_nao_zero:
                pushl $4
                pushl $no
                movl novo_no, %eax
                addl $56, %eax
                pushl %eax
                call memcpy
                addl $12, %esp # memcpy(novo_no + 56, &no, 4)
                
                pushl $4
                pushl $novo_no
                movl no_anterior, %eax
                addl $56, %eax
                call memcpy
                addl $12, %esp # memcpy(no_anterior + 56, &novo_no, 4)

                jmp _insercao_produto_continuar_interno

            _insercao_produto_continuar_interno:     

            movl tamanho_lista, %eax
            incl %eax
            movl %eax, tamanho_lista

            pushl $txtInsercaoSucesso
            call printf
            addl $4, %esp
            RET

        _insercao_produto_continua_laco:
        movl no, %eax
        movl %eax, no_anterior # no_anterior - no

        pushl $4
        addl $56, %eax
        pushl %eax
        pushl $no
        call memcpy
        addl $12, %esp # memcpy(&no, no + 56, 4)

        jmp _insercao_produto_inicio_laco

    _insercao_produto_fim_laco:

    movl no_anterior, %eax
    cmpl $0, %eax
    jne _insercao_produto_fim

    # lista vazia

    movl novo_no, %eax
    movl %eax, inicio_lista  # inicio_lista = novo_no

    movl tamanho_lista, %eax
    incl %eax
    movl %eax, tamanho_lista # tamanho_lista ++

    RET

    _insercao_produto_fim:

    pushl $4
    pushl $novo_no
    movl no_anterior, %eax
    addl $56, %eax
    pushl %eax
    call memcpy
    addl $12, %esp  # memcpy(no_anterior + 56, &novo_no, 4)

    RET

consulta:
    pushl $txtPedeNomeProduto
    call printf
    addl $4, %esp

    pushl $nome_aux
    pushl $formatoSTR
    call scanf
    addl $8, %esp
    
    call encontrar_produto_nome
    
    movl no, %eax
    cmpl $0, %eax
    je _consulta_no_nulo
    jne _consulta_no_nao_nulo

    _consulta_no_nulo:
        pushl $txtProdutoNaoEncon
        call printf
        addl $4, %esp
        RET

    _consulta_no_nao_nulo:
        call print_no

print_no:
    movl no, %eax
    cmpl $0, %eax
    jne _print_nao_nulo

    pushl $txtPrintNulo
    call printf
    addl $4, %esp
    RET

    _print_nao_nulo:
    
    call carregar_dados_no
    
    pushl valor_venda
    pushl valor_compra
    pushl quantidade_estoque
    pushl $fornecedor
    pushl data_validade
    pushl lote_produto
    pushl $nome_produto
    pushl $txtPrintNo
    call printf
    addl $32, %esp

    movl tipo_produto, %eax

    cmpl $0, %eax
    je _caso_0
    cmpl $1, %eax
    je _caso_1
    cmpl $2, %eax
    je _caso_2
    cmpl $3, %eax
    je _caso_3
    cmpl $4, %eax
    je _caso_4
    cmpl $5, %eax
    je _caso_5
    cmpl $6, %eax
    je _caso_6
    cmpl $7, %eax
    je _caso_7
    cmpl $8, %eax
    je _caso_8
    cmpl $9, %eax
    je _caso_9
    cmpl $10, %eax
    je _caso_10
    cmpl $11, %eax
    je _caso_11
    cmpl $12, %eax
    je _caso_12
    cmpl $13, %eax
    je _caso_13
    cmpl $14, %eax
    je _caso_14
    cmpl $15, %eax
    je _caso_15
    
    _caso_0:
        pushl $txtPrintHigiene
        jmp _print_final
    
    _caso_1:
        pushl $txtPrintLimpeza
        jmp _print_final

    _caso_2:
        pushl $txtPrintPereciveis
        jmp _print_final

    _caso_3:
        pushl $txtPrintNaoPereciv
        jmp _print_final

    _caso_4:
        pushl $txtPrintBebidas
        jmp _print_final

    _caso_5:
        pushl $txtPrintPadaria
        jmp _print_final

    _caso_6:
        pushl $txtPrintAcougue
        jmp _print_final

    _caso_7:
        pushl $txtPrintCongelados
        jmp _print_final

    _caso_8:
        pushl $txtPrintUtilidades
        jmp _print_final

    _caso_9:
        pushl $txtPrintEletrodom
        jmp _print_final

    _caso_10:
        pushl $txtPrintPetshop
        jmp _print_final
    
    _caso_11:
        pushl $txtPrintInfantis
        jmp _print_final

    _caso_12:
        pushl $txtPrintHortifruti
        jmp _print_final

    _caso_13:
        pushl $txtPrintPapelaria
        jmp _print_final

    _caso_14:
        pushl $txtPrintDoces
        jmp _print_final

    _caso_15:
        pushl $txtPrintOutros
        jmp _print_final

    _print_final:
        call printf
        addl $4, %esp
    
    RET

relatorio_ordenado_nome:
    movl inicio_lista, %eax
    movl %eax, no

    pushl $txtBannerOrdNome
    call printf
    addl $4, %esp

    _relatorio_ord_nome_inicio_laco:
        movl no, %eax
        cmpl $0, %eax
        je _relatorio_ord_nome_fim_laco # while (no != 0)

        call print_no

        pushl $4
        movl no, %eax
        addl $56, %eax
        pushl %eax
        pushl $no  # memcpy(&no, no + 56, 4)
        call memcpy
        addl $12, %esp

        jmp _relatorio_ord_nome_inicio_laco
    _relatorio_ord_nome_fim_laco:
        RET

atualizacao_produto:
    pushl txtAtualizNomeProd
    call printf
    addl $4, %esp
    
    pushl $nome_aux
    pushl $formatoSTR
    call scanf
    addl $8, %esp

    call encontrar_produto_nome

    # se no == 0, sai

    movl no, %eax
    cmpl $0, %eax
    jne _atualizao_no_nao_nulo

    pushl $txtProdutoNaoEncon
    call printf
    addl $4, %esp

    RET

    _atualizao_no_nao_nulo:
    
    pushl txtAtualizNovoEsto
    call printf
    addl $4, %esp
    
    pushl $quantidade_estoque   # pede novo estoque
    pushl $formatoINT
    call scanf
    addl $8, %esp

    pushl txtAtualizNovoVVen
    call printf
    addl $4, %esp
    
    pushl $valor_venda   # pede novo valor de venda
    pushl $formatoINT
    call scanf
    addl $8, %esp
    
    pushl $4
    pushl $quantidade_estoque
    movl no, %eax
    addl $44, %eax
    pushl %eax  # memcpy(no + 44, &quantidade_estoque, 4), copia novo estoque
    addl $12, %esp

    pushl $4
    pushl $valor_venda
    movl no, %eax
    addl $52, %eax
    pushl %eax  # memcpy(no + 52, &valor_venda, 4), copia novo estoque
    addl $12, %esp

    pushl $txtAtualizSucesso
    call printf
    addl $4, %esp

    RET

remocao_produto_nome:
    pushl $txtRemocaoPedeNome
    call printf
    addl $4, %esp

    pushl $nome_aux   # pega nome do produto a ser removido
    pushl $formatoSTR 
    call scanf
    addl $8, %esp

    call encontrar_produto_nome

    # se no == 0, sai

    movl no, %eax
    cmpl $0, %eax
    jne _remocao_no_nao_nulo

    pushl $txtProdutoNaoEncon
    call printf
    addl $4, %esp

    RET

    _remocao_no_nao_nulo:

    # se no_anterior == 0, é o primeiro elemento, senão é o N-Ésimo

    pushl $4
    movl no, %ebx
    addl $56, %ebx  # ebx = no + 56, posicao do ponteiro
    pushl %ebx

    movl no_anterior, %eax
    cmpl $0, %eax
    je _remocao_primeiro_elemento
    jmp _remocao_nesimo_elemento

    
    _remocao_primeiro_elemento:
        pushl $inicio_lista # memcpy(&inicio_lista, no + 56, 4)
        jmp _remocao_finalizar

    _remocao_nesimo_elemento:
        pushl no_anterior # memcpy(no_anterior + 56, no + 56, 4)
        jmp _remocao_finalizar

    _remocao_finalizar:
        call memcpy
        addl $12, %esp

        pushl no
        call free
        addl $4, %esp
        
        movl tamanho_lista, %eax
        decl %eax
        movl %eax, tamanho_lista # tamanho_lista -= 1
        
        pushl $txtRemocaoSucesso
        call printf
        addl $4, %esp

        RET


fim:
    pushl   $0
    call    exit