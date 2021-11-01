%% Extended Least Squares - ELS

%Calcula-se por m�nimos quadrados normalmente
[teta_MQ, temp] = lsqr(p,output);

tam = 100;  %Total de repeti��es

residuo(:,1) = output - p*teta_MQ;  %c�lculo do res�duo
vari = zeros(tam,1);    %vetor de vari�ncia
teta_LS = zeros(length(p(1,:))+1,tam);  %Matriz teta estendido
vari(1) = var(residuo(:,1));    %c�lculo da vari�ncia

for i = 2:tam
    %Matriz p estendida
    pp = [p residuo(:,i-1)];
    %c�lculo do teta estendido por m�nimos quadrados
    [teta_LS(:,i), temp] = lsqr(pp,output);
    %c�lculo do novo res�duo
    residuo(:,i) = output - pp*teta_LS(:,i);
    %c�lculo da vari�ncia
    vari(i) = var(residuo(:,i));
end

%Os seguintes elementos s�o necess�rios para o funcionamento do c�digo
%j� que em outros estimadores o total de par�metros � reduzido
p_linha = p;
M_linha = M;
indice = 1:M;
%Vetor de par�metros teta
teta = teta_LS(1:M,tam);
