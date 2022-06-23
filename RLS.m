%% RLS
Sinal_entrada;
ny = 2;
nu = 1;
M = ny + nu; %Isso não vai mais ser genérico

p = zeros(M,1);
erro = zeros(N,1);
teta_model = 0.01*ones(1,M);
a1 = zeros(N,1);
a2 = zeros(N,1);
b0 = zeros(N,1);
P = 10^3*eye(M);

for i = 3:N
    
    %Matriz de regressão
    p = [-output(i-1) -output(i-2) input(i-1)];
    
    %Cálculo do erro
    yhat = p*teta_model';
    erro(i) = output(i) - yhat;
    
    %Atualização do ganho
    ganho = (P*p')/(1 + p*P*p');
    %Atualização de teta
    teta_model = teta_model + ganho'*erro(i);
    %Atualização de P
    P = P - ganho*(1 + p*P*p')*(ganho');
    %Registro da evolução do teta
    a1(i) = teta_model(1);
    a2(i) = teta_model(2);
    b0(i) = teta_model(3);
    
end
%%
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
        p_1(j,:) = [-y_cha(i-1,j-1) -y_cha(i-2,j-2) inp_val(j-1)];
        y_cha(i,j) = p_1(j,:)*teta_model';
    end
end
y_cha = y_cha(ny+1:N,:);

% Cálculo do RMSE por k passos tomados
for i = 1:N-ny
    RMSE(i) = sqrt(sum(power(out_val - y_cha(i,:)',2))/N);
end

%%
rho = 10;
%Gráficos de Validação
lim_inf = 2+rho;
lim_sup = N;

figure
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(rho,lim_inf:lim_sup)')
title('Sinal diferença')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(rho,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Saída Real x Saída predita')
sgtitle('Validação')

%% Controle
%Pré-alocação de memória
%Sinal de referência
v = [zeros(1,5) 0.9*ones(1,300) 0.25*ones(1,300) 0.75*ones(1,395)];
sinal_controle = zeros(N,1);
du = zeros(N,1);
erro = zeros(N,1);
ers = zeros(N,1);
y = zeros(N,1);
h_1 = zeros(N,1);
h_2 = zeros(N,1);
%ruído com média 0 e variância 0.01
ruido = normrnd(0,0.01,N,1);
P = 5000*eye(4);
%chute inicial de teta
teta = 0.05*ones(1,4);
r1 = ones(N,1);
s0 = ones(N,1);
s1 = ones(N,1);
s2 = ones(N,1);
%Fim da pré-alocação


%Definição do pólo
p1 = 0.15;


if index == 1
    y(1) = ruido(1);
    y(2) = ruido(2) - y(1);
    y(3) = ruido(3) - y(2);
    
elseif index == 2
    y(1) = ruido(1);
    y(2) = ruido(2);
    y(3) = ruido(3);

elseif index == 3
    y(1) = ruido(1);
    y(2) = -0.8*y(1) + 0.18*y(1)^2 + ruido(2);
    y(3) = -0.8*y(2) + 0.18*y(2)^2 + ruido(3);
    
else
    y(1) = ruido(1);
    y(2) = tanh(3.2*tanh(-0.5*y(1))) + ruido(2);
    h_1(3) = tanh(-0.5*y(2));
    h_2(3) = tanh(1.3*y(1));
    y(3) = tanh(3.2*h_1(3)-h_2(3)) + ruido(3);
end

for i = 4:N
    %Medição da planta
    if index == 1
        y(i) = 0.4*sinal_controle(i-1) + 0.8*y(i-1) + ruido(i);
        
    elseif index == 2
        y(i) = 0.1*(sinal_controle(i-1))+0.9*y(i-1)+0.01*y(i-1)*sinal_controle(i-1)+ruido(i);
        
    elseif index == 3
        y(i) = -0.8*y(i-1)+0.2*sinal_controle(i-1)+0.18*y(i-1)^2 + ruido(i);
        
    elseif index == 4
        h_1(i) = tanh(-0.5*y(i-1)+sinal_controle(i-1));
        h_2(i) = tanh(1.3*y(i-2)+sinal_controle(i-2));
        y(i) = tanh(3.2*h_1(i)-h_2(i)) + ruido(i);
    end
    
    %Mínimos Quadrados Recursivos
    %Matriz de regressão
    %O cálculo de u_barra e y_barra estão inseridos diretamente na matriz
    p = [-(1-p1)*du(i-2) (y(i)-y(i-1)) (y(i-1)-y(i-2)) (y(i-2)-y(i-3))];
    %Cálculo do erro
    yhat = p*teta';
    ers(i) = (1-p1)*du(i-1) - yhat;
    %Atualização do ganho
    ganho = (P*p')/(1 + p*P*p');
    %Atualização de teta
    teta = teta + ganho'*ers(i);
    %Atualização de P
    P = P - ganho*(1 + p*P*p')*(ganho');
    
    %Registro da evolução do teta
    r1(i) = teta(1);
    s0(i) = teta(2);
    s1(i) = teta(3);
    s2(i) = teta(4);
    
    %RST Alocação de polos incremental direta
    erro(i) = v(i) - y(i);
    du(i) = -r1(i)*du(i-1) + s0(i)*erro(i) + s1(i)*erro(i-1)+ s2(i)*erro(i-2);
    %ação de controle
    sinal_controle(i) = du(i) + sinal_controle(i-1);
    
end

% figure
% plot(y)
% xlabel("k")
% ylabel("y(k)")
% hold on
% plot(v(1:1000))
% hold off
%%
figure

out_cont = Planta(sinal_controle,ruido,N,index);
plot(out_cont)
xlabel("k")
ylabel("y(k)")
hold on
plot(v(1:1000))
hold off