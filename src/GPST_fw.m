function [Wx,fs,dWx,as] = GPST_fw(x, dt, M)
%  GPST
% output:
%   Wx  GPST
%   fs  frequency
%   dWx  Differential of GPST
%   as  Normalized frequency
% input:
%   x  signal
%   dt  sampling interval
%   M   Generalized parameter 
%------------------------------------------------------------------------
%    Authors: Xiong Hongqiang
%    2023/4/1
%---------------------------------------------------------------------------------

%% 
x = x(:); % Turn into column vector
n = length(x);
xMean = mean(x);
x = x-xMean;       % remove DC    
noct = fix(n/2);  
as = 1:1:noct;
as = 1/(n):1/(n):1*noct/(n);
    %%  initialization    
    Wx = zeros(noct, n);       
    dWx = Wx;                  
	opt.dt = dt;              
    
    x = x(:).';                
    xh = fft(x);               
    
	k = 0:(n-1);
    xi = zeros(1, n);
    xi = 2*pi/n*[0:n-1];          
 %%  Finding the Differential of GPST and GPST Based on the Characteristics of Fourier Transform
 psihfn = @(w) 1/M*exp(-0.5/M^2*(w-2*pi).^2);
    for ai = 1:noct                         
        a = as(ai);                        
 		psih = psihfn(xi/a) * M;
		dpsih = (i*xi/opt.dt) .* psih;      
        xcpsi = ifft(psih .* xh);
        Wx(ai, :) = xcpsi;
        dxcpsi = ifft(dpsih .* xh);
        dWx(ai, :) = dxcpsi;               
    end
      fs = as/dt; 

end