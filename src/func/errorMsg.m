% --------------------------------*- Matlab -*---------------------------------
% Filename: errorMsg.m
% Description: This function can be used to generate error messages, which
%              can then be used with the error() function.  Useful for error
%              handling.
% Author: Fabian Wermelinger
% Email: fabianw@student.ethz.ch
% Created: Sat Nov 12 16:47:45 2011 (+0100)
% Version: 
% Last-Updated: Sat Nov 12 18:13:56 2011 (+0100)
%           By: Fabian Wermelinger
%     Update #: 2
% -----------------------------------------------------------------------------
% errorMsg.m starts here
% -----------------------------------------------------------------------------
function err = errorMsg( ID, stack )
% create error message structure for use with the error( err ) function.
    switch ( lower(stack.name) )
      case ( 'solversir' ) % errors associated with the solverSIR.m function
        switch ( lower(ID) )
          case ( 'wrongnumberofnodes' )
            err.message = ['number of global nodes does not match the ' ...
                           'length of the agent list'];
            err.identifier = [stack.name ':agentList'];
            err.stack = stack;
        end
        
    end

% -----------------------------------------------------------------------------
% errorMsg.m ends here
% -----------------------------------------------------------------------------
