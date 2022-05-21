%Mapa logístico

n = 100;
x = zeros(n,1);
r = 4;

x(1) = 0.2;
for i = 1:n-1
    x(i+1) = r*x(i)*(1-x(i));
end

plot(0:n-1,x)