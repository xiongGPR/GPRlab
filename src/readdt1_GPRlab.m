function [DATA,HD] = readdt1_GPRlab(path,file)
%  readdzt_GPRlab, Single channel DT1 file data reading;  单通道DT1文件数据读取
%
%   Input :  path,  file Path  ；文件路径
%            file, file name ; 文件名
%  Output : DATA,  2D data; 输出的2D数据 
%           HD，File header information ; 文件头信息
%  author  : Hongqiang  Xiong

%% Determine if there is a header file;判断是否有头文件
file_name = file(1:end-4);
files = dir(path);
for i = 1:length(files)
    [~, name, ext] = fileparts(files(i).name);
    if strcmpi(ext, '.HD') & name == file_name
        HD_name = files(i).name;
    end
end
if ~exist('HD_name');
    disp('No .rad files found in the specified folder.');
    HD = [];
    DATA = [];
    return;% IF non
end
%% Read header file first;先读取头文件
fid=fopen([path,HD_name],'r');  
HD  = readHD(fid);
fclose(fid);
%% Reading data, in fact, DT1 can read data without the file header;读数据 ，实际上DT1可以不要文件头就读出数据
fid = fopen([path,file],'rb');    
dt1 = dt1struct;     
h   = dimstruct;            
fseek(fid,h.samples,-1); 
samples = fread(fid,1,dt1.samples);      
tracedim= samples*2+128  ;                              
fseek(fid,-tracedim,1);  
max_traces = fread(fid,1,dt1.traces); 
i = 1;
fseek(fid,0,'bof');       
for j = 1:max_traces,
     i = i + 1;  
     trheaders(i-1) = readdt1traceheader(fid,j); 
     trace = fread(fid,samples,dt1.trace);
     DATA(:,i-1) = trace(:); 
     position = tracedim*j;    
     fseek(fid,position,-1);   
end 
fclose(fid);
end

function dt1 = dt1struct;
dt1.traces= 'float';
dt1.position= 'float';
dt1.samples= 'float';
dt1.topo= 'float';
dt1.x1= 'float';
dt1.bytes= 'float';
dt1.trac_num= 'float';
dt1.stack= 'float';
dt1.window= 'float';
dt1.x2= 'float';
dt1.x3= 'float';
dt1.x4= 'float';
dt1.x5= 'float';
dt1.x6= 'float';
dt1.x_rec= 'float';
dt1.y_rec= 'float';
dt1.z_rec= 'float';
dt1.x_tra= 'float';
dt1.y_tra= 'float';
dt1.z_tra= 'float';
dt1.time_zero= 'float';
dt1.zero= 'float';
dt1.x7= 'float';
dt1.time= 'float';
dt1.x8= 'float';
dt1.com0= 'float';
dt1.com1= 'float';
dt1.com2= 'float';
dt1.com3= 'float';
dt1.com4= 'float';
dt1.com5= 'float';
dt1.com6= 'float';
dt1.com7= 'float';
dt1.trace= 'int16';
end

function [dim]=dimstruct;
dim.tracl= 0;
dim.traces= 0;
dim.position= 4;
dim.samples= 8;
dim.topo= 12;
dim.x1= 16;
dim.bytes= 20;
dim.trac_num= 24;
dim.stack= 28;
dim.window= 32;
dim.x2= 36;
dim.x3= 40;
dim.x4= 44;
dim.x5= 48;
dim.x6= 52;
dim.x_rec= 56;
dim.y_rec= 60;
dim.z_rec= 64;
dim.x_tra= 68;
dim.y_tra= 72;
dim.z_tra= 76;
dim.time_zero= 80;
dim.zero= 84;
dim.x7= 88;
dim.time= 92;
dim.x8= 96;
dim.com0= 100;
dim.com1= 104;
dim.com2= 108;
dim.com3= 112;
dim.com4= 116;
dim.com5= 120;
dim.com6= 124;
dim.com7= 128;
end 

function trheader = readdt1traceheader(fid,j)
trheader.traces= fread(fid,1,'float');
trheader.position= fread(fid,1,'float');
trheader.samples= fread(fid,1,'float');
trheader.topo= fread(fid,1,'float');
trheader.x1= fread(fid,1,'float');
trheader.bytes= fread(fid,1,'float');
trheader.trac_num= fread(fid,1,'float');
trheader.stack= fread(fid,1,'float');
trheader.window= fread(fid,1,'float');
trheader.x2= fread(fid,1,'float');
trheader.x3= fread(fid,1,'float');
trheader.x4= fread(fid,1,'float');
trheader.x5= fread(fid,1,'float');
trheader.x6= fread(fid,1,'float');
trheader.x_rec= fread(fid,1,'float');
trheader.y_rec= fread(fid,1,'float');
trheader.z_rec= fread(fid,1,'float');
trheader.x_tra= fread(fid,1,'float');
trheader.y_tra= fread(fid,1,'float');
trheader.z_tra= fread(fid,1,'float');
trheader.time_zero= fread(fid,1,'float');
trheader.zero= fread(fid,1,'float');
trheader.x7= fread(fid,1,'float');
trheader.time= fread(fid,1,'float');
trheader.x8= fread(fid,1,'float');
trheader.com0= fread(fid,1,'float');
trheader.com1= fread(fid,1,'float');
trheader.com2= fread(fid,1,'float');
trheader.com3= fread(fid,1,'float');
trheader.com4= fread(fid,1,'float');
trheader.com5= fread(fid,1,'float');
trheader.com6= fread(fid,1,'float');
end


function HD = readHD(fid)
for i=1:6                     %Skip 6 lines;跳过6行 
    hdline      = fgetl(fid);
end;
hdline      = fgetl(fid);
HD.Num_traces       =  str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Samples_per_scan = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Signal_position  = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));  
hdline      = fgetl(fid);
hdline         = fgetl(fid);
HD.range       = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));   %mportant parameters, time window;重要参数，时窗
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Starting_position= str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline = fgetl(fid);
HD.Final_position   = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.spm   = str2num(hdline(findstr(hdline,'=')+1:length(hdline))); %Important parameters, sampling interval;重要参数，采样间隔
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.position_units   = hdline(findstr(hdline,'=')+1:length(hdline));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Nominal_Frequency= hdline(findstr(hdline,'=')+1:length(hdline));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Antenna_separation= str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Pulser_voltage   = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Number_of_stacks = str2num(hdline(findstr(hdline,'=')+1:length(hdline)));
hdline      = fgetl(fid);
hdline      = fgetl(fid);
HD.Survey_mode      = hdline(findstr(hdline,'=')+1:length(hdline));
end





