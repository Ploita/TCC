%Gráficos de Validação
lim_inf = 1+k;
lim_sup = N;

% figure
% subplot(2,1,1)
% plot(out_val(lim_inf:lim_sup))
% title('Saída Real');
% 
% subplot(2,1,2)
% plot(p_val(lim_inf:lim_sup,:)*teta)
% title('Saída Predita')
% sgtitle('Validação')

figure
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(k,lim_inf:lim_sup)')
title('Sinal diferença')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(k,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Saída Real x Saída predita')
sgtitle('Validação')

