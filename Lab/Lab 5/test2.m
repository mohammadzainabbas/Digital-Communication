packet1=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet1_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet2=[1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1 1 1 1 0 0 0];
packet2_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet3=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 1 0 0];
packet3_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 1 1 1 0 0 1 0 1 1 0 0 0];

packet4=[1 1 0 1 1 1 0 0 0 0 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet4_recieved=[0 1 1 0 0 1 1 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet5=[0 1 1 1 0 1 0 1 0 1 1 1 0 1 1 1 1 1 1 0 0 1 1 1 1 0 0 0];
packet5_recieved=[0 1 1 0 0 0 0 1 0 1 0 0 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet6=[0 1 1 1 0 1 0 1 0 0 0 1 0 1 1 1 0 1 1 1 0 1 1 1 1 0 0 0];
packet6_recieved=[0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet7=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet7_recieved=[0 1 1 0 0 1 1 1 0 1 0 1 0 0 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet8=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet8_recieved=[0 1 1 0 0 1 0 0 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet9=[0 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet9_recieved=[0 1 1 0 1 1 1 1 0 1 0 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];

packet10=[0 0 0 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0];
packet10_recieved=[0 1 1 0 1 1 1 1 0 1 0 0 0 0 1 1 0 1 1 0 0 1 1 1 1 0 0 0];


packet_send_2=[packet1,packet2];
packet_send_4=[packet1,packet2,packet3,packet4];
packet_send_6=[packet1,packet2,packet3,packet4,packet5,packet6];
packet_send_8=[packet1,packet2,packet3,packet4,packet5,packet6,packet7,packet9];
packet_send_10=[packet1,packet2,packet3,packet4,packet5,packet6,packet7,packet8,packet9,packet10];

packet_recieved_2=[packet1_recieved,packet2_recieved];
packet_recieved_4=[packet1_recieved,packet2_recieved,packet3_recieved,packet4_recieved];
packet_recieved_6=[packet1_recieved,packet2_recieved,packet3_recieved,packet4_recieved,packet5_recieved,packet6_recieved];
packet_recieved_8=[packet1_recieved,packet2_recieved,packet3_recieved,packet4_recieved,packet5_recieved,packet6_recieved,packet7_recieved,packet8_recieved];
packet_recieved_10=[packet1_recieved,packet2_recieved,packet3_recieved,packet4_recieved,packet5_recieved,packet6_recieved,packet7_recieved,packet8_recieved,packet9_recieved,packet10_recieved];




Error1=sum(xor(packet_send_2,packet_recieved_2));
Error2=sum(xor(packet_send_4,packet_recieved_4));
Error3=sum(xor(packet_send_6,packet_recieved_6));
Error4=sum(xor(packet_send_8,packet_recieved_8));
Error5=sum(xor(packet_send_10,packet_recieved_10));

 Efficiency1=(length(packet_send_2)-Error1)/length(packet_send_2);
 Efficiency2=(length(packet_send_4)-Error2)/length(packet_send_4);
 Efficiency3=(length(packet_send_4)-Error3)/length(packet_send_6);
 Efficiency4=(length(packet_send_4)-Error4)/length(packet_send_8);
 Efficiency5=(length(packet_send_4)-Error5)/length(packet_send_10);

Efficieny=[Efficiency1,Efficiency2,Efficiency3,Efficiency4,Efficiency5];
k=0:2:9;
figure;
plot(k,Efficieny);
title('Relation between Efficieny and no of packets');
xlabel('No of Packets') % x-axis label
ylabel('Efficiency') % y-axis label

Relaibility1=(sum(~xor(packet_send_2,packet_recieved_2))/length(packet_send_2))*10;
Relaibility2=(sum(~xor(packet_send_4,packet_recieved_4))/length(packet_send_4))*10;
Relaibility3=(sum(~xor(packet_send_6,packet_recieved_6))/length(packet_send_6))*10;
Relaibility4=(sum(~xor(packet_send_8,packet_recieved_8))/length(packet_send_8))*10;
Relaibility5=(sum(~xor(packet_send_10,packet_recieved_10))/length(packet_send_10))*10;

Relaibility=[Relaibility1,Relaibility2,Relaibility3,Relaibility4,Relaibility5];

figure;
bar(k,Relaibility);
title('Relation between Relaibility and no of Terminals');
xlabel('Terminals') % x-axis label
ylabel('Relaibility') % y-axis label

cons_Efficiency=[0.09,0.13,0.15,0.17,0.18,0.17,0.15,0.11];
Erasure_Probability=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8];

cons2_Efficiency=[0.055,0.085,0.11,0.11,0.10,0.086,0.081,0.075];

figure;
plot(Erasure_Probability,cons_Efficiency);
hold on
plot(Erasure_Probability,cons2_Efficiency);

title('Relation between Efficiency and Erasure_Probability');
xlabel('Erasure Probability') % x-axis label
ylabel('Efficiency') % y-axis label

Eff=[0.33,0.17,0.1,0.06];
Ideal_Eff=[0.25,0.13,0.08,0.049];
ter=[3,4,5,6];
figure;
plot(ter,Eff);
hold on
plot(ter,Ideal_Eff);

title('Relation between Efficiency and no of terminals');
xlabel('no of terminals') % x-axis label
ylabel('Efficiency') % y-axis label




