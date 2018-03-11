function [ DestStruct ] = pmf_DeltaSumCalc1(SrcStruct1, SrcStruct2)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;
TbmVmemR = SrcStruct1(1).Table;
TbmVarti = SrcStruct1(2).Table;
TbmVmemSub = SrcStruct1(3).Table;

IntensityVector = sort(unique(TbmVmemR.Intensity));
intensitylength = length(IntensityVector);

for l = 1:intensitylength
    TempStruct1(l).Intensity = TbmVmemR.Intensity(l);
    TempStruct1(l).dVmemRP = TbmVmemR.Positive(l) - TbmVmemR.PreP(l);
    TempStruct1(l).dVmemRN = TbmVmemR.Negative(l) - TbmVmemR.PreN(l);
    TempStruct1(l).dVartiP = TbmVarti.Positive(l) - TbmVarti.PreP(l);
    TempStruct1(l).dVartiN = TbmVarti.Negative(l) - TbmVarti.PreN(l);
    TempStruct1(l).dVmemSubP = TbmVmemSub.Positive(l) - TbmVmemSub.PreP(l);
    TempStruct1(l).dVmemSubN = TbmVmemSub.Negative(l) - TbmVmemSub.PreN(l);
end

for l = 1:intensitylength
    TempStruct2(intensitylength - l + 1).Intensity = -TbmVmemR.Intensity(l);
    TempStruct2(intensitylength + l - 1).Intensity = TbmVmemR.Intensity(l);
    if l == 1
        TempStruct2(intensitylength).dVmemR = mean([(TbmVmemR.Negative(l) - TbmVmemR.PreN(l));(TbmVmemR.Positive(l) - TbmVmemR.PreP(l))]);
        TempStruct2(intensitylength).dVarti = mean([(TbmVarti.Negative(l) - TbmVarti.PreN(l));(TbmVarti.Positive(l) - TbmVarti.PreP(l))]);
        TempStruct2(intensitylength).dVmemSub = mean([(TbmVmemSub.Negative(l) - TbmVmemSub.PreN(l));(TbmVmemSub.Positive(l) - TbmVmemSub.PreP(l))]);
    else
        TempStruct2(intensitylength - l + 1).dVmemR =  TbmVmemR.Negative(l) - TbmVmemR.PreN(l);
        TempStruct2(intensitylength + l - 1).dVmemR = TbmVmemR.Positive(l) - TbmVmemR.PreP(l);
        TempStruct2(intensitylength - l + 1).dVarti =  TbmVarti.Negative(l) - TbmVarti.PreN(l);
        TempStruct2(intensitylength + l - 1).dVarti = TbmVarti.Positive(l) - TbmVarti.PreP(l);
        TempStruct2(intensitylength - l + 1).dVmemSub =  TbmVmemSub.Negative(l) - TbmVmemSub.PreN(l);
        TempStruct2(intensitylength + l - 1).dVmemSub = TbmVmemSub.Positive(l) - TbmVmemSub.PreP(l);
    end
end

DestStruct(1).Condition = 'Vmem';
DestStruct(1).Table = struct2table(TempStruct1);
DestStruct(2).Condition = 'VmemSeries';
DestStruct(2).Table = struct2table(TempStruct2);