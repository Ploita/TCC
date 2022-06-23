# TCC - Identificação e controle de sistemas não lineares
Códigos em MATLAB utilizados no meu TCC

# Códigos Base

Os códigos que utilizam os demais códigos para realizar a identificação e controle
  
## Base.mlx

Realiza a identificação e controle sob a arquitetura NARMAX com uso de MQO, MQE ou MQ, a previsão de $\rho$ passos à frente do modelo pode ser ajustada alterando o valor de $\rho$ e por fim a planta é controlada pelo método _Feedback Linearization_
  
## RLS  

Realiza a identificação e controle sob a arquitetura ARX com uso de MQR, a previsão de $\rho$ passos à frente do modelo pode ser ajustada alterando o valor de $\rho$ e por fim a planta é controlada pelo método alocação de polos incremental direta  
  
## NonLinearityTest

Realiza o teste de não linearidade, pode ser ajustado junto com o arquivo 'planta.m' para gerar os teste de não linearidade

## Resumo

Resume as plotagens utilizadas no trabalho

# Códigos auxiliares

## Controle

Controle via _Feedback Linearization_

## NARMAX

Estuturação da matriz de parâmetros

## NARMAX_VAL

Estuturação da matriz de parâmetros considerando a previsão do modelo

## Planta

Calcula a saída da planta dados os valores de entrada, ruído e planta utilizada

## Plot_treino

Plota o gráfico de treino do modelo

## Plot_val

Plota o gráfico de validação do modelo

## PrintModel

Imprime o modelo NARMAX calculado

## PrintModelRLS

Plota o gráfico de evoluçaõ do $\theta$, imprime o modelo ARX calculado, plota o gráfico de validação do modelo, plota o gráfico de evolução dos polinômios R e S, imprime os polinômios, plota a saída controlada e a ação de controle

## Sinal_entrada

Gera o sinal APRBS

## OLS

Calcula os parâmetros NARMAX via mínimos quadros ortogonais

## ELS

Calcula os parâmetros NARMAX via mínimos quadros estendidos

## LS

Calcula os parâmetros NARMAX via mínimos quadros

## Figuras

Plota os gráficos da seção 3.1

## NewtonRaphson

Código importado para cálculo da ação de controle via _Feedback Linearization_ no caso não linear forte
