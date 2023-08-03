%f-k滤波，by熊洪强
function fk_filter_data = f_k(s,dear_x,Lg,Ls)

%f_k, Fk filtering; Fk滤波
%   Input :  s,  raw data  ; 原始数据
%            dear_x, Sampling interval(m); 道间距
%            Lg, length (m) of low-frequency interference ; 低频干扰窗口长度Lg,单位m （代表低频参数，低频干扰窗口长度Lg,单位m，一般可取窗口长度一半以上）   
%            Ls, length (m) of high-frequency interference ; 高频干扰窗口长度Ls,单位m（代表高频参数，机械抖动最大位移Ls，单位m）
%   Output： fk_filter_data

%  author  : Hongqiang  Xiong 



Data = s;%读入原始数据
[nr,nc] = size(Data);  %使用惯例nr表示行，ns表示列，便于后续计算
%% 异常判断
if Lg <= Ls || Lg >= dear_x*(nc-1)/2
    fk_filter_data = s;
    return 
end
%%
data_fft = fft2(Data);%保存fft（Data后的值）
% N_pass1 = floor(2*(nc-1)*dear_x/Lg)+1;%低频点，李延军博士论文中取的窗口长度
% N_pass2 = floor(2*(nc-1)*dear_x/Ls)+1;%高频点，李延军博士论文中取的窗口长度
N_pass1 = floor((nc-1)*dear_x/Lg)+1;%低频点
N_pass2 = floor((nc-1)*dear_x/Ls)+1;%高频点
data_fft2 = zeros(nr,nc);%保存频域滤波后的矩阵
data_fft2(:,N_pass1:N_pass2)= data_fft(:,N_pass1:N_pass2);
data_fft2(:,(nc-N_pass2+2):(nc-N_pass1+2))= data_fft(:,(nc-N_pass2+2):(nc-N_pass1+2));
fk_filter_data = ifft2(data_fft2);  %ifft2傅里叶反变换得到滤波后的矩阵
end
