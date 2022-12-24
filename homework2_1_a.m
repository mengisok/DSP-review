clear all
clc

b = [-0.1 0.8];
n = 1:500;
v = sqrt(0.27)*randn(1,length(n));
x = filter(b,1,v);
v1 = sqrt(0.27)*randn(1,length(n));
x1 = filter(b,1,v1);

figure(1)
plot(n, x, 'b')
hold on
plot(n, x1, 'm')
legend('x(n) 1st', 'x(n) 2nd')
xlabel('n')
ylabel('x(n)')
title('x(n) process')
axis tight

