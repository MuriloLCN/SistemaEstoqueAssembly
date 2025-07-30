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
    txtPrintNo:         .asciz  "\nProduto:\t\t%s \nLote:\t\t\t%d \nData de validade:\t%d \nFornecedor:\t\t%s \nQuantidade no estoque:\t%d\nValor de compra:\t%.2f \nValor de venda:\t\t%.2f \nTipo:\t\t\t"
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
    
    # strings da consulta financeira
    txtFinNenhumProd:   .asciz  "\nNenhum produto no estoque para calcular.\n"
    txtFinBanner:       .asciz  "\n--- Resultado da Consulta Financeira ---\n"
    txtFinResCompra:    .asciz  "Total de Compra (custo do estoque): R$ %.2f\n"
    txtFinResVenda:     .asciz  "Total de Venda (potencial de receita): R$ %.2f\n"
    txtFinResLucro:     .asciz  "Lucro Total (potencial): R$ %.2f\n"
    txtFinResPerda:     .asciz  "Capital Perdido (produtos vencidos): R$ %.2f\n"

    # strings dos relatorios
    txtNenhumProdRel:   .asciz  "\nNenhum produto no estoque para exibir.\n"
    txtMaxItensExcedido:.asciz  "\nO numero de itens excede o maximo para ordenacao (%d).\n"
    txtBannerOrdValidade: .asciz "\n-------------------------------------\nProdutos ordenados por data de validade\n-------------------------------------\n"
    txtBannerOrdEstoque: .asciz "\n----------------------------------------\nProdutos ordenados por quantidade em estoque\n----------------------------------------\n"


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
    valor_compra:           .float    0
    valor_venda:            .float    0
    max_itens:              .int    256
    op_ordenacao:           .int    0

.section .bss
    .lcomm  nome_produto,   16  # 16 caracteres
    .lcomm  fornecedor,     16
    .lcomm  nome_aux,       16
    .lcomm  ponteiro_prox,  4
    .lcomm  no,             4
    .lcomm  no_anterior,    4
    .lcomm  novo_no,        4
    .lcomm  inicio_lista,   4
    .lcomm  descritor_arquivo,    4
    .lcomm  indice_atual_lista, 4

    .lcomm  nome_novo_produto, 16
    .lcomm  lote_novo_produto, 4

    .lcomm  lixo,           4

    # variaveis da consulta financeira
    .lcomm  total_compra,   4
    .lcomm  total_venda,    4
    .lcomm  capital_perdido,4

    # variaveis para ordenacao
    .lcomm  nos_para_ordenar, 1024  # MAX_ITENS (256) * 4 bytes
    .lcomm  i_loop,         4
    .lcomm  j_loop,         4
    .lcomm  temp_no,        4
    .lcomm  valor_1,        4
    .lcomm  valor_2,        4


.section .text
.globl main

main:
    pushl   $limpaTerminal      # limpando o terminal para a execução do programa
    call    system          

    finit

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
            call consulta_financeira
            jmp     menu
        
        _if_fin_venda:
            movl    $1, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_lucro   # se os valores forem diferentes, passa para a verificação se o usuário escolheu o total de lucro
            #  chama a função de consulta do total de vendas
            call consulta_financeira
            jmp     menu
        
        _if_fin_lucro:
            movl    $2, %eax
            cmpl    op_menu, %eax            
            jne     _if_fin_perdido   # se os valores forem diferentes, passa para a verificação se o usuário escolheu  o capital perdido
            # chama a função da consulta de lucro total
            call consulta_financeira
            jmp     menu
        
        _if_fin_perdido:
            movl    $3, %eax
            cmpl    op_menu, %eax            
            jne     _if_op_invalida   # se o valor digitado pelo usuário não corresponder a nenhuma consulta financeira
            # chama a função de consulta de capital perdido
            call consulta_financeira
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
            call    relatorio_ordenado_nome
            jmp     menu
        
        _if_rel_validade:
            movl    $1, %eax
            cmpl    op_menu, %eax       
            jne     _if_rel_estoque         # se os valores forem diferentes, passa para verificação se o usuário optou pela ordenação pela quantidade de estoque
            # chama a função para mostrar o relatório ordenado pelas datas de validade
            movl $0, op_ordenacao
            call relatorio_ordenado_criterio
            jmp     menu
        
        _if_rel_estoque:
            movl    $2, %eax
            cmpl    op_menu, %eax       
            jne     _if_op_invalida         # se os valores forem diferentes, nenhuma opção válida foi escolhida
            # chama a função para mostrar o relatório ordenado pela quantidade de estoque
            movl $1, op_ordenacao
            call relatorio_ordenado_criterio
            jmp     menu

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
    # abrindo o arquivo com a syscall open
	movl 	$8, %eax 	        # opção da chamada open
	movl 	$nomeArquivo, %ebx  # nome do arquivo a ser aberto, "dados.dat"
	movl 	$1, %ecx            # opção somente de escrita
	orl 	$40, %ecx           # opção para criar o arquivo, se não existe
	movl 	$100, %edx          # concedendo a permissão de leitura para o usuário
	orl 	$80, %edx           # concedendo a permissão de escrita para o usuário
	int 	$0x80

    movl    %eax, descritor_arquivo   # salvando o ponteiro FILE* em descritor_arquivo

    # escrevendo o tamanho da lista no início do arquivo
    movl    $4, %eax                # opção da chamada write
    movl    descritor_arquivo, %ebx       # destino (arquivo dados.dat)
    movl    $tamanho_lista, %ecx    # tamanho da lista a ser escrito 
    movl    $4, %edx                # tamamho de um inteiro (4 bytes)
    int     $0x80

    movl    inicio_lista, %eax
    movl    %eax, indice_atual_lista         

    movl    $0, %ecx            # inicializando o controle do loop
    _loop_gravar_no_disco:
        movl    tamanho_lista, %edx
        incl    %edx

        cmpl    %ecx, %edx         # tamanho_lista - ecx + 1
        je      _fim_gravar_no_disco 

        movl    $0, %eax
        cmpl    indice_atual_lista, %eax    # verificando se não é NULL
        je      _fim_gravar_no_disco

        pushl   %ecx                        # apenas salvando ecx

        movl    $4, %eax                    # opção da chamada write
        movl    descritor_arquivo, %ebx     # destino (arquivo dados.dat)
        movl    indice_atual_lista, %ecx    # registro a ser escrito 
        movl    $56, %edx                   # tamamho de um registro sem o ponteiro final (56 bytes)
        int     $0x80

        # atualizando o índice atual com o próximo elemento
        movl    indice_atual_lista, %eax    # endereço do registro atual
        addl    $56, %eax                   # offset para a posição do endereço do próximo registro
        movl    (%eax), %ebx
        movl    %ebx, indice_atual_lista  # move o conteúdo da posição do endereço do próximo registro (ou seja, o endereço do próximo registro) para indice_atual_lista
        
        # addl    $16, %esp                   # desempilhando os pushl's de argumentos do fwrite
        popl    %ecx
        incl    %ecx
        jmp     _loop_gravar_no_disco

    _fim_gravar_no_disco:
        movl    $6, %eax                      # opção de chamada close
        movl    descritor_arquivo, %ebx       # arquivo que se deseja fechar
        int     $0x80

        pushl   tamanho_lista
        pushl   $txtGravacaoOK
        call    printf

        addl    $8, %esp
        RET
    
ler_do_disco:
    #   Para não criar mais variáveis, tentei reutilizar o que já estava declarado:
    #   reg_atual_ptr -> no | deslocamento -> %eax | prox -> ponteiro_prox

    # abrindo o arquivo com a syscall open
    movl    $5, %eax                # numero da chamada de sistema para abertura do arquivo, definida em /usr/include/asm/unistd_32.h
    movl    $nomeArquivo, %ebx      # nome do arquivo a ser lido "dados.dat"
    movl    $0, %ecx                # opção de somente leitura
    int     $0x80

    movl    %eax, descritor_arquivo   # salvando o ponteiro FILE* em descritor_arquivo

    # lendo o tamanho da lista presente no arquivo
    movl    $3, %eax                # read
    movl    descritor_arquivo, %ebx       # descritor do arquivo
    movl    $tamanho_lista, %ecx    # destino 
    movl    $4, %edx                # tamanho a ser lido
    int     $0x80
    
    cmpl    $0, tamanho_lista   # verificando se a lista está vazia
    je      _fim_ler_do_disco

    pushl   $60                 # tamanho em bytes de um registro
    call    malloc
    movl    %eax, no            # salvando o ponteiro pro espaço alocado para o registro em no
    movl    %eax, inicio_lista  # salvando também o início da lista
    addl    $4, %esp
   
    # lendo o primeiro registro presente no arquivo
    movl    $3, %eax                # read
    movl    descritor_arquivo, %ebx       # descritor do arquivo
    movl    no, %ecx    # destino 
    movl    $56, %edx                # tamanho a ser lido
    int     $0x80

    movl    $1, %ecx
    _loop_ler_do_disco:
        cmpl    tamanho_lista, %ecx
        je      _fim_ler_do_disco

        pushl   %ecx                # apenas salvando o ecx

        pushl   $60                 # tamanho em bytes de um registro
        call    malloc
        movl    %eax, ponteiro_prox 
        addl    $4, %esp

        movl    $3, %eax                    # read
        movl    descritor_arquivo, %ebx     # descritor do arquivo
        movl    ponteiro_prox, %ecx         # destino 
        movl    $56, %edx                   # tamanho a ser lido
        int     $0x80        

        popl    %ecx                # recuperando o ecx
        incl    %ecx                # incrementando o contador
        
        # ligando os nós
        movl    no, %eax
        addl    $56, %eax
        movl    ponteiro_prox, %edx
        movl    %edx, (%eax)
        movl    ponteiro_prox, %ebx
        movl    %ebx, no

        jmp _loop_ler_do_disco

    _fim_ler_do_disco:
        # terminando a lista
        movl    no, %eax
        addl    $56, %eax
        movl    $0, %ebx
        movl    %ebx, (%eax)          # aterrando o último ponteiro para o próximo elemento

        movl    $6, %eax                # opção de chamada close
        movl    descritor_arquivo, %ebx       # arquivo que se deseja fechar
        int     $0x80

        pushl   tamanho_lista
        pushl   $txtLeituraOK
        call    printf
        addl    $8, %esp

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

copiar_string:
    # assumindo que a origem está no %eax e o destino no %ebx
    movl    (%eax), %ecx
    movl    %ecx, (%ebx)

    addl    $4, %eax
    addl    $4, %ebx
    movl    (%eax), %ecx
    movl    %ecx, (%ebx)

    addl    $4, %eax
    addl    $4, %ebx
    movl    (%eax), %ecx
    movl    %ecx, (%ebx)

    addl    $4, %eax
    addl    $4, %ebx
    movl    (%eax), %ecx
    movl    %ecx, (%ebx)

    RET

carregar_dados_no:
    movl    no, %eax
    movl    $nome_produto, %ebx
    call    copiar_string

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
    movl    $fornecedor, %ebx
    call    copiar_string

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
    pushl $formatoFLOAT
    call scanf
    addl $8, %esp

    # receber valor de venda produto
    pushl $txtPedeVVenProduto
    call printf
    addl $4, %esp

    pushl $valor_venda
    pushl $formatoFLOAT
    call scanf
    addl $8, %esp

    RET

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

        movl $56, %eax
        addl no, %eax
        movl    (%eax), %ecx
        movl    %ecx, no

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

    movl    $nome_produto, %eax
    call    copiar_string

    addl $4, %ebx   # ebx = novo_no + 16

    movl    lote_produto, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx   # ebx = novo_no + 20
    
    movl tipo_produto, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx  # ebx = novo_no + 24

    movl    data_validade, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx  # ebx = novo_no + 28

    movl    $fornecedor, %eax
    call    copiar_string

    addl $4, %ebx  # ebx = novo_no + 44

    movl    quantidade_estoque, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx  # ebx = novo_no + 48

    movl    valor_compra, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx  # ebx = novo_no + 52

    movl    valor_venda, %ecx
    movl    %ecx, (%ebx)

    addl $4, %ebx  # ebx = novo_no + 56

    # memset(novo_no + 56, 0, 4)
    # pushl $4
    # pushl $0
    # pushl %ebx
    # call memset
    # addl $12, %esp

    movl    $0, %ecx
    movl    %ecx, (%ebx)
    
    # strcpy(nome_novo_produto, nome_produto)
    pushl $nome_produto
    pushl $nome_novo_produto
    call strcpy
    addl $8, %esp

    movl lote_produto, %eax
    movl %eax, lote_novo_produto

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

        pushl $nome_novo_produto
        pushl $nome_produto
        call strcmp
        addl $8, %esp   # eax = strcmp(nome_produto, nome_novo_produto)

        movl %eax, resultado_comparacao
        cmpl $0, %eax

        je _insercao_produto_nome_duplicado
        jmp _insercao_produto_nome_nao_duplicado
        _insercao_produto_nome_duplicado:

            movl lote_produto, %eax
            movl lote_novo_produto, %ebx
            cmpl %eax, %ebx
            jne _insercao_produto_nome_nao_duplicado

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
                movl novo_no, %eax
                addl $56, %eax
                
                movl    inicio_lista, %ecx
                movl    %ecx, (%eax)

                movl novo_no, %eax
                movl %eax, inicio_lista # inicio_lista = novo_no

                jmp _insercao_produto_continuar_interno

            _insercao_produto_no_anterior_nao_zero:
                movl novo_no, %eax
                addl $56, %eax
                
                movl    no, %ecx
                movl    %ecx, (%eax)

                movl no_anterior, %eax
                addl $56, %eax

                movl    novo_no, %ecx
                movl    %ecx, (%eax)

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

        movl no, %eax
        addl $56, %eax

        movl    (%eax), %ecx
        movl    %ecx, no

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

    movl no_anterior, %eax
    addl $56, %eax

    movl    novo_no, %ecx
    movl    %ecx, (%eax)

    movl tamanho_lista, %eax
    incl %eax
    movl %eax, tamanho_lista # tamanho_lista ++

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
        RET


// debug_print:
//     pushl valor_venda
//     pushl valor_compra
//     pushl quantidade_estoque
//     pushl $fornecedor
//     pushl data_validade
//     pushl lote_produto
//     pushl $nome_produto
//     pushl $txtPrintNo
//     call printf
//     addl $32, %esp
//     RET

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
    
    flds valor_venda
    subl $8, %esp
    fstpl (%esp)
    # pushl valor_venda

    flds valor_compra
    subl $8, %esp
    fstpl (%esp)
    #pushl valor_compra
    
    pushl quantidade_estoque
    pushl $fornecedor
    pushl data_validade
    pushl lote_produto
    pushl $nome_produto
    pushl $txtPrintNo
    call printf
    addl $40, %esp

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

        movl no, %eax
        addl $56, %eax
        movl (%eax), %ebx
        movl %ebx, no

        jmp _relatorio_ord_nome_inicio_laco
    _relatorio_ord_nome_fim_laco:
        RET

atualizacao_produto:
    pushl $txtAtualizNomeProd
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
    
    pushl $txtAtualizNovoEsto
    call printf
    addl $4, %esp
    
    pushl $quantidade_estoque   # pede novo estoque
    pushl $formatoINT
    call scanf
    addl $8, %esp

    pushl $txtAtualizNovoVVen
    call printf
    addl $4, %esp
    
    pushl $valor_venda   # pede novo valor de venda
    pushl $formatoFLOAT
    call scanf
    addl $8, %esp
    
    movl quantidade_estoque, %ecx
    movl no, %eax
    addl $44, %eax
    movl %ecx, (%eax)

    movl valor_venda, %ecx
    movl no, %eax
    addl $52, %eax
    movl %ecx, (%eax)

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

    # pushl $4
    movl no, %ebx
    addl $56, %ebx  # ebx = no + 56, posicao do ponteiro
    # pushl %ebx

    movl no_anterior, %eax
    cmpl $0, %eax
    je _remocao_primeiro_elemento
    jmp _remocao_nesimo_elemento

    
    _remocao_primeiro_elemento:
        movl $inicio_lista, %edx
        jmp _remocao_finalizar

    _remocao_nesimo_elemento:
        movl no_anterior, %edx
        addl $56, %edx
        jmp _remocao_finalizar

    _remocao_finalizar:
        movl (%ebx), %ecx
        movl %ecx, (%edx)

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

consulta_financeira:
    # Zera as variáveis de total

    movl $0, %eax
    movl %eax, lixo

    flds lixo
    fstl total_compra
    fstl total_venda
    fstpl capital_perdido # no último a gente tira da pilha
    
    # Verifica se a lista está vazia
    movl inicio_lista, %eax
    cmpl $0, %eax
    jne _consulta_financeira_nao_vazia
    
    pushl $txtFinNenhumProd
    call printf
    addl $4, %esp
    RET

_consulta_financeira_nao_vazia:
    movl inicio_lista, %eax
    movl %eax, no

_consulta_financeira_loop:
    cmpl $0, no
    je _consulta_financeira_fim_loop

    call carregar_dados_no

    filds quantidade_estoque  
    flds valor_compra
    fmul %st(1), %st(0)    # st0 = valor compra * qtd estoque
    flds total_compra
    fadd %st(1), %st(0)
    fstps total_compra
    fstps lixo  # limpando a pilha
    fstps lixo 
    
    // movl quantidade_estoque, %eax
    // movl valor_compra, %ebx
    // mull %ebx
    // addl %eax, total_compra

    filds quantidade_estoque  
    flds valor_venda
    fmul %st(1), %st(0)    # st0 = valor compra * qtd estoque
    flds total_venda
    fadd %st(1), %st(0)
    fstps total_venda
    fstps lixo  # limpando a pilha
    fstps lixo 
    
    // movl quantidade_estoque, %eax
    // movl valor_venda, %ebx
    // mull %ebx
    // addl %eax, total_venda
    
    movl data_validade, %eax
    movl data_atual, %ebx
    cmpl %ebx, %eax
    jge _consulta_financeira_proximo_no # se data_validade >= data_atual, não está vencido

    // movl quantidade_estoque, %eax
    // movl valor_compra, %ebx
    // mull %ebx
    // addl %eax, capital_perdido

    filds quantidade_estoque  
    flds valor_compra
    fmul %st(1), %st(0)    # st0 = valor compra * qtd estoque
    flds capital_perdido
    fadd %st(1), %st(0)
    fstps capital_perdido
    fstps lixo  # limpando a pilha
    fstps lixo 

_consulta_financeira_proximo_no:
    movl ponteiro_prox, %eax
    movl %eax, no
    jmp _consulta_financeira_loop

_consulta_financeira_fim_loop:
    pushl $txtFinBanner
    call printf
    addl $4, %esp

    movl op_menu, %eax
    cmpl $0, %eax
    je _print_total_compra
    cmpl $1, %eax
    je _print_total_venda
    cmpl $2, %eax
    je _print_lucro
    cmpl $3, %eax
    je _print_capital_perdido
    jmp _consulta_financeira_fim

_print_total_compra:

    flds total_compra
    subl $8, %esp
    fstpl (%esp)
    // pushl total_compra
    pushl $txtFinResCompra
    call printf
    addl $12, %esp
    jmp _consulta_financeira_fim

_print_total_venda:
    flds total_venda
    subl $8, %esp
    fstpl (%esp)
    // pushl total_venda
    pushl $txtFinResVenda
    call printf
    addl $12, %esp
    jmp _consulta_financeira_fim

_print_lucro:
    flds total_compra
    flds total_venda
    fsub %st(1), %st(0) # st(0) = venda - compra

    subl $8, %esp
    fstpl (%esp)
    fstpl lixo
    // movl total_venda, %eax
    // subl total_compra, %eax
    // pushl %eax
    
    pushl $txtFinResLucro
    call printf
    addl $12, %esp
    jmp _consulta_financeira_fim

_print_capital_perdido:
    flds capital_perdido
    subl $8, %esp
    fstpl (%esp)
    // pushl capital_perdido
    pushl $txtFinResPerda
    call printf
    addl $12, %esp

_consulta_financeira_fim:
    RET

relatorio_ordenado_criterio:
    # Checar se a lista está vazia
    cmpl $0, tamanho_lista
    jne _rel_ord_nao_vazio
    pushl $txtNenhumProdRel
    call printf
    addl $4, %esp
    RET
_rel_ord_nao_vazio:
    # Checar se excede o máximo
    movl tamanho_lista, %eax
    movl max_itens, %ebx
    cmpl %eax, %ebx
    jge _rel_qtd_ok
    pushl max_itens
    pushl $txtMaxItensExcedido
    call printf
    addl $8, %esp
    RET
_rel_qtd_ok:
    movl inicio_lista, %eax
    movl %eax, no

    movl $0, i_loop

_rel_ord_preencher_loop:
    movl no, %eax
    cmpl $0, %eax
    je _rel_ord_preencher_fim

    movl i_loop, %edx
    sall $2, %edx  # multiplicando por 4 bytes
    addl $nos_para_ordenar, %edx  # edx = &(nos_para_ordenar[i_loop])

    movl no, %ebx
    movl %ebx, (%edx)

    movl no, %edx
    addl $56, %edx
    movl (%edx), %ecx
    movl %ecx, no

    movl i_loop, %eax
    incl %eax
    movl %eax, i_loop

    jmp _rel_ord_preencher_loop
_rel_ord_preencher_fim:

    # 2. Bubble Sort
    movl $0, i_loop
_rel_ord_outer_loop:
    movl tamanho_lista, %eax
    decl %eax
    cmpl %eax, i_loop
    jge _rel_ord_sort_fim

    movl $0, j_loop
_rel_ord_inner_loop:
    movl tamanho_lista, %eax
    subl i_loop, %eax
    decl %eax
    cmpl %eax, j_loop
    jge _rel_ord_inner_loop_fim

    # Pega ponteiros
    movl j_loop, %ecx
    movl %ecx, %edx
    sall $2, %edx
    addl $nos_para_ordenar, %edx
    movl (%edx), %eax # ptr1
    addl $4, %edx
    movl (%edx), %ebx # ptr2

    # Extrai valores (quantidade, offset 44)

    movl op_ordenacao, %edx
    cmpl $0, %edx
    je _rel_ord_validade
    jne _rel_ord_estoque

    _rel_ord_validade:
    movl 24(%eax), %esi
    movl 24(%ebx), %edi
    jmp _rel_ord_cont
    
    _rel_ord_estoque:
    movl 44(%eax), %esi
    movl 44(%ebx), %edi
    jmp _rel_ord_cont

    _rel_ord_cont:
    cmpl %edi, %esi # valor1 > valor2 ?
    jle _rel_ord_no_swap

    # Troca ponteiros
    movl j_loop, %ecx
    movl %eax, temp_no
    movl %ebx, %eax
    movl %eax, nos_para_ordenar(,%ecx,4)
    incl %ecx
    movl temp_no, %eax
    movl %eax, nos_para_ordenar(,%ecx,4)

_rel_ord_no_swap:
    incl j_loop
    jmp _rel_ord_inner_loop
_rel_ord_inner_loop_fim:
    incl i_loop
    jmp _rel_ord_outer_loop
_rel_ord_sort_fim:
    # 3. Imprimir
    movl op_ordenacao, %edx
    cmpl $0, %edx
    je _mostra_banner_validade
    
    pushl $txtBannerOrdEstoque
    jmp _fim_banner

    _mostra_banner_validade:
    pushl $txtBannerOrdValidade

    _fim_banner:
    call printf
    addl $4, %esp

    movl $0, i_loop
_rel_ord_print_loop:
    # Compara i_loop com tamanho_lista
    movl i_loop, %ecx          # Carrega i_loop em um registrador
    movl tamanho_lista, %edx   # Carrega tamanho_lista em outro registrador
    cmpl %edx, %ecx            # Compara os dois (ecx - edx)

    # Se i_loop for maior ou igual, o laço terminou. Salta para o fim.
    jge _rel_ord_print_fim     

    # Corpo do laço (só executa se i_loop < tamanho_lista)
    # movl i_loop, %ecx # ECX já contém o valor de i_loop
    movl %ecx, %edx
    sall $2, %edx
    addl $nos_para_ordenar, %edx
    movl (%edx), %eax
    movl %eax, no
    call print_no

    # Incrementa o contador e volta para o início para a próxima verificação
    incl i_loop
    jmp _rel_ord_print_loop

_rel_ord_print_fim:
    RET # Retorna da função

fim:
    pushl   $0
    call    exit
