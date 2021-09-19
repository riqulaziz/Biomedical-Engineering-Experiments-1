clc
clear

sinyal =xlsread('file_noise_pli.csv');
fs=100; % frekuensi sampling 100
L=length(sinyal); %panjang data
time=L/fs;
waktu=linspace(0,time,L);
fk=48/fs;
fl=50/fs;
N=77; %keoefisien filter belum jadi
for k=1:N
    n=k-(N-1)/2;
    if n==0
        hd(k)=1-(2*fl-2*fk);
    else
        hd(k)=(sin(2*pi*fk*n)/(pi*n))-(sin(2*pi*fl*n)/(pi*n));
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
title("Sinyal ECG noise PLI sebelum filter domain waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%-----fft------
B=abs(fft(sinyal));
frek=(0:L-1)*fs/L;
subplot(2,1,2)
plot(frek,B)
title("Sinyal ECG noise PLI sebelum filter domain Frekuensi");
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
title("Sinyal ECG setelah filter FIR Bandstop domain Waktu");
xlabel("waktu(s)");
ylabel("amplitudo(v)");
%------fft---------
C=abs(fft(hk));
frek=(0:L-1)*fs/L;
subplot(2,1,2)
plot(frek,C)
title("Sinyal ECG setelah filter FIR Bandstop domain Frekuensi");
xlabel("Frekuensi(Hz)");
ylabel("Magnitude");
xlim([-10 110]);
ylim([0 5000]);
hold off