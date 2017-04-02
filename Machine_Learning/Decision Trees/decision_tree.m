function [] = decision_tree(trngFile, testFile, option, pruning_threshold)
    %construct examples
    examples = double(load(trngFile));
    target = examples(:,end);    
    
    %construct attributes
    attr_size = size(examples,2) - 1;
    attributes = zeros(1,attr_size);
    for i = 1:attr_size
        attributes(i) = i;
    end
    
    %construct default
    values = unique(target);
    default = histc(target(:),values);
    default = default / size(target,1);
    
    %read the test data
    testData = double(load(testFile));
    testTarget = testData(:,end);
    
    %compute the training
    if isequal(option,'optimized') || isequal(option,'randomized')
        attr_tree = zeros(1,60);
        threshold_tree = zeros(1,60);
        gain_tree = zeros(1,60);
        attr_tree = attr_tree + -1;
        threshold_tree = threshold_tree + -1;
        gain_tree = gain_tree + -1;
        [tree, threshold, gain] = DTL(examples,attributes,default,pruning_threshold,option,attr_tree,threshold_tree,1,gain_tree);
        treeId = 0;
        printTrainingOutput(treeId, tree, threshold, gain);
        positive = 0;
        total = size(testTarget,1);
        for i = 1:size(testData,1)        
            k = 1;
            while k <= size(tree,2)
                if threshold(k) == -1 && gain(k) == -1
                    break;
                end
                if tree(k) == 0
                    break;
                end
                if testData(i,tree(k)) < threshold(k)
                    k = 2 * k;                    
                else
                    k = (2 * k) + 1;                    
                end
            end
            predicted = tree(k);
            actual = testTarget(i);
            accuracy = 0;
            if predicted == actual
                positive = positive + 1;
                accuracy = 1;
            end
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',i-1, predicted, actual, accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n', final);
    elseif isequal(option,'forest3')
        [tree1, threshold1, gain1] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 0;
        printTrainingOutput(treeId, tree1, threshold1, gain1);
        [tree2, threshold2, gain2] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 1;
        printTrainingOutput(treeId, tree2, threshold2, gain2);
        [tree3, threshold3, gain3] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 2;
        printTrainingOutput(treeId, tree3, threshold3, gain3);
        positive = 0;
        total = size(testTarget,1);
        for i = 1:size(testData,1)    
            prob1 = calculateTest(tree1, threshold1, gain1, testData, i, max(target));
            prob2 = calculateTest(tree2, threshold2, gain2, testData, i, max(target));
            prob3 = calculateTest(tree3, threshold3, gain3, testData, i, max(target));            
            prob = (prob1 + prob2 + prob3) / 3;
            [maxVal, maxIndex] = max(prob);
            predicted = maxIndex - 1;
            actual = testTarget(i);
            accuracy = 0;
            if predicted == actual
                positive = positive + 1;
                accuracy = 1;
            end
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',i-1, predicted, actual, accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n', final);
    elseif isequal(option,'forest15')
        [tree1, threshold1, gain1] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 0;
        printTrainingOutput(treeId, tree1, threshold1, gain1);
        [tree2, threshold2, gain2] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 1;
        printTrainingOutput(treeId, tree2, threshold2, gain2);
        [tree3, threshold3, gain3] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 2;
        printTrainingOutput(treeId, tree3, threshold3, gain3);
        [tree4, threshold4, gain4] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 3;
        printTrainingOutput(treeId, tree4, threshold4, gain4);
        [tree5, threshold5, gain5] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 4;
        printTrainingOutput(treeId, tree5, threshold5, gain5);
        [tree6, threshold6, gain6] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 5;
        printTrainingOutput(treeId, tree6, threshold6, gain6);
        [tree7, threshold7, gain7] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 6;
        printTrainingOutput(treeId, tree7, threshold7, gain7);
        [tree8, threshold8, gain8] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 7;
        printTrainingOutput(treeId, tree8, threshold8, gain8);
        [tree9, threshold9, gain9] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 8;
        printTrainingOutput(treeId, tree9, threshold9, gain9);
        [tree10, threshold10, gain10] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 9;
        printTrainingOutput(treeId, tree10, threshold10, gain10);
        [tree11, threshold11, gain11] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 10;
        printTrainingOutput(treeId, tree11, threshold11, gain11);
        [tree12, threshold12, gain12] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 11;
        printTrainingOutput(treeId, tree12, threshold12, gain12);
        [tree13, threshold13, gain13] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 12;
        printTrainingOutput(treeId, tree13, threshold13, gain13);
        [tree14, threshold14, gain14] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 13;
        printTrainingOutput(treeId, tree14, threshold14, gain14);
        [tree15, threshold15, gain15] = callDTL(examples,attributes,default,pruning_threshold,'randomized');
        treeId = 14;
        printTrainingOutput(treeId, tree15, threshold15, gain15);
        positive = 0;
        total = size(testTarget,1);
        for i = 1:size(testData,1)    
            prob1 = calculateTest(tree1, threshold1, gain1, testData, i, max(target));
            prob2 = calculateTest(tree2, threshold2, gain2, testData, i, max(target));
            prob3 = calculateTest(tree3, threshold3, gain3, testData, i, max(target));
            prob4 = calculateTest(tree4, threshold4, gain4, testData, i, max(target));
            prob5 = calculateTest(tree5, threshold5, gain5, testData, i, max(target));
            prob6 = calculateTest(tree6, threshold6, gain6, testData, i, max(target));
            prob7 = calculateTest(tree7, threshold7, gain7, testData, i, max(target));
            prob8 = calculateTest(tree8, threshold8, gain8, testData, i, max(target));
            prob9 = calculateTest(tree9, threshold9, gain9, testData, i, max(target));
            prob10 = calculateTest(tree10, threshold10, gain10, testData, i, max(target));
            prob11 = calculateTest(tree11, threshold11, gain11, testData, i, max(target));
            prob12 = calculateTest(tree12, threshold12, gain12, testData, i, max(target));
            prob13 = calculateTest(tree13, threshold13, gain13, testData, i, max(target));
            prob14 = calculateTest(tree14, threshold14, gain14, testData, i, max(target));
            prob15 = calculateTest(tree15, threshold15, gain15, testData, i, max(target));
            prob = (prob1 + prob2 + prob3 + prob4 + prob5 + prob6 + prob7 + prob8 + prob9 + prob10 + prob11 + prob12 + prob13 + prob14 + prob15) / 15;
            [maxVal, maxIndex] = max(prob);
            predicted = maxIndex - 1;
            actual = testTarget(i);
            accuracy = 0;
            if predicted == actual
                positive = positive + 1;
                accuracy = 1;
            end
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',i-1, predicted, actual, accuracy);
        end
        final = positive / total;
        fprintf('classification accuracy=%6.4f\n', final);
    end        
end