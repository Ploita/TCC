% Oscilador Duffing-Ueda
f0 = 60;
tspan = [0 f0];
figure()
hold on

ft = linspace(0,f0,1000);
input = sin(2*pi()*ft);
% input = cos(2*30*ft/50);

y = [0;0];
[t,stateout] = ode45(@(t,y) myode(t,y,ft,input),tspan, y);
%%%Phase Plane
xout = stateout(:,1);
%xdotout = stateout(:,2);
plot(xout)
% plot(input)

xlabel('t')
ylabel('y(t)')

function dstatedt = myode(t,y,ft,input)
dstatedt = zeros(2,1);
input = interp1(ft,input,t);
dstatedt(1) = y(2);
dstatedt(2) = input - y(1)^3-0.1*y(2);
end