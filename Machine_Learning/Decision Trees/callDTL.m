function [tree, threshold, gain] = callDTL(examples,attributes,default,pruning_threshold,option)
    attr_tree = zeros(1,60);
    threshold_tree = zeros(1,60);
    gain_tree = zeros(1,60);
    attr_tree = attr_tree + -1;
    threshold_tree = threshold_tree + -1;
    gain_tree = gain_tree + -1;
    [tree, threshold, gain] = DTL(examples,attributes,default,pruning_threshold,option,attr_tree,threshold_tree,1,gain_tree);