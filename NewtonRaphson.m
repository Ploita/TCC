function u = NewtonRaphson(f,fd)
% f = @(x) x*(teta(4)*y1-teta(2)*x)+teta(1)*y1-ref;
%Write your function f(x), where f(x)=0.
%f= @ (x) x*x*x-4*x-9;
% fd = @ (x) teta(4)*y1-2*teta(2)*x;
%fd= @ (x) 3*x*x-4;
x0 = 0; %initial guess of the root.
%For exmple here x0=2.
epsilon = 10^-2;
%for exmple 0.001 or 0.0001 etc.
%Formula: x1=x0-f(x0)/f'(x0);
x1=x0-f(x0)/fd(x0);
err=abs(x1-x0);
while err > epsilon
    x1=x0-f(x0)/fd(x0);
    err=abs(x1-x0);
    x0=x1;
end
u = real(x1);
end