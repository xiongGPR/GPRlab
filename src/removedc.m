function ac = removedc( Data )
%  removedc, Remove DC component : ȥ�������е�ֱ������

%   Input :  Data,  the 2-D GPR section��ԭʼ����
%
%   Output : ac

%  author  : Hongqiang  Xiong 

%data = table2array(Data);


[nr,nc] = size(Data);                      %ʹ�ù���nr��ʾ�У�nc��ʾ�У����ں�������
dc = ones(nr,1)*mean(Data,1);              %����һ�ξ���˷�����dc����
% dc = ones(ns,1)*mean(d(1:206,:),1);      %����һ�ξ���˷�����dc����,���Ǵ˴�������d��һ������Ϊƽ��ֱ���ļ��㣬��Ӧselected  sample intervalģʽ
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

