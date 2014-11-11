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

function dist = euclidean_distance(a, b)
  % euclidean_distance - computes the euclidian distance between the two
  % given vectors 'a' and 'b'.
  dist = norm(a - b);
endfunction

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

# This is the "main" function, a.k.a. the entry point.

# Substitute by *your* path.
cd ~/forget/uni/iml/mnist

# Load the utility functions.
run('loadmnist.m');       

# Get the data.
[X y] = loadmnist(5000);

# Create 100 distinct random integers from the range [1:5000];
indices = randperm(5000, 100);

# Display 100 chosen digits and print the respective classes.
visual(X(indices,:));
y(indices)

#### !!!! IMPORTANT !!!! #############################
# On my Mac, gnuplot can display only one plot. If   #
# your system does the same, close the current plot, #
# and press Enter as instructed.                     #
input("Please close the gnuplot, and press Enter! ");#
######################################################
# Divide the data into the training set and the test set.
TrainingSet = X(1:2500,:);
TestSet = X(2501:5000,:);
TrainingSetY = y(1:2500);
TestSetY = y(2501:5000);

# Get all ten prototypes.
prototype_matrix = get_prototype_matrix(TrainingSet, TrainingSetY);

# Plot them.
visual(prototype_matrix);

# Run the prototype-based classifier over the test set,
# construct its confusion matrix, and print it along the error rate. 
cm1 = naive_classify(TestSet, TestSetY, prototype_matrix)
printf('Error rate of prototype-based classifier: %f.\n',
       compute_error_rate(cm1));
       
# Now, for the kNN-classifier.
cm2 = knn_classify(TrainingSet, TrainingSetY, TestSet, TestSetY)
printf('Error rate of kNN-classifier: %f.\n', compute_error_rate(cm2));