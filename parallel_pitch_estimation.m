function T_pitch = parallel_pitch_estimation(x, estimator_type ,fs, T_blanking, lambda, alpha)
% x - voice signal
% estimator_type - median, mean, R coef
% fs - sampling frequency [Hz]
% alpha - filtering factor for final estimator, between 0.9 - 1
% T_blankig[ms] - minimal duration of pich period 3.5-4.5ms
% lambda [1/ms] - limits maximal duration of pich period, between 1/6 - 1/8
% Out: 
% T_pitch [ms] - pitch period
[n,Wn] = buttord(800/(fs/2),1000/(fs/2),1,40);
[z,p,k] = butter(n,Wn, 'low');
[sos] = zp2sos(z,p,k);

x_filter = sosfilt(sos, x);

[n,Wn] = buttord(60/(fs/2), 70/(fs/2),1,40);
[z,p,k] = butter(n,Wn, 'high');
[sos] = zp2sos(z,p,k);
x_filter = sosfilt(sos, x_filter);



mi = pulse_generator(x_filter, fs);

PE = {};

for i = 1 : length(mi)
    PE{i} = pitch_estimator(mi{i}, T_blanking, lambda,fs);
end

T_pitch = final_estimator(PE, estimator_type, alpha);


end

