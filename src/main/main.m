% --------------------------------*- Matlab -*---------------------------------
% Filename: main.m
% Description: Main script to execute the simulation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Nov 10 21:20:16 2011 (+0100)
% Version: 
% Last-Updated: Tue Dec  6 20:41:31 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 165
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
par.nodes = [100 95 160];

% this parameter defines the maximum percentage of updated agents per time
% step.  it is an upper bound, the actual updatet agents may also be less.
par.maxAgentUpdate = 0.3;

% this parameter defines the considered depth of neighbor agents of a root
% agent.  E.g., 1 means consider only the immediate neighbors of root, 2
% means consider also the neighbors of neighbors and so on.
par.nbrDepth = 2;

% used for network generation.  khalf is the mean degree half and alpha is
% the rewiring probability.
par.kHalf = [3 2 3];
par.alpha = [0.5 0.3 0.1];

% number nodes between the different networks 
par.between = [2 4 2];

par.thresholdoffset = 0;
par.upperBound = 1;
par.lowerBound = 0;

par.riot = [1 5]; 
par.stretch = 1; 

% the time variable defines the start and end time of the simulation with a
% two element vector [tStart tEnd].  the nTime variable defines the number
% of nodes in the time domain.
par.time = [0 90]; % [day]
par.nTime = 300;

% the beta and gamma variables define the infection rate and the immunity
% rate, respectively, of the SIR model.  Each cluster has its own value
par.beta = [0.1, 0.08, 0.05]; % [day^-1]
par.gamma = [0.001, 0.01, 0.03]; % [day^-1]

% the riotOrigin parameter defines the number of the cluster in which the
% uprise against the government starts.  the riotOriginThreshold is a scalar
% between 0 and 1 and describes the point at which the riots in riotOrigin
% spreads over to the other clusters.  0 means that it immediately spreads
% over, 1 means that it spreads when riotOrigin already is in maximum
% revolution.
par.riotOrigin = 1;
% par.riotOriginThreshold = 0.6;

% defines the write interval, measured by the time step, for the .csv disk
% write for post-processing purposes.  used later for network plotting.  a
% value of 10 means that every tenth time step a file is written.
par.csvInterval = 30;

% -----------------------------------------------------------------------------
% start simulation
% -----------------------------------------------------------------------------

% create network
S = smallworld( par );

% create agents
agent = agents( S, par );

k = 0;
for i = 1:length( agent )
    if ( agent(i).citizen == 1 )
        agent(i).threshold = 1;
        k = k + 1;
    end
    if ( k == 4 )
        break;
    end
end


% run solver
[res, initStat, endStat] = solverSIRv2( agent, par );
plot( res );


% -----------------------------------------------------------------------------
% playground (delete this later)

% % test solverSIRv2.m
% n = 1;
% N = sum( par.nodes );
% imin = [1 par.nodes(2) par.nodes(3)];
% imax = [par.nodes(1) sum(par.nodes(1:2)) sum(par.nodes)];

% for i = 1:length( par.nodes )
%     for j = 1:par.nodes(i)
%         agent(n).state = 0;
%         dummy = [1 randi([1 6], [1])];
%         agent(n).nbr = randi( N, dummy );
%         % agent(n).nbr = randi( [imin(i) imax(i)] , dummy );
%         agent(n).citizen = i;
%         agent(n).threshold = 0.6;
%         n = n+1;
%     end
% end

% aList = randi( length(agent), [20 1] );
% for i = 1:length( aList )
%     agent(aList(i)).threshold = 1;
% end
        
% [res, initStat, endStat] = solverSIRv2( agent, par );
% plot( res );


% par.nodes = [5 5];
% n = 1;
% N = sum( par.nodes );
% imin = [1 par.nodes(2)];
% imax = [par.nodes(1) sum(par.nodes(1:2))];

% for i = 1:length( par.nodes )
%     for j = 1:par.nodes(i)
%         agent(n).state = randi( [0 1], [1] );
%         dummy = [1 randi([1 3], [1])];
%         agent(n).nbr = randi( N, dummy );
%         % agent(n).nbr = randi( [imin(i) imax(i)] , dummy );
%         agent(n).citizen = i;
%         n = n+1;
%     end
% end

% state = nbrStateRes( agent(1), agent, 2 );


% -----------------------------------------------------------------------------
% main.m ends here
% -----------------------------------------------------------------------------

