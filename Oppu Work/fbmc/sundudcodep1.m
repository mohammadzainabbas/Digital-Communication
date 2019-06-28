clear all
clc

a1=1; %needed to be calculated
p=1;
x_n=[1,2,3,1,2,3,4,2];% needed to be calculated
rn=[2,4,6,2,4,6,8,4]; %received data
[k,i]=size(rn);
h_o_o_hat=transpose(zeros(1,p));
h_n1_n_hat=transpose(zeros(1,p));
h=transpose(zeros(1,p));

Pnno=eye(p); %Gainen
kno=.1;% kalman gain
No=.001;

j=1;
hh=zeros(i,p);
error=zeros(i,1);
for j=1:1:i %assume j as n
    
 xn=transpose([x_n(j)]); 
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
    
    
Qn1=[ 0.01]; %in article calculated through other method.
Fn=[a1];
h_n1_n_hat=Fn*(hn_hat);
Pn1_n=(Fn*(Pn*transpose(Fn)))+Qn1;
xe=((transpose(xn))* (h_n1_n_hat))
en=rn(j)-((transpose(xn))* (h_n1_n_hat));
hn1_hat=h_n1_n_hat+(kn*en)

error(j,:)=en
hh(j,:)=transpose(hn1_hat)
end
