% --------------------------------*- Matlab -*---------------------------------
% Filename: main.m
% Description: Main script to execute the simulation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Nov 10 21:20:16 2011 (+0100)
% Version: 
% Last-Updated: Sat Nov 12 18:39:07 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 5
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

% the time variable defines the start and end time of the simulation with a
% two element vector [tStart tEnd].  the nTime variable defines the number
% of nodes in the time domain.
par.time = [0 60]; % [day]
par.nTime = 1000;

% the beta and gamma variables define the infection rate and the immunity
% rate, respectively, of the SIR model.
par.beta = 0.001; % [day^-1]
par.gamma = 0.00001; % [day^-1]

% -----------------------------------------------------------------------------
% start simulation
% -----------------------------------------------------------------------------



% -----------------------------------------------------------------------------
% main.m ends here
% -----------------------------------------------------------------------------
