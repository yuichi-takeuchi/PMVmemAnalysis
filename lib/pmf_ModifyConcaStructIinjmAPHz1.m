function [ DestStruct ] = pmf_ModifyConcaStructIinjmAPHz1( SrcStruct )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
for k = 1:5
    SrcTb1 = SrcStruct(k).Control;
    TempMat(:,:,k) = table2array(SrcTb1);
end
TempMat = mean(TempMat,3);
Tb = array2table(TempMat);
FieldNames =  SrcTb1.Properties.VariableNames;
Tb.Properties.VariableNames = FieldNames;

DestStruct = SrcStruct;
for k = 1:5
    DestStruct(k).mControl = Tb;
end
