% --------------------------------*- Matlab -*---------------------------------
% Filename: makeGraphics.m
% Description: 
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Wed Dec 14 14:18:12 2011 (+0100)
% Version: 
% Last-Updated: Wed Dec 14 15:00:47 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 14
% -----------------------------------------------------------------------------
% makeGraphics.m starts here
% -----------------------------------------------------------------------------
clear('all');
set( 0, 'defaultTextInterpreter', 'none' )

load( 'maxUpdate002.mat' );
resData{1} = res;

load( 'maxUpdate004.mat' );
resData{2} = res;

load( 'maxUpdate008.mat' );
resData{3} = res;

fig(1) = figure;
ax(1) = axes;
fig(2) = figure;
ax(2) = axes;
hold( ax(1), 'on' );
hold( ax(2), 'on' );

lineStyle = { '-k' '--k' '-.k' };
legendStr = { '$2\;\%$' '$4\;\%$' '$8\;\%$' };

% -----------------------------------------------------------------------------
% fig1
for i = 1:length( resData )
    h(i) = plot( ax(1), resData{i}(:,1), lineStyle{i} );
end
xlabel( ax(1), 'Number of Iterations' )
ylabel( ax(1), 'Residual' )
legend( h, legendStr, 'location', 'se' );
title( ax(1), 'Cluster 1' );
set( ax(1), 'YLim', [0 1] );
grid( ax(1), 'on' );

% -----------------------------------------------------------------------------
% fig2
for i = 1:length( resData )
    h(i) = plot( ax(2), resData{i}(:,4), lineStyle{i} );
end
xlabel( ax(2), 'Number of Iterations' )
ylabel( ax(2), 'Residual' )
legend( h, legendStr, 'location', 'se' );
title( ax(2), 'Global' );
set( ax(2), 'YLim', [0 1] );
grid( ax(2), 'on' );

% -----------------------------------------------------------------------------
% print
for i = 1:length( fig )
    laprint( fig(i), ['maxUpdate' num2str(i)], 'textwidth', 0.46 );
end

close( 'all' );

% -----------------------------------------------------------------------------
% makeGraphics.m ends here
% -----------------------------------------------------------------------------
