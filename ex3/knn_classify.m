function cm = knn_classify(TrainingSet, TrainingSetY, TestSet, TestSetY)
  % knn_classify - classifies the images in 'TestSet' using
  % training data in 'TrainingSet' and 'TrainingSetY', and produces the
  % confusion matrix.
  %
  % This function requires the training data ('TrainingSet' and 'TrainingSetY')
  % and the actual test data ('TestSet' and 'TestSetY').
  %
  % Returns the confusion matrix of kNN-classifier on give data.
  cm = zeros(10, 10);
  for i = 1:size(TestSet)(1)
    predicted_digit = knn_classify_impl(TrainingSet,
                                        TrainingSetY,
                                        TestSet(i,:));
    % Map digits 0 to index 10.
    if predicted_digit == 0
      predicted_digit = 10;
    endif
    actual_digit = TestSetY(i);
    if actual_digit == 0
      actual_digit = 10;
    endif
    cm(predicted_digit, actual_digit)++;
  endfor
endfunction