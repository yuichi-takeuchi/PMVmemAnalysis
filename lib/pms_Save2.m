% pms_Save2 saves mat file based on mfilenamebase in the struct.
% 
% Copyright (C) 2016 by Yuichi Takeuchi

varstr = '';
if exist('StructInfo', 'var')
    varstr = [varstr 'StructInfo '];
end
if exist(['StructAPIinjParam1st' num2str(StructInfo.expnum) '2'], 'var')
    varstr = [varstr 'StructAPIinjParam1st' num2str(StructInfo.expnum) '2 '];
end
if exist(['StructAPIinjParam2nd' num2str(StructInfo.expnum) '2'], 'var')
    varstr = [varstr 'StructAPIinjParam2nd' num2str(StructInfo.expnum) '2 '];
end
if exist(['StructDeltaSum' num2str(StructInfo.expnum) '1'], 'var')
    varstr = [varstr 'StructDeltaSum' num2str(StructInfo.expnum) '1 '];
end
if exist(['StructTimeParam' num2str(StructInfo.expnum) '1'], 'var')
    varstr = [varstr 'StructTimeParam' num2str(StructInfo.expnum) '1 '];
end

savestr = [StructInfo.mfilenamebase '_spec.mat'];
evalstr = ['save ' savestr ' ' varstr];
tic
disp('pms_Save2.m ...')
disp('Saving ...')
eval(evalstr)
disp('...')
toc

clear varstr savestr evalstr