function [r] = rsquared(xs, ys)
    ssres = 0;
    sstot = 0;

    mean_x = mean(xs);

    for i = 1:length(xs)
        sstot += (xs(i) - mean_x)^2;
        ssres += (xs(i) - ys(i))^2;
    end

    r = 1 - ssres / sstot;
end
