%% Least Squares - LS
[teta, ~] = lsqr(p,output);

%Os seguintes elementos são necessários para o funcionamento do código
%já que em outros estimadores o total de parâmetros é reduzido
p_linha = p;
M_linha = M;
indice = 1:M;