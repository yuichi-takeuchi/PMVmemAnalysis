function [hstruct] = pmf_PlotSweep(StructData, series, sweep)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% 
% Copyright (C) 2016 by Yuichi Takeuchi

hold on
for k = sweep
    plot(StructData(series).Voltage{k, 1})
end
hold off

hfig = gcf;
haxes = gca;
hstruct.hfig = hfig;
hstruct.haxes = haxes;

% hstruct.hxlabel = hxlabel;
% hstruct.hylabel = hylabel;
% hstruct.htitle = htitle;
% hstruct.hlegend = hlegend;

