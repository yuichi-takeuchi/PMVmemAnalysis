function [ DestStruct ] = pmf_DeltaSumCalc4(SrcStruct)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
% Copyright (C) 2016 by Yuichi Takeuchi

DestStruct = SrcStruct;
SrcTb1 = SrcStruct(1).Table;
SrcTb2 = SrcStruct(5).Table;

Intensity = SrcTb1.Intensity;
dVmemSubAPthP = SrcTb1.dVmemRP - SrcTb2.dAPthresP;
dVmemSubAPthN = SrcTb1.dVmemRN - SrcTb2.dAPthresN;
dAPthSubArtiP = SrcTb2.dAPthresP - SrcTb1.dVartiP;
dAPthSubArtiN = SrcTb2.dAPthresN - SrcTb1.dVartiN;

DestStruct(7).Condition = 'VmemAPthres';
DestStruct(7).Table = table(Intensity, dVmemSubAPthP, dVmemSubAPthN, dAPthSubArtiP, dAPthSubArtiN);

SrcTb1 = SrcStruct(2).Table;
SrcTb2 = SrcStruct(6).Table;

Intensity = SrcTb1.Intensity;
dVmemSubAPth = SrcTb1.dVmemR - SrcTb2.dAPthres;
dAPthSubArti = SrcTb2.dAPthres - SrcTb1.dVarti;

DestStruct(8).Condition = 'VmemAPthresSeries';
DestStruct(8).Table = table(Intensity, dVmemSubAPth, dAPthSubArti);