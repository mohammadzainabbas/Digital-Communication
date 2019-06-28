function quantization()
t=0:0.001:2;
fm=10;
x=sin(2*pi*fm*t);
subplot(2,1,1)
plot(t,x)
title('original Signal')
no_of_levels=16;
step_size=(max(x)-min(x))/16;
p_vector=min(x):step_size:max(x)-step_size;
code_book=min(x):step_size:max(x);
[index,quant]=quantiz(x,p_vector,code_book);
subplot(2,1,2)
stem(t,quant);
title('Quantized Signal')
%binary codes
codes=[dec2bin(index)]
end