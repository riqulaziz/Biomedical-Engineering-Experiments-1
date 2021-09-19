clc
clear

sinyal =xlsread('file_noise_MA.csv');
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
time=L/fs;
waktu=linspace(0,time,L);
fc=3;
N=1;
%------ sebelum------
hold on
figure(1)
subplot(2,1,1)
plot(waktu,sinyal)
title("Sinyal ECG noise Motion Artifact sebelum filter domain waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%-----fft------
B=abs(fft(sinyal));
frek=(0:L-1)*fs/L;
subplot(2,1,2)
plot(frek,B)
title("Sinyal ECG noise Motion Artifact sebelum filter domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off
%----------filter IIR Highpass
Highpass=designfilt('highpassiir','FilterOrder',N,'PassbandFrequency',fc,'PassbandRipple',0.5,'SampleRate',fs);
y=filter(Highpass,sinyal);
%-------setelah-----
hold on 
figure(2)
subplot(2,1,1)
plot(waktu,y)
title("Sinyal ECG setelah filter IIR Highpass domain Waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%------fft---------
C=abs(fft(y));
frek=(0:L-1)*fs/L;
subplot(2,1,2)
plot(frek,C)
title("Sinyal ECG setelah filter IIR Highpass domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off