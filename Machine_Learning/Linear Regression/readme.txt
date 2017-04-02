ML Assignment 4

Task 1

In this task you will implement linear regression, as described in Sections 3.1.1 and 3.1.4 of the PRLM textbook.

Command-line Arguments

You must implement a program that uses linear regression to fit a line or a second-degree polynomial to a set of training data. Your program can be invoked as follows:
linear_regression <training_file> <degree> <λ>
The arguments provide to the program the following information:
•	The first argument is the path name of the training file, where the training data is stored. The path name can specify any file stored on the local computer.
•	The second argument is a number. This number should be either 1 or 2. We will not test your code with any other values. If the number is 1, you should fit a line to the data. If the number is 2, you should fit a second-degree polynomial to the data.
•	The third number is a non-negative real number (it can be zero or greater than zero). This is the value of λ that you should use for regularization. If λ = 0, then no regularization is used.
The training file is a text file, containing data in tabular format. Each value is a number, and values are separated by white space. Each row contains two numbers: the first of those numbers is the training input, and the second of those numbers is the target output.
An example file that can be passed in as argument is sample_data1.txt. We reserve the right to test your code with any other file that follows the same format.
Since degree can only be 1 or 2, this means that your code will only have to invert matrices of size 2x2 or 3x3. For both 2x2 and 3x3 matrices, you can see the formulas for matrix inversion on this Wikipedia article. You should use 64-bit floating point numbers. We will only test your code with cases where 64-bit precision is sufficient for getting numerically correct results.
At the end, your program should print out the values of the weights that you have estimated.
•  For C or C++, use:
printf("w0=%.4lf\n", w0);
printf("w1=%.4lf\n", w1);
printf("w2=%.4lf\n", w2);
For any other language, just make sure that you use formatting specifies that produce aligned output that matches EXACTLY the specs given above for C. Note that you print the value of w2 even when the command-line degree argument is 1. In that case, just print 0 for w2.
In your answers.pdf document, provide the output of your program when given sample_data1.txt. For that file, provide the output for these program invocations:
linear_regression sample_data1.txt 1 0
linear_regression sample_data1.txt 2 0
linear_regression sample_data1.txt 2 0.001
linear_regression sample_data1.txt 2 1