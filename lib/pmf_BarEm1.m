function [hstruct] = pmf_BarEm1(SrcTb, fignum)
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 10;

hfig = figure(fignum);
% hfig = gcf;
hbar = bar(SrcTb.Intensity, SrcTb.dVmemSub);
haxes = gca;
hold(haxes, 'on');
% htitle = title('delta Membrane pontential (aritifact subtracted)');
hxlabel = xlabel('Stimulus intensity (µA, DC)');
hylabel = ylabel('\Delta Membrane potential (V)');
hold(haxes,'off');

grid(haxes,'off');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 9 7]...
    );

set(haxes,...
    'XTick',[-800 -600 -400 -200 0 200 400 600 800],...
    'XTickLabelRotation',45,...
%{
    'YTick',[-0.015 -0.01 -0.005 0 0.005 0.01 0.015],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YLim', [-0.017, 0.017],...
%}
    'FontName', fontname,...
    'FontSize', fontsize,...
    'Box', 'on'...
    );

set(hxlabel,...
    'HorizontalAlignment', 'center'...
    );

set(hylabel,...
    'HorizontalAlignment', 'center'...
    );
        
% constructing output handle structure
hstruct.hfig = hfig;
hstruct.haxes = haxes;
hstruct.hbar = hbar;
hstruct.hxlabel = hxlabel;
hstruct.hylabel = hylabel;
% hstruct.htitle = htitle;
% hstruct.hlegend = hlegend;
  