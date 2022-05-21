%% RLS
 index = 1;
Sinal_entrada;

ny = 2;
nu = 1;
M = ny + nu;

p = zeros(N,M);
erro = zeros(N,1);
ganho = zeros(N,M);
teta = zeros(M,1);
P = 10^4*eye(M);

for i = 1:N
    
    %Passo 2: Atualizar a matriz \Psi 
    pos = 1;
    for j = 1:ny
        if i-j > 0
            p(i,pos) = -output(i-j);
        else
            p(i,pos) = 0;
        end
        pos = pos + 1;
    end
    
    for j = 1:nu
        if i-j > 0
            p(i,pos) = input(i-j);
        else
            p(i,pos) = 0;
        end
        
        pos = pos + 1;
    end
        
    %Passo 3: Calcular o Erro
    erro(i) = output(i)-p(i,:)*teta;
    %Passo 4: Calcular o ganho
    k = P*p(i,:)'/(1 + p(i,:)*P*p(i,:)');
    ganho(i,:) = k;
    %Passo 5: Atualizar teta
    teta = teta + k*erro(i);
    %Passo 6: Calcular
    P = (P - k*p(i,:)*P);
end
model = zeros(N,1);
y_cha = zeros(N,N);
p_1 = zeros(N,M);
RMSE = zeros(N,1);
for i = 1:ny 
    for j = i:N
        y_cha(i,j) = out_val(j);
    end
end

for i = ny+1:N
    for j = i:N
        pos = 1;
        for k1 = 1:ny
            p_1(j,pos) = -y_cha(i-k1,j-k1);
            pos = pos+1;
        end
        
        for k1 = 1:nu
            p_1(j,pos) = inp_val(j-k1);
            pos = pos+1;
        end
        
    end
    
    for j = i:N
        y_cha(i,j) = p_1(j,:)*teta;
    end
    
end
y_cha = y_cha(ny+1:N,:);

% Cálculo do RMSE por k passos tomados
for i = 1:N-ny
    RMSE(i) = sqrt(sum(power(out_val - y_cha(i,:)',2))/N);
end

%%
k = 100;
%Gráficos de Validação
lim_inf = 2+k;
lim_sup = N;

figure
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(k,lim_inf:lim_sup)')
title('Sinal diferença')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(k,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Saída Real x Saída predita')
sgtitle('Validação')

%%

sinal_controle = zeros(N+1,1);
out_cont = zeros(N,1);
out_cont(1) = 0;
sinal_controle(1) = v(2)/teta(3);

out_cont(2) = teta(3)*sinal_controle(1);
sinal_controle(2) = (v(3) + teta(1)*out_cont(2))/teta(3);

for i = 3:N
    out_cont(i) = -teta(1)*out_cont(i-1) - teta(2)*out_cont(i-2) + teta(3)*sinal_controle(i-1);
    sinal_controle(i) = (v(i+1) + teta(1)*out_cont(i)+teta(2)*out_cont(i))/teta(3);
end



 plot(out_cont)
% xlabel("k")
% ylabel("y(k)")

ruido = normrnd(0,0.05,N+1,1);
saida = Planta(sinal_controle,ruido,N,index);

figure
plot(saida)
xlabel("k")
ylabel("y(k)")


clear i j pos p P k M M_linha