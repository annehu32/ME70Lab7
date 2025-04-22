%% Analysis for ME70 Lab 7
% Need to average each Run's trials
% then run t-tests on the two different hypotheses
% Step 1: import data as table
% Step 2: For each trial, power specturm, get primary and secondary peaks
sampleRate = 51200;
dt = 1/sampleRate;
run1PrimaryFreq = zeros(1, 5); % Pre-allocate variables for peak frequencies
run1SecondaryFreq = zeros(1, 5);
for i = 1:5
   trial = allData(:,i); % Select the trial of interest
   [rows, cols] = size(allData);
   % Fourier transform
   t = 0:dt:dt*rows;
   F = fftshift(fft(trial));
   smin = -1/(2*sampleRate);
   smax = 1/(2*sampleRate);
   s = linspace(smin, smax, length(t));
   power = F.*conj(F);
   % Identify primary peak
   [maxVal, maxIndex] = max(power);
   run1PrimaryFreq(1,i) = s(maxIndex);
   % Remove primary peak from data set, look for secondary peak
end

