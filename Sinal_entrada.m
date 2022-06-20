%% Sinal APRBS
N = 1000;   %Total de amostras

%Seleção de planta
%index
%Planta Linear = 1
%Planta Não Linear Fraca = 2
%Planta Não Linear Média = 3
%Planta Não Linear Forte = 4

Th = 10;    %Hold time(tempo de atualização)
if index == 4
    min_u = 0.1;  %Amplitude mínima da entrada
    max_u = 1;  %Amplitude máxima da entrada    
elseif index == 3
    min_u = -15;  %Amplitude mínima da entrada
    max_u = 15;  %Amplitude máxima da entrada
else
    min_u = -10;  %Amplitude mínima da entrada
    max_u = 10;  %Amplitude máxima da entrada
end


%Pré-alocação de memória
entrada = zeros(N,1);
ruido = normrnd(0,0.01,N,1);
% ruido = zeros(N,1);

T = 5;
%Geração do sinal de entrada
for i = Th:N
    
    if ~mod(i,T)   
        %Amplitude randômica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
        T = (fix(mod(rand(1)*10,10))+1)*Th;
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
ruido = normrnd(0,0.01,N,1);
T = 5;

%Geração do sinal de entrada
for i = Th:N
    %Atualização a cada Ts
    if ~mod(i,T)
        %Amplitude randômica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
        T = (fix(mod(rand(1)*10,10))+1)*Th;
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