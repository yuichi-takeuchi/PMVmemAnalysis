function [ Table ] = pmf_meanFirstRecTable( Table )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    meanvec = mean(table2array(Table(1:2, :)));
    Tb1 = array2table(meanvec);
    Table(1,:) = Tb1;
    Table(2,:) = [];
end

