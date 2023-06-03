function dmig=fkmig(d,dt,dx,rd,interpm)
 %  fkmig��FK migration algorithm;FK ƫ���㷨
%
%   Input :  d,  raw data  ; ԭʼ����
%            dt, time sampling interval ; ʱ��������
%            dx, Sampling interval(m) ; �����
%            rd, relative dielectric constant ; ��Խ�糣��
%            interpm,interpolation method ; ��ֵ����
%  Output : dmig,  2D data; �����2D���� 

%  author  : Hongqiang  Xiong     

if nargin<5
    interpm='linear';
end
     %%ȷ����Ҫ��Ҫ������С%%
[ns,ntr]=size(d);                                   %�����������д�С
% fn=1/(2*dt);                                        %�ο�˹�ز���Ƶ�ʣ���ʲô���壿��
Range=(ns-1)*dt;                                    %ʱ����Χ���ܵ�˫��ʱ
layer_velocity  = 0.3/sqrt(rd);                       %�ٶ�Ϊĳ�е�һ��������ע��˴�������ת��
    %%ԭʼ���ݵĸ���Ҷ�任�Ͳ��ٵ�ȷ��%%

    vmig=layer_velocity(1);
    dz=(vmig)/2*Range/(ns-1);                                                                                       %�������������Ƿ�����ʱ������ЧӦ��
    delt=dt;                                        %��Чʱ��������
     %%��0������FFT(�任��kx-w��)%%
    zpad=zeros(ns,ntr);                            %�����Ĳ�0��ʹ����Ϊ2��n�η���ʵ��������Ϊ��2fft��ԭ�򣬹��ƣ�
    fk=fft2([d;zpad]);                             %���ж�ά����Ҷ�任
    clear zpad;                                    %���zpad���ڴ�
    fk=fftshift(fk);                               %�ƶ�Ƶ�㵽ͼ������
    [nss,ntr]=size(fk);                            %����Ҷ�任������Ĵ�С[nss,ntr]

    %%���з�����Ҷ�任������ƫ�ƺ�ľ���dimg��ֵ%%
img = do_stolt(delt, dx, dz, vmig, fk, nss, ntr, interpm); %���������solt��ֵ�������õ��任ǰ��Ҫ��img����
ds=ifft2(ifftshift(img));

dmig=real(ds(1:ns,:));                                     %ȡ��ʵ�����֣��õ�����ƫ�ƵĽ��
end

    %%solt��ֵ��������kx-w�� ת���� kx-kz��%%
function img = do_stolt(dt, dx, dz, vmig, fk, nw, nkx, interpm)%%%
    %%��Ƶ��%%��Ƶ�ʴӸ�Ƶ�ʵ�����Ƶ�ʣ�����ǰ�������fftshift��������ֱ��������λ�ƣ�
w0=-pi/dt;
dw=2*pi/(nw*dt);                                     %��w=2*pi*f��f=1/(N*TS)*K,KΪ������
w=[w0:dw:abs(w0)-dw]';                            %��Ƶ������
    %%����kx��%%                                  ������ͬ�ϣ�
kx0=-pi/dx;
dkx=2*pi/(nkx*dx);
kx =[kx0:dkx:-kx0-dkx]';                         %kx�������飨�����и�������Ϊʲô����abs���أ���
    %%����kz��%%                                   ������ͬ�ϣ�
nkz=nw;
kz0=-pi/dz;
dkz  = 2*pi/(nkz*dz);
kz=[kz0:dkz:-kz0-dkz]';                          % kz�������飨�����и�������Ϊʲô����abs���أ���  
kzi=[1:1:length(kz)]';                           %kz�������������
    %%solt��ֵ%%
img=zeros(nw,nkx);                               %�����ֵ0
for ikx=1:nkx                                         %w-Kzʵ�����������һ��ת�䣬����ѭ������
    ks=sqrt(kx(ikx)^2+kz.^2);                    %�������̸����Ĺ�ϵ
    wz=sign(kz).*ks*vmig/2;                      %solt��ֵwz�ļ��㣨�뿴���ģ����� Stolt ƫ�Ƶ�̽���״�ϳɿ׾������о�-�Ŵ��ǣ������������ٸ����ź��������
    img(:,ikx)=interp1(w,fk(:,ikx),wz,interpm,0);%����wz���в�ֵ���㣬������Ƶ����w�Ͻ���ȡֵ����ֵ�����������Լ�����interpm              
    ij=find(ks);                                  %%����ͼ�񣬷���ks��0Ԫ�ص�ֵ��������λ�ø���ij��һά��,��Ϊ�ڹ�ʽ��ks��Ϊ��������Ϊ0
    img(ij,ikx)=img(ij,ikx).*(vmig*0.5*abs(kz(ij))./ks(ij));% �����ʾ�����ж�ά����Ҷ���任�ĺ������֣�MATGPR��û�г�2�������2.
    ji=setxor(kzi,ij);                           %�������������ķǣ�������Ϊ0��Ƶ�����ڵ�λ�á�Ŀ����ȥֱ��������ֱ�����������Ƴ���
    img(ji,ikx) = 0; 
end     
end
