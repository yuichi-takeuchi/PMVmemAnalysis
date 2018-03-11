function [ hstruct ] = pmf_LineIinjmAPHz2(fignum, SrcStruct)
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 10;

hfig = figure(fignum);
hold on
condition = {...
    'Control', 'Positive', 'Negative';...
    '-k', '-r', '-b'...
    };
switch rem(fignum, 2)
    case 0
        str = 's';
        ylimvec = [0 50];
    case 1
        str = 'w';
        ylimvec = [0 20];
    otherwise
        disp('otherwise')
end
for l = 1:5
    for k = 1:3
        eval(['SrcTb = SrcStruct(' num2str(l) ').' str condition{1,k} ';'])
        eval(['X = SrcTb.' str 'Iinj;'])
        plot(X,SrcTb.Mean, condition{2,k}, 'LineWidth', (0.5*l))
    end
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

hxlabel = xlabel('Injected current (pA, DC)');
hylabel = ylabel('Firing rate (Hz)');
hlegend = legend({...
    'control', '+0 �A', '-0 �A',...
    'control', '+200 �A', '-200 �A',...
    'control', '+400 �A', '-400 �A',...
    'control', '+600 �A', '-600 �A',...
    'control', '+800 �A', '-800 �A',...
    });

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 12 6]...
    );

set(haxes,...
    'Box', 'off',...
    'YLim', ylimvec,...
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
    'FontSize', 8,...
    'Location','northeastoutside'...
    );

hstruct.hfig = hfig;
hstruct.haxes = haxes;
hstruct.hxlabel = hxlabel;
hstruct.hylabel = hylabel;
hstruct.htitle = htitle;
hstruct.hlegend = hlegend;