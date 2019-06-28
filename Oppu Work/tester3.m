%% FBMC Modulation & Demodulation with AWGN channel
clear all;
close all
clc
%s = rng(211);            % Set RNG state for repeatability
% System Parameters
%
% Define system parameters for the example. You can modify these parameters
% to explore their impact on the system.

numFFT = 1024;           % Number of FFT points
numGuards = 212;         % Guard bands on both sides
K =4;                   % Overlapping symbols, one of 2, 3, or 4
numSymbols = 100;        % Simulation length in symbols
bitsPerSubCarrier = 6;   % 2: 4QAM, 4: 16QAM, 6: 64QAM, 8: 256QAM % This is M
%snrdB = 12;             % SNR in dB
EbNoVec = 1:28;          % This is

%% Filter Bank Multi-Carrier Modulation
channel = comm.AWGNChannel('BitsPerSymbol',bitsPerSubCarrier,'NoiseMethod',...
'Signal to noise ratio (SNR)','SignalPower',0.000155);%2.8070e-04

%Single tap equalization
fs =100000 ;                % Sample rate (Hz)
pathDelays = [0]*1e-6;  % Path delays (s)
pathPower = 0;      % Path power (dB)
fD = 0.4;                   % Maximum Doppler shift (Hz)
de= doppler('Rounded');
c=100;
%numSamples = 1000;        % Number of samples


relChan = comm.RayleighChannel('SampleRate',fs, ...
    'PathDelays',pathDelays,'AveragePathGains',pathPower, ...
    'MaximumDopplerShift',fD,     'NormalizePathGains',false,'DopplerSpectrum',doppler('Rounded'));

for EbNo = 1:length(EbNoVec)
   % disp('loop 1');
    %Convert Eb/No to SNR
    snrdB = EbNo;% + 3 + 10*log10(bitsPerSubCarrier);
    channel.SNR = EbNo;
    
    BER = comm.ErrorRate('ReceiveDelay',14400);
    
    % Prototype filter
    switch K
        case 2
            HkOneSided = sqrt(2)/2;
        case 3
            HkOneSided = [0.911438 0.411438];
        case 4
            HkOneSided = [0.971960 sqrt(2)/2 0.235147];
        otherwise
            return
    end
    % Build symmetric filter
    Hk = [fliplr(HkOneSided) 1 HkOneSided];

    % QAM symbol mapper
    qamMapper = comm.RectangularQAMModulator(...
        'ModulationOrder', 2^bitsPerSubCarrier, ...
        'BitInput', true, ...
        'NormalizationMethod', 'Average power');
    
    % QAM demodulator
    qamDemod = comm.RectangularQAMDemodulator(...
        'ModulationOrder', 2^bitsPerSubCarrier, ...
        'BitOutput', true, ...
        'NormalizationMethod', 'Average power');

    % Transmit-end processing
    %   Initialize arrays
    L = numFFT-2*numGuards;  % Number of complex symbols per OFDM symbol
    KF = K*numFFT;
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

    % Loop over symbols
    for symIdx = 1:numSymbols
   % disp('loop 1-1');
        % Generate mapped symbol data
        inpData(:, symIdx) = randi([0 1], numBits, 1);
        %modData = qamMapper(inpData(:, symIdx));
        modData = step(qamMapper,inpData(:, symIdx));

        % OQAM Modulator: alternate real and imaginary parts
        if rem(symIdx,2)==1     % Odd symbols
            dataSubCar(1:2:L) = real(modData);
            dataSubCar(2:2:L) = 1i*imag(modData);
        else                    % Even symbols
            dataSubCar(1:2:L) = 1i*imag(modData);
            dataSubCar(2:2:L) = real(modData);
        end

        % Upsample by K, pad with guards, and filter with the prototype filter
        dataSubCarUp(1:K:end) = dataSubCar;
        dataBitsUpPad = [zeros(numGuards*K,1); dataSubCarUp; zeros(numGuards*K,1)];
        X1 = filter(Hk, 1, dataBitsUpPad);
        % Remove 1/2 filter length delay
        X = [X1(K:end); zeros(K-1,1)];

        % Compute IFFT of length KF for the transmitted symbol
        txSymb = fftshift(ifft(X));

        % Transmitted signal is a sum of the delayed real, imag symbols
        symBuf = [symBuf(numFFT/2+1:end); complex(zeros(numFFT/2,1))];
        symBuf(KF+(1:KF)) = symBuf(KF+(1:KF)) + txSymb;

        % Compute power spectral density (PSD)
        currSym = complex(symBuf(1:KF));
%         [specFBMC, fFBMC] = periodogram(currSym, hann(KF, 'periodic'), KF*2, 1);
%         sumFBMCSpec = sumFBMCSpec + specFBMC;

        % Store transmitted signals for all symbols
        %currSym = relChan(currSym);
        currSym = step(relChan,currSym);

   
        txSigAll(:,symIdx) = (currSym);
       % disp('loop 1-2');
    end
   
    
    % hx=filter(relChan,modData(:,j).');
        realizations=1;
    for m=1:length(snrdB)   
    
      for h=1:realizations
      %   disp('loop 1-2-1');
        for j=1:c
      %      disp('loop 1-2-1-1');
        end
      end
    end
   pathgain=step(relChan,txSigAll(:,j));
         
   g=pathgain(1,1:1);
    P=fft(g);
    %% FBMC Receiver

   
    % Process symbol-wise
    for symIdx = 1:numSymbols
        %disp('loop 1-2');
        rxSig = txSigAll(:,symIdx);

        % Add WGN to Received Signal
        %release(channel);
     %rxNsig = (rxSig);
        rxNsig = step(relChan,rxSig);
       % rxNsig = channel(rxSig);

        % Perform FFT
        rxf = fft(fftshift(rxNsig));

        % Matched filtering with prototype filter
        rxfmf = filter(Hk, 1, rxf);
        % Remove K-1 delay elements
        rxfmf = [rxfmf(K:end); zeros(K-1,1)];
        % Remove guards
        rxfmfg = rxfmf(numGuards*K+1:end-numGuards*K);

        % OQAM post-processing
        %  Downsample by 2K, extract real and imaginary parts
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

        % Demapper: Perform hard decision
        % rxBits(:, symIdx) = qamDemod(rcomb);    
        rxBits(:, symIdx) = step(qamDemod,rcomb); 
    end

    % Measure BER with appropriate delay
    %BER.ReceiveDelay = bitsPerSubCarrier*KL;
    % error(:,EbNo) = step(errorCalc,inpData(:),rxBits(:)); 
    ber =step(BER,inpData(:),rxBits(:));

    % Display Bit error
    disp(['FBMC Reception for K = ' num2str(K) ', BER = ' num2str(ber(1)) ...
        ' at SNR = ' num2str(snrdB) ' dB'])

    newber(EbNo) = ber(1);
    %SNR(snrdB) = varSnr  
    Eq=fft(rxBits)./P;
    
         
end
  
%  end
   
%% Comapring the BER values

berTheory = berfading(EbNoVec,'qam',64,1);

% Plot BER
semilogy(EbNoVec,newber)
hold on
semilogy(EbNoVec,berTheory)
grid
axis([1 length(EbNoVec) 10^-5 1])
legend('Actual BER','Theoretical BER')
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate')
title('BER comparison for FBMC with AWGN Channel')

% Restore RNG state
%rng(s);