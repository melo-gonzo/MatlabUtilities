%%% Play with w,s,a,d! 
close all
clear all
clc
video = 0;
% rng(1)
computer = 0;
load High_Score
load te
disp('Playing Snake')
global s
tic
gamefig=figure();
set(gamefig,'MenuBar','none');
set(gamefig,'Position',[1272.5          543          200          200]);
ax=axes('XLim',[-1 1],'YLim',[-1 1]);
axis(ax,'square');hold(ax,'on');box(ax,'on');
set(ax,'XTick',[],'YTick',[]);
s.head=[0 0];s.length=1;s.body=[nan nan];
s.stomach=[nan nan];s.snake=[s.head;s.body];
title(ax,['Length: ',num2str(s.length)])
s.speed=5;s.speedInc=1;s.step=0.1;
s.direction='n';s.boxes=-1:s.step:1;
s.foodloc=round([s.boxes(randi(length(s.boxes))) s.boxes(randi(length(s.boxes)))],4);
s.splot=plot(0,0,'k.','markersize',30);
s.fplot=plot(s.foodloc(1),s.foodloc(2),'g.','markersize',30);
s.dir_change=1;set(gamefig,'KeyPressFcn',{@arrowkey,ax,gamefig});
w=waitforbuttonpress;
if video ==1
    v = VideoWriter('snake_computer_smarter.avi');
    v.FrameRate=12;
    open(v)
end
if w==1
    clear w
    while s.head(1)<=ax.XLim(2) && s.head(1)>=ax.XLim(1) &&...
            s.head(2)<=ax.YLim(2) && s.head(2)>=ax.YLim(1)
        if computer ==1
            s = get_computer_key(s,ax);
        end
        if s.length==27
            asdf=1;
        end 
        if computer ==1
            if outcome(s,ax) == 0
                s = swerve(s,ax);
            end
        end
        switch s.direction
            case 'n'
                s.stomach=s.snake(end,:);
                if ~isnan(s.snake(end,:))
                    s.body=[s.snake(1:end-1,:)];
                else
                    s.stomach=s.snake(end-1,:);
                end
                s.head(2)=s.head(2)+s.step;
                s.snake=[s.head;s.body];
            case 'e'
                s.stomach=s.snake(end,:);
                if ~isnan(s.snake(end,:))
                    s.body=[s.snake(1:end-1,:)];
                else
                    s.stomach=s.snake(end-1,:);
                end
                s.head(1)=s.head(1)+s.step;
                s.snake=[s.head;s.body];
            case 's'
                s.stomach=s.snake(end,:);
                if ~isnan(s.snake(end,:))
                    s.body=[s.snake(1:end-1,:)];
                else
                    s.stomach=s.snake(end-1,:);
                end
                s.head(2)=s.head(2)-s.step;
                s.snake=[s.head;s.body];
            case 'w'
                s.stomach=s.snake(end,:);
                if ~isnan(s.snake(end,:))
                    s.body=[s.snake(1:end-1,:)];
                else
                    s.stomach=s.snake(end-1,:);
                end
                s.head(1)=s.head(1)-s.step;
                s.snake=[s.head;s.body];
            otherwise
        end
        s.head=round(s.head,4);
        s.body=round(s.body,4);
        if ismember(2,sum((round(s.body,1)==round(s.head,1))'))
            break
        end
        if abs((s.head-s.foodloc)) <= 0.03
            s.length=s.length+1;
            if isnan(s.body)
                s.body=s.stomach;
            else
                s.body(end+1,:)=s.stomach;
            end
            s.snake=[s.head;s.body];
            s.foodloc=round([s.boxes(randi(length(s.boxes))) s.boxes(randi(length(s.boxes)))],4);
            set(s.fplot,'Xdata',s.foodloc(1),'YData',s.foodloc(2));
            s.speed=s.speed+s.speedInc;
            title(ax,['Length: ',num2str(s.length)])
        end
        set(s.splot,'XData',s.snake(:,1),'YData',s.snake(:,2))
        s.dir_change=1;
        if video ==1
            frame = getframe(gcf);
            writeVideo(v,frame);
        end
        pause(round(1/s.speed,10))
        
    end
    if s.direction == 'n'
        set(s.splot,'XData',s.snake(:,1),'YData',s.snake(:,2)-s.step,'color',[1 0 0])
    elseif s.direction == 'e'
        set(s.splot,'XData',s.snake(:,1)-s.step,'YData',s.snake(:,2),'color',[1 0 0])
    elseif s.direction =='s'
        set(s.splot,'XData',s.snake(:,1),'YData',s.snake(:,2)+s.step,'color',[1 0 0])
    elseif s.direction =='w'
        set(s.splot,'XData',s.snake(:,1)+s.step,'YData',s.snake(:,2),'color',[1 0 0])
    end
    disp('dead')
    title(ax,['Final Length: ',num2str(s.length)])
    if video ==1
        frame = getframe(gcf);
        writeVideo(v,frame)
        close(v)
    end
end

te=toc +te;
new_score=s.length;
if new_score>High_Score
    High_Score=new_score
    save C:\Users\carme\Desktop\TheProverbialCode\CML\snake_game\High_Score High_Score
end
save C:\Users\carme\Desktop\TheProverbialCode\CML\snake_game\te te



function arrowkey(~,~,~,gamefig)
global s
arrow=get(gamefig,'CurrentCharacter');
s.dir_change;
if s.dir_change ==1
    if arrow=='w' && s.direction~='s'
        s.direction='n';
    elseif arrow=='d' && s.direction~='w'
        s.direction='e';
    elseif arrow=='s' && s.direction~='n'
        s.direction='s';
    elseif arrow=='a' && s.direction~='e'
        s.direction='w';
    end
    s.dir_change = 0;
end
end


function s = get_computer_key(s,ax)
if s.dir_change ==1
    food = s.foodloc;
    head = s.head;
    v = (food-head)./sqrt(sum((food-head).^2));
    x = v(1);y = v(2);
    if sign(x)>0 && sign(y)>0
        if s.direction ~= 's'
            s.direction = 'n';
        else
            s.direction = 'e';
        end
    elseif sign(x)>0 && sign(y)<0
        if s.direction ~= 'w'
            s.direction = 'e';
        else
            s.direction = 's';
        end
    elseif sign(x)<0 && sign(y)>0
        if s.direction ~='e'
            s.direction = 'w';
        else
            s.direction = 'n';
        end
    elseif sign(x)<0 && sign(y)<0
        if s.direction ~= 'n'
            s.direction = 's';
        else
            s.direction = 'w';
        end
    elseif sign(y)==0 && sign(x) > 0
        if s.direction ~='w'
            s.direction = 'e';
        else
            s.direction = 'n';
        end
    elseif sign(y)==0 && sign(x) < 0
        if s.direction ~='e'
            s.direction = 'w';
        else
            s.direction ='s';
        end
    elseif sign(x)==0 && sign(y) > 0
        if s.direction ~='s'
            s.direction = 'n';
        else
            s.direction ='e';
        end
    elseif sign(x)==0 && sign(y) < 0
        if s.direction~='n'
            s.direction = 's';
        else
            s.direction ='w';
        end
    end
    if outcome(s,ax)==0
        s = swerve(s,ax);
    end
end
s.dir_change =0;
end

function o = outcome(s,ax)
switch s.direction
    case 'n'
        s.stomach=s.snake(end,:);
        if ~isnan(s.snake(end,:))
            s.body=[s.snake(1:end-1,:)];
        else
            s.stomach=s.snake(end-1,:);
        end
        s.head(2)=s.head(2)+s.step;
        s.snake=[s.head;s.body];
    case 'e'
        s.stomach=s.snake(end,:);
        if ~isnan(s.snake(end,:))
            s.body=[s.snake(1:end-1,:)];
        else
            s.stomach=s.snake(end-1,:);
        end
        s.head(1)=s.head(1)+s.step;
        s.snake=[s.head;s.body];
    case 's'
        s.stomach=s.snake(end,:);
        if ~isnan(s.snake(end,:))
            s.body=[s.snake(1:end-1,:)];
        else
            s.stomach=s.snake(end-1,:);
        end
        s.head(2)=s.head(2)-s.step;
        s.snake=[s.head;s.body];
    case 'w'
        s.stomach=s.snake(end,:);
        if ~isnan(s.snake(end,:))
            s.body=[s.snake(1:end-1,:)];
        else
            s.stomach=s.snake(end-1,:);
        end
        s.head(1)=s.head(1)-s.step;
        s.snake=[s.head;s.body];
    otherwise
end
if ismember(2,sum((round(s.body,1)==round(s.head,1))'))
    o = 0;
else
    o = 1;
end
if s.head(1)>ax.XLim(2) || s.head(1)<ax.XLim(1) ||...
        s.head(2)>ax.YLim(2) || s.head(2)<ax.YLim(1)
    o = 0;
end
end

function s = swerve(s,ax)
if s.direction == 'n'
    s.direction = 'e';
    if outcome(s,ax)==0
        s.direction ='w';
    end
elseif s.direction == 'e'
    s.direction = 'n';
    if outcome(s,ax)==0
        s.direction ='s';
    end
elseif s.direction == 's'
    s.direction = 'w';
    if outcome(s,ax)==0
        s.direction ='e';
    end
elseif s.direction == 'w'
    s.direction = 's';
    if outcome(s,ax)==0
        s.direction ='n';
    end
end
end
