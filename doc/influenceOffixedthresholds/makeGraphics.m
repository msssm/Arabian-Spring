% --------------------------------*- Matlab -*---------------------------------
% Filename: makeGraphics.m
% Description: 
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Wed Dec 14 14:18:12 2011 (+0100)
% Version: 
% Last-Updated: Wed Dec 14 15:36:37 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 16
% -----------------------------------------------------------------------------
% makeGraphics.m starts here
% -----------------------------------------------------------------------------
clear('all');
set( 0, 'defaultTextInterpreter', 'none' )

load( 'fixedthreshold=0.0.mat' );
resData{1} = res;

load( 'fixedthreshold=0.2.mat' );
resData{2} = res;

load( 'fixedthreshold=0.4.mat' );
resData{3} = res;

load( 'fixedthreshold=0.6.mat' ); 
resData{4} = res; 

fig(1) = figure;
ax(1) = axes;
fig(2) = figure;
ax(2) = axes;
hold( ax(1), 'on' );
hold( ax(2), 'on' );

lineStyle = { '-k' '--k' '-.k' ':k' };
legendStr = { '$ 0\;\%$' '$80\;\%$' '$60\;\%$' '$40\;\%$' };

% -----------------------------------------------------------------------------
% fig1
for i = 1:length(resData)
    h(i) = plot( ax(1), resData{i}(:,1), lineStyle{i} );
end
xlabel( ax(1), 'Number of Iterations' )
ylabel( ax(1), 'Residual' )
legend( h, legendStr, 'location', 'se', 'FontSize', 12 );
title( ax(1), 'Custer 1' );
set( ax(1), 'YLim', [0 1] );
grid( ax(1), 'off' );

% -----------------------------------------------------------------------------
% fig2

for i = 1:length( resData )
    h(i) = plot( ax(2), resData{i}(:,4), lineStyle{i} );
end
xlabel( ax(2), 'Number of Iterations' )
ylabel( ax(2), 'Residual' )
legend( h, legendStr, 'location', 'e', 'FontSize', 12 );
title( ax(2), 'Global' );
set( ax(2), 'YLim', [0 1] );
grid( ax(2), 'on' );

% -----------------------------------------------------------------------------
% print
for i = 1:2
    legend( ax(i), 'boxoff' )
    laprint( fig(i), ['fixedthreshold' num2str(i)], 'textwidth', 0.46 );
end

close( 'all' );

% -----------------------------------------------------------------------------
% makeGraphics.m ends here
% -----------------------------------------------------------------------------
