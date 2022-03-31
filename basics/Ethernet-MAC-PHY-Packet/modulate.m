function [modulated] = modulate(packet, ta, ns, fc)
% MODULATE Brief summary of this function.
% 
% Detailed explanation of this function.
% modulate packet
% ta = bit pulse duration
% ns = no of samples in one pulse
% fc = carrier freq
% use any modulation.
% but take care of BER and latency.
%Let's implement it
m = packet;
m = 2*m - 1;
% you can manually loop and assign the values to me and mo but this is fast
me = m(2:2:end);
mo = m(1:2:end);
% The rest code is same as QAM just the duration is halfed. only t changes
dt = ta/ns;
% time values note that instead of size of m, we have size of me which is half
t = dt:dt:ta*size(me, 2);
% lets make physical versions of m1 and m2
s1 = me(ceil(t/ta));
s2 = mo(ceil(t/ta));
%plot(t, s1);
%plot(t, s2);
% cosine part:
cosine = s1 .* cos(2*pi*fc*t);
% sine part:
sine = s2 .* sin(2*pi*fc*t);
modulated = cosine + sine;
% add noise say, with snr 18 dB
modulated = awgn(modulated, 18);
%plot(t,modulated);
end