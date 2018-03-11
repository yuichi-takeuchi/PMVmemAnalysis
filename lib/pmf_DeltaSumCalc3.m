function [ DestStruct ] = pmf_DeltaSumCalc3(SrcStruct1, SrcStruct2)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;
TbmAPHz = SrcStruct1(7).Table;
TbmAPthres = SrcStruct1(8).Table;
TbmAPamp = SrcStruct1(9).Table;
TbmAPrise = SrcStruct1(10).Table;
TbmAPhw = SrcStruct1(11).Table;

IntensityVector = sort(unique(TbmAPHz.Intensity));
intensitylength = length(IntensityVector);

for l = 1:intensitylength
    TempStruct1(l).Intensity = TbmAPHz.Intensity(l);
    TempStruct1(l).dAPHzP = TbmAPHz.Positive(l) - TbmAPHz.PreP(l);
    TempStruct1(l).dAPHzN = TbmAPHz.Negative(l) - TbmAPHz.PreN(l);
    TempStruct1(l).dAPthresP = TbmAPthres.Positive(l) - TbmAPthres.PreP(l);
    TempStruct1(l).dAPthresN = TbmAPthres.Negative(l) - TbmAPthres.PreN(l);
    TempStruct1(l).dAPampP = TbmAPamp.Positive(l) - TbmAPamp.PreP(l);
    TempStruct1(l).dAPampN = TbmAPamp.Negative(l) - TbmAPamp.PreN(l);
    TempStruct1(l).dAPriseP = TbmAPrise.Positive(l) - TbmAPrise.PreP(l);
    TempStruct1(l).dAPriseN = TbmAPrise.Negative(l) - TbmAPrise.PreN(l);
    TempStruct1(l).dAPhwP = TbmAPhw.Positive(l) - TbmAPhw.PreP(l);
    TempStruct1(l).dAPhwN = TbmAPhw.Negative(l) - TbmAPhw.PreN(l);
end

for l = 1:intensitylength
    TempStruct2(intensitylength - l + 1).Intensity = -TbmAPHz.Intensity(l);
    TempStruct2(intensitylength + l - 1).Intensity = TbmAPHz.Intensity(l);
    if l == 1
        TempStruct2(intensitylength).dAPHz = mean([(TbmAPHz.Negative(l) - TbmAPHz.PreN(l));(TbmAPHz.Positive(l) - TbmAPHz.PreP(l))]);
        TempStruct2(intensitylength).dAPthres = mean([(TbmAPthres.Negative(l) - TbmAPthres.PreN(l));(TbmAPthres.Positive(l) - TbmAPthres.PreP(l))]);
        TempStruct2(intensitylength).dAPamp = mean([(TbmAPamp.Negative(l) - TbmAPamp.PreN(l));(TbmAPamp.Positive(l) - TbmAPamp.PreP(l))]);
        TempStruct2(intensitylength).dAPrise = mean([(TbmAPrise.Negative(l) - TbmAPrise.PreN(l));(TbmAPrise.Positive(l) - TbmAPrise.PreP(l))]);
        TempStruct2(intensitylength).dAPhw = mean([(TbmAPhw.Negative(l) - TbmAPhw.PreN(l));(TbmAPhw.Positive(l) - TbmAPhw.PreP(l))]);
    else
        TempStruct2(intensitylength - l + 1).dAPHz =  TbmAPHz.Negative(l) - TbmAPHz.PreN(l);
        TempStruct2(intensitylength + l - 1).dAPHz = TbmAPHz.Positive(l) - TbmAPHz.PreP(l);
        TempStruct2(intensitylength - l + 1).dAPthres = TbmAPthres.Negative(l) - TbmAPthres.PreN(l);
        TempStruct2(intensitylength + l - 1).dAPthres = TbmAPthres.Positive(l) - TbmAPthres.PreP(l);
        TempStruct2(intensitylength - l + 1).dAPamp = TbmAPamp.Negative(l) - TbmAPamp.PreN(l);
        TempStruct2(intensitylength + l - 1).dAPamp = TbmAPamp.Positive(l) - TbmAPamp.PreP(l);
        TempStruct2(intensitylength - l + 1).dAPrise = TbmAPrise.Negative(l) - TbmAPrise.PreN(l);
        TempStruct2(intensitylength + l - 1).dAPrise = TbmAPrise.Positive(l) - TbmAPrise.PreP(l);
        TempStruct2(intensitylength - l + 1).dAPhw = TbmAPhw.Negative(l) - TbmAPhw.PreN(l);
        TempStruct2(intensitylength + l - 1).dAPhw = TbmAPhw.Positive(l) - TbmAPhw.PreP(l);
    end
end

DestStruct(5).Condition = 'APsponta';
DestStruct(5).Table = struct2table(TempStruct1);
DestStruct(6).Condition = 'APspontaseries';
DestStruct(6).Table = struct2table(TempStruct2);

