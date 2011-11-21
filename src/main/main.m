% --------------------------------*- Matlab -*---------------------------------
% Filename: main.m
% Description: Main script to execute the simulation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Nov 10 21:20:16 2011 (+0100)
% Version: 
% Last-Updated: Sat Nov 19 18:22:06 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 27
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
par.nodes = [100 150 200];
par.khalf = [10 20 30];
par.alpha = [0.1 0.3 0.6];

% the time variable defines the start and end time of the simulation with a
% two element vector [tStart tEnd].  the nTime variable defines the number
% of nodes in the time domain.
par.time = [0 60]; % [day]
par.nTime = 600;

% the beta and gamma variables define the infection rate and the immunity
% rate, respectively, of the SIR model.
par.beta = 0.005; % [day^-1]
par.gamma = 0.0008; % [day^-1]

% the riotOrigin parameter defines the number of the cluster in which the
% uprise against the government starts.  the riotOriginThreshold is a scalar
% between 0 and 1 and describes the point at which the riots in riotOrigin
% spreads over to the other clusters.  0 means that it immediately spreads
% over, 1 means that it spreads when riotOrigin already is in maximum
% revolution.
par.riotOrigin = 1;
par.riotOriginThreshold = 0.6;

% -----------------------------------------------------------------------------
% start simulation
% -----------------------------------------------------------------------------

% test solverSIR.m
n = 1;
N = sum( par.nodes );
imin = [1 par.nodes(2) par.nodes(3)];
imax = [par.nodes(1) sum(par.nodes(1:2)) sum(par.nodes)];

for i = 1:length( par.nodes )
    for j = 1:par.nodes(i)
        agent(n).state = rand();
        dummy = [1 randi(8)];
        agent(n).nbr = randi( N, dummy );
        % agent(n).nbr = randi( [imin(i) imax(i)] , dummy );
        agent(n).alpha = 0.6;
        agent(n).citizen = i;
        n = n+1;
    end
end

res = solverSIR( agent, par );
plot( res );

% -----------------------------------------------------------------------------
% main.m ends here
% -----------------------------------------------------------------------------

