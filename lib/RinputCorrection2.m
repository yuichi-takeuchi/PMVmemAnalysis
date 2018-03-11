function [DestTb] = RinputCorrection2(SrcTb)
VariableNames = SrcTb.Properties.VariableNames;
for k = 1:length(VariableNames)
   eval(['tempvec = SrcTb.' VariableNames{k} ';'])
   if ~strcmp('Intensity', VariableNames{k})
       tempvec = tempvec/10;
   end
   eval(['DestStruct.' VariableNames{k} ' = tempvec;'])
end
DestTb = struct2table(DestStruct);