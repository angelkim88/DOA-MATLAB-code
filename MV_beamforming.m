% Capon AOA estimation for a M = 6 element array with noise variance = .1 
clear all
clc
M=20; % 센서의 수
sig2=.1; % noise cvariance = .1 
th1=20; % 각도  
spacing=0.5; % lambda/2 센서 사이의 간격
S=[1];    % 신호원
% 등간 원형 어레이(ULA)의 Steering Vector
A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180));     
% Maximum Likehood 추정값
R_hat=(A*S*(conj(A).'))+sig2*eye(M); 
inv(R_hat)

for k=1:360 
   th(k)=(-90+(k/2))*pi/180; % -90 ~ 90 
   for jj=1:M
       % 정합된 공간 필터
       Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
   end
   % Conventional 빔형성기 공간 출력 스펙트럼식
   P(k)=real(M./( (conj(Aw).')*inv(R_hat)*Aw) ) ;
end 
figure; 
plot(th*180/pi,10*log10(P/max(P)),'r','linewidth',1.5) 
grid on 
xlabel('Angle') 
ylabel('|P(\theta)| (dB)') 
axis([-90 90 -50 10]) 
%set(gca,'xtick',-90:10:90);
