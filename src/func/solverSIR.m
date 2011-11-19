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
% Last-Updated: Sat Nov 19 18:15:20 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 34
% -----------------------------------------------------------------------------
% solverSIR.m starts here
% -----------------------------------------------------------------------------
function result = solverSIR( agent, par )
% Solve the opinion formation problem using a SIR model.
    if ( length(agent) ~= sum(par.nodes) )
        [stack, I] = dbstack( '-completenames' );
        error( errorMsg('WrongNumberOfNodes', stack) );
    end
    
    % create time vector
    t = linspace( par.time(1), par.time(2), par.nTime );

    % init residual vector(s)
    res = zeros( length(t), length(par.nodes) + 1 ); % +1 is for global res
    
    % start iteration
    for i = 1:length( t )
        % residual
        res(i,:) = calcResidual( agent, par );
        for j = 1:length( agent )
            for k = 1:length( agent(j).nbr )
                % agent(j) gets influenced by its neighbor agent(k)
                agent(j) = applyInfluence( ...
                    agent(k), agent(j), res(i, par.riotOrigin), par );
            end
        end
    end
    result = res;
    return;
    
% -----------------------------------------------------------------------------
% subroutines
% -----------------------------------------------------------------------------
function b = applyInfluence( a, b, res, par )
% apply the influence of agent a on agent b.  If a and b are not both
% residents of the par.riotOrigin country (i.e. cluster number), the the
% actual residual of the par.riotOrigin country decides wether a influences
% b at the actual timestep.  The parameter par.riotOriginThreshold defines
% the limit for inter-cluster influence
    bTmp.motivated = false;
    if ( res <= par.riotOriginThreshold )
        if ( a.citizen == b.citizen && a.citizen == par.riotOrigin )
            % agent j and agent k are citizens of the same counrty
            % (i.e. cluster) and know each other
            if ( rand() < par.beta )
                bTmp.state = b.state;
                bTmp.motivated = true;
                b = setStateNative( a, b );
            end
        end
    else
        if ( a.citizen == b.citizen )
            % agent j and agent k are citizens of the same counrty
            % (i.e. cluster) and know each other
            if ( rand() < par.beta )
                bTmp.state = b.state;
                bTmp.motivated = true;
                b = setStateNative( a, b );
            end
        else
            % agent j and agent k are not citizens of the same
            % country (i.e. cluster) and know each other
            if ( rand() < par.beta )
                bTmp.state = b.state;
                bTmp.motivated = true;
                b = setStateAlien( a, b );
            end
        end
    end
    if ( bTmp.motivated )
        % if b was motivated by a to change its mind, there is probability
        % par.gamma that b was not sure about this new thinking and returns
        % to its old  mindstate instead
        if ( rand() < par.gamma )
            b.state = bTmp.state;
        end
    end
    return;
    
function b = setStateNative( a, b )
% set the mind-state of native agent b under influence of agent a
    b.state = a.alpha*a.state + (1 - a.alpha)*b.state;
    return;

function b = setStateAlien( a, b )
% set the mind-state of alien agent b under influence of agent a
    b = setStateNative( a, b );
    return;

function res = calcResidual( agent, par )
% calculate residual for each cluster as well as global
    res = cell( 1, length(par.nodes) + 1 );
    for i = 1:length( par.nodes )
        res{i} = zeros( par.nodes(i), 1 );
    end
    res{length(res)} = zeros( length(agent), 1 );

    % init array addressing
    counter = ones( size(res) );
    for i = 1:length( agent )
        % local residual vector entry for agent(i)
        res{agent(i).citizen}(counter(agent(i).citizen)) = agent(i).state;
        counter(agent(i).citizen) = counter(agent(i).citizen) + 1;
        % global residual entry for agent(i)
        res{length(res)}(counter(length(counter))) = agent(i).state;
        counter(length(counter)) = counter(length(counter)) + 1;
    end
    % calculate maxRes for normalization
    maxRes = zeros( size(res) );
    for i = 1:length( par.nodes )
        maxRes(i) = norm( ones(par.nodes(i), 1) ); % local
    end
    maxRes(length(maxRes)) = norm( ones(sum(par.nodes), 1) ); % global

    % normalize
    tmpRes = zeros( size(res) );
    for i = 1:length( res )
        tmpRes(i) = norm( res{i} )/maxRes(i);
    end
    res = tmpRes;
    return;
    
% -----------------------------------------------------------------------------
% solverSIR.m ends here
% -----------------------------------------------------------------------------
