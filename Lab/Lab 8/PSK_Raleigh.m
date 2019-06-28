clear all
M = 2;
n=10^4;
EbNo=10^(25/10);
Signal = randi([0 M-1],n,1);
PSK = pskmod(Signal,M,pi/M);
scatterplot(PSK)

noise_AWGN=(1/sqrt(2*EbNo))*(rand(n,1)+1j*rand(n,1));
noise_Raleigh = randn(n,1) + 1i*randn(n,1);
recieved=PSK.*noise_Raleigh+noise_AWGN;
recieved=recieved./noise_Raleigh;
scatterplot(recieved)

Recieved_Signal = pskdemod(recieved,M,pi/M);
BER_PSK_AWGn = (n-sum(Signal==Recieved_Signal))/n;