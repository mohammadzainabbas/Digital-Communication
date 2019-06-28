function task3_part1()
a=audiorecorder;
disp('start speaking')
recordblocking(a,2);
disp('end of speaking')
x=getaudiodata(a);
subplot(5,1,1)
stem(x)
title('original signal')
%sampling
x=x(1:length(x)/200:length(x));
x=transpose(x);
subplot(5,1,2)
stem(x)
title('sampled signal')
%uniform quantization on signal
step_size=(max(x)-min(x))/16;
p_vector=min(x):step_size:max(x)-step_size;
code_book=min(x):step_size:max(x);
[index,uni_quant]=quantiz(x,p_vector,code_book);
subplot(5,1,3)
stem(uni_quant)
title('uniform quantized')
%bit error rate for uniform quantization
uni_quan_error=x-uni_quant;
error_u=sum(uni_quan_error);
disp('uniform quantization error')
error_u=abs(error_u)
%non_uniform quantization
comp=compand(x,10,max(x),'mu/compressor');
subplot(5,1,4)
stem(comp)
title('Companded signal')
step_size=(max(comp)-min(comp))/16;
p_vector=min(comp):step_size:max(comp)-step_size;
code_book=min(comp):step_size:max(comp);
[index,quant]=quantiz(comp,p_vector,code_book);
exp=compand(quant,10,max(quant),'mu/expander');
subplot(5,1,5)
stem(exp)
title('non uniform quantized')
%bit error rate for non uniform quantization
non_uni_quan_error=x-exp;
error=sum(non_uni_quan_error);
disp('non uniform quantization error')
error=abs(error)
end