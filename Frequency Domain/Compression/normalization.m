%% Author: Thomas Jokinen
%% Purpose: RMS Error
%% Inputs: Fig801a.tif (Should be in 'current folder' when ran)
%% Outputs: Total Error between the two images
%% Date Created: 12/08/2016
%% Date Modified: 12/09/2016
%% Modifications: General Code Cleanup
clear all

%Get image
I = (imread('Fig809a.tif'));

%Get image height and width
[j k] = size(I); 

J=int8(I)-128;

Z   =  [16  11  10	16  24  40  51  61
        12  12  14  19  26  58  60  55
        14  13  16  24  40  57  69  56
        14  17  22  29  51  87  80  62
        18  22  37  56  68  109 103 77  
        24  35  55  64  81  104 113 92
        49  64  78  87  103 121 120 101 
        72  92  95  98  112 100 103 99];

%SubImage and Compression ratio
% compress=4;
ns=8;
Sub=[ns ns];

%% 
for y=1:ns:j-ns                            
    for x=1:ns:k-ns                         
        subI = J(y:y+ns-1, x:x+ns-1);
        test=dct2(subI);
        J2(y:y+ns-1,x:x+ns-1)=test;   
    end
end

for y=1:ns:j-ns                           
    for x=1:ns:k-ns                         
        T_dot= J2(y:y+ns-1,x:x+ns-1).*Z;
        J3(y:y+ns-1,x:x+ns-1)=T_dot;   
    end
end

for y=1:ns:j-ns                            
    for x=1:ns:k-ns                          
        subI2 = J3(y:y+ns-1, x:x+ns-1);
        test2=idct2(subI2);
        Q(y:y+ns-1,x:x+ns-1)=test2;
    end
end

figure;
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(J3);
title('DCT');
subplot(1,3,3);
imshow(Q, []);
title('test');
