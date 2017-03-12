%% Author: Thomas Jokinen
%% Purpose: Real Filter DC Removal
%% Inputs: Workspace variable 'F' from DFT 'm' files
%% Outputs: DFT with FFT comparision 
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get Image
% Grabs 'F' for processing
F_filt=F;
[Q P] = size(F_filt); 

% Preaccolate memory
H=F_filt*0;

%% Filter
H=F_filt./F_filt;  %Should set everything to 1
H(Q/2,P/2)=F(Q/2,P/2).*0; %Sets the DC val to 0
G=H.*F_filt;

%% Magnitude
G_mag=abs(G);
maxval=max(G_mag(:));

%% Normalization
G_norm=255*G_mag/maxval;

% figure
% subplot(1,2,1);
% imshow(F_norm);
% title('Original DFT'); 
% subplot(1,2,2);
% imshow(G_norm);
% title('DFT with DC Filter'); 