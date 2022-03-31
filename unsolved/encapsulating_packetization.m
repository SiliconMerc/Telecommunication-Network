function [mac_frame_buff] = encapsulating_packetization (data,frameSize,crcgenerator)
    % 5) Generate the mac frame using L3_to_macframe.m
    % The format of mac_frame:
    %  _________________________________________________________________________________________________________________________________________________
    % | Frame Control |Duration/ID   |   Address 1  |   Address 2  |   Address 3  |Sequence |Address 4 |Qos      | HT       |  Packet       | FCS or CRC|
    % | (2 bytes)     |(2 bytes)     |(6 bytes)     |(6 bytes)     |(6 bytes)     |Control  |(6 bytes) |Control  | Control  | from layer 3  | 4 bytes   |
    % |               |              |              |              |              |(2 bytes)|          |(2 bytes)| (4 bytes)| 0-7951 bytes  |           |
    % |_______________|______________|______________|______________|______________|_________|__________|_________|__________|_______________|___________|
    mac_frame = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator);
    % 6) The phy layer combines this frame with some extra bits:
    %  _________________________________________________________________________________________
    % |    Sync   | SFD    |  Rate    | Reserved bit |  Length   |Parity bit | Tail | mac frame |
    % | 16 bytes  | 2 byte | 4 bits   | 1 bit        |   2 byte  |  1 bit    | 6 bit|           |
    % |___________|________|__________|______________|___________|___________|______|___________|
    % relevant functions: mac_to_phy.m
    
    raw = mac_to_phy(mac_frame);
end