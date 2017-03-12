%% Author: Thomas Jokinen
%% Purpose: DFT from Image
%% Inputs: Fig222b.tif (Should be in 'current folder' when ran)
%% Outputs: DFT with FFT comparision 
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%Get image
I = double(imread('Fig222b.tif'));

%Get image height and width
[N M] = size(I); 

%preaccolate memory for image and fourier transform
fp=padarray(I,[N M],'post');
F_xv=I*0;
F=I*0;

%% Centering 
for y=1:N                             %moves the y pos (y)
    for x=1:M                         %moves the x pos (x)
        f(y,x)=I(y,x)*(-1)^(x+y);
    end
end

%% Loading Bar
h = waitbar(0,'Performing Fourier Transform','Name','Discrete Fourier Transform',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)

%% 1D Seperablity Fourier Transform
for v=1:N       
    
    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((v)/(N+M))
    
    for x=1:M 
        for y=1:N
            F_xv(v,x)=F_xv(v,x)+f(y,x)*exp(-1i*2*pi*(y-1)*(v)/(N));
        end
    end
end
for u=1:M
    
    if getappdata(h,'canceling')
       delete(h); 
       return
    end
    waitbar((v+u)/(N+M))
    
    for v=1:N                           
        for x=1:N
            F(v,u)=F(v,u)+F_xv(v,x)*exp(-1i*2*pi*(u)*(x-1)/(M));
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
FFT=fft2(f);
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

figure
subplot(1,2,1);
imshow(F);
title('Custom DFT'); 
subplot(1,2,2);
imshow(FFT);
title('FFT DFT'); 




