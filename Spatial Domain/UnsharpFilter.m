%% Author: Thomas Jokinen
%% Purpose: Unsharp Weighted Mask
%% Inputs: Fig340a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig338a.tif'));

%Get image height and width
[j k] = size(I); 

%Neighborhood Size (should be odd)
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

%% Blur Filter
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
%Unsharp Mask
mask=I-J;

%Scaled unsharp + Original Image
scale=4.5;
boost=I+scale*mask;

%Plot all Images
figure;
subplot(1,4,1);
imshow(I);
title('Original');
subplot(1,4,2);
imshow(J);
title(['Blur Filter ', num2str(m),'x',num2str(n)]);
subplot(1,4,3);
imshow(mask);
title('Mask');
subplot(1,4,4);
imshow(boost);
title(['Scaled Version k=',num2str(scale)]);

