t=0:0.01:1;
fm=1;
pi=3.14;
x=sin(2*pi*fm*t);
val=(max(x)-min(x))/4;

freq=[0 0 0 0];
for i = 1:length(x)
    if (x(i) >= -1 && x(i) < -0.5)
        freq(1)=freq(1)+1;
    elseif  (x(i) >= -0.5 && x(i) < 0 )
        freq(2)=freq(2)+1;
    elseif (x(i)>=0 && x(i)<0.5)
        freq(3)=freq(3)+1;
    elseif (x(i) >= 0.5 && x(i) < 1 )
        freq(4)=freq(4)+1;
    end
end

figure
bar(freq)

pdf = freq/4
figure
bar(pdf)

cdf=[]
for i = 1:length(pdf)
    if i==1 
        cdf(1)=pdf(1)
    else
        cdf (i)= cdf(i-1) + pdf(i)
    end
         
    
end
figure
bar(cdf)
    
    
    



