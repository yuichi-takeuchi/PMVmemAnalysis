function [ hstruct ] = pmf_LineIinjmAPHz3(fignum, SrcStruct)
% 
% Copyright (C) 2016 by Yuichi Takeuchi

% Parameters
fontname = 'Arial';
fontsize = 10;

hfig = figure(fignum);
hold on
condition = {...
    'mControl', 'Positive', 'Negative';...
    '-k', '-r', '-b'...
    };

ylimvec = [0 50];

for l = 1:5
    for k = 2:3
        eval(['SrcTb = SrcStruct(' num2str(l) ').' condition{1,k} ';'])
        X = SrcTb.Iinj;
        plot(X,SrcTb.Mean, condition{2,k}, 'LineWidth', (0.5*l))
    end
end

SrcTb = SrcStruct(1).mControl;
X = SrcTb.Iinj;
plot(X,SrcTb.Mean, condition{2,1}, 'LineWidth', 3)

hold off
haxes = gca;
grid(haxes,'off');

if fignum < 2
    titlestr = 'skin';
else
    titlestr = 'skull';
end
htitle = title(titlestr);

hxlabel = xlabel('Injected current (pA, DC)');
hylabel = ylabel('Firing rate (Hz)');
hlegend = legend({...
    '+0 �A', '-0 �A',...
    '+200 �A', '-200 �A',...
    '+400 �A', '-400 �A',...
    '+600 �A', '-600 �A',...
    '+800 �A', '-800 �A',...
    'control',...
    });

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [7 7 12 6]...
    );

set(htitle,...
    'FontName', fontname,...
    'FontSize', (fontsize + 2)...
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
    'FontSize', fontsize,...
    'Location','northeastoutside'...
    );

hstruct.hfig = hfig;
hstruct.haxes = haxes;
hstruct.hxlabel = hxlabel;
hstruct.hylabel = hylabel;
hstruct.htitle = htitle;
hstruct.hlegend = hlegend;