clear all
clc

M=5; % ������ ��
distance = 0.5; % lambda/2 ���� ������ ����
degrees = 30; % degrees
phi = -90:0.1:90; % -90~90 0.1�� beampattern

A = exp(-j*2*pi*distance*[0:(M-1)]'*sin(degrees*pi/180)) / sqrt(M);
Aw = exp(-j*2*pi*distance*[0:(M-1)]'*sin(phi*pi/180))/sqrt(M);

C_bp = Aw'*A; %���

figure
% ��� ����Ʈ��
plot(phi,20*log10(abs(C_bp)),'b','linewidth',1);
xlabel('Angle (deg)','fontweight','bold','fontsize',10);
ylabel('Power Response (dB)','fontweight','bold','fontsize',10);
set(gca,'fontweight','bold','fontsize',10);
axis([-90 90 -50 10]);
grid
set(gca,'xtick',-90:15:90);


% Conventional 
clear all

M=20; % ������ ��
sig2=.1; % noise cvariance = .1 
th1=20; % ����  
spacing=0.5; % lambda/2 ���� ������ ����
% � ���� ���(ULA)�� Steering Vector
A=exp(-i*2*pi*spacing*[0:(M-1)]'*sin(th1*pi/180));     

S=[1]; % ��ȣ�� 
% Maximum Likehood ������
R_hat=(A*S*(conj(A).')) + sig2*eye(M);

for k=1:180 
   th(k)=(-90+k)*pi/180; % -90 ~ 90
   for jj=1:M
      % ���յ� ���� ����
      Aw = exp(-j*2*pi*spacing*[0:(jj-1)]'*sin(th(k)));
   end
   % Conventional �������� ���� ����Ʈ����
   P(k)= real((conj(Aw).') * R_hat * Aw)./ M ; 
end 

figure;
% Conventional �������� �Ŀ� ����Ʈ���� [dB]
plot(th*180/pi,20*log10(P/max(P)),'k') 
grid on 
xlabel('Angle')
ylabel('|P(\theta)| (dB)') 
axis([-90 90 -50 10]) 

clear all
clc

M=20; % ������ ��
distance = 0.5; % lambda/2 ���� ������ ����
degrees = 30; % degrees

phi = -90:0.1:90; % -90~90 0.1�� beampattern

A = exp(-j*2*pi*distance*[0:(M-1)]'*sin(degrees*pi/180)) / sqrt(M);
Aw = exp(-j*2*pi*distance*[0:(M-1)]'*sin(phi*pi/180))/sqrt(M);

Rss=[1];
Rrr=A*Rss*A';

C_bp = real((conj(Aw.')*Rrr*Aw)./1); %���
C_b=C_bp(:,1100)
figure
% ��� ����Ʈ��
plot(phi,20*log10(abs(C_bp)),'b','linewidth',1.5);
xlabel('Angle (deg)','fontweight','bold','fontsize',10);
ylabel('Power Response (dB)','fontweight','bold','fontsize',10);
set(gca,'fontweight','bold','fontsize',10);
axis([-90 90 -50 10]);
grid
set(gca,'xtick',-90:15:90);


