function main()
t = [0:.01:1];
number_of_samples = length(t);
%freq = input('Enter your frequency: ');
freq = 1;
%x = sin(2*pi*freq*t);
x = randn(1,100);
bins = input('Enter number of bins: ');
%hist = histogram(x, bins);

histogram(x,bins);
interval = (max(x)-min(x))/(bins);

hist_x_axis = [min(x):interval:max(x)];
hist = zeros(1, bins);
for i = 1:bins
    if i == bins
          hist(i) = length(find(x >= hist_x_axis(i) & x <= hist_x_axis(i+1)));
          continue;
    end
    hist(i) = length(find(x >= hist_x_axis(i) & x < hist_x_axis(i+1)));
end

PDF = hist/number_of_samples;
%plot(hist_y_axis);

CDF = zeros(1, bins);
CDF(1) = PDF(1);

for i = 2:bins
    CDF(i) = CDF(i-1)+PDF(i); 
end
figure
title('Histogram by loop')
bar(hist)
figure
title('PDF')
bar(PDF)
figure
title('CDF')
bar(CDF)
%plot(hist.Data)
end
