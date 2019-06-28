function Amplitude_Shift_Key()
%200 samples
fs = 200;
t = [0:1/fs:1-1/fs];

%Carrier wave
f = 1;
carrier = sin(2*pi*f*t);

%Our Signal
x = [1 1 0 1 0 0 1 0 1 1 1 1 1 0 0 0 0 1 0 1 0 1 0 0 0 1 1 0 1];
signal_size = length(x);

%Modulated signal
y = [];
for i=1:signal_size
    temp = x(i)*carrier;
    y = cat(2, y, temp);   
end

%plot
figure
subplot(3,1,1)
stem(x)
subplot(3,1,2)
plot(t,carrier)
subplot(3,1,3)
plot(y)
end