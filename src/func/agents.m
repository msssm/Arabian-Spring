% --------------------------------*- Matlab -*---------------------------------
% Filename: agents.m
% Description: It takes a matrix discribing a network and generates the
% agents.
% Author: Sebasitan Heinekamp
% Email: heinekas@student.ethz.ch
% Created: Sun Nov 13 20:05:26 2011 (+0100)
% Version:
% Last-Updated: Wed Nov 23 17:13:06 2011 (+0100)
% By: 
% Update #: 0
% -----------------------------------------------------------------------------
% agents.m starts here 
% -----------------------------------------------------------------------------
function [ agent ] = agents( networkmatrix, par  )
%AGENTS generates the agents out of a network.

[r c] = size(networkmatrix); 
numberofagents = r;
agent = struct('citizen', [], 'state', [], 'nbr', [], 'threshold', []); 
agent(numberofagents).citizen = 0; 

totrebls =0; 

for i=1:numberofagents
    
    % Determine in which country the citizen lives
    agent(i).citizen = 0; 
    k = 1; 
    maxNode = 0;
    while(agent(i).citizen == 0)
        maxNode = maxNode + par.nodes(k);
        if i <= maxNode
            agent(i).citizen = k; 
        end
        k = k + 1; 
    end
    
    % Set state
    agent(i).state = 0; 
    
    % Get threshold
    agent(i).threshold = (rand(1)+par.thresholdoffset)/(1+par.thresholdoffset);
   
    % Find connected agents (neighbours) 
    agent(i).nbr = [];
    for j=1:c,
        
        if networkmatrix(i,j) ~= 0
            
            agent(i).nbr = [agent(i).nbr j]; 
            
        end
        
    end
    
    % initialise roit origins 
    if agent(i).citizen == par.riot(1)
        if totrebls <= par.riot(2)
            if 0.5 <= (rand(1)*par.stretch)
                agent(i).threshold = 1;
                totrebls = totrebls +1; 
            end
        end
    end
    
        
    
    
end



end

