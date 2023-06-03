function rgb = removegb(Data,s,e)

% removegb, Global background removal; 全局去背景
%   Input :  Data,  raw data  ; 原始数据
%            dw, Number of traces in the horizontal direction; 水平方向的道数
%            s, start trace of background ; 背景的开始道
%            e, end trace of background; 背景的结束道
%   Output： rgb

%  author  : Hongqiang  Xiong 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%软件中的静态去背景%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nr,nc] = size(Data);
if e > nc
    e = nc;
end
gb = mean(Data(:,s:e),2); 
gb = repmat(gb,[1,nc]);%背景矩阵
rgb = Data-gb;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%静态去背景（原来的程序）%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %gb= mean(d(:,s:e),2)*ones(1,ntr);                         %运用一次矩阵乘法，求gb矩阵，对应RGB:CAL模式
% % gb = mean(d(:,1:200),2)*ones(1,ntr);         % 运用一次矩阵乘法，求gb矩阵,但是此处运用了d的一部分作为背景计算，对应对应RGB:CAL模式可选择的参数
% % b=xlsread('300M_23(16248)ac.xlsx') ;           % 用其他数据作为背景计算，对应对应RGB:PRE模式可选择的参数
% % gb=mean(b,2)*ones(1,ntr);
   %rgb = d - gb;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%动态窗口去背景%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态平均去背景，采用窗口函数进行平均去背景,注意窗口N值需设为奇数，它作用是消除小的水平特征，一般不用该方法。
% [ns,ntr] = size(d);                                                              %使用惯例ns表示行，ntr表示列，便于后续计算
% N=31;                            %窗口大小N，只能为奇数
% rgb = d;                     %将rgb赋值为d，这样可以保证边缘数据不处理，直接用不处理的数据代替
% for  i=(N+1)/2:1:ntr-(N+1)/2;      %i为列循环，这里这样做是为了保证边缘数据得到运算
% rgb(:,i)=d(:,i)-mean(d(:,(i-(N-1)/2):1:(i+(N-1)/2)),2);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return
end
