% --------------------------------*- Matlab -*---------------------------------
% Filename: runSim.m
% Description: perform simulation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Dec  8 21:38:49 2011 (+0100)
% Version: 
% Last-Updated: Thu Dec  8 21:41:41 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 1
% -----------------------------------------------------------------------------
% runSim.m starts here
% -----------------------------------------------------------------------------
function [res, initStat, endStat, agent, S] = runSim( par )
% run a simulation
    S = randomgraph( par ); % create random graph network
    % S = smallworld( par ); %create small world network
    agent = agents( S, par ); % create agents
    [res, initStat, endStat] = solverSIRv3( agent, par ); % run solver
    return;

% -----------------------------------------------------------------------------
% runSim.m ends here
% -----------------------------------------------------------------------------
