
X=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

Bit_Rate=10;
Time_Sequence=length(X)/Bit_Rate;
T_b=1/Bit_Rate;

time=0:T_b/200:Time_Sequence;
BiPhaseManchester_Pulse = zeros(1,length(time));
DifferentialManchester_Pulse = zeros(1,length(time));
i=1;
for k=1:200:length(X)*200
   
    if(X(i)==0)
        BiPhaseManchester_Pulse(k:k+99)=5;
        BiPhaseManchester_Pulse(k+99:k+199)=-5;
    else
        BiPhaseManchester_Pulse(k:k+99)=-5;
        BiPhaseManchester_Pulse(k+99:k+199)=5;
    end
    i=i+1;
end

plot(time,BiPhaseManchester_Pulse,'LineWidth',2);
title('BiPhase Manchester Pulse');

i=1;
temp=5;
for k=1:200:length(X)*200
    if(X(i)==1)
        DifferentialManchester_Pulse(k:k+99)=temp;
        temp=-temp;
        DifferentialManchester_Pulse(k+99:k+199)=temp;      
    else
        DifferentialManchester_Pulse(k:k+99)=-temp;
        DifferentialManchester_Pulse(k+99:k+199)=temp;
    end
    i=i+1;
end

figure;
plot(time,DifferentialManchester_Pulse,'LineWidth',2);
title('DifferentialManchester_Pulse');
