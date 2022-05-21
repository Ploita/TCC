%% Orthogonal Least Squares - OLS
indice = zeros(M,1);    %Retorna os �ndices dos elementos mais impactantes
ite = 1:M;              %Possui todos os �ndices da matriz de par�metros
w = zeros(N,M);         %Matriz ortogonalizada
a = eye(M);             %Triangular superior que auxilia na ortogonaliza��o
ERR = zeros(M,1);       %Taxa de redu��o de erro
custo = zeros(M,1);     %Vari�vel auxiliar para o ERR, � basicamente um ERR tempor�rio
tol = 0.01;                %Toler�ncia, o c�digo para quando 1 - sum(ERR) < tol ou depois de varrer todos os par�metros


%Ortogonaliza��o de P
%o objetivo � reduzir a quantidade de par�metros, ent�o cada coluna de W � calculada testando todos os par�metros dispon�veis e utilizar apenas o melhor
for i = ite
    % Alguma coisa aqui
    w(:, 1) = p(:, i);
    custo(i) = power(dot(output, w(:,1)), 2) / (dot(output, output) * dot(w(:, 1), w(:, 1)));
end
%Identifica��o do melor par�metro
[ERR(1), indice(1)] = max(custo);
%Remo��o do melhor par�metro do indice de busca
ite(ite == indice(1)) =[];
%Ajuste de W para o melhor par�metro
w(:,1) = p(:,indice(1));


%A mesma ideia, por�m o valor atual de W depende dos valores anteriores
for ii = 2:M
    %Zerando o custo para garantir uma leitura correta
    custo = zeros(M,1);
    for i = ite
        %C�lculo da Matriz A
        for j = 1:ii-1
            a(j,ii) = dot(p(:,i), w(:,j)) / dot(w(:,j), w(:,j));
        end
        
        temp = zeros(N,1);
        for k = 1:ii-1
            temp = temp - a(k,ii).*w(:,k);
        end
        %C�lculo de W
        w(:,ii) = p(:,i) + temp;
        %C�lculo do ERR
        custo(i) = dot(output,w(:,ii))^2/(dot(output,output)*dot(w(:,ii),w(:,ii)));
    end
    %Identifica��o do melhor par�metro
    [ERR(ii), indice(ii)] = max(custo);
    %Remo��o do melhor par�metro do indice de busca
    ite(ite == indice(ii)) =[];
    %Ajuste de A para o melhor par�metro
    for j = 1:ii-1
    	a(j,ii) = dot(p(:,indice(ii)),w(:,j))/dot(w(:,j),w(:,j));
    end
    
    temp = zeros(N,1);
    for k = 1:ii-1
        temp = temp - a(k,ii).*w(:,k); 
    end
    %Ajuste de W para o melhor par�metro    
    w(:,ii) = p(:,indice(ii)) +temp;
    
    %C�digo de parada
    ESR = 1 - sum(ERR);
    if ESR < tol
        break;
    end
end

M_linha = ii;               %Caso atinja a toler�ncia, ii < M
teta = zeros(M_linha,1);    %Ent�o as matrizes devem ser recalculadas, para evitar colunas com zeros
g = zeros(M_linha,1);
p_linha = zeros(N,M_linha);

for i = 1:M_linha
    p_linha(:,i) = p(:,indice(i));
end

%Par�metros g
for i =1:M_linha
    g(i) = dot(output(:),w(:,i))/dot(w(:,i),w(:,i));
end

%C�lculo do Teta
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