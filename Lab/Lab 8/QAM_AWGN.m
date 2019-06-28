clear all

M = 1024;                   
k = log2(M);               
n = 270000;                    
len = n/k;               

Modulated_Signal = modem.qammod(M);         
Modulated_Signal.InputType = 'Bit';         
Modulated_Signal.SymbolOrder = 'Gray';         
hDemod = modem.qamdemod(Modulated_Signal); 

x = randi([0 1],n,1); 
Signal = modulate(Modulated_Signal,x);

EbNo = 25;
EbNo = EbNo + 10*log10(k);

recieved = zeros(len,length(EbNo));
bit_error_rate = zeros(length(EbNo),1);
for i=1:length(EbNo)
    recieved(:,i) = awgn(Signal,EbNo(i),'measured');
end

     figure;
      scatter(real(Signal),imag(Signal));
      title('QAM CONSTELLATION DIAGRAM'); 
      figure;
      scatter(real(recieved),imag(recieved));
      title(' QAM NOISED CONSTELLATION DIAGRAM'); 

recieved_demod = demodulate(hDemod,recieved);
for i=1:length(EbNo)
    [~,bit_error_rate(i)] = biterr(x,recieved_demod(:,i));
end
figure;
semilogy(EbNo, bit_error_rate, '-*');
grid on;