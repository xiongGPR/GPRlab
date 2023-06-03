function [DATA, HD ] = readrd3_GPRlab(path,file)
%  readdzt_GPRlab, Single channel rd3 file data reading;  单通道rd3文件数据读取
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
    if strcmpi(ext, '.rad') & name == file_name
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
%% Reading data;读数据 
sample=HD.Samples_per_scan;
trace = HD.Last_trace;
fid=fopen([path,file],'r');
A=fread(fid,'short');
status=fclose(fid);
  for m=1:sample
       for n=1:trace
           DATA(m,n)=A((n-1)*sample+m);
       end
  end
  return;
end  

function HD = readHD(fid)
hdline         = fgetl(fid);
HD.Samples_per_scan   = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline         = fgetl(fid);
HD.Frequency          = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline         = fgetl(fid);
HD.Frequency_steps    = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline         = fgetl(fid);
HD.Signal_position    = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Raw_Signal_position= str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Distance_flag      = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Time_flag          = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Program_flag       = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.External_flag      = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Time_interval      = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.spm  = str2num(hdline(findstr(hdline,':')+1:length(hdline))); %Important parameters, sampling interval;重要参数，采样间隔
HD.Operator           = fgetl(fid);
HD.Customer           = fgetl(fid);
HD.Site               = fgetl(fid);
hdline = fgetl(fid);
HD.Antennas           = hdline(findstr(hdline,':')+1:length(hdline));
hdline                 = fgetl(fid); % Antenna orientation is not yet valid field
%HDR.Antenna_orientation= str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline                 = fgetl(fid);
HD.Antenna_separation = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
HD.Comment            = fgetl(fid);
hdline = fgetl(fid);
HD.range         = str2num(hdline(findstr(hdline,':')+1:length(hdline)));   %mportant parameters, time window;重要参数，时窗
hdline = fgetl(fid);
HD.Stacks             = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Stack_exponent     = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Stacking_time      = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Last_trace         = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
hdline = fgetl(fid);
HD.Stop_position      = str2num(hdline(findstr(hdline,':')+1:length(hdline)));
% HD.Comment = cat(2,HD.Operator,'  ',HD.Customer,'  ',HD.Site,'  ',...
% HD.Comment);
end