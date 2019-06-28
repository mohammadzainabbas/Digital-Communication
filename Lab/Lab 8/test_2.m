Eb_No_dB = [0:20]; % multiple Eb/N0 values
N = 1e6;
si=2*(round(rand(2,N))-0.5);     %In-phase symbol generation
sq=2*(round(rand(2,N))-0.5);     %Quadrature symbol generation                
Data=si+j*sq;                       %Adding the two parallel symbol streams
for i = 1:length(Eb_No_dB)
   
   sig = sqrt(1/10^(Eb_No_dB(i)/10)); % noise variance 
   n = sig*(randn(2,N) + 1i*randn(2,N));  % Additive white gaussian noise prototype 
   
   h = randn(2,N) + 1i*randn(2,N);  % Rayleigh channel
   
   y = h.*Data + n; % bit-streams corrupted by Rayleigh channel & AWGN

   
   y_rcv = y./h; % equalization of received data by channel information at the receiver
   
   
   Data_rcv = [refresh(real(y_rcv(1,:))); refresh(real(y_rcv(2,:)))]; % Regenerating the received bits by threshold comparison
   
    
   Err(i) = sum(sum(round(Data) ~= round(Data_rcv))); % computing the bit error in each simulation

end
