clc
clear all

RawECG =xlsread('RawECG.csv');
sinyal=RawECG(:,2)/1023.00*5.0;
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
waktu=(0:L-1)/fs;
%-------Plot Waktu---------
% subplot(2,1,1)
plot(waktu,sinyal);
title("Sinyal ECG Domain waktu");
xlabel("Waktu(s)");
ylabel("Amplitudo(Volt)");
% %-------FFT dan Plot Frekuensi-------
% frek=0:fs/L:(fs/2)-fs/L;
% B=abs(fft(sinyal));
% mag=B.^2;
% subplot(2,1,2)
% plot(frek,mag(1:L/2))
% title("Sinyal ECG Domain Frekuensi");
% xlabel("Frekuensi(Hz)");
% ylabel("Magnitude");
% xlim([-10 110]);
% ylim([0 5000]);
