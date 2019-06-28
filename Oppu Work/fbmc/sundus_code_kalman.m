clear all
clc
a1=1;
a2=0;
a3=0; %needed to be calculated
p=3;

x_n=[1,2,3,1,2,3];% needed to be calculated
rn=[2,4,6,2,4,6]; %received data
[k,i]=size(rn);
h_o_o_hat=transpose(zeros(1,p));
h_n1_n_hat=transpose(zeros(1,p));
h=transpose(zeros(1,p));


Pnno=eye(p);
kno=0.5; %Initial gain k
No=.1; %noise variance

j=1;
hh=zeros(i,p);
error=zeros(i,1);% h estimation error
for j=1:1:i %assume j as n
    
 xn=transpose([x_n(j),0,0]); % matrix size changes with p
 xnt=transpose(xn);
 
if j==1
  hn_hat=h_o_o_hat;  
 Pn=Pnno;
 kn=kno;
else
    hn_hat=hn1_hat;
    S=(xnt*Pn1_n)*conj(xn);
  kn=Pn1_n*conj(xn)*inv(No+S);
  Pn=Pn1_n-(kn*xnt*Pn1_n);
end
    
    

Qn1=[0 0 0; 0 0 0;0 0 0.01]; %in article calculated through other method.
Fn=[a1,a2,a3;1,0,0;0,1,0];
h_n1_n_hat=Fn*(hn_hat);
Pn1_n=(Fn*(Pn*transpose(Fn)))+Qn1;
xe=((transpose(xn))* (h_n1_n_hat))
en=rn(j)-((transpose(xn))* (h_n1_n_hat)); %received data error
hn1_hat=h_n1_n_hat+(kn*en)

error(j,:)=en
hh(j,:)=transpose(hn1_hat)
end
