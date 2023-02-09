
# Pacotes -----------------------------------------------------------------

library(tidyverse)
library(readxl)

# Caminhos ----------------------------------------------------------------

"C:\Users\Fernando\OneDrive"
# caminho de uma pasta ou arquivo que parte da raiz do seu sistema é "absoluto"

"C:\Users\Fernando\OneDrive\Área de Trabalho\2023-r4ds1"
# outro caminho absoluto

"\home\users\fernando\Documentos"
# um caminho absoluto no linux seria mais ou menos assim ^

read.csv2("C:/Users/Fernando/OneDrive/Área de Trabalho/2023-r4ds1/exemplo_csv.csv")
# é caminho absoluto

read.csv2("exemplo_csv.csv")
# é caminho relativo a pasta em que eu estou, como estou num projeto a pasta
# "de referência" é a própria pasta do projeto.

read.csv2("dados/imdb.csv")

# moral da história...
# na maior parte das vezes a gente quer usar caminhos RELATIVOS e ter um jeito
# de fazer todo mundo que vai olhar o código usar uma pasta de referência conveniente

# Ler arquivos de texto ---------------------------------------------------

read_csv("dados/imdb.csv")
# bonitão!

read.csv("dados/imdb.csv")
# feio... vamos parara de usar!

base_imdb <- read_csv("dados/imdb.csv")

mean(base_imdb$nota_imdb)
min(base_imdb$nota_imdb)
max(base_imdb$nota_imdb)
hist(base_imdb$nota_imdb)

# tem uma função que faz várias estatisticas de uma vez que é a summary
summary(base_imdb$nota_imdb)

# vamos guardar essa ideia 
class(base_imdb)

# o que poderia ter dado errado?

base_imdb <- read_csv2("dados/imdb.csv")
# errei o delimitador

base_imdb <- read_csv("dados/imdb.csv")
# aqui parece que deu tudo certo mas a coluna de "data_lancamento"
# está errada era pra ser data... como eu posso arrumar?

base_imdb <- read_csv("dados/imdb.csv", col_types = cols(data_lancamento = col_date(format = "%Y-%m-%d")))
# código que veio do import datasets

# no csv americano normalmente os problemas que vão aparecer são esses de tipo trocado
# e eventualmente uns NAs

# nos csvs brasileiros é mais complicado...

base_imdb2 <- read_csv2("dados/imdb2.csv")

base_imdb2 <- read_csv2("dados/imdb2.csv", col_types = cols(data_lancamento = col_date(format = "%Y-%m-%d")))
# código que veio do import datasets

# Ler Excel ---------------------------------------------------------------

imdb_nao_estruturada <- read_excel("dados/imdb_nao_estruturada.xlsx", 
                                   col_names = FALSE, skip = 4)

