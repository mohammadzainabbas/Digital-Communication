
X=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_Rate=10;
Time_Sequence=length(X)/Bit_Rate;
T_b=1/Bit_Rate;

time=0:T_b/200:Time_Sequence;
UniPolar_NRZ_Pulse = zeros(1,length(time));
UniPolar_RZ_Pulse = zeros(1,length(time));
i=1;
for k=1:200:length(X)*200
   
    if(X(i)==1)
        UniPolar_NRZ_Pulse(k:k+199)=1;
    else
        UniPolar_NRZ_Pulse(k:k+199)=0;
    end
    i=i+1;
end

plot(time,UniPolar_NRZ_Pulse,'LineWidth',2);
title('UniPolar NRZ Pulse');

i=1;
for k=1:200:length(X)*200
    if(X(i)==1)
        UniPolar_RZ_Pulse(k:k+99)=1;
        UniPolar_RZ_Pulse(k+99:k+199)=0;
    else
        UniPolar_RZ_Pulse(k:k+199)=0;
    end
    i=i+1;
end

figure;
plot(time,UniPolar_RZ_Pulse,'LineWidth',2);
title('UniPolar RZ Pulse');
