Fs=1000;   
time=0:1/Fs:1;
f=5;

Umer_Signal=sin(2*pi*time*f);
% figure;
% plot(Umer_Signal);
% title('Umer_Signal');

 

 partitions=-1:0.125:1; % 16 levels for quantization

codebook=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];

Quantized_Signal=quantiz(Umer_Signal,partitions,codebook); % Quantized_Signal
% figure;
% stem(Quantized_Signal);
% title('Quantized_Signal');

bit_Stream=de2bi(Quantized_Signal); % Converting decimal signals into binary

Polar_NRZ=[];
k=1:3;
for i=1:length(bit_Stream)
     Polar_NRZ=[Polar_NRZ bit_Stream(i,1:5)] ;  % converting the  1001*5 to a single bit stream of 1*5005
end
Polar_NRZL_Pulse = zeros(1,200*length(Polar_NRZ)); % assigning values 1=+5 and 0=-5 
i=1;
for k=1:200:length(Polar_NRZ)*200
   
    if(Polar_NRZ(i)==1)
        Polar_NRZL_Pulse(k:k+199)=5;
    else
        Polar_NRZL_Pulse(k:k+199)=-5;
    end
    i=i+1;
end

% plot(Polar_NRZL_Pulse);
% title('Polar NRZL Pulse');


noise1=0.5*randn(1,length(Polar_NRZL_Pulse)); % noises of different variances
noise2=1*randn(1,length(Polar_NRZL_Pulse));
noise3=10*randn(1,length(Polar_NRZL_Pulse));

Noised_Signal=noise3+Polar_NRZL_Pulse; % adding noise to the Polar signal
Averaged_Signal=[];
for i=1:200:length(Noised_Signal)-200
    Averaged_Signal=[Averaged_Signal (sum(Noised_Signal(i:i+200)))/200]; %Taking average of signal because 1 bit is represented with 200 samples and demodulating
end

for i=1:length(Averaged_Signal) %converting the values to binary >0 =1 and <0 = 0
   if( Averaged_Signal(i)>0)
       Averaged_Signal(i)=1;
   else
       Averaged_Signal(i)=0;
   end
end
Averaged_Signal=[Averaged_Signal 1]; % appending a bit because it was 1*5004 to make it 1*5005
BER=(sum(xor(Averaged_Signal,Polar_NRZ)))/length(Polar_NRZ); % Finding Bit Rate

Decoded_Signal=zeros(1001,5);

for i=1:1001
   if(i==1)
    Decoded_Signal(i,1:5)=Averaged_Signal(i:i+4);
   else
    Decoded_Signal(i,1:5)=Averaged_Signal(i*5-4:i*5); % Decoding by coverting 1*5005 to again 1001*5
   end
    
end

Signal=bi2de(Decoded_Signal); %converting binary values to decimal values again
Signal=rot90(Signal);
