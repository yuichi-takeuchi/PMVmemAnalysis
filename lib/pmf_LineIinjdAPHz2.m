function [ hstruct ] = pmf_LineIinjdAPHz2( fignum, SrcStruct )
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 10;

hfig = figure(fignum);
hold on
condition = {'Weak', 'Strong'};
for k = 1:6
    switch rem(fignum,2)
        case 0
            SrcTb = SrcStruct(k).Strong;
        case 1
            SrcTb = SrcStruct(k).Weak;
        otherwise
            disp('otherwise')
            break
    end
    plot(SrcTb.Intensity, SrcTb.Mean, '-k', 'LineWidth', (0.5*k));
end
hold off
haxes = gca;
grid(haxes,'off');

if fignum < 3
    titlestr = 'skin';
else
    titlestr = 'skull';
end
htitle = title(titlestr);

hxlabel = xlabel('Stimulus intensity (µA, DC)');
hylabel = ylabel('\Delta Firing rate (Hz)');
switch rem(fignum,2)
    case 0
        Legendvec = [SrcStruct.sIinj];
    case 1
        Legendvec = [SrcStruct.wIinj];
    otherwise
        disp('otherwise')
end

legendstr = cellfun(@num2str, num2cell(Legendvec), 'UniformOutput', false);
for l = 1:length(legendstr)
   legendstr{l} = [legendstr{l} ' pA'];
end
hlegend = legend(legendstr);

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 12 6]...
    );

set(haxes,...
    'Box', 'off',...
    'XLim', [-900 900],...
    'XTick',...
    linspace(-800,800,9),...
    'XTickLabel',{'-800','-600','-400','-200','0','200','400','600','800'},...
    'YLim', [-10 15],...
    'FontName', fontname,...
    'FontSize', fontsize...
    );

set(hxlabel,...
    'HorizontalAlignment', 'center'...
    );

set(hylabel,...
    'HorizontalAlignment', 'center'...
    );

set(hlegend,...
    'Box', 'off',...
    %{
    'Location', 'best'...
    'Location','northeastoutside'...
    'FontSize', 8,...
    %}
    'Location','eastoutside'...
    );

hstruct.hfig = hfig;
hstruct.haxes = haxes;
hstruct.hxlabel = hxlabel;
hstruct.hylabel = hylabel;
hstruct.htitle = htitle;
hstruct.hlegend = hlegend;