function cm = naive_classify(TestSet, TestSetY, prototype_matrix)
  % naive_classify - computes the confusion matrix of the given test set
  % according to the particular prototype matrix.
  %
  % This function takes the test set ('TestSet') and the corresponding
  % labels ('TestSetY'), along the prototype matrix ('prototype_matrix').
  %
  % Returns the confusion matrix, in which (i,j) element is the amount of
  % times label 'i' was given to the actual label 'j'.
  cm = zeros(10, 10);
  for i = 1:size(TestSet)(1)
    predicted_class = naive_classify_impl(TestSet(i,:), prototype_matrix);
    actual_class = TestSetY(i);
    predicted_class_index = predicted_class;
    actual_class_index = actual_class;
    if predicted_class == 0
      predicted_class_index = 10;
    endif
    if actual_class == 0
      actual_class_index = 10;
    endif
    cm(predicted_class_index, actual_class_index)++;
  endfor
endfunction