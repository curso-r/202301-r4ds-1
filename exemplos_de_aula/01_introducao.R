
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
#valor+para+cada+um também não pode

# nome válidos

# letras maisculas e minusculas

ValorParaCadaUm <- conta_mercado/2
valorparacadaum <- 123

# Camel Case

# IMPORTANTE o R é Case-Sensitive
# (diferencia maiúsculas e minúsculas)

# ponto

valor.para.cada.um <- conta_mercado/2

# pode usar numero se não for o primeiro caracter

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
1+2+3+4+5

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

# E se for aspas simples?

objetos_texto_nathan <- 'meu texto'

objeto_texto_com_aspas <- "'meu texto'"

# Quais tipos de objeto existem?

class(objeto_numero)
class(objeto_texto)

# são infinitos!

# essencialmente 5 são os mais importantes

# eles são mais importantes pq são colunas das nossas bases de dados


# numeros
4
x <- 5
# são azuis

# textos
textao <- "a"

# lógico ou booleano (em ingles logical ou boolean) só tem 2
TRUE
FALSE

# azul desbotado

objeto_booleano <- TRUE

class(objeto_booleano)

# spoiler isso aqui vai ser importante pra fazer filtros
# vou mandar o R executar um comando pra todas as linhas da
# se o resultado for TRUE a linha 
# na tabela, se for FALSE ela vai embora

# Datas! Objetos do tipo Date

Sys.Date()

data_de_hoje <- Sys.Date()
data_de_ontem <- data_de_hoje-1

class(data_de_hoje)

data_de_hoje+30
data_de_hoje-10

data_de_hoje-data_de_ontem

# Número inteiro (integer)

# é praticamente ao numeric normal

x <- 1.1

class(x)

# a class é diferente

x2 <- 1L
# colocamos a letra L do lado!

class(x2)

# Nossos 5 tipos de variáveis mais comuns de 95% das aplicações:

# numeric (numero quebrado), character (texto), logical (TRUE ou FALSE),
# Date (datas) e integer (numero inteiro)

# Outro tipo muito comum: o data.frame

# funções de leitura de dados normalmente começam com "read"

outra_variavel <- 10

dados <- read.csv2("exemplo_csv.csv")
class(dados)

# numeric (numero quebrado), character (texto), logical (TRUE ou FALSE),
# Date (datas) e integer (numero inteiro)
# e podemos misturar esses tipos dentro dos data.frames!

# como posso usar data.frame: extraindo colunas e manipulando

dados$salario
sum(dados$salario)

sum(dados$salario)/3
# média na mão

mean(dados$salario)
# função que tira a média

# Vetores

salario <- 11L

# vamos comparar:
salario
dados$salario

class(salario)
class(dados$salario)

salario <- c(11L, 12L, 13L)

salario
dados$salario

vetor_de_textos <- c("fernando", "maria")

dados$salario
# é um vetor! poderia ter sido criado com c(11L, 12L, 13L)

sum(salario)
# grande parte das nossas funções aceitam vetor como entrada

mean(salario)
max(salario)
min(salario)

# vetores sendo filas ordenadas de valores deixam a gente mexer nas 
# posições

salario[1]
# começa do 1, não do 0 ou outra coisa
salario[3]

salario[4]
# ATENÇÃO!! às vezes mexendo com vetores podemos nos deparar com 
# "não disponível" ou NA veremos mais detalhes sobre isso depois

numeros_quebrados <- c(11.1, 12.2, 15.7)
class(numeros_quebrados)
numerozinho_quebrado <- 0.1
class(numerozinho_quebrado)

c(11.1, "a")
# coisas que podem dar errado! ^^

dados_2 <- read.csv2("exemplo_csv_zoado.csv")
dados_2

# vetores tem que ser sempre do mesmo tipo! não pode misturar
# se eu to criando na mão acontece coerção:

c(11.1, "a", TRUE)
# o texto ganhou!

# numa tabela acontece a mesma coisa
dados_2
class(dados_2$salario)

salario_ao_quadrado <- dados$salario^2

mean(salario_ao_quadrado)

# o que podemos fazer? trocar o tipo das variáveis (tanto vetor quanto objeto avulso)

# usamos as funções as.???

numero_1_que_virou_texto <- as.character(1)
class(numero_1_que_virou_texto)

numero_quebrados_em_texto <- as.character(numeros_quebrados)
numero_quebrados_em_texto+1
"1"+1

salario_como_numero <- as.numeric(dados_2$salario)
class(salario_como_numero)
salario_como_numero+1

# numeric (numero quebrado), character (texto), logical (TRUE ou FALSE),
# Date (datas) e integer (numero inteiro)

as.numeric("12")
as.character(50)
as.logical("TRUE")


data_em_formato_texto <- "2020-01-01"
data_em_formato_texto+1

as.Date(data_em_formato_texto)+1

# OBSERVE
data_em_formato_texto
data_em_formato_data <- as.Date(data_em_formato_texto)
data_em_formato_data

class(data_em_formato_texto)
class(data_em_formato_data)

as.Date("2020/01/01")
# separador pode ser /
as.Date("2020.01.01")
# não pode ser .

# CUIDADO!!!!
as.Date("01/01/2020")
# esse comando roda, mas o resultado não faz (muito) sentido

# parenteses: argumentos de função
# tudo que vem dentro do parênteses quando eu uso uma função:
#FUNCAO(???)
#FUNCAO(argumentos/parametros)

as.Date("01/01/2020", format = "%d/%m/%Y")
# aqui nessa função os argumentos são o texto que vai virar data e
# "format" que diz de que maneira aquele texto tem que ser interpretado

# como eu sabia que existia isso?

# eu consultei a documentação:

help(as.Date)
# help, sem chamar a função (usar ela + ()) mostra a documentação

as.Date("01/01/2020")
# é uma boa prática a gente nomear os argumentos
as.Date(x = "01/01/2020", format = "%m/%d/%Y")
as.Date(x <- "01/01/2020", format <- "%m/%d/%Y")
# normalmente vc não quer isso! então nos argumentos/parametros
# das funçõe use sempre "=" que não dá esse problema

as.Date(x = "2020.01.01", format = "%Y.%m.%d")

variavel1 <- 1
variavel1_alt = 1

# Pacotes

install.packages("tidyverse")

read_csv
# substitui a read.csv, vem do pacote readr

# antes de eu mandar o pacote ficar disponível, dá erro:
read_csv2("exemplo_csv.csv")

library(readr)
# dou library no pacote onde mora a função que eu quero

# SPOILER

# pacotes mais importantes do curso são do readr pra leitura 
# organizada de pacotes

# e dplyr pra manipulação de tabelas

library(tidyverse)
# é um atalho pra carregar os dois ao mesmo

install.packages("ggupset")
