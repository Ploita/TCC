%Gráficos de treino
lim_inf = 1;
lim_sup = N;

% figure
% subplot(2,1,1)
% plot(output(lim_inf:lim_sup))
% title('Saída Real');
% 
% subplot(2,1,2)
% plot(p_linha(lim_inf:lim_sup,:)*teta)
% title('Saída Predita')
% sgtitle('Treino')

png = figure;
subplot(2,1,1)
plot(output(lim_inf:lim_sup)-p_linha(lim_inf:lim_sup,:)*teta)
title('Sinal diferença')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,output(lim_inf:lim_sup),lim_inf:lim_sup,p_linha(lim_inf:lim_sup,:)*teta);
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Saída Real x Saída predita')
sgtitle('Treino')
saveas(png,"TreinoOLS"+ int2str(index) +".png")