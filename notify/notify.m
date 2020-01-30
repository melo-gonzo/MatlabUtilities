% beats mane 
load new.wav


% 
% close all
% clear all
% clc
% playtime=.15;
% ze=1:1:1;
% fs=44100;
% t=0:1/fs:playtime-1/fs;
% tpt=2*pi*t;
% % % % % % % % % % % % % my ringtone
% f1=50;
% up=chirp(t,f1,playtime,f1*50);
% up2=chirp(t,f1,playtime*1.1,f1*50);
% back=fliplr(up);
% ringtone=[zeros(1,100) up back up2]./5;
% audiowrite('new.wav',ringtone,fs)
% sound(ringtone,fs)

























% zerob=sin(ze);
% 
% f1=40:((80-40)/(length(tpt)-1)):80;
% f1=10*(sin(f1)+10);
% f1=fliplr(f1);
% 
% % f2=f.^2;
% f2=80:-((80-40)/(length(tpt)-1)):40;
% f2=sin(f2.^2);
% % f2=10*(sin(f2)+10)
% % b2=sin(tpt.*f2);
% % sound(b2,fs)
% % b3=sin(tpt.*f2 +.1).*sin(tpt.*f2*.2);
% b3=sin(f2)
% 
% 
% b1=sin(tpt.*f1).*sin(tpt.*f1*1.1);
% 
% sound(b3,fs)
% sound(b1,fs)

% sound(b1,fs)

% f1=80;
% b1=1.2*sin(tpt*f1);
% f2=80*(4/3);
% b2=1.2*sin(tpt*f2);
% sound(b1,fs)
% sound(b2,fs)
% 
% 
% f=chirp(t,f1,playtime,1.1*f1);
% fback=flipud(f')';
% sound(f,fs)
% flong=[f fback];

% fhc=chirp(t,f1,playtime/.8,40*f1);
% fhighback=flipud(f')';
% sound(fhc,fs)

% playtime2=1;
% t2=0:1/fs:playtime2-1/fs;
% b2=sin(tpt*f1*10);
% f2=chirp(t2,f1,playtime2,20*f1);
% f2back=flipud(f2')';
% f2long=[f2 fback];
% 
% sound(flong,fs)
