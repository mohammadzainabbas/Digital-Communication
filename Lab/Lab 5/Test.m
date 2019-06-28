packet_1=randn(1,100);
packet_2=randn(1,100);
packet_3=randn(1,100);
packet_4=randn(1,100);
packet_5=randn(1,100);
packet_6=randn(1,100);
packet_7=randn(1,100);
packet_8=randn(1,100);
packet_9=randn(1,100);
packet_10=randn(1,100);

packets_2=[packet_1,packet_2];
packets_4=[packet_1,packet_2,packet_3,packet_4];
packets_6=[packet_1,packet_2,packet_3,packet_4,packet_5,packet_6];
packets_8=[packet_1,packet_2,packet_3,packet_4,packet_5,packet_6,packet_7,packet_8];
packets_10=[packet_1,packet_2,packet_3,packet_4,packet_5,packet_6,packet_7,packet_8,packet_9,packet_10];
BER=zeros(1,5);
for i=1:5
    if(i==1)
        packet_send=packets_2;
    elseif(i==2)
        packet_send=packets_4;
    elseif(i==3)
        packet_send=packets_6;
    elseif(i==4)
        packet_send=packets_8;
    elseif(i==5)
        packet_send=packets_10;
    end
partitions=-1:0.125:1; % 16 levels for quantization

codebook=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];


Quantized_Signal=quantiz(packet_send,partitions,codebook);

bit_Stream=de2bi(Quantized_Signal);

Polar_NRZ=[];
k=1:3;
for j=1:length(bit_Stream)
     Polar_NRZ=[Polar_NRZ bit_Stream(j,1:5)] ;  % converting the  1001*5 to a single bit stream of 1*5005
end
Polar_NRZL_Pulse = zeros(1,200*length(Polar_NRZ)); % assigning values 1=+5 and 0=-5 
l=1;
for k=1:200:length(Polar_NRZ)*200
   
    if(Polar_NRZ(l)==1)
        Polar_NRZL_Pulse(k:k+199)=5;
    else
        Polar_NRZL_Pulse(k:k+199)=-5;
    end
    l=l+1;
end

noise3=15*randn(1,length(Polar_NRZL_Pulse));
Noised_Signal=noise3+Polar_NRZL_Pulse;

Averaged_Signal=[];
for m=1:200:length(Noised_Signal)-200
    Averaged_Signal=[Averaged_Signal (sum(Noised_Signal(m:m+200)))/200]; %Taking average of signal because 1 bit is represented with 200 samples and demodulating
end

for n=1:length(Averaged_Signal) %converting the values to binary >0 =1 and <0 = 0
   if( Averaged_Signal(n)>0)
       Averaged_Signal(n)=1;
   else
       Averaged_Signal(n)=0;
   end
end
Averaged_Signal=[Averaged_Signal 1]; % appending a bit because it was 1*5004 to make it 1*5005
BER(i)=(sum(xor(Averaged_Signal,Polar_NRZ)))/length(Polar_NRZ); % Finding Bit Rate

Decoded_Signal=zeros(1001,5);

for o=1:1001
   if(o==1)
    Decoded_Signal(o,1:5)=Averaged_Signal(i:i+4);
   else
    Decoded_Signal(o,1:5)=Averaged_Signal(i*5-4:i*5); % Decoding by coverting 1*5005 to again 1001*5
   end
    
end

Signal=bi2de(Decoded_Signal); %converting binary values to decimal values again
recieved_Signal=rot90(Signal);
end

k=1:2:10;
plot(k,BER);
% title()
