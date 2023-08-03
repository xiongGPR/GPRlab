function rgb = remove_svd( Data,number )
%  remove_svd ,singular value decomposition(SVD): 对数据进行奇异性分解计算(SVD)

%   Usage : rgb = remove_svd( Data );交流电用AC表示
%
%   Input :  Data,  the 2-D GPR section；原始数据Data
%            number, Deleted eigenvalues in the S-matrix; S矩阵中从第一个开始，取出的特征层数(删除的前几个特征值)
%   Output : rgb,  执行完成奇异性分解后的数据矩阵

%  author  : Hongqiang  Xiong 


[nr,nc] = size(Data);                      %使用惯例nr表示行，nc表示列，便于后续计算
[U,S,V] = svd(Data);
if number < 0 || number > nc|| number > nr
    number = 1;
end

for i=1:number
    S(i,i) = 0;          %特征值矩阵中的每个元素相当于含有该图片中的最多信息的相关因子，因此把它赋值为0就相当于去除了背景
end
rgb = U*S*V';
end

