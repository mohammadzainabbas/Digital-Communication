function Task_1()
%To generate random signal
x = random_signal();
size = length(x);
bins = input('Enter number of bins: ');

%Calculate pdf
pdf = PDF(x, bins);

%Rearranging x-axis of both so that mean appears at 0
x_axis = min(x):(max(x)-min(x))/(bins):max(x) - (max(x)-min(x))/(bins);
%x_axis = x_axis(1:size-1);         %coz no. of bins = length - 1
 
% length(x)
% length(pdf)

%Calculating mean of signal
mean = sum((x) .* pdf);

%Calculating variance of signal
variance = sum(power((x - mean),2)/(length(x)));

%To change mean and variance
y = (100)*x + 1000;
pdf_y = PDF(y, bins);
y_axis = x_axis + 1000;

%Plot
figure 
subplot(2,1,1) 
bar(x_axis,pdf)
subplot(2,1,2)
bar(y_axis,pdf_y)
end

function x = random_signal()
size = input('Enter signal size: ');
x = randn(1,size);
end


function pdf = PDF(x, bins)
pdf = hist(x,bins)/(length(x));
end