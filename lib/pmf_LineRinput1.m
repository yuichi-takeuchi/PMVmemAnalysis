function [ hstruct ] = pmf_LineRinput1( fignum, SrcStruct1, SrcStruct2 )
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 12;

hfig = figure(fignum);
htitle = title('');
hxlabel = xlabel('Stimulus intensity (µA, DC)');
hylabel = ylabel('Input membrane resistance (\Omega)');
haxes = gca;
hold(haxes, 'on');
switch fignum
    case 2
        SrcTb = SrcStruct1(6).Table;
        plot(haxes, SrcTb.Intensity, SrcTb.Rinput30, '-ok')
        plot(haxes, SrcTb.Intensity, SrcTb.Rinput60, '-sk')
        plot(haxes, SrcTb.Intensity, SrcTb.Rinput90, '-^k')
    case 3
        SrcTb = SrcStruct2(4).Table;
        plot(haxes, SrcTb.Intensity, SrcTb.dRinput30, '-ok')
        plot(haxes, SrcTb.Intensity, SrcTb.dRinput60, '-sk')
        plot(haxes, SrcTb.Intensity, SrcTb.dRinput90, '-^k')
    otherwise
        disp('otherwise')
end

hlegend = legend({'-30 pA injection', '-60 pA injection', '-90 pA injection'}, ...
    'Location', 'best',...
    'box', 'off');

grid(haxes,'off');
hold(haxes,'off');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 9 6]...
    );

set(haxes,...
    'FontName', fontname,...
    'FontSize', fontsize...
    );

set(htitle,...
    'FontName', fontname,...
    'FontSize', (fontsize + 2)...
    );

set(hxlabel,...
    'HorizontalAlignment', 'center'...
    );

set(hylabel,...
    'HorizontalAlignment', 'center'...
    );

hstruct.hfig = hfig;
hstruct.haxes = haxes;
hstruct.hxlabel = hxlabel;
hstruct.hylabel = hylabel;
hstruct.htitle = htitle;
hstruct.hlegend = hlegend;
