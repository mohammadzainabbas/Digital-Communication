function main_uni_polar_RZ()
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
        pulse(k: k + (Samples_per_bit_time - 1)/2) = 5;
        pulse(k + (Samples_per_bit_time - 1)/2: k + Samples_per_bit_time - 1) = 0;
    end
    i = i + 1;
end
plot(t, pulse);
end
