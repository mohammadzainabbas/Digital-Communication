EbNo = 2:250;
ber = zeros(length(EbNo),20);
for L = 1:10 
    ber(:,L) = berfading(EbNo,'qam',8,L);
end
figure
semilogy(EbNo,ber,'b')
% text(18.5, 0.02, sprintf('L=%d',1))
% text(18.5, 1e-11, sprintf('L=%d',20))
title('QAM over fading channel with diversity order 1 to 20')
xlabel('E_b/N_0 (dB)')
ylabel('BER')
grid on