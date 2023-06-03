function M_data = Manual_gain(Data,point,time)

%Manual_gain, Manual gain ; 人工增益
%   Input :  Data,  raw data  ; 原始数据
%            point, Longitudinal gain point; 纵向增益点序列
%            time, Gain multiple corresponding to longitudinal gain point ; 纵向增益点对应的倍数序列

%   Output： M_data

%  author  : Hongqiang  Xiong 

[nr,nc] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算
points = str2num(point);                   %app处理表中保存的是文本数据，必须转换为数值数据
points(1) = 1;
points(end) = nr;
times = str2num(time);                     %app处理表中保存的是文本数据，必须转换为数值数据
if size(points) == size(times)
    F = griddedInterpolant(points,times);      %构建一维网格插值
    y = F(1:nr);                               %求得增益矩阵
    M_data = Data.*(y'*ones(1,nc));            %原始数据矩阵与增益矩阵对应相乘
else
     M_data = Data;
end
end

