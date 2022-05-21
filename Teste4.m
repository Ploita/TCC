u = zeros(N,1);
r = normrnd(0,0.05,N+1,1);
r1 = normrnd(0,0.05,N+1,1);
v = ones(N+1,1);
y1 = zeros(N,1);
y2 = zeros(N,1);

for i = 2:N
    u(i) = 5*v(i+1)+4*y1(i-1)-0.9*y1(i-1)^2 - 5*r1(i+1);
    y1(i) = -0.8*y1(i-1)+0.2*u(i-1)+0.18*y1(i-1)^2 + r(i);
    y2(i) = -0.8*y2(i-1)+0.2*v(i-1)+0.18*y2(i-1)^2 + r(i);
end

plot(1:N,y1(1:N))
% figure
% plot(1:100, y2(1:100))

%%


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

for i = 1:M_linha
    fprintf(' %.4f'+str(indice(i)),teta(i));
end
