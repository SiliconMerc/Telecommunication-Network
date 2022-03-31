function [mac_frame] = phy_to_mac(raw)
% PHY_TO_MAC Brief summary of this function.
% 
% Detailed explanation of this function.
%  _________________________________________________________________________________________
% |    Sync   | SFD    |  Rate    | Reserved bit |  Length   |Parity bit | Tail | mac frame |
% | 16 bytes  | 2 byte | 4 bits   | 1 bit        |   2 byte  |  1 bit    | 6 bit|           |
% |___________|________|__________|______________|___________|___________|______|___________|
% from raw bits, remove everything and return mac frame
data=raw(8*8+1:end);
len = bi2de(data(1:16),'left-msb');
%size(data)
mac_frame=data(17:16+len);
end