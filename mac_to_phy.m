function [raw] = mac_to_phy(mac_frame)
% MAC_TO_PHY Wait for it.
%  _________________________________________________________________________________________
% |    Sync   | SFD    |  Rate    | Reserved bit |  Length   |Parity bit | Tail | mac frame |
% | 16 bytes  | 2 byte | 4 bits   | 1 bit        |   2 byte  |  1 bit    | 6 bit|           |
% |___________|________|__________|______________|___________|___________|______|___________|
% make a phy packet from the mac frame.
% use these for preamble and sfd:
% preamble is just an alternating sequence of 1 and 0's for synchronization
% sfd is start frame delimeter, indicates the starting of the frame.
% sfd is also an alternating sequence of 1's and 0's but with the last bit 1.
% Rate: this field over 4 bits indicates the actual data rate
% Length: indicates the size of the frame, protected by a convolution code.
%Parity bit and reserved bit: bit 4 is reserved for future use and is set to 0. The parity bit applies to the first 16 bits of the “signal” field(Rate+Reserved+Length+Parity+Tail) to protect them against errors.
%Tail: end field over 6 bits (000000).
preamble = mod((1:56),2);
sfd = [mod(1:7, 2) 1];
len=de2bi(size(mac_frame,2),'left-msb',16);%row vector padded to 16 bits which is equal to length of mac_frame
raw=[preamble sfd len mac_frame];
end