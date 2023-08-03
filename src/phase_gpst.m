function w= phase_gpst(Wx, dWx,dt)
% Calculate instantaneous frequency
%   w       instantaneous frequency
%   Wx      GPST
%   fs      frequency
%   dWx     Differentiation of GPST
%------------------------------------------------------------------------
%    Authors: Xiong Hongqiang
%    2023/4/1
%---------------------------------------------------------------------------------

 [M,N] = size(Wx);
 w = abs(imag(dWx./Wx/(2*pi))); %
 w(abs(Wx)<eps) = Inf;   
end

