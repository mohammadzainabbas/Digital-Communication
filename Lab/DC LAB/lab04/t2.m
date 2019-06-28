pi=3.14;
Fs=100;
F = 3;
t=(0:1/Fs:1);
x=sin(2*pi*F*t);
figure
subplot(2,1,1)
plot(x)
partition=min(x):((max(x)-min(x))/16):max(x)-((max(x)-min(x))/16);
codebook=min(x):((max(x)-min(x))/16):max(x);
% quants contains the rounded numbers, and index tells which quantization level each number is in.
[index,quants] = quantiz(x,partition,codebook);
subplot(2,1,2)
stem(t,quants)
% plot(t,x,'o',t,quants,'.')
% legend('Original signal','Quantized signal');

