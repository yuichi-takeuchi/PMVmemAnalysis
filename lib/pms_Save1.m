% pms_Save1 saves mat file based on mfilenamebase in the struct.
% 
% Copyright (C) 2016 by Yuichi Takeuchi

tic
disp('pms_Save1.m ...')
disp('Saving ...')
save([StructInfo.mfilenamebase '.mat']);

disp('...')
toc