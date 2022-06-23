png = figure;
sgtitle('Par�metros \theta')
subplot(3,1,1)
plot(a1)
ylabel('a_1')
xlabel('k')
subplot(3,1,2)
plot(a2)
ylabel('a_2')
xlabel('k')
subplot(3,1,3)
plot(b0)
ylabel('b_0')
xlabel('k')
% saveas(png,"TetaRLS"+ int2str(index) +".png")
%%
% Imprimir o modelo
if a1(N) > 0
    fprintf('y(k) = - %.4f y(k-1)',a1(N));
else
    fprintf('y(k) = %.4f y(k-1)',abs(a1(N)));
end
if a2(N) > 0
    fprintf(' - %.4fy(k-2)',a2(N));
else
    fprintf(' + %.4fy(k-2)',abs(a2(N)))
end

if b0(N) > 0
    fprintf(' + %.4fu(k-1)',b0(N));
else
    fprintf(' - %.4fu(k-1)',abs(b0(N)));
end

fprintf('\n');
%%
k = 10;

%Gr�ficos de Valida��o
lim_inf = 2+k;
lim_sup = N;

png = figure;
subplot(2,1,1)
plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup)-y_cha(k,lim_inf:lim_sup)')
title('Sinal diferen�a')

subplot(2,1,2)
pp = plot(lim_inf:lim_sup,out_val(lim_inf:lim_sup),lim_inf:lim_sup,y_cha(k,lim_inf:lim_sup));
pp(1).Color = 'b';
pp(2).Color = 'r';
title('Sa�da Real x Sa�da predita')
sgtitle('Valida��o')
% saveas(png,"Valida��oRLS"+ int2str(index) +".png")
%
png = figure;
sgtitle('Evolu��o da taxa RMSE')
plot(0:100,[0; RMSE(1:100)])
xlabel("\rho passos � frente")
ylabel("RMSE")
% saveas(png,"RMSE_RLS"+ int2str(index) +".png")
%%
png = figure;
sgtitle('Par�metros R e S')
subplot(4,1,1)
plot(r1)
ylabel('r_1')
xlabel('k')
subplot(4,1,2)
plot(s0)
ylabel('s_0')
xlabel('k')
subplot(4,1,3)
plot(s1)
ylabel('s_1')
xlabel('k')
subplot(4,1,4)
plot(s2)
ylabel('s_2')
xlabel('k')
% saveas(png,"PolinomiosRS"+ int2str(index) +".png")
% Imprimir o modelo
if r1(N) > 0
    fprintf('R(z^-1) = %.4f',r1(N));
else
    fprintf('R(z^-1) = - %.4f',abs(r1(N)));
end
fprintf('\n')

if s0(N) > 0
    fprintf('S(z^-1) = %.4f',s0(N));
else
    fprintf('S(z^-1) = - %.4f',abs(s0(N)));
end

if s1(N) > 0
    fprintf(' + %.4fz^-1',s1(N));
else
    fprintf(' - %.4fz^-1',abs(s1(N)))
end

if s2(N) > 0
    fprintf(' + %.4fz^-2',s2(N));
else
    fprintf(' - %.4fz^-2',abs(s2(N)));
end

fprintf('\n');

png = figure;
sgtitle('Sa�da controlada')
plot(out_cont)
xlabel("k")
ylabel("y(k)")
hold on
plot(v(1:1000))
hold off
% saveas(png,"ControleRLS"+ int2str(index) +".png")

png = figure;
sgtitle('A��o de controle')
plot(sinal_controle)
xlabel('k')
ylabel('u(k)')
% saveas(png,"LeiRLS"+ int2str(index) +".png")