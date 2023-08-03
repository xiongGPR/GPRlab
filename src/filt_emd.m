function result = filt_emd(Data,s,e,dir)
%emd, Empirical mode decomposition ; 经验模态分解
%   Input :  Data,  raw data  ; 原始数据
%            s, start; 开始
%            e, numbers of imf - e ; 结束, 最大的imf数减去e
%            dir, Horizontal direction is 0, vertical direction is 1F ; 方向，水平方向为0(行)，垂直方向为1（列）
%   Output： result

%  author  : Hongqiang  Xiong 
[nr,nc] = size(Data); 
result = zeros(nr,nc);
%% 异常处理
if s <= 0 || s >= 10 ||  e < 0
    result = Data;
    return   
end
%% 算法过程
if dir == 1
    for i = 1:1:nc  %深度向滤波
        A = emd(Data(:,i));
        if e<=size(A,2)
            result(:,i)= sum(A(:,s:end-e),2);
        else
            result(:,i)= sum(A(:,s:end-1),2);
        end
    end
else
    for j = 1:1:nr %水平向滤波
        A = emd(Data(j,:));
        if e<=size(A,2)
            result(j,:)= sum(A(:,s:end-e),2)';
        else
            result(j,:)= sum(A(:,s:end-1),2)'; 
        end
    end
end

end

