x=randn(1,2000);
plot(x)
hist(x,5)
mean=sum(x)/length(x);
for i=1:length(x)
    var=sum(power((x(i)-mean),2)/length(x));
end
pdf=hist(x,5)/2000;
y=min(x):((max(x)-min(x))/5):max(x)-((max(x)-min(x))/5);
figure;
bar(y,pdf);
y1=x+300
y2=x-300;
mean1=sum(y)/length(y);
figure;
hist(y1,5)
for i=1:length(x)
    var1=(sum(power((x(i)-mean),2)/length(x)))*10000;
end
for i=1:length(x)
    var2=(sum(power((x(i)-mean),2)/length(x)))*50000;
end


