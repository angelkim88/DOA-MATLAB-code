clear all
clc

M=5; % 센서의 수
distance = 0.5; % lambda/2 센서 사이의 간격
degrees = 30; % degrees
phi = -90:0.1:90; % -90~90 0.1씩 beampattern

A = exp(-j*2*pi*distance*[0:(M-1)]'*sin(degrees*pi/180)) / sqrt(M);
Aw = exp(-j*2*pi*distance*[0:(M-1)]'*sin(phi*pi/180))/sqrt(M);

C_bp = Aw'*A; %출력

figure
% 출력 스펙트럼
plot(phi,20*log10(abs(C_bp)),'b','linewidth',1);
xlabel('Angle (deg)','fontweight','bold','fontsize',10);
ylabel('Power Response (dB)','fontweight','bold','fontsize',10);
set(gca,'fontweight','bold','fontsize',10);
axis([-90 90 -50 10]);
grid
set(gca,'xtick',-90:15:90);


% Conventional 
clear all

M=20; % 센서의 수
sig2=.1; % noise cvariance = .1 
th1=20; % 각도  
spacing=0.5; % lambda/2 센서 사이의 간격
% 등간 원형 어레이(ULA)의 Steering Vector
A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180));     

S=[1]; % 신호원 
% Maximum Likehood 추정값
R_hat=(A*S*(conj(A).')) + sig2*eye(M);

for k=1:180 
   th(k)=(-90+k)*pi/180; % -90 ~ 90
   for jj=1:M
      % 정합된 공간 필터
      Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
   end
   % Conventional 빔형성기 공간 스펙트럼식
   P(k)= real((conj(Aw).') * R_hat * Aw)./ M ; 
end 

figure;
% Conventional 빔형성기 파워 스펙트럼식 [dB]
plot(th*180/pi,20*log10(P/max(P)),'k') 
grid on 
xlabel('Angle')
ylabel('|P(\theta)| (dB)') 
axis([-90 90 -50 10]) 

clear all
clc

M=20; % 센서의 수
distance = 0.5; % lambda/2 센서 사이의 간격
degrees = 30; % degrees

phi = -90:0.1:90; % -90~90 0.1씩 beampattern

A = exp(-j*2*pi*distance*[0:(M-1)]'*sin(degrees*pi/180)) / sqrt(M);
Aw = exp(-j*2*pi*distance*[0:(M-1)]'*sin(phi*pi/180))/sqrt(M);

Rss=[1];
Rrr=A*Rss*A';

C_bp = real((conj(Aw.')*Rrr*Aw)./1); %출력
C_b=C_bp(:,1100)
figure
% 출력 스펙트럼
plot(phi,20*log10(abs(C_bp)),'b','linewidth',1.5);
xlabel('Angle (deg)','fontweight','bold','fontsize',10);
ylabel('Power Response (dB)','fontweight','bold','fontsize',10);
set(gca,'fontweight','bold','fontsize',10);
axis([-90 90 -50 10]);
grid
set(gca,'xtick',-90:15:90);


