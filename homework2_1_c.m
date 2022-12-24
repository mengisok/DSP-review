a1=0.1;
a2=-0.8;
i=100;

f = zeros(1, 500);
epsilon1 = zeros(1, 500);
epsilon2 = zeros(1, 500);

for j=1:1:N
    f(j)=e(i,j);
    epsilon1(j)=-a1-h(i,j,1);
    epsilon2(j)=-a2-h(i,j,2);
end

figure(3);
subplot(3,1,1);
plot([1:N],abs(fft(f)).^2);
title('f(n)');
subplot(3,1,2);
plot([1:N],abs(fft(epsilon1)).^2);
title('epsilon1(n)');
subplot(3,1,3);
plot([1:N],abs(fft(epsilon2)).^2);
title('epsilon2(n)');