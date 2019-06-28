clear all
M = 2;
n=10^4;
Eb_No=10^(25/10);
Signal = randi([0 M-1],n,1);
PSK = pskmod(Signal,M,pi/M);
scatterplot(PSK)
Gausian_noise=(1/sqrt(2*Eb_No))*(rand(n,1)+1j*rand(n,1));
noised_Signal =PSK+Gausian_noise;
scatterplot(noised_Signal)

Recieved_Signal = pskdemod(noised_Signal,M,pi/M);
BER_PSK_AWGn = (n-sum(Signal==Recieved_Signal))/n;