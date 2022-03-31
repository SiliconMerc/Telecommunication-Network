function [mac_frame] = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator)
% L3_TO_MACFRAME Convert raw data to mac_frame in 802.11
% FC tells info about the type of frame
% Duration is 4 bytes long field which contains the value indicating the period of time in which the medium is occupied(in µs). A  "single" OFDM symbol with a time duration of 4 us.
% Address1 Receiver address, specified as a 12-element character vector or a string scalar representing a six-octet hexadecimal value. The default value, 'FFFFFFFFFFFF', is a broadcast address.
% Address 2 Transmitter address, specified as a 12-element character vector or a string scalar representing a six-octet hexadecimal value.
% Address 3 Basic service set identifier (BSSID), destination address (DA), or source address (SA), specified as a 12-element character vector or a string scalar representing a six-octet hexadecimal value.
% Sequence Control Frame sequence number, specified as an integer in the interval [0, 4095].
% Address 4 SA or BSSID, specified as one of these values. '00123456789B' (default)
% Qos(Quality of Service) Contorl 16-bit field that identifies the Quality of Service (QoS) parameter of a data frame (only in data frame type QoS-Data).
% HT(High Throughput) control field of the MAC header,'00000000' (default)  specified as an eight-element character vector or a string scalar representing a four-octet hexadecimal value. The leftmost byte in HTControl must be the most significant byte.
% packet is the data received from layer 3
% crcgenerator is the crc generator object for generating and appending
% CRC code to the packet
% The format of mac_frame:
%  _________________________________________________________________________________________________________________________________________________
% | Frame Control |Duration/ID   |   Address 1  |   Address 2  |   Address 3  |Sequence |Address 4 |Qos      | HT       |  Packet       | FCS or CRC|
% | (2 bytes)     |(2 bytes)     |(6 bytes)     |(6 bytes)     |(6 bytes)     |Control  |(6 bytes) |Control  | Control  | from layer 3  | 4 bytes   |
% |               |              |              |              |              |(2 bytes)|          |(2 bytes)| (4 bytes)| 0-7951 bytes  |           |
% |_______________|______________|______________|______________|______________|_________|__________|_________|__________|_______________|___________|
% CRC is called cyclic redundancy check. It is used for checking if the
% transmission was accurate or erroneous.
% For 4-byte (32 bit) CRC calculation, use CRC32 algorithm.
len=de2bi(size(packet,2),'left-msb',16);%getting a binary column vector that is padded to 16 bits , representing the length of packet
data=[dest_addr src_addr len packet];
mac_frame = crcgenerator(data')';%packet + crc output
end