y = zeros(N,1);
C = 5.9 ;

for k = 3:N
    y(k) = 0.2*y(k-1) + 0.5*C*(input(k-2)-y(k-2))*y(k-2) + 0.1*C*(input(k-2)-y(k-2))^2;
end

plot(y)

%%
function Teste1()
close all
clc
tspan = [0 10];
figure()
hold on

for x0 = -3:0.5:3
    for xdot0 = -3:0.5:3
        y = [x0;xdot0];
        
        [~,stateout] = ode45(@Derivatives,tspan,y);
        %%%Phase Plane
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        plot(xout,xdotout)
        drawnow
        axis([-3 3 -3 3])
        ylabel('x1')
        xlabel('x2')
    end
    
end
    disp('Fim da simulação')
end 


function dstatedt = Derivatives(~,state)
dstatedt = zeros(2,1);
dstatedt(1) = state(2);
dstatedt(2) = ((b-a)*state(2)+(a*b-1)*(state(1)));

end

