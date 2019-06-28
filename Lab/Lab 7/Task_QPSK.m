clear all
len=100000;
bits_real=round(rand(1,len));
bits_Imaginary=round(rand(1,len));
S_real=2*(bits_real-0.5);
S_Imag=2*(bits_Imaginary-0.5);
S_complex=S_real+j*S_Imag;

S_complex_BPSK=S_real;

Eb_No=1:20;

BER_AWGN=zeros(1,length(Eb_No));
BER_Raleigh=zeros(1,length(Eb_No));
BER_AWGN_BPSK=zeros(1,length(Eb_No));
BER_Raleigh_BPSK=zeros(1,length(Eb_No));
for i=1:length(Eb_No)
    Signal_Recieved_Real=zeros(1,len);
    Signal_Recieved_Imaginary=zeros(1,len);
    noise_AWGN=(1/sqrt(2*(Eb_No(i))))*(randn(1,len)+1i*randn(1,len));
    noise_Raleigh = randn(1,len) + 1i*randn(1,len);  
    Noised_Signal_AWGN=S_complex +noise_AWGN;
    Noised_Signal_Raleigh=noise_Raleigh.*S_complex+noise_AWGN;
    Noised_Signal_Raleigh=Noised_Signal_Raleigh./noise_Raleigh;
    
    Recieved_Signal_AWGN_real=sign(real(Noised_Signal_AWGN));                              
    Recieved_Signal_AWGN_imaginary=sign(imag(Noised_Signal_AWGN));
    Recieved_Signal_Raleigh_real=sign(real(Noised_Signal_Raleigh));                              
    Recieved_Signal_Raleigh_imaginary=sign(imag(Noised_Signal_Raleigh));
    
    BER_AWGN(i)=mean([(len-sum(Recieved_Signal_AWGN_real==S_real))/len (len-sum(Recieved_Signal_AWGN_imaginary==S_Imag))/len]);                   
    BER_Raleigh(i)=mean([(len-sum(Recieved_Signal_Raleigh_real==S_real))/len (len-sum(Recieved_Signal_Raleigh_imaginary==S_Imag))/len]);

    BER_AWGN_BPSK(i)=(len-sum(Recieved_Signal_AWGN_real==S_real))/len;                   
    BER_Raleigh_BPSK(i)=(len-sum(Recieved_Signal_Raleigh_real==S_real))/len;
end



figure;
grid on
semilogy(10*log10(Eb_No),BER_AWGN,'o-','LineWidth',2);
hold on
semilogy(10*log10(Eb_No),BER_Raleigh,'--','LineWidth',2);
hold on
semilogy(10*log10(Eb_No),BER_AWGN_BPSK,'-','LineWidth',2);
hold on
semilogy(10*log10(Eb_No),BER_Raleigh_BPSK,'x', 'LineWidth',2);
legend('BER AWGN','BER Raleigh','BER AWGN BPSK','BER Raleigh BPSK');
title('BER CURVE FOR QPSK and BPSK , AWGN AND RALEIGH CHANNEL');
xlabel('EbNo(dB)')                                  
ylabel('BER')                                         
                                               

