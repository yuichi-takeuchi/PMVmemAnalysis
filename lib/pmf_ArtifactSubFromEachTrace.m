function [ DestStruct ] = pmf_ArtifactSubFromEachTrace(StructData, StructAvg, SeriesPair)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

seriespairlength = length(SeriesPair);
for l = 1:seriespairlength
    [srcreclength, ~] = size(StructData(SeriesPair(l, 1)).Voltage);
    for m = 1:srcreclength
        if SeriesPair(l, 2) ~= 0
            DestStruct(SeriesPair(l,1)).Voltage{m,1} = StructData(SeriesPair(l,1)).Voltage{m,1}...
                - StructAvg(SeriesPair(l,2)).Voltage;
        else
            DestStruct(SeriesPair(l,1)).Voltage{m,1} = StructData(SeriesPair(l,1)).Voltage{m,1}...
                - 0;
        end
    end
end


