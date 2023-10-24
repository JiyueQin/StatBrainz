function squarescreen
% fullscreen makes the plot fullscreen
%--------------------------------------------------------------------------
% ARGUMENTS
% Mandatory
% Optional
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Samuel Davenport
%--------------------------------------------------------------------------

%%  Check mandatory input and get important constants
%--------------------------------------------------------------------------

%%  Add/check optional values
%--------------------------------------------------------------------------
if ~exist( 'opt1', 'var' )
   % Default value
   opt1 = 0;
end

%%  Main Function Loop
%--------------------------------------------------------------------------
% set(gcf, 'position', [0,0,1500,642])
set(gcf, 'position', [0,35,650,607])
end

