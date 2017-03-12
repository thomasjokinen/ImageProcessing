%% Author: Thomas Jokinen
%% Purpose: RMS Error
%% Inputs: Fig801a.tif (Should be in 'current folder' when ran)
%% Outputs: Total Error between the two images
%% Date Created: 12/08/2016
%% Date Modified: 12/09/2016
%% Modifications: General Code Cleanup

%Get image
f = (imread('Fig801a.tif'));

%Create compressed image
%WRITE COMPRESSION CODE HERE
%f_comp=f;
%WRITE DECOMPRESSION CODE HERE
%f_hat=f;

%Get image height and width
[j k] = size(I); 

%create an error function
e=I*0;

%% RMS error
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        e(y,x)=f_hat(y,x)-f(y,x);
    end
end

figure;
subplot(1,3,1);
imshow(f);
title('Original Image');
subplot(1,3,2);
imshow(f_hat);
title('Approximate Image');
subplot(1,3,3);
imshow(e);
title('RMS Error');

%% SNR
%create an SNR numerator
f_hat2=I*0;

for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        f_hat2(y,x)=f_hat(y,x)^2;
    end
end

SNR=f_hat2/(e^2);
figure;
subplot(1,3,1);
imshow(f);
title('Original Image');
subplot(1,3,2);
imshow(f_hat);
title('Approximate Image');
subplot(1,3,3);
imshow(SNR);
title('SNR');


