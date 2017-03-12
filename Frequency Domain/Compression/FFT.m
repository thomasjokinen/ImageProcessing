%% Author: Thomas Jokinen
%% Purpose: RMS Error
%% Inputs: Fig801a.tif (Should be in 'current folder' when ran)
%% Outputs: Total Error between the two images
%% Date Created: 12/08/2016
%% Date Modified: 12/09/2016
%% Modifications: General Code Cleanup
clear all

%Get image
I = (imread('Fig809a.tif'));

%Get image height and width
[j k] = size(I); 

%SubImage and Compression ratio
compress=4;
ns=8;
Sub=[ns ns];

%% Create Mask
mask=zeros(ns);
for y=1:j                            
    for x=1:k
        if x+y<compress+2
            mask(y,x)=1;
        end
    end
end

%% 
for y=1:ns:j-ns                            
    for x=1:ns:k-ns                         
        subI = I(y:y+ns-1, x:x+ns-1);
        test=fft2(subI);
        test=test.*mask;
        J(y:y+ns-1,x:x+ns-1)=test;
        
    end
end

for y=1:ns:j-ns                           
    for x=1:ns:k-ns                         
        subI2 = J(y:y+ns-1, x:x+ns-1);
        test2=ifft2(subI2);
        Q(y:y+ns-1,x:x+ns-1)=test2;
    end
end
Q=abs(Q/255);

figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(J);
title('DCT');
subplot(1,3,3);
imshow(Q, []);
title(['Compressed Image (SubImage Size: ', num2str(ns),'x',num2str(ns),') (Truncated to ',num2str(ceil(compress^2/2)+2),' coefficients)']); 
