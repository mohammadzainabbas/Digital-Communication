
function main()
%Defining common variables
signal_length = 100000;
M = 4;
m = 2;
%Vi = [sqrt(1 + 1) sqrt(1 + 1) sqrt(1 + 1) sqrt(1 + 1)];
%Es = 1/M*sum(abs(Vi)*2)
Es = 2;
Eb = Es/m;
No = 1;

%SNR = Eb/No
SNR = [1:10];
%SNR_t = 10;
%Generate Binary Data
Binary_Data1 = round(rand(1,signal_length)); 
Real_BD = 2*(Binary_Data1 - 0.5);
Binary_Data2 = round(rand(1,signal_length)); 
Imaginary_BD = 2*(Binary_Data2 - 0.5);

%Generate complex signal for QPSK
Signal = Real_BD + j*Imaginary_BD; 

for k=1:length(SNR)
%Random Noise Generation
factor(k) = 1/(sqrt(2*SNR(k)));
noise = factor(k)*(randn(1, signal_length) + j*randn(1, signal_length));

%For Rayleigh fading channel
Modulated_signal = Signal + noise;

%For demodulation
Received = Modulated_signal;

demodulated_real=[];
demodulated_imaginary =[];
% 
% for i=1:2:length(Received)
%    current_part = Received(i);
%    if i == length(Received)
%        next_part = Received(i);
%    else
%        next_part = Received(i+1);
%    end
%    
%    %real-> +ve and img-> +ve
%    if (current_part >= 0 && next_part >= 0)
%       demodulated = [demodulated 1 1];
%    %real-> -ve and img-> +ve
%    else if(current_part <= 0 && next_part >= 0)
%       demodulated = [demodulated 1 0];
%    %real-> +ve and img-> -ve
%    else if(current_part >= 0 && next_part <= 0)
%       demodulated = [demodulated 0 1];
%    %real-> -ve and img-> -ve
%    else
%       demodulated = [demodulated 0 0];
%    end
%    end
%    end
% end


for i=1:length(Received)
   real_part = real(Received(i));
   imaginary_part = imag(Received(i));
   
   %real-> +ve and img-> +ve
   if (real_part >= 0 && imaginary_part >= 0)
      demodulated_real = [demodulated_real 1];
      demodulated_imaginary = [demodulated_imaginary 1];
   %real-> -ve and img-> +ve
   else if(real_part <= 0 && imaginary_part >= 0)
      demodulated_real = [demodulated_real -1];
      demodulated_imaginary = [demodulated_imaginary 1];

   %real-> +ve and img-> -ve
   else if(real_part >= 0 && imaginary_part <= 0)
      demodulated_real = [demodulated_real 1];
      demodulated_imaginary = [demodulated_imaginary -1];
   %real-> -ve and img-> -ve
   else
      demodulated_real = [demodulated_real -1];
      demodulated_imaginary = [demodulated_imaginary -1];
   end
   end
   end
end
length(demodulated_real)
length(Binary_Data1)
length(Signal)
%BER - Bit error rate
Change_in_real = sum((Real_BD ~=demodulated_real));
Change_in_imaginary = sum((Imaginary_BD ~=demodulated_imaginary));
Total_Different = Change_in_real + Change_in_imaginary;
Total_bits = length(Real_BD) + length(Imaginary_BD);
BER(k) = Total_Different/Total_bits;
end

%Plot
semilogy(10*log10(SNR),BER);
end

% function y = BinaryToComplex(x)
% j = 1;
% for i=1:length(x)
%     if(x(i)==0 && x(i+1))
%        y(j) 
%     end
% end
% end