% Latest verstion is available in Github
% (https://github.com/yuichi-takeuchi/PMVmemAnalysis)
%
% Lisence:
% MIT License
%

%% Save variables
tic
save('Fg_561')
toc

%% Preparing Data structure
recnum = 19;

strexpNo = num2str(StructInfo.expnum);
SummaryData(recnum).Info = StructInfo.mfilenamebase;
SummaryData(recnum).ExpID = StructInfo.ExpID;
SummaryData(recnum).AniID = StructInfo.AniID;
SummaryData(recnum).Treatment = StructInfo.Treatment;
if exist(['StructTimeParam' strexpNo '1'], 'var')
    SummaryData(recnum).TimeParam = eval(['StructTimeParam' strexpNo '1']);
end
if exist(['StructDeltaSum' strexpNo '1'], 'var')
    SummaryData(recnum).DeltaSum = eval(['StructDeltaSum' strexpNo '1']);
end
if exist(['StructAPIinjParam1st' strexpNo '2'], 'var')
    SummaryData(recnum).APIinjParam1st = eval(['StructAPIinjParam1st' strexpNo '2']);
end
if exist(['StructAPIinjParam2nd' strexpNo '2'], 'var')
    SummaryData(recnum).APIinjParam2nd = eval(['StructAPIinjParam2nd' strexpNo '2']);
end

eval(['clear StructTimeParam' strexpNo '1'])
eval(['clear StructDeltaSum' strexpNo '1'])
eval(['clear StructAPIinjParam1st' strexpNo '2'])
eval(['clear StructAPIinjParam2nd' strexpNo '2'])

clear animalID expID recnum strexpNo treatment StructInfo

tic
save('Fg_561')
toc

%% Preparing Table dEm
Intensity = [-800, -600, -400, -200, -100, -50, 0, 50, 100, 200, 400, 600, 800]';
SumSkin.Intensity = Intensity;
SumSkull.Intensity = Intensity;
for k = 1:length(SummaryData)
    TempStruct = SummaryData(k).DeltaSum;
    flag = false;
    for l = 1:length(TempStruct)
        if strcmp(TempStruct(l).Condition, 'VmemSeries' )
            SrcWave1 = TempStruct(l).Table.Intensity;
            SrcWave2 = TempStruct(l).Table.dVmemSub;
            flag = true;
            break
        end
    end
    if ~flag
        continue
    end
    for m = 1:length(Intensity)
        index = (SrcWave1 == Intensity(m));
        if any(index)
            dVmemSub(m) = SrcWave2(index);
        else
            dVmemSub(m) = NaN;
        end
    end
    
    switch SummaryData(k).Treatment
        case 'skin'
            evalstr = ['SumSkin.exp' num2str(SummaryData(k).ExpID) ' = dVmemSub'';'];
            eval(evalstr)
        case 'skull'
            evalstr = ['SumSkull.exp' num2str(SummaryData(k).ExpID) ' = dVmemSub'';'];
            eval(evalstr)
        otherwise
    end
    
    TbdEmSkin = struct2table(SumSkin);
    TbdEmSkull = struct2table(SumSkull);
end

clear evalstr Intensity dVmemSub index k l m SrcWave1 SrcWave2 SumSkin SumSkull TempStruct flag

%% Removing suboptimal data points (dEm)
TbdEmSkin.exp2790(:) = NaN;
TbdEmSkull.exp2781(1) = NaN;
TbdEmSkull.exp2782([1:4, 10:13]) = NaN;
TbdEmSkull.exp2783([1:4, 10:13]) = NaN;
TbdEmSkull.exp2797([1:4, 10:13]) = NaN;

%% Preparing Table dAPsponta
Intensity = [-800, -600, -400, -200, -100, -50, 0, 50, 100, 200, 400, 600, 800]';
SumSkin.Intensity = Intensity;
SumSkull.Intensity = Intensity;
for k = 1:length(SummaryData)
    TempStruct = SummaryData(k).DeltaSum;
    flag = false;
    for l = 1:length(TempStruct)
       if strcmp(TempStruct(l).Condition, 'APspontaseries' )
           SrcWave1 = TempStruct(l).Table.Intensity;
           SrcWave2 = TempStruct(l).Table.dAPHz;
           flag = true;
           break
       end
    end
    if ~flag
        continue
    end
    for m = 1:length(Intensity)
        index = (SrcWave1 == Intensity(m));
        if any(index)
            dAPHz(m) = SrcWave2(index);
        else
            dAPHz(m) = NaN;
        end
    end
    
    switch SummaryData(k).Treatment
        case 'skin'
            evalstr = ['SumSkin.exp' num2str(SummaryData(k).ExpID) ' = dAPHz'';'];
            eval(evalstr)
        case 'skull'
            evalstr = ['SumSkull.exp' num2str(SummaryData(k).ExpID) ' = dAPHz'';'];
            eval(evalstr)
        otherwise
    end
    
    TbdAPHzSkin = struct2table(SumSkin);
    TbdAPHzSkull = struct2table(SumSkull);
end

clear evalstr Intensity dAPHz index k l m SrcWave1 SrcWave2 SumSkin SumSkull flag TempStruct

%% Preparing Structure Rinputs
Intensity = [-800, -600, -400, -200, -100, -50, 0, 50, 100, 200, 400, 600, 800]';
Sum30Skin.Intensity = Intensity;
Sum60Skin.Intensity = Intensity;
Sum90Skin.Intensity = Intensity;
Sum30Skull.Intensity = Intensity;
Sum60Skull.Intensity = Intensity;
Sum90Skull.Intensity = Intensity;
for k = 1:length(SummaryData)
    TempStruct = SummaryData(k).TimeParam;
    flag = false;
    for l = 1:length(TempStruct)
       if strcmp(TempStruct(l).Condition, 'mRinputSeries' )
           SrcWave1 = TempStruct(l).Table.Intensity;
           SrcWave2 = TempStruct(l).Table.Rinput30;
           SrcWave3 = TempStruct(l).Table.Rinput60;
           SrcWave4 = TempStruct(l).Table.Rinput90;
           flag = true;
           break
       end
    end
    if ~flag
        continue
    end
    for m = 1:length(Intensity)
        index = (SrcWave1 == Intensity(m));
        if any(index)
            Rinput30(m) = SrcWave2(index);
            Rinput60(m) = SrcWave3(index);
            Rinput90(m) = SrcWave4(index);
        else
            Rinput30(m) = NaN;
            Rinput60(m) = NaN;
            Rinput90(m) = NaN;
        end
    end
    
    switch SummaryData(k).Treatment
        case 'skin'
            evalstr = ['Sum30Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput30'';'];
            eval(evalstr)
            evalstr = ['Sum60Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput60'';'];
            eval(evalstr)
            evalstr = ['Sum90Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput90'';'];
            eval(evalstr)
        case 'skull'
            evalstr = ['Sum30Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput30'';'];
            eval(evalstr)
            evalstr = ['Sum60Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput60'';'];
            eval(evalstr)
            evalstr = ['Sum90Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput90'';'];
            eval(evalstr)
        otherwise
    end
    
    StructRinputSkin.Iinj30 = struct2table(Sum30Skin);
    StructRinputSkin.Iinj60 = struct2table(Sum60Skin);
    StructRinputSkin.Iinj90 = struct2table(Sum90Skin);
    StructRinputSkull.Iinj30 = struct2table(Sum30Skull);
    StructRinputSkull.Iinj60 = struct2table(Sum60Skull);
    StructRinputSkull.Iinj90 = struct2table(Sum90Skull);
end

clear evalstr Intensity index k l m SrcWave1 SrcWave2 SrcWave3 SrcWave4 Sum30Skin Sum60Skin Sum90Skin Sum30Skull Sum60Skull Sum90Skull Rinput30 Rinput60 Rinput90 flag TempStruct

%% Preparing Structure dRinputs
Intensity = [-800, -600, -400, -200, -100, -50, 0, 50, 100, 200, 400, 600, 800]';
Sum30Skin.Intensity = Intensity;
Sum60Skin.Intensity = Intensity;
Sum90Skin.Intensity = Intensity;
Sum30Skull.Intensity = Intensity;
Sum60Skull.Intensity = Intensity;
Sum90Skull.Intensity = Intensity;
for k = 1:length(SummaryData)
    TempStruct = SummaryData(k).DeltaSum;
    flag = false;
    for l = 1:length(TempStruct)
       if strcmp(TempStruct(l).Condition, 'RinputSeries' )
           SrcWave1 = TempStruct(l).Table.Intensity;
           SrcWave2 = TempStruct(l).Table.dRinput30;
           SrcWave3 = TempStruct(l).Table.dRinput60;
           SrcWave4 = TempStruct(l).Table.dRinput90;
           flag = true;
           break
       end
    end
    if ~flag
        continue
    end
    for m = 1:length(Intensity)
        index = (SrcWave1 == Intensity(m));
        if any(index)
            Rinput30(m) = SrcWave2(index);
            Rinput60(m) = SrcWave3(index);
            Rinput90(m) = SrcWave4(index);
        else
            Rinput30(m) = NaN;
            Rinput60(m) = NaN;
            Rinput90(m) = NaN;
        end
    end
    
    switch SummaryData(k).Treatment
        case 'skin'
            evalstr = ['Sum30Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput30'';'];
            eval(evalstr)
            evalstr = ['Sum60Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput60'';'];
            eval(evalstr)
            evalstr = ['Sum90Skin.exp' num2str(SummaryData(k).ExpID) ' = Rinput90'';'];
            eval(evalstr)
        case 'skull'
            evalstr = ['Sum30Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput30'';'];
            eval(evalstr)
            evalstr = ['Sum60Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput60'';'];
            eval(evalstr)
            evalstr = ['Sum90Skull.exp' num2str(SummaryData(k).ExpID) ' = Rinput90'';'];
            eval(evalstr)
        otherwise
    end
    
    StructdRinputSkin.Iinj30 = struct2table(Sum30Skin);
    StructdRinputSkin.Iinj60 = struct2table(Sum60Skin);
    StructdRinputSkin.Iinj90 = struct2table(Sum90Skin);
    StructdRinputSkull.Iinj30 = struct2table(Sum30Skull);
    StructdRinputSkull.Iinj60 = struct2table(Sum60Skull);
    StructdRinputSkull.Iinj90 = struct2table(Sum90Skull);
end

clear evalstr Intensity index k l m SrcWave1 SrcWave2 SrcWave3 SrcWave4 Sum30Skin Sum60Skin Sum90Skin Sum30Skull Sum60Skull Sum90Skull Rinput30 Rinput60 Rinput90 flag TempStruct

%% Preparing Structure of APIinjParam1st (mAPHz vs Iinj (cont, weak, strong))
Intensity = linspace(0,800,5);
wIinj = linspace(0,150,6)';
sIinj = linspace(0,500,6)';
wControlSkin.wIinj = wIinj;
sControlSkin.sIinj = sIinj;
wPositiveSkin.wIinj = wIinj;
sPositiveSkin.sIinj = sIinj;
wNegativeSkin.wIinj = wIinj;
sNegativeSkin.sIinj = sIinj;
wControlSkull.wIinj = wIinj;
sControlSkull.sIinj = sIinj;
wPositiveSkull.wIinj = wIinj;
sPositiveSkull.sIinj = sIinj;
wNegativeSkull.wIinj = wIinj;
sNegativeSkull.sIinj = sIinj;

for o = 1:length(Intensity)
    for k = 1:length(SummaryData)
        TempStruct = SummaryData(k).APIinjParam1st;
        flag = false;
        for l = 1:length(TempStruct)
           if TempStruct(l).Intensity == Intensity(o)
               SrcWave0 = TempStruct(1).mAPHz.wIinj;
               SrcWave1 = TempStruct(l).mAPHz.wControl;
               SrcWave2 = TempStruct(l).mAPHz.sControl;
               SrcWave3 = TempStruct(l).mAPHz.wPositive;
               SrcWave4 = TempStruct(l).mAPHz.sPositive;
               SrcWave5 = TempStruct(l).mAPHz.wNegative;
               SrcWave6 = TempStruct(l).mAPHz.sNegative;
               flag = true;
               break
           end
        end
        if ~flag
            continue
        end
        for m = 1:length(wIinj)
            index = (SrcWave0 == wIinj(m));
            if any(index)
                wControl(m) = SrcWave1(index);
                sControl(m) = SrcWave2(index);
                wPositive(m) = SrcWave3(index);
                sPositive(m) = SrcWave4(index);
                wNegative(m) = SrcWave5(index);
                sNegative(m) = SrcWave6(index);
            else
                wControl(m) = NaN;
                sControl(m) = NaN;
                wPositive(m) = NaN;
                sPositive(m) = NaN;
                wNegative(m) = NaN;
                sNegative(m) = NaN;
            end
        end

        switch SummaryData(k).Treatment
            case 'skin'
                evalstr = ['wControlSkin.exp' num2str(SummaryData(k).ExpID) ' = wControl'';'];
                eval(evalstr)
                evalstr = ['sControlSkin.exp' num2str(SummaryData(k).ExpID) ' = sControl'';'];
                eval(evalstr)
                evalstr = ['wPositiveSkin.exp' num2str(SummaryData(k).ExpID) ' = wPositive'';'];
                eval(evalstr)
                evalstr = ['sPositiveSkin.exp' num2str(SummaryData(k).ExpID) ' = sPositive'';'];
                eval(evalstr)
                evalstr = ['wNegativeSkin.exp' num2str(SummaryData(k).ExpID) ' = wNegative'';'];
                eval(evalstr)
                evalstr = ['sNegativeSkin.exp' num2str(SummaryData(k).ExpID) ' = sNegative'';'];
                eval(evalstr)
            case 'skull'
                evalstr = ['wControlSkull.exp' num2str(SummaryData(k).ExpID) ' = wControl'';'];
                eval(evalstr)
                evalstr = ['sControlSkull.exp' num2str(SummaryData(k).ExpID) ' = sControl'';'];
                eval(evalstr)
                evalstr = ['wPositiveSkull.exp' num2str(SummaryData(k).ExpID) ' = wPositive'';'];
                eval(evalstr)
                evalstr = ['sPositiveSkull.exp' num2str(SummaryData(k).ExpID) ' = sPositive'';'];
                eval(evalstr)
                evalstr = ['wNegativeSkull.exp' num2str(SummaryData(k).ExpID) ' = wNegative'';'];
                eval(evalstr)
                evalstr = ['sNegativeSkull.exp' num2str(SummaryData(k).ExpID) ' = sNegative'';'];
                eval(evalstr)
            otherwise
        end
    end
    
    StructIinjmAPHzSkin(o).Intensity = Intensity(o);
    StructIinjmAPHzSkin(o).wControl = struct2table(wControlSkin);
    StructIinjmAPHzSkin(o).sControl = struct2table(sControlSkin);
    StructIinjmAPHzSkin(o).wPositive = struct2table(wPositiveSkin);
    StructIinjmAPHzSkin(o).sPositive = struct2table(sPositiveSkin);
    StructIinjmAPHzSkin(o).wNegative = struct2table(wNegativeSkin);
    StructIinjmAPHzSkin(o).sNegative = struct2table(sNegativeSkin);

    StructIinjmAPHzSkull(o).Intensity = Intensity(o);
    StructIinjmAPHzSkull(o).wControl = struct2table(wControlSkull);
    StructIinjmAPHzSkull(o).sControl = struct2table(sControlSkull);
    StructIinjmAPHzSkull(o).wPositive = struct2table(wPositiveSkull);
    StructIinjmAPHzSkull(o).sPositive = struct2table(sPositiveSkull);
    StructIinjmAPHzSkull(o).wNegative = struct2table(wNegativeSkull);
    StructIinjmAPHzSkull(o).sNegative = struct2table(sNegativeSkull);
end

clear evalstr flag index Intensity k l m o sControl sControlSkin sControlSkull sIinj sNegative sNegativeSkin sNegativeSkull
clear sPositive sPositiveSkin sPositiveSkull SrcWave0 SrcWave1 SrcWave2 SrcWave3 SrcWave4 SrcWave5 SrcWave6 TempStruct
clear wControl wControlSkin wControlSkull wIinj wNegative wNegativeSkin wNegativeSkull wPositive wPositiveSkin wPositiveSkull

%% Concatenating and Calculating delta effects of mAPIinjParam1st-2 (mAPHz vs Iinj)
Varlist = who('StructIinjm*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [DestStruct] = pmf_MakeStructIinjmAPHz2(SrcStruct);
    [DestStruct] = pmf_ModifyConcaStructIinjmAPHz1(DestStruct);
    [DestStruct] = pmf_ModifyConcaStructIinjmAPHz2(DestStruct);
    eval(['Conca' Varlist{k} ' = DestStruct;'])
end

clear SrcStruct DestStruct k Varlist

%% Preparing Structure of dAPIinjParam1st (dAPHz vs Intensity (wIinj, sIinj))
wIinj = linspace(0,150,6);
sIinj = linspace(0,500,6);
Intensity = linspace(-800,800,9)';
WeakSkin.Intensity = Intensity;
StrongSkin.Intensity = Intensity;
WeakSkull.Intensity = Intensity;
StrongSkull.Intensity = Intensity;
for o = 1:6
    for k = 1:length(SummaryData)
        TempStruct = SummaryData(k).APIinjParam2nd;
        flag = false;
        for l = 1:length(TempStruct)
           if TempStruct(l).wIinj == wIinj(o)
               SrcWave0 = TempStruct(l).Weak.Intensity;
               SrcWave1 = TempStruct(l).Weak.dAPHz;
               SrcWave2 = TempStruct(l).Strong.dAPHz;
               flag = true;
               break
           end
        end
        if ~flag
            continue
        end
        for m = 1:length(Intensity)
            index = (SrcWave0 == Intensity(m));
            if any(index)
                weak(m) = SrcWave1(index);
                strong(m) = SrcWave2(index);
            else
                weak(m) = NaN;
                strong(m) = Nan;
            end
        end

        switch SummaryData(k).Treatment
            case 'skin'
                evalstr = ['WeakSkin.exp' num2str(SummaryData(k).ExpID) ' = weak'';'];
                eval(evalstr)
                evalstr = ['StrongSkin.exp' num2str(SummaryData(k).ExpID) ' = strong'';'];
                eval(evalstr)
            case 'skull'
                evalstr = ['WeakSkull.exp' num2str(SummaryData(k).ExpID) ' = weak'';'];
                eval(evalstr)
                evalstr = ['StrongSkull.exp' num2str(SummaryData(k).ExpID) ' = strong'';'];
                eval(evalstr)
            otherwise
        end
    end
    
    StructIinjdAPHzSkin(o).wIinj = wIinj(o);
    StructIinjdAPHzSkin(o).sIinj = sIinj(o);
    StructIinjdAPHzSkin(o).Weak = struct2table(WeakSkin);
    StructIinjdAPHzSkin(o).Strong = struct2table(StrongSkin);

    StructIinjdAPHzSkull(o).wIinj = wIinj(o);
    StructIinjdAPHzSkull(o).sIinj = sIinj(o);
    StructIinjdAPHzSkull(o).Weak = struct2table(WeakSkull);
    StructIinjdAPHzSkull(o).Strong = struct2table(StrongSkull);

end

clear evalstr flag index Intensity k l m o sIinj SrcWave0 SrcWave1 SrcWave2 strong StrongSkin StrongSkull
clear TempStruct weak WeakSkin WeakSkull wIinj

%% Mean Std Sem: dTables (Em, APHz)
Varlist = who('Tbd*');
for k = 1:length(Varlist)
    eval(['SrcTb = ' Varlist{k} ';'])
    [DestTb] = yfMeanStdSemOfTable1(SrcTb);
    eval(['Mean' Varlist{k} ' = DestTb;'])
end

clear SrcTb DestTb Varlist k

%% Mean Std: mTables (Rinput & dRinput)
Varlist = [who('StructRinput*'); who('StructdRinput*')];
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [DestStruct] = pmf_MeanRinput(SrcStruct);
    eval(['Mean' Varlist{k} ' = DestStruct;'])
end

clear SrcStruct DestStruct Varlist k

%% Mean Std: mTables (APIinjd)
Varlist = who('StructIinjd*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [DestStruct] = pmf_MeanAPIinjd(SrcStruct);
    eval(['Mean' Varlist{k} ' = DestStruct;'])
end

clear SrcStruct DestStruct k Varlist

%% Mean Std: mTables (APIinjm)
Varlist = who('StructIinjm*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [DestStruct] = pmf_MeanEachTbInStruct(SrcStruct);
    eval(['Mean' Varlist{k} ' = DestStruct;'])
end

clear SrcStruct DestStruct k Varlist

%% Mean Std: mTables (ConcaAPIinjm)
Varlist = who('ConcaStructIinjm*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [DestStruct] = pmf_MeanEachTbInStruct(SrcStruct);
    eval(['Mean' Varlist{k} ' = DestStruct;'])
end

clear SrcStruct DestStruct k Varlist

%% Figure dEm (Bar)
Varlist = who('MeanTbdEm*');
for k = 1:length(Varlist)
    eval(['SrcTb = ' Varlist{k} ';'])
    [hstruct] = pmf_BarEm2(SrcTb, k);
    eval(['hdEm(' num2str(k)  ') =  hstruct;'])
end

clear SrcTb Varlist k hstruct
clear hdEm

%% Figure dEm2 (Bar)
SrcTb1 = MeanTbdEmSkin;
SrcTb2 = MeanTbdEmSkull;
groupwidth = 29;
[hstruct] = pmf_BarEm3(SrcTb1, SrcTb2, 1, groupwidth);

clear SrcTb1 SrcTb2 hstruct groupwidth

%% Figure dEm3 (Bar)
SrcTb1 = MeanTbdEmSkin;
SrcTb2 = MeanTbdEmSkull;
groupwidth = 29;
[hstruct] = pmf_BarEm4(SrcTb1, SrcTb2, 1, groupwidth);

clear SrcTb1 SrcTb2 hstruct groupwidth
%% Figure dAPHz (Bar)
Varlist = who('MeanTbdAP*');
for k = 1:length(Varlist)
    eval(['SrcTb = ' Varlist{k} ';'])
    [hstruct] = pmf_BarSpike2(SrcTb, k);
    eval(['hdAPHz(' num2str(k)  ') =  hstruct;'])
end

clear SrcTb Varlist k hstruct
clear hdAPHz

%% Figure dAPHz2 (Bar)
SrcTb1 = MeanTbdAPHzSkin;
SrcTb2 = MeanTbdAPHzSkull;
groupwidth = 29;
[hstruct] = pmf_BarSpike3(SrcTb1, SrcTb2, 1, groupwidth);

clear SrcTb1 SrcTb2 hstruct groupwidth

%% Figure dAPHz2 (Bar)
SrcTb1 = MeanTbdAPHzSkin;
SrcTb2 = MeanTbdAPHzSkull;
groupwidth = 29;
[hstruct] = pmf_BarSpike4(SrcTb1, SrcTb2, 1, groupwidth);

clear SrcTb1 SrcTb2 hstruct groupwidth

%% Figure Rinput (Line)
Varlist = who('MeanStructRinput*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [hstruct] = pmf_LineRinput2(k, SrcStruct);
    eval(['hRinput(' num2str(k)  ') =  hstruct;'])
end

clear SrcStruct Varlist k hstruct
clear hRinput

%% Figure dRinput (Line)
Varlist = who('MeanStructdRinput*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [hstruct] = pmf_LineRinput2(k, SrcStruct);
    set(hstruct.hylabel,'String','\Delta Input membrane resistance (MOhm)');
    eval(['hdRinput(' num2str(k)  ') =  hstruct;'])
end

clear SrcStruct Varlist k hstruct
clear hdRinput

%% Figure Rinput (Trace)
fignum = 1;
eval('SrcStruct1 = StructSub2786;')
eval('SrcStruct2 = StructSub2776;')
series1 = 23;
series2 = 3;
sweep = 1:5;
yoffset = 0.03;

[hstruct] = pmf_TraceRinput2(fignum, SrcStruct1, SrcStruct2, series1, series2, sweep, yoffset);

clear fignum series1 series2 sweep yoffset hstruct SrcStruct1 SrcStruct2

%% Figure IinjmAPHz (line)
Varlist = who('MeanStructIinjmAPHz*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    for l = 1:2
        fignum = 2*(k-1)+l;
        [hstruct] = pmf_LineIinjmAPHz2(fignum, SrcStruct);
        eval(['hIinjmAPHz(' num2str(fignum)  ') =  hstruct;'])
    end
end

clear SrcStruct Varlist hstruct fignum k l
clear hIinjmAPHz

%% Figure IinjmAPHz2 (line)
Varlist = who('MeanConcaStructIinjmAPHz*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [hstruct] = pmf_LineIinjmAPHz3(k, SrcStruct);
    eval(['hIinjmAPHz2(' num2str(k)  ') =  hstruct;'])
end

clear SrcStruct Varlist hstruct k
clear hIinjmAPHz2

%% Figure IinjdAPHz (line)
Varlist = who('MeanStructIinjdAPHz*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    for l = 1:2
        fignum = 2*(k-1)+l;
        [hstruct] = pmf_LineIinjdAPHz2(fignum, SrcStruct);
        eval(['hIinjdAPHz(' num2str(fignum)  ') =  hstruct;'])
    end
end

clear SrcStruct Varlist k l hstruct fignum
clear hIinjdAPHz

%% Figure IinjdAPHz2 (line)
Varlist = who('MeanConcaStructIinjmAPHz*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [hstruct] = pmf_LineIinjdAPHz3(k, SrcStruct);
    eval(['hIinjdAPHz2(' num2str(k)  ') =  hstruct;'])
end

clear SrcStruct Varlist hstruct k
clear hIinjdAPHz2

%% Figure IinjdAPHz3 (line)
Varlist = who('MeanConcaStructIinjmAPHz*');
for k = 1:length(Varlist)
    eval(['SrcStruct = ' Varlist{k} ';'])
    [hstruct] = pmf_LineIinjdAPHz4(k, SrcStruct);
    eval(['hIinjdAPHz3(' num2str(k)  ') =  hstruct;'])
end

clear SrcStruct Varlist hstruct k
clear hIinjdAPHz3

%% Figure Iinj (Trace weak)
fignum = 1;
eval('SrcStruct1 = StructSub2787;')
eval('SrcStruct2 = StructSub2776;')
series1 = 20;
series2 = 20;
sweep = 2:4;

[hstruct] = pmf_TraceGain2(fignum, SrcStruct1, SrcStruct2, series1, series2, sweep);

clear fignum series1 series2 sweep hstruct SrcStruct1 SrcStruct2

%% Figure Iinj (Trace Strong)
fignum = 1;
eval('SrcStruct1 = StructSub2787;')
eval('SrcStruct2 = StructSub2776;')
series1 = 20;
series2 = 20;
sweep = 2:4;

[hstruct] = pmf_TraceGain3(fignum, SrcStruct1, SrcStruct2, series1, series2, sweep);

clear fignum series1 series2 sweep hstruct SrcStruct1 SrcStruct2

%% Rinput, dRinput Value Correction
for k = 1:length(SummaryData)
    if length(SummaryData(k).TimeParam) > 3 && ~isempty(SummaryData(k).TimeParam(l).Table)
        for l = 5:6;
            SrcTb = SummaryData(k).TimeParam(l).Table;
            [DestTb] = RinputCorrection2(SrcTb);
            SummaryData(k).TimeParam(l).Table = DestTb;
        end
    end
    
    if length(SummaryData(k).DeltaSum) > 2 && ~isempty(SummaryData(k).DeltaSum(m).Table)
        for m = 3:4
            SrcTb = SummaryData(k).DeltaSum(m).Table;
            [DestTb] = RinputCorrection2(SrcTb);
            SummaryData(k).DeltaSum(m).Table = DestTb;
        end
    end
end

clear k l m SrcTb DestTb
    