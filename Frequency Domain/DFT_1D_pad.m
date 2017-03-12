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

%% Loading Bar
h = waitbar(0,'Performing Fourier Transform','Name','Discrete Fourier Transform',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)

%% 1D Seperablity Fourier Transform
for v=1:Q       
    
    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((v)/(Q+P))
    
    for x=1:P 
        for y=1:Q
            F_xv(v,x)=F_xv(v,x)+fp(y,x)*exp(-1i*2*pi*(y-1)*(v)/(Q));
        end
    end
end
for u=1:P
    
    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((v+u)/(Q+P))
    
    for v=1:Q                           
        for x=1:P
            F(v,u)=F(v,u)+F_xv(v,x)*exp(-1i*2*pi*(u)*(x-1)/(P));
        end
    end
end
delete(h); 

%% Magnitude
F_mag=abs(F);
maxval=max(F_mag(:));

%% Normalization
F_norm=255*F_mag/maxval;

%% FFT Comparision 
FFT=fft2(fp);
FFT_mag=abs(FFT);
maxvalFFT=max(FFT_mag(:));
FFT_norm=255*FFT_mag/maxvalFFT;

%% Output Images
figure
subplot(1,3,1);
imshow(I, []);
title('Original Image'); 
subplot(1,3,2);
imshow(F_norm);
title('Designed DFT'); 
subplot(1,3,3);
imshow(FFT_norm);
title('FFT DFT'); 

% figure
% subplot(1,2,1);
% imshow(F);
% title('Custom DFT'); 
% subplot(1,2,2);
% imshow(FFT);
% title('FFT DFT'); 





