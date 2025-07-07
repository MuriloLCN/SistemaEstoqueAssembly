// Planejamento inicial em C

/*
Implementar em linguagem Gnu Assembly para plataforma 32bits, um programa de Controle Estoque de Supermercado, 
usando exclusivamente as instruções e recursos de programação passados durante as aulas. O programa deve executar 
as funcionalidades de controle de estoque de um supermercado. As seguintes funcionalidades devem ser implementadas: 
inserção de produto (insere novo registro de produto), 
remoção de produtos (remove registro de produto existente por nome ou por estar fora de validade, a escolher), 
atualização de produto (atualiza registro de produto existente nos campos quantidade do estoque e valor de venda), 
consulta de produto (consulta por nome), consulta financeira (total de compra, total de venda, lucro total ou capital perdido, a escolher), 
gravação de registro (da memória para o disco), carregamento/recuperação de registros (do disco para a memória) e 
relatório de registros (ordenados por nome, por data de validade ou por quantidade em estoque, a escolher).

Deve-se usar uma lista encadeada dinâmica (com malloc) para armazenar os registros dos produtos ordenados 
por ordem alfabética em memória. As inserções e remoções alteram a lista, alocando e liberando espaço de memória, 
respectivamente. A lista pode ser gravada ou carregada no/do disco.

Para cada registro de produto deve-se ter as seguintes informações: nome do produto, lote do produto, 
tipo do produto (por ex: alimento, limpeza, utensílios etc, totalizando 15 tipos a escolher), data de validade, 
fornecedor, quantidade no estoque, valor de compra e valor de venda. As consultas de produtos devem ser feitas por 
nome do produto, observando que para o mesmo nome pode haver diferentes lotes.

O relatório deve mostrar todos os registros cadastrados de forma ordenada. 

Na consulta financeira, o total de compra indica o total gasto com as compras do estoque, total de venda indica o total 
a ser obtido com a venda de todo o estoque, lucro total é obtido pelo total de venda menos o total de compra e o capital 
perdido indica o total gasto com a compra de produtos que perderam a validade.

Os trabalhos devem ser feitos em grupos de no máximo 3 alunos. O código fonte deve ser entregue juntamente com um relatório contendo: 
identificação dos participantes, descrição dos principais módulos desenvolvidos e auto-avaliação do funcionamento (elencar as partes 
que funcionam corretamente, as partes que não funcionam corretamente e sob quais circunstancias, bem como as partes que não foram 
implementadas). O programa deve ser estruturado em procedimentos/funções Deve-se utilizar menu de opções. O código deve ser comentado. 
Entregar o código fonte.

OBS: O trabalho será apresentado.

Lista de funções
> Inserção de produto
> Remoção de produtos
> Atualização
> Consulta
> Consulta financeira
> Gravação na memória
> Leitura Memória
> Relatório

Deslocamentos
0-15: Nome
16-19: Lote
20-23: Tipo
24-27: Data de validade
28-43: Fornecedor
44-47: Quantidade do estoque
48-51: Valor de compra
52-55: Valor de venda
56-59: Ponteiro para o próximo
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// strings para mostrar o nome do programa no terminal
const char banner1[] = "\n   _____ _     _                             _        ______     _                         \n";
const char banner2[] = "  / ____(_)   | |                           | |      |  ____|   | |                        \n";
const char banner3[] = " | (___  _ ___| |_ ___ _ __ ___   __ _    __| | ___  | |__   ___| |_ ___   __ _ _   _  ___ \n";
const char banner4[] = "  \\___ \\| / __| __/ _ \\ '_ ` _ \\ / _` |  / _` |/ _ \\ |  __| / __| __/ _ \\ / _` | | | |/ _ \\ \n";
const char banner5[] = "  ____) | \\__ \\ ||  __/ | | | | | (_| | | (_| |  __/ | |____\\__ \\ || (_) | (_| | |_| |  __/\n";
const char banner6[] = " |_____/|_|___/\\__\\___|_| |_| |_|\\__,_|  \\__,_|\\___| |______|___/\\__\\___/ \\__, |\\__,_|\\___|\n";
const char banner7[] = "                                                                             | |           \n";
const char banner8[] = "                                                                             |_|           \n";

// argumento passado para a função system()
const char limpa_terminal[] = "clear";

// formatos de argumentos para o scanf
// ...

// Variáveis de trabalho
char nome_produto[16];
char fornecedor[16];
int data_atual;
int tamanho_lista = 0;
int lote_produto, tipo_produto, data_validade, quantidade_estoque;
float valor_compra, valor_venda;
char* ponteiro_prox;
char* no;
char* inicio_lista;
int op_menu;
FILE *arquivo_ptr;
char nome_aux[16];

char* no_anterior;
char* novo_no;

/*
    Produtos:
    0: Higiene
    1: Limpeza
    2: Perecíveis
    3: Não-Perecíveis
    4: Bebidas
    5: Padaria
    6: Açougue
    7: Congelados
    8: Utilidades
    9: Eletrodom.
    10: Petshop
    11: Infantis
    12: Hortifruti
    13: Papelaria
    14: Doces
    15: Outros
*/

// Inserção

char nome_novo_produto[16];
int resultado_comparacao;

void carregar_dados_no()
{
    /*
    Carrega dos dados do ponteiro apontado por 'no' para as variáveis 'nome produto','lote produto', etc.
    */
    memcpy(nome_produto, no + 0, 16);
    memcpy(&lote_produto, no + 16, 4);
    memcpy(&tipo_produto, no + 20, 4);
    memcpy(&data_validade, no + 24, 4);
    memcpy(fornecedor, no + 28, 16);
    memcpy(&quantidade_estoque, no + 44, 4);
    memcpy(&valor_compra, no + 48, 4);
    memcpy(&valor_venda, no + 52, 4);
    memcpy(&ponteiro_prox, no + 56, 4);
}

void print_no()
{
    /*
        Printa as informações do nó atualmente armazenado em 'no' na tela
    */
    if (no == 0)
    {
        printf("\n[Debug] Tentativa de imprimir um nó inválido realizada");
        return;
    }

    carregar_dados_no();

    printf("\nProduto: %s | Lote: %d, data de validade: %d, fornecedor: %s, quantidade no estoque: %d, valor de compra: %f, valor de venda: %f, tipo: ",nome_produto,lote_produto,data_validade, fornecedor, quantidade_estoque, valor_compra, valor_venda);
    switch (tipo_produto)
    {
        case 0:
            printf("Higiene");
            break;
        case 1:
            printf("Limpeza");
            break;
        case 2:
            printf("Perecíveis");
            break;
        case 3:
            printf("Não-Perecíveis");
            break;
        case 4:
            printf("Bebidas");
            break;
        case 5:
            printf("Padaria");
            break;
        case 6:
            printf("Açougue");
            break;
        case 7:
            printf("Congelados");
            break;
        case 8:
            printf("Utilidades");
            break;
        case 9:
            printf("Eletrodom.");
            break;
        case 10:
            printf("Petshop");
            break;
        case 11:
            printf("Infantis");
            break;
        case 12:
            printf("Hortifruti");
            break;
        case 13:
            printf("Papelaria");
            break;
        case 14:
            printf("Doces");
            break;
        case 15:
            printf("Outros");
            break;
    }
}

void encontrar_produto_nome()
{
    /*
        Percorre a lista até encontrar um produto com o mesmo nome do que está na variável nome_aux
        Como resultado, o ponteiro do produto estará em no, caso não seja encotrado no será igual a 0
        O elemento anterior é armazenado em no_anterior
    */

    no_anterior = 0;
    no = inicio_lista;

    while (no != 0)
    {
        carregar_dados_no();

        resultado_comparacao = strcmp(nome_produto, nome_aux);

        if (resultado_comparacao == 0)
        {
            break;
        }

        no_anterior = no;
        memcpy(&no, no + 56, 4);
    }
}

void pegar_dados_produto_input()
{
    printf("\nInsira:\nNome do produto:\n>> ");
    scanf("%s", nome_produto);

    printf("\nLote:\n>> ");
    scanf("%d", &lote_produto);

    printf("\nTipo:\n0: Higiene\n1: Limpeza\n2: Perecíveis\n3: Não-Perecíveis\n4: Bebidas\n5: Padaria\n6: Açougue\n7: Congelados\n8: Utilidades\n9: Eletrodom.\n10: Petshop\n11: Infantis\n12: Hortifruti\n13: Papelaria\n14: Doces\n15: Outros\n>> ");
    scanf("%d", &tipo_produto);

    printf("\nData validade (YYYYMMDD):\n>> ");
    scanf("%d", &data_validade);

    printf("\nFornecedor:\n>> ");
    scanf("%s", &fornecedor);

    printf("\nQuantidade no estoque:\n>> ");
    scanf("%d", &quantidade_estoque);

    printf("\nValor compra:\n>> ");
    scanf("%f", &valor_compra);

    printf("\nValor venda:\n>> ");
    scanf("%f", &valor_venda);
}

void insercao_produto()
{
    /*
        Cria um novo nó com os dados de nome_produto, lote, etc. e insere ordenadamente na lista
    */

    novo_no = malloc(sizeof(char) * 60);
    memcpy(novo_no + 0, nome_produto, 16);
    memcpy(novo_no + 16, &lote_produto, 4);
    memcpy(novo_no + 20, &tipo_produto, 4);
    memcpy(novo_no + 24, &data_validade, 4);
    memcpy(novo_no + 28, fornecedor, 16);
    memcpy(novo_no + 44, &quantidade_estoque, 4);
    memcpy(novo_no + 48, &valor_compra, 4);
    memcpy(novo_no + 52, &valor_venda, 4);
    memset(novo_no + 56, 0, 4); // Inicia com NULL
    strcpy(nome_novo_produto, nome_produto);
    no_anterior = 0;
    no = inicio_lista;
    while (no != 0)
    {
        carregar_dados_no();

        resultado_comparacao = strcmp(nome_produto, nome_novo_produto);

        if (resultado_comparacao < 0)
        {
            // Achou o lugar
            // A -> C
            // A -> B -> C
            if (no_anterior == 0)
            {
                memcpy(novo_no + 56, &inicio_lista, 4);
                inicio_lista = novo_no;
            }
            else
            {
                memcpy(novo_no + 56, &no, 4);
                memcpy(no_anterior + 56, &novo_no, 4);
            }      
            tamanho_lista++;
            printf("\nProduto inserido com sucesso!");      
            return;
        }
        if (resultado_comparacao == 0)
        {
            printf("\nNome duplicado! Produto não pode ser inserido");
            free(novo_no);
            return;
        }

        no_anterior = no;
        memcpy(&no, no + 56, 4);
    }
    printf("Chegou aqui 6");
    if (no_anterior == 0)
    {
        // Lista vazia
        inicio_lista = novo_no;
        tamanho_lista++;
    }
    else
    {
        memcpy(no_anterior + 56, &novo_no, 4);
        tamanho_lista++;
    }
}

void remocao_produto_nome()
{
    printf("\nInsira o nome do produto a ser removido:\n >> ");
    scanf("%s", nome_aux);

    encontrar_produto_nome();
    
    if (no == 0)
    {
        printf("\nProduto não encontrado");
    }
    else
    {
        if (no_anterior == 0)
        {
            // Primeiro elemento
            memcpy(&inicio_lista, no + 56, 4);
            free(no);
        }
        else
        {
            // N-Ésimo elemento
            memcpy(no_anterior + 56, no + 56, 4);
            free(no);
        }
        tamanho_lista--;
        printf("\nProduto removido com sucesso!");
    }
}

void remocao_produto_validade()
{
    /*
        Percorre a lista de registros comparando a data de validade do produto com a data atual. Caso a data de validade
        do produto seja menor que a data atual, este item é removido da lista. Nessa funcionalidade, nenhum dado 
        adicional é pedido ao usuário, as comparações são feitas com base na data atual do sistema já inserida pelo usuário
    */

    printf("\nRemovendo produtos fora de validade [%d] ...", data_atual);

    no_anterior = NULL;
    no = inicio_lista;

    while (no != NULL)
    {
        carregar_dados_no();

        printf("\nData validade: %d\tData atual: %d\n");
        resultado_comparacao = data_validade - data_atual;

        if (resultado_comparacao < 0) // se a data de validade for estritamente menor que a data atual
        {
            if (no_anterior == NULL) // se o primeiro elemento é quem deve ser removido
            {
                // memcpy(inicio_lista, no + 56, 4); 
                inicio_lista = ponteiro_prox; // o segundo elemento da lista se torna o primeiro
            }

            else // se o elemento a ser removido não é o primeiro
            {
                // o nó anterior continua sendo o mesmo, nesse caso
                memcpy(no_anterior + 56, no + 56, 4);
                // memcpy(no, no_anterior + 56, 4); // avançando na lista
            }

            printf("Item:\t[%s]\tREMOVIDO\n", nome_produto);

            free(no);
            tamanho_lista--;
        }

        else 
        {
            no_anterior = no;
            // memcpy(no, no + 56, 4); // avançando na lista
        }

        no = ponteiro_prox; // avançando a lista
    }
}

void atualizacao_produto()
{
    printf("\nInsira o nome do produto a ser alterado:\n>> ");
    scanf("%s", nome_aux);

    encontrar_produto_nome();

    if (no == 0)
    {
        printf("\nProduto não encontrado");
        return;
    }

    printf("\nInsira o estoque novo:\n>> ");
    scanf("%d", &quantidade_estoque);

    printf("\nInsira o valor de venda:\n>> ");
    scanf("%f", &valor_venda);
    
    memcpy(no + 44, &quantidade_estoque, 4);
    memcpy(no + 52, &valor_venda, 4);

    printf("\nProduto alterado com sucesso!");
}

void consulta()
{
    printf("\nInsira o nome do produto a ser buscado:\n>> ");
    scanf("%s", nome_aux);

    encontrar_produto_nome();

    if (no == 0)
    {
        printf("\nProduto não encontrado");
    }
    else
    {
        print_no();
    }
}

void consulta_financeira()
{
    // Talvez compense ter apenas um laço que some o total de compra, total de venda, lucro total e capital perdido
    // Aí no final só faz o display do que a pessoa escolher, já que ele pede a escolha
}

void gravar_no_disco()
{
    // Arquivo binário
    // Primeiros 4 bytes: inteiro com o número de registros
    // A cada 56*n + 4 bytes: um registro
    
    // Sobrescrever o arquivo antigo, caso exista

    arquivo_ptr = fopen("dados.dat", "wb");

    fwrite(&tamanho_lista, sizeof(int), 1, arquivo_ptr);

    char *indice_atual_lista = inicio_lista;
    for (int i = 0; i < tamanho_lista; i++)
    {   
        // só uma segurança a mais
        if (indice_atual_lista == NULL)
            break;

        // vamos escrever 56 bytes, descontando os últimos quatro bytes do nó que representa o ponteiro para o próximo elemento
        fwrite(indice_atual_lista, 56, 1, arquivo_ptr);
        /*
            Esse passo merece uma explicação um pouco mais atenciosa. Primeiramente, temos que encontrar a posição no registro
            que guarda o ponteiro para o próximo registro; tal posição é dada pela soma do endereço de memória do início do 
            registro + o offset da posição onde o endereço do próximo nó está armazenado. Tenho esse deslocamento, temos que 
            informar que o tipo de dado ali contido é um ponteiro para um ponteiro, por isso usa-se char**. Além disso, não
            queremos esse endereço cru, mas sim o ponteiro no qual ele aponta. Devido a isso, ainda é necessário fazer a 
            derreferenciação final.
        */
        // atualizando o índice atual com o próximo elemento
        indice_atual_lista = *((char**) (indice_atual_lista + 56));
    }

    fclose(arquivo_ptr);
}

void ler_do_disco()
{
    // Arquivo binário
    // Primeiros 4 bytes: inteiro com o número de registros
    // A cada 56*n + 4 bytes: um registro

    char *prox, *deslocamento, *reg_atual_ptr;
    arquivo_ptr = fopen("dados.dat", "rb");
    
    fread(&tamanho_lista, 4, 1, arquivo_ptr);

    // cada registro, na RAM, tem 60 bytes
    reg_atual_ptr = malloc(60);
    inicio_lista = reg_atual_ptr;
    fread(reg_atual_ptr, 56, 1, arquivo_ptr);

    // começa do 1, porque já foi lido um registro
    for (int i = 1; i < tamanho_lista; i++)
    {
        prox = malloc(60);
        fread(prox, 56, 1, arquivo_ptr);    
        deslocamento = reg_atual_ptr + 56;
        // ligando os nós
        *((void**) deslocamento) = prox;
        reg_atual_ptr = prox;
    }

    deslocamento = reg_atual_ptr + 56;
    // atterrando o últiimo registro
    *((void**) deslocamento) = NULL;

    fclose(arquivo_ptr);
}

void relatorio_ordenado_nome()
{
    // Apenas ir printando por ordem da lista :D
    no = inicio_lista;
    
    printf("\n-----------------------\nProdutos ordenados por nome\n-----------------------");
    while (no != 0)
    {
        print_no();
        memcpy(&no, no + 56, 4); // no = no.prox
    }
}

void relatorio_ordenado_data_validade()
{
    // montar uma lista de n inteiros, um pra cada elemento da lista, inicializados com 0

    // malloc e dps um for

    // variavel booleana: flag printou elemento = true

    // enquanto printou elemento:

    // indice maior = -1

    // percorrer e ir guardando o maior nó e o seu índice correspondente, com base na validade [Pular os que tem lista[k]=1!!]

    // se o indice for igual a -1, printou_elemento = false

    // se n, printar o elemento, setar lista[indice_maior] = 1

    // free no malloc
}

void relatorio_ordenado_quantidade_estoque()
{
    // mesma coisa que o anterior mas com base na quantidade estoque
}

void mostrar_banner()
{
    printf("%s", banner1);
    printf("%s", banner2);
    printf("%s", banner3);
    printf("%s", banner4);
    printf("%s", banner5);
    printf("%s", banner6);
    printf("%s", banner7);
    printf("%s", banner8);
}

void recebe_ano()
{
    char resposta = 's';
    do {
        printf("\nDigite a data atual no formato yyyymmdd (Ex.: 20250612): ");
        scanf("%d", &data_atual);
        printf("Data atual: %d\n", data_atual);
        printf("Confirma a data [%d]? (s/n) ", data_atual);
        scanf(" %c", &resposta);
    } while(resposta != 's');
}

void debug()
{
    printf("\nVariáveis:");
    printf("\nNome prod: %s",nome_produto);
    printf("\nFornecedor %s:",fornecedor);
    printf("\nData atual: %d",data_atual);
    printf("\nTamanho: %d",tamanho_lista);
    printf("\nLote: %d",lote_produto);
    printf("\nTipo: %d",tipo_produto);
    printf("\nData validade: %d",data_validade);
    printf("\nQtd estoque: %d",quantidade_estoque);
    printf("\nValor compra: %f",valor_compra);
    printf("\nValor venda: %f",valor_venda);
    printf("\nPonteiro prox: %d",ponteiro_prox);
    printf("\nNo: %d",no);
    printf("\nInicio lista: %d",inicio_lista);
    printf("\nNome aux: %s",nome_aux);
}

void menu()
{
    debug();
    printf("\n--> Data atual: %d", data_atual);
    
    printf("\n\nSelecione uma das funcionalidades abaixo: \n");
    printf("[0] - Insercao de produto\n");
    printf("[1] - Remocao de produto\n");
    printf("[2] - Atualizacao de produto\n");
    printf("[3] - Consulta de produto por nome\n");
    printf("[4] - Consulta financeira\n");
    printf("[5] - Gravacao de registros\n");
    printf("[6] - Carregamento de registros\n");
    printf("[7] - Relatorio de registros\n");
    printf("[8] - Sair\n");
    scanf("%d", &op_menu);

    if (op_menu == 0)
    {
        pegar_dados_produto_input();
        insercao_produto();
    }

    else if (op_menu == 1)
    {
        printf("\nDeseja remover por das opcoes abaixo? \n");
        printf("[0] - Nome\n");
        printf("[1] - Data de validade\n");
        scanf("%d", &op_menu);
        
        if (op_menu == 0)
        {
            remocao_produto_nome();
        }

        else if (op_menu == 1)
        {
            remocao_produto_validade();
        }

        else
        {
            printf("Opcao inválida!\n");
            menu(); // Chama o menu novamente
        }
    }

    else if (op_menu == 2)
    {
        atualizacao_produto();
    }
    else if (op_menu == 3)
    {
        consulta();
    }

    else if (op_menu == 4)
    {
        printf("\nDeseja consultar qual das opcoes abaixo?\n");
        printf("[0] - Total de compra\n");
        printf("[1] - Total de venda\n");
        printf("[2] - Lucro total\n");
        printf("[3] - Capital perdido\n");
        scanf("%d", &op_menu);

        if (op_menu == 0)
        {
            // chama a função de consulta de total de compra
        }

        else if (op_menu == 1)
        {
            // chama a função de consulta de total de venda
        }

        else if (op_menu == 2)
        {
            // chama a função de consulta de lucro total
        }

        else if (op_menu == 3)
        {
            // chama a função de consulta de capital perdido
        }

        else
        {
            printf("Opcao inválida!\n");
            menu(); // Chama o menu novamente
        }
    }

    else if (op_menu == 5)
    {
        gravar_no_disco();
    }

    else if (op_menu == 6)
    {
        ler_do_disco();
    }

    else if (op_menu == 7)
    {
        printf("\nDeseja a ordenacão por qual das opcoes abaixo?\n");
        printf("[0] - Nome\n");
        printf("[1] - Data de validade\n");
        printf("[2] - Quantidade de estoque\n");
        scanf("%d", &op_menu);

        if (op_menu == 0)
        {
            relatorio_ordenado_nome();
        }

        else if (op_menu == 1)
        {
            // chama a função de relatório ordenado por data de validade
        }

        else if (op_menu == 2)
        {
            // chama a função de relatório ordenado por quantidade de estoque
        }
        
        else
        {
            printf("Opcao inválida!\n");
            menu(); // Chama o menu novamente
        }
    }

    else if (op_menu == 8)
    {
        return;
    }

    else
    {
        printf("Opcao invalida!\n");
        menu(); // Chama o menu novamente
    }

    menu();
}

int main()
{
    recebe_ano();

    system(limpa_terminal);
    mostrar_banner();
    menu();


    inicio_lista = NULL;
}
