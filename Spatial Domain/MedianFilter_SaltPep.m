%% Author: Thomas Jokinen
%% Purpose: Median Filtering with Salt & Pepper
%% Inputs: Fig326a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig326a.tif'));

%Add noise
d=0.1;
Inoise=imnoise(I,'salt & pepper',d);

%Get image height and width
[j k] = size(I); 

%Neighborhood Size (should be odd)
m=3;
n=19;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
I2 = Inoise;
I2 = [zeros(j+b,a) [zeros(b,k);I2]];
I2 = [[I2;zeros(b,k+a)] zeros(j+b+b,a)];

%create a second image
J=I*0;

%medean Matrix
med_mat=zeros(n,m);

%% Median Filter
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        
        for t=-b:b      %moves the t pos 
            for s=-a:a  %moves the s pos 
                med_mat((b+1)+t,(a+1)+s)=double(I2((y+b)+t,(x+a)+s));
            end
        end
        %median array
        med=reshape(med_mat,1,(m*n));
        J(y,x)=median(med);
    end
end
%Plot
figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(Inoise);
title(['Salt & Pepper Noise: d=',num2str(d)]);
subplot(1,3,3);
imshow(J);
title(['Median Filter: ',num2str(m), 'x',num2str(n)]);

%% Histograms of each image
figure;
subplot(1,3,1);
imhist(I);
title('Original');
subplot(1,3,2);
imhist(Inoise);
title('Gaussian Noise');
subplot(1,3,3);
imhist(J);
title('Root Image');


