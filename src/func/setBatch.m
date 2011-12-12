% --------------------------------*- Matlab -*---------------------------------
% Filename: setBatch.m
% Description: Set environment for batch operation
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Dec  8 20:36:39 2011 (+0100)
% Version: 
% Last-Updated: Thu Dec  8 22:00:00 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 5
% -----------------------------------------------------------------------------
% setBatch.m starts here
% -----------------------------------------------------------------------------
function [par, dirname]  = setBatch( par, batch, i, j, k, l );
% set par according to batch, generate dirname;
    par.kHalf = batch.kHalf{i};
    par.maxAgentUpdate = batch.maxAgentUpdate(j);
    par.noisyAgent = batch.noisyAgent(k);
    par.nbrDepth = batch.nbrDepth(l);

    % -------------------------------------------------------------------------
    % concat dirname
    kHalf = ['kHalf='];
    for m = 1:length( batch.kHalf{i} )
        kHalf = [kHalf num2str( batch.kHalf{i}(m) ) '-'];
    end
    kHalf = kHalf(1:length(kHalf)-1);
    maxAgent = ['maxUpdate=' num2str( batch.maxAgentUpdate(j) )];
    noize = ['noize=' num2str( batch.noisyAgent(k) )];
    nbrDepth = ['nbrDepth=' num2str( batch.nbrDepth(l) )];
    fixedthreshold = ['fixedthreshold=' num2str(par.fixedthreshold(2))]; 
    dirname = ['batchRun__' kHalf '_' maxAgent '_' noize '_' nbrDepth '_' fixedthreshold];
    return;
    
% -----------------------------------------------------------------------------
% setBatch.m ends here
% -----------------------------------------------------------------------------
