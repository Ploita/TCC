%Controle do modelo
%Geração do sinal referência
if index == 4
    v = [0 -0.25*ones(1,300) 0.6*ones(1,300) 0.2*ones(1,400)];
elseif index == 3
    v = [0 ones(1,300) 2*ones(1,300) 1.5*ones(1,400)];
else
    v = [0 -ones(1,300) -2*ones(1,300) -1.5*ones(1,400)];
end


% png = figure;
% plot(v(1:1000))
% % ylim([-0.7 0.7])
% xlabel('k')
% ylabel('v(k)')
% % saveas(png,"REF"+ int2str(index) +".png")

%%
% ruido = zeros(N+1,1); Caso ideal
ruido = normrnd(0,0.01,N+1,1);
sinal_controle = zeros(N+1,1);
out_cont = zeros(N,1);

if index == 1
    out_cont(1) = ruido(1);
    sinal_controle(1) = (v(2))/teta(2);
    for i = 2:N
        out_cont(i) = teta(1)*out_cont(i-1) + teta(2)*sinal_controle(i-1) + ruido(i);
        sinal_controle(i) = (v(i+1) - teta(1)*out_cont(i))/teta(2);
    end
    
elseif index == 2
    out_cont(1) = ruido(1);
    sinal_controle(1) = v(2)/teta(2);
    for i = 2:N
        out_cont(i) = teta(1)*out_cont(i-1) + teta(2)*sinal_controle(i-1) + teta(3)*sinal_controle(i-1)*out_cont(i-1) + ruido(i);
        sinal_controle(i) = (v(i+1) - teta(1)*out_cont(i))/(teta(2)+teta(3)*out_cont(i));
    end
    
elseif index == 3
    out_cont(1) = ruido(1);
    sinal_controle(1) = 0;
    for i = 2:N
        out_cont(i) = teta(1)*sinal_controle(i-1)*out_cont(i-1) + teta(2)*out_cont(i-1)^2 + teta(3)*sinal_controle(i-1) + teta(4)*out_cont(i-1) + ruido(i);
        sinal_controle(i) = (v(i+1) - teta(2)*out_cont(i)^2 - teta(4)*out_cont(i))/(teta(1)*out_cont(i) + teta(3));
    end

elseif index == 4
    
    out_cont(1) = ruido(1);
    sinal_controle(1) = 0;
        for i =2:N
            out_cont(i) = teta(1)*sinal_controle(i-1) + teta(2)*out_cont(i-1) + teta(3)*sinal_controle(i-1)^2 + teta(4)*out_cont(i-1)^2 + ruido(i);
            sinal_controle(i) = NewtonRaphson(@(x) teta(1)*x + teta(2)*out_cont(i) + teta(3)*x^2 + teta(4)*out_cont(i)^2 - v(i+1),@(x) teta(1) + 2*teta(3)*x);
        end
end


% figure
% plot(out_cont)
% xlabel("k")
% ylabel("y(k)")

ruido = normrnd(0,0.01,N+1,1);
saida = Planta(sinal_controle,ruido,N,index);

png = figure;
sgtitle('Saída controlada')
plot(saida)
xlabel("k")
ylabel("y(k)")
hold on
plot(v(1:1000))
hold off
% saveas(png,"ControleOLS"+ int2str(index) +".png")

png = figure;
sgtitle('Ação de controle')
plot(sinal_controle(1:1000))
xlabel('k')
ylabel('u(k)')
% saveas(png,"LeiOLS"+ int2str(index) +".png")