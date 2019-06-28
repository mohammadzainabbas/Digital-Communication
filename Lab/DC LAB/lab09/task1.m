l=100000;
EbNodB=(1:0.5:50);
EbNo=10.^(EbNodB/10);
ber = zeros(1,length(EbNodB));
a=sqrt(8)+4;
b=sqrt(8);
s1=round(rand(1,l));
s2=round(rand(1,l));
s3=round(rand(1,l));
signal = zeros(1,length(s1));
c=zeros(1,8);
c(1) = b*cos(5*pi/4) + b*1j*sin(5*pi/4);
c(2) = a*cos(5*pi/4) + a*1j*sin(5*pi/4);
c(3) = b*cos(7*pi/4) + b*1j*sin(7*pi/4);
c(4) = a*cos(7*pi/4) + a*1j*sin(7*pi/4);
c(5) = b*cos((3*pi)/4) + b*1j*sin((3*pi)/2);
c(6) = a*cos((3*pi)/4) + a*1j*sin((3*pi)/2);
c(7) = b*cos(pi/4) + b*1j*sin(pi/4);
c(8) = a*cos(pi/4) + a*1j*sin(pi/4);
s1_r = zeros(1,l);
s2_r = zeros(1,l);
s3_r = zeros(1,l);
for n=1:length(EbNodB)
for k=1:length(signal)
if s1(k)==0 && s2(k)==0 && s3(k)==0
signal(k) =c(1);
elseif s1(k)==0 && s2(k)==0 && s3(k)==1
signal(k) =c(2);
elseif s1(k)==0 && s2(k)==1 && s3(k)==0
signal(k) =c(3);
elseif s1(k)==0 && s2(k)==1 && s3(k)==1
signal(k) =c(4);
elseif s1(k)==1 && s2(k)==0 && s3(k)==0
signal(k) =c(5);
elseif s1(k)==1 && s2(k)==0 && s3(k)==1
signal(k) =c(6);
elseif s1(k)==1 && s2(k)==1 && s3(k)==0
signal(k) =c(7);
else
signal(k) =c(8);
end
end
w=(1/sqrt(2*EbNo(n)))*(randn(1,l)+1j*randn(1,l)); %Random noise generation
r = signal + w;
for k=1:length(r)
distances = abs(c - r(k));
[val,index] = min(distances);
if index == 1
s1_r(k) = 0;
s2_r(k) = 0;
s3_r(k) = 0;
elseif index==2
s1_r(k) = 0;
s2_r(k) = 0;
s3_r(k) = 1;
elseif index==3
s1_r(k) = 0;
s2_r(k) = 1;
s3_r(k) = 0;
elseif index==4
s1_r(k) = 0;
s2_r(k) = 1;
s3_r(k) = 1;
elseif index==5
s1_r(k) = 1;
s2_r(k) = 0;
s3_r(k) = 0;
elseif index==6
s1_r(k) = 1;
s2_r(k) = 0;
s3_r(k) = 1;
elseif index==7
s1_r(k) = 1;
s2_r(k) = 1;
s3_r(k) = 0;
else
s1_r(k) = 1;
s2_r(k) = 1;
s3_r(k) = 1;
end
end

ber1 = (l-sum(s1_r==s1))/l;
ber2 = (l-sum(s2_r==s2))/l;
ber3 = (l-sum(s3_r==s3))/l;
ber(n)= mean([ber1 ber2 ber3]);
end
semilogy(EbNodB, ber,'o-') 
xlabel('EbNo(dB)') 
ylabel('BER')
grid on 