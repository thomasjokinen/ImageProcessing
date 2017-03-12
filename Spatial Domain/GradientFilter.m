%% Author: Thomas Jokinen
%% Purpose: Spatial Filtering
%% Inputs: Fig342a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig342a.tif'));

%Get image height and width
[j k] = size(I); 

%Neighborhood Size (should be odd)
m=3;
n=3;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
I2 = I;
I2 = [zeros(j+b,a) [zeros(b,k);I2]];
I2 = [[I2;zeros(b,k+a)] zeros(j+b+b,a)];

%create a second image
J=I*0;
J2=I*0;

%% Cross-gradient operation; Robert's Method
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        mag=abs(double(I2((y+b+1),(x+a+1)))-double(I2((y+b),(x+a))))+abs(double(I2((y+b+1),(x+a)))-double(I2((y+b),(x+a+1))));
        J(y,x)=mag;
        J2(y,x)=double(I2((y+b),(x+a)))+mag;
    end
end

figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(J);
title('Gradient Function');
% subplot(1,4,2);
% imshow(J2);
% title('Gradient + Original Image');

%% Comparison with MATLAB function
BW = edge(I,'Roberts');
subplot(1,3,3);
imshow(BW);
title('MATLAB Roberts');


