function prototype_matrix = get_prototype_matrix(T, labels)
  % get_prototype_matrix - computes a 10 x 784 matrix in which each row
  % is the prototype for a particular digit. For 0 < d < 10, the digit's 'd'
  % the prototype is the dth row. And the prototype for digit '0' is the 10th
  % row of the matrix.
  %
  % This function requires the training data matrix 'T', and its corresponding
  % class vector 'labels'.
  %
  % Returns the prototype matrix as above.
  prototype_matrix = zeros(10, size(T)(2));
  class_sizes = zeros(1, 10);
  for i = 1:size(T)(1)
    digit = labels(i);
    if digit == 0
      class_sizes(10)++;
      prototype_matrix(10,:) += T(i,:);
    else
      class_sizes(digit)++;
      prototype_matrix(digit,:) += T(i,:);
    endif
  endfor
  for i = 1:10
    prototype_matrix(i,:) /= class_sizes(i);
  endfor
endfunction