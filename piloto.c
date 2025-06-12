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

// Variáveis de trabalho
char nome_produto[16];
char fornecedor[16];
int data_atual;
int tamanho_lista = 0;
int lote_produto, tipo_produto, data_validade, quantidade_estoque;
float valor_compra, valor_venda;
int* ponteiro_prox;
char* no;
char* inicio_lista;

char* no_anterior;

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
    if (no == 0)
    {
        return;
    }

    carregar_dados_no();

    // Buscar tipo de produto

    char str_tipo_produto[16] = "teste placeholder";
    printf("Produto: %s | Lote: %d, tipo: %s, data de validade: %d, fornecedor: %s, quantidade no estoque: %d, valor de compra: %f, valor de venda: %f",nome_produto,lote_produto,str_tipo_produto, data_validade, fornecedor, quantidade_estoque, valor_compra, valor_venda);
}
void insercao_produto()
{
    printf("\nInsira:\nNome do produto:\n>> ");
    scanf("%s", nome_produto);

    printf("\nLote:\n>> ");
    scanf("%d", &lote_produto);

    printf("\nTipo:\n>> ");
    // OBS: Aqui tem que printar também a tabela com os tipos do produtos (1-Higiene, 2-Limpeza, etc.)
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

    // OBS IMPORTANTE: Talvez seja bem interessante desacoplar essa parte final aqui pra reutilizar na hora de ler o arquivo

    no = malloc(sizeof(char) * 60);

    memcpy(no + 0, nome_produto, 16);
    memcpy(no + 16, &lote_produto, 4);
    memcpy(no + 20, &tipo_produto, 4);
    memcpy(no + 24, &data_validade, 4);
    memcpy(no + 28, fornecedor, 16);
    memcpy(no + 44, &quantidade_estoque, 4);
    memcpy(no + 48, &valor_compra, 4);
    memcpy(no + 52, &valor_venda, 4);
    memset(no + 56, 0, 4); // Inicia com NULL

    // A fazer: percorrer a lista e realizar a inserção ordenada do nó nela

    // Se ele já estiver, talvez printar um erro

    printf("\nProduto inserido com sucesso!");
}

void remocao_produto_nome()
{
    printf("\nInsira o nome do produto a ser removido:\n >> ");
    scanf("%s", nome_produto);

    no_anterior = NULL;
    no = inicio_lista;

    // Percorrer a lista até achar o produto

    // Se achou, colocar o ponteiro do nó anterior como o ponteiro do nó a ser removido, então dar free no nó

    printf("\nProduto removido com sucesso!");
    printf("\nProduto não encontrado");
}

void remocao_produto_validade()
{
    printf("\nRemovendo produtos fora de validade...");

    // Percorrer a lista e ir removendo que nem a função de cima
}

void atualizacao_produto()
{
    printf("\nInsira o nome do produto a ser alterado:\n>> ");
    scanf("%s", nome_produto);

    // Percorrer a lista e achar o nó do produto

    // Se não achar, printar um erro e voltar pra main

    // Talvez printar o produto?

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
    scanf("%s", nome_produto);

    // Percorrer a lista até encontrar o produto com o nome

    // Talvez dê pra reutilizar essa função nas outras, se a gente definir bem como fica o estado das variáveis dps de rodar
    
    printf("\nProduto não encontrado");
    printf("\nProduto: ...");
}

void consulta_financeira()
{
    // Talvez compense ter apenas um laço que some o total de compra, total de venda, lucro total e capital perdido
    // Aí no final só faz o display do que a pessoa escolher, já que ele pede a escolha
}


void gravar_no_disco()
{
    // Arquivo binário
    // Primeiros 4 bytes: inteiro com o número de arquivos
    // A cada 60*n + 4 bytes: um registro

    // Apagar o arquivo antigo, caso exista

    // fprintf (?) no arquivo de saída com o número de registros

    // percorrer a lista até o fim, armazenando os registros como uma sequência de 60 bytes em binário
}

void ler_do_disco()
{
    // Arquivo binário
    // Primeiros 4 bytes: inteiro com o número de arquivos
    // A cada 60*n + 4 bytes: um registro

    // Apagar a lista atual, caso exista

    // fread o número de registros

    // ir lendo os registros e usando a função de inserção para ir montando a nova lista
}

void relatorio_ordenado_nome()
{
    // Apenas ir printando por ordem da lista :D
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

int main()
{
    // Pedir data atual

    inicio_lista = NULL;
}
