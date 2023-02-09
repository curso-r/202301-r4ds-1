
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
