%% Author: Thomas Jokinen
%% Purpose: Sobel Operation with Threshold
%% Inputs: Fig342a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup
clear all

%Get image
I = imread('Fig1022a.tif');

%Define Threshold and Sigma
T=200;
Sigma=4;

%Get image height and width
[j k] = size(I); 

%Neighborhood Size for Gaussian(should be odd)
n=25;
m=n;
hsize=[n n];
T=1;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
I2 = I;
I2 = [zeros(j+b,a) [zeros(b,k);I2]];
I2 = [[I2;zeros(b,k+a)] zeros(j+b+b,a)];

%Preaccolate memory
J=I*0;
K=I*0;
K2=I*0;
G=0;

H = fspecial('gaussian', hsize, Sigma);
J = imfilter(I,H,'replicate');

J2 = J;
J2 = [zeros(j+b,a) [zeros(b,k);J2]];
J2 = [[J2;zeros(b,k+a)] zeros(j+b+b,a)];

% Laplacian Filter
c=-1;
g=0;
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        oper=double(J2((y+b),(x+a+1)))+double(J2((y+b),(x+a-1)))+double(J2((y+b+1),(x+a)))+double(J2((y+b-1),(x+a)))-4*double(J2((y+b),(x+a)));
        K(y,x)=oper;
        g=0;
    end
end

for y=1:j                            %moves the y pos (y)
    for x=1:k                        %moves the x pos (x)
        if K(y,x)<T
            K(y,x)=0;
        else
            K(y,x)=255;
        end
    end
end

figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(J);
title('Gaussian');
subplot(1,3,3);
imshow(K, []);
title('Laplace');








