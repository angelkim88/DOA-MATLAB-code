%Maximum Likelihood Array Weights 
% example 8.4 
d=0.5; 
N= 20; 
sig2=.001;        % noise variance 
theta=-pi/2:.01:pi/2; 
ang=theta*180/pi; 
th0=30*pi/180;      % receive angle 
 
s=1;                %signal amplitude 
 
a=[]; 
n1=[]; 
n2=[]; 
n=-(N-1)/2:(N-1)/2; 
a=exp(1j*2*pi*n*d*sin(th0));  % array steering vector 
a=a.'; 
Rnn=sig2*eye(N);        % noise correlation matrix        
 
w=inv(Rnn)*a./(a'*inv(Rnn)*a);           % calculated weight vector 
 
for j=1:length(theta) 
    th=theta(j); 
    aa=[exp(1j*2*pi*n*d*sin(th))];   
    y(j)=w'*aa.'; 
end 
figure; 
plot(ang,abs(y)/max(abs(y)),'k') 
axis([-90 90 0 1]) 
xlabel('\theta') 
ylabel('|AF(\theta)|') 
num2str(a,2) 
