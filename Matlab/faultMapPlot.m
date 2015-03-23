% This script cumputes a bidimensional gaussian distribution and plots it.
% This probability function is assumed to represent the probability a fault
% happens on the chip in the coordinates (x1, x2).
% After that, a map is created where random faults are simulated. The value
% 0 in the map means 'no fault' and 1 means 'fault', whereas -1 indicates 
% the points out of the circular wafer

clear all
close all
clc

% Initializing variables for gussian plot
ray = 50;

x1 = linspace(-10,10,2*ray);
x2 = x1;

mean = [0,0];
normalizedVariance = [0.1, 0; 0, 0.1];
variance = ray.*normalizedVariance;

[X1,X2] = meshgrid(x1,x2);

rng = 'default'; % for reproducibility

% Computing and plotting multivariate normal probability density function
Z = mvnpdf([X1(:), X2(:)], mean, variance);
Z = reshape(Z, length(x1), length(x2));

figure(1)
surf(X1,X2,Z)
title('Probability density function')

% Filling sqare matrix with simbolic values. Fault are deloyed according to
% the probabilit function.
maxZ = max(max(Z));
faultNumber = 0;

for (i=1:length(x1))
    for (j=1:length(x2))
        
        if ((rand*(maxZ*10) < Z(i,j)) && ((i-ray)^2+(j-ray)^2 <= ray^2))
            faultMap(i,j) = 1;
        else
            if ((i-ray)^2+(j-ray)^2 > ray^2)
                faultMap(i,j) = -1;
            else
            faultMap(i,j) = 0;
            end
        end
    end
end

faultNumber = length(find(faultMap));

% Plotting fault map
figure(2)
pcolor(faultMap)
title('Fault map')
