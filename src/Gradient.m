function Gradient_data = Gradient(Data,direction,scale,points)
%Gradient, Subtract values at certain intervals from each data and multiply by scale; 梯度，每道数据减去间隔一定位置的值，并乘以scale
%   direction 向上或向下间隔points
%   Input :  Data,  raw data  ; 原始数据
%            direction, points up or down; 向上或向下间隔points
%            scale   
%            points
%   Output： Gradient_data

%  author  : Hongqiang  Xiong 



[nr,~] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算
%% 异常处理
if points <= 0 || points>=nr/2
    points = 1;
end

down_L = nr-points;
up_L = 1+points;
if strcmp(direction,'down')
    Gradient_data(1:down_L,:) = scale*(Data(1:down_L,:)-Data((1+points):nr,:));%满足条件的采样点
    for i = (down_L+1):(nr-1)
        Gradient_data(i,:) = scale*(Data(i,:)-Data(nr,:));%不满足条件的采样点
    end
    Gradient_data(nr,:) = Gradient_data(nr-1,:);%最后一个点
elseif strcmp(direction,'up')
    Gradient_data(up_L:nr,:) = scale*(Data(up_L:nr,:)-Data(1:(nr-points),:));%满足条件的采样点
    for i = 1:(up_L-1)
        Gradient_data(i,:) = scale*(Data(i,:)-Data(1,:));%不满足条件的采样
    end
     Gradient_data(1,:) = Gradient_data(2,:);%第一个点
end
end

