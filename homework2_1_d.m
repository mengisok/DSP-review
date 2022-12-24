emean=mean(e.^2);   
emean(1)=1;
emean(2)=1;

[V D]=eig([1,-0.5;-0.5,1]);
gama=[0.5;1.5];
v1=V'*[-0.1;0.8]
v1=v1.^2;

for i=1:N
    J(i)=0.27+gama'*v1;
    v1=(eye(2)-2*delta*D+delta^2*gama*gama')*v1+delta^2*0.27*gama;
end

figure(4);
plot([1:N],emean(1:N),[1:N],J)