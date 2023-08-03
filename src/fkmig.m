function dmig=fkmig(d,dt,dx,rd,interpm)
 %  fkmig，FK migration algorithm;FK 偏移算法
%
%   Input :  d,  raw data  ; 原始数据
%            dt, time sampling interval ; 时间采样间隔
%            dx, Sampling interval(m) ; 道间距
%            rd, relative dielectric constant ; 相对介电常数
%            interpm,interpolation method ; 插值方法
%  Output : dmig,  2D data; 输出的2D数据 

%  author  : Hongqiang  Xiong     

if nargin<5
    interpm='linear';
end
     %%确定需要重要参数大小%%
[ns,ntr]=size(d);                                   %输入矩阵的行列大小
% fn=1/(2*dt);                                        %奈奎斯特采样频率（有什么意义？）
Range=(ns-1)*dt;                                    %时窗范围或总的双程时
layer_velocity  = 0.3/sqrt(rd);                       %速度为某行第一个参数，注意此处进行了转置
    %%原始数据的傅里叶变换和波速的确定%%

    vmig=layer_velocity(1);
    dz=(vmig)/2*Range/(ns-1);                                                                                       %纵向采样间隔，是否考虑了时间减半的效应？
    delt=dt;                                        %等效时间采样间隔
     %%补0，进行FFT(变换到kx-w域)%%
    zpad=zeros(ns,ntr);                            %这样的补0会使纵向为2的n次方（实际上是因为基2fft的原因，估计）
    fk=fft2([d;zpad]);                             %进行二维傅里叶变换
    clear zpad;                                    %清除zpad的内存
    fk=fftshift(fk);                               %移动频点到图像中心
    [nss,ntr]=size(fk);                            %傅里叶变换后数组的大小[nss,ntr]

    %%进行反傅里叶变换，计算偏移后的矩阵dimg的值%%
img = do_stolt(delt, dx, dz, vmig, fk, nss, ntr, interpm); %引用下面的solt插值函数，得到变换前需要的img矩阵
ds=ifft2(ifftshift(img));

dmig=real(ds(1:ns,:));                                     %取用实数部分，得到最终偏移的结果
end

    %%solt插值函数，将kx-w域 转换到 kx-kz域%%
function img = do_stolt(dt, dx, dz, vmig, fk, nw, nkx, interpm)%%%
    %%角频率%%（频率从负频率到整容频率，所以前面才用了fftshift函数进行直流分量的位移）
w0=-pi/dt;
dw=2*pi/(nw*dt);                                     %（w=2*pi*f，f=1/(N*TS)*K,K为整数）
w=[w0:dw:abs(w0)-dw]';                            %角频率数组
    %%波数kx域%%                                  （道理同上）
kx0=-pi/dx;
dkx=2*pi/(nkx*dx);
kx =[kx0:dkx:-kx0-dkx]';                         %kx波速数组（这里有个疑问是为什么不是abs了呢？）
    %%波数kz域%%                                   （道理同上）
nkz=nw;
kz0=-pi/dz;
dkz  = 2*pi/(nkz*dz);
kz=[kz0:dkz:-kz0-dkz]';                          % kz波速数组（这里有个疑问是为什么不是abs了呢？）  
kzi=[1:1:length(kz)]';                           %kz波数域数组个数
    %%solt插值%%
img=zeros(nw,nkx);                               %定义初值0
for ikx=1:nkx                                         %w-Kz实际上是纵向的一个转变，横向循环不变
    ks=sqrt(kx(ikx)^2+kz.^2);                    %波动方程给出的关系
    wz=sign(kz).*ks*vmig/2;                      %solt插值wz的计算（请看论文：基于 Stolt 偏移的探地雷达合成孔径成像研究-张春城），但是这里少个负号和论文相比
    img(:,ikx)=interp1(w,fk(:,ikx),wz,interpm,0);%按照wz进行插值运算，从新在频率域w上进行取值，插值函数类型由自己给定interpm              
    ij=find(ks);                                  %%缩放图像，发现ks非0元素的值，并将其位置给到ij（一维）,因为在公式中ks作为被除数不为0
    img(ij,ikx)=img(ij,ikx).*(vmig*0.5*abs(kz(ij))./ks(ij));% 这里表示论文中二维傅里叶反变换的函数部分，MATGPR中没有除2，这里除2.
    ji=setxor(kzi,ij);                           %计算两个交集的非，即计算为0的频率所在的位置。目的是去直流（发现直流分量并且移除）
    img(ji,ikx) = 0; 
end     
end
