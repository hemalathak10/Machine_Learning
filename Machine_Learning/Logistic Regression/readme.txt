Machine Learning
Assignment 5
Task 1 (100 points)
In this task you will implement logistic regression using Iterative Reweighted Least Squares, as described in Section 4.3.3 of the PRLM textbook.
________________________________________
Command-line Arguments
You must implement a program that uses linear regression to fit a line or a second-degree polynomial to a set of training data. Your program can be invoked as follows:
logistic_regression <training_file> <degree> <test_file>
The arguments provide to the program the following information:
•	The first argument, <training_file>, is the path name of the training file, where the training data is stored. The path name can specify any file stored on the local computer.
•	The second argument, <degree> is a number equal to either 1 or 2. We will not test your code with any other values. The degree specifies what function φ you should use. Suppose that you have an input vector x = (x1, x2, ..., xD)T,.
o	If the degree is 1, then φ(x) = (1, x1, x2, ..., xD)T.
o	If the number is 2, then φ(x) = (1, x1, (x1)2, x2, (x2)2..., xD, (xD)2)T.
•	The third argument, <test_file>, is the path name of the test file, where the test data is stored. The path name can specify any file stored on the local computer.
Both the training file and the test file are text files, containing data in tabular format. Each value is a number, and values are separated by white space. The i-th row and j-th column contain the value for the j-th feature of the i-th object. The only exception is the LAST column, that stores the class label for each object. Make sure you do not use data from the last column (i.e., the class labels) as attributes (features).

For each dataset, a training file and a test file are provided. The name of each file indicates what dataset the file belongs to, and whether the file contains training or test data.
Note that, for the purposes of your assignment, it does not matter at all where the data came from. One of the attractive properties of the methods that you are implementing is that they can be applied in the exact same way to many different types of data, and produce useful results.
________________________________________
Implementation Details for Logistic Regression
Matrix Inversion
Your code will only have to invert matrices of arbitrary size. If you use C, C++, Java, or Python:
•	There is code posted on Blackboard (under "Class Material"->"Code for Assignment 5"), for inverting matrices.
•	It is MANDATORY that you invert matrices using the invert_matrix functions defined in that code.
You should use 64-bit floating point numbers. We will only test your code with cases where 64-bit precision is sufficient for getting numerically correct results.
Converting to Binary Classification Problem
We have only covered logistic regression for binary classification problems. In this assignment, you should convert the class labels found in the files as follows:
•	If the class label is equal to 1, it stays equal to 1.
•	If the class label is not equal to 1, you must set it equal to 0.
This way, your code will only see class labels that are 1 or 0.
Weight Initialization
All weights must be initialized to 0.
Stopping Criteria
For logistic regression, the training goes through iterations. At each iteration, you should decide as follows if you should stop the training:
•	Compare the new weight values, computed at this iteration, with the previous weight values. If the sum of absolute values of differences of individual weights is less than 0.001, then you should stop the training.
•	Compute the cross-entropy error, using the new weights computed at this iteration. Compare it with the cross-entropy error computed using the previous value of weights. If the change in the error is less than 0.001, then you should stop the training.
Numerical Issues for Yeast Dataset
Your code will probably not work on the yeast dataset for degree=2. Don't worry about that, we will not test for that case. As an optional (and zero-credit) task, figure out how to make the code work in this case. Feel free to do any changes you want, including ignoring some dimensions of the data. If you succeed, describe in your answers.pdf file what you did.