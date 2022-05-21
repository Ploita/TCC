function fh = h(x)
    if(x>=1)        fh = 2/7*x + (-1/7 - 2/7);
    elseif (x<=1)   fh = 2/7*x - (-1/7 - 2/7);
    else
        fh = -1/7*x;
    end
end