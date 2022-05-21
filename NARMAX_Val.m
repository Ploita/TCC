%% NARMAX Validação
%Validação Simulação k passos à frente
%Tem que ver esse código RMSE(LS)<RMSE(OLS)
RMSE = zeros(N-min1+1,1);
p_1 = zeros(N,M);
y_cha = zeros(N,N); %\hat{y} sendo a resposta estimada pela previsão 



%Para cada atraso a matriz de y_cha recebe uma coluna de out_val
%Um mero ajuste pra facilitar a implementação
for i = 1:ny 
    for j = i:N
        y_cha(i,j) = out_val(j);
    end
end

for i = ny+1:N
for j = i:N 
    pos = 1;
    for k1 = 1:ny
        p_1(j,pos) = y_cha(i-k1,j-k1);
        pos = pos+1;
    end

    for k1 = 1:nu
        p_1(j,pos) = inp_val(j-k1);
        pos = pos+1;
    end
    
    for k1 = 1:ne
        p_1(j,pos) = erro(j-k1);
        pos = pos+1;
    end
    
    %Matriz de regressão (2ª ordem)
    if l>=2
        for k1 = 1:n
            for k2 = k1:n
                p_1(j,pos) = p_1(j,k1)*p_1(j,k2);
                pos = pos +1;
            end
        end
    end
    
    %Matriz de regressão (3ª ordem)
    if l >=3
       for k1 =1:n
            for k2 = k1:n
                for k3 = k2:n
                    p_1(j,pos) = p_1(j,k1)*p_1(j,k2)*p_1(j,k3);
                    pos = pos+1;
                end
            end
        end 
    end
end


p_lin = zeros(N,M_linha);

for j = 1:M_linha
    p_lin(:,j) = p_1(:,indice(j));
end


for j = i:N
    y_cha(i,j) = p_lin(j,:)*teta;
end

end
%%
y_cha = y_cha(ny+1:N,:);

% Cálculo do RMSE por k passos tomados
for i = 1:N-ny
    RMSE(i) = sqrt(sum(power(out_val - y_cha(i,:)',2))/N);
end

clear i j k1 k2 k3 pos