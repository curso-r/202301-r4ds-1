
# Como rodar códigos

432/2

# CTRL+ENTER, apertar o "RUN" ou CTRL+V daqui pro Console

# mais comandos de calculadora

# adição
1+1

# subtração
4-2

# divisão
4/2

# multiplicação
3*2

# potência
2^2
# (2 x 2)

2^5
#( 2 x 2 x 2 x 2 x 2)

# Objetos

# objeto é um nome que se dá àquilo que a gente o computador guardar
# um outro nome é variável

resultado_conta <- 2^3
# o sinalzinho de "<-" que se chama "atribuição"

resultado_conta+1
resultado_conta-1

# Exemplo de objetos legais

conta_mercado <- 432

valor_para_cada_um <- conta_mercado/2

# nomes inválidos para objetos
# nome é o que vem do lado esquerdo da setinha

# nomes com espaço

valor para cada um <- conta_mercado/2

# nome que comeca com numero

1numero <- conta_mercado/2

# comecar com underline

_numero <- conta_mercado/2

# nao pode tracinho (hifen) em nenhum lugar

valor-para-cada-um <- conta_mercado/2

# nome válidos

# letras maisculas e minusculas

ValorParaCadaUm <- conta_mercado/2
valorparacadaum <- 123

# IMPORTANTE o R é Case-Sensitive
# (diferencia maiúsculas e minúsculas)

# ponto

valor.para.cada.um <- conta_mercado/2

# pode user numero se não for o primeiro caracter

valor_para_cada_um_jan_2023 <- conta_mercado/2

# nós na curso-r e também outros grupos como as pessoas
# que fazem o rstudio usam o padrão:

# tudo minusculo
# troca espaco por underline
# sem acentos ou caracteres especiais

Valor_Que_É <- conta_mercado/2

# Funções

# são comandos como quaisquer outros só que
# eles são descritos por palavras chave mais ou menos
# como os nomes de objetos

sum(1,2,3,4,5)

read.csv2("exemplo_csv.csv")
# esse aqui só lê, mas não guarda
# o R "esquece". não foi pra prateleira dele

dados <- read.csv2("exemplo_csv.csv")
# o R vai lembrar enquanto estiver na prateleira dele

# Tipo de objetos

# até agora sabemos três coisas que podemos escrever no console

# 1 comandos diretos, tipo contas
# 2 chamadas de funcoes (nomes + (???) + possivelmente com argumentos dentro dos parenteses)
# 3 chamar o nome de objetos que a gente já tenha criado pra ser utilizado

# as vezes pode ter confusao entre texto literal
# e nome de objeto

# as aspas servem pra avisar pro R que eu quero
# que aquele texto seja interpretado de maneira
# literal no contexto que ele estiver

dados <- read.csv2("exemplo_csv.csv")

dados <- read.csv2(exemplo_csv.csv)
# isso aqui não funciona porque ele procura um
# objeto com esse nome

# todo texto entre aspas no R é um objeto do tipo
# character, também conhecido como string

# sim! tudo que a gente cria no R tem um tipo

# como eu sei o tipo de um objeto? usa a função class

objeto_numero <- 5
objeto_texto <- "meu texto"

class(objeto_numero)
class(objeto_texto)

# pra que as classes servem? para ajudar o R a entender
# expressoes que envolvam só nomes de objetos

5+5
# esse tá fácil pro R

objeto_numero+5
# já complicou um pouco pq ele precisa abrir o objeto_numero

objeto_texto+objeto_numero
# aqui os tipos de objeto cumprem um papel
# dizer pro R que não vai dar pra fazer a soma
# porque tem um objeto "objeto_texto"
# que não é numérico

# Pergunta do Nathan

# diferença entre "<-" e "="

# em 99% dos casos não tem diferença

X <- 12
X2 = 12
