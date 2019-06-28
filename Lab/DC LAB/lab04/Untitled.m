pi=3.14;
Fs=100;
F = 3;
t=(0:1/Fs:1);
x=sin(2*pi*F*t);
figure
subplot(4,1,1)
plot(x)

%exact nyquist
nyquist=x(2:Fs/6:length(x));

subplot(4,1,2)
plot(nyquist);
%less than nyquist
less_nyquist=x(2:Fs/5:length(x));

subplot(4,1,3)
plot(less_nyquist)
greater_nyquist=x(2:Fs/10:length(x));

subplot(4,1,4)
plot(greater_nyquist)


