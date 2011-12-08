% --------------------------------*- Matlab -*---------------------------------
% Filename: solverSIRv2.m
% Description: New, modified version of solverSIR.m
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Thu Dec  1 21:59:51 2011 (+0100)
% Version: 
% Last-Updated: Thu Dec  8 22:01:05 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 49
% -----------------------------------------------------------------------------
% solverSIRv2.m starts here
% -----------------------------------------------------------------------------
function [res, initStat, finalStat] = solverSIRv2( agent, par )
% Solve the opinion formation problem using a SIR model.
    if ( length(agent) ~= sum(par.nodes) )
        [stack, I] = dbstack( '-completenames' );
        error( errorMsg('WrongNumberOfNodes', stack) );
    end
    
    % create time vector
    t = linspace( par.time(1), par.time(2), par.nTime );
    
    % init residual vector(s)
    res = zeros( length(t), length(par.nodes) + 1 ); % +1 is for global res
    maxUpdatedAgents = int32( par.maxAgentUpdate*length(agent) );
    
    % get initial agent statistics
    initStat = fieldStat( agent );
    csvBasename = 'riotAgents';
    writeCSV( [csvBasename num2str(0) '.csv'], agent );
    
    % start iteration
    for i = 1:length( t )
        res(i,:) = calcResidual( agent, par );
        % generate a random list of agents to be updated in this time step.
        % The list has a random length, but at most par.maxAgentUpdate
        % (percent of total agents)
        aList = randi( length(agent), [randi(maxUpdatedAgents) 1] );
        nNoize = floor( par.noisyAgent*length(aList) );
        runSolver = true;
        if ( logical(nNoize) )
            for j = 1:nNoize
                agent(aList(j)).state = randi( [0 1], [1] ); % add noize
            end
            runSolver = false;
            if ( nNoize < length(aList) )
                aList = aList( (nNoize+1):length(aList) );
                runSolver = true;
            end
        end
        if ( runSolver )
            for j = 1:length( aList )
                if ( (1 - agent(aList(j)).threshold) <= ...
                     nbrStateRes(agent(aList(j)), agent, par.nbrDepth) )
                    if ( rand() <= par.beta(agent(aList(j)).citizen) )
                        % SIR infection
                        agent(aList(j)).state = 1; % if the neighbor
                                                   % residual is
                                                   % larger than the agent
                                                   % threshold, set its mind
                                                   % state to 1.
                    end
                else
                    %agent(aList(j)).state = 0; % if the neighbor residual is
                                               % less than the agent threshold,
                                               % set the agents state to 0,
                                               % regardless what is was before.
                end
                if ( rand() < par.gamma(agent(aList(j)).citizen) )
                    % SIR removal
                    agent(aList(j)).state = 0;
                end
            end
            if ( ~mod(i, par.csvInterval) )
                writeCSV( [csvBasename num2str(i) '.csv'], agent );
            end
        end
    end
    % get final agent statistics
    finalStat = fieldStat( agent );
    return;
    
% -----------------------------------------------------------------------------
% subroutines
% -----------------------------------------------------------------------------
function stat = fieldStat( agent )
% Gather information of the agent field.
    stat.nOnes = 0; % number of agents with a state 1
    stat.nInitiator = 0; % number of initiator agents, i.e., agents with a
                         % threshold of 1 and state 0
    for i = 1:length( agent )
        if ( logical(agent(i).state) )
            stat.nOnes = stat.nOnes + 1;
        else
            if ( agent(i).threshold == 1 )
                stat.nInitiator = stat.nInitiator + 1;
            end
        end
    end
    return;
    
function stateRes = nbrStateRes( root, agents, depth )
% Calculate the residual of all neighbor states of the root agent.  The
% variable depth defines how many neighbors of neighbors shall be considered
    global state k nbrCount; % used for the functions getTotalNbr and
                             % getAllStates, which are both recursive
    nbrCount = 0; % init neighbor counter
    getTotalNbr( root, agents, depth ); % get total number of neighbors
    state = zeros( nbrCount + 1, 1 ); % +1 is for the root agent itself and
                                      % will not be needed later on
    k = 0;
    getAllStates( root, agents, depth ); % get the states of all neighbours
                                         % and write it into the vector
                                         % state
    state = state(1:length(state) - 1); % cut off the last element since it
                                        % is the state of root itself.
                                        % However, only neighbor states are
                                        % of interest.
    maxRes = norm( ones(size(state)) ); % maximum residual, i.e., all
                                        % neighbors have state 1
    stateRes = norm( state )/maxRes; % calculate normalized residual of all
                                     % neighbors of the root agent
    return;

function getTotalNbr( root, agents, depth )
% Count the total number of agents, which are neighbors (and higher order
% neighbors, according to depth) of the root agent.  Write result into
% global variable nbrCount.  This function is recursive.
    global nbrCount
    if ( depth == 0 )
        return;
    elseif ( depth == 1 )
        nbrCount = nbrCount + length( root.nbr );
        return;
    else
        for i = 1:length( root.nbr )
            getTotalNbr( agents(root.nbr(i)), agents, depth - 1 );
        end
        nbrCount = nbrCount + length( root.nbr );
        return;
    end
        
function getAllStates( root, agents, depth )
% Get the states of all neighbors (and higher order neighbors, according to
% depth) of the root agent. Write the states into the global variable
% state.  This is a recursive function.  The very last state is the one from
% the root agent itself.
    global state k
    if ( depth == 0 )
        k = k + 1;
        state(k) = root.state;
        return;
    else
        for i = 1:length( root.nbr )
            getAllStates( agents(root.nbr(i)), agents, depth - 1 );
        end
        k = k + 1;
        state(k) = root.state;
        return;
    end
    
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

function writeCSV( filename, agent )
% write every agent with state 1 to .csv file
    fid = fopen( filename, 'w' );
    for i = 1:length( agent )
        if ( logical(agent(i).state) )
            fprintf( fid, '%i\n', i );
        end
    end
    fclose( fid );
    return;
    
% -----------------------------------------------------------------------------
% solverSIRv2.m ends here
% -----------------------------------------------------------------------------
