%% Author: Thomas Jokinen
%% Purpose: Displays a figure with 8 bit plane plots
%% Inputs: Fig221a.tif (Should be in 'current folder' when ran)
%% Outputs: Plot of bit planes
%% Date Created: 9/27/2016
%% Date Modified: 10/3/2016
%% Modifications: General Code Cleanup

I = (imread('Fig221a.tif'));
i=8;
figure;
%Loops through the 8 bit planes and displays them
while i>0
    J=bitget(I,i); 
    subplot(2,4,i); 
    imshow(J,[]);
    title(['Bit Plane ',num2str(i)]);
    i=i-1;
end

%% Old code; For individual plots
% while i>0
%     J=bitget(I,i); 
%     figure;
%     imshow(J,[]);
%     title(['Bit Plane ',num2str(i)]);
%     i=i-1;
% end