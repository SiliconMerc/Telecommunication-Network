%1)Load the audio/image
% The loaded audio has analog values that need to be restricted to a range
% for proper encoding
% The image consists of RGB channels with values in 0-255 
path="C:\Users\prana\OneDrive\Documents\GitHub\Telecommunication-Network\cat.mp4";
%read video
vidObj = VideoReader(path);
% t=1.0/vidObj.FrameRate:1.0/vidObj.FrameRate:vidObj.Duration;
% t=[1];
% t=1.0/vidObj.FrameRate:1:vidObj.Duration;
t=1.0/vidObj.FrameRate:1:20;


eof=false;

%write video
v = VideoWriter('cats2.avi');
v.FrameRate = vidObj.FrameRate;
open(v);
%%
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
crcgenerator=comm.CRCGenerator(poly);
% 2.2) After generating a CRCGenerator above, create a CRCDetector Object for
% error detection here.
crcdetector=comm.CRCDetector(poly);
%%

%3) modulation
%Declare modulation/demodulation schemes to convert the data to signal
%Hint:comm.BPSKModulator
%%%%%%%%%%%bpsk%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 2;                 % Modulation alphabet
k = log2(M);           % Bits/symbol
bpskModulator = comm.BPSKModulator;
errorRate = comm.ErrorRate;
bpskDemodulator = comm.BPSKDemodulator;
%%%%%%%%%%qpsk%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M = 4;                 % Modulation alphabet
% k = log2(M);           % Bits/symbol
% qpskMod = comm.QPSKModulator('BitInput',true);
% qpskDemod = comm.QPSKDemodulator('BitInput',true);
%%

%4) ofdm
%Declare the OFDM modulator and demodulator with the following parameters
%Hint:comm.OFDMModulator
numSC = 52;           % Number of OFDM subcarriers
cpLen = 32;            % OFDM cyclic prefix length
maxBitErrors = 100;    % Maximum number of bit errors
maxNumBits = 1e7;      % Maximum number of bits transmitted
ofdmMod = comm.OFDMModulator('FFTLength',numSC,'CyclicPrefixLength',cpLen);
ofdmDemod = comm.OFDMDemodulator('FFTLength',numSC,'CyclicPrefixLength',cpLen);
ofdmDims = info(ofdmMod);
numDC = ofdmDims.DataInputSize(1);
frameSize = [k*numDC 1];
%%
%5) channel
%The channel has to be modeled as awgn with SNR 10dB
channel = comm.AWGNChannel('NoiseMethod','Variance', ...
    'VarianceSource','Input port');
EbNoVec = (0:10)';
snrVec = EbNoVec + 10*log10(k) + 10*log10(numDC/numSC);

%result
berVec = zeros(length(EbNoVec),3);
errorStats = zeros(1,3);

%progess
f = waitbar(0,'Please wait...');

%%

% for m = 1:length(EbNoVec)
    m=1;
    snr = snrVec(m);
    for time = t
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %get video frame from file
        vidObj.CurrentTime=time;
        frame = readFrame(vidObj);
        %imshow(frame);
        frame=imresize(frame,[64 64]);
        A = py.numpy.array(frame(:)');
        py.qoiread.myfunc(A)
    end