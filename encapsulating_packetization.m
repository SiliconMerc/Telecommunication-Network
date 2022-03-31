function [mac_phy_frame_buff,mac_frame_buff,packet_buff] = encapsulating_packetization (data,frameSize,crcgenerator)
    d=randi(255,1,6);%creating random packet of 6 bytes
    b = de2bi(d,'left-msb')';%converting to binary(column vector) where eight bits mean a number
    dest_addr=b(:)';

    d=randi(255,1,6);%creating random packet of 6 bytes
    b = de2bi(d,'left-msb')';%converting to binary(column vector) where eight bits mean a number
    src_addr =b(:)';
    
    packet_size=128*8;
    [Q,R]=quorem(sym(size(data,1)),sym(packet_size));
    cols=double(Q)+1;
    packet_buff=zeros(packet_size,cols);
    packet_buff(1:size(data,1))=data(:);
    
    phy_frame_buff=[];
    mac_frame_buff=[];
    for  i = 1:size(packet_buff,2);
        packet=packet_buff(:,i);
        size(packet);
%         if i==1
%             packet(1:10)
%         end
        % 5) Generate the mac frame using L3_to_macframe.m
        % The format of mac_frame:
        %  _________________________________________________________________________________________________________________________________________________
        % | Frame Control |Duration/ID   |   Address 1  |   Address 2  |   Address 3  |Sequence |Address 4 |Qos      | HT       |  Packet       | FCS or CRC|
        % | (2 bytes)     |(2 bytes)     |(6 bytes)     |(6 bytes)     |(6 bytes)     |Control  |(6 bytes) |Control  | Control  | from layer 3  | 4 bytes   |
        % |               |              |              |              |              |(2 bytes)|          |(2 bytes)| (4 bytes)| 0-7951 bytes  |           |
        % |_______________|______________|______________|______________|______________|_________|__________|_________|__________|_______________|___________|
        mac_frame = L3_to_macframe(dest_addr, src_addr, packet, crcgenerator);
        size(mac_frame);
        mac_frame_buff=[mac_frame_buff mac_frame'];
%         if i==1
%             mac_frame(1:10)
%         end
        
        % 6) The phy layer combines this frame with some extra bits:
        %  _________________________________________________________________________________________
        % |    Sync   | SFD    |  Rate    | Reserved bit |  Length   |Parity bit | Tail | mac frame |
        % | 16 bytes  | 2 byte | 4 bits   | 1 bit        |   2 byte  |  1 bit    | 6 bit|           |
        % |___________|________|__________|______________|___________|___________|______|___________|
        % relevant functions: mac_to_phy.m

        raw = mac_to_phy(mac_frame);
        %size(raw)
        %size(phy_frame_buff)
        %size(raw)
        phy_frame_buff=[phy_frame_buff raw];
    end
    size(phy_frame_buff);
    % we have to make the raw an integer multiple of frameSize , even if we
    % have to add some padding in the end
    % Total bits except Tail and Packet = 472
    [Q,R]=quorem(sym(size(phy_frame_buff,1)*size(phy_frame_buff,2)),sym(frameSize(1)));
    rows=frameSize(1);
    cols=double(Q)+1;
    mac_phy_frame_buff=zeros(rows,cols);
    mac_phy_frame_buff(1:size(phy_frame_buff,1)*size(phy_frame_buff,2))=phy_frame_buff(:);
    size(mac_phy_frame_buff);
%     mac_phy_frame_buff(1:10)
end