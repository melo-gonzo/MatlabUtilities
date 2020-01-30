function simulate_data(t,x,pause_length,COMET,by_size,video_name)
%simulate_data(t,x,pause_length,COMET,by_size,video_name)
%no comet, comet=0
%no by_size, by_size=1
%no video, video_name='NoVideo'

[m1,n1]=size(x);
if n1>m1
    x=x';
end

% [m2,n2]=size(x);
% if n1>m1
%     x=x';
% end


fig=figure();
set(gca,'Position',[0.2 0.2 0.6 0.6]);


lines=plot(nan(2,length(x(1,:))));
% xlabel('Time (s)')
% ylabel('Acceleration (m/s^2)')
% legend('x1','x2','x3')

if ~strcmp(video_name,'NoVideo')
    v=VideoWriter(video_name);
    open(v)
end 

if COMET~=0
    for k=1:by_size:length(x(:,1))
        if k>COMET
            for n1=1:length(x(1,:))
                set(lines(n1),'XData',t(k-COMET:k),'YData',x(k-COMET:k,n1))
                axis([t(k-COMET) t(k) min(min((x(k-COMET:k,:)))) max(max(x(k-COMET:k,:)))])
            end
        else
            for n1=1:length(x(1,:))
                set(lines(n1),'XData',t(1:k),'YData',x(1:k,n1))
                if t(k)~=0
                    axis([0 t(k) min(min(x(1:k,:))) max(max(x(1:k,:)))])
                end
            end
        end
        if ~strcmp(video_name,'NoVideo')
        pause(pause_length)
        writeVideo(v,getframe(gcf))
        end 
    end
else
    axis([min(t) max(t) min(min(x)) max(max(x))])
    for k=1:by_size:length(x(:,1))
        for n1=1:length(x(1,:))
            set(lines(n1),'XData',t(1:k),'YData',x(1:k,n1))
        end
        pause(pause_length)
        if ~strcmp(video_name,'NoVideo')
        pause(pause_length)
        writeVideo(v,getframe(fig))
        end 
    end
end
if ~strcmp(video_name,'NoVideo')
    close(v)
end
