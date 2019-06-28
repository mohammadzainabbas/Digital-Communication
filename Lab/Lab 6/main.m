function main()
Fs = 1000;
t = [0:1/Fs:1];
number_of_samples = length(t);
%freq = input('Enter your frequency: ');
freq = 5;
x = sin(2*pi*freq*t);
%x = randn(1,100);


Nyquist = 2*freq;
%At_nyquist = Fs/(Nyquist);
% Less_than_nyquist = Fs/(Nyquist/2);
More_than_nyquist = Fs/(10*Nyquist);

%x = sin(2*pi*max_freq*t);

figure
subplot(3,1,1)
plot(x)

%At nyquist

x1 = x(2:More_than_nyquist:end);
subplot(3,1,2)
stem(x1)

%Qunatization

%partition = [-1:.5:1];
partition = [-1, -.75, -.5, 0 , .5, .75, 1];
codebook = [0,1,2,3,4,5,6,7];
[out,y] = quantiz(x, partition, codebook);
bit_stream = dec2bin(y);

subplot(3,1,3)
stem(y)

end

function main_polar_NRZ()
x = [0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_rate = 5;
Samples_per_bit_time = 200;
Total_time = length(x)/Bit_rate;
Bit_time = 1/Bit_rate;
Tb = Bit_time;

t = Tb/Samples_per_bit_time:Tb/Samples_per_bit_time:Total_time;
pulse = zeros(1, (length(x)*Samples_per_bit_time));
i = 1;
for k = 1:Samples_per_bit_time:length(x)*Samples_per_bit_time
    if (x(i) == 1)
        pulse(k: k + Samples_per_bit_time - 1) = 5;
    else
        pulse(k: k + Samples_per_bit_time - 1) = -5;
    end
    i = i + 1;
end
plot(t, pulse);
end