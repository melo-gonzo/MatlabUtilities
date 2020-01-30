function del_last_axis(n)
ch=get(gcf,'Children');delete(ch(1:n));
% ;set(ch(1),'XData',[],'YData',[]);clear ch(1)