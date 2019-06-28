%% Program to plot the BER of OFDM in Frequency selective channel
clc; clear all; close all;
%Defining parameters
No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                           % Cyclic prefix length
Sampling_time = 1e-3;                                                   % Sampling period of channel
Max_doppler_frequency = 0;                                              % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                % No of pilot symbols
OFDM_Blocks = 1e3;                                                     % No of OFDM frames

M_bpsk = 2;     M_qpsk_4 = 4;       M_qpsk_8 = 8;                       % No of symbols for M-PSK modulation
M_qam_16 = 16;  M_qam_64 = 64;      M_qam_128 = 128;                    % No of symbols for M_QAM modulation

Bit_stream_for_bpsk     = round((M_bpsk-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qpsk_4   = round((M_qpsk_4-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qpsk_8   = round((M_qpsk_8-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qam_16   = round((M_qam_16-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qam_64   = round((M_qam_64-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qam_128  = round((M_qam_128-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
%const = pskmod([0:M_bpsk-1],M_bpsk);   %const = pskmod([0:M_qpsk_4-1],M_qpsk_4);   %const = qammod([0:M_qam_16-1],M_qam_16);
Modulated_signal_bpsk       = pskmod(Bit_stream_for_bpsk,M_bpsk);
Modulated_signal_qpsk_4     = pskmod(Bit_stream_for_qpsk_4,M_qpsk_4);
Modulated_signal_qpsk_8     = pskmod(Bit_stream_for_qpsk_8,M_qpsk_8);
Modulated_signal_qam_16     = qammod(Bit_stream_for_qam_16,M_qam_16);
Modulated_signal_qam_64     = qammod(Bit_stream_for_qam_64,M_qam_64);
Modulated_signal_qam_128    = qammod(Bit_stream_for_qam_128,M_qam_128);

Data_bpsk       = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_bpsk ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qpsk_4     = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qpsk_4 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qpsk_8     = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qpsk_8 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qam_16     = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qam_16 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qam_64     = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qam_64 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qam_128    = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qam_128 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
%% OFDM symbol
IFFT_Data_bpsk      = (128/sqrt(120))*ifft(Data_bpsk,No_of_subcarriers);
IFFT_Data_qpsk_4    = (128/sqrt(120))*ifft(Data_qpsk_4,No_of_subcarriers);
IFFT_Data_qpsk_8    = (128/sqrt(120))*ifft(Data_qpsk_8,No_of_subcarriers);
IFFT_Data_qam_16    = (128/sqrt(120))*ifft(Data_qam_16,No_of_subcarriers);
IFFT_Data_qam_64    = (128/sqrt(120))*ifft(Data_qam_64,No_of_subcarriers);
IFFT_Data_qam_128   = (128/sqrt(120))*ifft(Data_qam_128,No_of_subcarriers);

Tx_Data_bpsk       = [IFFT_Data_bpsk((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_bpsk];           % Cyclic prefix
Tx_Data_qpsk_4     = [IFFT_Data_qpsk_4((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qpsk_4];       % Cyclic prefix
Tx_Data_qpsk_8     = [IFFT_Data_qpsk_8((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qpsk_8];       % Cyclic prefix
Tx_Data_qam_16     = [IFFT_Data_qam_16((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qam_16];       % Cyclic prefix
Tx_Data_qam_64     = [IFFT_Data_qam_64((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qam_64];       % Cyclic prefix
Tx_Data_qam_128    = [IFFT_Data_qam_128((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qam_128];       % Cyclic prefix

[row column] = size(Tx_Data_bpsk);        %All have same size

%% Frequency selective channel with 4-tapped ISI channel
tau = [0 1e-5 3.5e-5 12e-5];                            % Path delays
pdb = [0 -1 -1 -3];                                     % Average path power gains (attenuation)

channel1 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel2 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel3 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel4 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel5 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.
channel6 = rayleighchan(Sampling_time, Max_doppler_frequency, tau, pdb); %Creating Rayleigh fading channel object.

channel1.StoreHistory = 0;   channel1.StorePathGains = 1;     channel1.ResetBeforeFiltering = 1;                       
channel2.StoreHistory = 0;   channel2.StorePathGains = 1;     channel2.ResetBeforeFiltering = 1;                       
channel3.StoreHistory = 0;   channel3.StorePathGains = 1;     channel3.ResetBeforeFiltering = 1;                       
channel4.StoreHistory = 0;   channel4.StorePathGains = 1;     channel4.ResetBeforeFiltering = 1;                       
channel5.StoreHistory = 0;   channel5.StorePathGains = 1;     channel5.ResetBeforeFiltering = 1;                       
channel6.StoreHistory = 0;   channel6.StorePathGains = 1;     channel6.ResetBeforeFiltering = 1;                       
%% SNR of channel
EbNo = 0:5:30;
EsNo = EbNo + 10*log10(120/128)+ 10*log10(128/144);      % symbol to noise ratio
snr  = EsNo - 10*log10(128/144); 
%% Transmit through channel
bpsk_ber    = zeros(1,length(snr)); 
qpsk_4_ber  = zeros(1,length(snr));
qpsk_8_ber  = zeros(1,length(snr));
qam_16_ber  = zeros(1,length(snr));
qam_64_ber  = zeros(1,length(snr));
qam_128_ber = zeros(1,length(snr));

Rx_Data_bpsk    = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qpsk_4  = zeros((No_of_subcarr iers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qpsk_8  = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qam_16  = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qam_64  = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qam_128 = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);

for i = 1:length(snr)
    for j = 1:column                                         % Transmit frame by frame
        hx_bpsk     = filter(channel1,Tx_Data_bpsk(:,j).');                  % Pass through Rayleigh channel
        hx_qpsk_4	= filter(channel2,Tx_Data_qpsk_4(:,j).');                % Pass through Rayleigh channel
        hx_qpsk_8   = filter(channel3,Tx_Data_qpsk_8(:,j).');                % Pass through Rayleigh channel
        hx_qam_16   = filter(channel4,Tx_Data_qam_16(:,j).');                % Pass through Rayleigh channel
        hx_qam_64   = filter(channel5,Tx_Data_qam_64(:,j).');                % Pass through Rayleigh channel
        hx_qam_128  = filter(channel6,Tx_Data_qam_128(:,j).');               % Pass through Rayleigh channel

        a1 = channel1.PathGains;
        a2 = channel2.PathGains;
        a3 = channel3.PathGains;
        a4 = channel4.PathGains;
        a5 = channel5.PathGains;
        a6 = channel6.PathGains;

        AM1 = channel1.channelFilter.AlphaMatrix;
        AM2 = channel2.channelFilter.AlphaMatrix;
        AM3 = channel3.channelFilter.AlphaMatrix;
        AM4 = channel4.channelFilter.AlphaMatrix;
        AM5 = channel5.channelFilter.AlphaMatrix;
        AM6 = channel6.channelFilter.AlphaMatrix;

        h1 = a1*AM1;                                             % Channel coefficients
        h2 = a2*AM2;                                             % Channel coefficients
        h3 = a3*AM3;                                             % Channel coefficients
        h4 = a4*AM4;                                             % Channel coefficients
        h5 = a5*AM5;                                             % Channel coefficients
        h6 = a6*AM6;                                             % Channel coefficients

        H1(j,:) = fft(h1,No_of_subcarriers);              %N-point FFT of channel coefficients
        H2(j,:) = fft(h2,No_of_subcarriers);              %N-point FFT of channel coefficients
        H3(j,:) = fft(h3,No_of_subcarriers);              %N-point FFT of channel coefficients
        H4(j,:) = fft(h4,No_of_subcarriers);              %N-point FFT of channel coefficients
        H5(j,:) = fft(h5,No_of_subcarriers);              %N-point FFT of channel coefficients
        H6(j,:) = fft(h6,No_of_subcarriers);              %N-point FFT of channel coefficients
        
        y_bpsk      = awgn(hx_bpsk,snr(i));                            % Add AWGN noise
        y_qpsk_4    = awgn(hx_qpsk_4,snr(i));                          % Add AWGN noise
        y_qpsk_8    = awgn(hx_qpsk_8,snr(i));                          % Add AWGN noise
        y_qam_16    = awgn(hx_qam_16,snr(i));                          % Add AWGN noise
        y_qam_64    = awgn(hx_qam_64,snr(i));                          % Add AWGN noise
        y_qam_128   = awgn(hx_qam_128,snr(i));                         % Add AWGN noise
%% Receiver
        Rx_bpsk     = y_bpsk(Length_of_cyclic_prefix+1:row);                                % Removal of cyclic prefix 
        Rx_qpsk_4   = y_qpsk_4(Length_of_cyclic_prefix+1:row);                              % Removal of cyclic prefix 
        Rx_qpsk_8   = y_qpsk_8(Length_of_cyclic_prefix+1:row);                              % Removal of cyclic prefix 
        Rx_qam_16   = y_qam_16(Length_of_cyclic_prefix+1:row);                              % Removal of cyclic prefix 
        Rx_qam_64   = y_qam_64(Length_of_cyclic_prefix+1:row);                              % Removal of cyclic prefix 
        Rx_qam_128  = y_qam_128(Length_of_cyclic_prefix+1:row);                             % Removal of cyclic prefix 
 
        FFT_Data_bpsk       = (sqrt(120)/128)*fft(Rx_bpsk,No_of_subcarriers)./H1(j,:);       % Frequency Domain Equalization
        FFT_Data_qpsk_4     = (sqrt(120)/128)*fft(Rx_qpsk_4,No_of_subcarriers)./H2(j,:);     % Frequency Domain Equalization
        FFT_Data_qpsk_8     = (sqrt(120)/128)*fft(Rx_qpsk_8,No_of_subcarriers)./H3(j,:);     % Frequency Domain Equalization
        FFT_Data_qam_16     = (sqrt(120)/128)*fft(Rx_qam_16,No_of_subcarriers)./H4(j,:);     % Frequency Domain Equalization
        FFT_Data_qam_64     = (sqrt(120)/128)*fft(Rx_qam_64,No_of_subcarriers)./H5(j,:);     % Frequency Domain Equalization
        FFT_Data_qam_128    = (sqrt(120)/128)*fft(Rx_qam_128,No_of_subcarriers)./H6(j,:);    % Frequency Domain Equalization
    
        Rx_Data_bpsk(:,j)       = pskdemod(FFT_Data_bpsk(5:124),M_bpsk);            % Removal of pilot and Demodulation 
        Rx_Data_qpsk_4(:,j)     = pskdemod(FFT_Data_qpsk_4(5:124),M_qpsk_4);        % Removal of pilot and Demodulation 
        Rx_Data_qpsk_8(:,j)     = pskdemod(FFT_Data_qpsk_8(5:124),M_qpsk_8);        % Removal of pilot and Demodulation 
        Rx_Data_qam_16(:,j)     = qamdemod(FFT_Data_qam_16(5:124),M_qam_16);        % Removal of pilot and Demodulation 
        Rx_Data_qam_64(:,j)     = qamdemod(FFT_Data_qam_64(5:124),M_qam_64);        % Removal of pilot and Demodulation 
        Rx_Data_qam_128(:,j)    = qamdemod(FFT_Data_qam_128(5:124),M_qam_128);      % Removal of pilot and Demodulation 
       
    end
    bpsk_ber(i)     = sum(sum(Rx_Data_bpsk~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qpsk_4_ber(i)   = sum(sum(Rx_Data_qpsk_4~=Bit_stream_for_qpsk_4))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qpsk_8_ber(i)   = sum(sum(Rx_Data_qpsk_8~=Bit_stream_for_qpsk_8))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qam_16_ber(i)   = sum(sum(Rx_Data_qam_16~=Bit_stream_for_qam_16))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qam_64_ber(i)   = sum(sum(Rx_Data_qam_64~=Bit_stream_for_qam_64))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qam_128_ber(i)  = sum(sum(Rx_Data_qam_128~=Bit_stream_for_qam_128))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
end
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