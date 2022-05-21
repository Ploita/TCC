%% Sinal APRBS
N = 1000;   %Total de amostras

%Sele��o de planta
%index:
%Planta Linear = 1
%Planta N�o Linear Fraca = 2
%Planta N�o Linear M�dia = 3
%Planta N�o Linear Forte = 4

Ts = 10;    %Per�odo de amostragem (tempo de atualiza��o)
min_u = 1;  %Amplitude m�nima da entrada
max_u = 5;  %Amplitude m�xima da entrada

%Pr�-aloca��o de mem�ria
entrada = zeros(N,1);
% saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

%Gera��o do sinal de entrada
for i = 2:N
    %Atualiza��o a cada Ts
    if ~mod(i,Ts)   
        %Amplitude rand�mica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        %Manuten��o da �ltima amplitude
        entrada(i) = entrada(i-1);
    end
end

%C�lculo da sa�da da planta
saida = Planta(entrada,ruido,N,index);
input = entrada(1:N);
output = saida(1:N);

%% Valida��o
%Pr�-aloca��o de mem�ria
entrada = zeros(N,1);
% saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

%Gera��o do sinal de entrada
for i = 2:N
    %Atualiza��o a cada Ts
    if ~mod(i,Ts)
        %Amplitude rand�mica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        %Manuten��o da �ltima amplitude
        entrada(i) = entrada(i-1);
    end
end

%C�lculo da sa�da da planta
saida = Planta(entrada,ruido,N,index);

inp_val = entrada(1:N);
out_val = saida(1:N);

clear i amp Ts ruido entrada saida min_u max_u