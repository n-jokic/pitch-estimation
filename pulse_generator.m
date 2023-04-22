function mi = pulse_generator(x, fs)
% x - voice signal
% fs - sampling frequency [Hz]
% Out: 
% mi - 6 pulse signals, used for pitch estimation

[maxima, max_idx] = findpeaks(x);
[minima, min_idx] = findpeaks(-x);
minima = -minima;
t = (0 : 1 : (length(x)-1))/fs;

figure();
    plot(t, x);
        xlabel('t[s]');
        ylabel('y_filtered');
        title('Lokalni min i maks filtriranog signala');
    hold('on');
    p = plot(max_idx/fs, maxima, 'r.');
    q = plot(min_idx/fs, minima, 'b.');   
    legend([p, q], {'M', 'm'}, 'Location', 'best');
    %xlim([0.08, 0.2]);


mi = {};
M = zeros(length(x), 1);
m = zeros(length(x), 1);
M(max_idx) = maxima;
m(min_idx) = minima;

for i = 1 : 6
    switch i
    case 1
        mi{i} = max(0, M);
    case 2
        mi{i} = max(0, M);

        for j = 2 : length(max_idx)
            mi{i}(max_idx(j)) = mi{i}(max_idx(j)) - M(max_idx(j-1));
        end
        
    case 3
        mi{i} = max(0, M);
        for j = 2 : length(max_idx)
            if (j-1) > length(min_idx)
                break
            end
            mi{i}(max_idx(j)) = mi{i}(max_idx(j)) - m(min_idx(j-1));
        end
    case 4
        mi{i} = max(0, -m );
    case 5
        mi{i} = max(0, -m );
        for j = 2 : length(min_idx)
            mi{i}(min_idx(j)) = mi{i}(min_idx(j)) + m(min_idx(j-1));
        end
    case 6
        mi{i} = max(0, -m );
        for j = 2 : length(min_idx)
            if (j-1) > length(max_idx)
                break
            end
            mi{i}(min_idx(j)) = mi{i}(min_idx(j)) + M(max_idx(j-1));
        end
    otherwise
        break;

    end
end

