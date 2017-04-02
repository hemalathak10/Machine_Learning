function [] = logistic_regression(trngFile, degree, testFile)
    %Logistic Regression Part
    A = double(load(trngFile));
    T = A(:,end);
    A = A(:,1:end-1);
    T(T > 1) = 0;
    rows = size(A,1);
    cols = size(A,2);
    P = zeros(rows,1);
    for i = 1:rows        
        P(i,1) = 1;
        k = 2;
        for j = 2:cols+1
            x = A(i,j-1);
            P(i,k) = x;
            k = k + 1;
            if degree == 2
                P(i,k) = x * x;
                k = k + 1;
            end
        end
    end
    Err = 0;
    condition = true;
    W = zeros(cols*degree+1,1);    
    PT = transpose(P);
    m = 1;  
    while condition
        WT = transpose(W);
        a = zeros(rows,1);
        for i = 1:rows
            a(i,1) = WT * PT(1:end,i);
        end
        a = a * -1;
        Y = zeros(rows,1);
        for i = 1:rows
            denominator = 1 + exp(a(i,1));
            Y(i,1) = 1 / denominator;
        end
        E = PT * (Y - T);
        NErr = sum(E,1);
        R = zeros(rows,rows);
        for i = 1:rows
            R(i,i) = Y(i,1) * (1 - Y(i,1));
        end
        NW = W - pinv(PT * R * P) * E;
        condition = abs(sum(NW) - sum(W)) >= 0.001 && abs(NErr - Err) >= 0.001;
        W = NW;
        Err = NErr;
        m = m + 1;        
    end
    for i = 1:(cols*degree)+1
        fprintf('w%d=%.4f\n',i-1,NW(i));
    end
    
    %Accuracy Part
    ATest = double(load(testFile));
    TTest = ATest(:,end);
    ATest = ATest(:,1:end-1);
    TTest(TTest > 1) = 0;
    rowsTest = size(ATest,1);
    colsTest = size(ATest,2);
    PTest = zeros(rowsTest,1);
    for i = 1:rowsTest    
        PTest(i,1) = 1;
        k = 2;
        for j = 2:colsTest+1
            x = ATest(i,j-1);
            PTest(i,k) = x;
            k = k + 1;
            if degree == 2
                PTest(i,k) = x * x;
                k = k + 1;
            end
        end
    end
    NWT = transpose(NW);
    PTestT = transpose(PTest);
    total = 0;
    positive = 0;    
    for i = 1:rowsTest
        clash = 0;
        YTest = NWT * PTestT(1:end,i);
        aTest = YTest * -1;
        denominatorTest = 1 + exp(aTest);
        sigmoidalTest = 1 / denominatorTest;
        if YTest > 0 && sigmoidalTest > 0.5
            predictedClass = 1;
            probability = sigmoidalTest;
        elseif YTest < 0 && (1 - sigmoidalTest) > 0.5
            predictedClass = 0;
            probability = 1 - sigmoidalTest;
        else
            predictedClass = 0;
            probability = 1 - sigmoidalTest;
            clash = 1;
        end
        if predictedClass == TTest(i,1)
            accuracy = 1;
        else
            accuracy = 0;
        end
        if clash == 1
            accuracy = 0.5;
        end
        positive = positive + accuracy;
        fprintf('ID=%5d, predicted=%3d, probability = %.4f, true=%3d, accuracy=%4.2f\n',i-1,predictedClass,probability,TTest(i,1),accuracy);
        total = total + 1;
    end
    finalAccuracy = positive / total;
    fprintf('classification accuracy=%6.4f\n',finalAccuracy);