function rewgb = removedwgb(Data,dw,s,e)

% removedwgb, Sliding window to remove background; 滑动窗口去背景
%   Input :  Data,  raw data  ; 原始数据
%            dw, Number of traces in the horizontal direction; 水平方向的道数
%            s, Vertical start position ; 纵向作用点开始位置   
%            e, Vertical end position ; 纵向作用点结束位置
%   Output： rewgb

%  author  : Hongqiang  Xiong 


[nr,nc] = size(Data); 
%%%%%%%%%%%%%%%异常处理%%%%%%%%%%%%%
if s <= 0 || s >= nr || e <= 0 || e > nr
    s = 1;
    e = nr;
end
if dw<=0 || dw>=nc/4
    dw = floor(nc/4);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%动态窗口去背景%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%动态平均去背景，采用窗口函数进行平均去背景,注意窗口N值需设为奇数，它作用是消除小的水平特征，一般不用该方法。
                                                             %使用惯例ns表示行，ntr表示列，便于后续计算
if mod(floor(dw), 2) == 0             %窗口大小N，只能为奇数
    N=floor(dw)+1;                           
else
    N=floor(dw); 
end
rewgb = Data;                     %将rgb赋值为原始数据
for  i = (N+1)/2:1:nc-(N-1)/2      %i为列循环
    rewgb(s:e,i) = Data(s:e,i)-mean(Data(s:e,(i-(N-1)/2):1:(i+(N-1)/2)),2);
end
%%%%%%%%%%%%%%%%处理两侧边缘，采用普通移除平均背景的方式%%%%%%%%%%%%%%%%%%%%%
%%%左侧
for i=1:((N+1)/2)-1
    rewgb(s:e,i) = Data(s:e,i)-mean(Data(s:e,1:(N+1)/2-1),2);
end
%%%右侧
for i=(nc-((N-1)/2)+1):nc
    rewgb(s:e,i) = Data(s:e,i)-mean(Data(s:e,(nc-((N-1)/2)+1):nc),2);
end

end

