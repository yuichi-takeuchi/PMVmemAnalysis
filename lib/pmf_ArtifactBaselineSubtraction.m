function [ DestStruct ] = pmf_ArtifactBaselineSubtraction(SrcStruct, SeriesVector, sr)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

for l = SeriesVector
    SrcWave = SrcStruct(l).Voltage;
    SrcWave = SrcWave - mean(SrcWave(1:2*sr));
    SrcStruct(l).Voltage = SrcWave;
end
DestStruct = SrcStruct;

