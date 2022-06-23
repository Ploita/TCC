%Gr�ficos de Valida��o
rho = 10;
lim_inf = 11;
lim_sup = N;

% figure
% subplot(2,1,1)
% plot(out_val(lim_inf:lim_sup))
% title('Sa�da Real');
% 
% subplot(2,1,2)
% plot(p_val(lim_inf:lim_sup,:)*teta)
% title('Sa�da Predita')
% sgtitle('Valida��o')

png = figure;
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(rho,lim_inf:lim_sup)')
title('Sinal diferen�a')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(rho,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Sa�da Real x Sa�da predita')
sgtitle('Valida��o')
%saveas(png,"Valida��oOLS"+ int2str(index) +".png")

png = figure;
sgtitle('Evolu��o da taxa RMSE')
plot(0:100,[0; RMSE(1:100)])
xlabel("\rho passos � frente")
ylabel("RMSE")
%saveas(png,"RMSE_OLS"+ int2str(index) +".png")