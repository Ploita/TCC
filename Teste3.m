function Teste3()
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
        %xdotout = stateout(:,2);
        plot(xout)
        drawnow
        ylabel('x1')
        xlabel('x2')
        pause(0.5)
    end
end


    disp('Fim da simulação')
end 


function dstatedt = Derivatives(~,state)
dstatedt = zeros(2,1);
dstatedt(1) = state(2);
dstatedt(2) = -state(1) +0.5*(1-state(1)^2)*state(2);
end

