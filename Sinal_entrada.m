%% Sinal APRBS
N = 1000;   %Total de amostras

%Sele��o de planta
%index
%Planta Linear = 1
%Planta N�o Linear Fraca = 2
%Planta N�o Linear M�dia = 3
%Planta N�o Linear Forte = 4

Th = 10;    %Hold time(tempo de atualiza��o)
if index == 4
    min_u = 0.1;  %Amplitude m�nima da entrada
    max_u = 1;  %Amplitude m�xima da entrada    
elseif index == 3
    min_u = -15;  %Amplitude m�nima da entrada
    max_u = 15;  %Amplitude m�xima da entrada
else
    min_u = -10;  %Amplitude m�nima da entrada
    max_u = 10;  %Amplitude m�xima da entrada
end


%Pr�-aloca��o de mem�ria
entrada = zeros(N,1);
ruido = normrnd(0,0.01,N,1);
% ruido = zeros(N,1);

T = 5;
%Gera��o do sinal de entrada
for i = Th:N
    
    if ~mod(i,T)   
        %Amplitude rand�mica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
        T = (fix(mod(rand(1)*10,10))+1)*Th;
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
ruido = normrnd(0,0.01,N,1);
T = 5;

%Gera��o do sinal de entrada
for i = Th:N
    %Atualiza��o a cada Ts
    if ~mod(i,T)
        %Amplitude rand�mica dentro do limite definido
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
        T = (fix(mod(rand(1)*10,10))+1)*Th;
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