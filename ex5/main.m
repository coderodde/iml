# This is the main entry point.
run('rsquared.m');

xs = unifrnd(-3, 3, 1, 30);
ys = zeros(1, 30);

f = @(x) 2 + x - 0.5 * x^2;

for i = 1:30
    ys(i) = f(xs(i)) + normrnd(0, 0.4);
end

# Now we have the data. Lets draw.
for K = 0:10
    figure;
    plot(xs, ys, 'o');
    hold on;
    p = polyfit(xs, ys, K);
    xt = linspace(-3, 3);
    fs = polyval(p, xt);
    fs2 = polyval(p, xs);
    plot(xt, fs, 'r-');
    title(["K = ", num2str(K), " R-squared = ", num2str(rsquared(xs, fs2))]);
    legend('Data points', 'Fitting polynomial', 'location', 'southwest');
end
