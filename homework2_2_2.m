% 产生一个x(n)序列
len = 1000; 
time_n = 1:len;
en =  0.01*randn(1,len); 
phi = 2 * pi * rand(1);
x1 = sin(0.05 * pi * time_n + phi);
x2 = zeros([1,len]);
x2(1,1) = en(1,1);
x2(1,2) = en(1,2) + 2 * en(1,1);

for i = 3:len
    x2(1,i) = en(1,i) + 2* en(1,i-1) + en(1,i-2);
end

% LMS
x = x1 + x2;
sigma = 0.005;
error_n = zeros([1,len]);
H = zeros([2,len]); 

error_n(4) = x(4) - (H(:,3))' * [x(1);0];
H(:,4) = H(:,3) + sigma * error_n(4) * [x(1);0];

for iter_time = 5:len
    error_n(iter_time) = x(iter_time) - (H(:,iter_time - 1))' * [x(iter_time - 3);x(iter_time - 4)];
    H(:,iter_time) = H(:,iter_time - 1) + sigma * error_n(iter_time) * [x(iter_time - 3);x(iter_time - 4)];
end

h1 = H(1,len);
h2 = H(2,len);
output_y = zeros(1,len);
for n = 5:len
    output_y(1,n) = h1 * x(1,n-3) + h2 * x(1,n-4);
end
error_signal = x - output_y;

% 画图
plot(100:500,x(1,100:500),'r',100:500,output_y(1,100:500),'b');
legend('x(n)','y(n)');