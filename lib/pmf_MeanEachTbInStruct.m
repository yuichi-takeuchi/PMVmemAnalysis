function [DestStruct] = pmf_MeanEachTbInStruct(SrcStruct)
%
%
% Copyright 2016 Yuichi Takeuchi.

names = fieldnames(SrcStruct);
for k = 1:length(SrcStruct)
    DestStruct(k).Intensity = SrcStruct(k).Intensity;
    for l = 2:length(names)
        eval(['SrcTb = SrcStruct(' num2str(k) ').' names{l} ';'])
        [DestTb] = yfMeanStdSemOfTable1(SrcTb);
        eval(['DestStruct(' num2str(k) ').' names{l} ' = DestTb;'])
    end
end

