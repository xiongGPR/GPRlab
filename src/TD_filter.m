function TD_data = TD_filter(Data,type,rows,columns)
%TwoD_filter, two dimensional filtering; 二维滤波
%
%   Input :  Data,  raw data  ; 原始数据
%            type, Median filtering or mean filtering; 中值滤波或均值滤波
%            rows
%            columns
%  Output : TD_data,  2D data; 输出的2D数据 

%  author  : Hongqiang  Xiong  

[nr,nc] = size(Data);  %使用惯例nr表示行，ns表示列，便于后续计算
M = 2*floor(rows/2);   %保证具有中心的模板行
N = 2*floor(columns/2);%保证具有中心的模板列
switch type                          %%%选择算法
    case 'median filter'
        TD_data = medfilt2(Data,[M,N],'symmetric');%中值滤波
    case'mean filter'
        h = fspecial('average',[M,N]);%创建二维滤波器
        TD_data = imfilter(Data,h,'replicate');%图像滤波
end
end

