%%
% Here, we are going to simulate the message tranfer. To understand the 
% process we need to learn the basic concepts first. 
% For that go through the wikipedia of OSI MODEL: 
% <https://en.wikipedia.org/wiki/OSI_model>

% Now you are ready for the simulation implementation:

% This is the main file to sum up all the components for simulation.
% Complete all the codes below.
% We are designing only phy and mac thus we are currently ignoring 
% other things such as IP etc.

% for uniformity in judgement, ensure that your transmitted signal has
% energy equal to 1. bit duration, ta=0.2ms
% Keep number of samples per pulse (ns) around 20-25 to not cause memory
% issues or crashes.
% Ensure fc in 17kHz-20kHz

% set your parameters fc, ta etc here:
ta=0.2e-3;
fc=20e3;
ns=20;
%dt=ta/ns;
%%

% 0) The message to be transmitted is actually divided into packets by the
% layers which are above the mac layer. You are free to divide the message
% as you wish. Longer packets will make it difficult to avoid collisions.
% IEEE has recommended 46 - 1500 bytes. It can vary as per your choice.

% Declare a single packet here:
d=randi(255,1,100);%creating random packet of 100 bytes 
b = de2bi(d,'left-msb')';%converting to binary(column vector) where eight bits mean a number 
packet=b(:)';
%%
% 1) Then mac layer combines this packet with some info to make a frame:
%  __________________________________________________________________
% | Dest mac addr | src mac addr | Length of| Packet        | CRC     |
% | (6 bytes)     | (6 bytes)    | L3 packet| from layer 3  | 4 bytes |
% |               |              | 2 bytes  | 46-1500 bytes |         |
% |_______________|______________|__________|_______________|_________|
%
% You can choose any 6 byte bit seq as the addresses for the simulation.

d=randi(255,1,6);%creating random packet of 6 bytes
b = de2bi(d,'left-msb')';%converting to binary(column vector) where eight bits mean a number
dest_addr=b(:)';

d=randi(255,1,6);%creating random packet of 6 bytes
b = de2bi(d,'left-msb')';%converting to binary(column vector) where eight bits mean a number
src_addr =b(:)';

% CRC is called cyclic redundancy check. It is used for checking if the
% transmission was accurate or erroneous.
% For 4-byte (32 bit) CRC calculation, use CRC32 algorithm.

% 1.1) Use comm.CRCGenerator with a 32 degree polynomial (Check Docs!)
% Generate a CRC generator object and pass it to the function
% This object is necessary because CRC values are not unique.

% Use this for th polynomial:
% 'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1'

poly='z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1';
crcgenerator=comm.CRCGenerator(poly);
% 1.2) After generating a CRCGenerator above, create a CRCDetector Object for
% error detection here.
crcdetector=comm.CRCDetector(poly);
% 1.3) Generate the mac frame using L3_to_macframe.m
%mac_frame = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator)
mac_frame = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator);

%%
% 2) The phy layer combines this frame with some extra bits:
%  ______________________________________________
% | Preamble  | SFD    | Length  | mac frame     |<---Interpacket Gap--->
% | 7 bytes   | 1 byte | 2 bytes | 64-1522 bytes | time delay bw packets
% |___________|________|_________|_______________|

% relevant functions: mac_to_phy.m
raw = mac_to_phy(mac_frame);
%%
% 3) Before transmission, the sender checks if the channel is in use. To do
% that send a dummy message

% 3.1) generate a dummy message of 8 bits.
dummy=randi([0,1],1,8);

% 3.2) apply CRC. Use the object generated above
codeword=crcgenerator(dummy')';

% 3.3) modulate the message. use function modulate.m
modulated= modulate(codeword, ta, ns, fc);

% 3.4) Now receiving ths signal, use demodulate.m
demodulated= demodulate(modulated, ta, ns, fc);

% 3.5) Check if error occured by using comm.CRCDetector
[msg,err]=crcdetector(demodulated');
err
%%

% 4) If no errors, the packet is modulated and transmitted
% use modulate.m

%if(err==0)
%then
%end
modulated= modulate(raw, ta, ns, fc);
% 5) receiver receives the packet, demodulates it. rejects if the message
% was not addressed to it.
% use demodulate.m
demodulated= demodulate(modulated, ta, ns, fc);
%%

% 7) mac frame is extracted from the raw bits received by phy
% use phy_to_mac.m
recovered_mac = phy_to_mac(demodulated);
% 8) check the accuracy using CRC.
% use crcdetector defined above
[msg,err]=crcdetector(recovered_mac');
%%
% 8.1) extract the Level 3 packet from mac_frame (macframe_to_L3.m)
%mac_frame==recovered_mac
recovered_packet= macframe_to_L3(recovered_mac);
%%

% 9) If correct message received, send ACK else NACK from the receiver.
% ack is the 7 bit sequence 000 0110
% nack is the 7 bit sequence 001 0101
% use modulate.m
ack=[0 0 0 0 1 1 0];
nack=[0 0 1 0 1 0 1];

if(err==0)
    mod_cnfrm= modulate([0 ack], ta, ns, fc);
else
    mod_cnfrm= modulate([0 nack], ta, ns, fc);
end
% 10) sender receives the acknowledgement.
% use demodulate.m
%all([1,1,1,1,1])
received_cnfrm = demodulate(mod_cnfrm, ta, ns, fc)
if(all(received_cnfrm(2:8)==ack))
    fprintf ( "Success");    
elseif(all(received_cnfrm(2:8)==nack))
    fprintf ( "Fail");    
end