
# Pacotes -----------------------------------------------------------------

library(tidyverse)

# Valores especiais -------------------------------------------------------

# No R existem alguns valores que eles representam situações especiais que acontecem
# com código. Exemplo, mudar tipos:

as.numeric("a")

# NA é a sigla pra Not Available (não disponível)

dados <- read_csv("dados/imdb.csv")

dados$orcamento

# outro exemplo

dados_exemplo <- read_csv2("exemplo_csv.csv")

mean(c(1, 3, NA))
mean(dados_exemplo$salario)
sum(c(1, 3, NA))

mean(c(1, 3, NA), na.rm = TRUE)

dados_ordeados <- dados |> 
  arrange(desc(orcamento))

# Existem outros valores "especiais" que o R reserva pra situações estranhas

NaN 
# not a number

Inf
-Inf

# são tipo o NA, mas pra situações estranhas envolvendo números

1+1/0

mean(c(1, 3, 1/0))

0/0
-Inf/Inf
log(-Inf)

# todos os valores especiais vão ter um comportamento parecido: se eu tento usar
# o resultado do uso do valor continua sendo um um valor "estranho":

NA+1
NA-1
Inf+10
mean(c(Inf, 2))
NaN+10
1/NaN

# Em bases de dados -------------------------------------------------------

dados_completos <- drop_na(dados) 

mean(dados$orcamento)

#CUIDADO

mean(dados_completos$orcamento)
# essa aqui eu tirei pra fazer a média os NA da coluna orçamento,
# mas também TODOS os NA de outras colunas

mean(dados$orcamento, na.rm = TRUE)
# aqui tira os NA só da coluna orçamento

dados_com_orcamento <- drop_na(dados, orcamento)

mean(dados_com_orcamento$orcamento)
