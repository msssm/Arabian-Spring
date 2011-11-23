% --------------------------------*- Matlab -*---------------------------------
% Filename: agents.m
% Description: It takes a matrix discribing a network and generates the
% agents.
% Author: Sebasitan Heinekamp
% Email: heinekas@student.ethz.ch
% Created: Sun Nov 13 20:05:26 2011 (+0100)
% Version:
% Last-Updated: Wed Nov 23 16:22:40 2011 (+0100)
% By: 
% Update #: 0
% -----------------------------------------------------------------------------
% agents.m starts here
% -----------------------------------------------------------------------------
function [ agent ] = agents( networkmatrix, par  )
%AGENTS generates the agents out of a network.

[r c] = size(networkmatrix); 
numberofagents = r;
agent = struct('citizen', [], 'state', [], 'nbr', []); 
agent(numberofagents).citizen = 0; 
maxnbr = 0; 

for i=1:numberofagents
    
    % Determine in which country the citizen lives
    agent(i).citizen = 0; 
    k = 1; 
    maxNode = 0;
    while(agent(i).citizen == 0)
        naxNode = maxNode + par.nodes(k);
        if i <= maxNode
            agent(i).citizen = k; 
        end
        k = k + 1; 
    end
    
    % Find a random mindstate (with a curtain offset for one party)
    agent(i).state = (rand(1)+par.stateoffset)/(1+par.stateoffset);
    
    % Find connected agents (neighbours) 
    agent(i).nbr = [];
    for j=1:c,
        
        if networkmatrix(i,j) ~= 0
            
            agent(i).nbr = [angent(i).nbr j]; 
            
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
for i=1:numberofagents,
    agent(i).alpha = agent(i).alpha / maxnbr; 
end


end

