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

% counts the number of already initialised rebls
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
    % Says whether the agent is rioting (1) or not (2).
    agent(i).state = 0; 
    
    % Get threshold
    % The threshold is randomly generated and can be set off in either
    % direction to favour the system or the rebls
    agent(i).threshold = (rand(1)+par.thresholdoffset)/(1+par.thresholdoffset);
   
    % handle fixed thresholds
    if rand(1) <= par.fixedthreshold(1)
        agent(i).threshold = par.fixedthreshold(2); 
    end
    % Find connected agents (neighbours)
    % goes through the network and finds all the neighbours of the current
    % agent so the solver saves time.
    agent(i).nbr = [];
    for j=1:c,
        
        if networkmatrix(i,j) ~= 0
            
            agent(i).nbr = [agent(i).nbr j]; 
            
        end
        
    end
    
    % initialise roit origins 
    % the number of rebles are placed in the network. How far the rioting
    % agents are apart depends on par.strech. for par.stretch = 2 or larger
    % the rebles are in the closest neighbourhood of each other, while for
    % small the rebles are placed further apart. for to small par.stretch
    % values the distance between the rebles might be larger than the
    % network so not all rebls are placed in the network. 
    % for par.stretch smaller(or equal) to 0.5 no agents will beplaced at
    % all.
    % the rebles are caracterised by a threshold of 1. That means that they
    % will turn against the system as soon as they are updated.
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

