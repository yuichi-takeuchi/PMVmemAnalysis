function [ DestStruct ] = pmf_StructAPIinjParam2nd(SrcStruct1, IntensityVector, SrcStruct2);
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi


intensitylength = length(IntensityVector);

strparam = {'Weak', 'Strong'};
strfield = {'dAPHz', 'dAPthres', 'dAPamp', 'dAPrise', 'dAPhw'};
fieldlength = length(strfield);

for o = 6:-1:1
    for m = 1:intensitylength
        TbdAPHz = SrcStruct1(m).mAPHz;
        TbdAPthres = SrcStruct1(m).mAPthres;
        TbdAPamp = SrcStruct1(m).mAPamp;
        TbdAPrise = SrcStruct1(m).mAPrise;
        TbdAPhw = SrcStruct1(m).mAPhw;
        
        DestStructWeak(intensitylength - m + 1).Intensity = -IntensityVector(m);
        DestStructWeak(intensitylength + m - 1).Intensity = IntensityVector(m);
        DestStructStrong(intensitylength - m + 1).Intensity = -IntensityVector(m);
        DestStructStrong(intensitylength + m - 1).Intensity = IntensityVector(m);
        
        for n = 1:fieldlength
            evalstr = ['DestStructWeak(intensitylength - m + 1).' strfield{n} ' = Tb' strfield{n} '.wNegative(o) - Tb' strfield{n} '.wControl(o);'];
            eval(evalstr)
            evalstr = ['DestStructWeak(intensitylength + m - 1).' strfield{n} ' = Tb' strfield{n} '.wPositive(o) - Tb' strfield{n} '.wControl(o);'];
            eval(evalstr)
            evalstr = ['DestStructStrong(intensitylength - m + 1).' strfield{n} ' = Tb' strfield{n} '.sNegative(o) - Tb' strfield{n} '.sControl(o);'];
            eval(evalstr)
            evalstr = ['DestStructStrong(intensitylength + m - 1).' strfield{n} ' = Tb' strfield{n} '.sPositive(o) - Tb' strfield{n} '.sControl(o);'];
            eval(evalstr)
        end
    end
    
    % Outputting final structure
    DestStruct(o).Sweep = o;
    DestStruct(o).wIinj = SrcStruct2.InitialIinjW + (o-1)*SrcStruct2.dIinjW;
    DestStruct(o).sIinj = SrcStruct2.InitialIinjS + (o-1)*SrcStruct2.dIinjS;
    DestStruct(o).Weak = struct2table(DestStructWeak);
    DestStruct(o).Strong = struct2table(DestStructStrong);
end