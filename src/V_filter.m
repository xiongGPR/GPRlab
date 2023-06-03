function V_filter_data = V_filter(Data,type,fs,stop1,pass1,pass2,stop2)
%V_filter, Vertical one-dimensional filtering; 垂向1维滤波（含频域滤波，FIR等波纹滤波和IIR滤波）

%   Input :  Data,  raw data  ; 原始数据
%            type, Frequency Domain Filtering,FIR or IIR; 频域滤波，FIR 或 IIR
%            fs, sampling frequency ; 采样频率
%            stop1,pass1,pass2,stop2, stopband low frequency, passband low frequency, passband high frequency, stopband high frequency; 阻带低频，通带低频，通带高频，阻带高频
%   Output： V_filter_data

%  author  : Hongqiang  Xiong 

%% 异常处理代码段
if pass2>=fs/2 || stop2>=fs/2
   V_filter_data = Data;
   return
end
%%
[nr,nc] = size(Data);  %使用惯例nr表示行，ns表示列，便于后续计算
switch type                          %%%选择算法
    case 'Frequency domain filtering'
        data_fft = zeros(nr,nc);%提前开辟内存
        data_fft = fft(Data);%保存fft（Data后的值）
        N_pass1 = floor(pass1*(nr-1)/fs)+1;%低频点
        N_pass2 = floor(pass2*(nr-1)/fs)+1;%高频点
        data_fft2 = zeros(nr,nc);%保存频域滤波后的矩阵
        data_fft2(N_pass1:N_pass2,:)= data_fft(N_pass1:N_pass2,:);
        data_fft2((nr-N_pass2+2):(nr-N_pass1+2),:)= data_fft((nr-N_pass2+2):(nr-N_pass1+2),:);
        V_filter_data = ifft(data_fft2);  %ifft傅里叶反变换得到滤波后的矩阵 
    case'FIR'
        myfilter = designfilt('bandpassfir', 'StopbandFrequency1', stop1, 'PassbandFrequency1', pass1, 'PassbandFrequency2', pass2, 'StopbandFrequency2', stop2, 'StopbandAttenuation1', 40, 'PassbandRipple', 1, 'StopbandAttenuation2', 40, 'SampleRate', fs);
        V_filter_data = filtfilt(myfilter,Data);  %FIR滤波后得到的矩阵
    case'IIR'
        myfilter = designfilt('bandpassiir', 'StopbandFrequency1', stop1, 'PassbandFrequency1', pass1, 'PassbandFrequency2', pass2, 'StopbandFrequency2', stop2, 'StopbandAttenuation1', 40, 'PassbandRipple', 1, 'StopbandAttenuation2', 40, 'SampleRate', fs, 'DesignMethod', 'cheby2');
        V_filter_data = filtfilt(myfilter,Data);  %IIR滤波后得到的矩阵
end
end

