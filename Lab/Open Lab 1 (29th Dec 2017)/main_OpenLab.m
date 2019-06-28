function main_OpenLab()
%Defining common variables
signal_length = 3000000;
M = 8;
m = 3;
Es = 24;
Eb = Es/m;
EbNo = [1:2:100];
No = Eb./EbNo;
SNR = Eb./No;
BitsPerSymbol = 3;
DesiredBER = 1e-3;
%Generate Binary Data
BinaryStream = round(rand(1,signal_length)); 

BinaryChunksofThreeBits = reshape(BinaryStream, length(BinaryStream)/BitsPerSymbol, []);
Signal = zeros(1, length(BinaryChunksofThreeBits));
%Generate complex signal for 8-QAM
for i=1:length(BinaryChunksofThreeBits)
   if BinaryChunksofThreeBits(i) == 000
       Real_BD = 2;
       Imaginary_BD = 2;
   else if BinaryChunksofThreeBits(i) == 001
       Real_BD = 2;
       Imaginary_BD = -2;
   else if BinaryChunksofThreeBits(i) == 010
       Real_BD = -2;
       Imaginary_BD = 2;
   else if BinaryChunksofThreeBits(i) == 011
       Real_BD = -2;
       Imaginary_BD = -2;
   else if BinaryChunksofThreeBits(i) == 100
       Real_BD = 6;
       Imaginary_BD = 2;
   else if BinaryChunksofThreeBits(i) == 101
       Real_BD = 6;
       Imaginary_BD = -2;
   else if BinaryChunksofThreeBits(i) == 110
       Real_BD = -6;
       Imaginary_BD = 2;
   else if BinaryChunksofThreeBits(i) == 111
       Real_BD = -6;
       Imaginary_BD = -2;
       end
       end
       end
       end
       end
       end
       end
end
   Signal(i) = Real_BD + 1j*Imaginary_BD;
end

factor = zeros(1,length(SNR));

for k=1:length(SNR)
%Random Noise Generation1
factor(k) = 1/(sqrt(2*SNR(k)));
noise = factor(k)*(randn(1, signal_length/BitsPerSymbol) + j*randn(1, signal_length/BitsPerSymbol));

%For Rayleigh fading channel
Modulated_signal = Signal.*noise;

%For demodulation
Received = Modulated_signal;

demodulated_real = [];
demodulated_imaginary = [];

for i=1:length(Received)
   real_part = real(Received(i));
   imaginary_part = imag(Received(i));
   
   %real-> 0_4 and img-> 0_2  For -> 000
   if (real_part >= 0 && real_part <= 4 && imaginary_part >= 0)
      demodulated_real = [demodulated_real 2];
      demodulated_imaginary = [demodulated_imaginary 2];
   %real-> 0_4 and img-> 0_-2 For -> 001
   else if(real_part >= 0 && real_part <= 4 && imaginary_part <= 0)
      demodulated_real = [demodulated_real 2];
      demodulated_imaginary = [demodulated_imaginary -2];
   %real-> -4_0 and img-> 0_2 For -> 010
   else if(real_part <= 0 && real_part >= -4 && imaginary_part >= 0)
      demodulated_real = [demodulated_real -2];
      demodulated_imaginary = [demodulated_imaginary 2];
   %real-> -4_0 and img-> 0_-2 For -> 011
   else if(real_part <= 0 && real_part >= -4 && imaginary_part <= 0)
      demodulated_real = [demodulated_real -2];
      demodulated_imaginary = [demodulated_imaginary -2];
   %real-> 4 or above and img-> 0_2 For -> 100
   else if(real_part > 4 && imaginary_part >= 0)
      demodulated_real = [demodulated_real 6];
      demodulated_imaginary = [demodulated_imaginary 2];
   %real-> 4 or above and img-> 0_-2 For -> 101
   else if(real_part > 4 && imaginary_part <= 0)
      demodulated_real = [demodulated_real 6];
      demodulated_imaginary = [demodulated_imaginary -2];
   %real-> -4 or below and img-> 0_2 For -> 110
   else if(real_part < -4 && imaginary_part >= 0)
      demodulated_real = [demodulated_real -6];
      demodulated_imaginary = [demodulated_imaginary 2];
   %real-> -4 or below and img-> 0_-2 For -> 111
   else if(real_part < -4 && imaginary_part <= 0)
      demodulated_real = [demodulated_real -6];
      demodulated_imaginary = [demodulated_imaginary -2];
   else
      demodulated_real = [demodulated_real 2];
      demodulated_imaginary = [demodulated_imaginary 2];
   end
   end
   end
   end
   end
   end
   end
   end
end
length(Received)
length(demodulated_real)
length(BinaryStream)
length(Signal)
%BER - Bit error rate
Change_in_real = sum((real(Signal) ~= demodulated_real));
Change_in_imaginary = sum((imag(Signal) ~= demodulated_imaginary));
Total_Different = Change_in_real + Change_in_imaginary;
Total_bits = length(Signal);
BER(k) = Total_Different/Total_bits;
if BER(k) < DesiredBER
    disp('For SNR')
    disp(SNR(i))
end
end
    
%Plot
semilogy(10*log10(SNR),BER);
end