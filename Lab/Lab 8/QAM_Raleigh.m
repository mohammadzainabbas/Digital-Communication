clear all
M = 8;
N=10^4;
EbNo=10^(25/10);

noise_AWGN=(1/sqrt(2*EbNo))*(rand(N,1)+1j*rand(N,1));
noise_Raleigh = randn(N,1) + 1i*randn(N,1);

Signal=randi([0 M-1],N,1);
QAM=qammod(Signal,M);
scatterplot(QAM)
Noised_Signal=QAM.*noise_Raleigh+noise_AWGN;
Noised_Signal=Noised_Signal./noise_Raleigh;
scatterplot(Noised_Signal)

Recieved = pskdemod(Noised_Signal,M);
BER = (N-sum(Signal~=Recieved))/N;