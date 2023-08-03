function result = filt_vmd(Data,s,e,num_imf,dir)
%vmd, Variational mode decomposition ; 变分模态分解
%   Input :  Data,  raw data  ; 原始数据
%            s, start; 开始
%            e, end ; 结束
%            num_imf, number of IMF （max 10） ; IMF的数量，最大不超过10
%            dir, Horizontal direction is 0, vertical direction is 1F ; 方向，水平方向为0(行)，垂直方向为1（列）
%   Output： result

%  author  : Hongqiang  Xiong 
[nr,nc] = size(Data); 
result = zeros(nr,nc);
%% 异常处理
if s <= 0 || s >= e ||  e > 10
    result = Data;
    return   
end
%% 算法过程
if dir == 1
    for i = 1:1:nc  %深度向滤波
        A = vmd(Data(:,i),'NumIMF',num_imf);
        result(:,i)= sum(A(:,s:e),2);
    end
else
    for j = 1:1:nr %水平向滤波
        A = vmd(Data(j,:),'NumIMF',num_imf);
        result(j,:)= sum(A(:,s:e),2)';
    end
end

end



