function [hstruct] = pmf_TraceGain1(fignum, SrcStruct1, SrcStruct2, series, sweep)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 8;

hfig = figure(fignum);

haxes(1) = subplot(2, 1, 1);
axis off
haxes(2) = subplot(2, 1, 2);
axis off
hold(haxes(1),'on');
hold(haxes(2),'on');
xwave = linspace(0, 12, 240000);
for l = sweep
    SrcWave = SrcStruct1(series).Voltage{l,1};
    plot(haxes(1), xwave, SrcWave, 'k', 'LineWidth', 0.3)
    SrcWave = SrcStruct2(series).Current{l,1};
    plot(haxes(2), xwave, SrcWave, 'k', 'LineWidth', 0.3)
end
hold(haxes(1),'off');
hold(haxes(2),'off');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 15 9]...
    );

set(haxes,...
    %{
    'YLim', [-0.55 0.02],...
    'Box', 'on'...
%}
    'FontName', fontname,...
    'FontSize', fontsize...
    );

   %{
set(hxlabel,...
    'HorizontalAlignment', 'center'...
    );

set(hylabel,...
    'HorizontalAlignment', 'center'...
    );
    %}

hstruct.hfig = hfig;
hstruct.haxes = haxes;

% hstruct.hxlabel = hxlabel;
% hstruct.hylabel = hylabel;
% hstruct.htitle = htitle;
% hstruct.hlegend = hlegend;