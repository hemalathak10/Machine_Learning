function [] = printTrainingOutput(treeId, tree, threshold, gain)
    for i = 1:size(tree,2)
        feature = tree(i) - 1;
        if tree(i) == 0
            feature = -1;
        end
        if threshold(i) == -1 && gain(i) == -1
            feature = -1;
        end
        if threshold(i) ~= 0 && gain(i) ~= 0
            fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n',treeId, i, feature, threshold(i), gain(i));
        end
    end
end