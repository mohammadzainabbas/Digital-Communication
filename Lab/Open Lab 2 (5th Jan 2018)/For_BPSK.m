EbN0_dB = 25;
EbN0 = 10.^(EbN0_dB/10);
BER = 1/2.*erfc(sqrt(EbN0));
semilogy(EbN0_dB,BER)
grid on
ylabel('BER')
xlabel('E_b/N_0 (dB)')
title('Bit Error Rate for Binary Phase-Shift Keying')

BER