# This is the "main" function, a.k.a. the entry point.

# Load all the functions.
run('get_prototype_matrix.m');
run('euclidean_distance.m');
run('naive_classify_impl.m');
run('naive_classify.m');
run('knn_classify_impl.m');
run('knn_classify.m');
run('compute_error_rate.m');

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