%% Author: Thomas Jokinen
%% Purpose: Spatial Filtering
%% Inputs: Fig338a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig333a.tif'));

%Get image height and width
[j k] = size(I); 

%Neighborhood Size (should be odd)
m=9;
n=9;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
I2 = I;
I2 = [zeros(j+b,a) [zeros(b,k);I2]];
I2 = [[I2;zeros(b,k+a)] zeros(j+b+b,a)];

%create a second image
J=I*0;

%% Smoothing Filter
g=0;
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        
        for t=-b:b      %moves the t pos 
            for s=-a:a  %moves the s pos 
                g=g+double(I2((y+b)+t,(x+a)+s));
            end
        end
        J(y,x)=g/(m*n);
        g=0;
    end
end

figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(J);
title('Smoothing Filter');

%% Comparison with MATLAB function
H = fspecial('average', [n m]);
BW = imfilter(I,H,'replicate');
subplot(1,3,3);
imshow(BW);
title('MATLAB Smoothing Filter');


