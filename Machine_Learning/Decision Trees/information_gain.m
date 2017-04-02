function [gain] = information_gain(examples, A, threshold)
%function [gain] = information_gain(trngFile, A, threshold)
    %examples = double(load(trngFile));
    target = examples(1:end,end);
    values = unique(target);
    default = histc(target(:),values);
    default = default / size(target,1);
    H_of_E = 0;
    for i = 1:size(default)
        if default(i) ~= 0
            H_of_E = H_of_E + (-default(i) * (log(default(i)) / log(2)));
        end
    end
    leftCount = 0;
    rightCount = 0;
    j = 1;
    k = 1;
    left = [];
    right = [];
    for i = 1:size(examples,1)
        if examples(i,A) >= threshold
            rightCount = rightCount + 1;
            right(j) = examples(i,end);
            j = j + 1;
        else
            leftCount = leftCount + 1;
            left(k) = examples(i,end);
            k = k + 1;
        end
    end
    total = leftCount + rightCount;
    if isempty(left)
        left(1) = 0;
    else
        l = size(left,2);
        left = histc(left(:),unique(left));
        left = left / l;
    end
    if isempty(right)
        right(1) = 0;
    else
        r = size(right,2);
        right = histc(right(:),unique(right));    
    right = right / r;
    end
    
    H_of_E1 = 0;
    for i = 1:size(left,1)
        if left(i) ~= 0
            H_of_E1 = H_of_E1 + (-left(i) * (log2(left(i))));            
        end
    end
    H_of_E1 = (leftCount / total) * H_of_E1;
    H_of_E2 = 0;
    for i = 1:size(right,1)
        if right(i) ~= 0
            H_of_E2 = H_of_E2 + (-right(i) * (log(right(i)) / log(2)));
        end
    end
    H_of_E2 = (rightCount / total) * H_of_E2;
    gain = H_of_E - H_of_E1 - H_of_E2;    
end