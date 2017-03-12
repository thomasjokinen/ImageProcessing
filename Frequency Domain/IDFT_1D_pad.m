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

%% Loading Bar
h = waitbar(0,'Performing Inverse Fourier Transform','Name','Inverse Discrete Fourier Transform',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)

%% 1D Seperablity Inverse Fourier Transform
for y=1:Q
    
    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((y)/(Q+P))
    
    for u=1:P 
        for v=1:Q
            f_uy(y,u)=f_uy(y,u)+1/Q.*F_IDFT(v,u).*exp(1i*2*pi*(y)*(v-1)/(Q));
        end
    end
end
for x=1:P

    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((x+y)/(Q+P))
    
    for y=1:Q                          
        for u=1:P
            f_idft(y,x)=f_idft(y,x)+1/P.*f_uy(y,u).*exp(1i*2*pi*(u-1)*(x)/(P));
        end
    end
end
delete(h);

%% Centering 
f_idft2=f_idft.*0;
for y=1:Q                             
    for x=1:P                        
        f_idft2(y,x)=f_idft(y,x).*(-1)^(x+y);
    end
end

%% Magnitude and Normalization 
f_mag=abs(f_idft2/255);
f_mag=real(f_mag);

%% Unpad Image
f_final=f_mag(1:Q/2,1:P/2);

%% FFT Comparision 
IFFT=ifft2(F_IDFT);
IFFT2=IFFT.*0;
for y=1:Q                             
    for x=1:P                        
        IFFT2(y,x)=IFFT(y,x).*(-1)^(x+y);
    end
end
IFFT_mag=abs(IFFT2/255);
IFFT_mag=real(IFFT_mag);
IFFT_final=IFFT_mag(1:Q/2,1:P/2);

%% Output Images
figure
subplot(1,3,1);
imshow(I);
title('Orignal Image'); 
subplot(1,3,2);
imshow(f_final);
title('Designed Filtered Image'); 
subplot(1,3,3);
imshow(IFFT_final);
title('FFT Filtered Image'); 
