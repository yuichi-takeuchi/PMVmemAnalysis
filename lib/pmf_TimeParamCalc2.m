function [ DestStruct ] = pmf_TimeParamCalc2(SrcStruct1, SrcStruct2, IntensityVector)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;

FieldStrCell1 = {'Cont0', 'Cont30', 'Cont60', 'Cont90', 'Posi0', 'Posi30', 'Posi60', 'Posi90', 'Nega0', 'Nega30', 'Nega60', 'Nega90'};
FieldStrCell2 = {'Cont30', 'Cont60', 'Cont90', 'Posi30', 'Posi60', 'Posi90', 'Nega30', 'Nega60', 'Nega90'};

tb = SrcStruct1(4).Table;
TempStruct1 = struct([]);
for l = 1:length(IntensityVector)
    TempStruct1(l).Intensity = IntensityVector(l);
    if find(tb.Intensity == IntensityVector(l))
        for m = 1:12
            evalstr = ['TempStruct1(l).' FieldStrCell1{m} ' = mean(tb.Value(tb.Intensity == IntensityVector(l) & tb.Segment == ' num2str(m) '));'];
            eval(evalstr)
        end
    else
        for m = 1:12
            evalstr = ['TempStruct1(l).' FieldStrCell1{m} ' = NaN;'];
            eval(evalstr)
        end
    end
end

Tb = struct2table(TempStruct1);
IntensityVector = sort(unique(Tb.Intensity));
intensitylength = length(IntensityVector);
TempStruct2 = struct([]);
for l = 1:intensitylength
    TempStruct2(l).Intensity = Tb.Intensity(l);
    TempStruct2(l).Cont30 = -1e12*(Tb.Cont30(l) - Tb.Cont0(l))/30;
    TempStruct2(l).Cont60 = -1e12*(Tb.Cont60(l) - Tb.Cont0(l))/60;
    TempStruct2(l).Cont90 = -1e12*(Tb.Cont90(l) - Tb.Cont0(l))/90;
    TempStruct2(l).Posi30 = -1e12*(Tb.Posi30(l) - Tb.Posi0(l))/30;
    TempStruct2(l).Posi60 = -1e12*(Tb.Posi60(l) - Tb.Posi0(l))/60;
    TempStruct2(l).Posi90 = -1e12*(Tb.Posi90(l) - Tb.Posi0(l))/90;
    TempStruct2(l).Nega30 = -1e12*(Tb.Nega30(l) - Tb.Nega0(l))/30;
    TempStruct2(l).Nega60 = -1e12*(Tb.Nega60(l) - Tb.Nega0(l))/60;
    TempStruct2(l).Nega90 = -1e12*(Tb.Nega90(l) - Tb.Nega0(l))/90;
end

 for o = 1:9
     evalstr = ['tempvec = [TempStruct2.' FieldStrCell2{o} '];'];
     eval(evalstr)
     tempvec(tempvec < 0) = NaN;
     for l = 1:intensitylength
         evalstr = ['TempStruct2(l).' FieldStrCell2{o} ' = tempvec(l);'];
         eval(evalstr)
     end
 end

Tb = struct2table(TempStruct2);
TempStruct3 = struct([]);
for l = 1:intensitylength
    TempStruct3(intensitylength - l + 1).Intensity = -Tb.Intensity(l);
    TempStruct3(intensitylength + l - 1).Intensity = Tb.Intensity(l);
    if l == 1
        TempStruct3(intensitylength).Rinput30 = mean([Tb.Nega30; Tb.Posi30(l)]);
        TempStruct3(intensitylength).Rinput60 = mean([Tb.Nega60; Tb.Posi60(l)]);
        TempStruct3(intensitylength).Rinput90 = mean([Tb.Nega90; Tb.Posi90(l)]);
    else
        TempStruct3(intensitylength - l + 1).Rinput30 = Tb.Nega30(l);
        TempStruct3(intensitylength + l - 1).Rinput30 = Tb.Posi30(l);
        TempStruct3(intensitylength - l + 1).Rinput60 = Tb.Nega60(l);
        TempStruct3(intensitylength + l - 1).Rinput60 = Tb.Posi60(l);
        TempStruct3(intensitylength - l + 1).Rinput90 = Tb.Nega90(l);
        TempStruct3(intensitylength + l - 1).Rinput90 = Tb.Posi90(l);
    end
end

DestStruct(4).Condition = ['m' SrcStruct1(4).Condition];
DestStruct(4).Table = struct2table(TempStruct1);
DestStruct(5).Condition = 'mRinput';
DestStruct(5).Table = struct2table(TempStruct2);
DestStruct(6).Condition = 'mRinputSeries';
DestStruct(6).Table = struct2table(TempStruct3);



