function y = Planta(entrada,ruido,nend,index)
%Planta Linear = 1
%Planta Não Linear Fraca = 2
%Planta Não Linear Média = 3
%Planta Não Linear Forte = 4
y = zeros(nend,1);
u = zeros(nend,1);

if index == 1
     
%     sys = tf(0.4,[1 -0.8],-1);
%     p = lsim(sys, entrada);
    y(1) = ruido(1);
    for i = 2:nend
        y(i) = 0.4*entrada(i-1) + 0.8*y(i-1) + ruido(i);
    end
    
elseif index == 2
    y(1) = ruido(1);
    for i = 2:nend
        y(i) = 0.1*(entrada(i-1))+0.9*y(i-1)+0.01*y(i-1)*entrada(i-1)+ruido(i);
    end
    
elseif index == 3
    y(1) = ruido(1);
    for i = 2:nend
        y(i)=-0.8*y(i-1)+0.2*entrada(i-1)+0.18*y(i-1)^2 + ruido(i);
    end
    
elseif index == 4
    y(1) = ruido(1);
    y(2) = tanh(3.2*tanh(-0.5*y(1)+entrada(1)))+ruido(2);
    for i = 3:nend
        h_1(i) = tanh(-0.5*y(i-1)+entrada(i-1));
        h_2(i) = tanh(1.3*y(i-2)+entrada(i-2));
        y(i) = tanh(3.2*h_1(i)-h_2(i)) + ruido(i);
    
    end


% Sinal controlado
% Vai ter que adaptar pra pegar do modelo

elseif index == 5
    v = normrnd(0,0.05,nend+1,1);
    
    y(1) = ruido(1);
    u(1) = -2*y(1) - 2.5*v(2) + 2.5*entrada(2);
    for i = 2:nend
        y(i) = 0.4*u(i-1) + 0.8*y(i-1) + ruido(i);
        u(i) = -2*y(i) - 2.5*v(i+1) + 2.5*entrada(i+1);
    end
    
elseif index == 10
    v = normrnd(0,0.05,nend+1,1);
    y(1) = ruido(1);
    u(1) = (-0.9*y(1)-v(2)+entrada(2))/(0.1+0.01*y(1));
    for i = 2:nend
        y(i) = 0.1*u(i-1)+0.9*y(i-1)+0.01*y(i-1)*u(i-1)+ruido(i);
        u(i) = (-0.9*y(i)-v(i+1)+entrada(i+1))/(0.1+0.01*y(i));
    end
end

if index == 15
    v = normrnd(0,0.05,nend+1,1);
    y(1) = ruido(1);
    u(1) = 4*y(1)-0.9*y(1)^2-5*v(1)+5*entrada(2);
    for i = 2:nend
        y(i) = -0.8*y(i-1)+0.2*u(i-1)+0.18*y(i-1)^2 + ruido(i);
        u(i) = 4*y(i)-0.9*y(i)^2-5*v(i+1)+5*entrada(i+1);
    end
end
if index == 20
    %não funciona pq h_1 e h_2 dependem da previsão de x e vice-versa
    y(1) = ruido(1);
    y(2) = tanh(3.2*tanh(-0.5*y(1)+entrada(1)))+ruido(2);
    h_1(nend+1) = 0;
    for i = 3:nend
        h_1(i) = tanh(-0.5*y(i-1)+entrada(i-1));
        h_2(i) = tanh(1.3*y(i-2)+entrada(i-2));
        y(i) = tanh(3.2*h_1(i)-h_2(i)) + ruido(i);
        u(i) = atanh(h_1(i+1))+0.5*y(i)+entrada(i+1);
    end
end



return
end