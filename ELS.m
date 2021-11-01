%% Extended Least Squares - ELS

%Calcula-se por mínimos quadrados normalmente
[teta_MQ, temp] = lsqr(p,output);

tam = 100;  %Total de repetições

residuo(:,1) = output - p*teta_MQ;  %cálculo do resíduo
vari = zeros(tam,1);    %vetor de variância
teta_LS = zeros(length(p(1,:))+1,tam);  %Matriz teta estendido
vari(1) = var(residuo(:,1));    %cálculo da variância

for i = 2:tam
    %Matriz p estendida
    pp = [p residuo(:,i-1)];
    %cálculo do teta estendido por mínimos quadrados
    [teta_LS(:,i), temp] = lsqr(pp,output);
    %cálculo do novo resíduo
    residuo(:,i) = output - pp*teta_LS(:,i);
    %cálculo da variância
    vari(i) = var(residuo(:,i));
end

%Os seguintes elementos são necessários para o funcionamento do código
%já que em outros estimadores o total de parâmetros é reduzido
p_linha = p;
M_linha = M;
indice = 1:M;
%Vetor de parâmetros teta
teta = teta_LS(1:M,tam);
