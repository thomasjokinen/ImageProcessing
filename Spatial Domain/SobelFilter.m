%% Author: Thomas Jokinen
%% Purpose: Edge enhancement: Sobel Operation
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

%% Sobel Operation
for y=1:j                            %moves the y pos (y)
    for x=1:k                        %moves the x pos (x)
        gx_1=double(I2((y+b+1),(x+a-1)))+2*double(I2((y+b+1),(x+a)))+double(I2((y+b+1),(x+a+1)));
        gx_2=double(I2((y+b-1),(x+a-1)))+2*double(I2((y+b-1),(x+a)))+double(I2((y+b-1),(x+a+1)));
        gy_1=double(I2((y+b-1),(x+a+1)))+2*double(I2((y+b),(x+a+1)))+double(I2((y+b+1),(x+a+1)));
        gy_2=double(I2((y+b-1),(x+a-1)))+2*double(I2((y+b),(x+a-1)))+double(I2((y+b+1),(x+a-1)));
        sobel=abs(gx_1-gx_2)+abs(gy_1-gy_2);
        %sobel=sqrt((gx_1-gx_2)^2)+sqrt((gy_1-gy_2)^2);
        J(y,x)=sobel;
        J2(y,x)=double(I2((y+b),(x+a)))+sobel;
    end
end

figure;
subplot(1,4,1);
imshow(I);
title('Original Image');
subplot(1,4,2);
imshow(J);
title('Sobel Function');
% subplot(1,4,2);
% imshow(J2);
% title('Sobel + Original Image');

%% Comparison with MATLAB function
BW = edge(I,'Sobel');
H = fspecial('sobel');
BW2 = imfilter(I,H,'replicate');
subplot(1,4,3);
imshow(BW2);
title('MATLAB fspecial Sobel');
subplot(1,4,4);
imshow(BW);
title('MATLAB edge Sobel');




