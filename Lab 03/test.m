function test()
a=randn(1,2000);
a=a*100;
a=a+1000;

a_mean=sum(a)/length(a);
a_var=0;
for i=1:1:2000
    a_var=a_var+( power((a(i)-a_mean),2)/length(a) );
end
sd=power(a_var,0.5);
display('Mean: ' + a_mean);
display('SD: ' + a_var);
end