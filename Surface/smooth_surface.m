function surface = smooth_surface( surface, FWHM, data )
% smooth_surface( surface, FWHM, data ) smoothes data on the surface using
% nearest neighbour smoothing which corresponds to the FWHM.
%--------------------------------------------------------------------------
% ARGUMENTS
% Mandatory
%  surface  a
%  FWHM     the FWHM with which to smooth
% Optional
%  data
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
lhrh = 0;
if ~isstruct(surface)
    g = gifti(surface);
    clear surface
    surface.faces = g.faces;
    surface.vertices = g.vertices;
    surface.data = data;
else
    if isfield(surface, 'lh')
        surface.lh = smooth_surface(surface.lh, FWHM);
        lhrh = 1;
    end
    if isfield(surface, 'rh')
        surface.rh = smooth_surface(surface.rh, FWHM);
        lhrh = 1;
    end
end


if lhrh == 0
    if ~isfield(surface, 'data') && (nargin == 3)
        surface.data = data;
    end
    surface.data = SurfStatSmooth( surface.data', surface, FWHM )';
end

end

