function T_pitch = pitch_detection(x, type,estimator_type ,fs, clipping ,ct, T_blanking, lambda, alpha)
% x - voice signal
% type - parallel, corellation
% estimator_type - median, mean, R coef
% clippping - clipping function for corellation estimation
% ct - clipping threshold (for corellation)
% fs - sampling frequency [Hz]
% alpha - filtering factor for final estimator, between 0.9 - 1
% T_blankig[ms] - minimal duration of pich period 3.5-4.5ms
% lambda [1/ms] - limits maximal duration of pich period, between 1/6 - 1/8
% Out: 
% T_pitch [ms] - pitch period

if strcmp(type, 'parallel')
    T_pitch = parallel_pitch_estimation(x, estimator_type, fs, T_blanking, lambda, alpha);
end

if strcmp(type, 'corellation')
    T_pitch = corellation_pitch_estimation(x, clipping ,ct, fs, T_blanking);
end

t = (0 : 1 : length(x)-1)/fs;
figure();
    plot(t, T_pitch);
    xlabel('t[s]');
    ylabel('$T_{pitch}$(t) [ms]');
    xlim([t(200), t(end-100)]);
    ylim([0, 20]);
    title('Estimacija pitch periode')
    

end

