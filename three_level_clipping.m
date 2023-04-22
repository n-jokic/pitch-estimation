function x_clipped = three_level_clipping(x, ct)
% x - voice signal
% ct - clipping threshold (for corellation)
% Out: 
% x_clipped - clipped signal

x_clipped = x;
x_clipped(x <= ct & x >= -ct) = 0;
x_clipped(x >= ct) = 1;
x_clipped(x <= ct) = -1;

end

