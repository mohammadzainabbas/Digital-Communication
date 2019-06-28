function task1()
x = randn(1,20);
x1 = randn(1,2000);

hist(x,10);
figure;
hist(x1,10);
y=min(x):((max(x)-min(x))/10): max(x)-(((max(x)-min(x))/10));
pdf=hist(x,10)/20;
bar(y,pdf);

y1=min(x1):((max(x1)-min(x1))/10): max(x1)-(((max(x1)-min(x1))/10));
pdf=hist(x1,10)/2000;
bar(y1,pdf);

a=mean(x)
a1=mean(x1)
v=var(x);
v1=var(x1);

