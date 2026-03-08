# Sistema de Controle de Estoque de Supermercado

## Descrição

Este projeto implementa um sistema de controle de estoque para supermercado, desenvolvido majoritariamente em Assembly x86 (AT&T syntax), com apoio de código em C. O sistema permite o gerenciamento completo de produtos, incluindo inserção, remoção, atualização, consultas e geração de relatórios, além de uma consulta financeira baseada no estoque atual e na validade dos produtos. O projeto foi desenvolvido como Trabalho de Implementação 1 da disciplina Programação para Interfaceamento de Hardware e Software.

# Compilação e Execução

# Pré-requisitos

* Sistema Linux (ou WSL)
* GCC com suporte a 32 bits
* NASM / GAS (GNU Assembler)

# Compilação (exemplo)

`gcc -m32 piloto.c sistema-estoque.s -o sistema-estoque`

`./sistema-estoque`
