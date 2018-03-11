function [DestStruct] = RinputCorrection1(SrcStruct)
TableStr = {'Iinj30', 'Iinj60', 'Iinj90'};
for k = 1:3
    eval(['SrcTb = SrcStruct.' TableStr{k} ';'])
    DestTb = RinputCorrection2(SrcTb);
    eval(['DestStruct.' TableStr{k} ' = DestTb;'])
end