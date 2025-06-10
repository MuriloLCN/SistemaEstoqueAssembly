// Planejamento inicial em C

/*
Implementar em linguagem Gnu Assembly para plataforma 32bits, um programa de Controle Estoque de Supermercado, usando exclusivamente as instruções e recursos de programação passados durante as aulas. O programa deve executar as funcionalidades de controle de estoque de um supermercado. As seguintes funcionalidades devem ser implementadas: inserção de produto (insere novo registro de produto), remoção de produtos (remove registro de produto existente por nome ou por estar fora de validade, a escolher), atualização de produto (atualiza registro de produto existente nos campos quantidade do estoque e valor de venda), consulta de produto (consulta por nome), consulta financeira (total de compra, total de venda, lucro total ou capital perdido, a escolher), gravação de registro (da memória para o disco), carregamento/recuperação de registros (do disco para a memória) e relatório de registros (ordenados por nome, por data de validade ou por quantidade em estoque, a escolher).

Deve-se usar uma lista encadeada dinâmica (com malloc) para armazenar os registros dos produtos ordenados por ordem alfabética em memória. As inserções e remoções alteram a lista, alocando e liberando espaço de memória, respectivamente. A lista pode ser gravada ou carregada no/do disco.

Para cada registro de produto deve-se ter as seguintes informações: nome do produto, lote do produto, tipo do produto (por ex: alimento, limpeza, utensílios etc, totalizando 15 tipos a escolher), data de validade, fornecedor, quantidade no estoque, valor de compra e valor de venda. As consultas de produtos devem ser feitas por nome do produto, observando que para o mesmo nome pode haver diferentes lotes.

O relatório deve mostrar todos os registros cadastrados de forma ordenada. 

Na consulta financeira, o total de compra indica o total gasto com as compras do estoque, total de venda indica o total a ser obtido com a venda de todo o estoque, lucro total é obtido pelo total de venda menos o total de compra e o capital perdido indica o total gasto com a compra de produtos que perderam a validade.

Os trabalhos devem ser feitos em grupos de no máximo 3 alunos. O código fonte deve ser entregue juntamente com um relatório contendo: identificação dos participantes, descrição dos principais módulos desenvolvidos e auto-avaliação do funcionamento (elencar as partes que funcionam corretamente, as partes que não funcionam corretamente e sob quais circunstancias, bem como as partes que não foram implementadas). O programa deve ser estruturado em procedimentos/funções Deve-se utilizar menu de opções. O código deve ser comentado. Entregar o código fonte.

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
*/
