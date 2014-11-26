function err = sum_of_squared_errors(y, f)
    err = 0;
    for i = 1:length(y)
        err += (y(i) - f(i))^2;
    end
end