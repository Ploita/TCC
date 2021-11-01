lim_inf = 1;
lim_sup = N;

figure
subplot(2,1,1)
plot(out_val(lim_inf:lim_sup))
title('Sa�da Real');

subplot(2,1,2)
plot(p_val(lim_inf:lim_sup,:)*teta)
title('Sa�da Predita')
sgtitle('Valida��o')

figure
subplot(2,1,1)
plot(out_val(lim_inf:lim_sup)-p_val(lim_inf:lim_sup,:)*teta)
title('Sinal diferen�a')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,p_val(lim_inf:lim_sup,:)*teta);
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Sa�da Real x Sa�da predita')
sgtitle('Valida��o')