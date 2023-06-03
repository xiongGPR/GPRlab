function A_gain = Auto_gain(Data,length,type,Average)
%Auto_gain, automatic gain control; 自动增益控制
%   Input :  Data,  raw data  ; 原始数据
%            length, Overlapping window length; 重叠窗口长度
%            type, Types of automatic gain (liner,RMS,GRMS);   自动增益类型，liner线性自动增益，RMS自动增益，GRMS高斯-RMS自动增益
%            Average, Window mean; 窗口均值
%   Output： A_gain

%  author  : Hongqiang  Xiong   

[nr,nc] = size(Data);
%%%%%异常处理
length = floor(length);
if length <=0 || length >=nr
    length = floor(nr/8);
end

if nargin == 4, A_gain = Auto_gain_liner(Data,length,Average); end
if nargin<4
    switch type      %%%选择增益类型
        case'RMS'     %RMS自动增益
        A_gain = Auto_gain_RMS(Data,length);    
        case'GRMS'     %高斯RMS自动增益
        A_gain = Auto_gain_GRMS(Data,length);
    end
 end

%% 线性自动增益（好像效果不太好）
function liner_gain = Auto_gain_liner(Data,length,Average)

[nr,nc] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算
data = abs(Data);                          %对数据求绝对值
L = floor(length/2);                       %L 步进值，窗口的50%
A = [1,L:L:L*floor((nr-1)/L),nr];          %A 每列的增益点
%%%%%%%%%%%计算点的增益值矩阵d，二维矩阵%%%%%%%%%%%
d = ones(size(A,2),nc);
for i = 2:(size(A,2)-1)
    d(i,:) = Average./mean(data(A(i-1):A(i+1),:),1);
end
d(1,:) = d(2,:);                       %上边界  
d(end,:) = d(end-1,:);                 %下边界
%%%%%%%%%%%计算增益矩阵d_need,二维矩阵%%%%%%%%%%%%
[X,Y] = ndgrid(A,1:nc);             %构建二维网格
F = griddedInterpolant(X,Y,d);      %构建2维网格插值
[X1,Y1] = ndgrid(1:nr,1:nc);             %构建二维网格
d_need = F(X1,Y1);                       %求得增益矩阵
liner_gain = data.*d_need;              %原始数据矩阵与增益矩阵对应相乘
 %%%%注意，这个函数经过试验，插值速度是很快的，matlab的griddedInterpolant是非常便于做大型矩阵的插值，构建网格的方式，一定要非常注意！   
end


%% 基于RMS值的自动增益
function RMS_gain = Auto_gain_RMS(Data,length)
[ns, ntr] = size(Data);
iwagc = round(length/2);               % 窗口一半 
RMS_gain = zeros(ns, ntr);
%% 循环数据
for itr = 1:ntr                       % loop over all traces
    
    tr = Data(:,itr);                    % Current trace to process
    agcdata = zeros(ns,1);            % work array for agc'ed data         
% compute initial window for first datum 
    sum = 0.0;
    for i = 1:iwagc
        val = tr(i);
        sum = sum + val*val;
    end
    nwin = 2*iwagc+1;
    rms = sum/nwin;
    if rms <= 0.0 
        agcdata(1) = 0.0;
    else
        agcdata(1) = tr(1)/sqrt(rms);
    end
% ramping on 
    for i = 1:iwagc        
        val = tr(i+iwagc);
        sum = sum + val*val;
        nwin= nwin + 1;
        rms = sum/nwin;
        if rms <= 0.0
            agcdata(i) = 0.0;
        else 
            agcdata(i) = tr(i)/sqrt(rms);
        end
    end
% middle range -- full rms window 
    for i = iwagc+1 : ns-1-iwagc
        val = tr(i+iwagc);
        sum = sum + val*val;
        val = tr(i-iwagc);
        sum = sum - val*val; 
        rms = sum/nwin;
        if rms <= 0.0
            agcdata(i) = 0.0;
        else
            agcdata(i) = tr(i)/sqrt(rms);
        end
    end 
% ramping off 
    for i = ns-iwagc : ns
        val = tr(i-iwagc);
        sum = sum - val*val;
        nwin = nwin-1;
        rms = sum/nwin;
        if rms <= 0.0
            agcdata(i) = 0.0;
        else
            agcdata(i) = tr(i)/sqrt(rms);
        end
    end
% Trace finished - load onto output array
    RMS_gain(:,itr) = agcdata;                                     
end
end


%% 高斯RMS自动增益
function GRMS_gain = Auto_gain_GRMS(Data,length)
[ns, ntr] = size(Data);
%% 
GRMS_gain = zeros(ns,ntr);  %赋初值
iwagc = length;               % agc window in samples
EPS   = 3.8090232;
% Compute Gaussian window weights 
w   = zeros(iwagc,1); %窗口初始化
u   = EPS/iwagc;
u2  = u*u;

for i=1:iwagc
    w(i) = exp(-(u2*i*i));
end
d2 = zeros(ns,1);                    % Initialize sum of squares 
s  = zeros(ns,1);                    % Initialize weighted sum of squares

% loop over all traces
for itr = 1:ntr
    tr = Data(:,itr);                    % Current trace to process
    agcdata = zeros(ns,1);            % work array for agc'ed data 
% agc itr'th trace
    for i = 1:ns       %先求平方
        val     = tr(i);
        d2(i) = val * val;
        s(i)  = d2(i);
    end
    for j = 1:iwagc-1  %不够窗口长度的
        for i = j:ns
            s(i) = s(i) +( w(j)*d2(i-j+1));
        end
        k = ns - j;
        for i = 1:k
            s(i) = s(i) +( w(j)*d2(i+j));
        end
    end
    for i = 1:ns
        
        
        if ~s(i)
            agcdata(i) = 0.0;
        else
            agcdata(i) = tr(i)/sqrt(s(i));
        end
    end
    GRMS_gain(:,itr) = agcdata;
end                                    % itr loop over traces
        
end

end
