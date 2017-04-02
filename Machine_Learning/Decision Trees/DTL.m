function [attr_tree, threshold_tree, gain] = DTL(examples, attributes, default, pruning_thres,option,attr_tree,threshold_tree,index,gain)
% function [attr_tree, threshold_tree] = DTL(trngFile, attributes, default, pruning_thres,option,attr_tree,threshold_tree,index)
%      if index == 1
%          examples = double(load(trngFile));
%      else
%          examples = trngFile;
%      end
    if size(examples,1) == 0
        return;
    end
    target = examples(:,end);
    if size(examples,1) < pruning_thres
    %if size(examples,1) <= 1
        values = unique(target);
        default = histc(target(:),values);
        default = default / size(target,1);
        [maxVal,maxIndex] = max(default);        
        attr_tree(index) = values(maxIndex);
        threshold_tree(index) = -1;
        gain(index) = -1;        
    elseif size(unique(target)) == 1
        attr_tree(index) = unique(target);            
        threshold_tree(index) = -1;
        gain(index) = -1;
    else
        [best_attr, best_thres, best_gain] = choose_attr(examples,attributes,option);
        attr_tree(index) = best_attr;
        threshold_tree(index) = best_thres;
        gain(index) = best_gain;
        left_examples = [];
        right_examples = [];
        k = 1;
        j = 1;
        for i = 1:size(examples,1)
            if examples(i,best_attr) >= best_thres
                right_examples(j,:) = examples(i,1:end);
                j = j + 1;
            else
                left_examples(k,:) = examples(i,1:end);
                k = k + 1;
            end
        end
        left_index = index * 2;
        right_index = left_index + 1;
        attributes_left = zeros(1,left_index);
        for i = 1:left_index
            attributes_left(i) = i;
        end
        attributes_right = zeros(1,right_index);
        for i = 1:right_index
            attributes_right(i) = i;
        end
        [attr_tree, threshold_tree, gain] = DTL(left_examples, attributes, default, pruning_thres, option, attr_tree, threshold_tree, left_index,gain);
        [attr_tree, threshold_tree, gain] = DTL(right_examples, attributes, default, pruning_thres, option, attr_tree, threshold_tree, right_index,gain);        
    end    
end