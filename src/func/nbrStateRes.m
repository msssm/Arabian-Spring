function stateRes = nbrStateRes( root, agents, depth )
% Calculate the residual of all neighbor states of the root agent.  The
% variable depth defines how many neighbors of neighbors shall be considered
    global state k nbrCount; % used for the functions getTotalNbr and
                             % getAllStates, which are both recursive
    root
    depth
    
    nbrCount = 0; % init neighbor counter
    getTotalNbr( root, agents, depth ); % get total number of neighbors

    nbrCount
    
    state = zeros( nbrCount + 1, 1 ); % +1 is for the root agent itself and
                                      % will not be needed later on
    k = 0;
    getAllStates( root, agents, depth ); % get the states of all neighbours
                                         % and write it into the vector
                                         % state
    state
    
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
