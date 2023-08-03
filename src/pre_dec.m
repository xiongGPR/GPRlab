function out = pre_dec(s,dear_t,n,alph)
%pre_dec, Prediction error deconvolution; 预测误差反褶积

%   Input :  s,  raw data  ; 原始数据
%            dear_t, time interval(ns); 时间采样间隔（ns）
%            n, operator length(ns) ; 算子时间长度（ns），一般应取小于1/2窗口长度。优选地，可以选择比主频持续周期长3倍即可，比如300MHZ天线，可以选择大约10ns
%            alph, Prediction step size(ns) ; 预测步长（ns），应小于算子长度（削弱多次波的使用中）。最好是多次波的周期。如果多次波周期大于算子长度，则调整算子长度即可。
%   Output： out

%  author  : Hongqiang  Xiong 


[ns, ntr]=size(s);
n = ceil(n/dear_t);%算子长度
alph = ceil(alph/dear_t);%预测步长
%% 异常情况处理
out = zeros(ns,ntr);
if n >= ns/2 || alph >= n
    out = s;
    return
end
%%
for i= 1:ntr
    w = s(:,i);
    cc = xcorr(w);
    ccc = cc(ns:n+ns-1);
    R1 = toeplitz(ccc);%左侧矩阵
    L = cc(ns+alph:alph+n+ns-1);%右侧矩阵
    c = R1\L;%反褶积因子
    co = conv(c,w);%求取预测序列
    cod = vertcat(zeros(alph,1),co);
    out(:,i) = s(:,i)-cod(1:ns);%求得结果，减去预测序列。
end
end
