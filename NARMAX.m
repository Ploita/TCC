%% NARMAX

l = 2; %grau do polimônio máx 3
ny = 1; %ordem da saída
nu = 1; %ordem da entrada
ne = 1; %ordem do resíduo
n = ny + nu + ne;
M  = factorial(l+n)/(factorial(l)*factorial(n)); %Quantidade de termos para representar o problema

erro = normrnd(0,0.05,N,1); %sinal erro
min1 = max([ny nu ne])+1;
p = [zeros(N,M - 1) ones(N,1)];

    
%Estabelecendo a matriz de regressão
%saída, entrada, ruído ou uma combinação destes, além de um termo constante
for i = min1:N
    pos = 1;
    for j =1:ny
        p(i,pos) = output(i-j);
        pos = pos+1;
    end

    for j =1:nu
        p(i,pos) = input(i-j);
        pos = pos+1;
    end
        
    for j =1:ne
        p(i,pos) = erro(i-j);
        pos = pos+1;
    end
    
    %Matriz de regressão (2ª ordem)
    if l>=2
        for j = 1:n
            for k = j:n 
                p(i,pos) = p(i,j)*p(i,k);
                pos = pos +1;
            end
        end
    end
    
    %Matriz de regressão (3ª ordem)
    if l >=3
       for j =1:n
            for k = j:n
                for ll = k:n
                    p(i,pos) = p(i,j)*p(i,k)*p(i,ll);
                    pos = pos+1;
                end
            end
        end 
    end 
end

clear i j k ll pos