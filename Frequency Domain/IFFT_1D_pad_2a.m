%% Author: Thomas Jokinen
%% Purpose: IDFT from Image
%% Inputs: Workspace variable 'G' from filter 'm' files
%% Outputs: IDFT with IFFT comparision 
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get Image
F_IDFT=G;

% Get image height and width
[Q P] = size(F_IDFT); 

% Preaccolate memory for image and inverse fourier transform
f_idft=F_IDFT.*0;
f_uy=F_IDFT.*0;

%% FFT Comparision 
f=ifft2(F_IDFT);
IFFT2=f.*0;

%% Centering 
for y=1:Q                             
    for x=1:P                        
        IFFT2(y,x)=f(y,x).*(-1)^(x+y);
    end
end
IFFT_mag=abs(IFFT2/255);
IFFT_mag=real(IFFT_mag);
f_final=IFFT_mag(1:Q/2,1:P/2);

%% Output Images
figure
subplot(1,2,1);
imshow(G_norm);
title('DFT with Filter'); 
subplot(1,2,2);
imshow(f_final);
title('IFFT Image'); 
