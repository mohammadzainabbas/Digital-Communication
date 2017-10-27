function main_polar()
x = [0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_rate = 5;
Samples_per_bit_time = 200;
Total_time = length(x)/Bit_rate;
Bit_time = 1/Bit_rate;
Tb = Bit_time;
t = Tb/Samples_per_bit_time:Tb/Samples_per_bit_time:Total_time;

pulse_NRZ = polar_NRZ(x, Samples_per_bit_time, Bit_rate);
pulse_RZ = polar_RZ(x, Samples_per_bit_time, Bit_rate);
subplot(2,1,1)
plot(t, pulse_NRZ);
subplot(2,1,2)
plot(t, pulse_RZ);

end

function pulse = polar_NRZ(x, Samples_per_bit_time, Bit_rate)
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
end


function pulse = polar_RZ(x, Samples_per_bit_time, Bit_rate)
Total_time = length(x)/Bit_rate;
Bit_time = 1/Bit_rate;
Tb = Bit_time;
t = Tb/Samples_per_bit_time:Tb/Samples_per_bit_time:Total_time;
pulse = zeros(1, (length(x)*Samples_per_bit_time));
i = 1;
for k = 1:Samples_per_bit_time:length(x)*Samples_per_bit_time
    if (x(i) == 1)
        pulse(k: k + (Samples_per_bit_time - 1)/2) = 5;
        pulse( k + (Samples_per_bit_time - 1)/2: k + Samples_per_bit_time - 1) = 0;
    else
        pulse(k: k + (Samples_per_bit_time - 1)/2) = -5;
        pulse( k + (Samples_per_bit_time - 1)/2: k + Samples_per_bit_time - 1) = 0;
    end
    i = i + 1;
end
end
