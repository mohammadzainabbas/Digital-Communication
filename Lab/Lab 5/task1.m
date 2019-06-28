x=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
bitrate=10;
n=200;
T = length(x)/bitrate;
Tb=1/bitrate;
t=Tb/200:Tb/200:T;
pulse=zeros(1,1000);
i=1;
for k=1:n:(length(x)*n) %nonpolar nrz
    if (x(i)==1)
        pulse(k:k+199)=1;
    else
        pulse(k:k+199)=0;
    end
    i=i+1;
      
end
subplot(6,1,1)
plot(t,pulse)
i=1;
for k=1:n:(length(x)*n) %nonpolar rz
    if (x(i)==1)
        pulse(k:k+99)=1;
        pulse(k+100:k+199)=0;
    else
        pulse(k:k+99)=0;
        pulse(k+100:k+199)=1;
    end
    i=i+1;
      
end
subplot(6,1,2)
plot(t,pulse)
i=1;
for k=1:n:(length(x)*n) %polar nrz-l
    if (x(i)==1)
        pulse(k:k+199)=1;
        
    else
        pulse(k:k+199)=-1;
        
    end
    i=i+1;
      
end
subplot(6,1,3)
plot(t,pulse)
i=1;
for k=1:n:(length(x)*n) %polar rz
    if (x(i)==1)
        pulse(k:k+99)=1;
        pulse(k+100:k+199)=-1;
    else
        pulse(k:k+99)=-1;
        pulse(k+100:k+199)=1;
    end
    i=i+1;
      
end
subplot(6,1,4)
plot(t,pulse)
i=1;
state=0;
for k=1:n:(length(x)*n) %polar nrz-i
    if (x(i)==1)
        state=~state;
        pulse(k:k+199)=state;
    else 
        pulse(k:k+199)=state;
        
    end
    i=i+1;
      
end
subplot(6,1,5)
plot(t,pulse)
i=1;
for k=1:n:(length(x)*n) %manchester
    if (x(i)==1)
        pulse(k:k+99)=0;
        pulse(k+100:k+199)=1;
    else
        pulse(k:k+99)=1;
        pulse(k+100:k+199)=0;
    end
    i=i+1;
subplot(6,1,6)
plot(t,pulse)      
end
i=1;
for k=1:n:(length(x)*n) %DIFFERENTIAL
    if (x(i)==0)
        state=~state;
        pulse(k:k+199)=state;
    else 
        pulse(k:k+199)=state;
        
    end
    i=i+1;
      
end
subplot(7,1,7)
plot(t,pulse)




