% close all
% clear all
% clc
% x=0;y=0;
% u=0.5;v=0.5;
function arrow_function(x,y,u,v)

length=sqrt((x-u)^2+(y-v)^2);
arrow_length_x=0.05;
arrow_length_y=0.025;

arrow=[0 1 1 1-arrow_length_x*1 1-arrow_length_x*1;
    0 0 0 -(arrow_length_y*1) arrow_length_y*1];

theta=atan2(v-y,u-x);
arrow = length*arrow;
arrow = [cos(theta) -sin(theta);sin(theta) cos(theta)]*arrow;
arrow = arrow+[x;y];


hold on
% plot(x,y,'k.','markersize',20)
% plot(x,y,'b.','markersize',20)
% plot(cos(0:0.001:2*pi),sin(0:0.001:2*pi),'b-')

plot(arrow(1,1:2), arrow(2,1:2),'k-','linewidth',1)
plot(arrow(1,3:4), arrow(2,3:4),'k-','linewidth',1)
plot(arrow(1,[3 5]), arrow(2,[3 5]),'k-','linewidth',1)