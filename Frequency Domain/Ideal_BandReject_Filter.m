%% Author: Thomas Jokinen
%% Purpose: Ideal Lowpass Filter 
%% Inputs: Workspace variable 'G' from Ideal_Lowpass_Filter
%% Outputs: Filter for DFT
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get Image
% Grabs 'F' for processing
F_filt=G;
[Q P] = size(F_filt); 

% Preaccolate memory
H=F_filt*0;
D=F_filt*0;
if exist('D0')
    %Do nothing
else
    D0=10;
end
if exist('W')
    %Do nothing
else
    W=10;
end

%% Create D
for v=1:Q                             
    for u=1:P                        
        D(v,u)=((u-P/2)^2+(v-Q/2)^2)^(1/2);
    end
end

%% Filter
for v=1:Q                             
    for u=1:P      
        if((D0-W/2)<=D(v,u)) && (D(v,u)<=(D0+W/2))
            H(v,u)=0;
        else
            H(v,u)=1;
        end
    end
end

G=H.*F_filt;

%% Magnitude
G_mag=abs(G);
maxval=max(G_mag(:));

%% Normalization
G_norm=255*G_mag/maxval;

figure
subplot(1,2,1);
imshow(H);
title('Filter'); 
subplot(1,2,2);
imshow(G_norm);
title('DFT with Ideal Band-reject Filter'); 





