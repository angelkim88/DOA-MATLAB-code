% Capon AOA estimation for a M = 6 element array with noise variance = .1 
clear all
clc
M=20; % ������ ��
sig2=.1; % noise cvariance = .1 
th1=20; % ����  
spacing=0.5; % lambda/2 ���� ������ ����
S=[1];    % ��ȣ��
% � ���� ���(ULA)�� Steering Vector
A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180));     
% Maximum Likehood ������
R_hat=(A*S*(conj(A).'))+sig2*eye(M); 
inv(R_hat)

for k=1:360 
   th(k)=(-90+(k/2))*pi/180; % -90 ~ 90 
   for jj=1:M
       % ���յ� ���� ����
       Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
   end
   % Conventional �������� ���� ��� ����Ʈ����
   P(k)=real(M./( (conj(Aw).')*inv(R_hat)*Aw) ) ;
end 
figure; 
plot(th*180/pi,10*log10(P/max(P)),'r','linewidth',1.5) 
grid on 
xlabel('Angle') 
ylabel('|P(\theta)| (dB)') 
axis([-90 90 -50 10]) 
%set(gca,'xtick',-90:10:90);
