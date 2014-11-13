function err_rate = compute_error_rate(cm)
  % compute_error_rate - computes the error rate given a confusion matrix.
  %
  % This function requires the actual confusion matrix with dimensions
  % 10 x 10.
  %
  % Returns the error rate, which is the ratio of misses and the total amount
  % of test.
  total = sum(cm(:));
  hits = 0;
  for i = 1:10
    hits += cm(i,i);
  endfor
  err_rate = 1 - hits / total;
endfunction