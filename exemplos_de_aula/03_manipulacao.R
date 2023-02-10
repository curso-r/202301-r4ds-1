
# Carregando pacotes ------------------------------------------------------

library(dplyr)
library(readr)
#alternativa pra carregar um só: library(tidyverse)
# eu não vou dar esse library pra ficar o que estamos usando
# fique a vontade!

# library(c('dplyr', 'readr'))
# não funciona
# library(c(dplyr, readr))

# Carregando base de dados ------------------------------------------------

imdb <- read_rds("dados/imdb.rds")


# Dicas de como ter um cheiro de uma base de dados ------------------------

# algumas funções ajudam a olhar pedacinhos da base pra gente entender o que
# está vindo do arquivo

View(imdb)
# View abre pra gente uma janela no primeiro quadrante que mostra a base
# em formato tabular (tabela)

names(imdb)
# a função aplicada num data.frame retorna o nomes das colunas

glimpse(imdb)
# essa é  meio que uma mistura das duas acima

View(head(imdb))
tail(imdb)


# Manipulação (do  bem) de dados ------------------------------------------

# a lógica aqui é que muitas manipulações (quase todas) podem ser
# resumidas em aplicar alguma ordem de passos pré-definidos.

# ou seja é como se eu fosse contar uma história sobre os dados a tabela etc, mas
# só com 6 verbos:

# verbos do dplyr ---------------------------------------------------------

# selecionar colunas (função select())
# ordernar linhas (função arrange())
# filtrar linhas (remover) (função filter())
# criar colunas (função mutate())
# sumarizar os dados em pedaços menores (função summarize() summarise())
# juntar bases de dados (funções do estilo XXXX_join())

# Exemplo: quero uma lista dos nomes dos 10 filmes de maior orcamento

# Passo 1: (arrange) Ordenar as linhas da base pela coluna "orcamento" (do maior pro menor)
# Passo 2: (head) Manter apenas as 10 primeiras linhas
# Passo 3: (select) Selecionar só a coluna "titulo" que tem o nome do filme

# arrange -----------------------------------------------------------------

# todos os verbos do dplyr tem um padrão parecido: VERBO(DADOS, ?????)

arrange(imdb, orcamento)
# por padrão a ordenação é do menor pro maior

imdb_ordenado_pelo_orcamento <- arrange(imdb, orcamento)

imdb_maiores_orcamentos <- arrange(imdb, desc(orcamento))

top_10_orcamentos <- head(imdb_maiores_orcamentos, 10)
# curiosidade: se eu quisesse chamar de 10_maiores_orcamento não podia

top_6_a_top_10_orcamento <- tail(top_10_orcamentos, 5)

# select ------------------------------------------------------------------

select(imdb, titulo, orcamento)
# select(DADOS, coluna, coluna2, coluna3, ETC)

titulos_dos_10_orcamento <- select(top_10_orcamentos, titulo, orcamento)

# MISSÃO ORIGINAL CUMPRIDA. Encontra os 10 maiores orcamentos e manter só o título (ou quase)

# outros úteis de usar o select. Suponha que eu quero todas as colunas menos de orcamento

imdb_sem_orcamento <- select(imdb, -orcamento)
# para remover variáveis o "-"

# selecionar com base na posição
imdb_so_ficha <- select(imdb, titulo:pais)

imdb_so_numero_criticas <- select(imdb, starts_with("num"))
# de novo temos funções auxiliares! essas funções servem pra ser usadas
# dentro dos verbos do dplyr e normalmente não fazem sentido fora

imdb_so_numero_criticas_2 <- select(imdb, titulo, starts_with("num"))
# podemos misturar tudo dentro do select

imdb_so_numero_criticas_3 <- select(imdb, starts_with("num"),  titulo)

imdb_termina_cao <- select(imdb, ends_with("cao"))

imdb_termina_cao <- select(imdb, titulo, ends_with("cao"))

imdb_nome_duas_palavras <- select(imdb, contains("_"))

imdb_selecao_vazia <- select(imdb, contains("faturamento_reais"))
# o pior que pode acontecer é não achar nada

# e pra linhas???
# a funçaõ vai ser "filter(dados, condicoes)"

# antes de terminar, mais um exemplo de regras:

imdb_numero_criticas <- select(imdb, starts_with("num_"), -num_avaliacoes)
# é igual a fazer select(imdb, num_criticas_publico, num_criticas_critica)

# misturando verbos do dplyr ----------------------------------------------

# retomando o exemplo dos 10 filmes de maiores orcamentos

imdb_ordenado_orc <- arrange(imdb, desc(orcamento))
imdb_top_10_orc <- head(imdb_ordenado_orc, 10)
imdb_top_10_orc_so_filmes <- select(imdb_top_10_orc, titulo)

# ideia 1: você poderia escrever tudo de uma vez sem criar objetos
# intermediarios:

# passo 1, reescrever "imdb_top_10_orc" sem mencao a "imdb_ordenado_orc":

head(arrange(imdb, desc(orcamento)), 10)
# é igual a imdb_top_10_orc

# passo 2, reeescrever "imdb_top_10_orc_so_filmes" sem mencao
# a "imdb_top_10_orc" e tb sem mencao a "imdb_ordenado_orc"

select(head(arrange(imdb, desc(orcamento)), 10), titulo)
# não é mais fácil de ler... essa solução pra tirar as repetições não é mto boa

# e se eu desse "ctrl+shift+a" ou algo parecido, pra indentar?
select(
  head(
    arrange(
      imdb, desc(orcamento)), 10
  ),
  titulo
)
# não ajuda muito. fica mais fácil de ler só que não tá na ordem que o R faz
# o R faz primeiro arrange, depois head, depois select.
# o que eu leio é ao contrário: primeiro select, depois head, depois arrange

# teria como escrever na ordem que o computador faz e mesmo assim ele entender?
# sem repetir nenhum nome de objeto? TEM!!! 

# a soluçaõ se chama "PIPE" (cachimbo em inglês) e o símbolo dela é "|>"


# Pipe |>    --------------------------------------------------------------

# serve pra transformar funções que estão sendo sucessivamente (aninhadas é um nome pra isso)
# em uma lista de funções ordenadas:

select(head(arrange(imdb, desc(orcamento)), 10), titulo)
# essas funções estão "aninhadas": o "select" é aplicado no resultado de um "head"
# que é aplicado no resultado de um "arrange".


head(arrange(imdb, desc(orcamento)), 10)
# o head tá sendo aplicado num arrange e isso é um aninhamento tb. o pipe "desaninha"
# assim:

arrange(imdb, desc(orcamento)) |> head(10) 
# isso é um atalho pra outra forma:
head(      arrange(imdb, desc(orcamento))                , 10)
# de maneira conceitual o que o pipe faz é:
# FUNCAO2(FUNCAO1(X)) vai virar:
# FUNCAO1(X) |> FUNCAO2()

arrange(imdb, desc(orcamento)) |> head(10) |> select(titulo)
# note que esse pipe acima é exatamente uma implementação dos passos da "receita"
# que a gente escreveu no começo, tipo um roteiro

# Exemplo: quero uma lista dos nomes dos 10 filmes de maior orcamento

# Passo 1: (arrange) Ordenar as linhas da base pela coluna "orcamento" (do maior pro menor)
# Passo 2: (head) Manter apenas as 10 primeiras linhas
# Passo 3: (select) Selecionar só a coluna "titulo" que tem o nome do filme

# pra organizar até mais eu poderia pular linhas:

# passo 1: ordenar
arrange(imdb, desc(orcamento)) |>
  # passo 2: escolher 10 linhas
  head(10) |>
  # passo 3: selecionar titulo
  select(titulo) |>
  # passo 4: pegar só o filme com mais orcamento
  head(1)

# IMPORTANTE:

# em toda sequência de pipes a gente costuma pular linha e entre as funções
# aplicadas você precisa colocar pipe, se você não colocar dá erro:

arrange(imdb, desc(orcamento)) |> 
  head(10) # SE FALTAR O PIPE >>>>     |>         <<<< a próxima linha fica desorientada
  # ERRADO
  select(titulo)
  # aqui ele espera select(DADOS, titulo)

arrange(imdb, desc(orcamento)) |>
  head(10) |>
  select(titulo)

# OUTRA COISA!!! as vezes a gente coloca um pipe e esquece de continuar

arrange(imdb, desc(orcamento)) |>
  head(10) |>
  select(titulo) |>
# isso aqui não dá bem um erro mas é um comando incompleto. depois de um pipe 
# o R sempre espera a aplicação de uma função 
  
# o "+" do R esperando uma coisa acontecer é comum mesmo sem pipe
#arrange(imdb, desc(orcamento)

# lembrando!!! pipe é um atalho para B(A(X)) vira A(X) |> B()

# diferenca entre cifrao e select:

objeto <- arrange(imdb, desc(orcamento)) |>
  head(10) |>
  select(titulo)

objeto
# isso (que sai do select) é uma tabela com 10 linhas e 1 coluna

objeto$titulo
# isso é um vetor!
        
objeto$titulo[1]

objeto[2]

# são diferentes!! ^^^

# os verbos do dplyr só recebem data.frame ou em linguagem popular "tabela"
# não vetor

# existe uma função que faz o mesmo que o "$" pra tabelas, ela se chama pull:

pull(objeto, titulo)
objeto$titulo
# igualzinho

objeto <- arrange(imdb, desc(orcamento)) |>
  head(10) |>
  pull(titulo)
  # essa ultima linha em um conjunto com as otras é pull(tabela_mexida, titulo)

# manipulando as colunas por posicao
imdb |> 
  select(20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

imdb |> 
  select(ano, titulo, everything())
# esse é um bom jeito de trazer colunas pra frente da tabela

imdb |> 
  select(ano, titulo, everything(), -num_avaliacoes, starts_with("num_")) |> View()
# levar pro final é um pouco mais complicado usando o "everything()"

# porque não usar %>%??
# esse pipe existe por um motivo histórico ele vinha de um pacote que se chama "magrittr"
# uma funcionalidade parecida foi incorporada em 2020 na forma do simbolo |>, o "pipe novo"

imdb |> head(10) |> View()
imdb %>% head(10) %>% View()

# Filtrar linhas (filter) -------------------------------------------------


imdb <- read_csv("dados/imdb.csv")

imdb_spielberg <- filter(imdb, direcao == "Steven Spielberg")

imdb_spielberg_ordenado <- arrange(imdb_spielberg, desc(orcamento))

# pipes
imdb_spielberg_ordenado <- imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(orcamento))

imdb_filmes_10_horas <- imdb |> 
  filter(duracao > 600)
# as vezes dá 0 linhas e faz sentido

# vamos usar aqui os operadores lógicos:
# intuitivamente são os sinais que fazem comparações: ==, >, <, <=, >=

# é tudo que no R quando eu uso o resultado é TRUE ou FALSE

imdb |> 
  filter(ano > 2010, duracao > 180)

# poderíamos fazer várias aplicações de filter:

imdb |> 
  filter(ano > 2010) |> 
  filter(duracao < 180)

# Comparações lógicas -----------------------------------------------------

x <- 5

x > 3
x > 0

x > 7

# comparação de vetor com número é como se fosse várias perguntas:
imdb_filmes_5_horas$ano > 2010

# é isso ^^^ que acontece quando a gente faz

imdb_filmes_5_horas |> 
  filter(ano > 2010)
# ele mantém só as linhas pras quais aquele comando deu TRUE

imdb |> 
  filter(receita > orcamento) |>
  View()
# posso colocar no sinal de comparação duas colunas!

imdb$receita > imdb$orcamento
# dá um monte de NA, mas funciona

# Operador lógico ---------------------------------------------------------

# E, OU, NÃO e também DENTRE, que vamos adicionar hj no R

imdb |> 
  filter(pais == "USA" | pais == "BR")
# o que tem dentro do parêntes pode ser traduzido como 
# pais é USA OU pais é BR. | é o "OU"

# a vírgula, se vc não usar OU na mesma frase, é o E

# se vc quiser usar OU e E ao mesmo tempo, o E é &
imdb |> 
  filter(pais == "USA", ano > 2010)

imdb |> 
  filter(pais == "USA" & ano > 2010)

# esses comandos são iguais, mas se tivesse "OU" só poderia usar o segundo

imdb |> 
  filter(
    (pais == "USA" & ano > 2010) | pais == "BR"
  ) |> 
  View()
# não tem filme brasileiro

imdb |> 
  filter(
    !(direcao == "Steven Spielberg")
  )
# a exclamação na frente é NÃO filme do spielberg

imdb |> 
  filter(
    !(duracao < 120)
  )

imdb |> 
  filter(
    (duracao >= 120)
  )

meu_vetor <- c(1,2,3)

# Filter e NA -------------------------------------------------------------

arrange(imdb, desc(orcamento))

imdb |> 
  arrange(desc(orcamento)) |> 
  View()

imdb |> 
  filter(orcamento > 0)

imdb |> 
  filter(orcamento > -10000000000)
# o número é quase igual nos dois casos. como isso é possível?

imdb |> 
  filter(orcamento > -Inf)

# o filter exclui os orçamentos com NA!

# o que a gente pode fazer, então?

# incluir nos nossos filtrous ou "OU se é NA"

filmes_sem_orcamento <- imdb |> 
  filter(is.na(orcamento))

is.na(NA)
# pra gente entender o is.na é como se fosse fazer
# x <- 10
# x == NA
# isso conceitualmente porque esse comando não funciona por convenção
# do R
# o jeito correto de verificar se algo é NA é fazer is.na(x)

is.na(c(1, 2, 3, NA, 5))

imdb |> 
  filter(orcamento > 1000000 | is.na(orcamento))
# pra garantir que os NA's fiquem esse é o único jeito

# podemos fazer o nosso próprio drop_na se a gente quiser

imdb_com_orcamento <- imdb |> 
  filter(!is.na(orcamento))

#igual da
#imdb_com_orcamento <- imdb |> 
# drop_na(orcamento)


# Mais exemplos de filtro -------------------------------------------------

# DENTRE

imdb |> 
  filter(direcao == "Steven Spielberg")

imdb |> 
  filter(!(direcao == "Steven Spielberg"))

# teria algum jeito de eu fazer uma lista de diretos que eu quer manter
# ou remover?

# é pra isso que serve o DENTRE ou %in%

imdb |> 
  filter(direcao %in% c("Steven Spielberg", "Martin Scorsese",
                        "Quentin Tarantino", "Greta Gerwig")) |> 
  View()

imdb |> 
  filter(ano %in% c(1931, 1956, 2010))

# o %in% é bem parecido com o === só que ele verifica o pertencimentos
# dos elementos da coluna a um certo conjunto (que aparece a direita)
# do %in%

imdb |> 
  filter(
    !(generos %in% c("Drama", "Comedy"))
  ) |> 
  View()

imdb |> 
  filter(
    !(generos %in% c("Drama", "Comedy") | ano > 2010
  )
  ) |> 
  View()

# Filter texto vs. numeros ------------------------------------------------

imdb |> 
  filter(
    ano > 2010
  )

imdb |> 
  filter(data_lancamento >= "2020-03-01",
         data_lancamento <= "2020-03-31") |> 
  View()
# pra datas e números então o %in% não é necessário

# pra textos ele é útil mas também não resolve todos os problemas

imdb |> 
  filter(
    generos == "Comedy"
  )

imdb |> 
  filter(
    generos %in% c("Comedy", "Comedy, Horror", "Comeddy, Horror, Drama")
  )

# como eu poderia procurar "comedia" em qualquer posição nos generos?

library(stringr)

str_detect(c("banana", "ana clara", "ilana", "fernando"), "ana")

imdb |> 
  filter(
    str_detect(generos, "Comedy")
  ) |> 
  View()
# o str_detect verifica se a string de segundo está contida nas células da coluna
# que a gente passa no lado esquerdo do str_detect

imdb |> 
  filter(
    generos == "Comedy"
  ) |> 
  View()
# o == faz uma correspondência literal

# dentro do filter(base_de_dados, ????) ou base_de_dados |> filter(????) eu posso colocar 
# qualquer comando de R que vire um vetor de TRUE e FALSE um pra cada linha da base
# na maior parte dos casos vai servir pra mim usar comparações lógicas
# ==,>=, <=, >, <
# | (OU), & (E, ou ',' se for mais simples), ! (NÃO), %in% (DENTRE)
# mas, como tudo que retorna TRUE ou FALSE serve pro filter, o céu é o limite, eu 
# se der TRUE ou FALSE numa função eu posso escrever no filter:
# is.na, str_detect são exemplos de funções que retornam TRUE ou FALSE


# Misturando filter com outras coisas -------------------------------------

menores_bilheterias_de_filme <- imdb |> 
  arrange(receita) |> 
  head(5) |> 
  filter(receita > 100000, ano > 2000) 

# é a mesma coisa que fazer

head(arrange(imdb, receita), 5)
# opcao 1

imbd_receita_maior_que_100k <- filter(imdb, receita > 100000)
imdb_receita_ordenada <- arrange(imbd_receita_maior_que_100k, receita)
menores_5_receitas <- head(imdb_receita_ordenada, 5)


maiores_orcamentos_anos_90 <- imdb |> 
  filter(ano >= 1990, ano <= 1999) |> 
  arrange(desc(orcamento)) |> 
  head(10) |> 
  select(titulo, orcamento)

maiores_bilheterias_anos_90 <- imdb |> 
  filter(ano >= 1990, ano <= 1999) |> 
  arrange(desc(receita)) |> 
  head(10) |> 
  select(titulo, receita)

# a ordem é muito importante:

imdb |> 
  arrange(desc(receita)) |> 
  head(50) |> 
  filter(ano < 2000)
# quais filme dentre as 50 maiores bilheterias da histórias são de antes de 2000

imdb |> 
  filter(ano < 2000) |> 
  arrange(desc(receita)) |> 
  head(50)
# os 50 filmes de maior bilheteria lançados antes de 2000

imdb |> 
  select(titulo, receita) |> 
  filter(ano < 2000)
# isso dá erro! o select jogou o ano fora

imdb |> 
  filter(ano < 2000) |> 
  select(titulo, receita) 
# agora dá certo, no passo do filter a tabela que está entrando de fato tem a coluna ano
# e o select consegue selecionar o que ele quis
  
