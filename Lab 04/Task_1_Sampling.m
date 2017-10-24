Fs = 100;
t = [0:1/Fs:1];
max_freq = 5;
Nyquist = 2*max_freq;
At_nyquist = Fs/Nyquist;
Less_than_nyquist = Fs/(Nyquist/2);
More_than_nyquist = Fs/(3*Nyquist);

x = sin(2*pi*max_freq*t);

figure
subplot(4,1,1)
plot(x)

%At nyquist

x1 = x(2:At_nyquist:end);
subplot(4,1,2)
plot(x1)

%Less than Nyquist

x2 = x(2:Less_than_nyquist:end);
subplot(4,1,3)
plot(x2)

%More than Nyquist

x3 = x(2:More_than_nyquist:end);
subplot(4,1,4)
plot(x3)


%Qunatization

%partition = [-1:.5:1];
partition = [-1, -.5, .5, 1];
codebook = [0:3];
[out,y] = quantiz(x, partition, [-1:.5:1]);

figure
subplot(2,1,1)
plot(x)
subplot(2,1,2)
stem(y)
axis([0 100 -1 1])