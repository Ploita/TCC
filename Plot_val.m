%Gráficos de Validação
rho = 10;
lim_inf = 11;
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

png = figure;
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(rho,lim_inf:lim_sup)')
title('Sinal diferença')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(rho,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Saída Real x Saída predita')
sgtitle('Validação')
%saveas(png,"ValidaçãoOLS"+ int2str(index) +".png")

png = figure;
sgtitle('Evolução da taxa RMSE')
plot(0:100,[0; RMSE(1:100)])
xlabel("\rho passos à frente")
ylabel("RMSE")
%saveas(png,"RMSE_OLS"+ int2str(index) +".png")