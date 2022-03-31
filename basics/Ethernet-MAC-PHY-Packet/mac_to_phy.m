function [raw] = mac_to_phy(mac_frame)
% MAC_TO_PHY Wait for it.
%  ______________________________________________
% | Preamble  | SFD    | Length  | mac frame     |
% | 7 bytes   | 1 byte | 2 bytes | 64-1522 bytes |
% |___________|________|_________|_______________|
% make a phy packet from the mac frame.
% use these for preamble and sfd:
% preamble is just an alternating sequence of 1 and 0's for synchronization
% sfd is start frame delimeter, indicates the starting of the frame.
% sfd is also an alternating sequence of 1's and 0's but with the last bit
% 1.
preamble = mod((1:56),2);
sfd = [mod(1:7, 2) 1];
len=de2bi(size(mac_frame,2),'left-msb',16);%row vector padded to 16 bits which is equal to length of mac_frame
raw=[preamble sfd len mac_frame];
end