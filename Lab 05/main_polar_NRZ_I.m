function main_polar_NRZ_I()
x = [0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_rate = 5;
Samples_per_bit_time = 200;
Total_time = length(x)/Bit_rate;
Bit_time = 1/Bit_rate;

Tb = Bit_time;

t = Tb/Samples_per_bit_time:Tb/Samples_per_bit_time:Total_time;
pulse = zeros(1, (length(x)*Samples_per_bit_time));
i = 1;
toggle = 1;
last = 0;
for k = 1:Samples_per_bit_time:length(x)*Samples_per_bit_time
    
    if (x(1) == 1)
        pulse(k: k + Samples_per_bit_time - 1) = 5;
        last = 5;
    else
        pulse(k: k + Samples_per_bit_time - 1) = -5;
        last = -5;
    end
    
    if (i > 1)
    if (x(i) == 0)
        pulse(k: k + Samples_per_bit_time - 1) = last;
    elseif (x(i) == 1)
        if (last == 5)
            pulse(k: k + Samples_per_bit_time - 1) = -5;
            last = -5;
        elseif(last == -5)
            pulse(k: k + Samples_per_bit_time - 1) = 5;
            last = 5;
        end
    end
    end
    i = i + 1;
end
plot(t, pulse);
end
