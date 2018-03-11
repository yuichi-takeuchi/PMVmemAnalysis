function [ hstruct ] = pmf_LineIinjmAPHz1(fignum, SrcStruct)
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 12;

hfig = figure(fignum);
hold on
for l = 1:5
    SrcTb = SrcStruct(l).mAPHz;
    switch fignum
        case 2
            plot(SrcTb.wIinj, SrcTb.wControl, '-k', 'LineWidth', (0.5*l));
            plot(SrcTb.wIinj, SrcTb.wPositive, '-r', 'LineWidth', (0.5*l));
            plot(SrcTb.wIinj, SrcTb.wNegative, '-b', 'LineWidth', (0.5*l));
        case 3
            plot(SrcTb.sIinj, SrcTb.sControl, '-k', 'LineWidth', (0.5*l));
            plot(SrcTb.sIinj, SrcTb.sPositive, '-r', 'LineWidth', (0.5*l));
            plot(SrcTb.sIinj, SrcTb.sNegative, '-b', 'LineWidth', (0.5*l));
        otherwise
            disp('otherwise')
    end
end
hold off
haxes = gca;
grid(haxes,'off');

htitle = title('±0-800 µA stimulation; 100 µA increment');
hxlabel = xlabel('Injected current (pA, DC)');
hylabel = ylabel('Firing rate (Hz)');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 9 6]...
    );

set(haxes,...
%{
    'YLim', [-0.55 0.02],...
    'Box', 'on'...
%}
    'FontName', fontname,...
    'FontSize', fontsize...
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
% hstruct.hlegend = hlegend;