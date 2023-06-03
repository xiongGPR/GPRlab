function Hl = Hl(Data,type)
%Hl, Hilbert attribute analysis (Instantaneous amplitude, instantaneous phase, instantaneous frequency);希尔伯特属性分析（含瞬时振幅、瞬时相位和瞬时频率）

%   Input :  Data,  raw data  ; 原始数据
%            type, Instantaneous amplitude, instantaneous phase,instantaneous frequency; 瞬时振幅，瞬时相位，瞬时频率
%   Output： Hl

%  author  : Hongqiang  Xiong 
[nr,nc] = size(Data);  %使用惯例nr表示行，ns表示列，便于后续计算
Hl = zeros(nr,nc);
HL = hilbert(Data);    %对数据进行希尔伯特复信号构建
switch type                          %%%选择瞬时属性类型
    case 'Amplitude'
        Hl = abs(HL);%瞬时振幅分析（包络分析）
    case'Phase'
       Hl = angle(HL);%瞬时相位分析
    case'Frequency'
       Hl = imag(HL./conj(HL))./(2*pi); %瞬时频率
end
end
