%AmirHossein Osooli           project 1            811497046
%%

clc
clear all
dx = input("your mesh:");
n = ((1/dx)+1);    
x = 0:dx:1;                                         
dt = input("your step time:");
t = 0:dt:5;
T=(5/dt)+1;
X = cell(T,n);

du = zeros(T,n);
dv = zeros(T,n);
u = zeros(T,n);
v = zeros(T,n);

%%initial condition

for i=2:(n-1)
u(1,i) = sin(pi*((i-1)*dx));                                        
end
for i=1:n                                        
v(1,i) = pi*cos(pi*((i-1)*dx));
end

%%baundary condition   

u(:,1) = 1;                                                                                      
u(:,n) = 0; 

%%Blocks

A = {};
B = {}; 
C = {}; 

for k = 1:T
                                   
A{k,1} = [0 0;1/(2*dx) -1/4];
B{k,1} = [1 0;-1/(2*dx) -1/4];
B{k,n} = [(1/(2*dt)+v(k,n)/4) (-1/(2*dx)+u(k,n)/4);1 0];
C{k,1}=[0 0;0 0];
C{k,n}=[(1/(2*dt)+v(k,n-1)/4) (1/(2*dx)+u(k,n-1)/4) ;0 0];

for j = 2:n-1
A{k,j} = [0 0;1/(2*dx) -1/4];
B{k,j} = [((1/(2*dt))+(v(k,j)/4)) ((-1/(2*dx))+(u(k,j)/4));(-1/(2*dx)) -1/4];
C{k,j} = [((1/(2*dt))+(v(k,j-1)/4)) ((1/(2*dx))+(u(k,j-1)/4)) ;0 0];
end

%%RHS

r{k,1} = [0;(((v(k,2)+v(k,1))/2)-((1/dx)*(u(k,2)-u(k,1))))];
r{k,n} = [((1/dx)*(v(k,n)-v(k,n-1)))-(((u(k,n)*v(k,n))+(u(k,n-1)*v(k,n-1)))/2);0];
for j = 2:n-1    
r{k,j} = [((1/dx)*(v(k,j)-v(k,j-1)))-(((u(k,j-1)*v(k,j-1))+(u(k,j)*v(k,j)))/2);(((v(k,j+1)+v(k,j))/2)-((1/dx)*(u(k,j+1)-u(k,j))))];
end  

%%Thomas algorithm

for j = 2:n
B{k,j} = (B{k,j} - ((C{k,j}/(B{k,j-1}))*A{k,j-1}));
r{k,j} = (r{k,j} - (C{k,j}/(B{k,j-1})*r{k,j-1}));
end
X{k,n} = (B{k,n}\r{k,n});
du(k,n) = X{k,n}(1);
dv(k,n) = X{k,n}(2);
for i=(n-1):-1:1
X{k,i} = (B{k,i}\(r{k,i} - (A{k,i}*X{k,i+1})));
du(k,i) = X{k,i}(1);
dv(k,i) = X{k,i}(2);
end
for i=1:n
u(k+1,i)  = u(k,i)+du(k,i);
v(k+1,i) = v(k,i)+dv(k,i);
end
end
%plot
 for k=1:T
x = 0:dx:1;
grid on
hold on
plot(x,u(k,:))
% plot(x,u(2,:))
% plot(x,u(5,:))
title('uniform mesh');
ylabel("u");
xlabel("x");
Mesh = dx;
Timestep = dt;
str = {'mesh =',dx,'Time step =',dt};
text(0.1,0.8,str)
end


