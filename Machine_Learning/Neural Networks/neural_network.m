function [] = neural_network(trngFile, testFile, layers, units_per_layer, rounds)
    inputMatrix = double(load(trngFile));
    target = inputMatrix(:,end);
    rows = size(inputMatrix,1);    
    no_of_attrs = size(inputMatrix,2);
    no_of_classes = max(target) + 1;
    learning_rate = 1;
    tmpMax = max(inputMatrix);
    maxVal = max(tmpMax);
    inputMatrix = inputMatrix / maxVal;
    inputMatrix(:,no_of_attrs) = 1;
    testMatrix = load(testFile);
    testTarget = testMatrix(:,end);    
    tmpMax = max(testMatrix);
    maxVal = max(tmpMax);
    testMatrix = testMatrix / maxVal;
    testMatrix(:,no_of_attrs) = 1;
    positive = 0;
    total = size(testMatrix,1);
    
    if layers == 2
        weights3 = randi([-50 50], units_per_layer, no_of_attrs);
        weights3 = weights3 / 1000;
        weights3(:,end) = 1;
        r = 1;
        while r <= rounds
            for rowIter = 1:rows
                transposeInput = double(transpose(inputMatrix(rowIter,1:end)));
                transposeInput(end) = 1;
                out = weights3 * transposeInput;
                out = logsig(out);
                deltaOutput = zeros(no_of_classes,1);
                for j = 1:size(out,1)
                    t = 0;
                    if j == target(rowIter,1)+1
                        t = 1;
                    end
                    deltaOutput(j,1) = (out(j) - t) * out(j) * (1 - out(j));
                end
                for j = 1:size(out,1)
                    for i = 1:size(inputMatrix,2)
                        weights3(j,i) = weights3(j,i) - learning_rate * deltaOutput(j,1) * transposeInput(i,1);
                    end
                end                
            end            
            r = r + 1;
            learning_rate = learning_rate * 0.98;
        end    
        %-------------------- output
        for rowIter = 1:size(testMatrix,1)
            transposeOut = double(transpose(testMatrix(rowIter,1:end)));
            transposeOut(end) = 1;
            outOut = weights3 * transposeOut;        
            outOut = logsig(outOut);
            [val, index] = max(outOut);
            test = testTarget(rowIter,1);
            accuracy = 0;
            if index-1 == test
                accuracy = 1;
                positive = positive + 1;            
            end        
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',rowIter-1,index-1,test,accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n',final);
    elseif layers == 3
        weights1 = randi([-50 50], units_per_layer, no_of_attrs);
        weights1 = weights1 / 1000;
        weights1(:,end) = 1;
        weights3 = randi([-50 50], no_of_classes,units_per_layer+1);
        weights3 = weights3 / 1000;
        weights3(:,end) = 1;
        r = 1;
        while r <= rounds
            for rowIter = 1:rows
                out1 = weights1 * transpose(inputMatrix(rowIter,1:end));
                out1 = logsig(out1);
                out1 = vertcat(out1,1);
                out = weights3 * out1;
                out = logsig(out);
                deltaOutput1 = zeros(no_of_classes,1);
                for j = 1:size(out,1)
                    t = 0;
                    if j == target(rowIter,1)+1
                        t = 1;
                    end
                    deltaOutput1(j,1) = (out(j) - t) * out(j) * (1 - out(j));
                end
                for j = 1:size(weights3,1)
                    for i = 1:size(weights3,2)
                        weights3(j,i) = weights3(j,i) - learning_rate * deltaOutput1(j,1) * out1(i,1);
                    end
                end
                deltaOutput2 = zeros(units_per_layer,1);
                for j = 1:size(out1,1)                    
                    sum = 0;
                    for u = 1:size(weights3,1)
                        sum = sum + (deltaOutput1(u) * weights3(u,j));
                    end
                    deltaOutput2(j,1) = sum * out1(j) * (1 - out1(j));
                end
                for j = 1:units_per_layer
                    for i = 1:no_of_attrs
                        weights1(j,i) = weights1(j,i) - learning_rate * deltaOutput2(j,1) * inputMatrix(rowIter,i);
                    end
                end                
            end
            r = r + 1;
            learning_rate = learning_rate * 0.98;            
        end
        %-------------------- output
        for rowIter = 1:size(testMatrix,1)
            transposeOut = double(transpose(testMatrix(rowIter,1:end)));
            transposeOut(end) = 1;
            testOut1 = weights1 * transposeOut;
            testOut1 = logsig(testOut1);
            testOut1 = vertcat(testOut1,1);
            testOut2 = weights3 * testOut1;
            testOut2 = logsig(testOut2);
            [val, index] = max(testOut2);
            test = testTarget(rowIter,1);
            accuracy = 0;
            if index-1 == test
                accuracy = 1;
                positive = positive + 1;            
            end        
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',rowIter-1,index-1,test,accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n',final);
    else
        weights1 = randi([-50 50], units_per_layer, no_of_attrs);
        weights1 = weights1 / 1000;
        weights1(:,end) = 1;
        weights2 = randi([-50 50], units_per_layer, units_per_layer+1);
        weights2 = weights2 / 1000;
        weights2(:,end) = 1;
        weights3 = randi([-50 50], no_of_classes,units_per_layer+1);
        weights3 = weights3 / 1000;
        weights3(:,end) = 1;
        r = 1;
        while r <= rounds
            for rowIter = 1:rows
                out1 = weights1 * transpose(inputMatrix(rowIter,1:end));
                out1 = logsig(out1);
                out1 = vertcat(out1,1);
                out2 = weights2 * out1;
                out2 = logsig(out2);
                out2 = vertcat(out2,1);
                out = weights3 * out2;
                out = logsig(out);
                deltaOutput1 = zeros(no_of_classes,1);
                for j = 1:size(out,1)
                    t = 0;
                    if j == target(rowIter,1)+1
                        t = 1;
                    end
                    deltaOutput1(j,1) = (out(j) - t) * out(j) * (1 - out(j));
                end
                for j = 1:size(weights3,1)
                    for i = 1:size(weights3,2)
                        weights3(j,i) = weights3(j,i) - learning_rate * deltaOutput1(j,1) * out2(i,1);
                    end
                end
                deltaOutput2 = zeros(units_per_layer,1);
                for j = 1:size(out2,1)                    
                    sum = 0;
                    for u = 1:size(weights3,1)
                        sum = sum + (deltaOutput1(u) * weights3(u,j));
                    end
                    deltaOutput2(j,1) = sum * out2(j) * (1 - out2(j));
                end
                for j = 1:units_per_layer
                    for i = 1:units_per_layer
                        weights2(j,i) = weights2(j,i) - learning_rate * deltaOutput2(j,1) * out1(i,1);
                    end
                end
                deltaOutput = zeros(size(out1,1));
                for j = 1:size(out1,1)
                    sum = 0;
                    for u = 1:size(weights2,1)
                        sum = sum + (deltaOutput2(u) * weights2(u,j));
                    end
                    deltaOutput(j,1) = sum * out1(j) * (1 - out1(j));
                end
                for j = 1:units_per_layer
                    for i = 1:no_of_attrs
                        weights1(j,i) = weights1(j,i) - learning_rate * deltaOutput(j,1) * inputMatrix(rowIter,i);
                    end
                end
            end
            r = r + 1;
        end
        %-------------------- output
        for rowIter = 1:size(testMatrix,1)
            transposeOut = double(transpose(testMatrix(rowIter,1:end)));
            transposeOut(end) = 1;
            testOut1 = weights1 * transposeOut;
            testOut1 = logsig(testOut1);
            testOut1 = vertcat(testOut1,1);
            testOut2 = weights2 * testOut1;
            testOut2 = logsig(testOut2);
            testOut2 = vertcat(testOut2,1);
            testOut = weights3 * testOut2;
            testOut = logsig(testOut);
            [val, index] = max(testOut);
            test = testTarget(rowIter,1);
            accuracy = 0;
            if index-1 == test
                accuracy = 1;
                positive = positive + 1;            
            end        
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',rowIter-1,index-1,test,accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n',final);
    end
end