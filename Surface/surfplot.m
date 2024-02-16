function surfplot( path4surf, surface_data, seeback, edgealpha, docamlight, view_vec )
% SURFPLOT
%--------------------------------------------------------------------------
% ARGUMENTS
% Mandatory
% Optional
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% See test_surfplot.m
%--------------------------------------------------------------------------
% Copyright (C) - 2023 - Samuel Davenport
%--------------------------------------------------------------------------

%%  Check mandatory input and get important constants
%--------------------------------------------------------------------------

%%  Add/check optional values
%--------------------------------------------------------------------------
if ~exist( 'seeback', 'var' )
   % Default value
   seeback = 0;
end

if ~exist( 'view_vec', 'var' )
   % Default value
   if seeback == 0
       view_vec = [-89, 16];
   else
       view_vec = [89,-16];
   end
end

if ~exist( 'edgealpha', 'var' )
   % Default value
   edgealpha = 0.05;
end

if ~exist( 'surface_data', 'var' )
   % Default value
   surface_data = [];
end

if ~exist( 'docamlight', 'var' )
   % Default value
   docamlight = 1;
end

%%  Main Function Loop
%--------------------------------------------------------------------------
if isstruct(path4surf)
    g = path4surf;
    if isfield(g, 'data')
        surface_data = g.data;
    end
else
    if strcmp(path4surf(end-3:end), '.gii')
        if ~exist('gifti', 'file')
            error('You need to install the gifti matlab package, available here: https://github.com/gllmflndn/gifti in order to read gifti surface files. Once installed you must make sure its contents are available on the matlab path.')
        end
        g = gifti(path4surf);
    else
        [vertices, faces] = read_fs_geometry(path4surf);
        g.vertices = vertices;
        g.faces = faces;
    end
end

if isempty(surface_data)
   % Default value
   use_surface_data = 0;
   warning('surface_data not included - plotting the empty mesh')
else
   use_surface_data = 1;
   surface_data = double(surface_data);
end


vertices = double(g.vertices);
X = vertices(:,1);
Y = vertices(:,2);
Z = vertices(:,3);
if use_surface_data == 1
    if docamlight
        ptru = trisurf(double(g.faces), X, Y, Z, ...
            'FaceVertexCData', surface_data, 'EdgeAlpha', edgealpha);
    else
        ptru = trisurf(double(g.faces), X, Y, Z,'FaceColor', 'interp', ...
            'FaceVertexCData', surface_data, 'EdgeAlpha', edgealpha);
    end
else
    ptru = trisurf(double(g.faces), X, Y, Z,'FaceColor', 'None', 'EdgeAlpha', edgealpha);
end
xlim([min(X)-1, max(X)+1])
ylim([min(Y)-1, max(Y)+1])
zlim([min(Z)-1, max(Z)+1])
axis off

view(view_vec)

if docamlight
    lighting gouraud;
    material dull;
    shading flat;
%     camlight('headlight')
%     camlight('headlight')
    camlight('headlight')
% %     camlight('right')
%     light
end
set(ptru,'AmbientStrength',0.5)
axis image
screen_size = get(0, 'ScreenSize');

% Set the figure position to cover the entire screen
set(gcf, 'Position', screen_size);
% fullscreen
end

