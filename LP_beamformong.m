% Linear predictive AOA estimation for a M = 6 element array with noise variance = .1 
% allow transpose(u3) = [0 0 1 0 0 0] 
 clear all
 clc
 
M=20; 
sig2=.1; 
th1=20; 
spacing=0.5; % lambda/2 센서 사이의 간격

 

u3=[0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; 

A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180));

Rss=[1]; 
Rrr=A*Rss*(conj(A).') + sig2*eye(M); 
for k=1:180; 
   th(k)=(-90+k)*pi/180;    %(-90+(k-1));
 
   for jj=2:M 
      Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
   end 
P(k)=real((u3'*inv(Rrr)*u3)/(abs(u3'*inv(Rrr)*Aw)^2)); 
 
 
end 
figure; 
plot(th*180/pi,20*log10(P/max(P)),'b','linewidth',1.5) 
grid on 
xlabel('Angle') 
ylabel('|P(\theta)|') 
axis([-90 90 -100 10]) 
 
%num2str(A,2)