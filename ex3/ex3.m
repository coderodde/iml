
function mean_vector = compute_prototype(T, labels, digit)
  % compute_prototype - compute the prototype vector for digit 'digit'
  %
  % This function takes a matrix containing the images as its rows (T),
  % the vector (labels) of corresponding actual classes for each row of T,
  % and the target digit (digit) for which the prototype should be computed.
  %
  % Returns the image vector where each "pixel" is the average value of
  % corresponding pixels in the training set.
  mean_vector = zeros(1, size(T)(2));
  count = 0;
  for i = 1:size(T)(1)
    if labels(i) == digit
      mean_vector += T(i,:);
      count++;
    endif
  endfor
  mean_vector /= count;
endfunction

function prototype_matrix = get_prototype_matrix(T, labels)
  % get_prototype_matrix - compute the matrix, whose rows correspond to
  % digit prototypes.
  %
  % This function takes a matrix containing the images as its rows (T),
  % and the vector with respective digit classes (labels).
  %
  % Returns a 10 x 784 matrix, in which each row i (0 < i < 10) corresponds to
  % the prototype for digit i, and the last row (num. 10) corresponds to the
  % prototype for digit 0.
  prototype_matrix = zeros(10, 784);
  for i = 1:9
    prototype_matrix(i,:) = compute_prototype(T, labels, i);
  endfor
  prototype_matrix(10,:) = compute_prototype(T, labels, 0);
endfunction

function dist = euclidean_distance(a, b)
  dist = norm(a - b);
endfunction

function label = naive_classify_impl(image, prototype_matrix)
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

# Run the naive classifier over the test set,
# construct its confusion matrix, and print it. 
cm1 = naive_classify(TrainingSet, TrainingSetY, prototype_matrix)