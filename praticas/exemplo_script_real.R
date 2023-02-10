# Importação de dados. Aqui vou ler o banco

dados = read.csv("arquivo.csv")

# O código abaixo remove a primeira coluna de
# "dados" e salva em "novos_dados"

novos_dados = dados[,-1]

# O código abaixo salva "novos_dados" em um
# arquivo .csv

write.csv(novos_dados, "novos_dados.csv")
