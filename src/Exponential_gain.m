function E_data = Exponential_gain(Data,scale,exponent,start_times,last_times)
%Exponential_gain, Exponential gain; 指数增益，E_data = scale*t.^exponent
%   Input :  Data,  raw data  ; 原始数据
%            scale
%            exponent
%            start_times, Starting times ; 开始的倍数   
%            last_times, Ending times ; 结束的倍数
%   Output： E_data

%  author  : Hongqiang  Xiong 


[nr,nc] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算                   
t_0 = start_times^(1/exponent);
t_end = last_times^(1/exponent);
t = t_0:((t_end-t_0)/(nr-1)):t_end;
d = scale*t.^exponent;                    
E_data = Data.*(d'*ones(1,nc));             %原始数据矩阵与指数增益矩阵对应相乘
end