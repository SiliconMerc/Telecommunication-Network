function [bits,err,recovered_mac_buff,bits_buff] = decapsulating_packetization (rx_frame_buff,dataSize,crcdetector)
    bits_buff=[];
    err=[];
    rxData=rx_frame_buff(:);
    %size(rxData,1)*size(rxData,2)
%     i = 1:2141:size(rxData,1)-2141;
%     size(1:2141:size(rxData,1)-2141)
    recovered_phy_buff=[];
    recovered_mac_buff=[];
    for  i = 1:2141:size(rxData,1)-2141;
%         rxData(1:10)
        demodulated=rxData(i:i+2141-1,1);
        recovered_phy_buff=[recovered_phy_buff demodulated];
%         demodulated(1:10)
        % 7) mac frame is extracted from the raw bits received by phy
        % use phy_to_mac.m
        recovered_mac = phy_to_mac(demodulated);
        recovered_mac_buff=[recovered_mac_buff recovered_mac];
%         recovered_mac(1:10)
        %%
        % 8.1) extract the Level 3 packet from mac_frame (macframe_to_L3.m)
        %mac_frame==recovered_mac
        [recovered_packet,error]= macframe_to_L3(recovered_mac,crcdetector);
        
        recovered_packet(1:10);
        bits_buff=[bits_buff recovered_packet];
        err=[err error];
        
%         break
    end
    size(bits_buff(:));
    dataSize;
    bits=bits_buff(1:dataSize);
end