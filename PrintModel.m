% Imprimir o modelo

str = string(zeros(M,1));
str(M) = "cte";
pos = 1;
for k = 1:ny
    str(pos) = "y(k-" + k +")";
    pos = pos + 1;
end
for k = 1:nu
    str(pos) = "u(k-" + k +")";
    pos = pos + 1;
end
for k = 1:ne
    str(pos) = "e(k-" + k +")";
    pos = pos + 1;
end
if l>=2
    for k1 = 1:n
        for k2 = k1:n
            str(pos) = str(k1) + '*' + str(k2);
            pos = pos +1;
        end
    end
end

if l >=3
    for k1 =1:n
        for k2 = k1:n
            for k3 = k2:n
                str(pos) = str(k1) + '*' + str(k2) + '*' + str(k3);
                pos = pos+1;
            end
        end
    end
end
fprintf('y(k) =')
fprintf(' %.4f'+str(indice(1)),teta(1));
for i = 2:M_linha
    if teta(i) > 0
        fprintf(' + %.4f'+str(indice(i))+' ',teta(i));
    else
        fprintf(' - %.4f'+str(indice(i)),abs(teta(i)));
    end
end
fprintf('\n');
