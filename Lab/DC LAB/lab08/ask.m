pi=3.14;
F=2;
sample=[1 1 0 1 0 0 1 0 1 1 1 1 1 0 0 0 0 1 0 1 0 1 0 0 0 1 1 0 1];
t=(1/200:1/200:1);
x=cos(2*pi*F*t);

figure
subplot(3,1,1)
plot(x);

bitrate=10;
n=200;
T = length(sample)/bitrate;
Tb=1/bitrate;
t=Tb/200:Tb/200:T;
pulse=zeros(1,1000);
pulse1=zeros(1,1000);

i=1;

%ask
for k=1:n:(length(sample)*n) %nonpolar nrz
    if (sample(i)==1)
        pulse(k:k+199)=1;
    else
        pulse(k:k+199)=0;
    end
    i=i+1;      
end
subplot(3,1,2)
plot (pulse)
ask_wave=zeros(1,5800);
i=1;

for j=1:n:(length(pulse)) 
   ask_wave(j:j+199)= x.*pulse(j:j+199);
   i=i+1;
end 
subplot(3,1,3)
plot (ask_wave)

%psk
i=1;
for k=1:n:(length(sample)*n) %polar nrz-l
    if (sample(i)==1)
        pulse1(k:k+199)=1;
        
    else
        pulse1(k:k+199)=-1;
        
    end
    i=i+1;      
end
figure
subplot(3,1,1)
plot (pulse1)
psk_wave=zeros(1,5800);
i=1;
for j=1:n:(length(pulse)) 
   psk_wave(j:j+199)= x.*pulse1(j:j+199);
   i=i+1;
end 
subplot(3,1,2)
plot (psk_wave)


%fsk
F1=4;
x1=cos(2*pi*F1*t);
figure
subplot(4,1,1)
plot(x1);
pulse_fsk=zeros(1,1000);
i=1;
for k=1:n:(length(sample)*n) %nonpolar nrz
    if (sample(i)==1)
        pulse_fsk(k:k+199)=0;
    else
        pulse_fsk(k:k+199)=1;
    end
    i=i+1;      
end
subplot(4,1,2)
plot (pulse_fsk)

fsk_wave=zeros(1,5800);
i=1;
for j=1:n:(length(pulse_fsk)) 
   fsk_wave(j:j+199)= x.*pulse_fsk(j:j+199);
   i=i+1;
end 
subplot(4,1,3)
plot (fsk_wave)


fsk_waveAdd=zeros(1,5800);
i=1;
for j=1:200:(length(pulse_fsk)-201) 
   fsk_waveAdd(j:j+199)=fsk_wave(j:j+199)+ ask_wave(j+200:j+399);
   i=i+1;
end 
subplot(4,1,4)
plot (fsk_waveAdd)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DEMODULATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter=1;
pk=[];
for m=1:200:length(ask_wave)
    a=ask_wave(m:m+199).*x;
    b=sum(a);
    disp(a)
    if (b>0)
        pk(counter)=1;
    else
        pk(counter)=0;
    
    end
    counter=counter+1;
end
pk2=[];
counter1=1;
for m=1:200:length(psk_wave)
    a=psk_wave(m:m+199).*x;
    b=sum(a);
    if (b>0)
        pk2(counter1)=1;
    else
        pk2(counter1)=0;
    
    end
    counter1=counter1+1;
end
counter2=1;
pk3=[];
for m=1:200:length(fsk_wave)
    a=fsk_wave(m:m+199).*x;
    b=sum(a);
    if (b>0)
        pk3(counter2)=1;
    else
        pk3(counter2)=0;
    end
    counter2=counter2+1;
end





