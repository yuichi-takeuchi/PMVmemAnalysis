function [DestStruct] = pmf_MeanAPIinjd(SrcStruct)
%
%
% Copyright 2016 Yuichi Takeuchi.

for k = 1:length(SrcStruct)
    eval(['DestStruct(' num2str(k) ').wIinj = SrcStruct(' num2str(k) ').wIinj;'])
    eval(['DestStruct(' num2str(k) ').sIinj = SrcStruct(' num2str(k) ').sIinj;'])
    
    eval(['SrcTb = SrcStruct(' num2str(k) ').Weak;'])
    [DestTb] = yfMeanStdSemOfTable1(SrcTb);
    eval(['DestStruct(' num2str(k) ').Weak = DestTb;'])
    
    eval(['SrcTb = SrcStruct(' num2str(k) ').Strong;'])
    [DestTb] = yfMeanStdSemOfTable1(SrcTb);
    eval(['DestStruct(' num2str(k) ').Strong = DestTb;'])
end