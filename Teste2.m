function Teste2()
tspan = [0 20];
figure()
hold on

for x0 = -3
    for y0 = -3
        for z0 = -3
            y = [x0;y0;z0];
            [~,stateout] = ode45(@Derivatives,tspan,y);
            %%%Phase Plane
            output = stateout(:,1);
            %xdotout = stateout(:,2);
            plot(output)
            drawnow
            ylabel('x')
            xlabel('t')
        end
    end
end
    disp('Fim da simulação')
end 


function dstatedt = Derivatives(~,state)
dstatedt = zeros(3,1);
dstatedt(1) = 9*(state(2) - H(state(1)));
dstatedt(2) = state(1) - state(2) + state(3);
dstatedt(3) = -100/7*state(2);
end

