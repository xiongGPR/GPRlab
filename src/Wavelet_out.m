function Wavelet_out = Wavelet_out(Data,type,F_low,F_high,T_1,T_2,N_start,N_end,Timewindow,N_sample)

%Wavelet_out, Various wavelet filters(1Ddwt,2Ddwt,1cwt); 各种小波滤波（1Ddwt,2Ddwt,1cwt）

%   Input :  Data,  raw data  ; 原始数据
%            type, 1Ddwt,2Ddwt,1cwt; 
%            F_low, Cut-off low frequency ; 截止低频
%            F_high, Cut-off high frequency ; 截止高频
%            T_1,Start time in CWT ; CWT的开始时间（用于滤除的位置）
%            T_2, End time in CWT ; CWT的结束时间（用于滤除的位置）
%            N_start, Starting channel of CWT action; 作用起始道
%            N_end, End channel of CWT action;作用结束道
%            Timewindow; 时窗
%            N_sample; 采样点数

%   Output： Wavelet_out

%  author  : Hongqiang  Xiong 


%%
Wavelet_out = Data;
switch type                          %%%选择小波操作方式
    case'OneDdwt'     %1维离散小波去噪
        Wavelet_out = wdenoise(Data);  %采用sym4小波
    case'TwoDdwt'      %2维离散小波去噪
        Wavelet_out = wdenoise2(Data);  %采用sym4小波
    case'OneDcwt'        %1维连续小波滤波
        Timewindow = Timewindow*1e-9;
        Fs = N_sample/Timewindow;        
        F_low = F_low*1e6;            %低通频率
        F_high = F_high*1e6;          %高通频率
        T_1 = T_1*1e-9;              %作用时窗起点
        T_2 = T_2*1e-9;              %作用时窗终点,也就是说在T1=0后，T2不起作用
       %% 异常处理
         if F_high >= Fs/2  || T_2*1e9 > Timewindow || N_end > size(Data,2)  %在软件中时窗的单位是ns
            Wavelet_out = Data;
            return
         end
        %%
        for i= N_start:N_end
            [a,b] = cwt(Data(:,i),Fs);%a代表系数矩阵，b代表对应的频率
            [~,index_1]=min(abs(b-F_low));
            [~,index_2]=min(abs(b-F_high));
            if T_1 == 0 && T_1 == Timewindow
                a(index_2:index_1,:) = 0;%滤波，实质上就是将小波系数中的一部分矩阵变为0
            else
                a(index_2:index_1,floor(T_1*Fs):floor(T_2*Fs)) = 0;%滤波，实质上就是将小波系数中的一部分矩阵变为0
            end
            Wavelet_out(:,i) = icwt(a,'SignalMean',mean(Data(:,i)));%重构数据
        end
end
end

