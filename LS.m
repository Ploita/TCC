%% Least Squares - LS
[teta, ~] = lsqr(p,output);

%Os seguintes elementos s�o necess�rios para o funcionamento do c�digo
%j� que em outros estimadores o total de par�metros � reduzido
p_linha = p;
M_linha = M;
indice = 1:M;