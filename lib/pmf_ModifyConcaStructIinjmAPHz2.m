function [ DestStruct ] = pmf_ModifyConcaStructIinjmAPHz2( SrcStruct )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

DestStruct = SrcStruct;

for k = 1:5
   TbmCont = SrcStruct(k).mControl;
   TbPosi = SrcStruct(k).Positive;
   TbNega = SrcStruct(k).Negative;
   
   [rsize,csize] = size(TbmCont);
   TbdPosi = array2table(zeros(rsize,csize));
   TbdNega = array2table(zeros(rsize,csize));
   Tbdelta = array2table(zeros(rsize,csize));
   TbdPosi.(1) = TbmCont.(1);
   TbdNega.(1) = TbmCont.(1);
   Tbdelta.(1) = TbmCont.(1);
   for l = 2:csize
      TbdPosi.(l) = TbPosi.(l) - TbmCont.(l);
      TbdNega.(l) = TbNega.(l) - TbmCont.(l);
      Tbdelta.(l) = TbPosi.(l) - TbNega.(l);
   end
   TbdPosi.Properties.VariableNames = TbmCont.Properties.VariableNames;
   TbdNega.Properties.VariableNames = TbmCont.Properties.VariableNames;
   Tbdelta.Properties.VariableNames = TbmCont.Properties.VariableNames;
   
   DestStruct(k).dPositive = TbdPosi;
   DestStruct(k).dNegative = TbdNega;
   DestStruct(k).deltaPN = Tbdelta;
end


