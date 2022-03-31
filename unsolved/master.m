
%1)Load the audio/image
% The loaded audio has analog values that need to be restricted to a range
% for proper encoding
% The image consists of RGB channels with values in 0-255 

%%
% CRC is called cyclic redundancy check. It is used for checking if the
% transmission was accurate or erroneous.
% For 4-byte (32 bit) CRC calculation, use CRC32 algorithm.

% 2.1) Use comm.CRCGenerator with a 32 degree polynomial (Check Docs!)
% Generate a CRC generator object and pass it to the function
% This object is necessary because CRC values are not unique.

% Use this for th polynomial:
% 'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1'

poly='z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1';
% 2.2) After generating a CRCGenerator above, create a CRCDetector Object for
% error detection here.
%%
%3) modulation
%Declare modulation/demodulation schemes to convert the data to signal
%Hint:comm.BPSKModulator
%%%%%%%%%%%bpsk%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 2;                 % Modulation alphabet
k = log2(M);           % Bits/symbol
%%
%4) ofdm
%Declare the OFDM modulator and demodulator with the following parameters
%Hint:comm.OFDMModulator
numSC = 64;           % Number of OFDM subcarriers
cpLen = 32;            % OFDM cyclic prefix length
maxBitErrors = 100;    % Maximum number of bit errors
maxNumBits = 1e7;      % Maximum number of bits transmitted
%%
%5) channel
%The channel has to be modeled as awgn with SNR 10dB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%transmitter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convert the image/audio into column of bits 0/1
%%
%packetization 
% Encapsulation : The process of encapsulating the data received from upper layers of the network(also called as payload) in a network layer packet at the source
mac_frame_buff= encapsulating_packetization (data,frameSize,crcgenerator)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%modulation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3.1)Apply the defined modulation scheme
%4.1)Apply OFDM modulation on BPSK/PSK/QAM modulated data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%channel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%5)Apply the channel channel characteristics on modulated signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%demodulation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4.2)Apply OFDM demodulation on received signal
%3.2)Apply the defined demodulation scheme
%%
%packetization 
% Decapsulation : Getting the payload from the network layer packet at the destination 
[bits,err] = decapsulating_packetization (rx_frame_buff,dataSize,crcdetector)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%receiver%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convert the bit data to image/audio
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Error%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate the BER
%Hint: comm.ErrorRate