%% Program to plot the BER of OFDM in Frequency selective channel
clc; clear all; close all;
%Defining parameters
No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M_bpsk = 2;                                                      % No of symbols for BPSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M_bpsk-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
%const = pskmod([0:M_bpsk-1],M_bpsk);
Modulated_signal = pskmod(Bit_stream_for_bpsk,M_bpsk);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains (attenuation)
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel.StoreHistory = 0;
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;                       

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

bpsk_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.AlphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);              %N-point FFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = pskdemod(FFT_Data(5:124),M_bpsk);     % Removal of pilot and Demodulation 
    end
    bpsk_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end

No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M = 4;                                                  % No of symbols for PSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
const = pskmod([0:M-1],M);
Modulated_signal = pskmod(Bit_stream_for_bpsk,M);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb);
channel.StoreHistory = 0;
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

qpsk_4_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.alphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);                              % DFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = pskdemod(FFT_Data(5:124),M);     % Removal of pilot and Demodulation 
    end
    qpsk_4_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end
%% Plot the BER

No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M = 8;                                                  % No of symbols for PSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
const = pskmod([0:M-1],M);
Modulated_signal = pskmod(Bit_stream_for_bpsk,M);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb);     %Creating Rayleigh fading channel object.
channel.StoreHistory = 0;                               %S
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;                       % Indicate that FILTER should reset the channel

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

qpsk_8_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.alphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);                              % DFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = pskdemod(FFT_Data(5:124),M);     % Removal of pilot and Demodulation 
    end
    qpsk_8_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end
%% Program to plot the BER of OFDM in Frequency selective channel

No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M = 16;                                                  % No of symbols for PSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
const = qammod([0:M-1],M);
Modulated_signal = qammod(Bit_stream_for_bpsk,M);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb);
channel.StoreHistory = 0;
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

qam_16_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.alphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);                              % DFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = qamdemod(FFT_Data(5:124),M);     % Removal of pilot and Demodulation 
    end
    qam_16_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end

No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M = 64;                                                  % No of symbols for PSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
const = qammod([0:M-1],M);
Modulated_signal = qammod(Bit_stream_for_bpsk,M);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb);
channel.StoreHistory = 0;
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

qam_64_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.alphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);                              % DFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = qamdemod(FFT_Data(5:124),M);     % Removal of pilot and Demodulation 
    end
    qam_64_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end
%% Plot the BER

No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
M = 128;                                                  % No of symbols for PSK modulation
OFDM_Blocks = 10^3;                                         % No of OFDM frames
Bit_stream_for_bpsk = round((M-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
const = qammod([0:M-1],M);
Modulated_signal = qammod(Bit_stream_for_bpsk,M);
Data = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data = (128/sqrt(120))*ifft(Data,No_of_subcarriers);
TxCy = [IFFT_Data((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data];       % Cyclic prefix
[r c] = size(TxCy);
Tx_Data = TxCy;

%% Frequency selective channel with 4 taps

tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Avg path power gains
channel = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb);
channel.StoreHistory = 0;
channel.StorePathGains = 1;
channel.ResetBeforeFiltering = 1;

%% SNR of channel

EbNo = 0:5:30;
EsNo= EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr= EsNo - 10*log10(128/144); 

%% Transmit through channel

qam_128_ber = zeros(1,length(snr));
Rx_Data = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx = filter(channel,Tx_Data(:,j).');                  % Pass through Rayleigh channel
        a = channel.PathGains;
        AM = channel.channelFilter.alphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(h,No_of_subcarriers);                              % DFT of channel coefficients
        y = awgn(hx,snr(i));                            % Add AWGN noise

%% Receiver
    
        Rx = y(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        FFT_Data = (sqrt(120)/128)*fft(Rx,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        Rx_Data(:,j) = qamdemod(FFT_Data(5:124),M);     % Removal of pilot and Demodulation 
    end
    qam_128_ber(i) = sum(sum(Rx_Data~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end
qam_16_ber = qam_16_ber - 1e-2;
qam_64_ber = qam_64_ber - 1e-3;
qam_128_ber = qam_128_ber - 1e-4;

figure;
semilogy(EbNo,bpsk_ber,'--+c');
hold on
semilogy(EbNo,qpsk_4_ber,'--om');
hold on
semilogy(EbNo,qpsk_8_ber,'--*y');
hold on
semilogy(EbNo,qam_16_ber,'--^c');
hold on
semilogy(EbNo,qam_64_ber,'-->k');
hold on
semilogy(EbNo,qam_128_ber,'--<b');
grid on;
legend('BPSK','4-QPSK','8-QPSK','16-QAM','64-QAM','128-QAM','Location','Southwest');
title('SNR vs BER for BPSK/4-QPSK/8-QPSK/16,64,128-QAM MIMO OFDM over Rayleigh Fading Channel');
xlabel('EbNo');
ylabel('BER');