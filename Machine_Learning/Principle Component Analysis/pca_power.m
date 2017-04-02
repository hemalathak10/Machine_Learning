function [] = pca_power(trngFile, testFile, m, iter)
    input = double(load(trngFile));
    input = input(:,1:end-1);
    D = size(input,2);
    ud = zeros(size(input,2),m);
    
    output = double(load(testFile));
    output = output(:,1:end-1);
    
    x = input;
    for d = 1:m
        sd = cov(x,1);
        b = randi([0 1],D,1);
        for i = 1:iter
            b = (sd * b) / norm(sd * b);
        end
        fprintf('Eigenvector %d\n',d);
        for i = 1:D
            fprintf('  %d: %.4f\n',i,b(i));
        end
        ud(:,d) = b;
        for n = 1:size(input,1)
            x(n,1:end) = x(n,1:end) - transpose(transpose(b) * transpose(x(n,1:end)) * b);
        end
    end
    projection_matrix = transpose(ud);
    f_of_x = projection_matrix * transpose(output);
    fprintf('\nTest object 0\n');
    for j = 1:m
        fprintf('  %d: %.4f\n',j,f_of_x(j, 1));
    end
end