# This is the main entry point:
run('rsquared.m');
run('sumofsquarederrors.m')

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
    hold off
end

# Split the data into 10 subsets.
xsplit = zeros(10, 3);
ysplit = zeros(10, 3);
for i = 1:10
    xsplit(i,:) = xs( 3 * (i - 1) + 1 : (i - 1) * 3 + 3);
    ysplit(i,:) = ys( 3 * (i - 1) + 1 : (i - 1) * 3 + 3);
end

# For the error sums.
errs = zeros(1, 12);

# Stored polynomial coefficients.
coefs = zeros(12, 12);

# For each value of K, do...
for K = 0:11
    printf("--- K = %d.\n", K);
    # For each subset, do...
    for j = 1:10
        # Copy the data points.
        xdata = xs;
        ydata = ys;
        # Obtain the jth subset.
        xjth = xdata(3 * (j - 1) + 1 : 3 * (j - 1) + 3);
        yjth = ydata(3 * (j - 1) + 1 : 3 * (j - 1) + 3);
        # Remove the jth subset.
        xdata(3 * (j - 1) + 1 : 3 * (j - 1) + 3) = [];
        ydata(3 * (j - 1) + 1 : 3 * (j - 1) + 3) = [];
        # Fit a polynomial of degree K over the datapoints.
        p = polyfit(xdata, ydata, K);
        # Add the coefficients.
        for kk = 0:K
            coefs(K + 1, kk + 1) += p(kk + 1) / 12;
        end
        # Evaluate the jth subset.
        fjth = polyval(p, xjth);
        err = sum_of_squared_errors(fjth, yjth);
        printf('Sum of squared errors on %dth subset is %f.\n', j, err);
        errs(K + 1) += err;
    end
    # Print the error sum.
    printf("-- Error sum is %f. ", errs(K + 1));
    # Print the coefficients of the polynomial.
    printf("Coefficients: ");
    for kk = 0:K
        printf("%f ", coefs(K + 1,kk + 1));
    end
    printf("\n");
end

# Prepare to plot K-to-error graph.
Ks = zeros(1, 12);
for K = 0:11
    Ks(K + 1) = K;
end
figure
plot(Ks, errs);