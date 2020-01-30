function [sig_freq, a]=exp_fit(t,y,stepsize)
% Calculate the exponential fit to a set of data as well as the frequency
% of the data. frequency in Hz

sampling_frequency=1/(t(2)-t(1));
sampling_period=1/sampling_frequency;
length_of_signal=length(y);
t=(0:length_of_signal-1)*sampling_period; %time vector - this is a nifty way to create!
Fast_Fourier_Transform=fft(y);
% Compute the two-sided spectrum P2. Then compute the single-sided...
% spectrum P1 based on P2 and the even-valued signal length L.
P2=abs(Fast_Fourier_Transform/length_of_signal);
P1=P2(1:length_of_signal/2+1);
P1(2:end-1) = 2*P1(2:end-1);
P1(1)=0;
f_domain=sampling_frequency*(0:(length_of_signal/2))/length_of_signal;
% f_domain=f_domain*(2*pi);
figure()
stem(f_domain,P1,'k','linewidth',2)
xlabel('rad/sec');
[amp,freq]=findpeaks(P1);
biggest=find(amp==max(amp));
sig_freq=f_domain(freq(biggest))



figure()
ax=plot(t,y,'k','linewidth',2);
axis tight 
[peaks,locs]=findpeaks(y,'minpeakheight',0.025,'minpeakdistance',(1/(sig_freq*stepsize)/2));
hold on
plot(t(locs),peaks,'r.','markersize',20)
xlabel('time');ylabel('amplitude')
% recreate the damping term 
y=log(peaks);
[my,ny]=size(y);
if ny>my
y=y';
end
x=t(locs)';
A=[x ones(length(x),1)];
a=A\y
hold on
tt=0:stepsize:t(end);
plot(tt,exp(a(2))*exp(a(1)*t),'b','linewidth',2)

