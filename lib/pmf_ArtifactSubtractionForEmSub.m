function [ DestStruct ] = pmf_ArtifactSubtractionForEmSub(StructData, StructAvg, SeriesPair, IntensitySeries)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

for l = 1:length(IntensitySeries)
    DestStruct(l).Intensity = IntensitySeries(l);
    [srcreclength, ~] = size(StructData(SeriesPair(l, 1)).Voltage);
    for m = 1:srcreclength
        if SeriesPair(l, 2) ~= 0
            DestStruct(l).Voltage{m,1} = StructData(SeriesPair(l,1)).Voltage{m,1}...
                - StructAvg(SeriesPair(l,2)).Voltage;
        else
            DestStruct(l).Voltage{m,1} = StructData(SeriesPair(l,1)).Voltage{m,1}...
                - 0;
        end
    end
end


