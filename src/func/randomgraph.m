%% --------------------------------*- Matlab -*---------------------------------
% Filename: smallworld.m
% Created: Thu Nov 10 21:29:23 2011 (+0100)
% Version: 
% Last-Updated: Wed Nov 23 16:58:06 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 10
% -----------------------------------------------------------------------------
% smallworld.m starts here
% -----------------------------------------------------------------------------
%
% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors: Stefan Brugger and Cristoph Schwirzer, 2011

function S = randomgraph(par)
% Generate a small world graph using the "Watts and Strogatz model" as
% described in Watts, D.J.; Strogatz, S.H.: "Collective dynamics of
% 'small-world' networks."
% A graph with n*k/2 edges is constructed, i.e. the nodal degree is n*k for
% every node.
%
% INPUT
% n: [1]: number of nodes of the graph to be generated
% kHalf: [1]: mean degree/2
% beta: [1]: rewiring probability
%
% OUPUT
% A: [n n] sparse symmetric adjacency matrix representing the generated graph

S = sparse( sum(par.nodes) );

s = ones( 1, length(par.nodes)+1 );
for i = 2:length(s)
    s(i) = s(i-1) + par.nodes(i-1);
end
    
for ni = 1:length(par.nodes)

A=random_graph(par.nodes(ni), par.alpha(ni));

S( s(ni):par.nodes(ni)+s(ni)-1, s(ni):par.nodes(ni)+s(ni)-1 ) = A;
end


count=1;
for b=1:(length(par.nodes)-1)
for c=b:(length(par.nodes)-1)
    add=round([(rand(par.between(c),1) * ((s(b+1)-1) - s(b)) + s(b)), (rand(par.between(c),1) * ((s(c+2)-1) - s(c+1)) + s(c+1))]);
    for d =1:length(add)
        S(add(d,1),add(d,2))=1;
        S(add(d,2),add(d,1))=1;
    end
    count=count+1;
end
end

    
    
csvwrite('random.csv', full(S));

end % small_world(...)
