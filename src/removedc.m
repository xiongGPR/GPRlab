function ac = removedc( Data )
%  removedc, Remove DC component : 去除数据中的直流分量

%   Input :  Data,  the 2-D GPR section；原始数据
%
%   Output : ac

%  author  : Hongqiang  Xiong 

%data = table2array(Data);


[nr,nc] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算
dc = ones(nr,1)*mean(Data,1);              %运用一次矩阵乘法，求dc矩阵，
% dc = ones(ns,1)*mean(d(1:206,:),1);      %运用一次矩阵乘法，求dc矩阵,但是此处运用了d的一部分作为平均直流的计算，对应selected  sample interval模式
ac = Data - dc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The old fashioned way will not do any more ...
% ac       = zeros(ns,ntr); 
% h = waitbar(0,'Removing DC ...');
% for i=1:ntr; 
%     ac(:,i) = d(:,i) - mean(d(:,i)); 
%     waitbar(i/ntr,h);
% end;
% close(h);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return
end

