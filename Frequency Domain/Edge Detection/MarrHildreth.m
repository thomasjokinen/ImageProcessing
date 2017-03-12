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

%Define Threshold and Sigma
T=.1*435.3086;
Sigma=4;

%Get image height and width
[j k] = size(I); 

%Neighborhood Size for Gaussian(should be odd)
n=25;
m=n;

%define a and b
a=(m-1)/2;
b=(n-1)/2;

%padded the image
I2 = double(I);
I2 = [zeros(j+b,a) [zeros(b,k);I2]];
I2 = [[I2;zeros(b,k+a)] zeros(j+b+b,a)];

%Preaccolate memory
J=double(I*0);
K=double(I*0);
K3=double(I*0);
K4=double(I*0);
G=0;


%% 2-D Gaussian function
for y=1:(n+1)/2                            %moves the y pos (y)
    for x=1:(n+1)/2                           %moves the x pos (x)
        G(y,x)=exp(-(x^2+y^2)/(2*Sigma^2));
    end
end

% Sets the large gaussian in the middle 
G = padarray(G,[0 (n+1)/2],'symmetric','pre');
G = padarray(G,[(n+1)/2 0],'symmetric','pre');
G((n+1)/2, :) = [];
G(:,(n+1)/2) = [];


%% 2D Convolution
g=0;
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        for t=-b:b      %moves the t pos 
            for s=-a:a  %moves the s pos 
                g=(double(G((b+1)+t,(a+1)+s)) * double(I2((y+b)+t,(x+a)+s)))+g;
            end
        end
        J(y,x)=g;
        g=0;
    end
end

%% Laplacian

%padded the image
J2 = double(J);
J2 = [zeros(j+b,a) [zeros(b,k);J2]];
J2 = [[J2;zeros(b,k+a)] zeros(j+b+b,a)];
% Laplacian Filter
c=1;
g=0;
for y=1:j                            %moves the y pos (y)
    for x=1:k                         %moves the x pos (x)
        oper=double(J2((y+b),(x+a+1)))+double(J2((y+b),(x+a-1)))+double(J2((y+b+1),(x+a)))+double(J2((y+b-1),(x+a)))-4*double(J2((y+b),(x+a)));
        K(y,x)=double(oper);
        g=0;
    end
end

%% Zero Crossing T=0
%Neighborhood Size for Zero Crossing
n=3;
m=n;
%define a and b
a=(m-1)/2;
b=(n-1)/2;
%padded the image
K2 = double(K);
K2 = [zeros(j+b,a) [zeros(b,k);K2]];
K2 = [[K2;zeros(b,k+a)] zeros(j+b+b,a)];

for y=1:j                            
    for x=1:k                        
        htest=K2(y+b,x+a-1)*K2(y+b,x+a+1);
        vtest=K2(y+b-1,x+a)*K2(y+b+1,x+a);
        d1test=K2(y+b-1,x+a+1)*K2(y+b+1,x+a+1);
        d2test=K2(y+b+1,x+a-1)*K2(y+b-1,x+a+1);
        htest2=abs(K2(y+b,x+a-1)-K2(y+b,x+a+1));
        vtest2=abs(K2(y+b-1,x+a)-K2(y+b+1,x+a));
        d1test2=abs(K2(y+b-1,x+a+1)-K2(y+b+1,x+a+1));
        d2test2=abs(K2(y+b+1,x+a-1)-K2(y+b-1,x+a+1));
        if (htest<0) || (vtest<0) || (d1test<0) || (d2test<0)
            if (htest2>0) || (vtest2>0) || (d1test2>0) || (d2test2>0)
                K3(y,x)=255;
            else
                K3(y,x)=0;
            end
        else
            K3(y,x)=0;
        end     
    end
end

%% Zero Crossing
%Neighborhood Size for Zero Crossing
n=3;
m=n;
%define a and b
a=(m-1)/2;
b=(n-1)/2;
%padded the image
K2 = double(K);
K2 = [zeros(j+b,a) [zeros(b,k);K2]];
K2 = [[K2;zeros(b,k+a)] zeros(j+b+b,a)];

for y=1:j                            
    for x=1:k                        
        htest=K2(y+b,x+a-1)*K2(y+b,x+a+1);
        vtest=K2(y+b-1,x+a)*K2(y+b+1,x+a);
        d1test=K2(y+b-1,x+a+1)*K2(y+b+1,x+a+1);
        d2test=K2(y+b+1,x+a-1)*K2(y+b-1,x+a+1);
        htest2=abs(K2(y+b,x+a-1)-K2(y+b,x+a+1));
        vtest2=abs(K2(y+b-1,x+a)-K2(y+b+1,x+a));
        d1test2=abs(K2(y+b-1,x+a+1)-K2(y+b+1,x+a+1));
        d2test2=abs(K2(y+b+1,x+a-1)-K2(y+b-1,x+a+1));
        if (htest<0) || (vtest<0) || (d1test<0) || (d2test<0)
            if (htest2>T) || (vtest2>T) || (d1test2>T) || (d2test2>T)
                K4(y,x)=255;
            else
                K4(y,x)=0;
            end
        else
            K4(y,x)=0;
        end     
    end
end

figure;
subplot(2,2,1);
imshow(I);
title('Original Image');
subplot(2,2,2);
imshow(K, [-255 255]);
title('Laplace');
subplot(2,2,3);
imshow(K3, []);
title('Zero-Crossing (T=0)');
subplot(2,2,4);
imshow(K4, []);
title(['Zero-Crossing (T=',num2str(T),')']);








