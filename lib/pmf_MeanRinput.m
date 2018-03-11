function [DestStruct] = pmf_MeanRinput(SrcStruct)
%
%
% Copyright 2016 Yuichi Takeuchi.

for k = linspace(30, 90, 3)
    eval(['SrcTb = SrcStruct.Iinj' num2str(k) ';'])
    [DestTb] = yfMeanStdSemOfTable1(SrcTb);
    eval(['DestStruct.Iinj' num2str(k) ' = DestTb;'])
end