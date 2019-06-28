%% Program to plot the BER of OFDM in Frequency selective channel
clc; clear all; close all;
%Defining parameters
No_of_subcarriers = 128;                                                % No of subcarriers
Length_of_cyclic_prefix = 16;                                               % Cyclic prefix length
Sampling_time = 1e-3;                                              % Sampling period of channel
Max_doppler_frequency = 0;                                                 % Max Doppler frequency shift
No_of_pilot_symbols = 4;                                                 % No of pilot symbols
OFDM_Blocks = 10^3;                                                      % No of OFDM frames
M_bpsk = 2;   M_qpsk_4 = 4;                                                    % No of symbols for BPSK modulation




Bit_stream_for_bpsk = round((M_bpsk-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));
Bit_stream_for_qpsk_4 = round((M_qpsk_4-1)*rand((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks));

%const = pskmod([0:M_bpsk-1],M_bpsk);
%const = pskmod([0:M_qpsk_4-1],M_qpsk_4);

Modulated_signal_bpsk = pskmod(Bit_stream_for_bpsk,M_bpsk);
Modulated_signal_qpsk_4 = pskmod(Bit_stream_for_qpsk_4,M_qpsk_4);

Data_bpsk = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_bpsk ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion
Data_qpsk_4 = [zeros(No_of_pilot_symbols,OFDM_Blocks); Modulated_signal_qpsk_4 ; zeros(No_of_pilot_symbols,OFDM_Blocks)];   % Pilot Insertion

%% OFDM symbol

IFFT_Data_bpsk = (128/sqrt(120))*ifft(Data_bpsk,No_of_subcarriers);
IFFT_Data_qpsk_4 = (128/sqrt(120))*ifft(Data_qpsk_4,No_of_subcarriers);


TxCy_bpsk = [IFFT_Data_bpsk((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_bpsk];       % Cyclic prefix
TxCy_qpsk_4 = [IFFT_Data_qpsk_4((128-Length_of_cyclic_prefix+1):128,:); IFFT_Data_qpsk_4];       % Cyclic prefix

[r c] = size(TxCy_bpsk);
[r c] = size(TxCy_qpsk_4);


Tx_Data_bpsk = TxCy_bpsk;
Tx_Data_qpsk_4 = TxCy_qpsk_4;

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
qpsk_4_ber = zeros(1,length(snr));

Rx_Data_bpsk = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);
Rx_Data_qpsk_4 = zeros((No_of_subcarriers-2*No_of_pilot_symbols),OFDM_Blocks);

for i = 1:length(snr)
    for j = 1:c                                         % Transmit frame by frame
        hx_bpsk = filter(channel,Tx_Data_bpsk(:,j).');                  % Pass through Rayleigh channel
        hx_qpsk_4 = filter(channel,Tx_Data_qpsk_4(:,j).');                  % Pass through Rayleigh channel
        
        a = channel.PathGains;
        AM = channel.channelFilter.AlphaMatrix;
        h = a*AM;                                       % Channel coefficients
        H(j,:) = fft(channel,No_of_subcarriers);              %N-point FFT of channel coefficients
        y_bpsk = awgn(hx_bpsk,snr(i));                            % Add AWGN noise
        y_qpsk_4 = awgn(hx_qpsk_4,snr(i));                            % Add AWGN noise


%% Receiver
    
        Rx_bpsk = y_bpsk(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 
        Rx_qpsk_4 = y_qpsk_4(Length_of_cyclic_prefix+1:r);                                % Removal of cyclic prefix 


        FFT_Data_bpsk = (sqrt(120)/128)*fft(Rx_bpsk,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        FFT_Data_qpsk_4 = (sqrt(120)/128)*fft(Rx_qpsk_4,No_of_subcarriers)./H(j,:);   % Frequency Domain Equalization
        
        Rx_Data_bpsk(:,j) = pskdemod(FFT_Data_bpsk(5:124),M_bpsk);     % Removal of pilot and Demodulation 
        Rx_Data_qpsk_4(:,j) = pskdemod(FFT_Data_qpsk_4(5:124),M_qpsk_4);     % Removal of pilot and Demodulation 
        
    end
    bpsk_ber(i) = sum(sum(Rx_Data_bpsk~=Bit_stream_for_bpsk))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);
    qpsk_4_ber(i) = sum(sum(Rx_Data_qpsk_4~=Bit_stream_for_qpsk_4))/((No_of_subcarriers-2*No_of_pilot_symbols)*OFDM_Blocks);

end