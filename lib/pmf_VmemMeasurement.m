function [ DestStruct ] = pmf_VmemMeasurement(SrcStruct, SeriesVector, IntensitySeries, group)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = struct([]);
ll = 1;
for l = SeriesVector
    [srcreclength, ~] = size(SrcStruct(l).Voltage);
    for m = 1:srcreclength;
        destrecsize = length(DestStruct);
        for n = 1:6
            % segment: PreP, 1; Positive, 2; PostP, 3; PreN, 4;
            % Negative, 5; PostN, 6
            DestStruct(destrecsize + n).Intensity = IntensitySeries(ll);
            DestStruct(destrecsize + n).Group = group;
            DestStruct(destrecsize + n).Series = l;
            DestStruct(destrecsize + n).Sweep = m;
            DestStruct(destrecsize + n).Segment = n;
            DestStruct(destrecsize + n).Value = mean(SrcStruct(l).Voltage{m,1}((1+50000*(n-1)):(50000*n)));
        end
    end
    ll = ll + 1;
end

