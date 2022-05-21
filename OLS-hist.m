%OLS
min1 = max([ny nu ne])+1;
teta = ones(1,M);  %parâmetros do modelo
p = [zeros(N,M - 1) ones(N,1)];
w = zeros(N,M);
a = eye(M);
g = zeros(M,1);
residuo = zeros(N,1);
ERR = zeros(M,1); 

%Estabelecendo a matriz de regressão

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
    
    %erro(i) = output(i) - dot(p(i,:),teta) ;
    
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

%(P'*P)^-1*P'*y = teta

%Ortogonalizando a matriz de regressores
w(:,1) = p(:,1);

for j=2:M
    for k=1:j-1 
        a(k,j) = dot(p(:,j),w(:,k))/dot(w(:,k),w(:,k));
        for i =1:N
            w(i,j) = p(i,j) - dot(a(k,j),w(i,k));
        end
    end
end

%Parâmetros g
for i =1:M
    g(i) = dot(output(:),w(:,i))/dot(w(:,i),w(:,i));
end

%Cálculo do Teta
teta(M) = g(M);
for i =M-1:-1:1
    teta(i) = g(i) - dot(a(i,i+1:M),teta(i+1:M));
end

%Cálculo do ERR
for i =1:M
    ERR(i) = g(i)^2*dot(w(:,i),w(:,i))/(dot(output(:),output(:)));
    %ERR(i) = dot(output,w(:,i))^2/(dot(output,output)*dot(w(:,i),w(:,i)));
end


%Cálculo do ESR
ESR = 1 - sum(ERR); 