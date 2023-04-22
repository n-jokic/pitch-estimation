function T_p = final_estimator(PE,type, alpha)
% PE - array of pitch estimations
% type - function: median, mean, R value
% alpha - filtering factor, should be around 0.9-1
% Out: 
% T_p[ms] - final pitch estimation

T_p = zeros(length(PE{1}), 1);
current = zeros(length(PE) + 1, 1);

for i = 1 : length(PE)
    current(i+1) = PE{i}(1);
end

T_p(1) = median(current);

for i = 2 : length(T_p)

    current(1) = T_p(i-1);
    for j = 1 : length(PE)
        current(j+1) = PE{j}(i);
    end
    T_p(i) = alpha*type(current) + (1-alpha)*T_p(i-1);
end

med = median(T_p);
for i = 1 : length(T_p)
    if (T_p(i) < med/10)
        T_p(i) = med;
    end
end


end

