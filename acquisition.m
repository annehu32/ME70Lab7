%% NI DAQ voltage acquisition, tested on NI9201 and NI9234 using cDAQ-9171
% R White 3/18/2025
daqlist("ni") %List all NI devices connected to the computer.
%Note - device must be connected *before* Matlab starts (at least on my
%computer) If you change modules or swap USB or something, restart Matlab
%% This part you just do once when you get set up:
mydaq=daq("ni") %Create an NI daq object called mydaq
addinput(mydaq,'cDAQ9Mod1','ai0','Voltage') %Add an analog input voltage channel, AI0
Fs=51200;
mydaq.Rate=Fs; %set sampling rate to 51200 Hz (the NI9234 only allows certain sampling rates, this is available)
%% This part you can do over and over to get new data
disp("STARTING NOW!!!!!!")
T=5; %Length of time to read for
V=read(mydaq,seconds(T),"OutputFormat","Matrix"); %Read data.  Length of data here is 5 seconds, can change at will.
P=V*100;
dB=20*log10(P/(20*10^-6))-39.6;
%Create time vector
t=0:1/Fs:(T-1/Fs);
dV = table(V);
volts = 'volts.xlsx';
writetable(dV,volts, 'Sheet', 20)
dT = table(dB);
filename = 'allData.xlsx';
writetable(dT, filename, 'Sheet', 20)
%% Plot
figure
plot(t,V)
xlabel('Time (sec)')
ylabel('Voltage (V)')
grid
xlim([0 T])
figure
plot(t,dB)
title("dB :)")
%% Close the NI hardware
clear mydaq
%% Fourier Transform stuff
F = fftshift(fft(dB));
smin = -1/(2*(t(2)-t(1)));
smax = 1/(2*(t(2)-t(1)));
s=linspace(smin, smax, length(t));
power=F.*conj(F);
figure
plot(s, power)



