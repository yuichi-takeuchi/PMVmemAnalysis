function [ DestStruct ] = pmf_DeltaSumCalc2(SrcStruct1, SrcStruct2)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;
Tb = SrcStruct1(5).Table;
IntensityVector = sort(unique(Tb.Intensity));
intensitylength = length(IntensityVector);

TempStruct1 = struct([]);
for l = 1:intensitylength
    TempStruct1(l).Intensity = Tb.Intensity(l);
    TempStruct1(l).Posi30 = Tb.Posi30(l) - Tb.Cont30(l);
    TempStruct1(l).Posi60 = Tb.Posi60(l) - Tb.Cont60(l);
    TempStruct1(l).Posi90 = Tb.Posi90(l) - Tb.Cont90(l);
    TempStruct1(l).Nega30 = Tb.Nega30(l) - Tb.Cont30(l);
    TempStruct1(l).Nega60 = Tb.Nega60(l) - Tb.Cont60(l);
    TempStruct1(l).Nega90 = Tb.Nega90(l) - Tb.Cont90(l);
end

TempStruct2 = struct([]);
for l = 1:intensitylength
    TempStruct2(intensitylength - l + 1).Intensity = -Tb.Intensity(l);
    TempStruct2(intensitylength + l - 1).Intensity = Tb.Intensity(l);
    if l == 1
        TempStruct2(intensitylength).dRinput30 = mean([(Tb.Nega30(l) - Tb.Cont30(l));(Tb.Posi30(l) - Tb.Cont30(l))]);
        TempStruct2(intensitylength).dRinput60 = mean([(Tb.Nega60(l) - Tb.Cont60(l));(Tb.Posi60(l) - Tb.Cont60(l))]);
        TempStruct2(intensitylength).dRinput90 = mean([(Tb.Posi90(l) - Tb.Cont90(l));(Tb.Nega90(l) - Tb.Cont90(l))]);
    else
        TempStruct2(intensitylength - l + 1).dRinput30 = Tb.Nega30(l) - Tb.Cont30(l);
        TempStruct2(intensitylength + l - 1).dRinput30 = Tb.Posi30(l) - Tb.Cont30(l);
        TempStruct2(intensitylength - l + 1).dRinput60 = Tb.Nega60(l) - Tb.Cont60(l);
        TempStruct2(intensitylength + l - 1).dRinput60 = Tb.Posi60(l) - Tb.Cont60(l);
        TempStruct2(intensitylength - l + 1).dRinput90 = Tb.Posi90(l) - Tb.Cont90(l);
        TempStruct2(intensitylength + l - 1).dRinput90 = Tb.Nega90(l) - Tb.Cont90(l);
    end
end

DestStruct(3).Condition = 'Rinput';
DestStruct(3).Table = struct2table(TempStruct1);
DestStruct(4).Condition = 'RinputSeries';
DestStruct(4).Table = struct2table(TempStruct2);


