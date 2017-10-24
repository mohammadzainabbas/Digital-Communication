function Task_2()
%To generate random signal
load('cdf.mat');

original_mean_of_signal = mean(x)
original_standard_deviation = std(x)
original_variance = var(x)


%From CDF
min_x = min(x);
max_x = max(x);

total_bins = 50 - 1;
bin_size = (max_x - min_x)/total_bins;
new_x = min(x):bin_size:max(x);

for i = 1:1:length(cdf1)
    if i == 1
        pdf_of_signal(i) = cdf1(i);
    else
        pdf_of_signal(i) = cdf1(i) - cdf1(i-1);
    
    end
end

mean_of_signal = sum((new_x).*pdf_of_signal);
variance_of_signal = sum(power((new_x - mean_of_signal),2).*pdf_of_signal)
standard_deviation = power(variance_of_signal,0.5)

end