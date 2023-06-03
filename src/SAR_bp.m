function Sar = SAR_bp(s,tw,derta_xx,alph,P,Permittivity_1,Permittivity_2)

%  SAR_bp，Synthetic aperture focusing imaging; 合成孔径聚集成像
%
%   Input :  s,  raw data  ; 原始数据
%            tw, Time window ; 时窗
%            derta_xx, Sampling interval(m) ; 道间距
%            alph, Antenna beam angle ; 天线波束角
%            P, Vertical sampling points of the interface ; 分界面的纵向采样点
%            Permittivity_1, Relative dielectric constant of the first layer ; 第一层的相对介电常数
%            Permittivity_2, Relative dielectric constant of the second layer ; 第二层的相对介电常数
%  Output : Sar,  2D data; 输出的2D数据 

%  author  : Hongqiang  Xiong 


c=2.998e+8/sqrt(Permittivity_1);  %第一层介质波速
v=2.998e+8/sqrt(Permittivity_2);  %第二层介质波速
[M,N]=size(s);%求出原始数据的行列值
Sar=s;          %这里可否直接将Sar赋值为s？？？？？？？？？？？
derta_n=(tw/(M-1))*10^-9;%每个采样表示的时间（derta_n=时窗/采样点数），这里可能只有511个点
nnn1=derta_n*c*0.5;%每个采样点间的间距（第一层介质中）
nnn2=derta_n*v*0.5;%每个采样点间的间距（第二层介质中）
nn1=derta_n*c*(alph*pi/180)*0.5;%空气中每个采样点间隔对应的孔径长度，这里要注意双程时的影响
nn2=derta_n*v*(alph*pi/180)*0.5;%介质中每个采样点间隔对应的孔径长度，这里要注意双程时的影响
%以下参数，目的是为了，在求取单点延时矩阵时，能够减少运算量
Permittivity1=sqrt(Permittivity_2);
Permittivity2=sqrt(Permittivity_2-1);
Permittivity3=Permittivity1/Permittivity2;
H=(P-1)*nnn1;%天线高度，也可以直接设定
% 希望将孔径的长度算出来，然后再将延时算出来(孔径矩阵和孔径对应的延时矩阵)
%% 异常判断  先写着，暂时不考虑位置
if P >= M || P <= 1
    P = M;
    Permittivity_2 = Permittivity_1;
end
if (nn1*(P-1)+(M-P)*nn2)/derta_xx >= N-5  %也就是说最后一个点合成孔径的大小，直接超过了整个矩阵的列数.N-5是为了保证稳定性。
    return
end    
%还需要考虑孔径长度超过道数的情况，这种异常情况下就直接赋值原来的数据
%%
for i=1:M
        R=nnn1*(i-1);
        %判断该点位于空气还是介质，计算不同的孔径数目
        if i<=P
        n=nn1*(i-1)/derta_xx;%孔径长度对应的道数，在空气中
        else
            n=(nn1*(P-1)+(i-P)*nn2)/derta_xx;
        end
        g=round(n);
        %%%%判断道数的位移数目，按偶数模式判断，李晓娟论文中提及的方法%%%%
        if (g>2)&&(mod(g,2)==0)
            N_number=g;
        else
            if (g>2)&&(mod(g,2)==1)&&g>n
                N_number=g-1;
            else
                if (g>2)&&(mod(g,2)==1)&&g<n
                    N_number=g+1;
                else
                    N_number=0;
                end
            end
        end    
        %计算每一行对应的延时（区分上下界面点的延时），矩阵，这里可以构成的最好是一个二维矩阵，且矩阵的列应该是不同的。
    if N_number~=0
      for j=1:N  %保证所有的值都有矩阵对应，进行列循环
      sum_m=s(i,j);
        %%%%%%%%情况1，假设点Q位于界面P上方，则延时比较好计算：
        for k=1:N_number/2%%%%%%%%%%%（倒着数的）
             if i<=P%界面上
                    s0=2*R;
                    ss=2*sqrt(R*R+k*k*derta_xx*derta_xx);
                    %%相当于邻域插值%%%                   
                    tt=(ss-s0)/c;%延时                 
                    T_number=round(tt/derta_n);%延时四舍五入，这样的话就会相当于邻域插值
             else%界面下
                %%%%%%%%%%%界面下方，还要判断Q点位置，计算反射点，利用第二套理论
                %%%%%%%%%%% 第一步，求到反射点：
                 z0=nnn2*(i-P);
                 xk=k*derta_xx;
                 %%%%%注意该反射点位于前方（只计算前后方一个点即可）%%%%
                 x1=z0*xk/(H+z0);                                              
                 if  xk<=(H+z0)*Permittivity3%判断用哪个反射点计算公式
                     xr=x1/Permittivity1;
                 else
                     xr=z0/Permittivity2;
                 end
                 %计算位于点下面的延时
                    t0=2*H/c+2*z0/v;
                    %%相当于邻域插值%%%
                    T=2*sqrt(H*H+(xk-xr)*(xk-xr))/c+2*sqrt(z0*z0+xr*xr)/v;%当聚焦点位于第二层介质中的旅行时间
                    tt=T-t0;%延时                 
                    T_number=round(tt/derta_n);%延时四舍五入，这样的话就会相当于邻域插值
             end
             if (i+T_number)<=M&&j>=N_number&&j<=N-N_number       %求和，对应每一个道,边缘采用镜像法处理
                 sum_m=sum_m+s(i+T_number,j-k)+s(i+T_number,j+k);
             elseif (i+T_number)<=M&&j<N_number
                 sum_m=sum_m+2*s(i+T_number,j+k);
             elseif(i+T_number)<=M&&j>N-N_number
                 sum_m=sum_m+2*s(i+T_number,j-k);
             else
                 break;
             end
        end
            Sar(i,j)=sum_m/(N_number+1);%取了平均计算，但是我认为这样不好。最好的是加入一个窗口函数。
      end
    end
        
end
