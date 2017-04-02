function [prob] = calculateTest(tree, threshold, gain, testData, i, maxTarget)
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
    index = predicted + 1;
    prob = zeros(1,maxTarget+1);
    prob(index) = 1;
end