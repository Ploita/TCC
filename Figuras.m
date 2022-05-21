    %% Respostas assimétricas 3.1.1
n = 100;
u = ones(n,1);
y = zeros(n,1);

y(1) = 0;
%Entrada degrau
for k = 2:n
    y(k)=0.8*y(k-1)-0.3*y(k-1)*sin(y(k-1))+u(k-1);
end

plot(y)
hold

%Entrada degrau negativo
for k = 2:n
    y(k)=0.8*y(k-1)-0.3*y(k-1)*sin(y(k-1))-u(k-1);
end
plot(y)

xlabel('k')
ylabel('y(k)')
%% Geração Harmônica 3.1.2
n = 300;
t = 0:0.01:3-0.01;
u = sin(2*pi()*t);
y = zeros(n,1);

for k = 2:n
    y(k)=0.9*y(k-1)+0.1*sin(2*pi()*u(k-1));
end
plot(1:n,y,1:n,u)

xlabel('k')
ylabel('y(k)')

%% Multiplicidade de entrada 3.1.3
n = 100;
o = ones(n,1);

u = o.*.09;
a_1 = 1; a_2 = 1.05; b = 1;
y = zeros(n,1);

y(1) = tanh(0);
y(2) = tanh(a_1*y(1)+b*u(1));
for k = 3:n
    y(k) = tanh(a_1*y(k-1)+a_2*y(k-2)+b*u(k-1));
end
plot(y)
hold

u = o.*.159;
y = zeros(n,1);

y(1) = tanh(0);
y(2) = tanh(a_1*y(1)+b*u(1));
for k = 3:n
    y(k) = tanh(a_1*y(k-1)+a_2*y(k-2)+b*u(k-1));
end
plot(y)

ylabel('y(k)')
xlabel('k')

%%
n = 1000;
o = ones(n,1);
y = zeros(n,1);
out = zeros(n,1);
pos = 1;
amp = 0:0.001:1-0.001;
a_1 = 1; a_2 = 1.05; b = 1; c = 0;

for k = amp
    u = o.*k;
    y(1) = tanh(c);
    y(2) = tanh(a_1*y(1)+b*u(1)+c);
    for k = 3:n
        y(k) = tanh(a_1*y(k-1)-a_2*y(k-2)+b*u(k-1)+c);
    end
    out(pos) = y(n);
    pos = pos + 1;
end

plot(amp,out)
% title('Mapa estático entrada-saída')
ylabel('y(k)')
xlabel('u(k)')

%% Estabilidade dependente da entrada 3.1.4
n = 60;
amp = 4;
u = amp*ones(n,1);
y = zeros(n,1);

for k = 2:n
    if ~mod(k,10)
        amp = amp + 4;
        u(k) = amp;
    else
        u(k) = u(k-1);
    end
    
    y(k)= -0.8*y(k-1)+0.2*u(k-1)+0.18*y(k-1)^2;
end

plot(1:n,y)
xlim([1 n])
ylabel('y(k)')
xlabel('k')
hold
plot(1:n,u)
%% Geração sub-harmônica 3.1.5
n = 60;
u = zeros(n,1);
amp = [0.12; 0.06; 0.03; 0.015];


for j = 3
    h_1 = zeros(n,1);
    h_2 = zeros(n,1);
    y = zeros(n,1);
    u(1) = amp(j);
    for k = 2:n
        if ~mod(k,1)
            amp(j) = -amp(j);
            u(k) = amp(j);
        else
            u(k) = u(k-1);
        end
    end

    h_1(2) = tanh(u(1));
    y(2) = tanh(3.2*h_1(2));
    for k = 3:n    
        h_1(k) = tanh(-0.5*y(k-1)+u(k-1));
        h_2(k) = tanh(1.3*y(k-2)+u(k-2));
        y(k) = tanh(3.2*h_1(k)- h_2(k));
    end
    plot(1:n,y,1:n,u)
    ylabel('y(k)')
    xlabel('k')

end
%% Caos 1.3.6
n = 600;
t = 0:0.01:6-0.01;

u = 0.1*sin(2*pi()*t/6);
y = zeros(n,1);


for k = 2:n
    y(k)= -0.8*y(k-1)+4.1*y(k-1)*sin(y(k-1))+u(k-1);
end

plot(y)
xlabel('k')
ylabel('y(k)')

%% Mapa logístico
n = 100;
y = zeros(n,1);
y(1) = 0.2;
for k = 2:n
    y(k) = 4*y(k-1)*(1-y(k-1));
end

plot(y)
xlabel('k')
ylabel('y(k)')

%% Multiplicidade de saída 3.1.7
n = 100;
u = zeros(n,1);
y = zeros(n,1);
out = zeros(n,1);
amp = (0.01:0.01:1)';
pos = 1;
u(1) = 1;
ruido = normrnd(0,0.01,n,1);


y(2) = tanh(u(1));
for k = 3:n
    y(k)=tanh(2*y(k-1)-0.928*y(k-2)+u(k-1)+ruido(k-2));
end
temp = y;

ruido = normrnd(0,0.01,n,1);

y(2) = tanh(u(1));
for k = 3:n
    y(k)=tanh(2*y(k-1)-0.929*y(k-2)+u(k-1)+ruido(k-2));
end
plot(1:n,temp,1:n,y)
xlabel('k')
ylabel('y(k)')  