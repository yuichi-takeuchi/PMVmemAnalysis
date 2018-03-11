function [ hstruct ] = pmf_LineIinjdAPHz1( fignum, SrcStruct )
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 12;

hfig = figure(fignum);
hold on
for l = 1:6
    switch fignum
        case 4
            SrcTb = SrcStruct(l).Weak;
        case 5
            SrcTb = SrcStruct(l).Strong;
        otherwise
            disp('otherwise')
    end
    plot(SrcTb.Intensity, SrcTb.dAPHz, '-k', 'LineWidth', (0.5*l));
end
hold off
haxes = gca;
grid(haxes,'off');

htitle = title('');
hxlabel = xlabel('Stimulus intensity (µA, DC)');
hylabel = ylabel('\Delta Firing rate (Hz)');

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 9 6]...
    );

set(haxes,...
    'XLim', [-800, 800],...
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