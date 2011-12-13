% --------------------------------*- Matlab -*---------------------------------
% Filename: main.m
% Description: Main script to execute the simulation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Nov 10 21:20:16 2011 (+0100)
% Version: 
% Last-Updated: Thu Dec  8 22:03:01 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 172
% -----------------------------------------------------------------------------
% main.m starts here
% -----------------------------------------------------------------------------

clear( 'all' );

% -----------------------------------------------------------------------------
% set paths
% -----------------------------------------------------------------------------
whereIs.main = pwd;
cd( '..' );
whereIs.src = pwd;
whereIs.func = [whereIs.src filesep 'func'];
addpath( whereIs.func );
cd( whereIs.main );

% -----------------------------------------------------------------------------
% parameter
% -----------------------------------------------------------------------------
% the nodes variable define the number of nodes in the network.  each
% element of the vector defines the number of nodes in that cluster, hence
% the total number of nodes in the global network is sum( par.nodes ) and
% the number of clusters in the global network is length( par.nodes ).
par.nodes = [200 400 600];

% this parameter defines the maximum percentage of updated agents per time
% step.  it is an upper bound, the actual updatet agents may also be less.
par.maxAgentUpdate = 0.04;

% this parameter defines the percentage of agents from the sequential update
% list to introduce noize by a randomly set mind state with the randi()
% function.
par.noisyAgent = 0.0;

% this parameter defines the considered depth of neighbor agents of a root
% agent.  E.g., 1 means consider only the immediate neighbors of root, 2
% means consider also the neighbors of neighbors and so on.
par.nbrDepth = 1;

% used for network generation.  khalf is the mean degree half and alpha is
% the rewiring probability.
par.kHalf = [2 2 2];
par.alpha = [0.1 0.1 0.1];

% number nodes between the different networks 
par.between = [2 4 2];

% Gives the possibility to build in a favour for the rebls or the system. 
% for possitive thresholdoffsets the thresholds of all the agents gets a
% bit higher, but by less than the given offset.
% likewise for negative thresholdoffsets.
par.thresholdoffset = 0.01;

% fix threshold for part of the network
% the first parameter is the partion in procentige that gets a fixed
% threshold. The second is the threshold these agents get.
par.fixedthreshold = [0 , 0.4]; 

% this parameter determines in which country and how many rebles are placed
% in the network.
% riot(1) is the country, riot(2) is the number of rebls.
par.riot = [1 1];
% stretch rang: [0.5 2]
% determines how far the rebls are placed apart. (inverse proportional)
par.stretch = 1; 

% the time variable defines the start and end time of the simulation with a
% two element vector [tStart tEnd].  the nTime variable defines the number
% of nodes in the time domain.
par.time = [0 100]; % [day]
par.nTime = 1000;

% the beta and gamma variables define the infection rate and the immunity
% rate, respectively, of the SIR model.  Each cluster has its own value.  If
% beta = 1 & gamma = 0 -> the SIR model is not used at all.
par.beta = ones( size(par.nodes) ); % [day^-1]
par.gamma = zeros( size(par.nodes) ); % [day^-1]

% defines the write interval, measured by the time step, for the .csv disk
% write for post-processing purposes.  used later for network plotting.  a
% value of 10 means that every tenth time step a file is written.
par.csvInterval = 250;

% -----------------------------------------------------------------------------
% start simulation
% -----------------------------------------------------------------------------



[res, initStat, endStat, agent, S] = runSim( par );
plot( res );

% -----------------------------------------------------------------------------
% main.m ends here
% -----------------------------------------------------------------------------

