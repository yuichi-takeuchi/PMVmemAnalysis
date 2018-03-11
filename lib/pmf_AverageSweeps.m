function [ DestStruct ] = pmf_AverageSweeps(SrcStruct)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

[~, recsize] = size(SrcStruct);
for l = 1:recsize
    [srcreclength, ~] = size(SrcStruct(l).Voltage);
    stackedtraceV = [];
    stackedtraceI = [];
    for m = 1:srcreclength
        stackedtraceV = [stackedtraceV; SrcStruct(l).Voltage{m,1}'];
        stackedtraceI = [stackedtraceI; SrcStruct(l).Current{m,1}'];
    end
    DestStruct(l).Voltage = mean(stackedtraceV)';
    DestStruct(l).Current = mean(stackedtraceI)';
end


