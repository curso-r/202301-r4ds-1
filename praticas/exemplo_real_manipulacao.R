# Este script lê uma base de dados de filmes salva em imdb.csv (linha XX) e
# devolve duas bases de dados com os filmes de maior orçamento nos EUA e no mundo

# Carregando pacotes ------------------------------------------------------

library(tidyverse)

# Lendo dados -------------------------------------------------------------

dados_imdb <- read_csv("dados/imdb.csv")

# Manipulando dados -------------------------------------------------------

top5_bilheterias_mundo <- arrange(dados_imdb, desc(receita)) |> 
  head(5) |> 
  select(titulo, receita)

top5_bilheterias_eua <- arrange(dados_imdb, desc(receita_eua)) |> 
  head(5) |> 
  select(titulo, receita)

# Escrevendo tabelas ------------------------------------------------------

write_csv2(top5_bilheterias_mundo, "top5_bilheterias_mundo.csv")
write_csv2(top5_bilheterias_eua, "top5_bilheterias_eua.csv")