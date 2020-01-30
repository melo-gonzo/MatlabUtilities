function del_last_line(n)
ch=get(gca,'Children');delete(ch(1:n));
% ;set(ch(1),'XData',[],'YData',[]);clear ch(1)
