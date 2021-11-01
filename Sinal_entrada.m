%% Sinal APRBS
N = 1000;

Ts = 50;
min_u = 1;
max_u = 5;


entrada = zeros(N,1);
saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

for i = 2:N
    if ~mod(i,Ts)
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        entrada(i) = entrada(i-1);
    end
end
%%
for i = Ts+1:N
    saida(i) = 0.1*(entrada(i-1))+0.9*saida(i-1)+0.01*saida(i-1)*entrada(i-1)+ruido(i);
end

input = entrada(1:N);
output = saida(1:N);
%% Validação

entrada = zeros(N,1);
saida = zeros(N,1);
ruido = normrnd(0,0.05,N,1);

for i = 2:N
    if ~mod(i,Ts)
        amp = (max_u-min_u)*rand()+min_u;
        entrada(i) = amp;
    else
        entrada(i) = entrada(i-1);
    end
end
%%
for i = Ts+1:N
    saida(i) = 0.1*(entrada(i-1))+0.9*saida(i-1)+0.01*saida(i-1)*entrada(i-1)+ruido(i);
end


inp_val = entrada(1:N);
out_val = saida(1:N);

clear i amp Ts ruido entrada saida min_u max_u