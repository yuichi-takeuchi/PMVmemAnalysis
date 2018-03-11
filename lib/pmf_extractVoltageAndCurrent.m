function [StructData] = pmf_extractVoltageAndCurrent(VarNameList, VarList)
% pmf_extractVoltageAndCurrent extract voltage and current from Trace_*
% variables and put them into StructData
% 
% Copyright (C) 2016 by Yuichi Takeuchi

for l = 1:length(VarNameList)
    A = sscanf(VarNameList{l}, 'Trace_%d_%d_%d_%d');
    switch A(4)
        case 1
           evalstr = ['StructData(' num2str(A(2)) ').Time{' num2str(A(3)) ', 1} =  VarList{1,' num2str(l) '}(:,1);'];
           eval(evalstr)
           evalstr = ['StructData(' num2str(A(2)) ').Voltage{' num2str(A(3)) ', 1} = VarList{1,' num2str(l) '}(:,end);'];
           eval(evalstr)
        case 2
           evalstr = ['StructData(' num2str(A(2)) ').Current{' num2str(A(3)) ', 1} = VarList{1,' num2str(l) '}(:,end);'];
           eval(evalstr)
        otherwise
           disp('otherwise')
    end
end





