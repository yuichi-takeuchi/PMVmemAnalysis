function [SrcStruct] = pmf_LJPSubtraction(SrcStruct, SeriesVector, ljp)
% UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% 
% Copyright (C) 2016 by Yuichi Takeuchi

for l = SeriesVector
    [srcreclength, ~] = size(SrcStruct(l).Voltage);
    for m = 1:srcreclength
        SrcStruct(l).Voltage{m,1} = SrcStruct(l).Voltage{m, 1} - ljp;
    end
end