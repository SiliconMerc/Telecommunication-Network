function [demodulated] = demodulate(modulated, ta, ns, fc)
% DEMODULATE Brief summary of this function.
% 
% Detailed explanation of this function.
% demodulate packet
% ta = bit pulse duration
% ns = no of samples in one pulse
% fc = carrier freq
dt=ta/ns;
t = dt:dt:dt*size(modulated,2);
% multiplying modulated signal by cos(2*pi*fc*t)
sig1 = modulated .* cos(2*pi*fc*t);
% multiplying modulated signal by sin(2*pi*fc*t)
sig2 = modulated .* sin(2*pi*fc*t);
% now we will apply the filter (conv):
sig1 = conv(sig1, ones(1, ns)*dt, 'same');
sig2 = conv(sig2, ones(1, ns)*dt, 'same');
% threshold as before
sig1 = sig1 > 0;
sig2 = sig2 > 0;
%plot(t, sig1);
%plot(t, sig2);
% sample
sampling_times = ta/2:ta:dt*size(modulated, 2);
m1_reconstructed = sig1(floor(sampling_times/dt));
m1_reconstructed = m1_reconstructed > 0;
m2_reconstructed = sig2(floor(sampling_times/dt));
m2_reconstructed = m2_reconstructed > 0;
% combining them,
% odd places
m_reconstructed = [ m2_reconstructed ; m1_reconstructed]; 
% even places
m_final = m_reconstructed(:)';
demodulated=m_final;
end