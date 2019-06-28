function task3_part2()
a=audiorecorder;
disp('start speaking')
recordblocking(a,2);
disp('end of speaking')
x=getaudiodata(a);
subplot(4,1,1)
stem(x)
title('original signal')
%sampling
x=x(1:length(x)/200:length(x));
x=transpose(x);
subplot(4,1,2)
stem(x)
title('sampled signal')
%non_uniform quantization using mu law
comp=compand(x,10,max(x),'mu/compressor');
step_size=(max(comp)-min(comp))/16;
p_vector=min(comp):step_size:max(comp)-step_size;
code_book=min(comp):step_size:max(comp);
[index,quant]=quantiz(comp,p_vector,code_book);
exp=compand(quant,10,max(quant),'mu/expander');
subplot(4,1,3)
stem(exp)
title('non uniform quantized using mu law')
%bit error rate for non uniform quantization(mu)
non_uni_quan_error=x-exp;
error=sum(non_uni_quan_error);
disp('non uniform quantization error(mu)')
error=abs(error)
%non_uniform quantization using A law
comp1=compand(x,10,max(x),'A/compressor');
step_size=(max(comp1)-min(comp1))/16;
p_vector=min(comp1):step_size:max(comp1)-step_size;
code_book=min(comp1):step_size:max(comp1);
[index,quant1]=quantiz(comp1,p_vector,code_book);
exp1=compand(quant1,10,max(quant1),'A/expander');
subplot(4,1,4)
stem(exp1)
title('non uniform quantized using A law')
%bit error rate for non uniform quantization
non_uni_quan_error1=x-exp1;
error=sum(non_uni_quan_error1);
disp('non uniform quantization error(A)')
error1=abs(error)
end