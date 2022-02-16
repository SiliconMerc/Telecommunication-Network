function [mac_frame] = phy_to_mac(raw)
% PHY_TO_MAC Brief summary of this function.
% 
% Detailed explanation of this function.
%  ______________________________________________
% | Preamble  | SFD    | Length  | mac frame     |
% | 7 bytes   | 1 byte | 2 bytes | 64-1522 bytes |
% |___________|________|_________|_______________|
% from raw bits, remove the preamble and sfd and return
data=raw(8*8+1:end);
len = bi2de(data(1:16),'left-msb');
%size(data)
mac_frame=data(17:16+len);
end