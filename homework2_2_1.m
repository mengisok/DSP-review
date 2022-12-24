clear all
clc

n=[0:1:9];

r1=0.5*cos(0.05*pi*n);

r2=zeros(10,1);
r2(1)=6;
r2(2)=4;
r2(3)=1;

figure(1)
scatter(n,r1,'b')
hold on
scatter(n,r2,'m')
legend('x1(n)的自相关函数','x2(n)的自相关函数')
hold off