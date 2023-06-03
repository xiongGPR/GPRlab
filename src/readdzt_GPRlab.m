function [DATA, HD ] = readdzt_GPRlab(path,file)
%  readdzt_GPRlab, Single channel dzt file data reading;  单通道dzt文件数据读取
%
%   Input :  path,  file Path  ；文件路径
%            file, file name ; 文件名
%  Output : DATA,  2D data; 输出的2D数据 
%           HD，File header information ; 文件头信息
%  author  : Hongqiang  Xiong


%% read .dzt code ;这是一个读取单道dzt格式的代码
fid=fopen([path,file]);  
% fclose(fid);
HD.tag=fread(fid,1,'ushort');
HD.hd_size=fread(fid,1,'ushort'); 
if HD.hd_size == 512 
    fclose(fid); 
    return
end
HD.nsamp=fread(fid,1,'ushort');   
HD.bits=fread(fid,1,'ushort');    

HD.zero=fread(fid,1,'short');     

HD.sps=fread(fid,1,'float');      
HD.spm=fread(fid,1,'float');      %Number of scans per meter, if distance mode is used, there is a value here, if not, it is 0 here;每米扫描数，如果采用距离模式，则这里有值，如果没有，这里为0

if HD.spm ~= 0
    HD.spm = 1/HD.spm;
end

HD.mpm=fread(fid,1,'float');      
HD.position=fread(fid,1,'float'); 
HD.range=fread(fid,1,'float');    %Time window, important parameters;时窗，重要参数

HD.npass=fread(fid,1,'ushort');   

Create.sec2=fread(fid,1,'ubit5')*2;  
Create.min=fread(fid,1,'ubit6'); 
Create.hour=fread(fid,1,'ubit5');
Create.day=fread(fid,1,'ubit5'); 
Create.month=fread(fid,1,'ubit4'); 
Create.year=fread(fid,1,'ubit7')+1980; 

Modify.sec2=fread(fid,1,'ubit5')*2;  
Modify.min=fread(fid,1,'ubit6'); 
Modify.hour=fread(fid,1,'ubit5');
Modify.day=fread(fid,1,'ubit5'); 
Modify.month=fread(fid,1,'ubit4'); 
Modify.year=fread(fid,1,'ubit7')+1980; 
% 
HD.rgain=fread(fid,1,'ushort');  
HD.nrgain=fread(fid,1,'ushort'); 
HD.text=fread(fid,1,'ushort');   
HD.ntext=fread(fid,1,'ushort');  
HD.proc=fread(fid,1,'ushort');   
HD.nproc=fread(fid,1,'ushort');  

HD.nchan=fread(fid,1,'ushort');  
% 
HD.epsr=fread(fid,1,'float');    %Average dielectric constant;平均介电常数
HD.top=fread(fid,1,'float');     
HD.depth=fread(fid,1,'float');   
% 
reserved=fread(fid,31,'char');   
HD.dtype=fread(fid,1,'char');    
HD.antname=fread(fid,14,'char'); 
HD.chanmask=fread(fid,1,'ushort'); 
HD.name=fread(fid,12,'char');      
% HD.chksum=fread(fid,1,'ushort');  
% 
% HD.Gain=fread(fid,1,'ushort');
% HD.Gainpoints=fread(fid,HD.Gain,'float');
% HD.comments=setstr(fread(fid,HD.ntext,'char'));
% HD.proccessing=fread(fid,HD.nproc,'char');

fseek(fid,0,'bof');    
fseek(fid,1024,'bof');  

if HD.bits ==8
    d=fread(fid,[HD.nsamp inf],'uint8');
elseif HD.bits ==16
    d=fread(fid,[HD.nsamp inf],'uint16');
elseif HD.bits ==32
    d=fread(fid,[HD.nsamp inf],'uint32');
else
    d=fread(fid,[HD.nsamp inf],'uint64');
end

d(1,:)=d(3,:);      %The data in the first two rows is unreliable, use the third row instead;前2行的数据不靠谱，用第3行代替
d(2,:)=d(3,:);      
DATA = d;

fclose(fid); 
end