% --------------------------------*- Matlab -*---------------------------------
% Filename: solverSIR.m
% Description: Solver function that employs the SIR model for opinion
%              spreading.  The function takes a list of agent structures and a
%              parameter structure, which is defined in main.m script.  The
%              function generates an output structure for post-processing.
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Nov 10 21:29:23 2011 (+0100)
% Version: 
% Last-Updated: Sat Nov 12 18:29:59 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 7
% -----------------------------------------------------------------------------
% solverSIR.m starts here
% -----------------------------------------------------------------------------
function res = solverSIR( agent, par )
% Solve the opinion formation problem using a SIR model.
    if ( length(agent) ~= sum(par.nodes) )
        [stack, I] = dbstack( '-completenames' );
        error( errorMsg('WrongNumberOfNodes', stack) );
    end
    
    % create time vector
    t = linspace( pat.time(1), par.time(2), par.nTime );

    % start iteration
    for i = 1:length( t )
        for j = 1:length( agent )
            for k = 1:length( agent(j).nbr )
                if ( agent(j).citizen == agent(k).citizen )
                    % agent j and agent k are citizens of the same counrty
                    % (i.e. cluster) and know each other
                    if ( rand() < par.beta )
                        agent(k) = setStateNative( agent(j), agent(k) );
                    end
                else
                    % agent j and agent k are not citizens of the same
                    % country (i.e. cluster) and know each other
                    if ( rand() < par.beta )
                        agent(k) = setStateAlien( agent(j), agent(k) );
                    end
                end
            end
        end
        % residual
        
    end
    res = 1;
    return;
    
function b = setStateNative( a, b )
% set the mind-state of native agent b under influence of agent a
    b.state = a.alpha*a.state + (1 - a.alpha)*b.state;
    return;

function b = setStateAlien( a, b )
% set the mind-state of alien agent b under influence of agent a
    b = setStateNative( a, b );
    return;
                    
% -----------------------------------------------------------------------------
% solverSIR.m ends here
% -----------------------------------------------------------------------------
