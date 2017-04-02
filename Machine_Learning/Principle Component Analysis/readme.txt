Task 1 (100 points)

In this task you will implement principal component analysis (PCA). More specifically, you will compute the projection matrix, and project the data using that matrix. You will find eigenvectors using the power method.
Your zip file should have a folder called pca_power, which contains your code and the README.txt file.

Command-line Arguments

Your program will be invoked as follows:
pca_power <training_file> <test_file> <M> <iterations>
The arguments provide to the program the following information:
The first argument, <training_file>, is the path name of the training file, where the training data is stored. The path name can specify any file stored on the local computer.
The second argument, <test_file>, is the path name of the test file, where the test data is stored. The path name can specify any file stored on the local computer.
The third argument, <M>, specifies the dimension of the output space of the projection. In other words, you will use the <M> with the largest eigenvalues to define the projection matrix.
The fourth argument, <iterations>, is a number greater than or equal to 1, that specifies the number of iterations for the power method. Slide 44 in the slides on PCA describes how to use the power method to find the top eigenvector, using a sequence bk. You should stop calculating this sequence after the specified number of iterations, and use the last bk (where k=<iterations>) as the eigenvector.
The training and test files will follow the same format as the text files in the UCI datasets directory. A description of the datasets and the file format can be found on this link. For each dataset, a training file and a test file are provided. The name of each file indicates what dataset the file belongs to, and whether the file contains training or test data. Your code should also work with ANY OTHER training and test files using the same format as the files in the UCI datasets directory.
As the description states, do NOT use data from the last column (i.e., the class labels) as features. In these files, all columns except for the last one contain example inputs. The last column contains the class label.

Training Stage Output

After you compute the projection matrix using the training data, print out the top <M> eigenvectors, in decreasing order of their eigenvalues. Note that you do not need to know the eigenvalues to specify this order. You just print out the eigenvectors in the order in which they have been calculated, based on the pseudocode in slide 54 of the slides on PCA. The output should follow this format:
Eigenvector 1
  1: %.4f
  2: %.4f
...
  D: %.4f

Eigenvector 2
  1: %.4f
  2: %.4f
...
  D: %.4f

...

Eigenvector M
  1: %.4f
  2: %.4f
...
  D: %.4f
In the above output template:
D is the number of dimensions of the training data.
M is command-line argument <M>.
In each line containing a value of an eigenvector, the first number (the dimension index) should be printed using the %3d format specification (an integer with three allocated spaces). The second value is simply the value of the eigenvector in that dimension, with exactly four decimal digits.
Test Stage

For each test object (in the order in which test objects appear in the test file), you should print the projection of that test object based on the projection you computed during training.
The output should follow this format:

Test object 0
  1: %.4f
  2: %.4f
...
  M: %.4f

Test object 1
  1: %.4f
  2: %.4f
...
  M: %.4f

...
In the above output template:
M is command-line argument <M>.
In each line containing a value of the projection of an object, follow the same instructions as for printing values of eigenvectors at the end of the training stage.