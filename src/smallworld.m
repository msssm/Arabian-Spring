%
% Network
%   Each network is an assembly of N nodes generated with independent
%   functions. The output of these functions must be a sparse matrix S. See
%   the MATLAB help for the sparse() function in order to generate sparse
%   matrices in MATLAB.
%
% INPUTS:
%   n = # of nodes
%   k = (mean degree)/2
%   p = probability to rewire
%
%   with n > 2k > ln(n) > 1 
%
% OUTPUT:
%   A = sparse matrix representing the small world network

function S = smallworld(n, k, p)

% construct regular lattice with n nodes which have in total k neighbors
row = reshape(repmat([1:n]' , 1, 2*k), 2*n*k, 1);
col = reshape(repmat([[1:k] [n-k:n-1]], n, 1), 2*n*k, 1);
B = sparse(row, col, ones(2*n*k,1));

% rewire nodes with probabilitz p
for i = [1:n]
    B(i, mod(i+k,n)+1)=1
end

for i=1:n
    for j=i+1:n
        if(B(i,j)==1 && rand()<p)
            B(i,j)=0;
            a=floor(rand()*n)+1;
            if(i<a)
                B(i,a)=1;
            else
                B(a,i)=1;
            end
        end
    end
end

S = sparse(B);

end
