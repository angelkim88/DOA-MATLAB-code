 % Min-Norm AOA estimation for a M = 6 element array with noise variance = .1 
clc
clear all
 
M=20; 
D = 1;  % number of signals 
sig2=.1; 
th1=20; 
temp=zeros(1,M-1);
II=eye(M);
u1=II(:,1);
spacing=0.5; % lambda/2 센서 사이의 간격
S=[1]; % 신호원

% 등간 원형 어레이(ULA)의 Steering Vector
A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180)); 

R_hat=(A*S*(conj(A).')) + sig2*eye(M);

[V,D]=eig(R_hat); 
N=V(:,1:M-D);      % calculate the noise subspace matrix of eigenvectors 
 
for k=1:180; 
   th(k)=(-90+k)*pi/180; % -90 ~ 90

   
   for jj=2:M 
      % 정합된 공간 필터
      Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
  end 
   
P(k)=1./abs( (conj(Aw).')*N*N'*u1 ).^2;  
 
end 
figure; 
plot(th*180/pi,10*log10(P/max(P)),'k') 
grid on 
xlabel('Angle') 
ylabel('|P(\theta)|') 
axis([-90 90 -350 10]) 
