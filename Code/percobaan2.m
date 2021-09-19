clc
clear

RawECG =xlsread('RawECG.csv');
sinyal=RawECG(:,2)/1023.00*5.0;
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
time=L/fs;
waktu=linspace(0,time,L);
S = sin(2*pi*50*waktu); % noise pli
ss=transpose(S);%menyamakan matriks
noise=sinyal+ss;
%---------- SINYAL SETELAH NOISE --------------
hold on
figure(1)
subplot(2,1,1)
plot(waktu,noise);
title("Sinyal ECG dengan Noise PLI domain Waktu");
xlabel("Waktu(s)");
ylabel("Amplitudo(Volt)");
%------- SINYAL DOMAIN FREKUENSI-----
B=abs(fft(noise));
mag=B.^2;
frek=0:fs/L:(fs/2)-fs/L;
subplot(2,1,2)
plot(frek,mag(1:L/2))
title("Sinyal ECG dengan Noise PLI domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off
csvwrite("file_noise_pli.csv",noise);%save noise
