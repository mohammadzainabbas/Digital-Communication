packet1=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet1_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet2=[1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1 1 1 1 0 0 0];
% packet2_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet3=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 1 0 0];
% packet3_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 1 1 1 0 0 1 0 1 1 0 0 0];
% 
% packet4=[1 1 0 1 1 1 0 0 0 0 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% packet4_recieved=[0 1 1 0 0 1 1 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet5=[0 1 1 1 0 1 0 1 0 1 1 1 0 1 1 1 1 1 1 0 0 1 1 1 1 0 0 0];
% packet5_recieved=[0 1 1 0 0 0 0 1 0 1 0 0 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet6=[0 1 1 1 0 1 0 1 0 0 0 1 0 1 1 1 0 1 1 1 0 1 1 1 1 0 0 0];
% packet6_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet7=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% packet7_recieved=[0 1 1 0 0 1 1 1 0 1 0 1 0 0 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet8=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% packet8_recieved=[0 1 1 0 0 1 0 0 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet9=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% packet9_recieved=[0 1 1 0 1 1 1 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% 
% packet10=[0 0 0 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
% packet10_recieved=[0 1 1 0 1 1 1 1 0 1 0 0 0 0 1 1 0 1 1 0 0 1 1 1 1 0 0 0];


packet_send_2=[packet1,packet1];
packet_send_4=[packet1,packet1,packet1,packet1];
packet_send_6=[packet1,packet1,packet1,packet1,packet1,packet1];
packet_send_8=[packet1,packet1,packet1,packet1,packet1,packet1,packet1,packet1];
packet_send_10=[packet1,packet1,packet1,packet1,packet1,packet1,packet1,packet1,packet1,packet1];

packet_recieved_2=[packet1_recieved,packet1_recieved];
packet_recieved_4=[packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved];
packet_recieved_6=[packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved];
packet_recieved_8=[packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved];
packet_recieved_10=[packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved,packet1_recieved];




Efficiency1=(sum(xor(packet_send_2,packet_recieved_2))/length(packet_send_2));
Efficiency2=(sum(xor(packet_send_4,packet_recieved_4))/length(packet_send_4));
Efficiency3=(sum(xor(packet_send_6,packet_recieved_6))/length(packet_send_6));
Efficiency4=(sum(xor(packet_send_8,packet_recieved_8))/length(packet_send_8));
Efficiency5=(sum(xor(packet_send_10,packet_recieved_10))/length(packet_send_10));

% Efficieny=[Efficiency1,Efficiency2,Efficiency3,Efficiency4,Efficiency5];
% k=0:2:9;
% plot(k,Efficieny);
