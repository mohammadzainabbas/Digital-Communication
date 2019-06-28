function main()
%Task No. 01

%Generate 2 random signal
[x1,size1] = random_signal();
[x2,size2] = random_signal();

%Calculate pdfs of both
[pdf1, bins1] = PDF(x1);
[pdf2, bins2] = PDF(x2);

%Rearranging x-axis of both so that mean appears at 0
x1_axis = min(x1):(max(x1)-min(x1))/(bins1):max(x1);
x1_axis = x1_axis(1:size1);         %coz no. of bins = length - 1

x2_axis = min(x2):(max(x2)-min(x2))/(bins2):max(x2);
x2_axis = x2_axis(1:size2);

% %plot both signals
% figure
% subplot(2,1,1)
% bar(x1_axis,pdf1);
% subplot(2,1,2)
% bar(x2_axis,pdf2);


%Task No. 02

%We already have both the signals x1 and x2, so don't need to generate them

%Calculating mean of both signals
mean1 = sum((x1) .* pdf1);
mean2 = sum((x2) .* pdf2);

%Calculating variance of both signals
variance1 = sum(power((x1 - mean1),2)/(length(x1)))
variance2 = sum(power((x2 - mean2),2)/(length(x2)))

% %Ploting PDFs of both
% figure
% subplot(2,1,1)
% bar(x1_axis,pdf1);
% subplot(2,1,2)
% bar(x2_axis,pdf2);

%Chaning mean of signal x2 from 0 to 300 and -300

new1_x2 = x2 + 300;
new2_x2 = x2 - 300;

figure 
subplot(3,1,1) 
bar(x2_axis,pdf2)
subplot(3,1,2)
bar(x2_axis,PDF(new1_x2)[1])
subplot(3,1,3)
bar(x2_axis,PDF(new2_x2)[1])

end

function [x, size] = random_signal()
size = input('Enter signal size: ');
x = randn(1,size);
end

function [pdf, bins] = PDF(x)
bins = input('Enter number of bins: ');
pdf = hist(x,bins)/(length(x));
end