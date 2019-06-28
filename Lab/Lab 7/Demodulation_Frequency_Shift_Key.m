function Demodulation_Frequency_Shift_Key()
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
modulated_signal = [];
for i=1:signal_size
    if (x(i) == 1)
        temp = carrier_1;
    else
        temp = carrier_2;
    end
    modulated_signal = cat(2, modulated_signal, temp);   
end

%Demodulation
for i=1:length(modulated_signal)/length(carrier_1)
   temp = modulated_signal((i-1)*length(carrier_1)+1:i*length(carrier_1));
   check = sum(temp.*carrier_1)/length(carrier_1);
   
   if check > 0
       y(i) = 1;
   else
       y(i) = 0;
   end
end


%plot
figure
subplot(5,1,1)
stem(x)
subplot(5,1,2)
plot(t,carrier_1)
subplot(5,1,3)
plot(t,carrier_2)
subplot(5,1,4)
plot(modulated_signal)
subplot(5,1,5)
stem(y)
end