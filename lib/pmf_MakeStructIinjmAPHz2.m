function [ DestStruct ] = pmf_MakeStructIinjmAPHz2( SrcStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

for k = 1:5
    TbwControl = SrcStruct(k).wControl;
    TbsControl = SrcStruct(k).sControl;
    TbwPositive = SrcStruct(k).wPositive;
    TbsPositive = SrcStruct(k).sPositive;
    TbwNegative = SrcStruct(k).wNegative;
    TbsNegative = SrcStruct(k).sNegative;
       
    Iinj = [TbwControl.wIinj; TbsControl.sIinj];
    [Iinj,I] = sort(Iinj);
    TempStructCont.Iinj = Iinj;
    TempStructPosi.Iinj = Iinj;
    TempStructNega.Iinj = Iinj;
    FieldList = TbwControl.Properties.VariableNames;
    for l = 2:length(FieldList)
        evalstr = ['expvec = [TbwControl.' FieldList{l} '; TbsControl.' FieldList{l} '];' ];
        eval(evalstr)
        evalstr = ['TempStructCont.' FieldList{l} ' = expvec(I);'];
        eval(evalstr)
        evalstr = ['expvec = [TbwPositive.' FieldList{l} '; TbsPositive.' FieldList{l} '];' ];
        eval(evalstr)
        evalstr = ['TempStructPosi.' FieldList{l} ' = expvec(I);'];
        eval(evalstr)
        evalstr = ['expvec = [TbwNegative.' FieldList{l} '; TbsNegative.' FieldList{l} '];' ];
        eval(evalstr)
        evalstr = ['TempStructNega.' FieldList{l} ' = expvec(I);'];
        eval(evalstr)
    end
    TbCont = pmf_meanFirstRecTable(struct2table(TempStructCont));
    TbPosi = pmf_meanFirstRecTable(struct2table(TempStructPosi));
    TbNega = pmf_meanFirstRecTable(struct2table(TempStructNega));
    DestStruct(k).Intensity = SrcStruct(k).Intensity;
    DestStruct(k).Control = TbCont;
    DestStruct(k).Positive = TbPosi;
    DestStruct(k).Negative = TbNega;
end


