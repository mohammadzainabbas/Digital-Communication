function Demodulation_Amplitude_Shift_Key()
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
modulated_signal = [];
for i=1:signal_size
    temp = x(i)*carrier;
    modulated_signal = cat(2, modulated_signal, temp);   
end

%Demodulation
for i=1:length(modulated_signal)/length(carrier)
   temp = modulated_signal((i-1)*length(carrier)+1:i*length(carrier));
   check = sum(temp.*carrier)/length(carrier);
   
   if check > 0
       y(i) = 1;
   else
       y(i) = 0;
   end
end


%plot
figure
subplot(4,1,1)
stem(x)
subplot(4,1,2)
plot(t,carrier)
subplot(4,1,3)
plot(modulated_signal)
subplot(4,1,4)
stem(y)
end