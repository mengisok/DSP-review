a1 = 0.1;
a2 = -0.8;
delta = 0.05;
N = 500;

v = zeros(100, 500);
x = zeros(100, 1000);

for i = 1:100
    whi = sqrt(0.27) * randn(1,N);
    v(i,1) = whi(1);
    v(i,2) = whi(2);
    x(i,1) = whi(1) + v(i,1);
    x(i,2) = -a1*x(1) + v(i,2);
    for j = 3:1:N
        v(i,j) = whi(j);
        x(i,j) = -a1*x(i,j-1) - a2*x(i,j-2) + v(i,j); 
    end
end

h = zeros(100,N,2);
e = zeros(100, 500);

for i = 1:1:100
    e(i,1) = x(i,1);
    h(i,1,1) = 0;
    h(i,1,2) = 0;
    e(i,2) = x(i,2) - h(i,1,1)*x(i,1);
    h(i,2,1) = h(i,1,1) + delta*e(i,2)*x(i,1);
    h(i,2,2) = h(i,1,2);
    for j = 3:1:N
        e(i,j) = x(i,j) - h(i,j-1,1)*x(i,j-1) - h(i,j-1,2)*x(i,j-2);
        h(i,j,1) = h(i,j-1,1) + delta*e(i,j)*x(i,j-1);
        h(i,j,2) = h(i,j-1,2) + delta*e(i,j)*x(i,j-2);
    end
end

a1 = zeros(1, 500);
a2 = zeros(1, 500);

for j = 1:1:N
    a1(j) = 0;
    a2(j) = 0;
    for i = 1:1:100
        a1(j) = a1(j) + h(i,j,1);
        a2(j) = a2(j) + h(i,j,2);
    end
    a1(j) = a1(j)/100;
    a2(j) = a2(j)/100;
end

figure(2);
plot(a1,'b')
hold on;
plot(a2,'m')
legend('a1','a2')


