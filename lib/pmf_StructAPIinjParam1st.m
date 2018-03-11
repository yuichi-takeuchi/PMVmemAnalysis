function [ DestStruct ] = pmf_StructAPIinjParam1st(SrcTb, IntensityVector, SrcStruct)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

strparam = {'mAPHz', 'mAPthres', 'mAPamp', 'mAPrise', 'mAPhw'};
paramlength = length(strparam);
strseg = {'wControl', 'sControl', 'wPositive', 'sPositive', 'wNegative', 'sNegative'};
seglength = length(strseg);

for o = 1:length(IntensityVector)
    for l = 1:6
        for m = 1:paramlength
            evalstr = ['DestStruct' strparam{m} '(l).Sweep = l;'];
            eval(evalstr)
            evalstr = ['DestStruct' strparam{m} '(l).wIinj = ' num2str(SrcStruct.InitialIinjW) ' + (l-1)*' num2str(SrcStruct.dIinjW) ';'];
            eval(evalstr)
            evalstr = ['DestStruct' strparam{m} '(l).sIinj = ' num2str(SrcStruct.InitialIinjS) ' + (l-1)*' num2str(SrcStruct.dIinjS) ';'];
            eval(evalstr)
        end
        
        if find(SrcTb.Intensity == IntensityVector(o))
            for n = 1:seglength
                evalstr = ['DestStructmAPHz(l).' strseg{n} ' = length(SrcTb.PeakX(SrcTb.Intensity == IntensityVector(o) & SrcTb.Sweep == l & SrcTb.Segment == n))/0.5;'];
                eval(evalstr)
                evalstr = ['DestStructmAPthres(l).' strseg{n} ' = mean(SrcTb.ThresY(SrcTb.Intensity == IntensityVector(o) & SrcTb.Sweep == l & SrcTb.Segment == n));'];
                eval(evalstr)
                evalstr = ['DestStructmAPamp(l).' strseg{n} ' = mean(SrcTb.Amp(SrcTb.Intensity == IntensityVector(o) & SrcTb.Sweep == l & SrcTb.Segment == n));'];
                eval(evalstr)
                evalstr = ['DestStructmAPrise(l).' strseg{n} ' = mean(SrcTb.Rise(SrcTb.Intensity == IntensityVector(o) & SrcTb.Sweep == l & SrcTb.Segment == n));'];
                eval(evalstr)
                evalstr = ['DestStructmAPhw(l).' strseg{n} ' = mean(SrcTb.APhw(SrcTb.Intensity == IntensityVector(o) & SrcTb.Sweep == l & SrcTb.Segment == n));'];
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
    
    DestStruct(o).Intensity = IntensityVector(o);

    for m = 1:paramlength
        evalstr = ['DestStruct(o).' strparam{m} ' = struct2table(DestStruct' strparam{m} ');'];
        eval(evalstr)
    end
end