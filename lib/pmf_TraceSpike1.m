function [hstruct] = pmf_TraceSpike1(SrcStruct, fignum, series, sweep, yoffset)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 8;

hfig = figure(fignum);
haxes = axes('Parent',hfig);
axis off

hold(haxes,'on');
xwave = linspace(0, 15, 300000);
for l = sweep
    SrcWave = SrcStruct(series).Voltage{l,1};
    SrcWave = SrcWave - yoffset * (l - 1);
    plot(xwave, SrcWave, 'k', 'LineWidth', 0.3)
end
hold(haxes,'off');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 12 9]...
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