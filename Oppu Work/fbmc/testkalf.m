clear all;
close all
clc

s = rng(211); 
numFFT = 1024;           % Number of FFT points
numGuards = 212;         % Guard bands on both sides
K = 4;                   % Overlapping symbols, one of 2, 3, or 4
numSymbols = 100;        % Simulation length in symbols
bitsPerSubCarrier = 6;   % 2: 4QAM, 4: 16QAM, 6: 64QAM, 8: 256QAM
snrdB = 12;             % SNR in dB
EbNoVec = 1:20;          % This is


    HkOneSided = [0.971960 sqrt(2)/2 0.235147];
     % Build symmetric filter
    Hk = [fliplr(HkOneSided) 1 HkOneSided];
    
    L = numFFT-2*numGuards;  % Number of complex symbols per OFDM symbol
    KF = K*numFFT
    KL = K*L;
    dataSubCar = zeros(L, 1);
    dataSubCarUp = zeros(KL, 1);
    
    sumFBMCSpec = zeros(KF*2, 1);
    sumOFDMSpec = zeros(numFFT*2, 1);
    
    numBits = bitsPerSubCarrier*L/2;    % account for oversampling by 2
    inpData = zeros(numBits, numSymbols); 
    rxBits = zeros(numBits, numSymbols);
    txSigAll = complex(zeros(KF, numSymbols));
    symBuf = complex(zeros(2*KF, 1));
    
    for symIdx = 1:numSymbols

        % Generate mapped symbol data
        inpData(:, symIdx) = randi([0 1], numBits, 1);
        
       Modulated_Signal = modem.qammod(64);         
       Modulated_Signal.InputType = 'Bit';         
       Modulated_Signal.SymbolOrder = 'Gray';         
       hDemod = modem.qamdemod(Modulated_Signal); 
       
       modData = modulate(Modulated_Signal,inpData(:, symIdx));
       
       if rem(symIdx,2)==1     % Odd symbols
            dataSubCar(1:2:L) = real(modData);
            dataSubCar(2:2:L) = 1i*imag(modData);
        else                    % Even symbols
            dataSubCar(1:2:L) = 1i*imag(modData);
            dataSubCar(2:2:L) = real(modData);
       end
        
      
       dataSubCarUp(1:K:end) = dataSubCar;
       dataBitsUpPad = [zeros(numGuards*K,1); dataSubCarUp; zeros(numGuards*K,1)];
       X1 = filter(Hk, 1, dataBitsUpPad);
    
       X = [X1(K:end); zeros(K-1,1)];
       txSymb = fftshift(ifft(X));
       symBuf = [symBuf(numFFT/2+1:end); complex(zeros(numFFT/2,1))];
       symBuf(KF+(1:KF)) = symBuf(KF+(1:KF)) + txSymb;
       
       currSym = complex(symBuf(1:KF));
        [specFBMC, fFBMC] = periodogram(currSym, hann(KF, 'periodic'), KF*2, 1);
        sumFBMCSpec = sumFBMCSpec + specFBMC;

        % Store transmitted signals for all symbols
        txSigAll(:,symIdx) = currSym;
    end
    
    sumFBMCSpec = sumFBMCSpec/mean(sumFBMCSpec(1+K+2*numGuards*K:end-2*numGuards*K-K));
    
   
a1=1; %needed to be calculated
p=1;
x_n=txSigAll(:,symIdx);% needed to be calculated
rn=[2,4,6,2,4,6,8,4]; %received data
[k,i]=size(rn);
h_o_o_hat=transpose(zeros(1,p));
h_n1_n_hat=transpose(zeros(1,p));
h=transpose(zeros(1,p));

Pnno=eye(p); %Gainen
kno=.1;% kalman gain
No=.001;

j=1;
hh=zeros(i,p);
error=zeros(i,1);
for j=1:1:i %assume j as n
    
 xn=transpose([x_n(j)]); 
 xnt=transpose(xn);
 
if j==1
  hn_hat=h_o_o_hat;  
 Pn=Pnno;
 kn=kno;
else
    hn_hat=hn1_hat;
    S=(xnt*Pn1_n)*conj(xn);
  kn=Pn1_n*conj(xn)*inv(No+S);
  Pn=Pn1_n-(kn*xnt*Pn1_n);
end
    
    
Qn1=[ 0.01]; %in article calculated through other method.
Fn=[a1];
h_n1_n_hat=Fn*(hn_hat);
Pn1_n=(Fn*(Pn*transpose(Fn)))+Qn1;
xe=((transpose(xn))* (h_n1_n_hat))
en=rn(j)-((transpose(xn))* (h_n1_n_hat));
hn1_hat=h_n1_n_hat+(kn*en)

error(j,:)=en
hh(j,:)=transpose(hn1_hat)
end

    
    BER = comm.ErrorRate;
    for symIdx = 1:numSymbols
        rxSig = txSigAll(:, symIdx);

        % Add WGN to Received Signal
        rxNsig = ( hh(j,:) );

        % Perform FFT
        rxf = fft(fftshift(rxNsig));
        
         rxfmf = filter(Hk, 1, rxf);
        % Remove K-1 delay elements
        rxfmf = [rxfmf(K:end); zeros(K-1,1)];
        % Remove guards
        rxfmfg = rxfmf(numGuards*K+1:end-numGuards*K);
        
        if rem(symIdx, 2)
            % Imaginary part is K samples after real one
            r1 = real(rxfmfg(1:2*K:end));
            r2 = imag(rxfmfg(K+1:2*K:end));
            rcomb = complex(r1, r2);
        else
            % Real part is K samples after imaginary one
            r1 = imag(rxfmfg(1:2*K:end));
            r2 = real(rxfmfg(K+1:2*K:end));
            rcomb = complex(r2, r1);
        end
        %  Normalize by the upsampling factor
        rcomb = (1/K)*rcomb;
        rxBits(:, symIdx) = demodulate(hDemod,rcomb);

    end
    
%     if(EbNo==1)
%        figure;
%        plot(rxBits)
%        title('rxBits')
%     end
    BER.ReceiveDelay = bitsPerSubCarrier*KL;
    ber = step(BER,inpData(:), rxBits(:));

    disp(['FBMC Reception for K ber2 = ' num2str(K) ', BER = ' num2str(ber(1)) ...
        ' at SNR = ' num2str(Pn) ' dB'])
     newber(EbNo) = ber(1);

figure;
semilogy(EbNoVec,newber)
grid
%axis([1 length(EbNoVec) 10^-5 1])
axis([1 length(EbNoVec) 0 1])
legend('Actual BER')
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate')
title('BER for FBMC with AWGN Channel')

rng(s);