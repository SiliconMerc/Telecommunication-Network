function [packet] = macframe_to_L3(mac_frame)
% MACFRAME_TO_L3 Brief summary of this function.
% 
% Detailed explanation of this function.
% The format of mac_frame:
%  __________________________________________________________________
% | Dest mac addr | src mac addr | Length of| Packet        | CRC     |
% | (6 bytes)     | (6 bytes)    | L3 packet| from layer 3  | 4 bytes |
% |               |              | 2 bytes  | 46-1500 bytes |         |
% |_______________|______________|__________|_______________|_________|
% remove extra bits and return the Layer 3 packet
data=mac_frame(12*8+1:end);
len = bi2de(data(1:16),'left-msb');
packet=(17:16+len);
end