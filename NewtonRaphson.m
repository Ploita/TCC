%% Adaptado do Autor Manotosh Mandal
% link = https://www.mathworks.com/matlabcentral/fileexchange/72482-newton-raphson

function u = NewtonRaphson(f,fd)
x0 = 0; %initial guess of the root.
epsilon = 10^-2;
x1 = x0 - f(x0)/fd(x0);
err = abs(x1-x0);
while err > epsilon
    x1 = x0 - f(x0)/fd(x0);
    err = abs(x1 - x0);
    x0 = x1;
end
u = real(x1);
end