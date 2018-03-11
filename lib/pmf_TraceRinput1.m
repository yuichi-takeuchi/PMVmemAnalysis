function [hstruct] = pmf_TraceRinput1(fignum, SrcStruct, series, sweep, yoffset)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 8;

hfig = figure(fignum);
haxes(1) = subplot(2, 1, 1);
haxes(1).Visible = 'off';
haxes(2) = subplot(2, 1, 2);
haxes(2).Visible = 'off';
hold(haxes(1),'on');
hold(haxes(2),'on');
xwave = linspace(0, 5.7, 114000);
for k = sweep
    SrcWave = SrcStruct(series).Voltage{k,1};
    SrcWave = SrcWave - yoffset * (k - 1);
    plot(haxes(1), xwave, SrcWave, 'k', 'LineWidth', 0.4)
end

SrcWave = zeros(114000,1);
for l = 1:3
    SrcWave([(6000+6000*l+1):(12000+6000*l),...
        (42000+6000*l+1):(48000+6000*l),...
        (78000+6000*l+1):(84000+6000*l)]) = -30e-12*l;
end
plot(haxes(2), xwave, SrcWave, 'k', 'LineWidth', 0.4)

hold(haxes(1),'off');
hold(haxes(2),'off');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 15 10]...
    );

set(haxes,...
    'XLim', [0 5.7],...
    'FontName', fontname,...
    'FontSize', fontsize...
    );

set(haxes(2),...
    'YLim', [-90E-12 0]...
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