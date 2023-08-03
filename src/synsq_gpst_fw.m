function [Tx, fs,Wx] = synsq_gpst_fw(x, dt,A)
%  SS-GPST
% output:
%   Tx  SSPGST
%   fs  frequency
%   Wx  PGST
% input:
%   x  signal
%   dt  sampling interval
%   A   Generalized parameter 
%------------------------------------------------------------------------
%    Authors: Xiong Hongqiang
%    2023/4/1
%---------------------------------------------------------------------------------
%% 
if nargin<3, A = 1/sqrt(3); end
if nargin<2, error('Too few input arguments'); end
%% Calculate PGST
[Wx,fs,dWx,f] = GPST_fw(x,dt,A);  
out = abs(Wx);
w= phase_gpst(Wx,dWx,dt);%Calculate instantaneous frequency
%% Calculate the synchrosqueezed frequency decomposition 
	[na, N] = size(Wx);
 	scaleterm = f;
	Wx(isinf(w)) = 0;       
	Tx = zeros(length(fs),size(Wx,2));  
    for b=1:N
        for ai=1:length(fs)
            % Find w_l nearest to w(a_i,b)
            [V,k] = min(abs(w(ai,b)-fs));   
             Tx(k, b) = Tx(k, b) + Wx(ai, b) /scaleterm(ai);
        end
    end
end


    




