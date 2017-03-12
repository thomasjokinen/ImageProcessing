%% Author: Thomas Jokinen
%% Purpose: DFT from Image with Padding
%% Inputs: I_file from another m file
%% Outputs: DFT with FFT comparision 
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get image
I = I_file;

% Get image height and width and add padding parameters
[N M] = size(I); 
P=2*M;
Q=2*N;

% Preaccolate memory for image and fourier transform
fp=padarray(I,[N M],'post');
fp=double(fp);
F_xv=fp*0;
F=fp*0;

%% Centering 
for y=1:Q                             
    for x=1:P                        
        fp(y,x)=fp(y,x)*(-1)^(x+y);
    end
end

%% FFT Comparision 
F=fft2(fp);
FFT_mag=abs(F);
maxvalFFT=max(FFT_mag(:));
F_norm=255*FFT_mag/maxvalFFT;

%% Output Images
% figure
% subplot(1,2,1);
% imshow(I, []);
% title('Original Image'); 
% subplot(1,2,1);
% imshow(F_norm);
% title('DFT'); 





