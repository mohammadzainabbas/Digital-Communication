
close all                 
clear all                 
k=3;                  
len=100000;           
total_bits=len*k;        
Eb=1;                    
itr=20;                 
BER=1:itr;
BER_Raleigh=zeros(1,length(itr));
real=0;             
img=0;                
for i=1:1:itr         
    counter=0;  
    counter_Raleigh=0;
    val=10.^(i/10);
    No=1/val;
    v=(No/Eb)/(2*k);   
for n=1:1:len
    bit1=round(rand(1));           
    bit2=round(rand(1));        
    bit3=round(rand(1));        

    if(bit1==0 && bit2==0 && bit3==0)
        real=cosd(0);
        img=sind(0);
 
    elseif(bit1==0 && bit2==0 && bit3==1)
        real=cosd(45);
        img=sind(45);
        
       
     elseif(bit1==0 && bit2==1 && bit3==0)
        real=cosd(90);
        img=sind(90);
            
     elseif(bit1==0 && bit2==1 && bit3==1)
        real=cosd(135);
        img=sind(135);
               
     elseif(bit1==1 && bit2==0 && bit3==0)
        real=cosd(180);
        img=sind(180);
                
     elseif(bit1==1 && bit2==0 && bit3==1)
        real=cosd(225);
        img=sind(225);
                
     elseif(bit1==1 && bit2==1 && bit3==0)
        real=cosd(270);
        img=sind(270);
                
     elseif(bit1==1 && bit2==1 && bit3==1)
        real=cosd(315);
        img=sind(315);
               
    end
    
    AWGN1=sqrt(v)*randn(1);
    AWGN2=sqrt(v)*randn(1);
    noise_Raleigh1 = randn(1);
    noise_Raleigh2 = randn(1);
    realn_AWGN=real+AWGN1;
    imgn_AWGN=img+AWGN2;
    realn=noise_Raleigh1.*real+AWGN1;          
    imgn=noise_Raleigh2.*img+AWGN2;
    
    realn=realn./noise_Raleigh1;
    imgn=imgn./noise_Raleigh2;
    
    if(n==1)
    figure;
    scatter(realn,imgn);
    end
    
    angle_recieved_Raleigh=mod(atan2d(imgn,realn)+360,360);
    angle_recieved=mod(atan2d(realn_AWGN,imgn_AWGN)+360,360);
     
   if((angle_recieved>=0&&angle_recieved<=22.5)||(angle_recieved>337.5))
        bit_recieved1=0;
        bit_recieved2=0;
        bit_recieved3=0;
    elseif(angle_recieved>22.5&&angle_recieved<=67.5)
        bit_recieved1=0;
        bit_recieved2=0;
        bit_recieved3=1;
        
    elseif(angle_recieved>67.5&&angle_recieved<=112.5)
        bit_recieved1=0;
        bit_recieved2=1;
        bit_recieved3=0;
                  
    elseif(angle_recieved>112.5&&angle_recieved<=157.5)
        bit_recieved1=0;
        bit_recieved2=1;
        bit_recieved3=1;
               
       elseif(angle_recieved>157.5&&angle_recieved<=202.5)
        bit_recieved1=1;
        bit_recieved2=0;
        bit_recieved3=0;
                
        elseif(angle_recieved>202.5&&angle_recieved<=247.5)
        bit_recieved1=1;
        bit_recieved2=0;
        bit_recieved3=1;
               
        elseif(angle_recieved>247.5&&angle_recieved<=292.5)
        bit_recieved1=1;
        bit_recieved2=1;
        bit_recieved3=0;
                
        elseif(angle_recieved>292.5&&angle_recieved<=337.5)
        bit_recieved1=1;
        bit_recieved2=1;
        bit_recieved3=1;
                
   end

   
   if((angle_recieved_Raleigh>=0&&angle_recieved_Raleigh<=22.5)||(angle_recieved_Raleigh>337.5))
        bit_recieved1_Raleigh=0;
        bit_recieved2_Raleigh=0;
        bit_recieved3_Raleigh=0;
    elseif(angle_recieved_Raleigh>22.5&&angle_recieved_Raleigh<=67.5)
        bit_recieved1_Raleigh=0;
        bit_recieved2_Raleigh=0;
        bit_recieved3_Raleigh=1;
        
    elseif(angle_recieved_Raleigh>67.5&&angle_recieved_Raleigh<=112.5)
        bit_recieved1_Raleigh=0;
        bit_recieved2_Raleigh=1;
        bit_recieved3_Raleigh=0;
                  
    elseif(angle_recieved_Raleigh>112.5&&angle_recieved_Raleigh<=157.5)
        bit_recieved1_Raleigh=0;
        bit_recieved2_Raleigh=1;
        bit_recieved3_Raleigh=1;
               
       elseif(angle_recieved_Raleigh>157.5&&angle_recieved_Raleigh<=202.5)
        bit_recieved1_Raleigh=1;
        bit_recieved2_Raleigh=0;
        bit_recieved3_Raleigh=0;
                
        elseif(angle_recieved_Raleigh>202.5&&angle_recieved_Raleigh<=247.5)
        bit_recieved1_Raleigh=1;
        bit_recieved2_Raleigh=0;
        bit_recieved3_Raleigh=1;
               
        elseif(angle_recieved_Raleigh>247.5&&angle_recieved_Raleigh<=292.5)
        bit_recieved1_Raleigh=1;
        bit_recieved2_Raleigh=1;
        bit_recieved3_Raleigh=0;
                
        elseif(angle_recieved_Raleigh>292.5&&angle_recieved_Raleigh<=337.5)
        bit_recieved1_Raleigh=1;
        bit_recieved2_Raleigh=1;
        bit_recieved3_Raleigh=1;
                
    end
   
   
   
   
    if(bit1~=bit_recieved1)          
        counter=counter+1;
    end
    if(bit2~=bit_recieved2)         
        counter=counter+1;
    end
    if(bit3~=bit_recieved3)        
        counter=counter+1;
    end
    
    if(bit1~=bit_recieved1_Raleigh)          
        counter_Raleigh=counter_Raleigh+1;
    end
    if(bit2~=bit_recieved2_Raleigh)         
        counter_Raleigh=counter_Raleigh+1;
    end
    if(bit3~=bit_recieved3_Raleigh)        
        counter_Raleigh=counter_Raleigh+1;
    end
 
end
BER(i)=(counter/total_bits);  
BER_Raleigh(i)=(counter_Raleigh/total_bits); 
end
Eb_No=1:1:20;
% 
% semilogy(10*log10(Eb_No),BER,'--g*','linewidth',1.5,'markersize',8);
%  hold on
%  semilogy(10*log10(Eb_No),BER_Raleigh,'--','linewidth',1.5,'markersize',8);
% legend('AWGN 8 PSK','Raleigh 8 PSK');
% xlabel('SNR(dB)');
% ylabel('BER');
% grid on;
