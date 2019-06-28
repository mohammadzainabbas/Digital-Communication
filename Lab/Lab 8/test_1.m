l=1e6;
EbNodB=0:2:10;
EbNo=10.^(EbNodB/10);

for n=1:length(EbNodB)
    si=2*(round(rand(1,l))-0.5);     %In-phase symbol generation
    sq=2*(round(rand(1,l))-0.5);     %Quadrature symbol generation                
    s=si+j*sq;                       %Adding the two parallel symbol streams
    w=(1/sqrt(2*EbNo(n)))*(randn(1,l)+j*randn(1,l)); %Random noise generation
    r=s+w;                                           %Received signal
    si_=sign(real(r));                               %In-phase demodulation
    sq_=sign(imag(r));                               %Quadrature demodulation
    ber1=(l-sum(si==si_))/l;                        %In-phase BER calculation
    ber2=(l-sum(sq==sq_))/l;                      %Quadrature BER calculation
    ber(n)=mean([ber1 ber2]);                         %Overall BER
end

semilogy(EbNodB, ber,'o-')                                 %Plot the BER
xlabel('EbNo(dB)')                                    %Label for x-axis
ylabel('BER')                                         %Label for y-axis
grid on                                               %Turning the grid on 