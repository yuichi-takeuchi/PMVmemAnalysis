function [ DestStruct ] = pmf_TimeParamCalc3(SrcTb, SrcStruct2, IntensityVector)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct2;

strparam = {'mAPHz', 'mAPthres', 'mAPamp', 'mAPrise', 'mAPhw'};
paramlength = length(strparam);
strseg = {'PreP', 'Positive', 'PostP', 'PreN', 'Negative', 'PostN'};
seglength = length(strseg);

for l = 1:length(IntensityVector)
    for m = 1:paramlength
        evalstr = ['DestStruct' strparam{m} '(l).Intensity = IntensityVector(l);'];
        eval(evalstr)
    end
    
    if find(SrcTb.Intensity == IntensityVector(l))
        for n = 1:seglength
            evalstr = ['DestStructmAPHz(l).' strseg{n} ' = length(SrcTb.PeakX(SrcTb.Intensity == IntensityVector(l) & SrcTb.Segment == n))/2.5;'];
            eval(evalstr)
            evalstr = ['DestStructmAPthres(l).' strseg{n} ' = mean(SrcTb.ThresY(SrcTb.Intensity == IntensityVector(l) & SrcTb.Segment == n));'];
            eval(evalstr)
            evalstr = ['DestStructmAPamp(l).' strseg{n} ' = mean(SrcTb.Amp(SrcTb.Intensity == IntensityVector(l) & SrcTb.Segment == n));'];
            eval(evalstr)
            evalstr = ['DestStructmAPrise(l).' strseg{n} ' = mean(SrcTb.Rise(SrcTb.Intensity == IntensityVector(l) & SrcTb.Segment == n));'];
            eval(evalstr)
            evalstr = ['DestStructmAPhw(l).' strseg{n} ' = mean(SrcTb.APhw(SrcTb.Intensity == IntensityVector(l) & SrcTb.Segment == n));'];
            eval(evalstr)
        end
    else
        for m = 1:paramlength
            for n = 1:seglength
                evalstr = ['DestStruct' strparam{m} '(l).' strseg{n} ' = NaN;'];
                eval(evalstr)
            end
        end
    end
end

for m = 1:paramlength
    evalstr = 'DestStruct(m + 6).Condition = strparam(m);';
    eval(evalstr)
    evalstr = ['DestStruct(m + 6).Table = struct2table(DestStruct' strparam{m} ');'];
    eval(evalstr)
end