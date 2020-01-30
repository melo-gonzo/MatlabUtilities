function simulate_video(x,pause_length,INTERPOLATE,by_size,video_name)
%function simulate_video(x,pause_length,INTERPOLATE,by_size,video_name)
%only assuming blue video data in x right now (kinda shitty)
%x is video data
%interpolate 0 or 1 (havent added this yet)
%video_name deault to NoName
[m,n,p,t]=size(x);
new_x = 255*ones(m,n);
fig=figure();
im=image(x(:,:,:,1));
set(gca,'Visible','off')
set(gcf,'MenuBar','none')
if ~strcmp(video_name,'NoVideo')
    v=VideoWriter(video_name);
    open(v)
end
if INTERPOLATE==0
    for k=1:by_size:t
        new_x(x(:,:,1,k)>0)=0;
        new_vid_data=cat(3,255*ones(m,n),new_x,new_x);
        set(im,'CData',new_vid_data)
        writeVideo(v,getframe(fig))
        pause(pause_length)
    end 
end 
if ~strcmp(video_name,'NoVideo')
    close(v)
end