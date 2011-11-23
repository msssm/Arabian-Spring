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
function [ agent ] = agents( networkmatrix, par  )
%AGENTS generates the agents out of a network.

[r c] = size(networkmatrix); 
numberofagents = r; 
agent = struct('citizen', 0, 'state', 0.5, 'nbr', [1 1]); 
agent(numberofagents).citizen = 0; 
maxnbr = 0; 

for i=numberofagents,
    
    % Determine in which country the citizen lives
    agent(i).citizen = 0; 
    k = 1; 
    while(agent(i).citizen == 0)
        if i <= par.nodes(k)
            agent(i).citizen = k; 
        end
        k = k + 1; 
    end
    
    % Find a random mindstate (with a curtain offset for one party)
    agent(i).state = (rand(1)+par.stateoffset)/(1+par.stateoffset);
    
    % Find connected agents (neighbours) 
    for j=c,
        
        if networkmatrix(i,j) ~= 0
            
            agent(i).nbr = [i, networkmatrix(i, j)]; 
            
        end
        
    end
    
    % Assigning the number of nodes as alpha
    [ nr nc] = size(agent(i).nbr); 
    agent(i).alpha = nc;   
    
    % Find maxnbr
    if maxnbr < nc
        maxnbr = nc; 
    end
    
    
end

% Complete the alpha
for i=numberofagents,
    agent(i).alpha = agent(i).alpha / maxnbr; 
end


end

