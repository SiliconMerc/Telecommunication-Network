function [bits,err] = decapsulating_packetization (rx_frame_buff,dataSize,crcdetector)
    % 7) mac frame is extracted from the raw bits received by phy
    % use phy_to_mac.m
    recovered_mac = phy_to_mac(demodulated);
    % 8) check the accuracy using CRC.
    % use crcdetector defined above
    [msg,err]=crcdetector(recovered_mac');
    if(err~=0)
        sprintf
    end
    %%
    % 8.1) extract the Level 3 packet from mac_frame (macframe_to_L3.m)
    %mac_frame==recovered_mac
    recovered_packet= macframe_to_L3(recovered_mac);
    
end