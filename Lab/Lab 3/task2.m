x=randn(1,4000);
load('F:\7th semester\DC LAB\lab03\cdf.mat')
plot(x)
hist(x,50)
mean=sum(x)/length(x);
for i=1:length(x)
    var=sum(power((x(i)-mean),2)/length(x));
end
% for i=1:length(x)
%     sd=sqrt(var(i));
% end
pdf=hist(x,50)/2000;
minval=14.2076;
maxval=1373.6;
y=minval:((maxval-minval)/50):maxval-((maxval-minval)/50);
figure;
bar(y,pdf);
cdf=[]
for i = 1:length(pdf)
    if i==1 
        cdf(1)=pdf(1)
    else
        cdf (i)= cdf(i-1) + pdf(i)
    end
figure;
plot(cdf)
end

