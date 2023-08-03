function H_filter_data = H_filter(Data,type,fs,stop1,pass1,pass2,stop2)
%H_filter, Horizontal one-dimensional filtering ; 水平一维滤波 

%   Input :  Data,  raw data  ; 原始数据
%            type, FIR or IIR; FIR 或 IIR
%            fs, sampling frequency ; 采样频率
%            stop1,pass1,pass2,stop2, stopband low frequency, passband low frequency, passband high frequency, stopband high frequency; 阻带低频，通带低频，通带高频，阻带高频
%   Output： H_filter_data

%  author  : Hongqiang  Xiong 


%% 异常处理代码段
if pass2>=fs/2 || stop2>=fs/2
   H_filter_data = Data;
   return
end
%%
data = Data';
%[nr,nc] = size(data);  %使用惯例nr表示行，ns表示列，便于后续计算,注意这里将原始矩阵转置
switch type                          %%%选择算法
    case'FIR'
        myfilter = designfilt('bandpassfir', 'StopbandFrequency1', stop1, 'PassbandFrequency1', pass1, 'PassbandFrequency2', pass2, 'StopbandFrequency2', stop2, 'StopbandAttenuation1', 40, 'PassbandRipple', 1, 'StopbandAttenuation2', 40, 'SampleRate', fs);
        H_filter_data = filtfilt(myfilter,data)';  %FIR滤波后得到的矩阵
    case'IIR'
        myfilter = designfilt('bandpassiir', 'StopbandFrequency1', stop1, 'PassbandFrequency1', pass1, 'PassbandFrequency2', pass2, 'StopbandFrequency2', stop2, 'StopbandAttenuation1', 40, 'PassbandRipple', 1, 'StopbandAttenuation2', 40, 'SampleRate', fs, 'DesignMethod', 'cheby2');
        H_filter_data = filtfilt(myfilter,data)';  %IIR滤波后得到的矩阵
end
end

