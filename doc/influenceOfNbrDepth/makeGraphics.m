% --------------------------------*- Matlab -*---------------------------------
% Filename: makeGraphics.m
% Description: 
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Wed Dec 14 14:18:12 2011 (+0100)
% Version: 
% Last-Updated: Wed Dec 14 16:35:08 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 27
% -----------------------------------------------------------------------------
% makeGraphics.m starts here
% -----------------------------------------------------------------------------
clear('all');
set( 0, 'defaultTextInterpreter', 'none' )

load( 'nbrDepth1.mat' );
resData{1} = res;

load( 'nbrDepth2.mat' );
resData{2} = res;

load( 'nbrDepth1_random.mat' );
resData{3} = res;

load( 'nbrDepth2_random.mat' );
resData{4} = res;

fig(1) = figure;
ax(1) = axes;
fig(2) = figure;
ax(2) = axes;
hold( ax(1), 'on' );
hold( ax(2), 'on' );

lineStyle = { '-k' '--k' };
legendStr = { 'Small World' 'Random' };

% -----------------------------------------------------------------------------
% fig1
h(1) = plot( ax(1), resData{1}(:,4), lineStyle{1} );
h(2) = plot( ax(1), resData{3}(:,4), lineStyle{2} );

xlabel( ax(1), 'Number of Iterations' )
ylabel( ax(1), 'Global Residual' )
legend( h, legendStr, 'location', 'se', 'FontSize', 14 );
title( ax(1), 'nbrDepth = 1' );
set( ax(1), 'YLim', [0 1] );
grid( ax(1), 'on' );

% -----------------------------------------------------------------------------
% fig2
h(1) = plot( ax(2), resData{2}(:,4), lineStyle{1} );
h(2) = plot( ax(2), resData{4}(:,4), lineStyle{2} );

xlabel( ax(2), 'Number of Iterations' )
ylabel( ax(2), 'Global Residual' )
legend( h, legendStr, 'location', 'se', 'FontSize', 14 );
title( ax(2), 'nbrDepth = 2' );
set( ax(2), 'YLim', [0 1] );
grid( ax(2), 'on' );

% -----------------------------------------------------------------------------
% print
for i = 1:length( fig )
    legend( ax(i), 'boxoff' )
    laprint( fig(i), ['nbrDepth' num2str(i)], 'textwidth', 0.46 );
end

close( 'all' );

% -----------------------------------------------------------------------------
% makeGraphics.m ends here
% -----------------------------------------------------------------------------
