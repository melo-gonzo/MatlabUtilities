CO=[0 0 0;
    0 0 1;
    1 0 0;
    0 0.5 0;
    0 0.75 0.75;
    0.75 0 0.75;
    0.75 0.75 0];
set(groot,'DefaultLineLineWidth',1.5);
set(groot,'defaultAxesColorOrder',CO);
set(groot,'DefaultAxesLineStyleOrder','-|-.|:|--');
set(groot,'DefaultTextInterpreter','latex')
set(groot, 'DefaultLegendInterpreter', 'latex')
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'DefaultAxesBox','on')
set(groot,'DefaultFigurePosition',[1500-560 925-420 560 420])
clear CO

% get(gcf,'Position')
% set(gcf,'Position',[ans(1:3) ans(4)/2])
