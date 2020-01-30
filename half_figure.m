function half_figure(shrink)
get(gcf,'Position')
set(gcf,'Position',[ans(1:3) ans(4)*shrink])