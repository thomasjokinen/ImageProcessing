%% Author: Thomas Jokinen
%% Purpose: Laplacian Filtering
%% Inputs: Fig338a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig338a.tif'));

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

%% Laplacian Filter
c=-1;
g=0;
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        oper=double(I2((y+b),(x+a+1)))+double(I2((y+b),(x+a-1)))+double(I2((y+b+1),(x+a)))+double(I2((y+b-1),(x+a)))-4*double(I2((y+b),(x+a)));
        J(y,x)=oper;
        J2(y,x)=double(I2((y+b),(x+a)))+c*oper;
        g=0;
    end
end

figure;
subplot(1,4,1);
imshow(I);
title('Original Image');
subplot(1,4,3);
imshow(J);
title('Laplacian Filter');
subplot(1,4,2);
imshow(J2);
title('Laplacian + Original Image');

%% Comparison with MATLAB function
H = fspecial('laplacian');
BW = imfilter(I,H,'replicate');
subplot(1,4,4);
imshow(BW);
title('MATLAB Laplacian Filter');
