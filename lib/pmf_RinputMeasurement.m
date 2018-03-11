function [ DestStruct ] = pmf_RinputMeasurement(SrcStruct, SeriesVector, IntensitySeries, group)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = struct([]);
ll = 1;
for l = SeriesVector
    [srcreclength, ~] = size(SrcStruct(l).Voltage);
    for m = 1:srcreclength;
        for n = 1:3
            destrecsize = length(DestStruct);
            for o = 1:4
                DestStruct(destrecsize + o).Intensity = IntensitySeries(ll);
                DestStruct(destrecsize + o).Group = group;
                DestStruct(destrecsize + o).Series = l;
                DestStruct(destrecsize + o).Sweep = m;
                DestStruct(destrecsize + o).Segment = 4*(n-1) + o;
                DestStruct(destrecsize + o).Value = mean(SrcStruct(l).Voltage{m,1}((1+36000*(n-1)+6000*o):(36000*(n-1)+6000*(o+1))));
            end
        end
    end
    ll = ll + 1;
end