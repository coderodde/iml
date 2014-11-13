function predicted_label = knn_classify_impl(TrainingSet,
                                             TrainingSetY,
                                             image)
  % knn_classify_impl - predicts a digit for image 'image'.
  %
  % This function requires the actual training set 'TrainingSet' along the
  % training labels 'TrainingSetY', and the image 'image' for which to
  % predict the digit.
  %
  % Returns the predicted digit for 'image'.
  best_distance = Inf;
  best_label = -1;
  for i = 1:size(TrainingSet)(1)
    current_dist = euclidean_distance(image, TrainingSet(i,:));
    if best_distance > current_dist
      best_distance = current_dist;
      best_label = TrainingSetY(i);
    endif
  endfor
  predicted_label = best_label;
endfunction