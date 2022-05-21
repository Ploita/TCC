
if sinal_ref == 1
    v = [0 ones(1,N)];
elseif sinal_ref == 2
    v = [0 -ones(1,N)];
end

ruido = normrnd(0,0.05,N+1,1);


%%
idc = zeros(M,1);
pos = 1;
for i = 1:M
    if i >= ny + 1 && i <= ny + nu
        idc(pos) = i;      % entrada pura
        pos = pos + 1;
    elseif i >= n + ny + 1 && i <= n + ny + nu
        idc(pos) = i;      % entrada e saída
        pos = pos + 1;
    elseif i >= 2*n + 1 && i <= 3*n -1
        idc(pos) = i;      % l=2, entrada e o resto
        pos = pos + 1;
    end
end

sinal_controle = zeros(N+1,1);
out_cont = zeros(N,1);
if index == 1
    out_cont(1) = 0;
    sinal_controle(1) = (v(2))/teta(2);
    for i = 2:N
        out_cont(i) = teta(1)*out_cont(i-1) + teta(2)*sinal_controle(i-1);
        sinal_controle(i) = (v(i+1) - teta(1)*out_cont(i))/teta(2);
    end
elseif index == 2
    out_cont(1) = 0;
    sinal_controle(1) = sqrt(v(2)/teta(2));
    for i = 2:N
        out_cont(i) = teta(1)*out_cont(i-1) + teta(2)*sinal_controle(i-1)^2;
        sinal_controle(i) = sqrt((v(i+1) - teta(1)*out_cont(i))/teta(2));
    end
elseif index == 3
    out_cont(1) = 0;
    sinal_controle(1) = 
    for i = 2:N
        out_cont(i) = teta(1)*out_cont(i-1) + teta(2)*sinal_controle(i-1)^2;
        sinal_controle(i) = sqrt((v(i+1) - teta(1)*out_cont(i))/teta(2));
    end
end

plot(out_cont)
xlabel("k")
ylabel("y(k)")


saida = Planta(sinal_controle,ruido,N,index);

figure
plot(saida)
xlabel("k")
ylabel("y(k)")
