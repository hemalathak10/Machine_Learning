function [] = linear_regression(fileName, degree, lambda)
    A = double(load(fileName));
    [r,c] = size(A);
    if degree == 1
        M = 2;
    else
        M = 3;
    end
    
    phi = [];
    T = [];
    for i = 1:r
        row = [];
        for j = 0:M-1
            p = A(i,1)^(j);
            row = [row(1:end) p];
        end
        phi = [phi(1:end) row];
        T = [T(1:end) A(i,2)];
    end
    P = vec2mat(phi,M);    
    PT = transpose(P);
    T = transpose(T);
    w1 = -1;
    w2 = -1;
    w3 = 0;
    
    tmp1 = PT * P;
    if lambda == 0        
        tmp2 = inv(vpa(tmp1));
        tmp3 = vpa(tmp2 * PT);     
        tmp = vpa(tmp3 * T);    
    else
        I = eye(M);
        L = vpa(lambda * I);
        tmp2 = vpa(L + tmp1);
        tmp3 = inv(tmp2);
        tmp4 = vpa(tmp3 * PT);
        tmp = vpa(tmp4 * T);
    end
    
    w1 = tmp(1);
    w1 = round(w1 * 10000) / 10000;
    w2 = tmp(2);
    w2 = round(w2 * 10000) / 10000;
    if degree ~= 1
        w3 = tmp(3);
        w3 = round(w3 * 10000) / 10000;
    end
    
    fprintf('w0=%.4f\n',w1);
    fprintf('w1=%.4f\n',w2);
    fprintf('w2=%.4f\n',w3);