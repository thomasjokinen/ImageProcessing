%% Author: Thomas Jokinen
%% Purpose: Sobel Operation with Threshold
%% Inputs: Fig342a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup
clear all

%Get image
I = (imread('Fig1022a.tif'));

%Define Threshold
T=100;
UseSmooth=1;

%Get image height and width
[j k] = size(I); 

%Neighborhood Size for Smoothing Filter (should be odd)
m=5;
n=5;

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
if UseSmooth == 1
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
end

%% Sobel Operation
%Neighborhood Size 
m=3;
n=3;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
if UseSmooth ==1
    J2 = J;
else
    J2 = I;
end
J2 = [zeros(j+b,a) [zeros(b,k);J2]];
J2 = [[J2;zeros(b,k+a)] zeros(j+b+b,a)];

for y=1:j                            %moves the y pos (y)
    for x=1:k                        %moves the x pos (x)
        gx_1=double(J2((y+b+1),(x+a-1)))+2*double(J2((y+b+1),(x+a)))+double(J2((y+b+1),(x+a+1)));
        gx_2=double(J2((y+b-1),(x+a-1)))+2*double(J2((y+b-1),(x+a)))+double(J2((y+b-1),(x+a+1)));
        gy_1=double(J2((y+b-1),(x+a+1)))+2*double(J2((y+b),(x+a+1)))+double(J2((y+b+1),(x+a+1)));
        gy_2=double(J2((y+b-1),(x+a-1)))+2*double(J2((y+b),(x+a-1)))+double(J2((y+b+1),(x+a-1)));
        sobel=abs(gx_1-gx_2)+abs(gy_1-gy_2);
        sobel_y=abs(gx_1-gx_2);
        sobel_x=abs(gy_1-gy_2);
        %sobel=sqrt((gx_1-gx_2)^2)+sqrt((gy_1-gy_2)^2);
        J(y,x)=sobel_x;
        %J2(y,x)=double(J2((y+b),(x+a)))+sobel;
        if J(y,x)<T
            J(y,x)=0;
        else
            J(y,x)=255;
        end
    end
end

figure;
subplot(1,2,1);
imshow(I);
title('Original Image');
subplot(1,2,2);
imshow(J);
title(['Vertical Sobel with Threshold (T=',num2str(T/255*100),'%)']);






