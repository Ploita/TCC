%% Sinal APRBS
N = 1000;   %Total de amostras

%Seleção de planta
%index:
%Planta Linear = 1
%Planta Não Linear Fraca = 2
%Planta Não Linear Média = 3
%Planta Não Linear Forte = 4

Ts = 10;    %Período de amostragem (tempo de atualização)
min_u = 1;  %Amplitude mínima da entrada
max_u = 5;  %Amplitude máxima da entrada

%Pré-alocação de memória
entrada = zeros(N,1);
% saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

%Geração do sinal de entrada
for i = 2:N
    %Atualização a cada Ts
    if ~mod(i,Ts)   
        %Amplitude randômica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        %Manutenção da última amplitude
        entrada(i) = entrada(i-1);
    end
end

%Cálculo da saída da planta
saida = Planta(entrada,ruido,N,index);
input = entrada(1:N);
output = saida(1:N);

%% Validação
%Pré-alocação de memória
entrada = zeros(N,1);
% saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

%Geração do sinal de entrada
for i = 2:N
    %Atualização a cada Ts
    if ~mod(i,Ts)
        %Amplitude randômica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        %Manutenção da última amplitude
        entrada(i) = entrada(i-1);
    end
end

%Cálculo da saída da planta
saida = Planta(entrada,ruido,N,index);

inp_val = entrada(1:N);
out_val = saida(1:N);

clear i amp Ts ruido entrada saida min_u max_u