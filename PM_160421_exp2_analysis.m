% Latest verstion is available in Github
% (https://github.com/yuichi-takeuchi/PMVmemAnalysis)
%
% Lisence:
% MIT License
%

%% StructInfo
StructInfo.mfilenamebase = 'PM_160421_exp2_analysis';
StructInfo.ExpID = 2771;
StructInfo.AniID = 1689;
StructInfo.Treatment = 'skin';
StructInfo.expnum = 2;
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
SeriesVector = 1:22;

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
SeriesVector = 26:30;

evalstr = ['SrcStruct = StructAvg' num2str(StructInfo.expnum) ';'];
eval(evalstr)
[DestStruct] = pmf_ArtifactBaselineSubtraction(SrcStruct, SeriesVector, StructInfo.sr);
evalstr = ['StructAvg' num2str(StructInfo.expnum) ' = DestStruct;'];
eval(evalstr)
disp('baselines of artifact traces were subtracted!')

clear SrcStruct DestStruct evalstr SeriesVector

%% Artifact subtraction for each traces
SignalVector = [1:5, 6:10, 11:15, 16:20];
ArtifactVector = [26:30, 31:35, 26:30, 36:40];
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
SeriesPair = [(1:5)', (26:30)'];

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
SeriesVector = 1:5;

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
SeriesVector = 26:30;

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
SeriesVector = 6:10;

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
series = 4;
sweep = 1:5;
yoffset = 0.03;

[hstruct] = pmf_TraceEm1(SrcStruct, fignum, series, sweep, yoffset);
set(hstruct.haxes, 'YLim', [-0.24 -0.06]);
figure1 = hstruct.hfig;
    
% line ‚ð?ì?¬
annotation(figure1,'line',[0.259832635983263 0.389121338912134],...
    [0.113214860956288 0.113214860956288],'LineWidth',2);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.645188284518825 0.774476987447695],...
    [0.113214860956288 0.113214860956288],'LineWidth',2);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.264917493366474 0.0486154071176723 0.116751271566966 0.0544430547423],...
    'String','+600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.655830140392414 0.0486154071176723 0.111675129313961 0.0544430547423],...
    'String','-600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% line ‚ð?ì?¬
annotation(figure1,'line',[0.73654375487463 0.838635805083835],...
    [0.0220584433506421 0.0217034298005071],'LineWidth',1);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.838174273858921 0.838174273858921],...
    [0.125185320859958 0.0228087212255886],'LineWidth',1);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.837849164889023 0.0520222614930343 0.065989849036922 0.0406758454027999],...
    'String',{'20 mV'},...
    'Interpreter','none',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.767819503646732 0.0169899140417062 0.0431472088984022 0.0406758454028001],...
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
series = 15;
sweep = 1:5;
yoffset = 0.1;

[hstruct] = pmf_TraceSpike1(SrcStruct, fignum, series, sweep, yoffset);
figure1 = hstruct.hfig;
set(hstruct.haxes, 'YLim', [-0.55 0.02]);

% Create line
annotation(figure1,'line',[0.259832635983263 0.389121338912134],...
    [0.152520325203252 0.152520325203252],'LineWidth',2);

% Create line
annotation(figure1,'line',[0.851313969571233 0.851310760719228],...
    [0.181938911022576 0.110401902115645],'LineWidth',1);

% Create line
annotation(figure1,'line',[0.749596347158799 0.851688397368004],...
    [0.10987762770058 0.109522614150445],'LineWidth',1);

% Create line
annotation(figure1,'line',[0.645188284518825 0.774476987447695],...
    [0.15252 0.15252],'LineWidth',2);

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
    [0.760204081632653 0.127187837144409 0.143990929705215 0.0406758454027997],...
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
series = 19;
sweep = 2:5;

[hstruct] = pmf_TraceGain1(fignum, SrcStruct1, SrcStruct2, series, sweep);
figure1 = hstruct.hfig;
set(hstruct.haxes(1),'YLim', [-0.09 0.01]);
set(hstruct.haxes(2),'YLim', [-1e-10 5e-10]);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.42037388874657 0.485260770975057],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.549217473206634 0.614104355435121],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.678185727174889 0.743072609403375],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.394829566207425 0.525255536901352 0.116751271566966 0.0544430547422998],...
    'String','+600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.523514373463661 0.525255536901352 0.116751271566966 0.0544430547422998],...
    'String','+600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.655708916662951 0.525255536901352 0.111675129313961 0.0544430547422998],...
    'String','-600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.78538578741125 0.525255536901352 0.111675129313961 0.0544430547422998],...
    'String','-600 µA',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.88775114602054 0.278327092852555 0.0388979022571401 0.0406758454027998],...
    'String','0.1 nA',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% line ‚ð?ì?¬
annotation(figure1,'line',[0.809919923338926 0.875283446712019],...
    [0.111485306328451 0.11099194166617],'LineWidth',1);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.821028080576271 0.0653981398517798 0.0431472088984022 0.0406758454028003],...
    'String','1 s',...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.144307308208446 0.375381051651199 0.0827664417136553 0.0440976939984222],...
    'String',{'Injected current'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.134953566488836 0.873345773496515 0.101473925152874 0.0440976939984222],...
    'String',{'Membrane potential'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.881112141871162 0.544991621682381 0.0388979022571402 0.0406758454028004],...
    'String','20 mV',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% line ‚ð?ì?¬
annotation(figure1,'line',[0.882918395573998 0.882917496542184],...
    [0.586391631635549 0.516981132075472],'LineWidth',1);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.882917489626556 0.882918402489626],...
    [0.326415094339623 0.267921258539034],'LineWidth',1);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.807845544075369 0.872732426303856],...
    [0.585103380881751 0.585103380881751],'LineWidth',2);

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
series = 8;
sweep = 1:5;
yoffset = 0.03;

[hstruct] = pmf_TraceRinput1(fignum, SrcStruct, series, sweep, yoffset);
figure1 = hstruct.hfig;
set(hstruct.haxes(1),'YLim', [-.22 -.06]);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.675243393602225 0.810848400556327],...
    [0.0800810810810821 0.0800811891891892]);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.415855354659247 0.619610570236439],...
    [0.582432432432438 0.582432432432438],'LineWidth',2);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.729485396684376 0.040891892495993 0.0271210007898002 0.0337837831796827],...
    'String',{'1 s'},...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% line ‚ð?ì?¬
annotation(figure1,'line',[0.661335187760776 0.865090403337968],...
    [0.582432432432438 0.582432432432438],'LineWidth',2);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.493045897379786 0.544945946550048 0.0462447832518559 0.0337837831796827],...
    'String','+400 µA',...
    'HorizontalAlignment','center',...
    'FontSize',9,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.744784423109966 0.544945946550048 0.0441585524378135 0.0337837831796827],...
    'String','-400 µA',...
    'HorizontalAlignment','center',...
    'FontSize',9,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.143254519835301 0.393344013652255 0.0994436690099383 0.0391891884239944],...
    'String',{'Injected currents'},...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.132127955493741 0.891079828937739 0.121696797693058 0.0391891884239943],...
    'String',{'Membrane pontential'},...
    'HorizontalAlignment','center',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% line ‚ð?ì?¬
annotation(figure1,'line',[0.913458431623759 0.913462787489155],...
    [0.231565329883571 0.145719489981785]);

% line ‚ð?ì?¬
annotation(figure1,'line',[0.913460609556457 0.913460609556457],...
    [0.687977640943993 0.601139803106154]);

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.913594489351065 0.630284994807288 0.0440818591966528 0.0337837831796826],...
    'String','40 mV',...
    'HorizontalAlignment','center',...
    'FontSize',9,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

% textbox ‚ð?ì?¬
annotation(figure1,'textbox',...
    [0.913309123888861 0.177080370793575 0.0382475651313599 0.0337837831796828],...
    'String',{'30 pA'},...
    'HorizontalAlignment','center',...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'EdgeColor','none');

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
