%% Author: Thomas Jokinen
%% Purpose: IDFT from Image
%% Inputs: Output workspace variable 'F' from DFT_1D.m
%% Outputs: IDFT with IFFT comparision 
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

F_IDFT=G;

%Get image height and width
[N M] = size(F_IDFT); 

%preaccolate memory for image and inverse fourier transform
f_idft=F_IDFT*0;
f_uy=F_IDFT*0;

%% Loading Bar
h = waitbar(0,'Performing Inverse Fourier Transform','Name','Inverse Discrete Fourier Transform',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)

%% 1D Seperablity Inverse Fourier Transform
for y=0:N-1
    
    if getappdata(h,'cancelling')
       delete(h); 
       return
    end
    waitbar((y)/(N+M))
    
    for u=0:M-1 
        for v=0:N-1
            f_uy(y+1,u+1)=f_uy(y+1,u+1)+1/N*F_IDFT(v+1,u+1)*exp(1i*2*pi*(y)*(v-1)/(N));
        end
    end
end
for x=1:M

    if getappdata(h,'cancelling')
       delete(h); 
       return
    end
    waitbar((x+y)/(N+M))
    
    for y=1:N                          
        for u=1:M
            f_idft(y,x)=f_idft(y,x)+1/M*f_uy(y,u)*exp(1i*2*pi*(u-1)*(x)/(M));
        end
    end
end
delete(h);

%% Magnitude and Normalization 
f_mag=abs(f_idft/255);

%% FFT Comparision 
ifft=ifft2(FFT);
ifft_mag=abs(ifft/255);

%% Output Images
figure
subplot(1,2,1);
imshow(f_mag);
title('Designed IDFT'); 
subplot(1,2,2);
imshow(ifft_mag);
title('MATLAB IFFT IDFT'); 