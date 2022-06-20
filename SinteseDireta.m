%% Controle - Método da Síntese Direta
out_cont = zeros(N,1);
sinal_controle = zeros(N,1);
erro = zeros(N,1);

y = zeros(N,1);
h_1 = zeros(N,1);
h_2 = zeros(N,1);
teta = zeros(1,3);
u_hist = zeros(6,1);
s_hist = zeros(6,1);
ruido = normrnd(0,0.05,N,1);

Na1 = zeros(N,1);
Na2 = zeros(N,1);
Nb0 = zeros(N,1);
lambda = 1;
P = 10^3*eye(M);
v = [zeros(1,4) ones(1,300) 2*ones(1,300) 1.5*ones(1,396)];

teta = teta_model;

Na1(3) = teta(1);
Na2(3) = teta(2);
Nb0(3) = teta(3);

num = [Nb0(3) 0];
den = [1 -Na2(3) -Na1(3)];
G = tf(num,den,-1);

num = [0.50057 0.2869];
den = [1 -0.4144 0.20189];
G0 = tf(num,den,-1);

for i = 3:N
    
    %Resposta da planta
%     if i > 1
        if index == 1
            y(i) = 0.4*sinal_controle(i-1) + 0.8*y(i-1);% + ruido(i);
            
        elseif index == 2
            y(i) = 0.1*(sinal_controle(i-1))+0.9*y(i-1)+0.01*y(i-1)*sinal_controle(i-1);%+ruido(i);
            
        elseif index == 3
            y(i) = -0.8*y(i-1)+0.2*sinal_controle(i-1)+0.18*y(i-1)^2;% + ruido(i);
            
        elseif index == 4
            if i ==2
                y(2) = tanh(3.2*tanh(-0.5*y(1)+sinal_controle(1)));%+ruido(2);
            else
                h_1(i) = tanh(-0.5*y(i-1)+sinal_controle(i-1));
                h_2(i) = tanh(1.3*y(i-2)+sinal_controle(i-2));
                y(i) = tanh(3.2*h_1(i)-h_2(i)) + ruido(i);
            end
        end
%     end
    
    %Mínimos Quadrados Recursivos
    
    %Matriz de regressão
%     if i > 2
        p = [-y(i-1) -y(i-2) sinal_controle(i-1)];
%     elseif i > 1
%         p = [-y(i-1) 0 sinal_controle(i-1)];
%     else
%         p = [0 0 0];
%     end
    %Cálculo do erro
    yhat = p*teta';
    erro(i) = output(i) - yhat;
    
    %Atualização do ganho
    ganho = (P*p')/(1 + p*P*p');
    %Atualização de teta
    teta = teta + ganho'*erro(i);
    %Atualização de P
    P = P - ganho*(1 + p*P*p')*(ganho');
    %Registro da evolução do teta
    Na1(i) = teta(1);
    Na2(i) = teta(2);
    Nb0(i) = teta(3);
    
    
    %Atualizar o modelo com o novo teta 
    num1 = [Nb0(i) 0];
    den1 = [1 -Na2(i) -Na1(i)];
    G = tf(num1,den1,-1);
    
    %Atualização do Controlador
    C = G0/(G*(1-G0));
    [num, den] = tfdata(C);
    num = cell2mat(num);
    den = cell2mat(den);
    
    %Sinal de erro
    for j = 0:5
        if i-j > 0
            u_hist(j+1) = v(i-j)-y(i-j);
            s_hist(j+1) = sinal_controle(i-j);
        else
            u_hist(j+1) = 0;
            s_hist(j+1) = 0;
        end
    end
     
    %Ação de Controle
     sinal_controle(i) = (num*u_hist - den*s_hist); % ALGUM BO AQUI
%      sinal_controle(i) = (num*u_hist - den(2:6)*s_hist(2:6))/den(1);  
%      sinal_controle(i) = sinal_controle(i-1);
   
   
end

figure
plot(y)
xlabel("k")
ylabel("y(k)")
hold
plot(v(1:1000))
