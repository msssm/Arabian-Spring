% --------------------------------*- Matlab -*---------------------------------
% Filename: agents.m
% Description: It takes a matrix discribing a network and generates the
% agents.
% Author: Sebasitan Heinekamp
% Email: heinekas@student.ethz.ch
% Created: Sun Nov 13 20:05:26 2011 (+0100)
% Version:
% Last-Updated: 
% By: 
% Update #: 0
% -----------------------------------------------------------------------------
% agents.m starts here
% -----------------------------------------------------------------------------
function [ agent ] = agents( networkmatrix, countrysize  )
%AGENTS generates the agents out of a network.

[r c] = size(networkmatrix); 
numberofagents = r; 
agent = zeros(numberofagents,1); 

for i=numberofagents, 
    agent(i).alpha = 0.5;  % Later a function has to find a value.
    
    agent(i).citizen = floor(i / countrysize); 
    
    agent(i).state = 0.5; % An algorithim to compute this is still needed
    
    % Find connected agents (neighbours) 
    for j=c,
        
        if networkmatrix(i,j) ~= 0
            
            agent.nbr = [i, networkmatrix(i, j)]; 
            
        end
        
    end
    
    
end

end

