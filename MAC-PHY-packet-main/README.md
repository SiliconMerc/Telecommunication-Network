# MAC-PHY-packet
Your goal is to design an acoustics based (audio signals used for transmission) communication stack: PHY and basic MAC for sending and receiving information between these two devices. You are free to use any modulation techniques, and also use frequencies above 16kHz in the inaudible band to avoid collisions with ambient sounds. The devices can send and receive until 21-22 kHz. Tweak with the modulation techniques, or introduce other compression algorithms to lower the bit error rate and latency.

0) The message to be transmitted is actually divided into packets by the layers which are above the mac layer.

1) Then mac layer combines this packet with some info to make a frame:

| Dest mac addr | src mac addr | Length of  L3 packet | Packet from layer 3 | CRC     |
| ------------- | ------------ | -------------------- | ------------------- | ------- |
| (6 bytes)     | (6 bytes)    | 2 bytes              | 46-1500 bytes       | 4 bytes |

2) The phy layer combines this frame with some extra bits:

| Preamble | SFD    | Length  | mac frame     | <---Interpacket Gap---> |
| -------- | ------ | ------- | ------------- | ----------------------- |
| 7 bytes  | 1 byte | 2 bytes | 64-1522 bytes | time delay bw packets   |

3) Before transmission, the sender checks if the channel is in use. To do that send a dummy message

4) If no errors, the packet is modulated and transmitted use modulate.m

5) receiver receives the packet, demodulates it. rejects if the message was not addressed to it.

 7) mac frame is extracted from the raw bits received by phy use phy_to_mac.m

8) check the accuracy using CRC. use crcdetector defined above

9) If correct message received, send ACK else NACK from the receiver.  ack is the 7 bit sequence 000 0110  nack is the 7 bit sequence 001 0101  use modulate.m

10) sender receives the acknowledgement. use demodulate.m

Have fun !!

