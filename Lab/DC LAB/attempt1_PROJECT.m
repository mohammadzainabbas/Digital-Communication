
% No.of Carriers: 64
% coding used: Convolutional coding
% Single frame size: 96 bits
% Total no. of Frames: 100
% Modulation: 16-QAM
% No. of Pilots: 4
% Cylic Extension: 25%(16)

close all
clear all
clc


%%
% Generating and coding data
t_data=randint(9600,1)';  %randint ceates 9600 by 1 size matrix 
%1x9600 matrix containing value from 0 to 1 with probab 0.5
x=1;
si=1; %for BER rows
%%
for d=1:100;
data=t_data(x:x+95); %arry of 1x96 from t_data array created
x=x+96; %x value updated for next iteration
k=3;
n=6; %assuming carriiers
s1=size(data,2);  % return size of data
j=s1/k;

%%
% Convolutionally encoding data 
%channel coding is done so that the signal can easily withstand the effect
%of channel impairments such as noise etc
%trellis = poly2trellis(ConstraintLength,CodeGenerator) performs 
%the conversion for a rate k / n feedforward encoder. ConstraintLength
%is a 1-by-k vector that specifies the delay for the encoder's 
%k input bit streams. CodeGenerator is a k-by-n matrix of octal numbers or a k-by-n cell array of 
%polynomial character vectors that specifies the n output connections for each of the encoder's k input bit 
constlen=7;
codegen = [171 133];    % Polynomial
trellis = poly2trellis(constlen, codegen);
codedata = convenc(data, trellis);



%%
%Interleaving coded data
%improves error correcting codes
s2=size(codedata,2);
j=s2/4; %48
matrix=reshape(codedata,j,4); %48x4

intlvddata = matintrlv(matrix',2,2)'; % Reorder symbols by filling matrix by rows and emptying it by columns
intlvddata=intlvddata'; %4x48


%%
% Binary to decimal conversion

dec=bi2de(intlvddata','left-msb');


%%
%16-QAM Modulation

M=16;
y = qammod(dec,M);
% scatterplot(y);


%%
% Pilot insertion

lendata=length(y);
pilt=3+3j;
nofpits=4;

k=1;

for i=(1:13:52)
    
    pilt_data1(i)=pilt;

    for j=(i+1:i+12);
        pilt_data1(j)=y(k);
        k=k+1;
    end
end

pilt_data1=pilt_data1';   % size of pilt_data =52
pilt_data(1:52)=pilt_data1(1:52);    % upsizing to 64
pilt_data(13:64)=pilt_data1(1:52);   % upsizing to 64

for i=1:52
    
    pilt_data(i+6)=pilt_data1(i);
    
end


%%
% IFFT

ifft_sig=ifft(pilt_data',64);


%%
% Adding Cyclic Extension to remove effect of ISI
cext_data=zeros(80,1);
cext_data(1:16)=ifft_sig(49:64);
for i=1:64
    
    cext_data(i+16)=ifft_sig(i); %previous value added @start. 49-64(16) our original will start from 17
    
end


%%
% Channel

 % SNR

 o=1;
for snr=0:2:50

ofdm_sig=awgn(cext_data,snr,'measured'); % Adding white Gaussian Noise
% figure;
% index=1:80;
% plot(index,cext_data,'b',index,ofdm_sig,'r'); %plot both signals
% legend('Original Signal to be Transmitted','Signal with AWGN');


%%
%                   RECEIVER
%%
%Removing Cyclic Extension

for i=1:64
    
    rxed_sig(i)=ofdm_sig(i+16);
    
end


%%
% FFT

ff_sig=fft(rxed_sig,64);

%%
% Pilot Synch%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:52
    
    synched_sig1(i)=ff_sig(i+6);
    
end

k=1;

for i=(1:13:52)
        
    for j=(i+1:i+12);
        synched_sig(k)=synched_sig1(j);
        k=k+1;
    end
end

% scatterplot(synched_sig)


%%
% Demodulation
dem_data= qamdemod(synched_sig,16);


%% 
% Decimal to binary conversion

bin=de2bi(dem_data','left-msb');
bin=bin';


%%
% De-Interleaving


deintlvddata = matdeintrlv(bin,2,2); % De-Interleave
deintlvddata=deintlvddata';
deintlvddata=deintlvddata(:)';





%%
%Decoding data
n=6;
k=3;
decodedata =vitdec(deintlvddata,trellis,5,'trunc','hard');  % decoding datausing veterbi decoder
rxed_data=decodedata;

%%
% Calculating BER
rxed_data=rxed_data(:)';
errors=0;


c=xor(data,rxed_data);
errors=nnz(c);

% for i=1:length(data)
%     
%        
%     if rxed_data(i)~=data(i);
%         errors=errors+1;     
%      
%     end
% end


BER(si,o)=errors/length(data);
o=o+1;

 end % SNR loop ends here
 si=si+1;
end % main data loop

%%
% Time averaging for optimum results

for col=1:25;        %%%change if SNR loop Changed
    ber(1,col)=0;  
for row=1:100;
  
    
        ber(1,col)=ber(1,col)+BER(row,col);
    end
end
ber=ber./100; 

%%
figure
i=0:2:48;
semilogy(i,ber);
title('BER vs SNR');
ylabel('BER');
xlabel('SNR (dB)');
grid on