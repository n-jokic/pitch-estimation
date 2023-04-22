function Tp = corellation_pitch_estimation(x, clipping ,ct, fs, T_blanking)
% x - voice signal
% clippping - clipping function for corellation estimation
% ct - clipping threshold (for corellation)
% T_blankig[ms] - minimal duration of pich period 3.5-4.5ms
% fs - sampling frequency [Hz]
% Out: 
% T_pitch [ms] - pitch period
N = 200;
x_clipped = clipping(x, ct);
N_blanking = round(T_blanking*fs/1000);

[r,lags] = xcorr(x,N,'normalized');   

r = r(lags >= 0);
lags = lags(lags >= 0);


[r_cl,lags_cl] = xcorr(x_clipped,N,'normalized');   

r_cl = r_cl(lags_cl >= 0);
lags_cl = lags_cl(lags_cl >= 0);

[peaks, locs] = findpeaks(r_cl, 'MinPeakHeight', 0.2);

figure();
    p = plot(lags/fs*1000, r, 'r--');
    hold('on');
    q = plot(lags_cl/fs*1000, r_cl,'k');
    m = plot(locs(1)/fs*1000, peaks(1), 'b.');
        xlabel('$\tau$ [ms]');
        ylabel('$r_{xx}(\tau)$');
        title('Autokorelaciona funkcija');
   legend([p, q, m], {'original', 'clipped', '$T_{pich}$'}, 'Location','best');

Tp = zeros(length(x), 1);

pad = zeros(N, 1);
x_temp = [pad; x];
x_clipped = clipping(x_temp, ct);

for i = 1 : length(x)

    if (i*N) > length(x)
        break
    end

    [r_cl,lags_cl] = xcorr(x_clipped((i-1)*N + 1 :i*N),N,'normalized');   

    %figure();
    %plot(lags_cl/fs*1000, r_cl,'k');

    r_cl = r_cl(lags_cl >= 0);
    [~, idx] = max(r_cl(N_blanking:end));
    idx = idx + N_blanking;


    for j = 1 : N
        Tp((i-1)*N + j) = idx/fs*1000;
    end
    

    %if i == 100
    %    break;
    %end

end

end

