%% Author: Thomas Jokinen
%% Purpose: Wiener Filter
%% Inputs: Workspace variable F, H, K  from other 'm' files 
%% Outputs: Filter for DFT
%% Date Created: 11/19/2016
%% Date Modified: 11/20/2016
%% Modifications: General Code Cleanup

%% Get Image
% Preaccolate memory
H_cc=H;
H2=H'.*H;

%% Filter
%F_hat=G./H;
F_hat=(1./H).*(H.*H'./(H.*H'+K));
F_hat=F_hat.*G;

% 
% for v=1:N                             
%     for u=1:M                        
%         F_hat(v,u) = (1/H(v,u))*((H(v,u)*H_cc(v,u))/(H(v,u)*H_cc(v,u)+K))*G(v,u);
%     end
% end