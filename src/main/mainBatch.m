% --------------------------------*- Matlab -*---------------------------------
% Filename: mainBatch.m
% Description: main.m as a batch script
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Dec  8 20:15:16 2011 (+0100)
% Version: 
% Last-Updated: Thu Dec  8 22:01:19 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 15
% -----------------------------------------------------------------------------
% mainBatch.m starts here
% -----------------------------------------------------------------------------

clear( 'all' );

% -----------------------------------------------------------------------------
% set paths
whereIs.main = pwd;
cd( '..' );
whereIs.src = pwd;
whereIs.func = [whereIs.src filesep 'func'];
addpath( whereIs.func );
cd( whereIs.main );

% -----------------------------------------------------------------------------
% batch parameter
batch.kHalf = { [2 2 2] }; % Sebastian
% batch.kHalf = { [4 4 4] }; % Tile
% batch.kHalf = { [6 6 6] }; % Fabian
batch.maxAgentUpdate = [0.02 0.04 0.08];
batch.noisyAgent = [0 0.01 0.1];
batch.nbrDepth = [1 2];

% -----------------------------------------------------------------------------
% general parameter, as is in main.m
par.nodes = [200 400 600];
par.maxAgentUpdate = 0.04;
par.noisyAgent = 0.01;
par.nbrDepth = 2;
par.kHalf = [2 2 2];
par.alpha = [0.2 0.4 0.6];
par.between = [2 4 2];
par.thresholdoffset = 0.01;
par.riot = [1 1];
par.stretch = 1; 
par.time = [0 100];
par.nTime = 1000;
par.beta = ones( size(par.nodes) );
par.gamma = zeros( size(par.nodes) );
par.csvInterval = 250;

% -----------------------------------------------------------------------------
% run batch
tic
for i = 1:length( batch.kHalf )
    for j = 1:length( batch.maxAgentUpdate )
        for k = 1:length( batch.noisyAgent )
            for l = 1:length( batch.nbrDepth )
                [par, dirname] = setBatch( par, batch, i, j, k, l );
                mkdir( dirname );
                cd( dirname );
                [res, initStat, endStat, agent, S] = runSim( par );
                save( [dirname '.mat'], 'res', 'initStat', 'endStat', ...
                      'agent', 'S' );
                cd( whereIs.main );
            end
        end
    end
end
disp( 'DONE...' );
toc

% -----------------------------------------------------------------------------
% mainBatch.m ends here
% -----------------------------------------------------------------------------
