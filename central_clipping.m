function x_clipped = central_clipping(x, ct)
% x - voice signal
% ct - clipping threshold (for corellation)
% Out: 
% x_clipped - clipped signal

x_clipped = x;
x_clipped(x <= ct & x >= -ct) = 0;
end

