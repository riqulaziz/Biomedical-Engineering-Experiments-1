clc
clear

sinyal =xlsread('file_noise_MA.csv');
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
time=L/fs;
waktu=linspace(0,time,L);
fc=3;
N=57; %keoefisien filter belum jadi
fcn=fc/fs; %normalisasi
for k=1:N
    n=k-(N-1)/2;
    if n==0
        hd(k)=1-(2*fcn);
    else
        hd(k)=-sin(2*pi*fcn*n)/(pi*n);
    end
end
nn=[1:N];
wn=0.42-0.5*cos(2*pi*nn/100)+0.08*cos(4*pi*nn/100);
h=hd.*wn;
hk=conv(sinyal,h,'same');
%-----sebelum----
hold on
figure(1)
subplot(2,1,1)
plot(waktu,sinyal);
title("Sinyal ECG noise Motion Artifact sebelum filter domain waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%-----fft------
B=abs(fft(sinyal).^2);
frek=0:fs/L:(fs/2)-fs/L;
subplot(2,1,2)
plot(frek,B(1:L/2))
title("Sinyal ECG noise Motion Artifact sebelum filter domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off
%-----------setelah-----
hold on
figure(2)
subplot(2,1,1)
plot(waktu,hk);
title("Sinyal ECG setelah filter FIR Highpass domain Waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%------fft---------
C=abs(fft(hk).^2);
subplot(2,1,2)
plot(frek,C(1:L/2))
title("Sinyal ECG setelah filter FIR Highpass domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off 