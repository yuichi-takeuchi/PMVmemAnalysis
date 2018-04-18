% Latest verstion is available in Github
% (https://github.com/yuichi-takeuchi/PMVmemAnalysis)
%
% Lisence:
% MIT License
%

%% StructInfo
StructInfo.mfilenamebase = 'PM_160429_exp5_analysis';
StructInfo.ExpID = 2776;
StructInfo.AniID = 1690;
StructInfo.Treatment = 'skull';
StructInfo.expnum = 5;
StructInfo.sr = 20000;
StructInfo.ljp = 0.0186;

%% Extraction of voltage and current channels
VarNameList = who('Trace_*');
for l = 1:length(VarNameList)
    VarList{l} = eval(VarNameList{l});
end
[StructData] = pmf_extractVoltageAndCurrent(VarNameList, VarList);
evalstr = ['StructData' num2str(StructInfo.expnum) ' = StructData;'];
eval(evalstr)

clear evalstr VarNameList VarList l Trace* StructData

%% Subtract liquid junction potential
SeriesVector = 1:39;

evalstr = ['SrcStruct = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[SrcStruct] = pmf_LJPSubtraction(SrcStruct, SeriesVector, StructInfo.ljp);
evalstr = ['StructData' num2str(StructInfo.expnum) ' = SrcStruct;'];
eval(evalstr)
disp('liquid junction potential was subtracted!')

clear k evalstr SrcStruct SeriesVector
clear k l m evalstr srcreclength SrcStruct SeriesVector

%% Display Sweeps
series = 11;
sweep = 1:5;
evalstr = ['StructData = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)

[hstruct] = pmf_PlotSweep(StructData, series, sweep);

clear evalstr StructData group series sweep hstruct

%% Averaging sweeps
evalstr = ['SrcStruct = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[DestStruct] = pmf_AverageSweeps(SrcStruct);
evalstr = ['StructAvg' num2str(StructInfo.expnum) ' = DestStruct;'];
eval(evalstr)

clear SrcStruct DestStruct evalstr

%% Artifact baseline subtraction
SeriesVector = 40:54;

evalstr = ['SrcStruct = StructAvg' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[DestStruct] = pmf_ArtifactBaselineSubtraction(SrcStruct, SeriesVector, StructInfo.sr);
evalstr = ['StructAvg' num2str(StructInfo.expnum) ' = DestStruct;'];
eval(evalstr)
disp('baselines of artifact traces were subtracted!')

clear SrcStruct DestStruct evalstr SeriesVector

%% Artifact subtraction for each traces
SignalVector = [1:5, 6:10, 11:15, 16:20];
ArtifactVector = [50:54, 40:44, 40:44, 45:49];
SeriesPair = [SignalVector', ArtifactVector'];

evalstr = ['StructData = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
evalstr = ['StructAvg = StructAvg' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[DestStruct] = pmf_ArtifactSubFromEachTrace(StructData, StructAvg, SeriesPair);
evalstr = ['StructSub' num2str(StructInfo.expnum) ' = DestStruct;'];
eval(evalstr)

clear ArtifactVector DestStruct SeriesPair SignalVector evalstr StructData StructAvg

%% Artifact subtraction for subthreshold voltage
IntensitySeries = linspace(0,800,5);
SeriesPair = [(6:10)', (40:44)'];

evalstr = ['StructData = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
evalstr = ['StructAvg = StructAvg' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[ DestStruct ] = pmf_ArtifactSubtractionForEmSub(StructData, StructAvg, SeriesPair, IntensitySeries);
evalstr = ['StructSubIntensity' num2str(StructInfo.expnum) ' = DestStruct;'];
eval(evalstr)

clear IntensitySeries SeriesPair evalstr StructData StructAvg DestStruct

%% Mesurement of VmemR
IntensitySeries = linspace(0,800,5);
SeriesVector = 6:10;

evalstr = ['SrcStruct = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[ DestStruct ] = pmf_VmemMeasurement(SrcStruct, SeriesVector, IntensitySeries, StructInfo.expnum);
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(1).Condition = ''VmemR'';'];
eval(evalstr)
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(1).Table = struct2table(DestStruct);'];
eval(evalstr)

clear DestStruct evalstr IntensitySeries SeriesVector SrcStruct

%% Mesurement of Vartifact
IntensitySeries = linspace(0,800,5);
SeriesVector = 40:44;

evalstr = ['SrcStruct = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[ DestStruct ] = pmf_VmemMeasurement(SrcStruct, SeriesVector, IntensitySeries, StructInfo.expnum);
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(2).Condition = ''Varti'';'];
eval(evalstr)
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(2).Table = struct2table(DestStruct);'];
eval(evalstr)

clear DestStruct evalstr IntensitySeries SeriesVector SrcStruct

%% Measurement of VmemSubtracted of specific segments
evalstr = ['SrcStruct = StructSubIntensity' num2str(StructInfo.expnum) ';'];
eval(evalstr)    
RecVector = 1:length([SrcStruct.Intensity]);
IntensitySeries = [SrcStruct.Intensity];
[ DestStruct ] = pmf_VmemMeasurement(SrcStruct, RecVector, IntensitySeries, StructInfo.expnum);
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(3).Condition = ''VmemSub'';'];
eval(evalstr)
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(3).Table = struct2table(DestStruct);'];
eval(evalstr)

clear DestStruct evalstr IntensitySeries SrcStruct RecVector

%% Measurement of Membrane voltage of specific segments (Rinput)
IntensitySeries = linspace(0,800,5);
SeriesVector = 1:5;

evalstr = ['SrcStruct = StructData' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[ DestStruct ] = pmf_RinputMeasurement(SrcStruct, SeriesVector, IntensitySeries, StructInfo.expnum);
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(4).Condition = ''VRinput'';'];
eval(evalstr)
evalstr = ['StructVmeas' num2str(StructInfo.expnum) '1(4).Table = struct2table(DestStruct);'];
eval(evalstr)

clear DestStruct evalstr IntensitySeries SrcStruct SeriesVector

%% Time parameters (mVmemR, mVarti, mVmemSub)
IntensityVector = linspace(0,800,5);

evalstr = ['SrcStruct = StructVmeas' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructTimeParam' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_TimeParamCalc1(SrcStruct, DestStruct, IntensityVector);        
evalstr = ['StructTimeParam' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr DestStruct IntensityVector SrcStruct

%% Time parameters (Rinputs)
IntensityVector = linspace(0,800,5);

evalstr = ['SrcStruct = StructVmeas' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructTimeParam' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_TimeParamCalc2(SrcStruct, DestStruct, IntensityVector);
evalstr = ['StructTimeParam' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr DestStruct IntensityVector SrcStruct

%% Delta Sum1: values vs. stimulation, Input: mTbs, Output: StimParamTable1
evalstr = ['SrcStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructDeltaSum' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructDeltaSum' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_DeltaSumCalc1(SrcStruct, DestStruct);
evalstr = ['StructDeltaSum' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr DestStruct SrcStruct

%% Delta Sum2: values vs. stimulation (input of TbVRInput), Output: StimParamTable1
evalstr = ['SrcStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructDeltaSum' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructDeltaSum' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_DeltaSumCalc2(SrcStruct, DestStruct);
evalstr = ['StructDeltaSum' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr DestStruct SrcStruct

%% Opening guide (panel1)
guide GuideAPDetector1.fig

%% Saving StructAP and TbAP 1
evalstr = ['StructAP' num2str(StructInfo.expnum) '1 = StructAP;'];
eval(evalstr)
evalstr = ['TbAP' num2str(StructInfo.expnum) '1 = struct2table(StructAP);'];
eval(evalstr)

clear StructAP evalstr

pms_Save1

%% Time parameters3 (mAPHz, mAPthres, mAPamp, mAPrise, mAPhw)
IntensityVector = linspace(0,800,5);
evalstr = ['SrcTb = TbAP' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructTimeParam' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_TimeParamCalc3(SrcTb, DestStruct, IntensityVector);
evalstr = ['StructTimeParam' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr SrcTb IntensityVector DestStruct

%% Delta Sum3: values vs. stimulation, Input: TbmAPs, Output: StimParamTable2
evalstr = ['SrcStruct = StructTimeParam' num2str(StructInfo.expnum) '1;'];
eval(evalstr)
if exist(['StructDeltaSum' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructDeltaSum' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_DeltaSumCalc3(SrcStruct, DestStruct);
evalstr = ['StructDeltaSum' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear evalstr DestStruct SrcStruct

%% Delta Sum4
if exist(['StructDeltaSum' num2str(StructInfo.expnum) '1'], 'var')
    evalstr = ['DestStruct = StructDeltaSum' num2str(StructInfo.expnum) '1;'];
    eval(evalstr)
else
    DestStruct = struct([]);
end
[ DestStruct ] = pmf_DeltaSumCalc4(DestStruct);
evalstr = ['StructDeltaSum' num2str(StructInfo.expnum) '1 = DestStruct;'];
eval(evalstr)

clear DestStruct evalstr

%% Opening guide (panel2)
guide GuideAPDetector2.fig

%% Saving StructAP and TbAP 2
evalstr = ['StructAP' num2str(StructInfo.expnum) '2 = StructAP;'];
eval(evalstr)
evalstr = ['TbAP' num2str(StructInfo.expnum) '2 = struct2table(StructAP);'];
eval(evalstr)

clear StructAP evalstr

pms_Save1

%% Preparing StructAPIinjParam1
IntensityVector = linspace(0, 800, 5);

evalstr = ['SrcTb = TbAP' num2str(StructInfo.expnum) '2;'];
eval(evalstr)
[ DestStruct ] = pmf_StructAPIinjParam1st(SrcTb, IntensityVector, StructPanel2);
evalstr = ['StructAPIinjParam1st' num2str(StructInfo.expnum) '2 = DestStruct;'];
eval(evalstr)

clear evalstr SrcTb IntensityVector DestStruct

%% Preparing StructAPIinjParam2
IntensityVector = linspace(0, 800, 5);

evalstr = ['SrcStruct = StructAPIinjParam1st' num2str(StructInfo.expnum) '2;'];
eval(evalstr)
[ DestStruct ] = pmf_StructAPIinjParam2nd(SrcStruct, IntensityVector, StructPanel2);
evalstr = ['StructAPIinjParam2nd' num2str(StructInfo.expnum) '2 = DestStruct;'];
eval(evalstr)

clear evalstr SrcStruct IntensityVector DestStruct

%% Making figure for Em A (Traces)
evalstr = ['SrcStruct = StructSub' num2str(StructInfo.expnum) ';'];
eval(evalstr)
fignum = 1;
series = 10;
sweep = 1:5;
yoffset = 0.03;

[hstruct] = pmf_TraceEm1(SrcStruct, fignum, series, sweep, yoffset);
set(hstruct.haxes, 'YLim', [-0.24 -0.06]);
figure1 = hstruct.hfig;
    
% Create line
annotation(figure1,'line',[0.259832635983263 0.389121338912134],...
    [0.152520325203252 0.152520325203252],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.645188284518825 0.774476987447695],...
    [0.15252 0.15252],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.855369112941751 0.855363321799307],...
    [0.186356587730797 0.0949821564312169],'LineWidth',1);

% Create line
annotation(figure1,'line',[0.752311389729402 0.854403439938607],...
    [0.0957824509120787 0.0954274373619437],'LineWidth',1);

% Create textbox
annotation(figure1,'textbox',...
    [0.129740518962076 0.0888658883471315 0.38622754491018 0.0544430547422999],...
    'String','+400 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.498003992015968 0.0888658883471315 0.43313373253493 0.0544430547422999],...
    'String','-400 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.80938123752495 0.131838962315185 0.157684630738523 0.0406758454027999],...
    'String',{'20 mV'},...
    'Interpreter','none',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.733532934131736 0.0378305018373108 0.143712574850299 0.0406758454028001],...
    'String',{'2 s'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

clear evalstr SrcStruct figure1 series sweep hstruct fignum 

%% Making figure Em B (bargraph)
evalstr = ['SrcTb = StructDeltaSum' num2str(StructInfo.expnum) '1(2).Table;'];
eval(evalstr)
fignum = 2;
[hstruct] = pmf_BarEm1(SrcTb, fignum);

clear evalstr hstruct SrcTb fignum

%% Making figure for Spike A (Traces)
evalstr = ['SrcStruct = StructSub' num2str(StructInfo.expnum) ';'];
eval(evalstr)
fignum = 1;
series = 14;
sweep = 1:5;
yoffset = 0.07;

[hstruct] = pmf_TraceSpike1(SrcStruct, fignum, series, sweep, yoffset);
figure1 = hstruct.hfig;
set(hstruct.haxes, 'YLim', [-0.38 -0.01]);

% Create line
annotation(figure1,'line',[0.259832635983263 0.389121338912134],...
    [0.152520325203252 0.152520325203252],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.749596347158799 0.851688397368004],...
    [0.10987762770058 0.109522614150445],'LineWidth',1);

% Create line
annotation(figure1,'line',[0.645188284518825 0.774476987447695],...
    [0.15252 0.15252],'LineWidth',2);

% Create textbox
annotation(figure1,'textbox',...
    [0.185232426303855 0.0895143967777411 0.27891156462585 0.0544430547422999],...
    'String','+800 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.678004535147392 0.0613473512509624 0.234693877551021 0.0406758454027999],...
    'String',{'2 s'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.571428571428572 0.0895143967777411 0.281746031746032 0.0544430547422999],...
    'String','-800 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create line
annotation(figure1,'line',[0.852891156462586 0.852607709750567],...
    [0.217362045760431 0.108681022880215],'LineWidth',1);

% Create textbox
annotation(figure1,'textbox',...
    [0.759637188208617 0.137954997305916 0.143990929705215 0.0406758454027997],...
    'String','50 mV',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

clear evalstr hstruct figure1 series SrcStruct fignum yoffset sweep

%% Making figure Spike B (bar graph)
evalstr = ['SrcTb = StructDeltaSum' num2str(StructInfo.expnum) '1(6).Table;'];
eval(evalstr)
fignum = 2;
[hstruct] = pmf_BarSpike1(SrcTb, fignum);

clear evalstr hstruct SrcTb fignum

%% Making figure for Iinj A (Traces)
fignum = 1;
eval(['SrcStruct1 = StructSub' num2str(StructInfo.expnum) ';'])
eval(['SrcStruct2 = StructData' num2str(StructInfo.expnum) ';'])
series = 20;
sweep = 2:4;

[hstruct] = pmf_TraceGain1(fignum, SrcStruct1, SrcStruct2, series, sweep);
figure1 = hstruct.hfig;
set(hstruct.haxes(1),'YLim', [-.1 0]);
set(hstruct.haxes(2),'YLim', [-.2E-9 .4E-9]);

% Create line
annotation(figure1,'line',[0.42037388874657 0.485260770975057],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.549217473206634 0.614104355435121],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.678185727174889 0.743072609403375],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.807845544075369 0.872732426303856],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.809919923338926 0.875283446712019],...
    [0.111485306328451 0.11099194166617],'LineWidth',1);

% Create textbox
annotation(figure1,'textbox',...
    [0.394829566207425 0.523928103273033 0.116751271566966 0.0544430547422998],...
    'String','+600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.523864858456619 0.523928103273033 0.116751271566966 0.0544430547422998],...
    'String','+600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.655438221832315 0.523928103273033 0.111675129313961 0.0544430547422998],...
    'String','-600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.855150153816428 0.544939691614873 0.0598037795641518 0.0406758454028004],...
    'String','20 mV',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.784473514081509 0.523928103273033 0.111675129313961 0.0544430547423004],...
    'String','-600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create line
annotation(figure1,'line',[0.885217707539943 0.885217707539943],...
    [0.587222512715701 0.521100917431195],'LineWidth',1);

% Create line
annotation(figure1,'line',[0.885219740734964 0.885219740734964],...
    [0.29847174026715 0.23847174026715],'LineWidth',1);

% Create textbox
annotation(figure1,'textbox',...
    [0.845936829932657 0.259978468999344 0.0746868412225501 0.0406758454027997],...
    'String','0.1 nA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.771084337349398 0.0653981398517798 0.148830616583983 0.0406758454028003],...
    'String','1 s',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.133238837703756 0.373546189265878 0.301204819277108 0.0440976939984223],...
    'String',{'Injected current'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.13693107098361 0.873345773496515 0.293820352717401 0.0440976939984222],...
    'String',{'Membrane potential'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');
    
clear evalstr figure1 SrcStruct1 SrcStruct2 hstruct series sweep fignum

%% Making figure Iinj B-C (lines)
fignum = [2, 3];
eval(['SrcStruct = StructAPIinjParam1st' num2str(StructInfo.expnum) '2;'])
for k = fignum
    [ h ] = pmf_LineIinjmAPHz1(k, SrcStruct);
    hstruct(k) = h;
end

clear fignum k SrcStruct evalstr l h hstruct

%% Making figure Iinj D,E (lines)
fignum = [4, 5];
eval(['SrcStruct = StructAPIinjParam2nd' num2str(StructInfo.expnum) '2;'])
for k = fignum
    [ h ] = pmf_LineIinjdAPHz1(k, SrcStruct);
    switch k
        case 4
            h.htitle.String = 'Weak injection (0-150 pA; 30 pA increment)';
        case 5
            h.htitle.String = 'Strong injection (0-500 pA; 100 pA increment)';
        otherwise
            disp('otherwise')
    end
    hstruct(k) = h;
end

clear fignum k SrcStruct h hstruct

%% Making figure Rinput A (Traces)
fignum = 1;
eval(['SrcStruct = StructSub' num2str(StructInfo.expnum) ';'])
% eval(['SrcStruct2 = StructAvg' num2str(StructInfo.expnum) ';'])
series = 3;
sweep = 1:5;
yoffset = 0.03;

[hstruct] = pmf_TraceRinput1(fignum, SrcStruct, series, sweep, yoffset);
figure1 = hstruct.hfig;
set(hstruct.haxes(1),'YLim', [-.2 -.05]);

% Create line
annotation(figure1,'line',[0.675243393602225 0.810848400556327],...
    [0.0800810810810821 0.0800811891891892]);

% Create line
annotation(figure1,'line',[0.415855354659247 0.619610570236439],...
    [0.582432432432438 0.582432432432438],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.661335187760776 0.865090403337968],...
    [0.582432432432438 0.582432432432438],'LineWidth',2);

% Create textbox
annotation(figure1,'textbox',...
    [0.137691237664521 0.393344013652255 0.234863393996899 0.0391891884239944],...
    'String',{'Injected currents'},...
    'HorizontalAlignment','center',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.143182377262449 0.891079828937739 0.223881114801044 0.0391891884239942],...
    'String',{'Membrane pontential'},...
    'HorizontalAlignment','center',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.416666666666667 0.544945946550048 0.200113378684807 0.0337837831796827],...
    'String','+400 µA',...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.663832199546485 0.544945946550048 0.200680272108843 0.0337837831796827],...
    'String','-400 µA',...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.821995464852608 0.630284994807288 0.0907271058709423 0.0337837831796826],...
    'String','40 mV',...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.823696145124717 0.186890975963732 0.0915793647571824 0.0337837831796827],...
    'String',{'30 pA'},...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.677437641723356 0.0395049299439819 0.132086167800454 0.0337837831796827],...
    'String',{'1 s'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create line
annotation(figure1,'line',[0.912436991600285 0.912436991600285],...
    [0.681389568821937 0.573162274618584]);

% Create line
annotation(figure1,'line',[0.912437849138321 0.912436134062249],...
    [0.231565329883571 0.167899706606027]);

clear figure1 SrcStruct series sweep hstruct fignum yoffset

%% Making figure Rinput B, C (line graph)
fignum = [2, 3];
eval(['SrcStruct1 = StructTimeParam' num2str(StructInfo.expnum) '1;'])
eval(['SrcStruct2 = StructDeltaSum' num2str(StructInfo.expnum) '1;'])

for k = fignum
    [ h ] = pmf_LineRinput1( k, SrcStruct1, SrcStruct2 );
    switch k
        case 2
            h.htitle.String = 'Input membrane resistance';
        case 3
            h.htitle.String = '\Delta Input membrane resistance';
        otherwise
            disp('otherwise')
    end
    hstruct(k) = h;
end

clear fignum k SrcStruct1 SrcStruct2 evalstr h hstruct

%% writetables of mAPs
for k = str2double([num2str(StructInfo.expnum) '1'])
    evalstr = ['writetable(TbAP' num2str(k) ', ''' mfilenamebase '_TbAP' num2str(k) '.csv'');'];
    eval(evalstr)
end

clear k evalstr

%% save variables
pms_Save1
pms_Save2
