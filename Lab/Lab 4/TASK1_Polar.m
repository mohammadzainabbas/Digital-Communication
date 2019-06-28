
X=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_Rate=10;
Time_Sequence=length(X)/Bit_Rate;
T_b=1/Bit_Rate;

time=0:T_b/200:Time_Sequence;
Polar_NRZL_Pulse = zeros(1,length(time));
Polar_NRZI_Pulse = zeros(1,length(time));
Polar_RZ_Pulse = zeros(1,length(time));
i=1;
for k=1:200:length(X)*200
   
    if(X(i)==0)
        Polar_NRZL_Pulse(k:k+199)=5;
    else
        Polar_NRZL_Pulse(k:k+199)=-5;
    end
    i=i+1;
end

plot(time,Polar_NRZL_Pulse,'LineWidth',2);
title('Polar NRZL Pulse');

i=1;
temp=5;
for k=1:200:length(X)*200
   
    if(X(i)==0)
        Polar_NRZI_Pulse(k:k+199)=temp;
    else
        if(temp==5)
            temp=-5;
        else
            temp=5;
        end
        Polar_NRZI_Pulse(k:k+199)=temp;
    end
    i=i+1;
end

figure;
plot(time,Polar_NRZI_Pulse,'LineWidth',2);
title('Polar NRZI Pulse');

i=1;
for k=1:200:length(X)*200
    if(X(i)==1)
        Polar_RZ_Pulse(k:k+99)=5;
        Polar_RZ_Pulse(k+99:k+199)=0;
    else
        Polar_RZ_Pulse(k:k+99)=-5;
        Polar_RZ_Pulse(k+99:k+199)=0;
    end
    i=i+1;
end

figure;
plot(time,Polar_RZ_Pulse,'LineWidth',2);
title('Polar RZ Pulse');
