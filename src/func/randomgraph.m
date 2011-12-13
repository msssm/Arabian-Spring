%% --------------------------------*- Matlab -*---------------------------------
% Filename: smallworld.m
% Created: Thu Nov 10 21:29:23 2011 (+0100)
% Version: 
% Last-Updated: Wed Nov 23 16:58:06 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 10
% -----------------------------------------------------------------------------
% randomgraph.m starts here
% -----------------------------------------------------------------------------
%

function S = randomgraph(par)
%uses the function written by Stefan Brugger and Christoph Schwirzer to
%create a random network
%
%in our example the function is called three times to create a cluster of
%three random graphs
%
% INPUT
% n: [1]: number of nodes of the graph to be generated
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
    
for ni = 1:length(par.nodes)

% call random graph function
A=random_graph(par.nodes(ni), par.alpha(ni));

%write the generated subnetwork at its position
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
csvwrite('random.csv', full(S));

end % randomgraph

% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors: Stefan Brugger and Cristoph Schwirzer, 2011

function A = random_graph(n, p)
% Generates an undirected random graph (without self-loops) of size n (as
% described in the Erdoes-Renyi model)
%
% INPUT
% n: [1]: number of nodes
% p: [1]: probability that node i and node j, i != j, are connected by an edge
%
% OUTPUT
% A: [n n] sparse symmetric adjacency matrix representing the generated graph

% Note: A generation based on sprandsym(n, p) failed (for some values of p
% sprandsym was far off from the expected number of n*n*p non-zeros), therefore
% this longish implementation instead of just doing the following:
%
%    B = sprandsym(n, p);
%    A = (B-diag(diag(B))~=0);
%

% Idea: first generate the number of non-zero values in every row for a general
% 0-1-adjacency matrix. For every row this number is distributed binomially with
% parameters n and p.
%
% The following lines calculate "rowsize = binoinv(rand(1, n), n, p)", just in a
% faster way for large values of n.

% generate a vector of n values chosen u.a.r. from (0,1)
v = rand(1, n);
% Sort them and calculate the binomial cumulative distribution function with
% parameters n and p at values 0 to n. Afterwards match the sorted random
% 0-1-values to those cdf-values, i.e. associate a binomial distributed value
% with each value in r. Each value in v also corresponds to a value in r:
% permute the values in rowSize s.t. they correspond to the order given in v. 
[r index] = sort(v); % i.e. v(index) == r holds
rowSize = zeros(1, n);
j = 0;
binoCDF = cumsum(binopdf(0:n, n, p));
for i = 1:n
    while j<n && binoCDF(j+1)<r(i)
        j = j + 1;
    end
    rowSize(i) = j;
end
rowSize(index) = rowSize;

% for every row choose the non-zero entries in it
nNZ = sum(rowSize);
I = zeros(1, nNZ);
J = zeros(1, nNZ);
j = 1;
for i = 1:n
    I(j:j+rowSize(i)-1) = i;
    J(j:j+rowSize(i)-1) = randsample(n, rowSize(i));
    j = j + rowSize(i);
end

% restrict I and J to indices that correspond to entries above the main diagonal
% and finally construct a symmetric sparse matrix using I and J
upperTriu = find(I<J);
I = I(upperTriu);
J = J(upperTriu);
A = sparse([I;J], [J;I], ones(1, 2*size(I, 2)), n, n);

end % random_graph(...)
