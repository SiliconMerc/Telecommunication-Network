function [packet] = macframe_to_L3(mac_frame)
% MACFRAME_TO_L3 Brief summary of this function.
% 
% Detailed explanation of this function.
% The format of mac_frame:
%  _________________________________________________________________________________________________________________________________________________
% | Frame Control |Duration/ID   |   Address 1  |   Address 2  |   Address 3  |Sequence |Address 4 |Qos      | HT       |  Packet       | FCS or CRC|
% | (2 bytes)     |(2 bytes)     |(6 bytes)     |(6 bytes)     |(6 bytes)     |Control  |(6 bytes) |Control  | Control  | from layer 3  | 4 bytes   |
% |               |              |              |              |              |(2 bytes)|          |(2 bytes)| (4 bytes)| 0-7951 bytes  |           |
% |_______________|______________|______________|______________|______________|_________|__________|_________|__________|_______________|___________|
% remove extra bits and return the Layer 3 packet
end