%% Orthogonal Least Squares - OLS
indice = zeros(M,1);    %Retorna os índices dos elementos mais impactantes
ite = 1:M;              %Possui todos os índices da matriz de parâmetros
w = zeros(N,M);         %Matriz ortogonalizada
a = eye(M);             %Triangular superior que auxilia na ortogonalização
ERR = zeros(M,1);       %Taxa de redução de erro
custo = zeros(M,1);     %Variável auxiliar para o ERR, é basicamente um ERR temporário
tol = 0.01;                %Tolerância, o código para quando 1 - sum(ERR) < tol ou depois de varrer todos os parâmetros


%Ortogonalização de P
%o objetivo é reduzir a quantidade de parâmetros, então cada coluna de W é calculada testando todos os parâmetros disponíveis e utilizar apenas o melhor
for i = ite
    % Alguma coisa aqui
    w(:, 1) = p(:, i);
    custo(i) = power(dot(output, w(:,1)), 2) / (dot(output, output) * dot(w(:, 1), w(:, 1)));
end
%Identificação do melor parâmetro
[ERR(1), indice(1)] = max(custo);
%Remoção do melhor parâmetro do indice de busca
ite(ite == indice(1)) =[];
%Ajuste de W para o melhor parâmetro
w(:,1) = p(:,indice(1));


%A mesma ideia, porém o valor atual de W depende dos valores anteriores
for ii = 2:M
    %Zerando o custo para garantir uma leitura correta
    custo = zeros(M,1);
    for i = ite
        %Cálculo da Matriz A
        for j = 1:ii-1
            a(j,ii) = dot(p(:,i), w(:,j)) / dot(w(:,j), w(:,j));
        end
        
        temp = zeros(N,1);
        for k = 1:ii-1
            temp = temp - a(k,ii).*w(:,k);
        end
        %Cálculo de W
        w(:,ii) = p(:,i) + temp;
        %Cálculo do ERR
        custo(i) = dot(output,w(:,ii))^2/(dot(output,output)*dot(w(:,ii),w(:,ii)));
    end
    %Identificação do melhor parâmetro
    [ERR(ii), indice(ii)] = max(custo);
    %Remoção do melhor parâmetro do indice de busca
    ite(ite == indice(ii)) =[];
    %Ajuste de A para o melhor parâmetro
    for j = 1:ii-1
    	a(j,ii) = dot(p(:,indice(ii)),w(:,j))/dot(w(:,j),w(:,j));
    end
    
    temp = zeros(N,1);
    for k = 1:ii-1
        temp = temp - a(k,ii).*w(:,k); 
    end
    %Ajuste de W para o melhor parâmetro    
    w(:,ii) = p(:,indice(ii)) +temp;
    
    %Código de parada
    ESR = 1 - sum(ERR);
    if ESR < tol
        break;
    end
end

M_linha = ii;               %Caso atinja a tolerância, ii < M
teta = zeros(M_linha,1);    %Então as matrizes devem ser recalculadas, para evitar colunas com zeros
g = zeros(M_linha,1);
p_linha = zeros(N,M_linha);

for i = 1:M_linha
    p_linha(:,i) = p(:,indice(i));
end

%Parâmetros g
for i =1:M_linha
    g(i) = dot(output(:),w(:,i))/dot(w(:,i),w(:,i));
end

%Cálculo do Teta
teta(M_linha) = g(M_linha);
for i =M_linha-1:-1:1
    temp = 0;
    
    for j = i+1:M_linha
        temp = temp - a(i,j).*teta(j); 
    end
    
    teta(i) = g(i) + temp;
end


for i = 1:M_linha
    
end
clear a custo g i ii ite j k temp