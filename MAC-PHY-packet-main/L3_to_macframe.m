function [mac_frame] = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator)
% L3_TO_MACFRAME Convert raw data to mac_frame
% dest_addr is the mac address of receiver
% src_addr is the mac address of receiver
% packet is the data received from layer 3
% crcgenerator is the crc generator object for generating and appending
% CRC code to the packet
% The format of mac_frame:
%  __________________________________________________________________
% | Dest mac addr | src mac addr | Length of| Packet        | CRC     |
% | (6 bytes)     | (6 bytes)    | L3 packet| from layer 3  | 4 bytes |
% |               |              | 2 bytes  | 46-1500 bytes |         |
% |_______________|______________|__________|_______________|_________|
% CRC is called cyclic redundancy check. It is used for checking if the
% transmission was accurate or erroneous.
% For 4-byte (32 bit) CRC calculation, use CRC32 algorithm.
len=de2bi(size(packet,2),'left-msb',16);%getting a binary column vector that is padded to 16 bits , representing the length of packet
data=[dest_addr src_addr len packet];
mac_frame = crcgenerator(data')';%packet + crc output
end