clc
clear

RawECG =xlsread('RawECG.csv');
sinyal=RawECG(:,2)/1023.00*5.0;
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
time=L/fs;
waktu=linspace(0,time,L);
rdom=rand(1,1); %noise Motion Artifact
S = sin(2*pi*rdom*waktu); %noise Motion Artifac
ss=transpose(S);
noise=sinyal+ss;
%---------- SINYAL SETELAH NOISE --------------
hold on
figure(1)
subplot(2,1,1)
plot(waktu,noise);
title("Sinyal ECG dengan Motion Artifact Noise domain Waktu");
xlabel("Waktu(s)");
ylabel("Amplitudo(Volt)");
%------- SINYAL DOMAIN FREKUENSI-----
B=abs(fft(noise));
frek=(0:L-1)*fs/L;
subplot(2,1,2)
plot(frek,B)
title("Sinyal ECG dengan Motion Artifact Noise domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off

csvwrite("file_noise_MA.csv",noise);