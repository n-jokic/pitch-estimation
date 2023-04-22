function PE_final = pitch_estimator(mi, T_blanking, lambda, fs)
% mi - pulse signal used for pitch estimation
% T_blanking[ms] - blanking period, 3.5 - 4.5ms, limits pitch value
% lambda[1/ms] - used for limiting pitch duration, 1/lambda  = 6-8ms
% fs - sampling frequency [Hz]
% Out: 
% PE_final - pitch estimation for given mi


N_blanking = round(T_blanking*fs/1000);
PE = zeros(length(mi), 1);


t = (0 : 1 :length(mi))/fs;
decay = exp(-lambda*t*1000);

not_done = true;
idx = find(mi, 1);
A = mi(idx);
start = idx;
idx = idx + N_blanking;

idx_exp = 1;
while not_done

    if mi(idx) >= A*decay(idx_exp)
        Tp = idx_exp/fs*1000 + T_blanking;
        A = mi(idx);
        
        PE(start:idx) = Tp;
        
        start = idx;
        idx = idx + N_blanking - 1;
        idx_exp = 0;
    end

    idx = idx + 1;
    idx_exp = idx_exp + 1;

    if idx > length(mi)
        not_done = false;
    end
end


PE_final = PE(1:length(mi));


end

