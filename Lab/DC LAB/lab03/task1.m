a = 100;
% signal with standard deviation 100 and mean 1000
b = 1000;
y = a.*randn(1000,1) + b;
stats = [mean(y) std(y) var(y)]
hist(y,10);
pdf=hist(y,10)/1000;
% bar(y,pdf);
plot(pdf)