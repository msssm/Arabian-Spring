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

function S = smallworld(par)
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

%generate empty sparce matrix
S = sparse( sum(par.nodes) );

%generate the vector with the positions of the sub networks that cluster
s = ones( 1, length(par.nodes)+1 );
for i = 2:length(s)
    s(i) = s(i-1) + par.nodes(i-1);
end

%generate small world network
for ni = 1:length(par.nodes)
n = par.nodes(ni);
% Construct a regular lattice: a graph with n nodes, each connected to k
% neighbors, k/2 on each side.
k = par.kHalf(ni)*2;
rows = reshape(repmat([1:par.nodes(ni)]', 1, k), par.nodes(ni)*k, 1);
columns = rows+reshape(repmat([[1:par.kHalf(ni)] [par.nodes(ni)-par.kHalf(ni):n-1]], par.nodes(ni), 1), par.nodes(ni)*k, 1);
columns = mod(columns-1, par.nodes(ni)) + 1;
B = sparse(rows, columns, ones(par.nodes(ni)*k, 1));
A = sparse([], [], [], par.nodes(ni), par.nodes(ni));

% With probability beta rewire an edge avoiding loops and link duplication.
% Until step i, only the columns 1:i are generated making implicit use of A's
% symmetry.
for i = [1:par.nodes(ni)]

% The i-th column is stored full for fast access inside the following loop.
    col= [full(A(i, 1:i-1))'; full(B(i:end, i))];
    for j = i+find(col(i+1:end))'
        if (rand()<par.alpha(ni))
            col(j)=0;
            k = randi(par.nodes(ni));
            while k==i || col(k)==1
                k = randi(par.nodes(ni));
            end
            col(k) = 1;
        end
    end
    A(:,i) = col;
end

% A is not yet symmetric: to speed things up, an edge connecting i and j, i < j
% implies A(i,j)==1, A(i,j) might be zero.
T = triu(A);
A = T+T';

%write the generated subnetwork at its position in the empty sparse matrix
S( s(ni):par.nodes(ni)+s(ni)-1, s(ni):par.nodes(ni)+s(ni)-1 ) = A;
end

%connect subnetworks with a specified number of connections
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

    
%export the network as a .csv file     
csvwrite('SW.csv', full(S));

end % small_world(...)
