% pms_Save3 saves mat file based on mfilenamebase in the struct.
% 
% Copyright (C) 2016 by Yuichi Takeuchi

varstr = 'EmStatSkin EmStatSkull APHzStatSkin APHzStatSkull';
savestr = 'deltaEmAPHzForStat.mat';
evalstr = ['save ' savestr ' ' varstr];
tic
disp('pms_Save3.m ...')
disp('Saving ...')
eval(evalstr)
disp('...')
toc

clear varstr savestr evalstr