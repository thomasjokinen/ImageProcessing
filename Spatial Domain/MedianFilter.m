%% Author: Thomas Jokinen
%% Purpose: Median Filtering
%% Inputs: Fig335a.tif (Should be in 'current folder' when ran)
%% Outputs: Spatial Filters
%% Date Created: 10/18/2016
%% Date Modified: 10/21/2016
%% Modifications: General Code Cleanup

%Get image
I = (imread('Fig335a.tif'));

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

figure;
subplot(1,2,1);
imshow(I);
title('Original Image');
subplot(1,2,2);
imshow(J);
title(['Median Filter: ',num2str(m), 'x',num2str(n)]);



