function label = naive_classify_impl(image, prototype_matrix)
  % naive_classify_impl - computes the label of the prototype, which is the
  % closest to the image 'image'.
  %
  % This function takes the image to be classified ('image') and the
  % prototype matrix ('prototype_matrix') that contains all the prototypes
  % as its rows.
  %
  % Returns the label, whose respective prototype is closest to 'image'.
  best_digit = -1;
  best_dist = Inf;
  for digit = 1:10
    current_dist = euclidean_distance(image, prototype_matrix(digit,:));
    if best_dist > current_dist
      best_dist = current_dist;
      best_digit = digit;
    endif
  endfor
  if best_digit == 10
    label = 0;
  else
    label = best_digit;
  endif
endfunction