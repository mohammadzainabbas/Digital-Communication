function Frequency_Shift_Key()
%200 samples
fs = 200;
t = [0:1/fs:1-1/fs];

%Carrier waves
f1 = 1;
carrier_1 = sin(2*pi*f1*t);

f2 = 2;
carrier_2 = sin(2*pi*f2*t);

%Our Signal
x = [1 1 0 1 0 0 1 0 1 1 1 1 1 0 0 0 0 1 0 1 0 1 0 0 0 1 1 0 1];
signal_size = length(x);

%Modulated signal
y = [];
for i=1:signal_size
    if (x(i) == 1)
        temp = carrier_1;
    else
        temp = carrier_2;
    end
    y = cat(2, y, temp);   
end

%plot
figure
subplot(4,1,1)
stem(x)
subplot(4,1,2)
plot(t,carrier_1)
subplot(4,1,3)
plot(t,carrier_2)
subplot(4,1,4)
plot(y)
end