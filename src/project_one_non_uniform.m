%AmirHossein Osooli           project 1            811497046
%%

clc
clear all
n = input("pleas enter your node's (odd):");
dx=[];
ER = input("pleas enter your expansion rate:");                                        
dt = input("pleas enter your step time:");
t = 0:dt:5;
T=5/dt+1;
X = cell(T,n);
dx(1) = ((1-ER)/(1-(ER^((n-1)/2))))*0.5;
du = zeros(T,n);
dv = zeros(T,n);
u = zeros(T,n);
v = zeros(T,n);

%%Blocks

A = {};
B = {}; 
C = {}; 
x=[];
%%baundary condition
for i=2:n-1
u(1,i) = sin(pi*((i-1)*dx));                                        
end
% v = diff(u);
for i=1:n                                      
v(1,i) = pi*cos(pi*((i-1)*dx));
end

u(:,1) = 0;                                                                                 
u(:,n) = 0;                                           
  
for k = 1:T
   
% if mod(n,2) == 0
% dx(1) = ((1-ER)/(1-(ER^((n-1)/2))))*0.5;
for i=1:((n/2)-1)
dx(i+1)=(dx(i)*ER);
end
dx(n-1)=dx(1);
for i=n-1:-1:((n/2)+2)
dx(i-1)=(dx(i)*ER);
end

% else

% dx(1)=(((1-(ER^((n+1)/2)))/(1-ER))+((1-(ER^((n-3)/2)))/((1-ER)*(ER^((n-3)/2))))^-1);

% for i=1:(n+1)/2
% dx(i+1)=dx(i)*ER;
% end
% dx(n-1)=dx(2);
% for i=(n-1):-1:(((n+3)/2)+1)
% dx(i-1)=(dx(i)*ER);
% end
% end
x(k,1)=0;
for i=1:n-2
x(k,i+1) = x(k,i)+dx(i);
end

%%initial condition

A{k,1} = [0 0;1/(2*dx(1)) -1/4];
B{k,1} = [1 0;-1/(2*dx(1)) -1/4];
B{k,n} = [(1/(2*dt)+v(k,n)/4) (-1/(2*dx(n-1))+u(k,n)/4);1 0];
C{k,1}=[0 0;0 0];
C{k,n}=[(1/(2*dt)+v(k,n-1)/4) (1/(2*dx(n-1))+u(k,n-1)/4) ;0 0];

for j = 2:n-1
A{k,j}= [0 0;1/(2*dx(j-1)) -1/4];
B{k,j}= [((1/(2*dt))+(v(k,j)/4)) ((-1/(2*dx(j-1)))+(u(k,j)/4));(-1/(2*dx(j-1))) -1/4];
C{k,j}=[((1/(2*dt))+(v(k,j-1)/4)) ((1/(2*dx(j-1)))+(u(k,j-1)/4)) ;0 0];
end

%%RHS

r{k,1} = [0;(((v(k,1)+v(k,2))/2)+((1/dx(1))*(u(k,1)-u(k,2))))];
r{k,n} = [(-(1/dx(n-1))*(v(k,n-1)-v(k,n)))-(((u(k,n-1)*v(k,n-1))+(u(k,n)*v(k,n)))/2);0];
for j = 2:n-1    
r{k,j} = [((-1/dx(j-1))*(v(k,j-1)-v(k,j)))-(((u(k,j-1)*v(k,j-1))+(u(k,j)*v(k,j)))/2);(((v(k,j+1)+v(k,j))/2)+((1/dx(j-1))*(u(k,j)-u(k,j+1))))];
end       
%%thomas algorithm
for j = 2:n
B{k,j} = (B{k,j} - (C{k,j}/(B{k,j-1})*A{k,j-1}));
r{k,j} = (r{k,j} - (C{k,j}/(B{k,j-1})*r{k,j-1}));
end
X{k,n} = B{k,n}\r{k,n};
du(k,n) = X{k,n}(1);
dv(k,n) = X{k,n}(2);
for i=n-1:-1:1
X{k,i} = (B{k,i}\(r{k,i} - (A{k,i}*X{k,i+1})));
du(k,i) = X{k,i}(1);
dv(k,i) = X{k,i}(2);
end
for i=1:n
u(k+1,i)  = u(k,i)+du(k,i);
v(k+1,i) = v(k,i)+dv(k,i);
end
end
for k=1:T
grid on
hold on
plot(x(k,:),u(k,:))
title('non uniform mesh');
ylabel("u");
xlabel("x");
Node = n;
Timestep = dt;
ExpansionRate = ER;
str = {'Expansion Rate =',ER,'Node =',n,'Time step =',dt};
text(0.1,0.8,str)
 end

