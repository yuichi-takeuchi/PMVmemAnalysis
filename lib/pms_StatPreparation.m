%% Initialization Em
EmStatSkin = [];
EmStatSkull = [];
%% Initialization APHz
APHzStatSkin = [];
APHzStatSkull = [];

%% SrcVariables Em
EmSrcTb = StructVmeas21(3).Table;

%% Stack Em Skin
TempEmStatSkin = pmf_EmStatPreparation(EmSrcTb);
EmStatSkin = [EmStatSkin; TempEmStatSkin];
clear EmSrcTb TempEmStatSkin

%% Stack Em Skull
TempEmStatSkull = pmf_EmStatPreparation(EmSrcTb);
EmStatSkull = [EmStatSkull; TempEmStatSkull];
clear EmSrcTb TempEmStatSkull

%% SrcVariableAPHz
APHzSrcTb = struct2table(StructAP21);

%% Stack APHz Skin
TempAPHzStatSkin = pmf_APHzStatPreparation(APHzSrcTb);
APHzStatSkin = [APHzStatSkin; TempAPHzStatSkin];
clear APHzSrcTb TempAPHzStatSkin

%% Stack APHz Skull
TempAPHzStatSkull = pmf_APHzStatPreparation(APHzSrcTb);
APHzStatSkull = [APHzStatSkull; TempAPHzStatSkull];
clear APHzSrcTb TempAPHzStatSkull

%% Save
pms_Save3

%% 
clear
load('deltaEmAPHzForStat.mat')
