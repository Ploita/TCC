%% NARMAX Validação

%Estabelecendo a matriz de parâmetros com M colunas
p_1 = [zeros(N,M - 1) ones(N,1)];

for i = min1:N
    pos = 1;
    for j =1:ny
        p_1(i,pos) = out_val(i-j);
        pos = pos+1;
    end

    for j =1:nu
        p_1(i,pos) = inp_val(i-j);
        pos = pos+1;
    end
    
    for j =1:ne
        p_1(i,pos) = erro(i-j);
        pos = pos+1;
    end
    
    %Matriz de regressão (2ª ordem)
    if l>=2
        for j = 1:n
            for k = j:n 
                p_1(i,pos) = p_1(i,j)*p_1(i,k);
                pos = pos +1;
            end
        end
    end
    
    %Matriz de regressão (3ª ordem)
    if l >=3
       for j =1:n
            for k = j:n
                for ll = k:n
                    p_1(i,pos) = p_1(i,j)*p_1(i,k)*p_1(i,ll);
                    pos = pos+1;
                end
            end
        end 
    end
end
%Matriz de parâmetros com M_linha colunas
p_val = zeros(N,M_linha);

for i = 1:M_linha
    p_val(:,i) = p_1(:,indice(i));
end

RMSE = sqrt(sum(power(output - p_linha*teta,2))/N);
RMSE_val = sqrt(sum(power(out_val - p_val*teta,2))/N);

clear i j k ll p_1
