function [best_attr,best_thres,max_gain] = choose_attr(examples,attributes,option)
%function [best_attr,best_thres] = choose_attr(trngFile,attributes,option)
%    examples = double(load(trngFile));
    max_gain = -1;
    best_attr = -1;
    best_thres = -1;
    if isequal(option,'randomized')
        val = randi(size(attributes,2));
        best_attr = val;
        attribute_values = examples(1:end,val);
        L = min(attribute_values);
        M = max(attribute_values);
        for K = 0:50
            threshold = L + K * (M - L) / 51;
            gain = information_gain(examples,val,threshold);                
            if gain > max_gain
                max_gain = gain;                
                best_thres = threshold;
            end
        end   
    elseif isequal(option,'optimized')
        for i = 1:size(attributes,2)            
            attribute_values = examples(1:end,attributes(i));
            L = min(attribute_values);
            M = max(attribute_values);
            for K = 0:50
                threshold = L + K * (M - L) / 51;
                gain = information_gain(examples,attributes(i),threshold);                
                if gain > max_gain
                    max_gain = gain;
                    best_attr = attributes(i);
                    best_thres = threshold;
                end
            end
        end
    end
end