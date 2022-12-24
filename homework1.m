% 1.画误差性能曲面和等值曲线

% 生成网格
[h0,h1] = meshgrid(-2:0.1:4, -4:0.1:2);

% 误差函数公式
J=0.55+h0.*h0+h1.*h1+2*cos(pi/8)*h1.*h0-sqrt(2)*h0*cos(pi/10)-sqrt(2)*h1*cos(9*pi/40);

% 画误差性能曲面
figure(1);
surf(h0,h1,J); % surf()画曲面图
xlabel('h0');
ylabel('h1');
title('误差性能曲面');
colorbar;

% 画误差性能曲面的等值曲线
figure(2);
v = 0:0.1:1; % 层级
contour(h0,h1,J,v); % contour()画等高线图
xlabel('h0');
ylabel('h1');
title('误差性能曲面的等值曲线');
colorbar;

% 3.方差为0.05,均值为0的白噪音S(n)

figure(3);
n = 1:1000;
s(n) = sqrt(0.05) * randn(1,length(n)); % randn()生成白噪声
plot(s);
axis([0 1000 -1 1]);
title('方差为0.05,均值为0的白噪音S(n)');

% 4.在等值曲线上叠加最陡下降法和LMS法的H(n)轨迹曲线

% 设置初值
N = 1000; % 信号点数
n = 1:N;
x = sqrt(2)*sin(2*pi*n/16); % 输入信号
s = sqrt(0.05)*randn(1,N); % 白噪声
y = s(n) + sin(2*pi*n/16+pi/10); % 叠加白噪声后的期望输出信号
k = 2; % 滤波器阶数
delta = 0.4; % 步长

% 进行两种算法的迭代
% 最陡下降法
H1 = zeros(2,N); 
H1(:,1) = [3 -4]';
Vg = [-2.7362 -3.5320]';
Rxx = [[1 0.9239]',[0.9239 1]'];
ryx = [0.6725 0.5377]';
for i = 1 : N-1
      Vg = 2 * Rxx * H1(:,i) - 2 * ryx;
      H1(:,i+1) = H1(:,i) - 1/2 * delta * Vg;
end

% LMS算法
H2 = zeros(2,N);
h = [3 -4]';
for i = 2 : N
   u = x(i:-1:i-1);
   e = y(i) - u * h;
   h = h + delta * e * u';
   H2(:,i) = h;
end

% 画图
figure(4);
contour(h0,h1,J,v); % 画等值曲线
xlabel('h0');
ylabel('h1');
hold on;
plot(H1(1,:),H1(2,:),'g');
plot(H2(1,:),H1(2,:),'r');
title('最陡下降法和LMS法的H（n）轨迹曲线');
legend('等值曲线','最陡下降法轨迹','LMS算法轨迹');

% 5.LMS法时J(n)和e(n)波形，及迭代100次后J(n)平均值随时间n的变化曲线

clear all;
k = 2; % 滤波器阶数
delta = 0.4; % 步长
N= 500; % 信号点数
enn = zeros(1,N-k+1); % 单次J(n)=e(n)^2
en0 = zeros(1,N-k+1); % 单次e(n)
ejn = zeros(1,N-k+1,100); % 100次J(n)

% 100次
for j = 1:100
    n = 1:N;
    s=sqrt(0.05)*randn(1,N);
    y=s(n)+sin(2*pi*n/16+pi/10);
    x=sqrt(2)*sin(2*pi*n/16);
    h=[3 -4]';
    for i = k:N
        u = x(i:-1:i-1);
        en = y(i)-u*h;
        h = h + delta*en*u';  
        en0(i-k+1) = en;
        enn(i-k+1) = en^2;
        ejn(:,i-k+1,j) = en^2;
    end
end

% 计算100次后J(n)的平均值
for i = 1:N-k+1
   jn(i) = sum(ejn(1,i,:)) / 100;
end

% 画图
figure(5);
plot(enn);
title('LMS算法,单次实现下的J(n)');
figure(6);
plot(en0);
title('LMS算法,单次实现下的e(n)');
figure(7);
plot(jn);
title('LMS算法,迭代100次后的平均J(n)');

% 6.在1的等值曲线上叠加LMS法100次H(n)平均值的轨迹曲线

clear all;
N=1000; % 信号点数
k=2; % 滤波器阶数
delta=0.4; % 步长

hn1(:,1)=[3 -4]';
hh=zeros(2,N,100);

for j=1:100
    n=1:N;
    x=sqrt(2)*sin(2*pi*n/16);
    s=sqrt(0.05)*randn(1,N);
    y=s(n)+sin(2*pi*n/16+pi/10); 
    % 最陡下降法
    hn=zeros(2,N);
    hn(:,1)=[3 -4]';
    vg=[-2.7362 -3.5320]';
    Rxx=[[1 0.9239]',[0.9239 1]'];
    Ryx=[0.6725 0.5377]';
    echo off;
    for i=1:N-1 
        vg=2*Rxx*hn(:,i)-2*Ryx;
        hn(:,i+1)=hn(:,i)-1/2*delta*vg;
    end
    % LMS算法
    hm=zeros(2,N);
    h=[3 -4]';
    hm(:,1)=[3 -4]';
    for i=k:N 
        u=x(i:-1:i-1);
        en=y(i)-u*h;
        h=h+delta*en*u';
        hm(:,i)=h;
        hh(:,i,j)=h;
    end
end

% 求100次的均值
for i=1:N-k+1 
    hn1(1,i+1)=sum(hh(1,i+1,:))/100;
    hn1(2,i+1)=sum(hh(2,i+1,:))/100;
end

% 画图
figure(8);
[h0,h1]=meshgrid(-2:.1:4,-4:.1:2);
J = 0.55+h0.*h0+h1.*h1+2*cos(pi/8)*h1.*h0-sqrt(2)*h0*cos(pi/10)-sqrt(2)*h1*cos(9*pi/40);
v=0:0.1:1;
contour(h0,h1,J,v);
xlabel('h0');
ylabel('h1');
hold on;
plot(hn(1,:),hn(2,:),'r'); % 最陡下降法
plot(hn1(1,:),hn1(2,:),'b'); % LMS法100次平均轨迹
title('在1的等值曲线上叠加LMS法100次H(n)平均值的轨迹曲线');
legend('等值曲线','最陡下降法','LMS法100次平均');


