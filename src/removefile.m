function rgb = removefile(Data,filepath,filename)
%  removefile；  文件去背景
%
%   Input :  Data,  the 2-D GPR section；原始数据data，一般简称为data
%            filename; 文件名
%            filepath;文件路径
%  Output : rgb,  the reduced GPR section
%  author  : Hongqiang  Xiong 

gb = readmatrix([filepath,filename]) ;
[nr,nc] = size(Data);
if nr == size(gb,1)
    rgb = Data - repmat(gb,[1,nc]);
else 
    rgb = Data;
end
end

