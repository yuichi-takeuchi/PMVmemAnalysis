function [ DestStruct ] = pmf_TimeParamCalc1(SrcStruct1, SrcStruct2, IntensityVector)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;

for m = 1:3
    tb = SrcStruct1(m).Table;
    
    TempStruct = struct([]);
    for l = 1:length(IntensityVector)
        TempStruct(l).Intensity = IntensityVector(l);
        if find(tb.Intensity == IntensityVector(l))
            TempStruct(l).PreP = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 1));
            TempStruct(l).Positive = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 2));
            TempStruct(l).PostP = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 3));
            TempStruct(l).PreN = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 4));
            TempStruct(l).Negative = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 5));
            TempStruct(l).PostN = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == 6));
        else
            TempStruct(l).PreP = NaN;
            TempStruct(l).Positive = NaN;
            TempStruct(l).PostP = NaN;
            TempStruct(l).PreN = NaN;
            TempStruct(l).Negative = NaN;
            TempStruct(l).PostN = NaN;
        end
    end
    
    DestStruct(m).Condition = ['m' SrcStruct1(m).Condition];
    DestStruct(m).Table = struct2table(TempStruct);
end


