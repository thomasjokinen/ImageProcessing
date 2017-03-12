%% Author: Thomas Jokinen
%% Purpose: DFT Gaussian Filter 
%% Inputs: Workspace variable F, T, a, and b  from other 'm' files 
%% Outputs: Filter for DFT
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get Image
% Grabs 'F' for processing
F_filt=F;
[Q P] = size(F_filt); 

% Preaccolate memory
H=F_filt*0;

a=0.1;
b=0.1;
T=1;

%% Filter
[u,v] = meshgrid(1:P,1:Q); %Use this code to generate mesh for filter
v=v-floor(P/2);            %Shift needed to make filter work properly
u=u-floor(Q/2);
for v=1:Q                             
    for u=1:P                        
        H(v,u)=(T./(pi*(u*a+v*b))).*sin(pi*(u*a+v*b)).*exp(-1i*pi*(u*a+v*b));
    end
end

G=H.*F;

%% Magnitude
G_mag=abs(G);
maxval=max(G_mag(:));